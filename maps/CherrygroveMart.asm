CherrygroveMart_MapEvents:
	def_warp_events
	warp_event  2,  7, CHERRYGROVE_CITY, 2
	warp_event  3,  7, CHERRYGROVE_CITY, 2

	def_coord_events

	def_bg_events

	def_object_events
	variable_mart_event 1, 3, PAL_NPC_PINK
	object_event  7,  6, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 2, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CherrygroveMartCooltrainerMText, -1
	object_event  2,  5, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, CherrygroveMartYoungsterText, -1

	object_const_def
	const CHERRYGROVEMART_CLERK
	const CHERRYGROVEMART_COOLTRAINER_M
	const CHERRYGROVEMART_YOUNGSTER

CherrygroveMart_MapScripts:
	def_scene_scripts

	def_callbacks

CherrygroveMartCooltrainerMText:
	text "I'm here to buy"
	line "more #balls to"
	cont "catch #mon!"
	done

CherrygroveMartYoungsterText:
	text "When I was walking"
	line "in the grass, a"
	cont "bug #mon poi-"
	cont "soned my own!"

	para "I just kept going,"
	line "but my #mon"
	cont "steadily lost its"
	cont "health until it"
	cont "almost fainted!"

	para "You should keep an"
	line "Antidote with you."
	done
