Route21_MapScripts:
	def_scene_scripts
	scene_script Route21ForcedToLeaveScene, SCENE_ROUTE_21_FORCED_TO_LEAVE
	scene_script Route21NoopScene,          SCENE_ROUTE_21_NOOP

	def_callbacks
	callback MAPCALLBACK_NEWMAP, Route21FlypointCallback

Route21FlypointCallback:
	setflag ENGINE_FLYPOINT_ROUTE_20
	setflag ENGINE_FLYPOINT_INDIGO_PLATEAU
	endcallback

Route21ForcedToLeaveScene:
	sdefer NoWarpingHereFirstTime
	; fallthrough

Route21NoopScene:
	end

NoWarpingHereFirstTime:
	applymovement PLAYER, Route21_StepDownMovement
	opentext
	writetext FirstTimeHereNoticeText
	waitbutton
	special FadeOutPalettes
	playsound SFX_WARP_TO
	waitsfx
	warp NEW_BARK_TOWN, 13, 6
	end

Route21_StepDownMovement:
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

Route21_MapEvents:
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
