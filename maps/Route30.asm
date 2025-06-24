	object_const_def
	const ROUTE30_YOUNGSTER1
	const ROUTE30_YOUNGSTER2
	const ROUTE30_YOUNGSTER3
	const ROUTE30_BUG_CATCHER
	const ROUTE30_YOUNGSTER4
	const ROUTE30_MONSTER1
	const ROUTE30_MONSTER2
	const ROUTE30_COOLTRAINER_F
	const ROUTE30_POKE_BALL
	const ROUTE30_BERRY_TREE1
	const ROUTE30_APRICORN_TREE1
	const ROUTE30_BERRY_TREE2
	const ROUTE30_APRICORN_TREE2
	const ROUTE30_BERRY_TEACHER

Route30_MapScripts:
	def_scene_scripts
	scene_script Route30Noop1Scene, SCENE_ROUTE_30_TEACHER_STOPS_YOU
	scene_script Route30Noop2Scene, SCENE_ROUTE_30_NOOP

	def_callbacks

Route30Noop1Scene:
	end

Route30Noop2Scene:
	end

YoungsterJoey_ImportantBattleScript:
	waitsfx
	special SaveMusic
	playmusic MUSIC_JOHTO_TRAINER_BATTLE
	opentext
	writetext Text_UseTackle
	pause 30
	closetext
	playsound SFX_TACKLE
	applymovement ROUTE30_MONSTER2, Route30_JoeysRattataAttacksMovement
	opentext
	faceplayer
	writetext Text_ThisIsABigBattle
	waitbutton
	turnobject ROUTE30_YOUNGSTER1, UP
	closetext
	playsound SFX_TACKLE
	applymovement ROUTE30_MONSTER1, Route30_MikeysRattataAttacksMovement
	special RestoreMusic
	end

TrainerYoungsterJoey:
	trainer YOUNGSTER, JOEY1, EVENT_BEAT_YOUNGSTER_JOEY, YoungsterJoey1SeenText, YoungsterJoey1BeatenText, 0, .Script

.Script:
	loadvar VAR_CALLERID, PHONE_YOUNGSTER_JOEY
	opentext
	checkflag ENGINE_JOEY_READY_FOR_REMATCH
	iftrue .Rematch
	checkcellnum PHONE_YOUNGSTER_JOEY
	iftrue .NumberAccepted
	checkevent EVENT_JOEY_ASKED_FOR_PHONE_NUMBER
	iftrue .AskAgain
	writetext YoungsterJoey1AfterText
	promptbutton
	setevent EVENT_JOEY_ASKED_FOR_PHONE_NUMBER
	scall .AskNumber1
	sjump .RequestNumber

.AskAgain:
	scall .AskNumber2
.RequestNumber:
	askforphonenumber PHONE_YOUNGSTER_JOEY
	ifequal PHONE_CONTACTS_FULL, .PhoneFull
	ifequal PHONE_CONTACT_REFUSED, .NumberDeclined
	gettrainername STRING_BUFFER_3, YOUNGSTER, JOEY1
	scall .RegisteredNumber
	sjump .NumberAccepted

.Rematch:
	scall .RematchStd
	winlosstext YoungsterJoey1BeatenText, 0
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
	checkevent EVENT_JOEY_HP_UP
	iftrue .GiveHPUp
	checkevent EVENT_GOT_HP_UP_FROM_JOEY
	iftrue .done
	scall .RematchGift
	verbosegiveitem HP_UP
	iffalse .PackFull
	setevent EVENT_GOT_HP_UP_FROM_JOEY
	sjump .NumberAccepted

.done
	end

.GiveHPUp:
	opentext
	writetext YoungsterJoeyText_GiveHPUpAfterBattle
	waitbutton
	verbosegiveitem HP_UP
	iffalse .PackFull
	clearevent EVENT_JOEY_HP_UP
	setevent EVENT_GOT_HP_UP_FROM_JOEY
	sjump .NumberAccepted

.AskNumber1:
	jumpstd AskNumber1MScript
	end

.AskNumber2:
	jumpstd AskNumber2MScript
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

.PhoneFull:
	jumpstd PhoneFullMScript
	end

.RematchStd:
	jumpstd RematchMScript
	end

.PackFull:
	setevent EVENT_JOEY_HP_UP
	jumpstd PackFullMScript
	end

.RematchGift:
	jumpstd RematchGiftMScript
	end

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

Route30YoungsterScript:
	faceplayer
	opentext
	checkevent EVENT_GAVE_MYSTERY_EGG_TO_ELM
	iftrue .CompletedEggQuest
	writetext Route30YoungsterText_DirectionsToMrPokemonsHouse
	waitbutton
	closetext
	end

.CompletedEggQuest:
	writetext Route30YoungsterText_EveryoneIsBattling
	waitbutton
	closetext
	end

Route30CooltrainerFScript:
	jumptextfaceplayer Route30CooltrainerFText

Route30Sign:
	jumptext Route30SignText

MrPokemonsHouseDirectionsSign:
	jumptext MrPokemonsHouseDirectionsSignText

MrPokemonsHouseSign:
	jumptext MrPokemonsHouseSignText

Route30TrainerTips:
	jumptext Route30TrainerTipsText

Route30Antidote:
	itemball ANTIDOTE

Route30FruitTree1:
	fruittree FRUITTREE_ROUTE_30_1

Route30FruitTree2:
	fruittree FRUITTREE_ROUTE_30_2

Route30HiddenPotion:
	hiddenitem POTION, EVENT_ROUTE_30_HIDDEN_POTION

Route30_JoeysRattataAttacksMovement:
	fix_facing
	big_step UP
	big_step DOWN
	step_end

Route30_MikeysRattataAttacksMovement:
	fix_facing
	big_step DOWN
	big_step UP
	step_end

Text_UseTackle:
	text "Go, RATTATA!"

	para "TACKLE!"
	done

Text_ThisIsABigBattle:
	text "What? This is a"
	line "big battle!"
	cont "Leave me alone!"
	done

YoungsterJoey1SeenText:
	text "I just lost, so"
	line "I'm trying to find"
	cont "more #MON."

	para "Wait! You look"
	line "weak! Come on,"
	cont "let's battle!"
	done

YoungsterJoey1BeatenText:
	text "Ack! I lost again!"
	line "Doggone it!"
	done

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

Route30YoungsterText_DirectionsToMrPokemonsHouse:
	text "MR.#MON's"
	line "house? It's a bit"
	cont "farther ahead."
	done

Route30YoungsterText_EveryoneIsBattling:
	text "Everyone's having"
	line "fun battling!"
	cont "You should too!"
	done

Route30CooltrainerFText:
	text "I'm not a trainer."

	para "But if you look"
	line "one in the eyes,"
	cont "prepare to battle."
	done

Route30SignText:
	text "ROUTE 30"

	para "VIOLET CITY -"
	line "CHERRYGROVE CITY"
	done

MrPokemonsHouseDirectionsSignText:
	text "MR.#MON'S HOUSE"
	line "STRAIGHT AHEAD!"
	done

MrPokemonsHouseSignText:
	text "MR.#MON'S HOUSE"
	done

Route30TrainerTipsText:
	text "TRAINER TIPS"

	para "No stealing other"
	line "people's #MON!"

	para "# BALLS are to"
	line "be thrown only at"
	cont "wild #MON!"
	done

YoungsterJoeyText_GiveHPUpAfterBattle:
	text "I lost again…"
	line "Gee, you're tough!"

	para "Oh yeah, I almost"
	line "forgot that I had"
	cont "to give you this."

	para "Use it to get even"
	line "tougher, OK?"

	para "I'm going to get"
	line "tougher too."
	done

Route30BerryTree1:
	opentext
	getitemname STRING_BUFFER_3, BERRY
	writetext Route30TreeText
	promptbutton
	writetext Route30HeyItsBerryApricornText
	promptbutton
	giveitem BERRY
	iffalse Route30NoRoomInBag
	disappear ROUTE30_BERRY_TREE1
	writetext Route30FoundItemText
	playsound SFX_ITEM
	waitsfx
	itemnotify
	closetext
	end

Route30BerryTree2:
	opentext
	getitemname STRING_BUFFER_3, PSNCUREBERRY
	writetext Route30TreeText
	promptbutton
	writetext Route30HeyItsBerryApricornText
	promptbutton
	giveitem PSNCUREBERRY
	iffalse Route30NoRoomInBag
	disappear ROUTE30_BERRY_TREE2
	writetext Route30FoundItemText
	playsound SFX_ITEM
	waitsfx
	itemnotify
	closetext
	end

Route30ApricornTree1:
	opentext
	getitemname STRING_BUFFER_3, YLW_APRICORN
	writetext Route30TreeText
	promptbutton
	writetext Route30HeyItsBerryApricornText
	promptbutton
	giveitem YLW_APRICORN
	iffalse Route30NoRoomInBag
	disappear ROUTE30_APRICORN_TREE1
	writetext Route30FoundItemText
	playsound SFX_ITEM
	waitsfx
	itemnotify
	closetext
	end

Route30ApricornTree2:
	opentext
	getitemname STRING_BUFFER_3, GRN_APRICORN
	writetext Route30TreeText
	promptbutton
	writetext Route30HeyItsBerryApricornText
	promptbutton
	giveitem GRN_APRICORN
	iffalse Route30NoRoomInBag
	disappear ROUTE30_APRICORN_TREE2
	writetext Route30FoundItemText
	playsound SFX_ITEM
	waitsfx
	itemnotify
	closetext
	end

Route30NoBerryOrApricorn:
	opentext
	writetext Route30TreeText
	promptbutton
	writetext Route30NothingHereText
	waitbutton
	closetext
	end

Route30NoRoomInBag:
	writetext Route30NoRoomInBagText
	waitbutton
	closetext
	end

Route30TreeText:
	text_far _FruitBearingTreeText
	text_end

Route30NothingHereText:
	text_far _NothingHereText
	text_end

Route30HeyItsBerryApricornText:
	text_far _HeyItsFruitText
	text_end

Route30FoundItemText:
	text_far _ObtainedFruitText
	text_end

Route30NoRoomInBagText:
	text_far _CantCarryItemText
	text_end

Route30BerryTeacher2Script:
	moveobject ROUTE30_BERRY_TEACHER, 8, 40
Route30BerryTeacher1Script:
	playsound SFX_ENTER_DOOR
	turnobject PLAYER, LEFT
	showemote EMOTE_SHOCK, PLAYER, 15
	appear ROUTE30_BERRY_TEACHER
	applymovement ROUTE30_BERRY_TEACHER, Route30BerryTeacherMovement
	turnobject PLAYER, LEFT
	opentext
	writetext DidYouJustPastThisObviousHouseText
	waitbutton
	closetext
	applymovement ROUTE30_BERRY_TEACHER, Route30BerryTeacherMovementExits
	playsound SFX_ENTER_DOOR
	disappear ROUTE30_BERRY_TEACHER
	setscene SCENE_ROUTE_30_NOOP
	end

Route30BerryTeacherMovement:
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step_end

Route30BerryTeacherMovementExits:
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step UP
	step_end

DidYouJustPastThisObviousHouseText:
	text "Well hello there"
	line "trainer."
	
	para "What's the rush?"

	para "What if I was MR."
	line "#MON? Fine, I'm"

	para "not but I have"
	line "important tips!"

	para "Come and join me"
	line "inside won't you?"
	done

Route30_MapEvents:
	def_warp_events
	warp_event  7, 39, ROUTE_30_BERRY_HOUSE, 1
	warp_event 17,  5, MR_POKEMONS_HOUSE, 1

	def_coord_events
	coord_event 12, 40, SCENE_ROUTE_30_TEACHER_STOPS_YOU, Route30BerryTeacher1Script
	coord_event 13, 40, SCENE_ROUTE_30_TEACHER_STOPS_YOU, Route30BerryTeacher2Script

	def_bg_events
	bg_event  9, 43, BGEVENT_READ, Route30Sign
	bg_event 13, 29, BGEVENT_READ, MrPokemonsHouseDirectionsSign
	bg_event 15,  5, BGEVENT_READ, MrPokemonsHouseSign
	bg_event  3, 21, BGEVENT_READ, Route30TrainerTips
	bg_event 14,  9, BGEVENT_ITEM, Route30HiddenPotion
	bg_event  5, 39, BGEVENT_READ, Route30NoBerryOrApricorn
	bg_event  4, 39, BGEVENT_READ, Route30NoBerryOrApricorn
	bg_event 11,  5, BGEVENT_READ, Route30NoBerryOrApricorn
	bg_event 12,  6, BGEVENT_READ, Route30NoBerryOrApricorn

	def_object_events
	object_event  5, 26, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, YoungsterJoey_ImportantBattleScript, EVENT_ROUTE_30_BATTLE
	object_event  2, 28, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerYoungsterJoey, EVENT_ROUTE_30_YOUNGSTER_JOEY
	object_event  5, 23, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 1, TrainerYoungsterMikey, -1
	object_event  1,  7, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 3, TrainerBugCatcherDon, -1
	object_event  7, 30, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, Route30YoungsterScript, -1
	object_event  5, 24, SPRITE_MONSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_ROUTE_30_BATTLE
	object_event  5, 25, SPRITE_MONSTER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_ROUTE_30_BATTLE
	object_event  2, 13, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route30CooltrainerFScript, -1
	object_event  8, 35, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, Route30Antidote, EVENT_ROUTE_30_ANTIDOTE
	object_event  5, 39, SPRITE_BERRY, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, Route30BerryTree1, EVENT_ROUTE_2_BERRY1
	object_event  4, 39, SPRITE_APRICORN, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_YELLOW, OBJECTTYPE_SCRIPT, 0, Route30ApricornTree1, EVENT_ROUTE_2_APRICORN1
	object_event 11,  5, SPRITE_BERRY, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, Route30BerryTree2, EVENT_ROUTE_2_BERRY2
	object_event 12,  6, SPRITE_APRICORN, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, Route30ApricornTree2, EVENT_ROUTE_2_APRICORN2
	object_event  7, 40, SPRITE_TEACHER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_ROUTE_30_BERRY_TEACHER
