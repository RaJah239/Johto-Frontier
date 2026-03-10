Route12_MapEvents:
	def_warp_events
	warp_event  9,  5, ROUTE_12_POWER_PLANT_GATE, 1

	def_coord_events

	def_bg_events
	bg_event 14, 10, BGEVENT_JUMPTEXT, Route12SignText
	bg_event  7,  8, BGEVENT_ITEM + HYPER_POTION, EVENT_ROUTE_12_HIDDEN_HYPER_POTION

	def_object_events
	rocksmash_event  7, 11
	rocksmash_event  6,  9
	rocksmash_event  7,  8
	object_event  8, 10, SPRITE_BEAUTY, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, MonicaScript, EVENT_ROUTE_12_MONICA_OF_MONDAY
	object_event 14, 15, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_GENERICTRAINER, 4, TrainerSwimmermSimon, -1
	object_event 18, 30, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_GENERICTRAINER, 5, TrainerSwimmermRandall, -1
	object_event  3, 19, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_GENERICTRAINER, 4, TrainerSwimmerfElaine, -1
	object_event 10, 25, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_GENERICTRAINER, 3, TrainerSwimmerfPaula, -1
	object_event 11, 13, SPRITE_LASS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route12Lass1Text, -1
	object_event  7,  6, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route12PokefanMText, -1
	object_event 13,  4, SPRITE_LASS, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route12Lass2Text, -1

	object_const_def
	const ROUTE12_ROCK1
	const ROUTE12_ROCK2
	const ROUTE12_ROCK3
	const ROUTE12_MONICA
	const ROUTE12_SWIMMER_BOY1
	const ROUTE12_SWIMMER_BOY2
	const ROUTE12_SWIMMER_GIRL1
	const ROUTE12_SWIMMER_GIRL2
	const ROUTE12_LASS1
	const ROUTE12_POKEFAN_M
	const ROUTE12_LASS2

Route12_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, Route12MonicaCallback

Route12MonicaCallback:
	readvar VAR_WEEKDAY
	ifequal MONDAY, .MonicaAppears
	disappear ROUTE12_MONICA
	endcallback

.MonicaAppears:
	appear ROUTE12_MONICA
	endcallback

MonicaScript:
	faceplayeropentext
	checkevent EVENT_GOT_SHARP_BEAK_FROM_MONICA
	iftrue .Monday
	readvar VAR_WEEKDAY
	ifnotequal MONDAY, .NotMonday
	checkevent EVENT_MET_MONICA_OF_MONDAY
	iftrue .MetMonica
	writethistext
		text "Monica: Glad to"
		line "meet you. I'm"
		cont "Monica of Monday."
		done
	promptbutton
	setevent EVENT_MET_MONICA_OF_MONDAY
.MetMonica:
	writethistext
		text "As a token of our"
		line "friendship, I have"
		cont "a gift for you!"
		done
	promptbutton
	verbosegiveitem SHARP_BEAK
	iffalse_endtext
	setevent EVENT_GOT_SHARP_BEAK_FROM_MONICA
	jumpthisopenedtext
		text "Monica: It's an"
		line "item that raises"
		cont "the power of fly-"
		cont "ing-type moves."
		done

.Monday:
	jumpthisopenedtext
		text "Monica: My broth-"
		line "ers and sisters"
		cont "are all over the"
		cont "place."

		para "See if you could"
		line "find them all!"
		done

.NotMonday:
	jumpthisopenedtext
		text "Monica: I don't"
		line "think today is"
		cont "Monday. How sad…"
		done

TrainerSwimmerfElaine:
	generictrainer SWIMMERF, ELAINE, EVENT_BEAT_SWIMMERF_ELAINE, .SeenText, .BeatenText

.AfterText
	text "I'd say I'm a bet-"
	line "ter swimmer than"
	cont "you. Yeah!"
	done

.SeenText
	text "Are you going to"
	line "Cianwood?"

	para "How about a quick"
	line "battle first?"
	done

.BeatenText
	text "I lost that one!"
	done

TrainerSwimmerfPaula:
	generictrainer SWIMMERF, PAULA, EVENT_BEAT_SWIMMERF_PAULA, .SeenText, .BeatenText

.AfterText
	text "While I float like"
	line "this, the waves"
	cont "carry me along."
	done

.SeenText
	text "No inner tube for"
	line "me."

	para "I'm hanging on to"
	line "a sea #mon!"
	done

.BeatenText
	text "Ooh, I'm feeling"
	line "dizzy!"
	done

TrainerSwimmermSimon:
	generictrainer SWIMMERM, SIMON, EVENT_BEAT_SWIMMERM_SIMON, .SeenText, .BeatenText

.AfterText
	text "Cianwood City is"
	line "a good distance"
	cont "away from here."
	done

.SeenText
	text "You have to warm"
	line "up before going"
	cont "into the water."

	para "That's basic."
	done

.BeatenText
	text "OK! Uncle! I give!"
	done

TrainerSwimmermRandall:
	generictrainer SWIMMERM, RANDALL, EVENT_BEAT_SWIMMERM_RANDALL, .SeenText, .BeatenText

.AfterText
	text "Swimming exercises"
	line "your entire body."
	cont "It's healthy."
	done

.SeenText
	text "Hey, you're young"
	line "and fit!"

	para "Don't ride your"
	line "#mon! Swim!"
	done

.BeatenText
	text "Uh-oh. I lost…"
	done

Route12Lass1Text:
	text "Although you can't"
	line "see it from here,"

	para "Cianwood is across"
	line "the sea."
	done

Route12PokefanMText:
	text "The Power Plant"
	line "that supplies all"
	cont "of Johto with"
	cont "energy is ahead."
	done

Route12Lass2Text:
	text "I came to Olivine"
	line "by ship to see the"
	cont "sights and soak up"
	cont "the atmosphere."

	para "Being a port, it"
	line "feels so different"
	cont "from a big city."
	done

Route12SignText:
	text "Route 12"

	para "Cianwood City -"
	line "Olivine City"
	done
