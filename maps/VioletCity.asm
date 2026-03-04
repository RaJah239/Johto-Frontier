VioletCity_MapEvents:
	def_warp_events
	warp_event 31, 25, VIOLET_POKECENTER_1F, 1
	warp_event  9, 17, VIOLET_MART, 2
	warp_event 18, 17, VIOLET_GYM, 1
	warp_event 30, 17, EARLS_POKEMON_ACADEMY, 1
	warp_event  3, 15, VIOLET_NICKNAME_SPEECH_HOUSE, 1
	warp_event 21, 29, VIOLET_KYLES_HOUSE, 1
	warp_event 23,  5, SPROUT_TOWER_1F, 1
	warp_event 39, 24, ROUTE_3_VIOLET_GATE, 1
	warp_event 39, 25, ROUTE_3_VIOLET_GATE, 2

	def_coord_events

	def_bg_events
	bg_event 24, 20, BGEVENT_JUMPTEXT, VioletCitySignText
	bg_event 15, 17, BGEVENT_JUMPTEXT, VioletGymSignText
	bg_event 24,  8, BGEVENT_JUMPTEXT, SproutTowerSignText
	bg_event 27, 17, BGEVENT_JUMPTEXT, EarlsPokemonAcademySignText
	bg_event 32, 25, BGEVENT_JUMPSTD, POKECENTER_SIGN_SCRIPT
	bg_event 10, 17, BGEVENT_JUMPSTD, MART_SIGN_SCRIPT
	bg_event 37, 14, BGEVENT_ITEM + HYPER_POTION, EVENT_VIOLET_CITY_HIDDEN_HYPER_POTION
	bg_event 14, 29, BGEVENT_JUMPSTD, NO_BERRY_OR_FRUIT_SCRIPT
	bg_event 12, 17, BGEVENT_JUMPSTD, NO_BERRY_OR_FRUIT_SCRIPT
	bg_event 13, 17, BGEVENT_JUMPSTD, NO_BERRY_OR_FRUIT_SCRIPT
	bg_event 13, 29, BGEVENT_JUMPSTD, NO_BERRY_OR_FRUIT_SCRIPT

	def_object_events
	object_event 28, 28, SPRITE_LASS, SPRITEMOVEDATA_WANDER, 2, 2, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, VioletCityLassText, -1
	object_event 24, 14, SPRITE_SUPER_NERD, SPRITEMOVEDATA_WANDER, 1, 2, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, VioletCitySuperNerdText, -1
	object_event 13, 15, SPRITE_GRAMPS, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, VioletCityGrampsText, -1
	object_event  5, 18, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, VioletCityYoungsterText, -1
	object_event  4,  1, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, VioletCityPPUp, EVENT_VIOLET_CITY_PP_UP
	object_event 35,  5, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, VioletCityRareCandy, EVENT_VIOLET_CITY_RARE_CANDY
	object_event 14, 29, SPRITE_BERRY, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, VioletCityBerryTree1, EVENT_VIOLET_CITY_BERRY1
	object_event 13, 29, SPRITE_BERRY, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_YELLOW, OBJECTTYPE_SCRIPT, 0, VioletCityBerryTree2, EVENT_VIOLET_CITY_BERRY2
	object_event 12, 17, SPRITE_APRICORN, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_WHITE, OBJECTTYPE_SCRIPT, 0, VioletCityApricornTree1, EVENT_VIOLET_CITY_APRICORN_1
	object_event 13, 17, SPRITE_APRICORN, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_BLACK, OBJECTTYPE_SCRIPT, 0, VioletCityApricornTree2, EVENT_VIOLET_CITY_APRICORN_2

	object_const_def
	const VIOLETCITY_LASS
	const VIOLETCITY_SUPER_NERD
	const VIOLETCITY_GRAMPS
	const VIOLETCITY_YOUNGSTER
	const VIOLETCITY_POKE_BALL1
	const VIOLETCITY_POKE_BALL2
	const VIOLETCITY_BERRY_TREE1
	const VIOLETCITY_BERRY_TREE2
	const VIOLETCITY_APRICORN_TREE1
	const VIOLETCITY_APRICORN_TREE2

VioletCity_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, VioletCityFlypointCallback

VioletCityFlypointCallback:
	setflag ENGINE_FLYPOINT_VIOLET
	endcallback

VioletCityLassText:
	text "Ghosts are rumored"
	line "to appear in"
	cont "Sprout Tower."

	para "They said normal-"
	line "type #mon moves"
	cont "had no effect on"
	cont "ghosts."
	done

VioletCitySuperNerdText:
	text "TODOTEXT"
	done

VioletCityGrampsText:
	text "Falkner, from the"
	line "Violet #mon"
	cont "Gym, is a fine"
	cont "trainer!"

	para "He inherited his"
	line "father's gym and"
	cont "has done a great"
	cont "job with it."
	done

VioletCityYoungsterText:
	text "I saw an odd"
	line "tree up ahead!"

	para "If only I could"
	line "reach it."
	done

VioletCitySignText:
	text "Violet City"

	para "The City of"
	line "Nostalgic Scents"
	done

VioletGymSignText:
	text "Violet City"
	line "#mon Gym"
	cont "Leader: Falkner"

	para "The Elegant Master"
	line "of Flying #mon"
	done

SproutTowerSignText:
	text "Sprout Tower"

	para "Experience the"
	line "Way of #mon"
	done

EarlsPokemonAcademySignText:
	text "Earl's #mon"
	line "Academy"
	done

VioletCityPPUp:
	itemball PP_UP
VioletCityRareCandy:
	itemball RARE_CANDY

VioletCityBerryTree1:
	setval PRZCUREBERRY
	setlasttalked VIOLETCITY_BERRY_TREE1
	jumpstd BerryOrFruitScript
VioletCityBerryTree2:
	setval BURNT_BERRY
	setlasttalked VIOLETCITY_BERRY_TREE2
	jumpstd BerryOrFruitScript
VioletCityApricornTree1:
	setval WHT_APRICORN
	setlasttalked VIOLETCITY_APRICORN_TREE1
	jumpstd BerryOrFruitScript
VioletCityApricornTree2:
	setval BLK_APRICORN
	setlasttalked VIOLETCITY_APRICORN_TREE2
	jumpstd BerryOrFruitScript
