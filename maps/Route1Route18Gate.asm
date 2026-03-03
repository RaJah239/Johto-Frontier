Route1Route18Gate_MapEvents:
	def_warp_events
	warp_event  4,  0, ROUTE_18, 1
	warp_event  5,  0, ROUTE_18, 2
	warp_event  4,  7, ROUTE_1, 1
	warp_event  5,  7, ROUTE_1, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event  0,  4, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route1Route18GateOfficerText, -1
	object_event  6,  4, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 1, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route1Route18GateYoungsterText, -1

	object_const_def
	const ROUTE1ROUTE18GATE_OFFICER
	const ROUTE1ROUTE18GATE_YOUNGSTER

Route1Route18Gate_MapScripts:
	def_scene_scripts

	def_callbacks

Route1Route18GateOfficerText:
	text "You can't climb"
	line "ledges."

	para "But you can jump"
	line "down from them to"
	cont "take a shortcut."
	done

Route1Route18GateYoungsterText:
	text "Different kinds of"
	line "#mon appear"
	cont "past here."

	para "If you want to"
	line "catch them all,"
	cont "you have to look"
	cont "everywhere."
	done
