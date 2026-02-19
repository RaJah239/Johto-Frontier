CherrygroveMart_MapEvents:
	def_warp_events
	warp_event  2,  7, CHERRYGROVE_CITY, 2
	warp_event  3,  7, CHERRYGROVE_CITY, 2

	def_coord_events

	def_bg_events

	def_object_events
	object_event  1,  3, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, CherrygroveMartClerkScript, -1
	object_event  7,  6, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 2, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CherrygroveMartCooltrainerMText, -1
	object_event  2,  5, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, CherrygroveMartYoungsterText, -1

	object_const_def
	const CHERRYGROVEMART_CLERK
	const CHERRYGROVEMART_COOLTRAINER_M
	const CHERRYGROVEMART_YOUNGSTER

CherrygroveMart_MapScripts:
	def_scene_scripts

	def_callbacks

CherrygroveMartClerkScript:
	opentext
	readvar VAR_BADGES
	ifgreater 7, .EightBadgesMart
	ifgreater 6, .SevenBadgesMart
	ifgreater 4, .FiveBadgesMart
	ifgreater 2, .ThreeBadgesMart
	ifgreater 0, .OneBadgeMart
	pokemart MARTTYPE_STANDARD, MART_NO_BADGES
	endtext

.OneBadgeMart:
	pokemart MARTTYPE_STANDARD, MART_ONE_BADGE
	endtext
.ThreeBadgesMart:
	pokemart MARTTYPE_STANDARD, MART_THREE_BADGES
	endtext
.FiveBadgesMart:
	pokemart MARTTYPE_STANDARD, MART_FIVE_BADGES
	endtext
.SevenBadgesMart:
	pokemart MARTTYPE_STANDARD, MART_SEVEN_BADGES
	endtext
.EightBadgesMart:
	pokemart MARTTYPE_STANDARD, MART_EIGHT_BADGES
	endtext

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
