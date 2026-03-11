Route15MahoganyGate_MapEvents:
	def_warp_events
	warp_event  4,  0, ROUTE_15, 1
	warp_event  5,  0, ROUTE_15, 2
	warp_event  4,  7, MAHOGANY_TOWN, 5
	warp_event  5,  7, MAHOGANY_TOWN, 5

	def_coord_events

	def_bg_events

	def_object_events
	object_event  0,  4, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route15MahoganyGateOfficerText, -1

	object_const_def
	const ROUTE15MAHOGANYGATE_OFFICER

Route15MahoganyGate_MapScripts:
	def_scene_scripts

	def_callbacks

Route15MahoganyGateOfficerText:
	text "The areas ahead"
	line "are in perpetual"
	cont "rainfall."
	
	para "Great for Water"
	line "#mon, not so"
	cont "for Fire."

	para "I wonder if the"
	line "Lake of Rage has"
	cont "anything to do"
	cont "with it…"
	done
