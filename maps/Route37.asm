	object_const_def
	const ROUTE37_WEIRD_TREE1
	const ROUTE37_WEIRD_TREE2
	const ROUTE37_YOUNGSTER
	const ROUTE37_SUNNY
	const ROUTE37_APRICORN_TREE1
	const ROUTE37_APRICORN_TREE2
	const ROUTE37_APRICORN_TREE3

Route37_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, Route37SunnyCallback

Route37SunnyCallback:
	readvar VAR_WEEKDAY
	ifequal SUNDAY, .SunnyAppears
	disappear ROUTE37_SUNNY
	endcallback

.SunnyAppears:
	appear ROUTE37_SUNNY
	endcallback

TrainerTwinsAnnandanne1:
	trainer TWINS, ANNANDANNE1, EVENT_BEAT_TWINS_ANN_AND_ANNE, TwinsAnnandanne1SeenText, TwinsAnnandanne1BeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext TwinsAnnandanne1AfterBattleText
	waitbutton
	closetext
	end

TrainerTwinsAnnandanne2:
	trainer TWINS, ANNANDANNE2, EVENT_BEAT_TWINS_ANN_AND_ANNE, TwinsAnnandanne2SeenText, TwinsAnnandanne2BeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext TwinsAnnandanne2AfterBattleText
	waitbutton
	closetext
	end

TrainerPsychicGreg:
	trainer PSYCHIC_T, GREG, EVENT_BEAT_PSYCHIC_GREG, PsychicGregSeenText, PsychicGregBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext PsychicGregAfterBattleText
	waitbutton
	closetext
	end

SunnyScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_MAGNET_FROM_SUNNY
	iftrue SunnySundayScript
	readvar VAR_WEEKDAY
	ifnotequal SUNDAY, SunnyNotSundayScript
	checkevent EVENT_MET_SUNNY_OF_SUNDAY
	iftrue .MetSunny
	writetext MeetSunnyText
	promptbutton
	setevent EVENT_MET_SUNNY_OF_SUNDAY
.MetSunny:
	checkflag ENGINE_PLAYER_IS_FEMALE
	iftrue .Kris
	writetext SunnyGivesGiftText1
	promptbutton
	sjump .next
.Kris:
	writetext SunnyGivesGiftText2
	promptbutton
.next
	verbosegiveitem MAGNET
	iffalse SunnyDoneScript
	setevent EVENT_GOT_MAGNET_FROM_SUNNY
	writetext SunnyGaveGiftText
	waitbutton
	closetext
	end

SunnySundayScript:
	writetext SunnySundayText
	waitbutton
SunnyDoneScript:
	closetext
	end

SunnyNotSundayScript:
	writetext SunnyNotSundayText
	waitbutton
	closetext
	end

Route37Sign:
	jumptext Route37SignText

Route37HiddenEther:
	hiddenitem ETHER, EVENT_ROUTE_37_HIDDEN_ETHER

TwinsAnnandanne1SeenText:
	text "ANN: ANNE and I"
	line "are in this to-"
	cont "gether!"
	done

TwinsAnnandanne1BeatenText:
	text "ANN & ANNE: Nnn… A"
	line "little too strong."
	done

TwinsAnnandanne1AfterBattleText:
	text "ANN: I can tell"
	line "what my sister and"

	para "my #MON are"
	line "thinking."
	done

TwinsAnnandanne2SeenText:
	text "ANNE: ANN and I"
	line "are in this to-"
	cont "gether!"
	done

TwinsAnnandanne2BeatenText:
	text "ANN & ANNE: Nnn… A"
	line "little too strong."
	done

TwinsAnnandanne2AfterBattleText:
	text "ANNE: We share the"
	line "same feelings as"
	cont "our #MON."
	done

PsychicGregSeenText:
	text "#MON can't do a"
	line "thing if they are"
	cont "asleep."

	para "I'll show you how"
	line "scary that is!"
	done

PsychicGregBeatenText:
	text "I lost. That's"
	line "pretty sad…"
	done

PsychicGregAfterBattleText:
	text "Putting #MON to"
	line "sleep or paralyz-"
	cont "ing them are good"
	cont "battle techniques."
	done

MeetSunnyText:
	text "SUNNY: Hi!"

	para "I'm SUNNY of Sun-"
	line "day, meaning it's"
	cont "Sunday today!"
	done

SunnyGivesGiftText1:
	text "I was told to give"
	line "you this if I saw"
	cont "you!"
	done

SunnyGivesGiftText2:
	text "I was told to give"
	line "you this if I saw"
	cont "you!"
	done

SunnyGaveGiftText:
	text "SUNNY: That thing…"

	para "Um…"

	para "… What was it now…"

	para "…"

	para "Oh! I remember"
	line "now!"

	para "A #MON that"
	line "knows electric"

	para "moves should hold"
	line "it."

	para "My sis MONICA said"
	line "it powers up"
	cont "electric moves!"
	done

SunnySundayText:
	text "SUNNY: My sisters"
	line "and brothers are"
	cont "MONICA, TUSCANY,"
	cont "WESLEY, ARTHUR,"
	cont "FRIEDA and SANTOS."

	para "They're all older"
	line "than me!"
	done

SunnyNotSundayText:
	text "SUNNY: Isn't today"
	line "Sunday?"
	cont "Um… I forgot!"
	done

Route37SignText:
	text "ROUTE 37"
	done

Route37ApricornTree1:
	opentext
	getitemname STRING_BUFFER_3, RED_APRICORN
	writetext Route37TreeText
	promptbutton
	writetext Route37HeyItsBerryApricornText
	promptbutton
	giveitem RED_APRICORN
	iffalse Route37NoRoomInBag
	disappear ROUTE37_APRICORN_TREE1
	writetext Route37FoundItemText
	playsound SFX_ITEM
	waitsfx
	itemnotify
	closetext
	end

Route37ApricornTree2:
	opentext
	getitemname STRING_BUFFER_3, BLU_APRICORN
	writetext Route37TreeText
	promptbutton
	writetext Route37HeyItsBerryApricornText
	promptbutton
	giveitem BLU_APRICORN
	iffalse Route37NoRoomInBag
	disappear ROUTE37_APRICORN_TREE2
	writetext Route37FoundItemText
	playsound SFX_ITEM
	waitsfx
	itemnotify
	closetext
	end

Route37ApricornTree3:
	opentext
	getitemname STRING_BUFFER_3, YLW_APRICORN
	writetext Route37TreeText
	promptbutton
	writetext Route37HeyItsBerryApricornText
	promptbutton
	giveitem YLW_APRICORN
	iffalse Route37NoRoomInBag
	disappear ROUTE37_APRICORN_TREE3
	writetext Route37FoundItemText
	playsound SFX_ITEM
	waitsfx
	itemnotify
	closetext
	end

Route37NoBerryOrApricorn:
	opentext
	writetext Route37TreeText
	promptbutton
	writetext Route37NothingHereText
	waitbutton
	closetext
	end

Route37NoRoomInBag:
	writetext Route37NoRoomInBagText
	waitbutton
	closetext
	end

Route37TreeText:
	text_far _FruitBearingTreeText
	text_end

Route37NothingHereText:
	text_far _NothingHereText
	text_end

Route37HeyItsBerryApricornText:
	text_far _HeyItsFruitText
	text_end

Route37FoundItemText:
	text_far _ObtainedFruitText
	text_end

Route37NoRoomInBagText:
	text_far _CantCarryItemText
	text_end

Route37_MapEvents:
	def_warp_events

	def_coord_events

	def_bg_events
	bg_event  5,  3, BGEVENT_READ, Route37Sign
	bg_event  4,  2, BGEVENT_ITEM, Route37HiddenEther
	bg_event 13,  5, BGEVENT_READ, Route37NoBerryOrApricorn
	bg_event 16,  5, BGEVENT_READ, Route37NoBerryOrApricorn
	bg_event 15,  7, BGEVENT_READ, Route37NoBerryOrApricorn

	def_object_events
	object_event  6, 12, SPRITE_TWIN, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 1, TrainerTwinsAnnandanne1, -1
	object_event  7, 12, SPRITE_TWIN, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 1, TrainerTwinsAnnandanne2, -1
	object_event  6,  6, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 1, TrainerPsychicGreg, -1
	object_event 16,  8, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SunnyScript, EVENT_ROUTE_37_SUNNY_OF_SUNDAY
	object_event 13,  5, SPRITE_APRICORN, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, Route37ApricornTree1, EVENT_ROUTE_37_APRICORN_1
	object_event 16,  5, SPRITE_APRICORN, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, Route37ApricornTree2, EVENT_ROUTE_37_APRICORN_2
	object_event 15,  7, SPRITE_APRICORN, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_YELLOW, OBJECTTYPE_SCRIPT, 0, Route37ApricornTree3, EVENT_ROUTE_37_APRICORN_3
