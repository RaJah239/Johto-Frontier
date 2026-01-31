	object_const_def
	const VIOLETMART_CLERK
	const VIOLETMART_GRANNY
	const VIOLETMART_COOLTRAINER_M

VioletMart_MapScripts:
	def_scene_scripts

	def_callbacks

VioletMartClerkScript:
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

VioletMartGrannyScript:
	jumptextfaceplayer VioletMartGrannyText

VioletMartCooltrainerMScript:
	jumptextfaceplayer VioletMartCooltrainerMText

VioletMartGrannyText:
	text "Just like Battle"
	line "items, Mail must"
	cont "also be held  by"
	cont "#mon."
	done

VioletMartCooltrainerMText:
	text "#MON can hold"
	line "items like POTION"
	cont "and ANTIDOTE."

	para "But they don't"
	line "appear to know how"

	para "to use manmade"
	line "items."
	done

VioletMart_MapEvents:
	def_warp_events
	warp_event  2,  7, VIOLET_CITY, 2
	warp_event  3,  7, VIOLET_CITY, 2

	def_coord_events

	def_bg_events

	def_object_events
	object_event  1,  3, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, VioletMartClerkScript, -1
	object_event  7,  6, SPRITE_GRANNY, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, VioletMartGrannyScript, -1
	object_event  5,  2, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, VioletMartCooltrainerMScript, -1
