	object_const_def

Route17Route18Gate_MapScripts:
	def_scene_scripts

	def_callbacks


Route17Route18Gate_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  0,  4, ROUTE_17, 1
	warp_event  0,  5, ROUTE_17, 2
	warp_event  9,  4, ROUTE_18, 1
	warp_event  9,  5, ROUTE_18, 2

	def_coord_events

	def_bg_events

	def_object_events
