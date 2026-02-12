	object_const_def
	const ROUTE14ECRUTEAKGATE_OFFICER

Route14EcruteakGate_MapScripts:
	def_scene_scripts

	def_callbacks

Route14EcruteakGateOfficerScript:
	jumptextfaceplayer Route14EcruteakGateOfficerText

Route14EcruteakGateOfficerText:
	text "MT.MORTAR is like"
	line "a maze inside."

	para "Be careful. Don't"
	line "get lost in there."
	done

Route14EcruteakGate_MapEvents:
	def_warp_events
	warp_event  0,  4, ECRUTEAK_CITY, 2
	warp_event  0,  5, ECRUTEAK_CITY, 3
	warp_event  9,  4, ROUTE_14, 1
	warp_event  9,  5, ROUTE_14, 2

	def_coord_events

	def_bg_events

	def_object_events
	object_event  5,  2, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, Route14EcruteakGateOfficerScript, -1
