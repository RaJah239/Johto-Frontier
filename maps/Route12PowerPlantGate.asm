Route12PowerPlantGate_MapEvents:
	def_warp_events
	warp_event  4,  7, ROUTE_12, 1
	warp_event  5,  7, ROUTE_12, 1
	warp_event  4,  0, POWER_PLANT_OUTSIDE, 2
	warp_event  5,  0, POWER_PLANT_OUTSIDE, 3

	def_coord_events

	def_bg_events

	def_object_events
	object_event  9,  4, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_AZURE, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route12PowerPlantOfficerText, -1

	object_const_def
	const ROUTE12POWERPLANTGATE_OFFICER

Route12PowerPlantGate_MapScripts:
	def_scene_scripts

	def_callbacks

Route12PowerPlantOfficerText:
	text "Be sure to stay"
	line "out of danger"
	cont "around here."
	done
