	object_const_def
	const NEWBARKTOWN_TEACHER
	const NEWBARKTOWN_CHEATER_KUN
	const NEWBARKTOWN_RIVAL

NewBarkTown_MapScripts:
	def_scene_scripts
	scene_script NewBarkTownNoop1Scene, SCENE_NEWBARKTOWN_TEACHER_STOPS_YOU
	scene_script NewBarkTownNoop2Scene, SCENE_NEWBARKTOWN_NOOP

	def_callbacks
	callback MAPCALLBACK_NEWMAP, NewBarkTownFlypointCallback

NewBarkTownNoop1Scene:
	end

NewBarkTownNoop2Scene:
	end

NewBarkTownFlypointCallback:
	setflag ENGINE_FLYPOINT_NEW_BARK
	clearevent EVENT_FIRST_TIME_BANKING_WITH_MOM
	endcallback

NewBarkTown_TeacherStopsYouScene1:
	playmusic MUSIC_MOM
	turnobject NEWBARKTOWN_TEACHER, LEFT
	opentext
	writetext Text_WaitPlayer
	waitbutton
	closetext
	turnobject PLAYER, RIGHT
	applymovement NEWBARKTOWN_TEACHER, NewBarkTown_TeacherRunsToYouMovement1
	opentext
	writetext Text_WhatDoYouThinkYoureDoing
	waitbutton
	closetext
	follow NEWBARKTOWN_TEACHER, PLAYER
	applymovement NEWBARKTOWN_TEACHER, NewBarkTown_TeacherBringsYouBackMovement1
	stopfollow
	opentext
	writetext Text_ItsDangerousToGoAlone
	waitbutton
	closetext
	special RestartMapMusic
	end

NewBarkTown_TeacherStopsYouScene2:
	playmusic MUSIC_MOM
	turnobject NEWBARKTOWN_TEACHER, LEFT
	opentext
	writetext Text_WaitPlayer
	waitbutton
	closetext
	turnobject PLAYER, RIGHT
	applymovement NEWBARKTOWN_TEACHER, NewBarkTown_TeacherRunsToYouMovement2
	turnobject PLAYER, UP
	opentext
	writetext Text_WhatDoYouThinkYoureDoing
	waitbutton
	closetext
	follow NEWBARKTOWN_TEACHER, PLAYER
	applymovement NEWBARKTOWN_TEACHER, NewBarkTown_TeacherBringsYouBackMovement2
	stopfollow
	opentext
	writetext Text_ItsDangerousToGoAlone
	waitbutton
	closetext
	special RestartMapMusic
	end

NewBarkTownTeacherScript:
	faceplayer
	opentext
	checkevent EVENT_TALKED_TO_MOM_AFTER_MYSTERY_EGG_QUEST
	iftrue .CallMom
	checkevent EVENT_GAVE_MYSTERY_EGG_TO_ELM
	iftrue .TellMomYoureLeaving
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iftrue .MonIsAdorable
	writetext Text_GearIsImpressive
	waitbutton
	closetext
	end

.MonIsAdorable:
	writetext Text_YourMonIsAdorable
	waitbutton
	closetext
	end

.TellMomYoureLeaving:
	writetext Text_TellMomIfLeaving
	waitbutton
	closetext
	end

.CallMom:
	writetext Text_CallMomOnGear
	waitbutton
	closetext
	end

NewBarkTownRivalScript:
	opentext
	writetext NewBarkTownRivalText1
	waitbutton
	closetext
	turnobject NEWBARKTOWN_RIVAL, LEFT
	opentext
	writetext NewBarkTownRivalText2
	waitbutton
	closetext
	follow PLAYER, NEWBARKTOWN_RIVAL
	applymovement PLAYER, NewBarkTown_RivalPushesYouAwayMovement
	stopfollow
	pause 5
	turnobject NEWBARKTOWN_RIVAL, DOWN
	pause 5
	playsound SFX_TACKLE
	applymovement PLAYER, NewBarkTown_RivalShovesYouOutMovement
	applymovement NEWBARKTOWN_RIVAL, NewBarkTown_RivalReturnsToTheShadowsMovement
	end

NewBarkTownSign:
	jumptext NewBarkTownSignText

NewBarkTownPlayersHouseSign:
	jumptext NewBarkTownPlayersHouseSignText

NewBarkTownElmsLabSign:
	jumptext NewBarkTownElmsLabSignText

NewBarkTownElmsHouseSign:
	jumptext NewBarkTownElmsHouseSignText

NewBarkTown_TeacherRunsToYouMovement1:
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step_end

NewBarkTown_TeacherRunsToYouMovement2:
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	turn_head DOWN
	step_end

NewBarkTown_TeacherBringsYouBackMovement1:
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	turn_head LEFT
	step_end

NewBarkTown_TeacherBringsYouBackMovement2:
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	turn_head LEFT
	step_end

NewBarkTown_RivalPushesYouAwayMovement:
	turn_head UP
	step DOWN
	step_end

NewBarkTown_RivalShovesYouOutMovement:
	turn_head UP
	fix_facing
	jump_step DOWN
	remove_fixed_facing
	step_end

NewBarkTown_RivalReturnsToTheShadowsMovement:
	step RIGHT
	step_end

Text_GearIsImpressive:
	text "Wow, your #GEAR"
	line "is impressive!"

	para "Did your mom get"
	line "it for you?"
	done

Text_WaitPlayer:
	text "Wait, <PLAY_G>!"
	done

Text_WhatDoYouThinkYoureDoing:
	text "What do you think"
	line "you're doing?"
	done

Text_ItsDangerousToGoAlone:
	text "It's dangerous to"
	line "go out without a"
	cont "#MON!"

	para "Wild #MON"
	line "jump out of the"

	para "grass on the way"
	line "to the next town."
	done

Text_YourMonIsAdorable:
	text "Oh! Your #MON"
	line "is adorable!"
	cont "I wish I had one!"
	done

Text_TellMomIfLeaving:
	text "Hi, <PLAY_G>!"
	line "Leaving again?"

	para "You should tell"
	line "your mom if you"
	cont "are leaving."
	done

Text_CallMomOnGear:
	text "Call your mom on"
	line "your #GEAR to"

	para "let her know how"
	line "you're doing."
	done

NewBarkTownRivalText1:
	text "<……>"

	para "So this is the"
	line "famous ELM #MON"
	cont "LAB…"
	done

NewBarkTownRivalText2:
	text "…What are you"
	line "staring at?"
	done

NewBarkTownSignText:
	text "NEW BARK TOWN"

	para "The Town Where the"
	line "Winds of a New"
	cont "Beginning Blow"
	done

NewBarkTownPlayersHouseSignText:
	text "<PLAYER>'s House"
	done

NewBarkTownElmsLabSignText:
	text "ELM #MON LAB"
	done

NewBarkTownElmsHouseSignText:
	text "ELM'S HOUSE"
	done

CheatingScript:
	faceplayer
	opentext
	checkevent EVENT_CHEAT_MENU_ACCESSIBLE
	iftrue .Start
	writetext CheatingIntroText
	setevent EVENT_CHEAT_MENU_ACCESSIBLE
	yesorno
	iffalse .ExitGameQuestionMark
.Start:
	writetext ReadyForSomeCheatingAreWeText
	promptbutton
	loadmenu .MenuHeader
	verticalmenu
	closewindow
	ifequal 1, .MaxRareCandy
	ifequal 2, .MaxHyperEvUp
	ifequal 3, .MaxMasterBall
	ifequal 4, .MaxCrystal
	writetext SwingByAnytimeText
	waitbutton
	closetext
	end

.MenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 0, 0, SCREEN_WIDTH - 1, TEXTBOX_Y
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR ; flags
	db 5 ; items
	db "99× Rare Candy@"
	db "99× Hyper EV Up@"
	db "99× Master Ball@"
	db "99× Crystal@"
	db "Cancel@"

.ExitGameQuestionMark:
	writetext AreYouReallySureText
	yesorno
	iffalse .Start
	closetext
	playsound SFX_WARP_TO
	applymovement NEWBARKTOWN_CHEATER_KUN, NewbarkTownCheaterKunTeleportAway
	disappear NEWBARKTOWN_CHEATER_KUN
	end

.MaxRareCandy:
	giveitem RARE_CANDY, 99
	iffalse .NotEnoughSpace
	getitemname STRING_BUFFER_3, RARE_CANDY
	sjump .EndCheatingScript

.MaxHyperEvUp:
	giveitem HYPER_EV_UP, 99
	iffalse .NotEnoughSpace
	getitemname STRING_BUFFER_3, HYPER_EV_UP
	sjump .EndCheatingScript

.MaxMasterBall:
	giveitem MASTER_BALL, 99
	iffalse .NotEnoughSpace
	getitemname STRING_BUFFER_3, MASTER_BALL
	sjump .EndCheatingScript

.MaxCrystal:
	giveitem CRYSTAL, 99
	iffalse .NotEnoughSpace
	getitemname STRING_BUFFER_3, CRYSTAL
	sjump .EndCheatingScript

.NotEnoughSpace:
	writetext NoSpaceText
	waitbutton
	closetext
	end

.EndCheatingScript:
	writetext ReceivedCheatedItemText
	playsound SFX_ITEM
	waitsfx
	closetext
	end

ReceivedCheatedItemText:
	text "<PLAYER> got"
	line "99× @"
	text_ram wStringBuffer3
	text "."
	done

CheatingIntroText:
	text "Salutations"
	line "<PLAYER>!"

	para "I'm your access to"
	line "the cheat menu."

	para "Right here, right"
	line "now, decide:"

	para "Have me exist or"
	line "let me exit your"
	cont "game permanently."

	para "Stay?"
	done

AreYouReallySureText:
	text "Are you certain"
	line "you want me gone?"
	done

ReadyForSomeCheatingAreWeText:
	text "Ready for some"
	line "cheating are we?"
	done

SwingByAnytimeText:
	text "Swing by anytime!"
	line "I'll always be"

	para "here for you and"
	line "your misdeeds!"
	done

NoSpaceText:
	text "There's no more"
	line "room in your bag…"
	done

NewbarkTownCheaterKunTeleportAway:
	teleport_from
	step_end

NewBarkTown_MapEvents:
	def_warp_events
	warp_event 13,  5, PLAYERS_HOUSE_1F, 1
	warp_event  6,  3, ELMS_LAB, 1
	warp_event  3, 11, PLAYERS_NEIGHBORS_HOUSE, 1
	warp_event 11, 13, ELMS_HOUSE, 1

	def_coord_events
	coord_event  1,  8, SCENE_NEWBARKTOWN_TEACHER_STOPS_YOU, NewBarkTown_TeacherStopsYouScene1
	coord_event  1,  9, SCENE_NEWBARKTOWN_TEACHER_STOPS_YOU, NewBarkTown_TeacherStopsYouScene2

	def_bg_events
	bg_event  8,  8, BGEVENT_READ, NewBarkTownSign
	bg_event 11,  5, BGEVENT_READ, NewBarkTownPlayersHouseSign
	bg_event  3,  3, BGEVENT_READ, NewBarkTownElmsLabSign
	bg_event  9, 13, BGEVENT_READ, NewBarkTownElmsHouseSign

	def_object_events
	object_event  6,  8, SPRITE_TEACHER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 1, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, NewBarkTownTeacherScript, -1
	object_event 13,  9, SPRITE_CHEATER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 1, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CheatingScript, EVENT_NEWBARK_CHEATER_KUN_EXITS
	object_event  3,  2, SPRITE_RIVAL, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, NewBarkTownRivalScript, EVENT_RIVAL_NEW_BARK_TOWN
