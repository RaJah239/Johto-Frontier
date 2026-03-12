NurseJoyTrainingAcademy_MapEvents:
	def_warp_events
	warp_event  4,  9, ROUTE_21, 5
	warp_event  5,  9, ROUTE_21, 5

	def_coord_events

	def_bg_events

	def_object_events
	porygonpc_event  8,  1, PAL_NPC_RED
	object_event  4,  1, SPRITE_NURSE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, NurseJoyTrainingNurseJoyScript, -1
	object_event  9,  4, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, NurseJoyTraininCooltrainerMText, -1
	object_event  1,  4, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, NurseJoyTraininCooltrainerFText, -1
	object_event  5,  1, SPRITE_BLISSEY, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, NurseJoyTrainingBlisseyScript, -1

	object_const_def
	const NURSEJOYTRAINING_PORYGON_PC
	const NURSEJOYTRAINING_COOLTRAINER_M
	const NURSEJOYTRAINING_COOLTRAINER_F
	const NURSEJOYTRAINING_NURSE_JOY
	const NURSEJOYTRAINING_BLISSEY

NurseJoyTrainingAcademy_MapScripts:
	def_scene_scripts

	def_callbacks

NurseJoyTrainingNurseJoyScript:
	faceplayeropentext
	checkevent EVENT_MET_NURSE_JOY
	iftrue .TakeOnJoysChallenge
	writethistext
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
	setevent EVENT_MET_NURSE_JOY
	yesorno
	iffalse_endtext
	sjump .FirstTimeChallenge

.TakeOnJoysChallenge
	writethistext
		text "Ready for some"
		line "training?"
		done
	yesorno
	iffalse_endtext
.FirstTimeChallenge
	special HealParty
	special BackupPartyHeldItems
	special SaveMusic
	writethistext
		text "Choose a team of"
		line "mine to battle."
		done
	winlosstext NurseJoyBeatenText, 0
	loadmenu .NurseJoysTeamSelectorMenuHeader
	_2dmenu
	closewindow
	ifequal 1, .level10
	ifequal 2, .level20
	ifequal 3, .level30
	ifequal 4, .level40
	ifequal 5, .level50
	endtext

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
	showthistext
		text "Keep coming back."
		line "I'm here for you!"
		done
	special HealParty
	special RestorePartyHeldItems
	special RestoreMusic
	end

.lose
    special HealParty
    reloadmap
    jumpthistext
		text "Aww… You'll get"
		line "me next time…"
		done

.NurseJoysTeamSelectorMenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 3, 2, 16, 10
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR | STATICMENU_WRAP ; flags
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

NurseJoyBeatenText:
	text "Good job trainer!"
	done

NurseJoyTraininCooltrainerMText:
	text "These battles are"
	line "tough!"

	para "I'm taking a break."
	done

NurseJoyTraininCooltrainerFText:
	text "This academy is"
	line "great. It's too"
	cont "bad we can't earn"
	cont "money here but the"
	cont "good news is that"
	cont "we don't loose"
	cont "money either."
	done

NurseJoyTrainingBlisseyScript:
	setval BLISSEY
	special SetMonAsSeen
	isfieldactionssettoquick
	iftrue .skipthis
	reanchormap
	pokepic BLISSEY
	cry BLISSEY
	waitbutton
	closepokepic
.skipthis
	jumpthistext
		text "Blissey: Seyyyy!"
		done
