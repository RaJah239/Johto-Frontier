	object_const_def
	const BATTLEPLAZA_RAJA

BattlePlaza_MapScripts:
	def_scene_scripts
	scene_script BattlePlazaRaJaScene, SCENE_BATTLE_PLAZA_SCENE
	scene_script BattlePlazaNoopScene, SCENE_BATTLE_PLAZA_NOOP

	def_callbacks

BattlePlazaRaJaScene:
	sdefer MeetRaJaFirstTime
	; fallthrough

BattlePlazaNoopScene:
	end

MeetRaJaFirstTime:
	applymovement PLAYER, BattlePlazaPlayerStepDownMovement
	showemote EMOTE_SHOCK, PLAYER, 15
	turnobject PLAYER, RIGHT
	playsound SFX_EXIT_BUILDING
	appear BATTLEPLAZA_RAJA
	waitsfx
	applymovement BATTLEPLAZA_RAJA, BattlePlazaRaJaMovement1
	opentext
	writetext BattlePlazaRaJaIntroText
	waitbutton
	closetext
	applymovement BATTLEPLAZA_RAJA, BattlePlazaRaJaMovement2
	playsound SFX_EXIT_BUILDING
	waitsfx
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
	step RIGHT
	step_end

BattlePlazaRaJaIntroText:
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

	para "So, with that in"
	line "mind, feel free to"
	cont "explore and if you"
	cont "want, you can drop"
	cont "by my place next"
	cont "door. Have fun."

	para "Bye."
	done

BattlePlazaTrainStationSign:
	jumptext BattlePlazaTrainStationSignText

BattlePlazaRaJaHouseSign:
	jumptext BattlePlazaRaJaHouseSignText

BattlePlazaTrainStationSignText:
	text "Battle Plaza's"
	line "Train Station"
	done

BattlePlazaRaJaHouseSignText:
	text "RaJa239's House"
	done

BattlePlaza_MapEvents:
	def_warp_events
	warp_event  5,  5, BATTLE_PLAZA_MAGNET_TRAIN_STATION, 1
	warp_event 20,  9, BATTLE_TOWER_1F, 1
	warp_event 21,  9, BATTLE_TOWER_1F, 2
	warp_event  5, 21, OAKS_LAB, 1
	warp_event 11,  5, BATTLE_PLAZA_RAJA_HOUSE, 1

	def_coord_events

	def_bg_events
	bg_event  4,  6, BGEVENT_READ, BattlePlazaTrainStationSign
	bg_event 12,  6, BGEVENT_READ, BattlePlazaRaJaHouseSign

	def_object_events
	object_event 11,  6, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_MET_RAJA
