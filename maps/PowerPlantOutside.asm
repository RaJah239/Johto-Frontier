PowerPlantOutside_MapEvents:
	def_warp_events
	warp_event  5,  5, POWER_PLANT, 1
	warp_event  8, 15, ROUTE_12_POWER_PLANT_GATE, 3
	warp_event  9, 15, ROUTE_12_POWER_PLANT_GATE, 4

	def_coord_events

	def_bg_events
	bg_event  6,  6, BGEVENT_JUMPTEXT, PowerPlantOutsideSignText

	def_object_events

	object_const_def

PowerPlantOutside_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, PowerPlantFlypointCallback

PowerPlantFlypointCallback:
	setflag ENGINE_FLYPOINT_POWER_PLANT
	endcallback

PowerPlantOutsideSignText:
	text "Power Plant"

	para "We Power all of"
	line "Johto!"
	done
