GoldenrodMagnetTrainStation_MapEvents:
	def_warp_events
	warp_event  8, 17, GOLDENROD_CITY, 6
	warp_event  9, 17, GOLDENROD_CITY, 6
	warp_event  6,  5, BATTLE_PLAZA_MAGNET_TRAIN_STATION, 4
	warp_event 11,  5, BATTLE_PLAZA_MAGNET_TRAIN_STATION, 3

	def_coord_events
	coord_event 11,  6, SCENE_GOLDENRODMAGNETTRAINSTATION_ARRIVE_FROM_SAFFRON, Script_ArriveFromSaffron

	def_bg_events

	def_object_events
	object_event  9,  9, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodMagnetTrainStationOfficerScript, -1
	object_event 11, 13, SPRITE_GENTLEMAN, SPRITEMOVEDATA_WANDER, 2, 2, -1, -1, PAL_NPC_YELLOW, OBJECTTYPE_COMMAND, jumptextfaceplayer, GoldenrodMagnetTrainStationGentlemanText, -1
	object_event  6, 14, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_WANDER, 2, 2, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, GoldenrodMagnetTrainStationCooltrainerMText, -1
	object_event  6, 10, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_SPINRANDOM_FAST, 1, 1, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, GoldenrodMagnetTrainStationBugCatcherText, -1

	object_const_def
	const GOLDENRODMAGNETTRAINSTATION_OFFICER
	const GOLDENRODMAGNETTRAINSTATION_GENTLEMAN
	const GOLDENRODMAGNETTRAINSTATION_COOLTRAINERM

GoldenrodMagnetTrainStation_MapScripts:
	def_scene_scripts
	scene_script GoldenrodMagnetTrainStationNoopScene, SCENE_GOLDENRODMAGNETTRAINSTATION_ARRIVE_FROM_SAFFRON

	def_callbacks

GoldenrodMagnetTrainStationNoopScene:
	end

GoldenrodMagnetTrainStationOfficerScript:
	faceplayeropentext
	writethistext
		text "We'll soon depart"
		line "to Battle Plaza."

		para "Are you coming on"
		line "board?"
		done
	yesorno
	iffalse .DecidedNotToRide
	closetext
	applymovement GOLDENRODMAGNETTRAINSTATION_OFFICER, GoldenrodMagnetTrainStationOfficerApproachTrainDoorMovement
	applymovement PLAYER, GoldenrodMagnetTrainStationPlayerApproachAndEnterTrainMovement
	setval FALSE
	special MagnetTrain
	warpcheck
	newloadmap MAPSETUP_TRAIN
	applymovement PLAYER, .MovementBoardTheTrain
	wait 2
	end

.MovementBoardTheTrain:
	turn_head DOWN
	step_end

.DecidedNotToRide:
	jumpthisopenedtext
		text "We hope to see you"
		line "again!"
		done

GoldenrodMagnetTrainStationPlayerApproachAndEnterTrainMovement:
	step UP
	step UP
	step UP
	step LEFT
	step LEFT
	step LEFT
	step UP
	step UP
	step_end

GoldenrodMagnetTrainStationOfficerApproachTrainDoorMovement:
	step UP
	step UP
	step RIGHT
	turn_head LEFT
	step_end

Script_ArriveFromSaffron:
	applymovement GOLDENRODMAGNETTRAINSTATION_OFFICER, GoldenrodMagnetTrainStationOfficerApproachTrainDoorMovement
	applymovement PLAYER, GoldenrodMagnetTrainStationPlayerLeaveTrainAndEnterStationMovement
	applymovement GOLDENRODMAGNETTRAINSTATION_OFFICER, GoldenrodMagnetTrainStationOfficerReturnToBoardingGateMovement
	jumpthistext
		text "We have arrived in"
		line "Goldenrod."

		para "We hope to see you"
		line "again."
		done

GoldenrodMagnetTrainStationPlayerLeaveTrainAndEnterStationMovement:
	step LEFT
	step LEFT
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	turn_head UP
	step_end

GoldenrodMagnetTrainStationOfficerReturnToBoardingGateMovement:
	step LEFT
	step DOWN
	step DOWN
	step_end

GoldenrodMagnetTrainStationGentlemanText:
	text "The Magnet Train"
	line "is the only way to"
	cont "get to the far off"
	cont "Battle Plaza."

	para "Unless…"
	done

GoldenrodMagnetTrainStationCooltrainerMText:
	text "The Battle Plaza"
	line "has a number of"
	cont "facilities."

	para "You don't even have"
	line "to use your own"
	cont "#mon in some."
	done

GoldenrodMagnetTrainStationBugCatcherText:
	text "Yes! Yes! To the"
	line "Battle Plaza I go!"
	done
