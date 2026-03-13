Route17_MapEvents:
	def_warp_events
	warp_event  2,  5, DARK_CAVE_BLACKTHORN_ENTRANCE, 1

	def_coord_events

	def_bg_events
	bg_event 10,  4, BGEVENT_JUMPTEXT, Route17SignText
	bg_event 13, 80, BGEVENT_ITEM + CRYSTAL, EVENT_ROUTE_17_HIDDEN_CRYSTAL
	bg_event 16, 82, BGEVENT_JUMPSTD, NO_BERRY_OR_FRUIT_SCRIPT
	bg_event 14, 82, BGEVENT_JUMPSTD, NO_BERRY_OR_FRUIT_SCRIPT

	def_object_events
	object_event 10, 16, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_GENERICTRAINER, 1, TrainerHikerErik, -1
	object_event 15, 65, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_GENERICTRAINER, 2, TrainerHikerMichael, -1
	object_event  5, 28, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_GENERICTRAINER, 2, TrainerHikerParry, -1
	object_event  9, 65, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_GENERICTRAINER, 1, TrainerHikerTimothy, -1
	object_event 11, 50, SPRITE_BLACK_BELT, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_GENERICTRAINER, 2, TrainerBlackbeltKenji, -1
	object_event 17, 18, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_GENERICTRAINER, 1, TrainerCooltrainermRyan, -1
	object_event  5, 36, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_GENERICTRAINER, 3, TrainerCooltrainerfKelly, -1
	object_event  4, 70, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_GENERICTRAINER, 3, TrainerCamperQuentin, -1
	object_event 13, 77, SPRITE_RAIKOU_OW, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, Route17StationaryRaikouScript, EVENT_ROUTE_17_RAIKOU
	object_event  5, 66, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, Route17Revive, EVENT_ROUTE_17_REVIVE
	object_event  6, 20, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, Route17Elixer, EVENT_ROUTE_17_ELIXER
	object_event  7, 33, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, Route17MaxPotion, EVENT_ROUTE_17_MAX_POTION
	object_event 16, 82, SPRITE_BERRY, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_ORANGE, OBJECTTYPE_SCRIPT, 0, Route17BerryTree1, EVENT_ROUTE_17_BERRY_1
	object_event 14, 82, SPRITE_BERRY, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, Route17BerryTree2, EVENT_ROUTE_17_BERRY_2
	object_event  6, 51, SPRITE_OTIS, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route17OtisScript, EVENT_MET_OTIS_TODAY

	object_const_def
	const ROUTE17_POKEFAN_M1
	const ROUTE17_POKEFAN_M2
	const ROUTE17_POKEFAN_M3
	const ROUTE17_POKEFAN_M4
	const ROUTE17_BLACK_BELT
	const ROUTE17_COOLTRAINER_M
	const ROUTE17_COOLTRAINER_F
	const ROUTE17_YOUNGSTER
	const ROUTE17_RAIKOU
	const ROUTE17_POKE_BALL1
	const ROUTE17_POKE_BALL2
	const ROUTE17_POKE_BALL3
	const ROUTE17_BERRY_TREE1
	const ROUTE17_BERRY_TREE2
	const ROUTE17_OTIS

Route17_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, .WeatherAndOtis

.WeatherAndOtis:
	random 4
	ifequal 0, .Sun
	ifequal 1, .Rain
	ifequal 2, .Sandstorm
	setval WEATHER_NONE
	writemem wFieldWeather

.CheckOtis
	; 10% chance of otis appearing
	checkflag ENGINE_MET_OTIS_TODAY
	iftrue .done
	random 10
	ifequal 0, .AppearOtis
.done
	disappear ROUTE17_OTIS
	endcallback

.Sun:
	setval WEATHER_SUN
	writemem wFieldWeather
	sjump .CheckOtis

.Rain:
	setval WEATHER_RAIN
	writemem wFieldWeather
	sjump .CheckOtis

.Sandstorm:
	setval WEATHER_SANDSTORM
	writemem wFieldWeather
	sjump .CheckOtis

.AppearOtis:
	appear ROUTE17_OTIS
	endcallback

TrainerBlackbeltKenji:
	generictrainer BLACKBELT_T, KENJI, EVENT_BEAT_BLACKBELT_KENJI, .SeenText, .BeatenText

.AfterText
	text "Rest is as impor-"
	line "tant as training."
	done

.SeenText
	text "I was training"
	line "here alone."

	para "Behold the fruits"
	line "of my labor!"
	done

.BeatenText
	text "Waaaargh!"
	done

TrainerHikerErik:
	generictrainer HIKER, ERIK, EVENT_BEAT_HIKER_ERIK, .SeenText, .BeatenText

.AfterText
	text "Learn and grow!"
	line "That's my motto."
	done

.SeenText
	text "Be prepared for"
	line "anything!"

	para "Let me see if your"
	line "#mon have been"
	cont "raised properly!"
	done

.BeatenText
	text "Oh, I lost that!"
	done

TrainerHikerMichael:
	generictrainer HIKER, MICHAEL, EVENT_BEAT_HIKER_MICHAEL, .SeenText, .BeatenText

.AfterText
	text "Boy, do I love"
	line "HP Up! Mmmm, yum!"

	para "I keep drinking my"
	line "#mon's!"

	para "I can't help it!"
	done

.SeenText
	text "Yo! You're spunky!"
	line "But you know what?"

	para "When it comes to"
	line "sheer spunkiness,"
	cont "I'm the man!"
	done

.BeatenText
	text "My #mon weren't"
	line "spunky enough!"
	done

TrainerHikerParry:
	generictrainer HIKER, PARRY, EVENT_BEAT_HIKER_PARRY, .SeenText, .BeatenText

.AfterText
	text "I'm not much good"
	line "at thinking, see?"

	para "So, I just plow"
	line "ahead with power!"
	done

.SeenText
	text "My #mon are"
	line "power packed!"
	done

.BeatenText
	text "Wahahah! I'm the"
	line "big loser!"
	done

TrainerHikerTimothy:
	generictrainer HIKER, TIMOTHY, EVENT_BEAT_HIKER_TIMOTHY, .SeenText, .BeatenText

.AfterText
	text "The best thing to"
	line "ever happen to me"
	cont "was discovering"
	cont "#mon."
	done

.SeenText
	text "Why do I climb"
	line "mountains?"

	para "Because they're"
	line "there."

	para "Why do I train"
	line "#mon?"

	para "Because they're"
	line "there!"
	done

.BeatenText
	text "Losses…"
	line "They're there too!"
	done

TrainerCooltrainermRyan:
	generictrainer COOLTRAINERM, RYAN, EVENT_BEAT_COOLTRAINERM_RYAN, .SeenText, .BeatenText

.AfterText
	text "I see you're rais-"
	line "ing your #mon"
	cont "with care."

	para "The bond you build"
	line "will save you in"
	cont "tough situations."
	done

.SeenText
	text "What are your"
	line "thoughts on rais-"
	cont "ing #mon?"
	done

.BeatenText
	text "You've won my"
	line "respect."
	done

TrainerCooltrainerfKelly:
	generictrainer COOLTRAINERF, KELLY, EVENT_BEAT_COOLTRAINERF_KELLY, .SeenText, .BeatenText

.AfterText
	text "I'm not in favor"
	line "of overly power-"
	cont "ful moves."

	para "I want to win, but"
	line "I also don't want"
	cont "to harm #mon."
	done

.SeenText
	text "What is your"
	line "battle strategy?"

	para "It is foolish to"
	line "use strong moves"
	cont "indiscriminately."
	done

.BeatenText
	text "Fine. I lost."
	done

TrainerCamperQuentin:
	generictrainer CAMPER, QUENTIN, EVENT_BEAT_CAMPER_QUENTIN, .SeenText, .BeatenText

.AfterText
	text "Have you been to"
	line "the Draft Arena?"

	para "I never, ever lose"
	line "there, but…"
	done

.SeenText
	text "I'm really, really"
	line "tough!"
	done

.BeatenText
	text "I was tough at the"
	line "Draft Arena…"
	done

Route17SignText:
	text "Route 17"
	line "Mountain Rd. Ahead"
	done

Route17StationaryRaikouScript:
	isfieldactionssettoquick
	iftrue .skipthis
	reanchormap
	pokepic RAIKOU
	cry RAIKOU
	waitbutton
	closepokepic
.skipthis
	showthistext
		text "Raikou: Rrrr!"
		done
	loadvar VAR_BATTLETYPE, BATTLETYPE_SUICUNE
	loadwildmon RAIKOU, 40
	startbattle
	disappear LAST_TALKED
	reloadmapafterbattle
	end

Route17Revive:
	itemball REVIVE
Route17Elixer:
	itemball ELIXER
Route17MaxPotion:
	itemball MAX_POTION

Route17BerryTree1:
	setval MIRACLEBERRY
	jumpstd BerryOrFruitScript
Route17BerryTree2:
	setval GOLD_BERRY
	jumpstd BerryOrFruitScript

Route17OtisScript:
	callstd WanderingOddEggNPCScript
	playsound SFX_WARP_TO
	applymovement ROUTE17_OTIS, Route17OtisTeleportAwayMovement
	disappear LAST_TALKED
	setflag ENGINE_MET_OTIS_TODAY
	end

Route17OtisTeleportAwayMovement:
	teleport_from
	step_end
