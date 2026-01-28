	object_const_def
	const NURSEJOYTRAINING_BLISSEY
	const NURSEJOYTRAINING_PORYGON_PC
	const NURSEJOYTRAINING_COOLTRAINER_M
	const NURSEJOYTRAINING_COOLTRAINER_F
	const NURSEJOYTRAINING_NURSE_JOY

NurseJoyTrainingAcademy_MapScripts:
	def_scene_scripts

	def_callbacks

NurseJoyTrainingBlisseyScript:
	faceplayer
	reanchormap
	pokepic BLISSEY
	cry BLISSEY
	waitsfx
	closepokepic
	refreshmap
	opentext
	writetext BlisseyCryText
	pause 20
	closetext
	end

BlisseyCryText:
	text "Blissey: Seyyyy!"
	done

NurseJoyTrainingPorygonPCScript:
	jumpstd PorygonPCScript

NurseJoyTrainingCooltrainerMScript:
	jumptextfaceplayer NurseJoyTraininCooltrainerMText

NurseJoyTraininCooltrainerMText:
	text "These battles are"
	line "tough!"

	para "I'm taking a break."
	done

NurseJoyTrainingCooltrainerFScript:
	jumptextfaceplayer NurseJoyTraininCooltrainerFText

NurseJoyTraininCooltrainerFText:
	text "This academy is"
	line "great. It's too"

	para "bad we can't earn"
	line "money here but the"

	para "good news is that"
	line "we don't loose"
	cont "money either."
	done

NurseJoyTrainingNurseJoyScript:
	faceplayer
	opentext
	checkevent EVENT_MET_NURSE_JOY
	iftrue .TakeOnJoysChallenge
	writetext NurseJoyMeetFirstTimeText
	setevent EVENT_MET_NURSE_JOY
	yesorno
	iffalse .done1
	sjump .FirstTimeChallenge
.done1
	closetext
	end

.TakeOnJoysChallenge
	writetext NurseJoysReadyForAChallengeText
	yesorno
	iffalse .done2
.FirstTimeChallenge
	special HealParty
	special BackupPartyHeldItems
	special SaveMusic
	writetext NurseJoysTrainingChallengeText
	winlosstext NurseJoyBeatenText, 0
	sjump .NurseJoysTeamSelector
.done2
	closetext
	end

.NurseJoysTeamSelector
	loadmenu .NurseJoysTeamSelectorMenuHeader
	_2dmenu
	closewindow
	ifequal 1, .level10
	ifequal 2, .level20
	ifequal 3, .level30
	ifequal 4, .level40
	ifequal 5, .level50
	closetext
	end

.level10:
	loadtrainer NURSE, NURSE1
	sjump .continue_battle

.level20:
	loadtrainer NURSE, NURSE2
	sjump .continue_battle

.level30:
	loadtrainer NURSE, NURSE3
	sjump .continue_battle

.level40:
	loadtrainer NURSE, NURSE4
	sjump .continue_battle

.level50:
	loadtrainer NURSE, NURSE5
.continue_battle
	startbattle
	ifequal LOSE, .lose
	reloadmapafterbattle
	opentext
	writetext NurseJoyAfterBattleText
	waitbutton
	closetext
	special HealParty
	special RestorePartyHeldItems
	special RestoreMusic
	end

.lose
    special HealParty
    reloadmap
    opentext
    writetext NurseJoyWinAfterBattleText
    waitbutton
    closetext
    end

.NurseJoysTeamSelectorMenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 3, 2, 16, 10
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR ; flags
	dn 3, 2 ; rows, columns
	db 6 ; spacing
	dba .Text
	dbw BANK(@), NULL

.Text:
	db "Lv10@"
	db "Lv20@"
	db "Lv30@"
	db "Lv40@"
	db "Lv50@"
	db "Quit@"

NurseJoyMeetFirstTimeText:
	text "Good day to you"
	line "and welcome to my"
	cont "training camp."

	para "You may battle ag-"
	line "ainst my team of"
	cont "Blisseys to your"
	cont "heart's content."
	
	para "They're great for"
	line "experience!"

	para "Your #mon are"
	line "healed before and"
	cont "after our bouts,"
	cont "in addition to no"
	cont "whiteouts!"
	
	para "Select one of my"
	line "parties and start."

	para "How about it?"
	done

NurseJoysReadyForAChallengeText:
	text "Ready for some"
	line "training?"
	done

NurseJoysTrainingChallengeText:
	text "Choose a team of"
	line "mine to battle."
	done

NurseJoyBeatenText:
	text "Good job trainer!"
	done

NurseJoyAfterBattleText:
	text "Keep coming back."
	line "I'm here for you!"
	done

NurseJoyWinAfterBattleText:
	text "Aww… You'll get"
	line "me next time…"
	done

NurseJoyTrainingAcademy_MapEvents:
	def_warp_events
	warp_event  4,  9, ROUTE_23, 5
	warp_event  5,  9, ROUTE_23, 5

	def_coord_events

	def_bg_events

	def_object_events
	object_event  5,  1, SPRITE_BLISSEY, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, NurseJoyTrainingBlisseyScript, -1
	object_event  8,  1, SPRITE_PORYGON_OW, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, NurseJoyTrainingPorygonPCScript, -1
	object_event  9,  4, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, NurseJoyTrainingCooltrainerMScript, -1
	object_event  1,  4, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, NurseJoyTrainingCooltrainerFScript, -1
	object_event  4,  1, SPRITE_NURSE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, NurseJoyTrainingNurseJoyScript, -1
