	object_const_def
	const ROUTE26MAGNETTRAINSTATION_OFFICER
	const ROUTE26MAGNETTRAINSTATION_GYM_GUIDE
	const ROUTE26MAGNETTRAINSTATION_TEACHER
	const ROUTE26MAGNETTRAINSTATION_LASS

Route26MagnetTrainStation_MapScripts:
	def_scene_scripts
	scene_script Route26MagnetTrainStationNoopScene, SCENE_ROUTE26MAGNETTRAINSTATION_ARRIVE_FROM_GOLDENROD

	def_callbacks

Route26MagnetTrainStationNoopScene:
	end

Route26MagnetTrainStationOfficerScript:
	faceplayer
	opentext
	writetext Route26MagnetTrainStationOfficerAreYouComingOnBoardText
	yesorno
	iffalse .DecidedNotToRide
	writetext Route26MagnetTrainStationOfficerRightThisWayText
	waitbutton
	closetext
	applymovement ROUTE26MAGNETTRAINSTATION_OFFICER, Route26MagnetTrainStationOfficerApproachTrainDoorMovement
	applymovement PLAYER, Route26MagnetTrainStationPlayerApproachAndEnterTrainMovement
	setval TRUE
	special MagnetTrain
	warpcheck
	newloadmap MAPSETUP_TRAIN
	applymovement PLAYER, .MovementBoardTheTrain
	wait 5
	end

.MovementBoardTheTrain:
	turn_head DOWN
	step_end

.DecidedNotToRide:
	writetext Route26MagnetTrainStationOfficerHopeToSeeYouAgainText
	waitbutton
	closetext
	end

Script_ArriveFromGoldenrod:
	applymovement ROUTE26MAGNETTRAINSTATION_OFFICER, Route26MagnetTrainStationOfficerApproachTrainDoorMovement
	applymovement PLAYER, Route26MagnetTrainStationPlayerLeaveTrainAndEnterStationMovement
	applymovement ROUTE26MAGNETTRAINSTATION_OFFICER, Route26MagnetTrainStationOfficerReturnToBoardingGateMovement
	opentext
	writetext Route26MagnetTrainStationOfficerArrivedInRoute26Text
	waitbutton
	closetext
	end

Route26MagnetTrainStationGymGuideScript:
	faceplayer
	opentext
	writetext Route26MagnetTrainStationGymGuideText_ReturnedMachinePart
	waitbutton
	closetext
	end

Route26MagnetTrainStationTeacherScript:
	jumptextfaceplayer Route26MagnetTrainStationTeacherText

Route26MagnetTrainStationLassScript:
	jumptextfaceplayer Route26MagnetTrainStationLassText

Route26MagnetTrainStationOfficerApproachTrainDoorMovement:
	step UP
	step UP
	step RIGHT
	turn_head LEFT
	step_end

Route26MagnetTrainStationOfficerReturnToBoardingGateMovement:
	step LEFT
	step DOWN
	step DOWN
	step_end

Route26MagnetTrainStationPlayerApproachAndEnterTrainMovement:
	step UP
	step UP
	step UP
	step LEFT
	step LEFT
	step LEFT
	step UP
	step UP
	step_end

Route26MagnetTrainStationPlayerLeaveTrainAndEnterStationMovement:
	step LEFT
	step LEFT
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	turn_head UP
	step_end

Route26MagnetTrainStationOfficerAreYouComingOnBoardText:
	text "We'll soon depart"
	line "for GOLDENROD."

	para "Are you coming on"
	line "board?"
	done

Route26MagnetTrainStationOfficerRightThisWayText:
	text "OK. Right this"
	line "way, please."
	done

Route26MagnetTrainStationOfficerHopeToSeeYouAgainText:
	text "We hope to see you"
	line "again."
	done

Route26MagnetTrainStationOfficerArrivedInRoute26Text:
	text "We have arrived in"
	line "Route 26."

	para "We hope to see you"
	line "again."
	done

Route26MagnetTrainStationGymGuideText_ReturnedMachinePart:
	text "Whew…"

	para "How many times"
	line "have I gone back"

	para "and forth between"
	line "KANTO and JOHTO?"
	done

Route26MagnetTrainStationTeacherText:
	text "Before the MAGNET"
	line "TRAIN STATION was"

	para "built, there was a"
	line "house there."

	para "A little girl"
	line "named COPYCAT used"
	cont "to live there."
	done

Route26MagnetTrainStationLassText:
	text "Hi. Do you have a"
	line "rail PASS? I have"

	para "one. All the peo-"
	line "ple in Route26 who"

	para "ride the MAGNET"
	line "TRAIN have PASSES."
	done

Route26MagnetTrainStation_MapEvents:
	def_warp_events
	warp_event  8, 17, ROUTE_26, 4
	warp_event  9, 17, ROUTE_26, 4
	warp_event  6,  5, GOLDENROD_MAGNET_TRAIN_STATION, 4
	warp_event 11,  5, GOLDENROD_MAGNET_TRAIN_STATION, 3

	def_coord_events
	coord_event 11,  6, SCENE_ROUTE26MAGNETTRAINSTATION_ARRIVE_FROM_GOLDENROD, Script_ArriveFromGoldenrod

	def_bg_events

	def_object_events
	object_event  9,  9, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route26MagnetTrainStationOfficerScript, -1
	object_event 10, 14, SPRITE_GYM_GUIDE, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route26MagnetTrainStationGymGuideScript, -1
	object_event  6, 11, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route26MagnetTrainStationTeacherScript, -1
	object_event  6, 10, SPRITE_LASS, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, Route26MagnetTrainStationLassScript, -1
