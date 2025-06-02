	object_const_def

Route16Gate_MapScripts:
	def_scene_scripts

	def_callbacks


Route16Gate_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  0,  4, ROUTE_16, 4
	warp_event  0,  5, ROUTE_16, 5
	warp_event  9,  4, ROUTE_16, 2
	warp_event  9,  5, ROUTE_16, 3

	def_coord_events

	def_bg_events

	def_object_events
