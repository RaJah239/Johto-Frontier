	object_const_def
	const ROUTE4RUINSOFALPHGATE_OFFICER
	const ROUTE4RUINSOFALPHGATE_POKEFAN_M
	const ROUTE4RUINSOFALPHGATE_YOUNGSTER

Route4RuinsOfAlphGate_MapScripts:
	def_scene_scripts

	def_callbacks

Route4RuinsOfAlphGateOfficerScript:
	jumptextfaceplayer Route4RuinsOfAlphGateOfficerText

Route4RuinsOfAlphGatePokefanMScript:
	jumptextfaceplayer Route4RuinsOfAlphGatePokefanMText

Route4RuinsOfAlphGateYoungsterScript:
	jumptextfaceplayer Route4RuinsOfAlphGateYoungsterText

Route4RuinsOfAlphGateOfficerText:
	text "RUINS OF ALPH"

	para "A Look-and-Touch"
	line "Tourist Site"

	para "Try the sliding"
	line "stone panels!"
	done

Route4RuinsOfAlphGatePokefanMText:
	text "You're studying"
	line "the RUINS?"

	para "I see a scientist"
	line "in the making."
	done

Route4RuinsOfAlphGateYoungsterText:
	text "There are drawings"
	line "on stone panels."

	para "I tried moving"
	line "them. I wonder"
	cont "what they are."
	done

Route4RuinsOfAlphGate_MapEvents:	def_warp_events
	warp_event  0,  4, RUINS_OF_ALPH_OUTSIDE, 10
	warp_event  0,  5, RUINS_OF_ALPH_OUTSIDE, 11
	warp_event  9,  4, ROUTE_4, 2
	warp_event  9,  5, ROUTE_4, 3

	def_coord_events

	def_bg_events

	def_object_events
	object_event  5,  2, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, Route4RuinsOfAlphGateOfficerScript, -1
	object_event  8,  2, SPRITE_POKEFAN_M, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 1, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, Route4RuinsOfAlphGatePokefanMScript, -1
	object_event  1,  6, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, Route4RuinsOfAlphGateYoungsterScript, -1
