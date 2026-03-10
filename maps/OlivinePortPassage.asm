OlivinePortPassage_MapEvents:
	def_warp_events
	warp_event 15,  0, OLIVINE_CITY, 9
	warp_event 16,  0, OLIVINE_CITY, 10
	warp_event 15,  4, OLIVINE_PORT_PASSAGE, 4
	warp_event  3,  2, OLIVINE_PORT_PASSAGE, 3
	warp_event  3, 14, OLIVINE_PORT, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event 17,  1, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlivinePortPassagePokefanMText, -1

	object_const_def
	const OLIVINEPORTPASSAGE_POKEFAN_M

OlivinePortPassage_MapScripts:
	def_scene_scripts

	def_callbacks

OlivinePortPassagePokefanMText:
	text "Fast Ship S.S.Aqua"
	line "sails to Cianwood"
	para "City."
	done
