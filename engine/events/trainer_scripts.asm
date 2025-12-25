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
	opentext
	writetext AskForARematchText
	yesorno
	iffalse .refused
    loadtemptrainer
	encountermusic
	sjump StartBattleWithMapTrainerScript

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
