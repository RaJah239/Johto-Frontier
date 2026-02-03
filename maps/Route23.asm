Route23_MapScripts:
	def_scene_scripts
	scene_script Route23ForcedToLeaveScene, SCENE_ROUTE_23_FORCED_TO_LEAVE
	scene_script Route23NoopScene,          SCENE_ROUTE_23_NOOP

	def_callbacks
	callback MAPCALLBACK_NEWMAP, Route23FlypointCallback

Route23FlypointCallback:
	setflag ENGINE_FLYPOINT_ROUTE_26
	setflag ENGINE_FLYPOINT_INDIGO_PLATEAU
	endcallback

Route23ForcedToLeaveScene:
	sdefer NoWarpingHereFirstTime
	; fallthrough

Route23NoopScene:
	end

NoWarpingHereFirstTime:
	applymovement PLAYER, Route23_StepDownMovement
	opentext
	writetext FirstTimeHereNoticeText
	waitbutton
	special FadeOutPalettes
	playsound SFX_WARP_TO
	waitsfx
	warp NEW_BARK_TOWN, 13, 6
	end

Route23_StepDownMovement:
	step DOWN
	step_end

FirstTimeHereNoticeText:
	text "Notice: First time"
	line "here must be via"
	cont "Victory Road."
	done

IndigoPlateauSign:
	jumptext IndigoPlateauSignText

IndigoPlateauSignText:
	text "INDIGO PLATEAU"

	para "The Ultimate Goal"
	line "for Trainers!"

	para "#MON LEAGUE HQ"
	done

NurseJoyTrainingSign:
	jumptext NurseJoyTrainingSignText

NurseJoyTrainingSignText:
	text "Nurse Joy's"
	line "training academy."

	para "Get your #mon"
	line "ready for the"
	cont "#mon League!"
	done

Route23_MapEvents:
	def_warp_events
	warp_event  9,  5, INDIGO_PLATEAU_POKECENTER_1F, 1
	warp_event 10,  5, INDIGO_PLATEAU_POKECENTER_1F, 2
	warp_event  9, 13, VICTORY_ROAD, 10
	warp_event 10, 13, VICTORY_ROAD, 10
	warp_event 13,  9, NURSE_JOYS_TRAINING_ACADEMY, 1

	def_coord_events

	def_bg_events
	bg_event 11,  7, BGEVENT_READ, IndigoPlateauSign
	bg_event 14, 10, BGEVENT_READ, NurseJoyTrainingSign

	def_object_events
