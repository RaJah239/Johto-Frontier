	object_const_def

VermilionCity_MapScripts:
	def_scene_scripts

	def_callbacks

VermilionCity_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  9,  5, VERMILION_POKECENTER_1F, 1
	warp_event 10, 19, VERMILION_GYM, 1
	warp_event 19, 31, VERMILION_PORT_PASSAGE, 1
	warp_event 20, 31, VERMILION_PORT_PASSAGE, 2

	def_coord_events

	def_bg_events

	def_object_events
