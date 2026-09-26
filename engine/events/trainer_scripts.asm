TalkToTrainerScript::
	faceplayer
	trainerflagaction CHECK_FLAG
	iftrue RematchScript
	loadtemptrainer
	encountermusic
	sjump StartBattleWithMapTrainerScript

SeenByTrainerScript::
	loadtemptrainer
	encountermusic
	showemote EMOTE_SHOCK, LAST_TALKED, 30
	callasm TrainerWalkToPlayer
	applymovementlasttalked wMovementBuffer
	writeobjectxy LAST_TALKED
	faceobject PLAYER, LAST_TALKED
	; fallthrough

StartBattleWithMapTrainerScript:
	opentext
RematchStartBattleWithMapTrainerScript:
	trainertext TRAINERTEXT_SEEN
	waitbutton
	closetext
	loadtemptrainer
	startbattle
	reloadmapafterbattle
	trainerflagaction SET_FLAG
	loadmem wRunningTrainerBattleScript, -1
	; fallthrough

AlreadyBeatenTrainerScript:
	scripttalkafter

RematchScript:
	scall AlreadyBeatenTrainerScript
	readmem wNoRematch
	iftrue .NoRematch
	writetext AskForARematchText
; The "Rematch Prompt" option only decides which of the two commands
; asks the question; both return carry when the player says no.
	callasm RematchPromptOrder
	iftrue .NoYesOrder
	yesorno
	sjump .GotChoice
.NoYesOrder:
	nooryes
.GotChoice:
	iffalse .refused
    loadtemptrainer
	encountermusic
	sjump RematchStartBattleWithMapTrainerScript

.refused:
	closetext
	end

.NoRematch:
	loadmem wNoRematch, 0
	closetext
	end

AskForARematchText:
	text "Up for a rematch?"
	done

RematchPromptOrder:
; Sets wScriptVar to TRUE when "Rematch Prompt" is "NoOrYes" and FALSE
; when it is the "YesOrNo" default, so the iftrue picks the command.
	ld a, [wTextboxFlags]
	bit REMATCH_NOYES_F, a
	ld a, FALSE
	jr z, .store
	inc a
.store
	ld [wScriptVar], a
	ret
