HatchRoom_MapScripts:
    def_scene_scripts

    def_callbacks
    callback MAPCALLBACK_NEWMAP, HatchRoomAlwaysOnBikeCallback

HatchRoomAlwaysOnBikeCallback:
    setflag ENGINE_ALWAYS_ON_BIKE
    setflag ENGINE_DOWNHILL
    endcallback

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
