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
	trainer CAMPER, TED, EVENT_BEAT_CAMPER_TED, CamperTedSeenText, CamperTedBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext CamperTedAfterBattleText
	waitbutton
	closetext
	end

TrainerPicnickerErin1:
	trainer PICNICKER, ERIN1, EVENT_BEAT_PICNICKER_ERIN, PicnickerErin1SeenText, PicnickerErin1BeatenText, 0, .Script

.Script:
	loadvar VAR_CALLERID, PHONE_PICNICKER_ERIN
	opentext
	checkevent EVENT_ERIN_CALCIUM
	iftrue .HasCalcium
	checkflag ENGINE_ERIN_READY_FOR_REMATCH
	iftrue .WantsBattle
	checkcellnum PHONE_PICNICKER_ERIN
	iftrue Route18NumberAcceptedF
	checkevent EVENT_ERIN_ASKED_FOR_PHONE_NUMBER
	iftrue .AskedAlready
	writetext PicnickerErinAfterBattleText
	promptbutton
	setevent EVENT_ERIN_ASKED_FOR_PHONE_NUMBER
	scall Route18AskNumber
	sjump .AskForNumber

.AskedAlready:
	scall Route18AskNumber
.AskForNumber:
	askforphonenumber PHONE_PICNICKER_ERIN
	ifequal PHONE_CONTACT_REFUSED, Route18NumberDeclinedF
	gettrainername STRING_BUFFER_3, PICNICKER, ERIN1
	scall Route18RegisteredNumberF
	sjump Route18NumberAcceptedF

.WantsBattle:
	scall Route18RematchF
	winlosstext PicnickerErin1BeatenText, 0
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftrue .LoadFight2
	checkevent EVENT_BEAT_ELITE_FOUR
	iftrue .LoadFight1
	loadtrainer PICNICKER, ERIN1
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_ERIN_READY_FOR_REMATCH
	end

.LoadFight1:
	loadtrainer PICNICKER, ERIN2
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_ERIN_READY_FOR_REMATCH
	end

.LoadFight2:
	loadtrainer PICNICKER, ERIN3
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_ERIN_READY_FOR_REMATCH
	scall Route18RematchGiftF
	verbosegiveitem CALCIUM
	iffalse ErinNoRoomForCalcium
	closetext
	end

.HasCalcium:
	writetext PicnickerErin_GiveCalciumAfterBattleAgain
	waitbutton
	verbosegiveitem CALCIUM
	iffalse ErinNoRoomForCalcium
	clearevent EVENT_ERIN_CALCIUM
	closetext
	end

Route18AskNumber:
	jumpstd AskNumber1FScript
	end

Route18RegisteredNumberF:
	jumpstd RegisteredNumberFScript
	end

Route18NumberAcceptedF:
	jumpstd NumberAcceptedFScript
	end

Route18NumberDeclinedF:
	jumpstd NumberDeclinedFScript
	end

Route18RematchF:
	jumpstd RematchFScript
	end

ErinNoRoomForCalcium:
	setevent EVENT_ERIN_CALCIUM
	jumpstd PackFullFScript
	end

Route18RematchGiftF:
	jumpstd RematchGiftFScript
	end

TrainerHikerBailey:
	trainer HIKER, BAILEY, EVENT_BEAT_HIKER_BAILEY, HikerBaileySeenText, HikerBaileyBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext HikerBaileyAfterBattleText
	waitbutton
	closetext
	end

Route18Sign:
	jumptext Route18SignText

Route18XSpeed:
	itemball HASTE_HERB

HikerBaileySeenText:
	text "Awright! I'll show"
	line "you the power of"
	cont "mountain #MON!"
	done

HikerBaileyBeatenText:
	text "Mercy! You showed"
	line "me your power!"
	done

HikerBaileyAfterBattleText:
	text "It's over. I don't"
	line "mind. We HIKERS"
	cont "are like that."
	done

CamperTedSeenText:
	text "I'm raising #-"
	line "MON too!"

	para "Will you battle"
	line "with me?"
	done

CamperTedBeatenText:
	text "Wha…?"
	done

CamperTedAfterBattleText:
	text "I did my best but"
	line "came up short."

	para "No excuses--I"
	line "admit I lost."
	done

PicnickerErin1SeenText:
	text "I raise #MON"
	line "too!"

	para "Will you battle"
	line "with me?"
	done

PicnickerErin1BeatenText:
	text "Oh, rats!"
	done

PicnickerErinAfterBattleText:
	text "I've been to many"
	line "GYMS, but the GYM"

	para "in GOLDENROD is my"
	line "favorite."

	para "It's filled with"
	line "pretty flowers!"
	done

PicnickerErin2BeatenText:
	text "Aww… I keep losing"
	line "all the time!"

	para "I'll just have to"
	line "try harder!"

	para "Anyway, thanks for"
	line "battling me again"

	para "and again. Here's"
	line "that present from"
	cont "the other time."
	done

PicnickerErin_GiveCalciumAfterBattleAgain:
	text "Nice! You're back"
	line "for my gift!"
	done

Route18SignText:
	text "ROUTE 18"
	line "MOUNTAIN RD. AHEAD"
	done

Route18BerryTree1:
	opentext
	getitemname STRING_BUFFER_3, PRZCUREBERRY
	writetext Route18TreeText
	promptbutton
	writetext Route18HeyItsBerryApricornText
	promptbutton
	giveitem PRZCUREBERRY
	iffalse Route18NoRoomInBag
	disappear ROUTE18_BERRY_TREE1
	writetext Route18FoundItemText
	playsound SFX_ITEM
	waitsfx
	itemnotify
	closetext
	end

Route18BerryTree2:
	opentext
	getitemname STRING_BUFFER_3, BITTER_BERRY
	writetext Route18TreeText
	promptbutton
	writetext Route18HeyItsBerryApricornText
	promptbutton
	giveitem BITTER_BERRY
	iffalse Route18NoRoomInBag
	disappear ROUTE18_BERRY_TREE2
	writetext Route18FoundItemText
	playsound SFX_ITEM
	waitsfx
	itemnotify
	closetext
	end

Route18BerryTree3:
	opentext
	getitemname STRING_BUFFER_3, BERRY
	writetext Route18TreeText
	promptbutton
	writetext Route18HeyItsBerryApricornText
	promptbutton
	giveitem BERRY
	iffalse Route18NoRoomInBag
	disappear ROUTE18_BERRY_TREE3
	writetext Route18FoundItemText
	playsound SFX_ITEM
	waitsfx
	itemnotify
	closetext
	end

Route18BerryTree4:
	opentext
	getitemname STRING_BUFFER_3, PSNCUREBERRY
	writetext Route18TreeText
	promptbutton
	writetext Route18HeyItsBerryApricornText
	promptbutton
	giveitem PSNCUREBERRY
	iffalse Route18NoRoomInBag
	disappear ROUTE18_BERRY_TREE4
	writetext Route18FoundItemText
	playsound SFX_ITEM
	waitsfx
	itemnotify
	closetext
	end

Route18NoBerryOrApricorn:
	opentext
	writetext Route18TreeText
	promptbutton
	writetext Route18NothingHereText
	waitbutton
	closetext
	end

Route18NoRoomInBag:
	writetext Route18NoRoomInBagText
	waitbutton
	closetext
	end

Route18TreeText:
	text_far _FruitBearingTreeText
	text_end

Route18NothingHereText:
	text_far _NothingHereText
	text_end

Route18HeyItsBerryApricornText:
	text_far _HeyItsFruitText
	text_end

Route18FoundItemText:
	text_far _ObtainedFruitText
	text_end

Route18NoRoomInBagText:
	text_far _CantCarryItemText
	text_end

Route18_MapEvents:
	def_warp_events
	warp_event  7, 33, ROUTE_1_ROUTE_18_GATE, 1
	warp_event  8, 33, ROUTE_1_ROUTE_18_GATE, 2
	warp_event 14,  5, DARK_CAVE_VIOLET_ENTRANCE, 3

	def_coord_events

	def_bg_events
	bg_event  9, 27, BGEVENT_READ, Route18Sign
	bg_event  7,  5, BGEVENT_READ, Route18NoBerryOrApricorn
	bg_event  8,  6, BGEVENT_READ, Route18NoBerryOrApricorn
	bg_event  7,  6, BGEVENT_READ, Route18NoBerryOrApricorn
	bg_event  8,  5, BGEVENT_READ, Route18NoBerryOrApricorn

	def_object_events
	object_event 12, 19, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 2, TrainerHikerBailey, -1
	object_event  4, 14, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 2, TrainerCamperTed, -1
	object_event  2, 13, SPRITE_LASS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 2, TrainerPicnickerErin1, -1
	object_event  2, 18, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, Route18XSpeed, EVENT_ROUTE_18_X_SPEED
	object_event  7,  5, SPRITE_BERRY, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, Route18BerryTree1, EVENT_ROUTE_18_BERRY_1
	object_event  8,  6, SPRITE_BERRY, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_YELLOW, OBJECTTYPE_SCRIPT, 0, Route18BerryTree2, EVENT_ROUTE_18_BERRY_2
	object_event  7,  6, SPRITE_BERRY, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, Route18BerryTree3, EVENT_ROUTE_18_BERRY_3
	object_event  8,  5, SPRITE_BERRY, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, Route18BerryTree4, EVENT_ROUTE_18_BERRY_4
