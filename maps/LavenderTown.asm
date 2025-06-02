	object_const_def

LavenderTown_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, LavenderTownFlypointCallback

LavenderTownFlypointCallback:
	setflag ENGINE_FLYPOINT_LAVENDER
	endcallback

LavenderTown_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  5,  5, LAVENDER_POKECENTER_1F, 1

	def_coord_events

	def_bg_events

	def_object_events
