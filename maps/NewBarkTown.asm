NewBarkTown_MapEvents:
	def_warp_events
	warp_event 13,  5, PLAYERS_HOUSE_1F, 1
	warp_event  6,  3, ELMS_LAB, 1
	warp_event  3, 11, PLAYERS_NEIGHBORS_HOUSE, 1
	warp_event 11, 13, ELMS_HOUSE, 1

	def_coord_events
	coord_event  1,  8, SCENE_NEWBARKTOWN_CANT_LEAVE_YET, NewBarkTown_CantGoLeftYet
	coord_event  1,  9, SCENE_NEWBARKTOWN_CANT_LEAVE_YET, NewBarkTown_CantGoLeftYet
	coord_event 18,  6, SCENE_NEWBARKTOWN_CANT_LEAVE_YET, NewBarkTown_CantGoRightYet
	coord_event 18,  7, SCENE_NEWBARKTOWN_CANT_LEAVE_YET, NewBarkTown_CantGoRightYet

	def_bg_events
	bg_event  8,  8, BGEVENT_JUMPTEXT, NewBarkTownSign
	bg_event 11,  5, BGEVENT_JUMPTEXT, NewBarkTownPlayersHouseSign
	bg_event  3,  3, BGEVENT_JUMPTEXT, NewBarkTownElmsLabSign
	bg_event  9, 13, BGEVENT_JUMPTEXT, NewBarkTownElmsHouseSign

	def_object_events
	object_event  6,  8, SPRITE_TEACHER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 1, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, NewBarkTownTeacherScript, -1
	object_event 13,  9, SPRITE_UNKNOWN, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 1, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CheatingScript, EVENT_NEWBARK_CHEATER_KUN_EXITS

	object_const_def
	const NEWBARKTOWN_TEACHER
	const NEWBARKTOWN_CHEAT_NPC

NewBarkTown_MapScripts:
	def_scene_scripts
	scene_script NewBarkTownNoop1Scene, SCENE_NEWBARKTOWN_CANT_LEAVE_YET
	scene_script NewBarkTownNoop2Scene, SCENE_NEWBARKTOWN_NOOP

	def_callbacks
	callback MAPCALLBACK_NEWMAP, NewBarkTownFlypointCallback

NewBarkTownNoop1Scene:
NewBarkTownNoop2Scene:
	end

NewBarkTownFlypointCallback:
	setflag ENGINE_FLYPOINT_NEW_BARK
	endcallback

NewBarkTown_CantGoLeftYet:
    checkevent EVENT_GOT_A_POKEMON_FROM_ELM
    iftrue .MeetMom
    showtext ProfElmIsWaitingText
    sjump .LeftTurnBack

.MeetMom:
    showtext CheckHomeBeforeLeavingText
.LeftTurnBack:
    applymovement PLAYER, NewBarkTown_PlayerStepsRight
    turnobject PLAYER, RIGHT
    end

NewBarkTown_PlayerStepsRight:
    step RIGHT
    step_end

NewBarkTown_CantGoRightYet:
    checkevent EVENT_GOT_A_POKEMON_FROM_ELM
    iftrue .MeetMom
    showtext ProfElmIsWaitingText
    sjump .RightTurnBack

.MeetMom:
    showtext CheckHomeBeforeLeavingText
.RightTurnBack:
    applymovement PLAYER, NewBarkTown_PlayerStepsLeft
    turnobject PLAYER, LEFT
    end

NewBarkTown_PlayerStepsLeft:
    step LEFT
    step_end

ProfElmIsWaitingText:
	text "Professor Elm is"
	line "waiting."
	done

CheckHomeBeforeLeavingText:
	text "Can't leave before"
	line "checking in home."
	done

NewBarkTownTeacherScript:
	checkevent EVENT_FIRST_TIME_BANKING_WITH_MOM
	iftrue_jumptextfaceplayer .TextCallYourMom
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iftrue_jumptextfaceplayer .TextGotAPokemon
	jumpthistextfaceplayer
		text "Wow, your #gear"
		line "is impressive!"

		para "Did your mom get"
		line "it for you?"
		done

.TextCallYourMom:
	text "Call your mom on"
	line "your #gear to"
	cont "let her know how"
	cont "you're doing."
	done

.TextGotAPokemon:
	text "Oh! Your #MON"
	line "is adorable!"

	para "I wish I had one!"
	done

CheatingScript:
	faceplayer
	opentext
	checkevent EVENT_CHEAT_MENU_ACCESSIBLE
	iftrue .Start
	writethistext
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
	setevent EVENT_CHEAT_MENU_ACCESSIBLE
	yesorno
	iffalse .ExitGameQuestionMark
.Start:
	writethistext
		text "Ready for some"
		line "cheating are we?"
		done
	promptbutton
	loadmenu .MenuHeader
	verticalmenu
	closewindow
	ifequal 1, .MaxRareCandy
	ifequal 2, .MaxHyperEvUp
	ifequal 3, .MaxMasterBall
	ifequal 4, .MaxCrystal
	jumpthisopenedtext
		text "Swing by anytime!"
		line "I'll always be"

		para "here for you and"
		line "your misdeeds!"
		done

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
	writethistext
		text "Are you certain"
		line "you want me gone?"
		done
	yesorno
	iffalse .Start
	closetext
	playsound SFX_WARP_TO
	applymovement NEWBARKTOWN_CHEAT_NPC, NewbarkTownCheaterKunTeleportAway
	disappear NEWBARKTOWN_CHEAT_NPC
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
.EndCheatingScript:
	writethistext
		text "<PLAYER> got"
		line "99× @"
		text_ram wStringBuffer3
		text "."
		done
	playsound SFX_ITEM
	waitsfx
	endtext

.NotEnoughSpace:
	jumpthisopenedtext
		text "There's no more"
		line "room in your bag…"
		done

NewbarkTownCheaterKunTeleportAway:
	teleport_from
	step_end

NewBarkTownSign:
	text "New Bark Town"

	para "The Town Where the"
	line "Winds of a New"
	cont "Beginning Blow"
	done

NewBarkTownPlayersHouseSign:
	text "<PLAYER>'s House"
	done

NewBarkTownElmsLabSign:
	text "Elm #mon Lab"
	done

NewBarkTownElmsHouseSign:
	text "Elm's House"
	done
