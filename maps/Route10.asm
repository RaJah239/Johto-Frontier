Route10_MapEvents:
	def_warp_events
	warp_event 35,  8, ROUTE_10_ECRUTEAK_GATE, 1
	warp_event 35,  9, ROUTE_10_ECRUTEAK_GATE, 2

	def_coord_events

	def_bg_events
	bg_event 33,  7, BGEVENT_JUMPTEXT, Route10SignText
	bg_event  5, 13, BGEVENT_JUMPTEXT, Route10TrainerTipsText
	bg_event 12, 10, BGEVENT_JUMPSTD, NO_BERRY_OR_FRUIT_SCRIPT
	bg_event 12,  9, BGEVENT_JUMPSTD, NO_BERRY_OR_FRUIT_SCRIPT

	def_object_events
	object_event  4,  1, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_GENERICTRAINER, 1, TrainerSchoolboyChad, -1
	object_event 15,  3, SPRITE_LASS, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_GENERICTRAINER, 2, TrainerLassDana, -1
	object_event 12, 15, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_GENERICTRAINER, 1, TrainerBirdKeeperToby, -1
	object_event 19,  9, SPRITE_BEAUTY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_GENERICTRAINER, 1, TrainerBeautyValerie, -1
	object_event 24,  5, SPRITE_SAILOR, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_GENERICTRAINER, 2, TrainerSailorHarry, -1
	object_event  5,  8, SPRITE_BEAUTY, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_GENERICTRAINER, 1, TrainerBeautyOlivia, -1
	object_event 12, 10, SPRITE_BERRY, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_YELLOW, OBJECTTYPE_SCRIPT, 0, Route10BerryTree1, EVENT_ROUTE_10_BERRY_1
	object_event 12,  9, SPRITE_BERRY, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_ORANGE, OBJECTTYPE_SCRIPT, 0, Route10BerryTree2, EVENT_ROUTE_10_BERRY_2

	object_const_def
	const ROUTE10_STANDING_YOUNGSTER1
	const ROUTE10_LASS
	const ROUTE10_STANDING_YOUNGSTER2
	const ROUTE10_BEAUTY1
	const ROUTE10_SAILOR
	const ROUTE10_BEAUTY2
	const ROUTE10_BERRY_TREE1
	const ROUTE10_BERRY_TREE2

Route10_MapScripts:
	def_scene_scripts

	def_callbacks

TrainerBirdKeeperToby:
	generictrainer BIRD_KEEPER, TOBY, EVENT_BEAT_BIRD_KEEPER_TOBY, .SeenText, .BeatenText

.AfterText
	text "I just flew here"
	line "on my #mon."
	done

.SeenText
	text "Fly high into the"
	line "sky, my beloved"
	cont "bird #mon!"
	done

.BeatenText
	text "I feel like just"
	line "flying away now."
	done

TrainerSailorHarry:
	generictrainer SAILOR, HARRY, EVENT_BEAT_SAILOR_HARRY, .SeenText, .BeatenText

.AfterText
	text "All kinds of peo-"
	line "ple around the"
	cont "world live happily"
	cont "with #mon."
	done

.SeenText
	text "I've been over-"
	line "seas, so I know"
	cont "about all sorts of"
	cont "#mon!"
	done

.BeatenText
	text "Your skill is"
	line "world class!"
	done

TrainerBeautyValerie:
	generictrainer BEAUTY, VALERIE, EVENT_BEAT_BEAUTY_VALERIE, .SeenText, .BeatenText

.AfterText
	text "When I see #-"
	line "mon, it seems to"
	cont "soothe my nerves."
	done

.SeenText
	text "Hi! Aren't you a"
	line "cute trainer!"

	para "May I see your"
	line "#mon?"
	done

.BeatenText
	text "I'm glad I got to"
	line "see your #mon!"
	done

TrainerBeautyOlivia:
	generictrainer BEAUTY, OLIVIA, EVENT_BEAT_BEAUTY_OLIVIA, .SeenText, .BeatenText

.AfterText
	text "Moomoo Milk is"
	line "good for beauty"
	cont "and health, but"
	cont "inconveniently,"
	cont "they only sell a"
	cont "bottle at a time."
	done

.SeenText
	text "Don't you think my"
	line "#mon and I are"
	cont "beautiful?"
	done

.BeatenText
	text "We drink Moomoo"
	line "Milk every day."
	done

TrainerLassDana:
	generictrainer LASS, DANA, EVENT_BEAT_LASS_DANA, .SeenText, .BeatenText

.AfterText
	text "I know something"
	line "good!"

	para "Moomoo Farm's milk"
	line "is famous for its"
	cont "flavor."
	done

.SeenText
	text "You seem to be"
	line "good at #mon."

	para "If you are, how"
	line "about giving me"
	cont "some advice?"
	done

.BeatenText
	text "I see. So you can"
	line "battle that way."
	done

TrainerSchoolboyChad:
	trainer SCHOOLBOY, CHAD1, EVENT_BEAT_SCHOOLBOY_CHAD, SchoolboyChad1SeenText, SchoolboyChad1BeatenText, 0, .Script

.Script
	loadvar VAR_CALLERID, PHONE_SCHOOLBOY_CHAD
	opentext
	checkevent EVENT_CHAD_TWISTEDSPOON
	iftrue .RematchGift
	checkflag ENGINE_CHAD_READY_FOR_REMATCH
	iftrue .ChadRematch
	checkcellnum PHONE_SCHOOLBOY_CHAD
	iftrue .HaveChadsNumber
	checkevent EVENT_CHAD_ASKED_FOR_PHONE_NUMBER
	iftrue .SecondTimeAsking
	writetext SchoolboyChadSoManyTestsText
	promptbutton
	setevent EVENT_CHAD_ASKED_FOR_PHONE_NUMBER
	scall .AskPhoneNumber
	sjump .AskToRegisterNumber

.SecondTimeAsking:
	scall .AskPhoneNumber
.AskToRegisterNumber:
	askforphonenumber PHONE_SCHOOLBOY_CHAD
	ifequal PHONE_CONTACT_REFUSED, .SaidNo
	gettrainername STRING_BUFFER_3, SCHOOLBOY, CHAD1
	scall .RegisteredChad
	sjump .HaveChadsNumber

.ChadRematch:
	scall .Rematch
	winlosstext SchoolboyChad1BeatenText, 0
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftrue .LoadFight4
	checkevent EVENT_BEAT_ELITE_FOUR
	iftrue .LoadFight3
	checkevent EVENT_CLEARED_RADIO_TOWER
	iftrue .LoadFight2
	checkflag ENGINE_FLYPOINT_MAHOGANY
	iftrue .LoadFight1
	loadtrainer SCHOOLBOY, CHAD1
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_CHAD_READY_FOR_REMATCH
	end

.LoadFight1:
	loadtrainer SCHOOLBOY, CHAD2
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_CHAD_READY_FOR_REMATCH
	end

.LoadFight2:
	loadtrainer SCHOOLBOY, CHAD3
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_CHAD_READY_FOR_REMATCH
	end

.LoadFight3:
	loadtrainer SCHOOLBOY, CHAD4
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_CHAD_READY_FOR_REMATCH
	end

.LoadFight4:
	loadtrainer SCHOOLBOY, CHAD5
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_CHAD_READY_FOR_REMATCH
	opentext
	writetext SchoolboyChad_GiveTwistedSpoonAfterBattleText
	waitbutton
	verbosegiveitem TWISTEDSPOON
	iffalse .PackFull
	closetext
	end

.RematchGift
	writetext SchoolboyChad_AgainGiveTwistedSpoonAfterBattleText
	waitbutton
	verbosegiveitem TWISTEDSPOON
	iffalse .PackFull
	clearevent EVENT_CHAD_TWISTEDSPOON
	closetext
	end

.PackFull:
	setevent EVENT_CHAD_TWISTEDSPOON
	jumpstd PackFullMScript
	end

.AskPhoneNumber:
	jumpstd AskNumberMScript
	end

.RegisteredChad:
	jumpstd RegisteredNumberMScript
	end

.HaveChadsNumber:
	jumpstd NumberAcceptedMScript
	end

.SaidNo:
	jumpstd NumberDeclinedMScript
	end

.Rematch:
	jumpstd RematchMScript
	end





SchoolboyChad1SeenText:
	text "Let me try some-"
	line "thing I learned"
	cont "today."
	done

SchoolboyChad1BeatenText:
	text "I didn't study"
	line "enough, I guess."
	done

SchoolboyChadSoManyTestsText:
	text "I have to take so"
	line "many tests, I"

	para "don't have much"
	line "time for #MON."

	para "So when I do get"
	line "to play, I really"
	cont "concentrate."
	done











SchoolboyChad_GiveTwistedSpoonAfterBattleText:
	text "Take this small"
	line "item."
	done

SchoolboyChad_AgainGiveTwistedSpoonAfterBattleText:
	text "Can a spoon fit"
	line "now?"
	done

Route10SignText:
	text "Route 10"

	para "Olivine City -"
	line "Ecruteak City"
	done

Route10TrainerTipsText:
	text "Trainer Tips"

	para "If a #mon is"
	line "trying to evolve,"
	cont "you can stop it."

	para "Press the B But-"
	line "ton during evolu-"
	cont "tion."

	para "That startles the"
	line "#mon and stops"
	cont "its evolution."
	done

Route10BerryTree1:
	setval BURNT_BERRY
	setlasttalked ROUTE10_BERRY_TREE1
	jumpstd BerryOrFruitScript
Route10BerryTree2:
	setval MYSTERYBERRY
	setlasttalked ROUTE10_BERRY_TREE2
	jumpstd BerryOrFruitScript
