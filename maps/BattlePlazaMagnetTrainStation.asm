BattlePlazaMagnetTrainStation_MapEvents:
	def_warp_events
	warp_event  8, 17, BATTLE_PLAZA, 1
	warp_event  9, 17, BATTLE_PLAZA, 1
	warp_event  6,  5, GOLDENROD_MAGNET_TRAIN_STATION, 4
	warp_event 11,  5, GOLDENROD_MAGNET_TRAIN_STATION, 3

	def_coord_events
	coord_event 11,  6, SCENE_BATTLEPLAZAMAGNETTRAINSTATION_ARRIVE_FROM_GOLDENROD, Script_ArriveFromGoldenrod

	def_bg_events

	def_object_events
	object_event  9,  9, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, BattlePlazaMagnetTrainStationOfficerScript, -1
	object_event 10, 14, SPRITE_GYM_GUIDE, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, BattlePlazaMagnetTrainStationGymGuideText, -1
	object_event  6, 11, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, BattlePlazaMagnetTrainStationTeacherText, -1
	object_event  6, 10, SPRITE_LASS, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, BattlePlazaMagnetTrainStationLassText, -1

	object_const_def
	const BATTLEPLAZAMAGNETTRAINSTATION_OFFICER
	const BATTLEPLAZAMAGNETTRAINSTATION_GYM_GUIDE
	const BATTLEPLAZAMAGNETTRAINSTATION_TEACHER
	const BATTLEPLAZAMAGNETTRAINSTATION_LASS

BattlePlazaMagnetTrainStation_MapScripts:
	def_scene_scripts
	scene_script BattlePlazaMagnetTrainStationNoopScene, SCENE_BATTLEPLAZAMAGNETTRAINSTATION_ARRIVE_FROM_GOLDENROD

	def_callbacks

BattlePlazaMagnetTrainStationNoopScene:
	end

BattlePlazaMagnetTrainStationOfficerScript:
	faceplayeropentext
	writethistext
		text "We'll soon depart"
		line "for Goldenrod."

		para "Are you coming on"
		line "board?"
		done
	yesorno
	iffalse .DecidedNotToRide
	writethistext
		text "OK. Right this"
		line "way, please."
		done
	waitclosetext
	applymovement BATTLEPLAZAMAGNETTRAINSTATION_OFFICER, BattlePlazaMagnetTrainStationOfficerApproachTrainDoorMovement
	applymovement PLAYER, BattlePlazaMagnetTrainStationPlayerApproachAndEnterTrainMovement
	setval TRUE
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
		line "again."
		done

Script_ArriveFromGoldenrod:
	applymovement BATTLEPLAZAMAGNETTRAINSTATION_OFFICER, BattlePlazaMagnetTrainStationOfficerApproachTrainDoorMovement
	applymovement PLAYER, BattlePlazaMagnetTrainStationPlayerLeaveTrainAndEnterStationMovement
	applymovement BATTLEPLAZAMAGNETTRAINSTATION_OFFICER, BattlePlazaMagnetTrainStationOfficerReturnToBoardingGateMovement
	jumpthistext
		text "We have arrived in"
		line "Goldenrod City."

		para "We hope to see you"
		line "again."
		done

BattlePlazaMagnetTrainStationOfficerApproachTrainDoorMovement:
	step UP
	step UP
	step RIGHT
	turn_head LEFT
	step_end

BattlePlazaMagnetTrainStationOfficerReturnToBoardingGateMovement:
	step LEFT
	step DOWN
	step DOWN
	step_end

BattlePlazaMagnetTrainStationPlayerApproachAndEnterTrainMovement:
	step UP
	step UP
	step UP
	step LEFT
	step LEFT
	step LEFT
	step UP
	step UP
	step_end

BattlePlazaMagnetTrainStationPlayerLeaveTrainAndEnterStationMovement:
	step LEFT
	step LEFT
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	turn_head UP
	step_end

BattlePlazaMagnetTrainStationGymGuideText:
	text "Whew…"

	para "Being on a train,"
	line "even a fast one"
	cont "is tiring…"
	done

BattlePlazaMagnetTrainStationTeacherText:
	text "I'm going to the"
	line "Draft Arena next."
	done

BattlePlazaMagnetTrainStationLassText:
	text "The Battle Tower"
	line "is tough!"
	done
