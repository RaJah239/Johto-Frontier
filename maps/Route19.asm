Route19_MapEvents:
	def_warp_events
	warp_event 33,  7, ROUTE_19_SANDSTORM_HOUSE, 1
	warp_event 26,  5, TOHJO_FALLS, 1
	warp_event 36,  5, TOHJO_FALLS, 2

	def_coord_events
	coord_event 18, 10, SCENE_ROUTE19_FIRST_STEP_INTO_KANTO, LeftScene
	coord_event 19, 10, SCENE_ROUTE19_FIRST_STEP_INTO_KANTO, RightScene

	def_bg_events
	bg_event 25,  7, BGEVENT_JUMPTEXT, TohjoFallsSignText

	def_object_events
	object_event 48,  7, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_GENERICTRAINER, 3, TrainerCooltrainermBlake, -1
	object_event 58,  6, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_GENERICTRAINER, 4, TrainerCooltrainermBrian, -1
	object_event 72, 10, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 4, TrainerCooltrainerfReena, -1
	object_event 37,  6, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_GENERICTRAINER, 2, TrainerCooltrainerfMegan, -1
	object_event 65,  7, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_GENERICTRAINER, 3, TrainerPsychicGilbert, -1
	object_event 58, 13, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_GENERICTRAINER, 3, TrainerBirdKeeperJose, -1
	object_event 60, 12, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, Route19TMSolarbeam, EVENT_ROUTE_19_TM_SOLARBEAM
	object_event 53, 12, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, Route19RareCandy, EVENT_ROUTE_19_RARE_CANDY
	object_event 21, 10, SPRITE_FISHER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route19FisherText, -1

	object_const_def
	const ROUTE19_COOLTRAINER_M1
	const ROUTE19_COOLTRAINER_M2
	const ROUTE19_COOLTRAINER_F1
	const ROUTE19_COOLTRAINER_F2
	const ROUTE19_YOUNGSTER1
	const ROUTE19_YOUNGSTER2
	const ROUTE19_POKE_BALL1
	const ROUTE19_POKE_BALL2
	const ROUTE19_FISHER

Route19_MapScripts:
	def_scene_scripts
	scene_script Route19Noop1Scene, SCENE_ROUTE19_FIRST_STEP_INTO_KANTO
	scene_script Route19Noop2Scene, SCENE_ROUTE19_NOOP

	def_callbacks

Route19Noop1Scene:
Route19Noop2Scene:
	end

LeftScene:
	turnobject ROUTE19_FISHER, LEFT
	showemote EMOTE_SHOCK, ROUTE19_FISHER, 15
	applymovement ROUTE19_FISHER, Route19FisherStepLeftTwiceMovement
	sjump FirstStepIntoKantoScene_Continue

Route19FisherStepLeftTwiceMovement:
	step LEFT
	step LEFT
	step_end

RightScene:
	turnobject ROUTE19_FISHER, LEFT
	showemote EMOTE_SHOCK, ROUTE19_FISHER, 15
	applymovement ROUTE19_FISHER, Route19FisherStepLeftOnceMovement
FirstStepIntoKantoScene_Continue:
	turnobject PLAYER, RIGHT
	opentext
	writethistext
		text "Hello there."
		done
	promptbutton
	writetext Route19FisherText
	waitclosetext
	setscene SCENE_ROUTE19_NOOP
	end

Route19FisherStepLeftOnceMovement:
	step LEFT
	step_end

TrainerPsychicGilbert:
	generictrainer PSYCHIC_T, GILBERT, EVENT_BEAT_PSYCHIC_GILBERT, .SeenText, .BeatenText

.AfterText
	text "With your skills,"
	line "you'll do well at"
	cont "the League."

	para "That's what my"
	line "premonition says."
	done

.SeenText
	text "Don't say a thing!"

	para "Let me guess what"
	line "you're thinking."

	para "Mmmmmmm…"

	para "I got it! You're"
	line "on the #mon"
	cont "League challenge!"
	done

.BeatenText
	text "You're too much!"
	done

TrainerBirdKeeperJose:
	generictrainer BIRD_KEEPER, JOSE, EVENT_BEAT_BIRD_KEEPER_JOSE, .SeenText, .BeatenText

.AfterText
	text "Bird Keepers like"
	line "me mimic bird"
	cont "whistles to com-"
	cont "mand #mon."

	para "Yes, we know we're"
	line "weirdos."
	done

.SeenText
	text "Tweet! Tweet!"
	line "Tetweet!"
	done

.BeatenText
	text "Tweet!"
	done

TrainerCooltrainermBlake:
	generictrainer COOLTRAINERM, BLAKE, EVENT_BEAT_COOLTRAINERM_BLAKE, .SeenText, .BeatenText

.AfterText
	text "If you prevail on"
	line "this harsh trek,"
	cont "the truth will be"
	cont "revealed!"

	para "Heh, sorry, I just"
	line "wanted to say"
	cont "something cool."
	done

.SeenText
	text "You look pretty"
	line "strong."

	para "Let me battle you!"
	done

.BeatenText
	text "Yow!"
	done

TrainerCooltrainermBrian:
	generictrainer COOLTRAINERM, BRIAN, EVENT_BEAT_COOLTRAINERM_BRIAN, .SeenText, .BeatenText

.AfterText
	text "A good trainer can"
	line "recognize other"
	cont "good trainers."
	done

.SeenText
	text "Hm? You're good,"
	line "aren't you?"
	done

.BeatenText
	text "Just as I thought!"
	done

TrainerCooltrainerfReena:
	trainer COOLTRAINERF, REENA1, EVENT_BEAT_COOLTRAINERF_REENA, CooltrainerfReenaSeenText, CooltrainerfReenaBeatenText, 0, .Script

.Script:
	loadvar VAR_CALLERID, PHONE_COOLTRAINERF_REENA
	opentext
	checkevent EVENT_REENA_MOON_STONE
	iftrue .RematchGift
	checkflag ENGINE_REENA_READY_FOR_REMATCH
	iftrue .WantsBattle
	checkcellnum PHONE_COOLTRAINERF_REENA
	iftrue .NumberAccepted
	checkevent EVENT_REENA_ASKED_FOR_PHONE_NUMBER
	iftrue .AskedAlready
	writetext CooltrainerfReenaAfterBattleText
	promptbutton
	setevent EVENT_REENA_ASKED_FOR_PHONE_NUMBER
	scall .AskNumber
	sjump .AskForNumber

.AskedAlready:
	scall .AskNumber
.AskForNumber:
	askforphonenumber PHONE_COOLTRAINERF_REENA
	ifequal PHONE_CONTACT_REFUSED, .NumberDeclined
	gettrainername STRING_BUFFER_3, COOLTRAINERF, REENA1
	scall .RegisteredNumber
	sjump .NumberAccepted

.WantsBattle:
	scall .Rematch
	winlosstext CooltrainerfReenaBeatenText, 0
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftrue .LoadFight2
	checkevent EVENT_BEAT_ELITE_FOUR
	iftrue .LoadFight1
	loadtrainer COOLTRAINERF, REENA1
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_REENA_READY_FOR_REMATCH
	end

.LoadFight1:
	loadtrainer COOLTRAINERF, REENA2
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_REENA_READY_FOR_REMATCH
	end

.LoadFight2:
	loadtrainer COOLTRAINERF, REENA3
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_REENA_READY_FOR_REMATCH
	opentext
	writetext CooltrainerfReenaText_GiveMoonStoneAfterBattle
	waitbutton
	verbosegiveitem MOON_STONE
	iffalse .PackFull
	closetext
	end

.RematchGift
	writetext CooltrainerfReenaText_AgainGiveMoonStoneAfterBattle
	waitbutton
	verbosegiveitem MOON_STONE
	iffalse .PackFull
	clearevent EVENT_REENA_MOON_STONE
	closetext
	end

.PackFull:
	setevent EVENT_REENA_MOON_STONE
	jumpstd PackFullFScript
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

TrainerCooltrainerfMegan:
	generictrainer COOLTRAINERF, MEGAN, EVENT_BEAT_COOLTRAINERF_MEGAN, .SeenText, .BeatenText

.AfterText
	text "Evolution really"
	line "does make #mon"
	cont "stronger."
	done

.SeenText
	text "It's rare to see"
	line "anyone come here."

	para "Are you training"
	line "on your own?"
	done

.BeatenText
	text "Oh! You're really"
	line "strong!"
	done

CooltrainerfReenaSeenText:
	text "You shouldn't"
	line "underestimate the"

	para "wild #MON in"
	line "these parts."
	done

CooltrainerfReenaBeatenText:
	text "Oh! You're much"
	line "too strong!"
	done

CooltrainerfReenaAfterBattleText:
	text "You're just a kid,"
	line "but you're not to"

	para "be underestimated"
	line "either."
	done



CooltrainerfReenaText_GiveMoonStoneAfterBattle:
	text "I'm in a giving"
	line "mood. Take this!"
	done

CooltrainerfReenaText_AgainGiveMoonStoneAfterBattle:
	text "Oh, back for my"
	line "gift, are you?"
	done

Route19FisherText:
	text "This way leads to"
	line "#mon League HQ."

	para "It's every trainer's"
	line "goal."

	para "The trek is harsh"
	line "and entry to the"
	cont "Victory Road isn't"
	cont "permitted unless a"
	cont "a trainer has all"
	cont "8 Johto Badges."

	para "I won't stop you…"
	line "Just be careful."
	done

TohjoFallsSignText:
	text "Tohjo Falls"

	para "Waterfall Cave"
	done

Route19TMSolarbeam:
	itemball TM_SOLARBEAM
Route19RareCandy:
	itemball RARE_CANDY
