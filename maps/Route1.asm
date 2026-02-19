Route1_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, Route1TuscanyCallback

Route1_MapEvents:
	def_warp_events
	warp_event 27,  1, ROUTE_1_ROUTE_18_GATE, 3

	def_coord_events

	def_bg_events
	bg_event 51,  7, BGEVENT_JUMPTEXT, Route1Sign1Text
	bg_event  3,  5, BGEVENT_JUMPTEXT, Route1Sign2Text
	bg_event 12,  2, BGEVENT_JUMPSTD, NO_BERRY_OR_FRUIT_SCRIPT
	bg_event 13,  3, BGEVENT_JUMPSTD, NO_BERRY_OR_FRUIT_SCRIPT
	bg_event 24, 12, BGEVENT_JUMPSTD, NO_BERRY_OR_FRUIT_SCRIPT

	def_object_events
	object_event 50, 12, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, CatchingTutorialDudeScript, -1
	object_event 27, 16, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 1, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route1YoungsterText, -1
	object_event 15, 11, SPRITE_TEACHER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route1TeacherText, -1
	object_event 25,  3, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route1FisherText, -1
	object_event 14,  4, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, Route1CooltrainerMScript, -1
	object_event 29, 12, SPRITE_TEACHER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, TuscanyScript, EVENT_ROUTE_1_TUSCANY_OF_TUESDAY
	object_event 48,  2, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, Route1Potion, EVENT_ROUTE_1_POTION
	object_event 12,  2, SPRITE_APRICORN, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, Route1PinkApricornTree, EVENT_ROUTE_1_APRICORN
	object_event 13,  3, SPRITE_BERRY, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, Route1BerryTree1, EVENT_ROUTE_1_BERRY1
	object_event 24,  12, SPRITE_BERRY, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, Route1BerryTree2, EVENT_ROUTE_1_BERRY2

	object_const_def
	const ROUTE1_COOLTRAINER_M1
	const ROUTE1_YOUNGSTER
	const ROUTE1_TEACHER1
	const ROUTE1_FISHER
	const ROUTE1_COOLTRAINER_M2
	const ROUTE1_TUSCANY
	const ROUTE1_POKE_BALL
	const ROUTE1_APRICORN1
	const ROUTE1_BERRY1
	const ROUTE1_BERRY2

Route1TuscanyCallback:
	readvar VAR_WEEKDAY
	ifnotequal TUESDAY, .TuscanyDisappears
	appear ROUTE1_TUSCANY
	endcallback

.TuscanyDisappears:
	disappear ROUTE1_TUSCANY
	endcallback

CatchingTutorialDudeScript:
	faceplayer
	opentext
	writetext CatchingTutorialRepeatText
	yesorno
	iffalse .Declined
	closetext
	checktime MORN | DAY
	iftrue .day_morn
	loadwildmon HOOTHOOT, 5
.loaded_mon:
	catchtutorial BATTLETYPE_TUTORIAL
	opentext
	writetext CatchingTutorialDebriefText
	waitbutton
	closetext
	end

.day_morn:
	loadwildmon BUNEARY, 5
	sjump .loaded_mon

.Declined:
	writetext CatchingTutorialDeclinedText
	waitbutton
	closetext
	end

Route1CooltrainerMScript:
	checktime DAY
	iftrue_jumptextfaceplayer .day
	checktime EVE | NITE
	iftrue_jumptextfaceplayer .evening_night
	jumpthistextfaceplayer
.morning
	text "I'm waiting for"
	line "#mon that"
	cont "appear only in the"
	cont "daytime."
	done

.day
	text "I'm waiting for"
	line "#mon that"
	cont "appear only at"
	cont "evening or night."
	done

.evening_night
	text "I'm waiting for"
	line "#mon that"
	cont "appear only in the"
	cont "morning."
	done

TuscanyScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_PINK_BOW_FROM_TUSCANY
	iftrue TuscanyTuesdayScript
	readvar VAR_WEEKDAY
	ifnotequal TUESDAY, TuscanyNotTuesdayScript
	checkevent EVENT_MET_TUSCANY_OF_TUESDAY
	iftrue .MetTuscany
	writetext MeetTuscanyText
	promptbutton
	setevent EVENT_MET_TUSCANY_OF_TUESDAY
.MetTuscany:
	writetext TuscanyGivesGiftText
	promptbutton
	verbosegiveitem PINK_BOW
	iffalse TuscanyDoneScript
	setevent EVENT_GOT_PINK_BOW_FROM_TUSCANY
	writetext TuscanyGaveGiftText
	waitbutton
	closetext
	end

TuscanyTuesdayScript:
	writetext TuscanyTuesdayText
	waitbutton
TuscanyDoneScript:
	closetext
	end

TuscanyNotTuesdayScript:
	writetext TuscanyNotTuesdayText
	waitbutton
	closetext
	end

Route1Potion:
	itemball POTION

CatchingTutorialDebriefText:
	text "That's how you do"
	line "it."

	para "If you weaken them"
	line "first, #MON are"
	cont "easier to catch."
	done

CatchingTutorialDeclinedText:
	text "#MON hide in"
	line "the grass. Who"

	para "knows when they'll"
	line "pop out…"
	done

CatchingTutorialRepeatText:
	text "Huh? You want me"
	line "to show you how to"
	cont "catch #MON?"
	done

Route1YoungsterText:
	text "Yo. How are your"
	line "#MON?"

	para "If they're weak"
	line "and not ready for"

	para "battle, keep out"
	line "of the grass."
	done

Route1TeacherText:
	text "See those ledges?"
	line "It's scary to jump"
	cont "off them."

	para "But you can go to"
	line "NEW BARK without"

	para "walking through"
	line "the grass."
	done

Route1FisherText:
	text "I wanted to take a"
	line "break, so I saved"

	para "to record my"
	line "progress."
	done

MeetTuscanyText:
	text "TUSCANY: I do be-"
	line "lieve that this is"

	para "the first time"
	line "we've met?"

	para "Please allow me to"
	line "introduce myself."

	para "I am TUSCANY of"
	line "Tuesday."
	done

TuscanyGivesGiftText:
	text "By way of intro-"
	line "duction, please"

	para "accept this gift,"
	line "a PINK BOW."
	done

TuscanyGaveGiftText:
	text "TUSCANY: Wouldn't"
	line "you agree that it"
	cont "is most adorable?"

	para "It strengthens"
	line "normal-type moves."

	para "I am certain it"
	line "will be of use."
	done

TuscanyTuesdayText:
	text "TUSCANY: Have you"
	line "met MONICA, my"
	cont "older sister?"

	para "Or my younger"
	line "brother, WESLEY?"

	para "I am the second of"
	line "seven children."
	done

TuscanyNotTuesdayText:
	text "TUSCANY: Today is"
	line "not Tuesday. That"
	cont "is unfortunate…"
	done

Route1Sign1Text:
	text "ROUTE 1"

	para "CHERRYGROVE CITY -"
	line "NEW BARK TOWN"
	done

Route1Sign2Text:
	text "ROUTE 1"

	para "CHERRYGROVE CITY -"
	line "NEW BARK TOWN"
	done

Route1PinkApricornTree:
	setval PNK_APRICORN
	setlasttalked ROUTE1_APRICORN1
	jumpstd BerryOrFruitScript

Route1BerryTree1:
	setval BERRY
	setlasttalked ROUTE1_BERRY1
	jumpstd BerryOrFruitScript

Route1BerryTree2:
	setval BERRY
	setlasttalked ROUTE1_BERRY2
	jumpstd BerryOrFruitScript
