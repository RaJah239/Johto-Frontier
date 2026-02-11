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
	closetext
	end

.OneBadgeMart:
	pokemart MARTTYPE_STANDARD, MART_ONE_BADGE
	closetext
	end

.ThreeBadgesMart:
	pokemart MARTTYPE_STANDARD, MART_THREE_BADGES
	closetext
	end

.FiveBadgesMart:
	pokemart MARTTYPE_STANDARD, MART_FIVE_BADGES
	closetext
	end

.SevenBadgesMart:
	pokemart MARTTYPE_STANDARD, MART_SEVEN_BADGES
	closetext
	end

.EightBadgesMart:
	pokemart MARTTYPE_STANDARD, MART_EIGHT_BADGES
	closetext
	end

CherrygroveMartCooltrainerMScript:
	jumptextfaceplayer CherrygroveMartCooltrainerMText_PokeBallsInStock

CherrygroveMartCooltrainerMText_PokeBallsInStock:
	text "I'm here to buy"
	line "more #balls to"
	cont "catch #mon!"
	done

CherrygroveMartYoungsterScript:
	jumptextfaceplayer CherrygroveMartYoungsterText

CherrygroveMartYoungsterText:
	text "When I was walking"
	line "in the grass, a"

	para "bug #MON poi-"
	line "soned my own!"

	para "I just kept going,"
	line "but my #MON"
	
	para "steadily lost its"
	line "health until it"
	cont "almost fainted!"

	para "You should keep an"
	line "ANTIDOTE with you."
	done

CherrygroveMart_MapEvents:
	def_warp_events
	warp_event  2,  7, CHERRYGROVE_CITY, 2
	warp_event  3,  7, CHERRYGROVE_CITY, 2

	def_coord_events

	def_bg_events

	def_object_events
	object_event  1,  3, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CherrygroveMartClerkScript, -1
	object_event  7,  6, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 2, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CherrygroveMartCooltrainerMScript, -1
	object_event  2,  5, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, CherrygroveMartYoungsterScript, -1
