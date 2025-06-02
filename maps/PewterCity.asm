	object_const_def

PewterCity_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, PewterCityFlypointCallback

PewterCityFlypointCallback:
	setflag ENGINE_FLYPOINT_PEWTER
	endcallback

PewterCity_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 16, 17, PEWTER_GYM, 1
	warp_event 13, 25, PEWTER_POKECENTER_1F, 1

	def_coord_events

	def_bg_events

	def_object_events
