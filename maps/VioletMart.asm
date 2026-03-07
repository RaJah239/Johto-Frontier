VioletMart_MapEvents:
	def_warp_events
	warp_event  2,  7, VIOLET_CITY, 2
	warp_event  3,  7, VIOLET_CITY, 2

	def_coord_events

	def_bg_events

	def_object_events
	variable_mart_event 1, 3, PAL_NPC_PURPLE
	object_event  7,  6, SPRITE_GRANNY, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, VioletMartGrannyText, -1
	object_event  5,  2, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, VioletMartCooltrainerMText, -1

	object_const_def
	const VIOLETMART_CLERK
	const VIOLETMART_GRANNY
	const VIOLETMART_COOLTRAINER_M

VioletMart_MapScripts:
	def_scene_scripts

	def_callbacks

VioletMartGrannyText:
	text "I'm old but even I"
	line "don't use Mail…"
	done

VioletMartCooltrainerMText:
	text "Repels prevent all"
	line "wild encounters"
	cont "regardless of your"
	cont "#mon's level."
	done
