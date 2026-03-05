Route5_MapEvents:
	def_warp_events
	warp_event 11,  9, UNION_CAVE_1F, 3

	def_coord_events

	def_bg_events
	bg_event 11, 11, BGEVENT_JUMPTEXT, Route5SignText
	bg_event  7, 11, BGEVENT_JUMPSTD, NO_BERRY_OR_FRUIT_SCRIPT
	bg_event  7, 12, BGEVENT_JUMPSTD, NO_BERRY_OR_FRUIT_SCRIPT
	bg_event 12, 16, BGEVENT_JUMPSTD, NO_BERRY_OR_FRUIT_SCRIPT
	bg_event 13, 16, BGEVENT_JUMPSTD, NO_BERRY_OR_FRUIT_SCRIPT
	bg_event 14, 16, BGEVENT_JUMPSTD, NO_BERRY_OR_FRUIT_SCRIPT

	def_object_events
	object_event  6, 13, SPRITE_POKEFAN_M, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_GENERICTRAINER, 2, TrainerHikerAnthony, -1
	object_event  9, 14, SPRITE_LASS, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route5LassText, -1
	object_event  7, 11, SPRITE_BERRY, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, Route5BerryTree1, EVENT_ROUTE_5_BERRY_1
	object_event  7, 12, SPRITE_BERRY, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_PURPLE, OBJECTTYPE_SCRIPT, 0, Route5BerryTree2, EVENT_ROUTE_5_BERRY_2
	object_event 12, 16, SPRITE_APRICORN, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, Route5ApricornTree1, EVENT_ROUTE_5_APRICORN_1
	object_event 13, 16, SPRITE_APRICORN, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, Route5ApricornTree2, EVENT_ROUTE_5_APRICORN_2
	object_event 14, 16, SPRITE_APRICORN, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, Route5ApricornTree3, EVENT_ROUTE_5_APRICORN_3

	object_const_def
	const ROUTE5_POKEFAN_M
	const ROUTE5_LASS
	const ROUTE5_BERRY_TREE1
	const ROUTE5_BERRY_TREE2
	const ROUTE5_APRICORN_TREE1
	const ROUTE5_APRICORN_TREE2
	const ROUTE5_APRICORN_TREE3

Route5_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, .Weather

.Weather:
	setval WEATHER_RAIN
	writemem wFieldWeather
	endcallback

TrainerHikerAnthony:
	generictrainer HIKER, ANTHONY2, EVENT_BEAT_HIKER_ANTHONY, HikerAnthony2SeenText, HikerAnthony2BeatenText, 0, .Script

HikerAnthony2SeenText:
	text "I came through the"
	line "tunnel, but I"

	para "still have plenty"
	line "of energy left."
	done

HikerAnthony2BeatenText:
	text "Whoa! You've got"
	line "more zip than me!"
	done

HikerAnthony2AfterText:
	text "We HIKERS are at"
	line "our best in the"
	cont "mountains."
	done

.Script:
	loadvar VAR_CALLERID, PHONE_HIKER_ANTHONY
	opentext
	checkevent EVENT_ANTHONY_BERRY_JUICE
	iftrue .RematchGift
	checkflag ENGINE_ANTHONY_READY_FOR_REMATCH
	iftrue .Rematch
	checkcellnum PHONE_HIKER_ANTHONY
	iftrue .NumberAccepted
	checkevent EVENT_ANTHONY_ASKED_FOR_PHONE_NUMBER
	iftrue .AskAgain
	writetext HikerAnthony2AfterText
	promptbutton
	setevent EVENT_ANTHONY_ASKED_FOR_PHONE_NUMBER
	scall .AskNumber
	sjump .AskForPhoneNumber

.AskAgain:
	scall .AskNumber
.AskForPhoneNumber:
	askforphonenumber PHONE_HIKER_ANTHONY
	ifequal PHONE_CONTACT_REFUSED, .NumberDeclined
	gettrainername STRING_BUFFER_3, HIKER, ANTHONY2
	scall .RegisteredNumber
	sjump .NumberAccepted

.Rematch:
	scall .RematchStd
	winlosstext HikerAnthony2BeatenText, 0
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftrue .LoadFight4
	checkevent EVENT_BEAT_ELITE_FOUR
	iftrue .LoadFight3
	checkevent EVENT_CLEARED_RADIO_TOWER
	iftrue .LoadFight2
	checkflag ENGINE_FLYPOINT_OLIVINE
	iftrue .LoadFight1
	loadtrainer HIKER, ANTHONY2
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_ANTHONY_READY_FOR_REMATCH
	end

.LoadFight1:
	loadtrainer HIKER, ANTHONY1
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_ANTHONY_READY_FOR_REMATCH
	end

.LoadFight2:
	loadtrainer HIKER, ANTHONY3
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_ANTHONY_READY_FOR_REMATCH
	end

.LoadFight3:
	loadtrainer HIKER, ANTHONY4
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_ANTHONY_READY_FOR_REMATCH
	end

.LoadFight4:
	loadtrainer HIKER, ANTHONY5
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_ANTHONY_READY_FOR_REMATCH
	opentext
	writetext HikerAnthony_GiveBerryJuiceAfterBattleText
	waitbutton
	verbosegiveitem BERRY_JUICE
	iffalse .PackFull
	closetext
	end

.RematchGift
	writetext HikerAnthony_AgainGiveBerryJuiceAfterBattleText
	waitbutton
	verbosegiveitem BERRY_JUICE
	iffalse .PackFull
	clearevent EVENT_ANTHONY_BERRY_JUICE
	closetext
	end

.PackFull:
	setevent EVENT_ANTHONY_BERRY_JUICE
	jumpstd PackFullMScript
	end

.AskNumber:
	jumpstd AskNumberMScript
	end

.RegisteredNumber:
	jumpstd RegisteredNumberMScript
	end

.NumberAccepted:
	jumpstd NumberAcceptedMScript
	end

.NumberDeclined:
	jumpstd NumberDeclinedMScript
	end

.RematchStd:
	jumpstd RematchMScript
	end

HikerAnthony_GiveBerryJuiceAfterBattleText:
	text "I found this in"
	line "the mountains."
	
	para "Go on, take it!"
	done

HikerAnthony_AgainGiveBerryJuiceAfterBattleText:
	text "Ready to collect"
	line "it? Go on now."
	done

Route5LassText:
	text "Pant, pant…"

	para "I finally got"
	line "through that cave."

	para "It was much bigger"
	line "than I'd expected."

	para "I got too tired to"
	line "explore the whole"
	cont "thing, so I came"
	cont "outside."
	done

Route5SignText:
	text "Route 5"
	done

Route5BerryTree1:
	giveitem PSNCUREBERRY
	disappear ROUTE5_BERRY_TREE1

Route5BerryTree2:
	setval MINT_BERRY
	setlasttalked ROUTE5_BERRY_TREE2
	jumpstd BerryOrFruitScript
Route5ApricornTree1:
	setval RED_APRICORN
	setlasttalked ROUTE5_APRICORN_TREE1
	jumpstd BerryOrFruitScript
Route5ApricornTree2:
	setval BLU_APRICORN
	setlasttalked ROUTE5_APRICORN_TREE2
	jumpstd BerryOrFruitScript
Route5ApricornTree3:
	setval GRN_APRICORN
	setlasttalked ROUTE5_APRICORN_TREE3
	jumpstd BerryOrFruitScript
