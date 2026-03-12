Route18_MapEvents:
	def_warp_events
	warp_event  7, 33, ROUTE_1_ROUTE_18_GATE, 1
	warp_event  8, 33, ROUTE_1_ROUTE_18_GATE, 2
	warp_event 14,  5, DARK_CAVE_VIOLET_ENTRANCE, 3

	def_coord_events

	def_bg_events
	bg_event  9, 27, BGEVENT_JUMPTEXT, Route18SignText
	bg_event  7,  5, BGEVENT_JUMPSTD, NO_BERRY_OR_FRUIT_SCRIPT
	bg_event  8,  6, BGEVENT_JUMPSTD, NO_BERRY_OR_FRUIT_SCRIPT
	bg_event  7,  6, BGEVENT_JUMPSTD, NO_BERRY_OR_FRUIT_SCRIPT
	bg_event  8,  5, BGEVENT_JUMPSTD, NO_BERRY_OR_FRUIT_SCRIPT

	def_object_events
	object_event 12, 19, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_GENERICTRAINER, 2, TrainerHikerBailey, -1
	object_event  4, 14, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_GENERICTRAINER, 2, TrainerCamperTed, -1
	object_event  2, 13, SPRITE_LASS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_GENERICTRAINER, 2, TrainerPicnickerErin, -1
	object_event  2, 18, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, Route18HasteHerb, EVENT_ROUTE_18_HASTE_HERB
	object_event  7,  5, SPRITE_BERRY, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, Route18BerryTree1, EVENT_ROUTE_18_BERRY_1
	object_event  8,  6, SPRITE_BERRY, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_YELLOW, OBJECTTYPE_SCRIPT, 0, Route18BerryTree2, EVENT_ROUTE_18_BERRY_2
	object_event  7,  6, SPRITE_BERRY, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, Route18BerryTree3, EVENT_ROUTE_18_BERRY_3
	object_event  8,  5, SPRITE_BERRY, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, Route18BerryTree4, EVENT_ROUTE_18_BERRY_4

	object_const_def
	const ROUTE18_POKEFAN_M
	const ROUTE18_YOUNGSTER
	const ROUTE18_LASS
	const ROUTE18_POKE_BALL
	const ROUTE18_BERRY_TREE1
	const ROUTE18_BERRY_TREE2
	const ROUTE18_BERRY_TREE3
	const ROUTE18_BERRY_TREE4

Route18_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, .Weather

.Weather:
	random 4
	ifequal 0, .Sun
	ifequal 1, .Rain
	ifequal 2, .Sandstorm
	setval WEATHER_NONE
	writemem wFieldWeather
	endcallback

.Sun
	setval WEATHER_SUN
	writemem wFieldWeather
	endcallback

.Rain
	setval WEATHER_RAIN
	writemem wFieldWeather
	endcallback

.Sandstorm
	setval WEATHER_SANDSTORM
	writemem wFieldWeather
	endcallback

TrainerCamperTed:
	generictrainer CAMPER, TED, EVENT_BEAT_CAMPER_TED, .SeenText, .BeatenText

.AfterText
	text "I did my best but"
	line "came up short."

	para "No excuses--I"
	line "admit I lost."
	done

.SeenText
	text "I'm raising #-"
	line "mon too!"

	para "Will you battle"
	line "with me?"
	done

.BeatenText
	text "Wha…?"
	done

TrainerPicnickerErin:
	generictrainer PICNICKER, ERIN, EVENT_BEAT_PICNICKER_ERIN, .SeenText, .BeatenText

.AfterText
	text "I've been to many"
	line "Gyms, but the Gym"
	cont "in Goldenrod is my"
	cont "favorite."

	para "It's filled with"
	line "pretty flowers!"
	done

.SeenText
	text "I raise #mon"
	line "too!"

	para "Will you battle"
	line "with me?"
	done

.BeatenText
	text "Oh, rats!"
	done

TrainerHikerBailey:
	generictrainer HIKER, BAILEY, EVENT_BEAT_HIKER_BAILEY, .SeenText, .BeatenText

.Afterext
	text "It's over. I don't"
	line "mind. We Hikers"
	cont "are like that."
	done

.SeenText
	text "Awright! I'll show"
	line "you the power of"
	cont "mountain #mon!"
	done

.BeatenText
	text "Mercy! You showed"
	line "me your power!"
	done

Route18SignText:
	text "Route 18"
	line "Mountain Rd. Ahead"
	done

Route18HasteHerb:
	itemball HASTE_HERB

Route18BerryTree1:
	setval PRZCUREBERRY
	jumpstd BerryOrFruitScript
Route18BerryTree2:
	setval BITTER_BERRY
	jumpstd BerryOrFruitScript
Route18BerryTree3:
	setval BERRY
	jumpstd BerryOrFruitScript
Route18BerryTree4:
	setval PSNCUREBERRY
	jumpstd BerryOrFruitScript
