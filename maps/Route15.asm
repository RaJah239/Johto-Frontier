Route15_MapEvents:
	def_warp_events
	warp_event  9, 51, ROUTE_15_MAHOGANY_GATE, 1
	warp_event 10, 51, ROUTE_15_MAHOGANY_GATE, 2
	warp_event 17, 35, ROUTE_15_GATE, 3
	warp_event 17, 31, ROUTE_15_GATE, 1
	warp_event 18, 31, ROUTE_15_GATE, 2

	def_coord_events

	def_bg_events
	bg_event 13,  3, BGEVENT_JUMPTEXT, Route15Sign1Text
	bg_event 11, 49, BGEVENT_JUMPTEXT, Route15Sign2Text
	bg_event 16, 38, BGEVENT_JUMPTEXT, Route15TrainerTipsText
	bg_event  1, 27, BGEVENT_JUMPSTD, NO_BERRY_OR_FRUIT_SCRIPT
	bg_event  0, 26, BGEVENT_JUMPSTD, NO_BERRY_OR_FRUIT_SCRIPT

	def_object_events
	object_event 13,  5, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_GENERICTRAINER, 2, TrainerPokemaniacBen, -1
	object_event 13, 20, SPRITE_SUPER_NERD, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerPokemaniacBrent, -1
	object_event 14,  7, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_GENERICTRAINER, 2, TrainerPokemaniacRon, -1
	object_event  4, 16, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_GENERICTRAINER, 4, TrainerFisherMarvin, -1
	object_event  9, 25, SPRITE_LASS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 2, TrainerPicnickerTiffany, -1
	object_event 13, 40, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_GENERICTRAINER, 3, TrainerCamperSpencer, -1
	object_event 12, 32, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, Route15MaxEther, EVENT_ROUTE_15_MAX_ETHER
	object_event  1, 27, SPRITE_BERRY, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_YELLOW, OBJECTTYPE_SCRIPT, 0, Route15BerryTree1, EVENT_ROUTE_15_BERRY_1
	object_event  0, 26, SPRITE_APRICORN, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, Route15ApricornTree1, EVENT_ROUTE_15_APRICORN_1

	object_const_def
	const ROUTE15_SUPER_NERD1
	const ROUTE15_SUPER_NERD2
	const ROUTE15_SUPER_NERD3
	const ROUTE15_FISHER
	const ROUTE15_LASS
	const ROUTE15_YOUNGSTER
	const ROUTE15_POKE_BALL
	const ROUTE15_BERRY_TREE1
	const ROUTE15_APRICORN_TREE1

Route15_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, .Weather

.Weather:
	setval WEATHER_RAIN
	writemem wFieldWeather
	endcallback

TrainerCamperSpencer:
	generictrainer CAMPER, SPENCER, EVENT_BEAT_CAMPER_SPENCER, .SeenText, .BeatenText

.AfterText
	text "I'm planning to"
	line "camp at the Lake"
	cont "Of Rage."
	done

.SeenText
	text "I can do so much"
	line "with my #mon--"
	cont "it's super-fun!"
	done

.BeatenText
	text "Losing isn't fun"
	line "at all…"
	done

TrainerPokemaniacBen:
	generictrainer POKEMANIAC, BEN, EVENT_BEAT_POKEMANIAC_BEN, .SeenText, .BeatenText

.AfterText
	text "What else do I"
	line "like besides"
	cont "#mon?"

	para "Mary on the radio."
	line "I bet she's cute!"
	done

.SeenText
	text "I love #mon!"

	para "That's why I"
	line "started--and why"
	cont "I'll keep on col-"
	cont "lecting #mon!"
	done

.BeatenText
	text "How could you do"
	line "this to me?"
	done

TrainerPokemaniacRon:
	generictrainer POKEMANIAC, RON, EVENT_BEAT_POKEMANIAC_RON, .SeenText, .BeatenText

.AfterText
	text "It's okay for"
	line "people to like"
	cont "different types"
	cont "of #mon."

	para "#mon isn't just"
	line "about having the"
	cont "most powerful one."
	done

.SeenText
	text "TODOTEXT"
	done

.BeatenText
	text "My Nidoking did"
	line "pretty right on!"
	done

TrainerFisherMarvin:
	generictrainer FISHER, MARVIN, EVENT_BEAT_FISHER_MARVIN, .SeenText, .BeatenText

.AfterText
	text "Kurt's Lure Ball"
	line "is the best for"
	cont "catching hooked"
	cont "#mon."

	para "It's much more"
	line "effective than a"
	cont "Ultra Ball."
	done

.SeenText
	text "I'm in a slump."

	para "Maybe it's the"
	line "gear I'm using."

	para "Let's battle for a"
	line "change of pace!"
	done

.BeatenText
	text "I lost, but I feel"
	line "better anyway."
	done

TrainerPokemaniacBrent:
	trainer POKEMANIAC, BRENT1, EVENT_BEAT_POKEMANIAC_BRENT, PokemaniacBrentSeenText, PokemaniacBrentBeatenText, 0, .Script

.Script:
	loadvar VAR_CALLERID, PHONE_POKEMANIAC_BRENT
	opentext
	checkevent EVENT_BRENT_GOLD_BERRY
	iftrue .RematchGift
	checkflag ENGINE_BRENT_READY_FOR_REMATCH
	iftrue .WantsBattle
	checkcellnum PHONE_POKEMANIAC_BRENT
	iftrue .NumberAccepted
	checkevent EVENT_BRENT_ASKED_FOR_PHONE_NUMBER
	iftrue .AskedAlready
	writetext PokemaniacBrentAfterBattleText
	promptbutton
	setevent EVENT_BRENT_ASKED_FOR_PHONE_NUMBER
	scall .AskNumber
	sjump .AskForNumber

.AskedAlready:
	scall .AskNumber
.AskForNumber:
	askforphonenumber PHONE_POKEMANIAC_BRENT
	ifequal PHONE_CONTACT_REFUSED, .NumberDeclined
	gettrainername STRING_BUFFER_3, POKEMANIAC, BRENT1
	scall .RegisteredNumber
	sjump .NumberAccepted

.WantsBattle:
	scall .Rematch
	winlosstext PokemaniacBrentBeatenText, 0
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftrue .LoadFight3
	checkevent EVENT_BEAT_ELITE_FOUR
	iftrue .LoadFight2
	loadtrainer POKEMANIAC, BRENT1
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_BRENT_READY_FOR_REMATCH
	end

.LoadFight1:
	loadtrainer POKEMANIAC, BRENT2
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_BRENT_READY_FOR_REMATCH
	end

.LoadFight2:
	loadtrainer POKEMANIAC, BRENT3
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_BRENT_READY_FOR_REMATCH
	end

.LoadFight3:
	loadtrainer POKEMANIAC, BRENT4
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_BRENT_READY_FOR_REMATCH
	opentext
	writetext PokemaniacBrent_GiveGoldBerryAfterBattleText
	waitbutton
	verbosegiveitem GOLD_BERRY
	iffalse .PackFull
	closetext
	end

.RematchGift
	writetext PokemaniacBrent_AgainGiveGoldBerryAfterBattleText
	waitbutton
	verbosegiveitem GOLD_BERRY
	iffalse .PackFull
	clearevent EVENT_BRENT_GOLD_BERRY
	closetext
	end

.PackFull:
	setevent EVENT_BRENT_GOLD_BERRY
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

.Rematch:
	jumpstd RematchMScript
	end



TrainerPicnickerTiffany:
	trainer PICNICKER, TIFFANY3, EVENT_BEAT_PICNICKER_TIFFANY, PicnickerTiffanySeenText, PicnickerTiffanyBeatenText, 0, .Script

.Script:
	loadvar VAR_CALLERID, PHONE_PICNICKER_TIFFANY
	opentext
	checkflag ENGINE_TIFFANY_HAS_PINK_BOW
	iftrue .HasPinkBow
	checkflag ENGINE_TIFFANY_READY_FOR_REMATCH
	iftrue .WantsBattle
	checkcellnum PHONE_PICNICKER_TIFFANY
	iftrue .NumberAccepted
	checkpoke CLEFAIRY
	iffalse .NoClefairy
	checkevent EVENT_TIFFANY_ASKED_FOR_PHONE_NUMBER
	iftrue .AskedAlready
	writetext PicnickerTiffanyWantsPicnicText
	promptbutton
	setevent EVENT_TIFFANY_ASKED_FOR_PHONE_NUMBER
	scall .AskNumber
	sjump .AskForNumber

.AskedAlready:
	scall .AskNumber
.AskForNumber:
	askforphonenumber PHONE_PICNICKER_TIFFANY
	ifequal PHONE_CONTACT_REFUSED, .NumberDeclined
	gettrainername STRING_BUFFER_3, PICNICKER, TIFFANY3
	scall .RegisteredNumber
	sjump .NumberAccepted

.WantsBattle:
	scall .Rematch
	winlosstext PicnickerTiffanyBeatenText, 0
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftrue .LoadFight3
	checkevent EVENT_BEAT_ELITE_FOUR
	iftrue .LoadFight2
	checkevent EVENT_CLEARED_RADIO_TOWER
	iftrue .LoadFight1
	loadtrainer PICNICKER, TIFFANY3
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_TIFFANY_READY_FOR_REMATCH
	end

.LoadFight1:
	loadtrainer PICNICKER, TIFFANY1
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_TIFFANY_READY_FOR_REMATCH
	end

.LoadFight2:
	loadtrainer PICNICKER, TIFFANY2
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_TIFFANY_READY_FOR_REMATCH
	end

.LoadFight3:
	loadtrainer PICNICKER, TIFFANY4
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_TIFFANY_READY_FOR_REMATCH
	end

.HasPinkBow:
	scall .Gift
	verbosegiveitem PINK_BOW
	iffalse .NoRoom
	clearflag ENGINE_TIFFANY_HAS_PINK_BOW
	closetext
	end

.NoRoom:
	sjump .PackFull

.NoClefairy:
	writetext PicnickerTiffanyClefairyText
	waitbutton
	closetext
	end

.AskNumber:
	jumpstd AskNumberFScript
	end

.RegisteredNumber:
	jumpstd RegisteredNumberFScript
	end

.NumberAccepted:
	jumpstd NumberAcceptedFScript
	end

.NumberDeclined:
	jumpstd NumberDeclinedFScript
	end

.Rematch:
	jumpstd RematchFScript
	end

.Gift:
	jumpstd GiftFScript
	end

.PackFull:
	jumpstd PackFullFScript
	end





PokemaniacBrentSeenText:
	text "Hey! Do you have"
	line "any rare #MON?"
	done

PokemaniacBrentBeatenText:
	text "Oh, my poor #-"
	line "MON! Darlings!"
	done

PokemaniacBrentAfterBattleText:
	text "I'd be happy just"
	line "to own a single"
	cont "rare #MON."
	done

PokemaniacBrent_GiveGoldBerryAfterBattleText:
	text "Take this to be"
	line "stronger for our"
	cont "next battle."
	done

PokemaniacBrent_AgainGiveGoldBerryAfterBattleText:
	text "Made room now?"
	line "Take it!"
	done









PicnickerTiffanySeenText:
	text "Are you going to"
	line "LAKE OF RAGE too?"

	para "Let's play for a "
	line "little while!"
	done

PicnickerTiffanyBeatenText:
	text "I played too much!"
	done

PicnickerTiffanyWantsPicnicText:
	text "I'm having a pic-"
	line "nic with #MON."

	para "Won't you join us?"
	done

PicnickerTiffanyClefairyText:
	text "Isn't my CLEFAIRY"
	line "just the most"
	cont "adorable thing?"
	
	para "Do you have a"
	line "CLEFAIRY?"
	done



Route15TrainerTipsText:
	text "Trainer Tips"

	para "All #mon have"
	line "pros and cons"
	cont "depending on their"
	cont "types."

	para "If their types"
	line "differ, a higher-"
	cont "level #mon may"
	cont "lose in battle."

	para "Learn which types"
	line "are strong and"
	cont "weak against your"
	cont "#mon's type."
	done

Route15Sign1Text:
	text "Route 15"

	para "Lake Of Rage -"
	line "Mahogany Town"
	done

Route15Sign2Text:
	text "Route 15"

	para "Lake Of Rage -"
	line "Mahogany Town"
	done

Route15MaxEther:
	itemball MAX_ETHER

Route15BerryTree1:
	setval BITTER_BERRY
	setlasttalked ROUTE15_BERRY_TREE1
	jumpstd BerryOrFruitScript
Route15ApricornTree1:
	setval PNK_APRICORN
	setlasttalked ROUTE15_APRICORN_TREE1
	jumpstd BerryOrFruitScript
