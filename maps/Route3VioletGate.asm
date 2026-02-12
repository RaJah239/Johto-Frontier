	object_const_def
	const ROUTE3VIOLETGATE_OFFICER
	const ROUTE3VIOLETGATE_COOLTRAINER_F

Route3VioletGate_MapScripts:
	def_scene_scripts

	def_callbacks

Route3VioletGateOfficerScript:
	jumptextfaceplayer Route3VioletGateOfficerText

Route3VioletGateCooltrainerFScript:
	jumptextfaceplayer Route3VioletGateCooltrainerFText

Route3VioletGateOfficerText:
	text "Hi there!"
	line "Did you visit"
	cont "SPROUT TOWER?"
	done

Route3VioletGateCooltrainerFText:
	text "I came too far"
	line "out. I'd better"
	cont "phone home!"
	done

Route3VioletGate_MapEvents:
	def_warp_events
	warp_event  0,  4, VIOLET_CITY, 8
	warp_event  0,  5, VIOLET_CITY, 9
	warp_event  9,  4, ROUTE_3, 1
	warp_event  9,  5, ROUTE_3, 2

	def_coord_events

	def_bg_events

	def_object_events
	object_event  5,  2, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, Route3VioletGateOfficerScript, -1
	object_event  1,  2, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, Route3VioletGateCooltrainerFScript, -1
