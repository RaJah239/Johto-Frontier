Route2_MapEvents:
	def_warp_events
	warp_event  7, 39, ROUTE_2_BERRY_HOUSE, 1
	warp_event 17,  5, MR_POKEMONS_HOUSE, 1

	def_coord_events
	coord_event 12, 40, SCENE_ROUTE_2_TEACHER_STOPS_YOU, Route2BerryTeacher1Script
	coord_event 13, 40, SCENE_ROUTE_2_TEACHER_STOPS_YOU, Route2BerryTeacher2Script

	def_bg_events
	bg_event  9, 43, BGEVENT_JUMPTEXT, Route2SignText
	bg_event 13, 29, BGEVENT_JUMPTEXT, MrPokemonsHouseDirectionsSignText
	bg_event 15,  5, BGEVENT_JUMPTEXT, MrPokemonsHouseSignText
	bg_event  3, 21, BGEVENT_JUMPTEXT, Route2TrainerTipsText
	bg_event  5, 39, BGEVENT_JUMPSTD, NO_BERRY_OR_FRUIT_SCRIPT
	bg_event  4, 39, BGEVENT_JUMPSTD, NO_BERRY_OR_FRUIT_SCRIPT
	bg_event 11,  5, BGEVENT_JUMPSTD, NO_BERRY_OR_FRUIT_SCRIPT
	bg_event 12,  6, BGEVENT_JUMPSTD, NO_BERRY_OR_FRUIT_SCRIPT
	bg_event 14,  9, BGEVENT_ITEM + POTION, EVENT_ROUTE_2_HIDDEN_POTION

	def_object_events
	object_event  2, 28, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerYoungsterJoey, -1
	object_event  5, 20, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 1, TrainerYoungsterMikey, -1
	object_event  1,  7, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 3, TrainerBugCatcherDon, -1
	object_event  7, 30, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route2YoungsterText_EveryoneIsBattling, -1
	object_event  2, 13, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route2CooltrainerFText, -1
	object_event  8, 35, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, Route2Antidote, EVENT_ROUTE_2_ANTIDOTE
	object_event  5, 39, SPRITE_BERRY, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, Route2BerryTree1, EVENT_ROUTE_2_BERRY1
	object_event  4, 39, SPRITE_APRICORN, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_YELLOW, OBJECTTYPE_SCRIPT, 0, Route2ApricornTree1, EVENT_ROUTE_2_APRICORN1
	object_event 11,  5, SPRITE_BERRY, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, Route2BerryTree2, EVENT_ROUTE_2_BERRY2
	object_event 12,  6, SPRITE_APRICORN, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, Route2ApricornTree2, EVENT_ROUTE_2_APRICORN2
	object_event  7, 40, SPRITE_TEACHER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_ROUTE_2_BERRY_TEACHER

	object_const_def
	const ROUTE2_YOUNGSTER1
	const ROUTE2_YOUNGSTER2
	const ROUTE2_BUG_CATCHER
	const ROUTE2_YOUNGSTER4
	const ROUTE2_COOLTRAINER_F
	const ROUTE2_POKE_BALL
	const ROUTE2_BERRY_TREE1
	const ROUTE2_APRICORN_TREE1
	const ROUTE2_BERRY_TREE2
	const ROUTE2_APRICORN_TREE2
	const ROUTE2_BERRY_TEACHER

Route2_MapScripts:
	def_scene_scripts
	scene_script Route2Noop1Scene, SCENE_ROUTE_2_TEACHER_STOPS_YOU
	scene_script Route2Noop2Scene, SCENE_ROUTE_2_NOOP

	def_callbacks

Route2Noop1Scene:
Route2Noop2Scene:
	end

Route2BerryTeacher2Script:
	moveobject ROUTE2_BERRY_TEACHER, 8, 40
Route2BerryTeacher1Script:
	playsound SFX_ENTER_DOOR
	turnobject PLAYER, LEFT
	showemote EMOTE_SHOCK, PLAYER, 15
	appear ROUTE2_BERRY_TEACHER
	applymovement ROUTE2_BERRY_TEACHER, Route2BerryTeacherMovement
	turnobject PLAYER, LEFT
	showthistext 
		text "Hello there."
		line "What's the rush?"

		para "How could you just"
		line "pass such a strik-"
		cont "ing house?"

		para "I might have some"
		line "important tips!"

		para "Exploration is the"
		line "core of adventure."

		para "Come and join me"
		line "inside won't you?"
		done
	applymovement ROUTE2_BERRY_TEACHER, Route2BerryTeacherMovementExits
	playsound SFX_ENTER_DOOR
	disappear ROUTE2_BERRY_TEACHER
	setscene SCENE_ROUTE_2_NOOP
	end

Route2BerryTeacherMovement:
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step_end

Route2BerryTeacherMovementExits:
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step UP
	step_end

TrainerYoungsterJoey:
	trainer YOUNGSTER, JOEY1, EVENT_BEAT_YOUNGSTER_JOEY, .SeenText, .BeatenText, 0, .Script

.SeenText
	text "I just lost, so"
	line "I'm trying to find"
	cont "more #mon."

	para "Wait! You look"
	line "weak! Come on,"
	cont "let's battle!"
	done

.BeatenText
	text "Ack! I lost again!"
	line "Doggone it!"
	done

.Script:
	loadvar VAR_CALLERID, PHONE_YOUNGSTER_JOEY
	opentext
	checkevent EVENT_JOEY_HP_UP
	iftrue .RematchGift
	checkflag ENGINE_JOEY_READY_FOR_REMATCH
	iftrue .Rematch
	checkcellnum PHONE_YOUNGSTER_JOEY
	iftrue .NumberAccepted
	checkevent EVENT_JOEY_ASKED_FOR_PHONE_NUMBER
	iftrue .AskAgain
	writetext YoungsterJoey1AfterText
	promptbutton
	setevent EVENT_JOEY_ASKED_FOR_PHONE_NUMBER
	scall .AskNumber
	sjump .RequestNumber

.AskAgain:
	scall .AskNumber
.RequestNumber:
	askforphonenumber PHONE_YOUNGSTER_JOEY
	ifequal PHONE_CONTACT_REFUSED, .NumberDeclined
	gettrainername STRING_BUFFER_3, YOUNGSTER, JOEY1
	scall .RegisteredNumber
	sjump .NumberAccepted

.Rematch:
	scall .RematchStd
	winlosstext .BeatenText, 0
	checkevent EVENT_BEAT_ELITE_FOUR
	iftrue .LoadFight4
	checkevent EVENT_CLEARED_RADIO_TOWER
	iftrue .LoadFight3
	checkflag ENGINE_FLYPOINT_OLIVINE
	iftrue .LoadFight2
	checkflag ENGINE_FLYPOINT_GOLDENROD
	iftrue .LoadFight1
	loadtrainer YOUNGSTER, JOEY1
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_JOEY_READY_FOR_REMATCH
	end

.LoadFight1:
	loadtrainer YOUNGSTER, JOEY2
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_JOEY_READY_FOR_REMATCH
	end

.LoadFight2:
	loadtrainer YOUNGSTER, JOEY3
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_JOEY_READY_FOR_REMATCH
	end

.LoadFight3:
	loadtrainer YOUNGSTER, JOEY4
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_JOEY_READY_FOR_REMATCH
	end

.LoadFight4:
	loadtrainer YOUNGSTER, JOEY5
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_JOEY_READY_FOR_REMATCH
	opentext
	writetext YoungsterJoeyText_GiveHPUpAfterBattle
	waitbutton
	verbosegiveitem HP_UP
	iffalse .PackFull
	closetext
	end

.RematchGift
	writetext YoungsterJoeyText_GiveHPUpAfterBattleAgain
	waitbutton
	verbosegiveitem HP_UP
	iffalse .PackFull
	clearevent EVENT_JOEY_HP_UP
	closetext
	end	

.AskNumber:
	jumpstd AskNumber1MScript

.RegisteredNumber:
	jumpstd RegisteredNumberMScript

.NumberAccepted:
	jumpstd NumberAcceptedMScript

.NumberDeclined:
	jumpstd NumberDeclinedMScript

.RematchStd:
	jumpstd RematchMScript

.PackFull:
	setevent EVENT_JOEY_HP_UP
	jumpstd PackFullMScript

TrainerYoungsterMikey:
	trainer YOUNGSTER, MIKEY, EVENT_BEAT_YOUNGSTER_MIKEY, YoungsterMikeySeenText, YoungsterMikeyBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext YoungsterMikeyAfterText
	waitbutton
	closetext
	end

TrainerBugCatcherDon:
	trainer BUG_CATCHER, DON, EVENT_BEAT_BUG_CATCHER_DON, BugCatcherDonSeenText, BugCatcherDonBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext BugCatcherDonAfterText
	waitbutton
	closetext
	end

YoungsterJoey1AfterText:
	text "Do I have to have"
	line "more #MON in"

	para "order to battle"
	line "better?"

	para "No! I'm sticking"
	line "with this one no"
	cont "matter what!"
	done

YoungsterMikeySeenText:
	text "You're a #MON"
	line "trainer, right?"

	para "Then you have to"
	line "battle!"
	done

YoungsterMikeyBeatenText:
	text "That's strange."
	line "I won before."
	done

YoungsterMikeyAfterText:
	text "Becoming a good"
	line "trainer is really"
	cont "tough."

	para "I'm going to bat-"
	line "tle other people"
	cont "to get better."
	done

BugCatcherDonSeenText:
	text "Instead of a bug"
	line "#MON, I found"
	cont "a trainer!"
	done

BugCatcherDonBeatenText:
	text "Argh! You're too"
	line "strong!"
	done

BugCatcherDonAfterText:
	text "I ran out of #"
	line "BALLS while I was"
	cont "catching #MON."

	para "I should've bought"
	line "some more…"
	done

YoungsterJoeyText_GiveHPUpAfterBattle:
	text "I lost again…"
	line "Gee, you're tough!"

	para "I want you to have"
	line "this."

	para "Use it to get even"
	line "tougher, OK?"

	para "I'm going to get"
	line "tougher too."
	done

YoungsterJoeyText_GiveHPUpAfterBattleAgain:
	text "Made space for the"
	line "HP UP? Take it!"
	done

Route2YoungsterText_EveryoneIsBattling:
	text "Everyone's having"
	line "fun battling!"
	cont "You should too!"
	done

Route2CooltrainerFText:
	text "I'm not a trainer"
	line "but if you look"
	cont "one in the eyes,"
	cont "prepare to battle."
	done

Route2TrainerTipsText:
	text "Trainer Tips"

	para "In addition to re-"
	line "ducing a wild"
	cont "#mon's HP to"
	cont "red, using any"
	cont "permanent status"
	cont "effect on a wild"
	cont "#mon makes it"
	cont "easier to capture."
	done

Route2SignText:
	text "Route 2"

	para "Violet City -"
	line "Cherrygrove City"
	done

MrPokemonsHouseDirectionsSignText:
	text "Mr.#mon's House"
	line "Straight Ahead!"
	done

MrPokemonsHouseSignText:
	text "Mr.#mon's House"
	done

Route2Antidote:
	itemball ANTIDOTE

Route2BerryTree1:
	setval BERRY
	setlasttalked ROUTE2_BERRY_TREE1
	jumpstd BerryOrFruitScript

Route2BerryTree2:
	setval PSNCUREBERRY
	setlasttalked ROUTE2_BERRY_TREE2
	jumpstd BerryOrFruitScript

Route2ApricornTree1:
	setval YLW_APRICORN
	setlasttalked ROUTE2_APRICORN_TREE1
	jumpstd BerryOrFruitScript

Route2ApricornTree2:
	setval GRN_APRICORN
	setlasttalked ROUTE2_APRICORN_TREE2
	jumpstd BerryOrFruitScript
