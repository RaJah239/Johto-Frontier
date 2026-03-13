BattlePlaza_MapEvents:
	def_warp_events
	warp_event  5, 13, BATTLE_PLAZA_MAGNET_TRAIN_STATION, 1
	warp_event 20,  9, BATTLE_TOWER_1F, 1
	warp_event 21,  9, BATTLE_TOWER_1F, 2
	warp_event  5, 19, OAKS_LAB, 1
	warp_event 11,  5, BATTLE_PLAZA_RAJA_HOUSE, 1
	warp_event 26, 13, BATTLE_PLAZA_BATTLE_LOBBY, 2
	warp_event 27, 13, BATTLE_PLAZA_BATTLE_LOBBY, 1
	warp_event 14, 13, BATTLE_PLAZA_DRAFT_ARENA, 2
	warp_event 15, 13, BATTLE_PLAZA_DRAFT_ARENA, 1
	warp_event 13, 19, BATTLE_PLAZA_MART, 1
	warp_event 17, 19, BATTLE_PLAZA_MART, 4
	warp_event 24, 19, BATTLE_PLAZA_ECHO_CHAMBER, 2
	warp_event 25, 19, BATTLE_PLAZA_ECHO_CHAMBER, 1

	def_coord_events

	def_bg_events
	bg_event  4, 14, BGEVENT_JUMPTEXT, BattlePlazaTrainStationSignText
	bg_event 12,  6, BGEVENT_JUMPTEXT, BattlePlazaRaJaHouseSignText
	bg_event 30, 12, BGEVENT_JUMPTEXT, BattlePlazaBattleLobbyHouseSignText
	bg_event 11, 12, BGEVENT_JUMPTEXT, BattlePlazaDraftArenaSignText
	bg_event 22, 10, BGEVENT_JUMPTEXT, BattlePlazaBattleTowerSignText
	bg_event  4, 20, BGEVENT_JUMPTEXT, BattlePlazaProOaksLabSignText
	bg_event 11, 20, BGEVENT_JUMPTEXT, BattlePlazaMartSignText
	bg_event 20, 14, BGEVENT_JUMPTEXT, BattlePlazaSignText
	bg_event 28, 18, BGEVENT_JUMPTEXT, BattlePlazaEchoChamberSignText

	def_object_events
	object_event 11, 14, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_MET_RAJA

	object_const_def
	const BATTLEPLAZA_RAJA

BattlePlaza_MapScripts:
	def_scene_scripts
	scene_script BattlePlazaRaJaScene, SCENE_BATTLE_PLAZA_SCENE
	scene_script BattlePlazaNoopScene, SCENE_BATTLE_PLAZA_NOOP

	def_callbacks

BattlePlazaRaJaScene:
	sdefer MeetRaJaFirstTime
BattlePlazaNoopScene:
	end

MeetRaJaFirstTime:
	applymovement PLAYER, BattlePlazaPlayerStepDownMovement
	showemote EMOTE_SHOCK, PLAYER, 15
	turnobject PLAYER, RIGHT
	appear BATTLEPLAZA_RAJA
	applymovement BATTLEPLAZA_RAJA, BattlePlazaRaJaMovement1
	opentext
	writethistext
		text "Welcome <PLAYER>!"
		line "I'm RaJa239."

		para "Hmm… You've heard"
		line "of me? Nevermind"
		cont "that now."

		para "This place is the"
		line "Battle Plaza!"

		para "A hub dedicated"
		line "to various #mon"
		cont "Battle Facilities!"
		
		para "You could've come"
		line "here as soon as"
		cont "you got #mon."
		
		para "You may or may not"
		line "have had a good"
		cont "time but that was"
		cont "always the point!"

		para "FREEDOM!"
		
		para "Do whatever you"
		line "want, whenever you"
		cont "want, if anything"
		cont "at all!"
		
		para "Here's something"
		line "that's useful here."
		done
	promptbutton
	verbosegiveitem MEMBERS_CARD
	writethistext
		text "So, with that in"
		line "mind, feel free to"
		cont "explore and if you"
		cont "want, you can drop"
		cont "by my place next"
		cont "door. Have fun."

		para "Bye."
		done
	waitclosetext
	applymovement BATTLEPLAZA_RAJA, BattlePlazaRaJaMovement2
	disappear BATTLEPLAZA_RAJA
	setscene SCENE_BATTLE_PLAZA_NOOP
	end

BattlePlazaPlayerStepDownMovement:
	step DOWN
	step_end

BattlePlazaRaJaMovement1:
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step_end

BattlePlazaRaJaMovement2:
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step UP
	step UP
	step UP
	step UP
	step UP
	step_end

BattlePlazaTrainStationSignText:
	text "Battle Plaza's"
	line "Train Station"
	done

BattlePlazaRaJaHouseSignText:
	text "RaJa239's House"
	done

BattlePlazaBattleLobbyHouseSignText:
	text "Battle Lobby"

	para "Challenge random"
	line "trainers at their"
	cont "best!"
	done

BattlePlazaDraftArenaSignText:
	text "Draft Arena"
	
	para "Battle with your"
	line "own or other's"
	cont "#mon!"
	done

BattlePlazaBattleTowerSignText:
	text "Battle Tower"

	para "Ultimate Trainer"
	line "Challenge!"

	para "Aim for a 100"
	line "win streak!"
	done

BattlePlazaProOaksLabSignText:
	text "Prof. Oak's Lab"
	done

BattlePlazaMartSignText:
	text "Battle Plaza Mart"

	para "We fulfill all"
	line "battling needs!"
	done

BattlePlazaSignText:
	text "Battle Plaza"

	para "Hub for trainers"
	line "seeking endless"
	cont "battles!"
	done

BattlePlazaEchoChamberSignText:
	text "Echo Chamber"

	para "Try your luck"
	line "against yourself!"
	done
