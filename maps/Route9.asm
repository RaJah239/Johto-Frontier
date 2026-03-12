Route9_MapEvents:
	def_warp_events

	def_coord_events

	def_bg_events
	bg_event  5,  3, BGEVENT_JUMPTEXT, Route9SignText
	bg_event  4,  2, BGEVENT_ITEM + ETHER, EVENT_ROUTE_9_HIDDEN_ETHER
	bg_event 13,  5, BGEVENT_JUMPSTD, NO_BERRY_OR_FRUIT_SCRIPT
	bg_event 16,  5, BGEVENT_JUMPSTD, NO_BERRY_OR_FRUIT_SCRIPT
	bg_event 15,  7, BGEVENT_JUMPSTD, NO_BERRY_OR_FRUIT_SCRIPT

	def_object_events
	object_event  6, 12, SPRITE_TWIN, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_GENERICTRAINER, 1, TrainerTwinsAnnandanne1, -1
	object_event  7, 12, SPRITE_TWIN, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_GENERICTRAINER, 1, TrainerTwinsAnnandanne2, -1
	object_event  6,  6, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_GENERICTRAINER, 1, TrainerPsychicGreg, -1
	object_event 16,  8, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SunnyScript, EVENT_ROUTE_9_SUNNY_OF_SUNDAY
	object_event 13,  5, SPRITE_APRICORN, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, Route9ApricornTree1, EVENT_ROUTE_9_APRICORN_1
	object_event 16,  5, SPRITE_APRICORN, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, Route9ApricornTree2, EVENT_ROUTE_9_APRICORN_2
	object_event 15,  7, SPRITE_APRICORN, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_YELLOW, OBJECTTYPE_SCRIPT, 0, Route9ApricornTree3, EVENT_ROUTE_9_APRICORN_3

	object_const_def
	const ROUTE9_TWIN1
	const ROUTE9_TWIN2
	const ROUTE9_YOUNGSTER
	const ROUTE9_SUNNY
	const ROUTE9_APRICORN_TREE1
	const ROUTE9_APRICORN_TREE2
	const ROUTE9_APRICORN_TREE3

Route9_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, Route9SunnyCallback

Route9SunnyCallback:
	readvar VAR_WEEKDAY
	ifequal SUNDAY, .SunnyAppears
	disappear ROUTE9_SUNNY
	endcallback

.SunnyAppears:
	appear ROUTE9_SUNNY
	endcallback

TrainerTwinsAnnandanne1:
	generictrainer TWINS, ANNANDANNE1, EVENT_BEAT_TWINS_ANN_AND_ANNE, .SeenText, .BeatenText

.AfterText
	text "Ann: I can tell"
	line "what my sister and"
	cont "my #mon are"
	cont "thinking."
	done

.SeenText
	text "Ann: Anne and I"
	line "are in this to-"
	cont "gether!"
	done

.BeatenText
	text "Ann & Anne: Nnn… A"
	line "little too strong."
	done

TrainerTwinsAnnandanne2:
	generictrainer TWINS, ANNANDANNE2, EVENT_BEAT_TWINS_ANN_AND_ANNE, .SeenText, .BeatenText

.AfterText
	text "Anne: We share the"
	line "same feelings as"
	cont "our #mon."
	done

.SeenText
	text "Anne: Ann and I"
	line "are in this to-"
	cont "gether!"
	done

.BeatenText
	text "Ann & Anne: Nnn… A"
	line "little too strong."
	done

TrainerPsychicGreg:
	generictrainer PSYCHIC_T, GREG, EVENT_BEAT_PSYCHIC_GREG, .SeenText, .BeatenText

.AfterText
	text "Putting #mon to"
	line "sleep or paralyz-"
	cont "ing them are good"
	cont "battle techniques."
	done

.SeenText
	text "#mon can't do a"
	line "thing if they are"
	cont "asleep."

	para "I'll show you how"
	line "scary that is!"
	done

.BeatenText
	text "I lost. That's"
	line "pretty sad…"
	done

SunnyScript:
	faceplayeropentext
	checkevent EVENT_GOT_MAGNET_FROM_SUNNY
	iftrue SunnySundayScript
	readvar VAR_WEEKDAY
	ifnotequal SUNDAY, SunnyNotSundayScript
	checkevent EVENT_MET_SUNNY_OF_SUNDAY
	iftrue .MetSunny
	writethistext
		text "Sunny: Hi!"

		para "I'm Sunny of Sun-"
		line "day, meaning it's"
		cont "Sunday today!"
		done
	promptbutton
	setevent EVENT_MET_SUNNY_OF_SUNDAY
.MetSunny:
	writethistext
		text "I was told to give"
		line "you this if I saw"
		cont "you!"
		done
	promptbutton
	verbosegiveitem MAGNET
	iffalse_endtext
	setevent EVENT_GOT_MAGNET_FROM_SUNNY
	jumpthisopenedtext
		text "Sunny: That thing…"

		para "Um…"

		para "… What was it now…"

		para "…"

		para "Oh! I remember"
		line "now!"

		para "A #mon that"
		line "knows electric"
		cont "moves should hold"
		cont "it."

		para "My sis Monica said"
		line "it powers up"
		cont "electric moves!"
		done

SunnySundayScript:
	jumpthisopenedtext
		text "Sunny: My sisters"
		line "and brothers are"
		cont "Monica, Tuscany,"
		cont "Wesley, Arthur,"
		cont "Frieda and Santos."

		para "They're all older"
		line "than me!"
		done

SunnyNotSundayScript:
	jumpthisopenedtext
		text "Sunny: Isn't today"
		line "Sunday?"
		
		para "Um… I forgot!"
		done

Route9SignText:
	text "Route 9"
	done

Route9ApricornTree1:
	setval RED_APRICORN
	jumpstd BerryOrFruitScript
Route9ApricornTree2:
	setval BLU_APRICORN
	jumpstd BerryOrFruitScript
Route9ApricornTree3:
	setval YLW_APRICORN
	jumpstd BerryOrFruitScript
