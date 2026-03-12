Route16_MapEvents:
	def_warp_events
	warp_event 56,  7, ICE_PATH_1F, 1

	def_coord_events

	def_bg_events
	bg_event 53,  7, BGEVENT_JUMPTEXT, Route16Sign1Text
	bg_event  6, 10, BGEVENT_JUMPTEXT, Route16Sign2Text
	bg_event 32,  9, BGEVENT_ITEM + ELIXER, EVENT_ROUTE_16_HIDDEN_ELIXER
	bg_event  9,  5, BGEVENT_JUMPSTD, NO_BERRY_OR_FRUIT_SCRIPT
	bg_event 53,  4, BGEVENT_JUMPSTD, NO_BERRY_OR_FRUIT_SCRIPT
	bg_event  8,  4, BGEVENT_JUMPSTD, NO_BERRY_OR_FRUIT_SCRIPT

	def_object_events
	object_event 35,  3, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_GENERICTRAINER, 1, TrainerFisherWilton, -1
	object_event 19, 13, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_GENERICTRAINER, 1, TrainerFisherEdgar, -1
	object_event 10,  9, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_GENERICTRAINER, 3, TrainerPsychicPhil, -1
	object_event 43,  2, SPRITE_SUPER_NERD, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_GENERICTRAINER, 3, TrainerPokemaniacZach, -1
	object_event 51,  5, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_GENERICTRAINER, 2, TrainerBirdKeeperVance, -1
	object_event 41, 15, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_GENERICTRAINER, 5, TrainerCooltrainermAllen, -1
	object_event 31, 14, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_GENERICTRAINER, 5, TrainerCooltrainerfCybil, -1
	object_event 30,  8, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, Route16MaxRevive, EVENT_ROUTE_16_MAX_REVIVE
	object_event 45,  4, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, Route16UltraBall, EVENT_ROUTE_16_ULTRA_BALL
	object_event 14,  9, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, Route16MaxRepel, EVENT_ROUTE_16_MAX_REPEL
	object_event  9,  5, SPRITE_BERRY, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_YELLOW, OBJECTTYPE_SCRIPT, 0, Route16BerryTree1, EVENT_ROUTE_16_BERRY_1
	object_event 53,  4, SPRITE_BERRY, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, Route16BerryTree2, EVENT_ROUTE_16_BERRY_2
	object_event  8,  4, SPRITE_APRICORN, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_WHITE, OBJECTTYPE_SCRIPT, 0, Route16ApricornTree1, EVENT_ROUTE_16_APRICORN_1
	
	object_const_def
	const ROUTE16_FISHER1
	const ROUTE16_FISHER2
	const ROUTE16_YOUNGSTER1
	const ROUTE16_SUPER_NERD
	const ROUTE16_YOUNGSTER2
	const ROUTE16_COOLTRAINER_M
	const ROUTE16_COOLTRAINER_F
	const ROUTE16_POKE_BALL1
	const ROUTE16_POKE_BALL2
	const ROUTE16_POKE_BALL3
	const ROUTE16_BERRY_TREE1
	const ROUTE16_BERRY_TREE2
	const ROUTE16_APRICORN_TREE1

Route16_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, .Weather

.Weather:
	random 4
	ifequal 0, .Sun
	ifequal 1, .Rain
	ifequal 2, .Hail
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

.Hail
	setval WEATHER_HAIL
	writemem wFieldWeather
	endcallback

TrainerBirdKeeperVance:
	generictrainer BIRD_KEEPER, VANCE, EVENT_BEAT_BIRD_KEEPER_VANCE, .SeenText, .BeatenText

.AfterText
	text "Articuno, Zapdos"
	line "and Moltres are"
	cont "the three legend-"
	cont "ary bird #mon."

	para "I heard there are"
	line "other legendary"
	cont "birds, though."
	done

.SeenText
	text "Do you know about"
	line "the legendary bird"
	cont "#mon?"
	done

.BeatenText
	text "Whew! You're hot"
	line "stuff."
	done

TrainerPsychicPhil:
	generictrainer PSYCHIC_T, PHIL, EVENT_BEAT_PSYCHIC_PHIL, .SeenText, .BeatenText

.AfterText
	text "It's important to"
	line "have conviction"
	cont "on your side."
	done

.SeenText
	text "I'm gonna win,"
	line "for sure!"
	done

.BeatenText
	text "Arrgh… That's a"
	line "shocking loss…"
	done

TrainerFisherWilton:
	generictrainer FISHER, WILTON, EVENT_BEAT_FISHER_WILTON, .SeenText, .BeatenText

.AfterText
	text "That #mon that"
	line "got away…"
	cont "It was huge."

	para "I swear it must've"
	line "been 16 feet long!"
	done

.SeenText
	text "Aack! You made me"
	line "lose a #mon!"
	cont "What are you going"
	cont "to do about it?"
	done

.BeatenText
	text "Just forget about"
	line "it."
	done

TrainerFisherEdgar:
	generictrainer FISHER, EDGAR, EVENT_BEAT_FISHER_EDGAR, .SeenText, .BeatenText

.AfterText
	text "That's a lot of"
	line "losses on my end!"

	para "But I don't mind"
	line "battling again."
	done

.SeenText
	text "I fish until I"
	line "can't anymore."

	para "I also battle"
	line "until I drop."

	para "That's my"
	line "relationship"
	cont "with my #mon."
	done

.BeatenText
	text "Hmmmm… "
	line "This isn't right."
	done

TrainerCooltrainerfCybil:
	generictrainer COOLTRAINERF, CYBIL, EVENT_BEAT_COOLTRAINERF_CYBIL, .SeenText, .BeatenText

.AfterText
	text "We all get better"
	line "by experiencing"
	cont "many battles."

	para "I battled a lot to"
	line "become what I am"
	cont "today--an elite."
	done

.SeenText
	text "You look strong."

	para "Good trainers seek"
	line "tough opponents"
	cont "instinctively."
	done

.BeatenText
	text "Nope! This won't"
	line "do at all."
	done

TrainerPokemaniacZach:
	generictrainer POKEMANIAC, ZACH, EVENT_BEAT_POKEMANIAC_ZACH, .SeenText, .BeatenText

.AfterText
	text "If a #mon has"
	line "different colors"
	cont "from usual, it's"
	cont "more valuable."

	para "What? You mean"
	line "that's not true?"
	done

.SeenText
	text "I'll do anything"
	line "to get my hands on"
	cont "rare #mon!"
	done

.BeatenText
	text "Oooh, your #mon"
	line "are so appealing."
	done

TrainerCooltrainermAllen:
	generictrainer COOLTRAINERM, ALLEN, EVENT_BEAT_COOLTRAINERM_ALLEN, .SeenText, .BeatenText

.AfterText
	text "I wonder if"
	line "Ecruteak Gym's"
	cont "Morty is still in"
	cont "training?"

	para "He really hammered"
	line "me."
	done

.SeenText
	text "I can tell you're"
	line "a good trainer by"
	cont "looking at you."

	para "I'm good at #-"
	line "mon, and I can see"
	cont "that you are too."
	done

.BeatenText
	text "Tch! It's a total"
	line "loss on my part."
	done

Route16Sign1Text:
	text "Route 16"
	line "Ice Path Ahead"
	done

Route16Sign2Text:
	text "Route 16"

	para "Mahogany Town -"
	line "Blackthorn City"
	done

Route16MaxRevive:
	itemball MAX_REVIVE
Route16UltraBall:
	itemball ULTRA_BALL
Route16MaxRepel:
	itemball MAX_REPEL

Route16BerryTree1:
	setval BURNT_BERRY
	jumpstd BerryOrFruitScript
Route16BerryTree2:
	setval MIRACLEBERRY
	jumpstd BerryOrFruitScript
Route16ApricornTree1:
	setval WHT_APRICORN
	jumpstd BerryOrFruitScript
