	object_const_def
	const NEWBARKTOWN_TEACHER
	const NEWBARKTOWN_CHEATER_KUN

NewBarkTown_MapScripts:
	def_scene_scripts
	scene_script NewBarkTownNoop1Scene, SCENE_NEWBARKTOWN_TEACHER_STOPS_YOU
	scene_script NewBarkTownNoop2Scene, SCENE_NEWBARKTOWN_NOOP

	def_callbacks
	callback MAPCALLBACK_NEWMAP, NewBarkTownFlypointCallback

NewBarkTownNoop1Scene:
NewBarkTownNoop2Scene:
	end

NewBarkTownFlypointCallback:
	setflag ENGINE_FLYPOINT_NEW_BARK
	endcallback

NewBarkTown_INeedToGoMeetElm:
	opentext
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iftrue .MeetMomBeforeLeaving
	writetext NeedToMeetElmText
.PlayerTurnBack:
	waitbutton
	closetext
	applymovement PLAYER, NewBarkTown_PlayerStepsLeft
	turnobject PLAYER, LEFT
	end

.MeetMomBeforeLeaving:
	writetext MeetMomBeforeLeavingText
	sjump .PlayerTurnBack

NewBarkTown_PlayerStepsLeft:
	step LEFT
	step_end

NeedToMeetElmText:
	text "Prof.Elm is wait-"
	line "ing on me."
	done

MeetMomBeforeLeavingText:
	text "I can't go before"
	line "checking home."
	done

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
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iffalse .GoMeetYourMom
	writetext GoMetYourMomText
	waitbutton
	closetext
	special RestartMapMusic
	end

.GoMeetYourMom:
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
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iffalse .GoMeetYourMom
	writetext GoMetYourMomText
	waitbutton
	closetext
	special RestartMapMusic
	end

.GoMeetYourMom:
	writetext Text_ItsDangerousToGoAlone
	waitbutton
	closetext
	special RestartMapMusic
	end

NewBarkTownTeacherScript:
	checkevent EVENT_FIRST_TIME_BANKING_WITH_MOM
	iftrue .CallMom
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iftrue .MonIsAdorable
	jumptextfaceplayer Text_GearIsImpressive

.CallMom:
	jumptextfaceplayer Text_CallMomOnGear

.MonIsAdorable:
	jumptextfaceplayer Text_YourMonIsAdorable

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

Text_CallMomOnGear:
	text "Call your mom on"
	line "your #gear to"
	cont "let her know how"
	cont "you're doing."
	done

Text_YourMonIsAdorable:
	text "Oh! Your #MON"
	line "is adorable!"

	para "I wish I had one!"
	done

Text_GearIsImpressive:
	text "Wow, your #gear"
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
	cont "#mon!"

	para "Wild #mon"
	line "jump out of the"
	cont "grass on the way"
	cont "to the next town."
	done

GoMetYourMomText:
	text "You're going on a"
	line "big adventure?"

	para "Then you can't just"
	line "leave without let-"
	cont "your mom know."
	done

NewBarkTownSignText:
	text "New Bark Town"

	para "The Town Where the"
	line "Winds of a New"
	cont "Beginning Blow"
	done

NewBarkTownPlayersHouseSignText:
	text "<PLAYER>'s House"
	done

NewBarkTownElmsLabSignText:
	text "Elm #mon Lab"
	done

NewBarkTownElmsHouseSignText:
	text "Elm's House"
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
	db STATICMENU_CURSOR | STATICMENU_WRAP ; flags
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
	coord_event 18,  6, SCENE_NEWBARKTOWN_TEACHER_STOPS_YOU, NewBarkTown_INeedToGoMeetElm
	coord_event 18,  7, SCENE_NEWBARKTOWN_TEACHER_STOPS_YOU, NewBarkTown_INeedToGoMeetElm

	def_bg_events
	bg_event  8,  8, BGEVENT_READ, NewBarkTownSign
	bg_event 11,  5, BGEVENT_READ, NewBarkTownPlayersHouseSign
	bg_event  3,  3, BGEVENT_READ, NewBarkTownElmsLabSign
	bg_event  9, 13, BGEVENT_READ, NewBarkTownElmsHouseSign

	def_object_events
	object_event  6,  8, SPRITE_TEACHER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 1, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, NewBarkTownTeacherScript, -1
	object_event 13,  9, SPRITE_UNKNOWN, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 1, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CheatingScript, EVENT_NEWBARK_CHEATER_KUN_EXITS
