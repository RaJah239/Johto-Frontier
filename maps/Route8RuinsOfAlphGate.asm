Route8RuinsOfAlphGate_MapEvents:
	def_warp_events
	warp_event  4,  0, ROUTE_8, 3
	warp_event  5,  0, ROUTE_8, 4
	warp_event  4,  7, RUINS_OF_ALPH_OUTSIDE, 9
	warp_event  5,  7, RUINS_OF_ALPH_OUTSIDE, 9

	def_coord_events

	def_bg_events

	def_object_events
	object_event  0,  4, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, Route8RuinsOfAlphGateOfficerScript, -1
	object_event  7,  5, SPRITE_GRAMPS, SPRITEMOVEDATA_WANDER, 1, 2, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route8RuinsOfAlphGateGrampsText, -1

	object_const_def
	const ROUTE8RUINSOFALPHGATE_OFFICER
	const ROUTE8RUINSOFALPHGATE_GRAMPS

Route8RuinsOfAlphGate_MapScripts:
	def_scene_scripts

	def_callbacks

Route8RuinsOfAlphGateOfficerScript:
	checkevent EVENT_GOT_WIDE_LENS
	iffalse .GiveWideLens
	jumpthistext
	text "Don't you wonder"
	line "who'd make some-"
	cont "thing like this?"

	para "And why?"
	done

.GiveWideLens
	faceplayeropentext
	writethistext
		text "If you're going to"
		line "inspect the Ruins,"
		cont "this'll surely"
		cont "come in handy."
		done
	promptbutton
	verbosegiveitem WIDE_LENS
	iffalse_endtext
	setevent EVENT_GOT_WIDE_LENS
	endtext

Route8RuinsOfAlphGateGrampsText:
	text "I wonder why so"
	line "very few visit the"
	cont "Ruins Of Alph."
	done
