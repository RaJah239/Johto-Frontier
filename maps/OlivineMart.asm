OlivineMart_MapEvents:
	def_warp_events
	warp_event  2,  7, OLIVINE_CITY, 7
	warp_event  3,  7, OLIVINE_CITY, 7

	def_coord_events

	def_bg_events

	def_object_events
	variable_mart_event 1, 3, PAL_NPC_BLUE
	object_event  6,  2, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 2, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlivineMartCooltrainerFText, -1
	object_event  1,  6, SPRITE_LASS, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlivineMartLassText, -1

	object_const_def
	const OLIVINEMART_CLERK
	const OLIVINEMART_COOLTRAINER_F
	const OLIVINEMART_LASS

OlivineMart_MapScripts:
	def_scene_scripts

	def_callbacks

OlivineMartCooltrainerFText:
	text "Do your #mon"
	line "already know the"
	cont "move for carrying"
	cont "people on water?"

	para "I guess it's not"
	line "needed if you have"
	cont "a Lanturn Call."
	done

OlivineMartLassText:
	text "My Beautifly came"
	line "from my boyfriend"
	cont "overseas."

	para "It carried some"
	line "Mail from him."

	para "Want to know what"
	line "it says?"

	para "Let's see… Nope!"
	line "It's a secret!"
	done
