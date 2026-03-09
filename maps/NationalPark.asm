NationalPark_MapEvents:
	def_warp_events
	warp_event 10, 47, ROUTE_7_NATIONAL_PARK_GATE, 1
	warp_event 33, 18, ROUTE_8_NATIONAL_PARK_GATE, 1
	warp_event 33, 19, ROUTE_8_NATIONAL_PARK_GATE, 2
	warp_event 11, 47, ROUTE_7_NATIONAL_PARK_GATE, 2

	def_coord_events

	def_bg_events
	bg_event 14, 44, BGEVENT_JUMPTEXT, NationalParkRelaxationSquareText
	bg_event 27, 31, BGEVENT_JUMPTEXT, NationalParkBattleNoticeText
	bg_event 12,  4, BGEVENT_JUMPTEXT, NationalParkTrainerTipsText
	bg_event 24, 51, BGEVENT_READ, NationalParkGholdengoEvent
	bg_event  6, 47, BGEVENT_ITEM + FULL_HEAL, EVENT_NATIONAL_PARK_HIDDEN_FULL_HEAL

	def_object_events
	object_event 15, 24, SPRITE_LASS, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, NationalParkLassText, -1
	object_event 14,  4, SPRITE_POKEFAN_F, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, NationalParkPokefanFText, -1
	object_event 27, 40, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, NationalParkTeacher1Script, -1
	object_event 11, 41, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, NationalParkYoungster1Text, -1
	object_event 10, 41, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, NationalParkYoungster2Text, -1
	object_event 17, 41, SPRITE_TEACHER, SPRITEMOVEDATA_WANDER, 1, 2, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, NationalParkTeacher2Text, -1
	object_event 27, 23, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_GENERICTRAINER, 3, TrainerSchoolboyJack, -1
	object_event 18, 29, SPRITE_POKEFAN_F, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_GENERICTRAINER, 2, TrainerPokefanfBeverly, -1
	object_event 16,  9, SPRITE_POKEFAN_M, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_GENERICTRAINER, 2, TrainerPokefanmWilliam, -1
	object_event  8, 14, SPRITE_LASS, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_GENERICTRAINER, 3, TrainerLassKrise, -1
	object_event 26,  6, SPRITE_GAMEBOY_KID, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, NationalParkGameboyKidScript, -1
	object_event 24, 52, SPRITE_GHOLDENGO, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, NationalParkGholdengoScript, EVENT_NATIONAL_PARK_GHOLDENGO
	object_event 26, 40, SPRITE_MEOWTH, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, NationalParkMeowthScript, -1
	object_event  1, 43, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, NationalParkTMDig, EVENT_NATIONAL_PARK_TM_DIG
	object_event 35, 12, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, NationalParkParlyzHeal, EVENT_NATIONAL_PARK_PARLYZ_HEAL

	object_const_def
	const NATIONALPARK_LASS1
	const NATIONALPARK_POKEFAN_F1
	const NATIONALPARK_TEACHER1
	const NATIONALPARK_YOUNGSTER1
	const NATIONALPARK_YOUNGSTER2
	const NATIONALPARK_TEACHER2
	const NATIONALPARK_YOUNGSTER3
	const NATIONALPARK_POKEFAN_F2
	const NATIONALPARK_POKEFAN_M
	const NATIONALPARK_LASS2
	const NATIONALPARK_GAMEBOY_KID
	const NATIONALPARK_GHOLDENGO
	const NATIONALPARK_MEOWTH
	const NATIONALPARK_POKE_BALL1
	const NATIONALPARK_POKE_BALL2

NationalPark_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, .Flypoint
	callback MAPCALLBACK_OBJECTS, .Weather

.Weather:
	checktime EVE | NITE
	iftrue .skipWeather
	setval WEATHER_SUN
	writemem wFieldWeather
.skipWeather
	endcallback

.Flypoint:
	setflag ENGINE_FLYPOINT_NATIONAL_PARK
	endcallback

NationalParkTeacher1Script:
	faceplayeropentext
	checkevent EVENT_GOT_QUICK_CLAW
	iftrue .GotQuickClaw
	writethistext
		text "Pay attention,"
		line "please!"

		para "…Oops, I have to"
		line "quit thinking like"
		cont "a teacher all the"
		cont "time."

		para "You must be a"
		line "#mon trainer."

		para "Since you're work-"
		line "ing so hard, I"
		cont "want you to have"
		cont "this."
		done
	promptbutton
	verbosegiveitem QUICK_CLAW
	iffalse_endtext
	setevent EVENT_GOT_QUICK_CLAW
.GotQuickClaw:
	jumpthisopenedtext
		text "Let a #mon hold"
		line "that Quick Claw."

		para "Sometimes it will"
		line "strike first"
		cont "during battle."
		done

TrainerSchoolboyJack:
	trainer SCHOOLBOY, JACK1, EVENT_BEAT_SCHOOLBOY_JACK, SchoolboyJack1SeenText, SchoolboyJack1BeatenText, 0, .Script

.Script:
	loadvar VAR_CALLERID, PHONE_SCHOOLBOY_JACK
	opentext
	checkevent EVENT_JACK_ZINC
	iftrue .RematchGift
	checkflag ENGINE_JACK_READY_FOR_REMATCH
	iftrue .Rematch
	checkcellnum PHONE_SCHOOLBOY_JACK
	iftrue .NumberAccepted
	checkevent EVENT_JACK_ASKED_FOR_PHONE_NUMBER
	iftrue .AskAgain
	writetext SchoolboyJackTradeMonText
	promptbutton
	setevent EVENT_JACK_ASKED_FOR_PHONE_NUMBER
	scall .AskNumber
	sjump .RequestNumber

.AskAgain:
	scall .AskNumber
.RequestNumber:
	askforphonenumber PHONE_SCHOOLBOY_JACK
	ifequal PHONE_CONTACT_REFUSED, .NumberDeclined
	gettrainername STRING_BUFFER_3, SCHOOLBOY, JACK1
	scall .RegisteredNumber
	sjump .NumberAccepted

.Rematch:
	scall .RematchStd
	winlosstext SchoolboyJack1BeatenText, 0
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftrue .LoadFight4
	checkevent EVENT_BEAT_ELITE_FOUR
	iftrue .LoadFight3
	checkevent EVENT_CLEARED_RADIO_TOWER
	iftrue .LoadFight2
	checkflag ENGINE_FLYPOINT_OLIVINE
	iftrue .LoadFight1
	loadtrainer SCHOOLBOY, JACK1
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_JACK_READY_FOR_REMATCH
	end

.LoadFight1:
	loadtrainer SCHOOLBOY, JACK2
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_JACK_READY_FOR_REMATCH
	end

.LoadFight2:
	loadtrainer SCHOOLBOY, JACK3
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_JACK_READY_FOR_REMATCH
	end

.LoadFight3:
	loadtrainer SCHOOLBOY, JACK4
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_JACK_READY_FOR_REMATCH
	end

.LoadFight4:
	loadtrainer SCHOOLBOY, JACK5
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_JACK_READY_FOR_REMATCH
	opentext
	writetext SchoolboyJackZincText
	waitbutton
	verbosegiveitem ZINC
	iffalse .PackFull
	closetext
	end

.RematchGift
	writetext SchoolboyJackZincAgainText
	waitbutton
	verbosegiveitem ZINC
	iffalse .PackFull
	clearevent EVENT_JACK_ZINC
	closetext
	end

.PackFull:
	setevent EVENT_JACK_ZINC
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

SchoolboyJack1SeenText:
	text "The world of"
	line "#MON is deep."

	para "There are still"
	line "lots of things we"
	cont "don't know."

	para "But I know more"
	line "than you do!"
	done

SchoolboyJack1BeatenText:
	text "Wha-wha-what?"
	done

SchoolboyJackTradeMonText:
	text "There is a lot"
	line "to learn."

	para "For example…"

	para "There are {d:NUM_TMS} kinds"
	line "of TMs."

	para "Traded #MON"
	line "level up faster."
	done

SchoolboyJackZincText:
	text "What a practical"
	line "battle!"
	
	para "Take this won't"
	line "you!"
	done

SchoolboyJackZincAgainText:
	text "Hope you made room"
	line "for it. Here!"
	done

TrainerPokefanfBeverly:
	trainer POKEFANF, BEVERLY1, EVENT_BEAT_POKEFANF_BEVERLY, PokefanfBeverly1SeenText, PokefanfBeverly1BeatenText, 0, .Script

.Script:
	loadvar VAR_CALLERID, PHONE_POKEFAN_BEVERLY
	endifjustbattled
	opentext
	checkflag ENGINE_BEVERLY_HAS_NUGGET
	iftrue .GiveNugget
	checkcellnum PHONE_POKEFAN_BEVERLY
	iftrue .NumberAccepted
	checkpoke MARILL
	iffalse .NoMarill
	checkevent EVENT_BEVERLY_ASKED_FOR_PHONE_NUMBER
	iftrue .AskAgain
	writetext PokefanBeverlyCuteMonText
	promptbutton
	setevent EVENT_BEVERLY_ASKED_FOR_PHONE_NUMBER
	scall .AskNumber
	sjump .RequestNumber

.AskAgain:
	scall .AskNumber
.RequestNumber:
	askforphonenumber PHONE_POKEFAN_BEVERLY
	ifequal PHONE_CONTACT_REFUSED, .NumberDeclined
	gettrainername STRING_BUFFER_3, POKEFANF, BEVERLY1
	scall .RegisteredNumber
	sjump .NumberAccepted

.GiveNugget:
	scall .Gift
	verbosegiveitem NUGGET
	iffalse .NoRoom
	clearflag ENGINE_BEVERLY_HAS_NUGGET
	closetext
	end

.NoRoom:
	sjump .PackFull

.NoMarill:
	writetext PokefanFBeverlyMarillFriendText
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

.Gift:
	jumpstd GiftFScript
	end

.PackFull:
	jumpstd PackFullFScript
	end

PokefanfBeverly1SeenText:
	text "My #MON are"
	line "simply darling."

	para "Let me tell you"
	line "how proud my"
	cont "darlings make me."
	done

PokefanfBeverly1BeatenText:
	text "I can beat you in"
	line "pride, but…"
	done

PokefanBeverlyCuteMonText:
	text "I must say, your"
	line "#MON are quite"
	cont "cute, too."
	done

PokefanFBeverlyMarillFriendText:
	text "My friend keeps a"
	line "MARILL!"

	para "I find them very"
	line "endearing."

	para "Oh, I wish to see"
	line "one soon…"
	done

TrainerPokefanmWilliam:
	generictrainer POKEFANM, WILLIAM, EVENT_BEAT_POKEFANM_WILLIAM, .SeenText, .BeatenText

.AfterText
	text "I lost the battle,"
	line "but my #mon win"
	cont "the prize for"
	cont "being most lovely."
	done

.SeenText
	text "We adore our #-"
	line "mon, even if they"
	cont "dislike us."

	para "That's what being"
	line "a Fan is about."
	done

.BeatenText
	text "M-my #mon!"
	done

TrainerLassKrise:
	generictrainer LASS, KRISE, EVENT_BEAT_LASS_KRISE, .SeenText, .BeatenText

.Afterext
	text "I thought you were"
	line "staring at me"
	cont "because I'm cute!"
	done

.SeenText
	text "Hello? Why are you"
	line "staring at me?"

	para "Oh, a battle?"
	done

.BeatenText
	text "…Hmmm…"
	done

NationalParkGholdengoEvent:
	faceplayeropentext
	special NuggetCountInBag
	writethistext
		text "Make a wish and"
		line "toss in"
		cont "99× Nuggets?"
		done
	yesorno
	iffalse_endtext
	checkitem NUGGET, 99
	iftrue .GholdengoAppears
	jumpthisopenedtext
		text "More Nuggets need-"
		line "ed to make a wish…"
		done

.GholdengoAppears:
	playsound SFX_WATER_GUN
	waitsfx
	special NuggetCountInBag
	writethistext
		text "<PLAYER> tossed in"
		line "the Nuggets."
		done
	takeitem NUGGET, 99
	special NuggetCountInBag
	promptbutton
	closetext
	applymovement PLAYER, PlayerWalksAroundFountain
	turnobject PLAYER, UP
	playsound SFX_SHINE
	waitsfx
    cry GHOLDENGO
    pause 15
	showemote EMOTE_SHOCK, PLAYER, 15
	appear NATIONALPARK_GHOLDENGO
	end

PlayerWalksAroundFountain:
	step DOWN
	step LEFT
	step LEFT
	step UP
	step UP
	step UP
	step UP
	step UP
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step LEFT
	step LEFT
	step_end

NationalParkGholdengoScript:
	isfieldactionssettoquick
	iftrue .skipthis
	reanchormap
	pokepic GHOLDENGO
	cry GHOLDENGO
	waitbutton
	closepokepic
.skipthis
	showthistext
		text "Gholdengo: Guyoo…!"
		done
    loadwildmon GHOLDENGO, 5
    loadvar VAR_BATTLETYPE, BATTLETYPE_TRAP
    startbattle
    disappear NATIONALPARK_GHOLDENGO
    reloadmapafterbattle
    end

NationalParkLassText:
	text "TODOTEXT"
	done

NationalParkPokefanFText:
	text "This is Mail I got"
	line "from my daughter."
	cont "It cheers me up."
	done

NationalParkYoungster1Text:
	text "TODOTEXT"
	done

NationalParkYoungster2Text:
	text "TODOTEXT"
	done

NationalParkTeacher2Text:
	text "Rumor has it, if a"
	line "kind trainer makes"
	cont "a wish then tosses"
	cont "99× Nuggets into"
	cont "the fountain lower"
	cont "and walk around it"
	cont "once, something"
	cont "unique will occur…"

	para "Hehe. Must just be"
	line "a rumour because"
	cont "who could amass"
	cont "99× Nuggets?"
	done

NationalParkGameboyKidScript:
	showthistextfaceplayer
		text "TODOTEXT"
		done
	turnobject NATIONALPARK_GAMEBOY_KID, DOWN
	end

NationalParkRelaxationSquareText:
	text "Relaxation Square"
	line "National Park"
	done

NationalParkBattleNoticeText:
	text "What is this"
	line "notice?"

	para "Please battle only"
	line "in the grass."

	para "National Park"
	line "Warden's Office"
	done

NationalParkTrainerTipsText:
	text "Trainer Tips"

	para "TODOTEXT"
	done

NationalParkMeowthScript:
	setval MEOWTH
	special SetMonAsSeen
	isfieldactionssettoquick
	iftrue .skipthis
	reanchormap
	pokepic MEOWTH
	cry MEOWTH
	waitbutton
	closepokepic
.skipthis
	jumpthistext
		text "Meowth: Meow!"
		done

NationalParkParlyzHeal:
	itemball PARLYZ_HEAL
NationalParkTMDig:
	itemball TM_DIG
