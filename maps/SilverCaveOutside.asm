	object_const_def
	const MTSILVER_GS_BALL

SilverCaveOutside_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, SilverCaveOutsideFlypointCallback

SilverCaveOutsideFlypointCallback:
	setflag ENGINE_FLYPOINT_SILVER_CAVE
	endcallback

MtSilverPokecenterSign:
	jumpstd PokecenterSignScript

MtSilverSign:
	jumptext MtSilverSignText

SilverCaveOutsideGSBall:
	itemball GS_BALL

MtSilverSignText:
	text "SILVER CAVE"
	done

SilverCaveOutside_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 25, 19, SILVER_CAVE_POKECENTER_1F, 1
	warp_event 18, 11, SILVER_CAVE_ROOM_1, 1
	warp_event 25, 31, ROUTE_39_SILVER_CAVE_GATE, 3
	warp_event 26, 31, ROUTE_39_SILVER_CAVE_GATE, 4

	def_coord_events

	def_bg_events
	bg_event 26, 19, BGEVENT_READ, MtSilverPokecenterSign
	bg_event 17, 13, BGEVENT_READ, MtSilverSign

	def_object_events
	object_event  9, 25, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_ITEMBALL, 0, SilverCaveOutsideGSBall, EVENT_CAN_GIVE_GS_BALL_TO_KURT
