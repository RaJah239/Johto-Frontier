	object_const_def
	const HATCH_ROOM_GRAMPS

HatchRoom_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, HatchRoomAlwaysOnBikeCallback
	callback MAPCALLBACK_OBJECTS, HatchRoomEggCheckCallback

HatchRoomAlwaysOnBikeCallback:
	setflag ENGINE_ALWAYS_ON_BIKE
	setflag ENGINE_DOWNHILL
	endcallback

HatchRoomEggCheckCallback:
	checkflag ENGINE_DAY_CARE_MAN_HAS_EGG
	iftrue .PutDayCareManOutside
	clearevent EVENT_DAY_CARE_MAN_IN_DAY_CARE
	setevent EVENT_DAY_CARE_MAN_ON_ROUTE_34
	endcallback

.PutDayCareManOutside:
	setevent EVENT_DAY_CARE_MAN_IN_DAY_CARE
	clearevent EVENT_DAY_CARE_MAN_ON_ROUTE_34
	endcallback

DayCareManScript_Outside:
	faceplayer
	opentext
	special DayCareManOutside
	waitbutton
	closetext
	ifequal TRUE, .end_fail
	clearflag ENGINE_DAY_CARE_MAN_HAS_EGG
	readvar VAR_FACING
	ifequal UP, .walk_around_player
	applymovement HATCH_ROOM_GRAMPS, HatchRoomMovementData_DayCareManWalksBackInside
	playsound SFX_ENTER_DOOR
	disappear HATCH_ROOM_GRAMPS
.end_fail
	end

.walk_around_player
	applymovement HATCH_ROOM_GRAMPS, HatchRoomMovementData_DayCareManWalksBackInside_WalkAroundPlayer
	playsound SFX_ENTER_DOOR
	disappear HATCH_ROOM_GRAMPS
	end

HatchRoomMovementData_DayCareManWalksBackInside:
	slow_step DOWN
	slow_step DOWN
	slow_step RIGHT
	slow_step DOWN
	step_end

HatchRoomMovementData_DayCareManWalksBackInside_WalkAroundPlayer:
	slow_step RIGHT
	slow_step DOWN
	slow_step DOWN
	slow_step DOWN
	step_end

HatchRoom_MapEvents:
    db 0, 0 ; filler

    def_warp_events
	warp_event  2, 59, ROUTE_34, 6
	warp_event  3,  2, ROUTE_34, 7
	warp_event  3, 59, ROUTE_34, 7
	warp_event  3, 56, HATCH_ROOM, 2; looping tile

    def_coord_events

    def_bg_events

    def_object_events
	object_event  1, 56, SPRITE_GRAMPS, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, DayCareManScript_Outside, EVENT_DAY_CARE_MAN_ON_ROUTE_34
