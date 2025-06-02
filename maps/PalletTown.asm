	object_const_def

PalletTown_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, PalletTownFlypointCallback

PalletTownFlypointCallback:
	setflag ENGINE_FLYPOINT_PALLET
	endcallback

PalletTown_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  4,  5, OAKS_LAB, 1

	def_coord_events

	def_bg_events

	def_object_events
