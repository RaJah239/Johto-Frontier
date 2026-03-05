AzaleaMart_MapEvents:
	def_warp_events
	warp_event  2,  7, AZALEA_TOWN, 3
	warp_event  3,  7, AZALEA_TOWN, 3

	def_coord_events

	def_bg_events

	def_object_events
	variable_mart_event 1, 3, PAL_NPC_RED
	object_event  2,  5, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, AzaleaMartCooltrainerMText, -1
	object_event  7,  2, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 2, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, AzaleaMartBugCatcherText, -1

	object_const_def
	const AZALEAMART_CLERK
	const AZALEAMART_COOLTRAINER_M
	const AZALEAMART_BUG_CATCHER

AzaleaMart_MapScripts:
	def_scene_scripts

	def_callbacks

AzaleaMartCooltrainerMText:
	text "There's no Great"
	line "Ball here for me."

	para "#balls will"
	line "have to do."

	para "I wish Kurt would"
	line "make me some of"
	cont "his custom Balls."
	
	para "He doesn't think me"
	line "worthy…"
	done

AzaleaMartBugCatcherText:
	text "A Great Ball is"
	line "better for catch-"
	cont "ing #mon than a"
	cont "# Ball."

	para "But Kurt's might"
	line "be better some-"
	cont "times."
	done
