	object_const_def

CeruleanCity_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, CeruleanCityFlypointCallback

CeruleanCityFlypointCallback:
	setflag ENGINE_FLYPOINT_CERULEAN
	endcallback

CeruleanCity_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 19, 21, CERULEAN_POKECENTER_1F, 1

	def_coord_events

	def_bg_events

	def_object_events
