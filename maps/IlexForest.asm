IlexForest_MapEvents:
	def_warp_events
	warp_event  1,  5, ROUTE_6_ILEX_FOREST_GATE, 3
	warp_event  3, 42, ILEX_FOREST_AZALEA_GATE, 1
	warp_event  3, 43, ILEX_FOREST_AZALEA_GATE, 2

	def_coord_events

	def_bg_events
	bg_event  3, 17, BGEVENT_JUMPTEXT, IlexForestSignpostText
	bg_event  8, 22, BGEVENT_UP, IlexForestShrineScript
	bg_event 11,  7, BGEVENT_ITEM + MAX_ETHER, EVENT_ILEX_FOREST_HIDDEN_MAX_ETHER
	bg_event 22, 14, BGEVENT_ITEM + HYPER_POTION, EVENT_ILEX_FOREST_HIDDEN_HYPER_POTION
	bg_event 22, 28, BGEVENT_ITEM + FULL_HEAL, EVENT_ILEX_FOREST_HIDDEN_FULL_HEAL
	bg_event  3, 33, BGEVENT_ITEM + LEAF_STONE, EVENT_ILEX_FOREST_HIDDEN_LEAF_STONE
	bg_event 13, 15, BGEVENT_ITEM + SUN_STONE, EVENT_ILEX_FOREST_HIDDEN_SUN_STONE
	bg_event 27,  1, BGEVENT_ITEM + SILVER_LEAF, EVENT_ILEX_FOREST_HIDDEN_SILVER_LEAF
	bg_event 10,  4, BGEVENT_ITEM + GOLD_LEAF, EVENT_ILEX_FOREST_HIDDEN_GOLD_LEAF
	bg_event 29, 22, BGEVENT_ITEM + GOLD_BERRY, EVENT_ILEX_FOREST_HIDDEN_GOLD_BERRY

	def_object_events
	chanseyheal_event 10, 4
	object_event 14, 31, SPRITE_SCYTHER_OW, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, IlexForestScytherScript, EVENT_ILEX_FOREST_SCYTHER
	object_event  7, 28, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, IlexForestCharcoalApprenticeScript, EVENT_ILEX_FOREST_APPRENTICE
	object_event  5, 28, SPRITE_BLACK_BELT, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, IlexForestCharcoalMasterScript, EVENT_ILEX_FOREST_CHARCOAL_MASTER
	object_event 15, 14, SPRITE_ROCKER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, IlexForestHeadbuttGuyScript, -1
	object_event  8, 29, SPRITE_KURT, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_ILEX_FOREST_KURT
	object_event  3, 24, SPRITE_LASS, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, IlexForestLassText, EVENT_ILEX_FOREST_LASS
	object_event 12,  1, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_GENERICTRAINER, 0, TrainerBugCatcherWayne, -1
	object_event  9, 17, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, PAL_NPC_TEAL, OBJECTTYPE_GENERICTRAINER, 3, TrainerBugCatcherAdam, -1
	object_event  2, 28, SPRITE_LASS, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_GENERICTRAINER, 4, TrainerLassSelina, -1
	object_event 22, 33, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_GENERICTRAINER, 1, TrainerSuperNerdTony, -1
	object_event 20, 32, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, IlexForestRevive, EVENT_ILEX_FOREST_REVIVE
	object_event 17,  7, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, IlexForestAntidote, EVENT_ILEX_FOREST_ANTIDOTE
	object_event 27,  1, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, IlexForestEther, EVENT_ILEX_FOREST_ETHER
	object_event  3, 40, SPRITE_S_MUSHROOM, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, IlexForestTinyMushroomScript, EVENT_ILEX_FOREST_TINY_MUSHROOM1
	object_event  1,  7, SPRITE_S_MUSHROOM, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, IlexForestTinyMushroomScript, EVENT_ILEX_FOREST_TINY_MUSHROOM2
	object_event 26, 22, SPRITE_L_MUSHROOM, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, IlexForestLargeMushroomScript, EVENT_ILEX_FOREST_LARGE_MUSHROOM

	object_const_def
	const ILEXFOREST_CHANSEY
	const ILEXFOREST_SCYTHER
	const ILEXFOREST_YOUNGSTER1
	const ILEXFOREST_BLACK_BELT
	const ILEXFOREST_ROCKER
	const ILEXFOREST_KURT
	const ILEXFOREST_LASS1
	const ILEXFOREST_BUGCATCHER1
	const ILEXFOREST_BUGCATCHER2
	const ILEXFOREST_LASS2
	const ILEXFOREST_SUPERNERD
	const ILEXFOREST_POKE_BALL1
	const ILEXFOREST_POKE_BALL2
	const ILEXFOREST_POKE_BALL3
	const ILEXFOREST_S_MUSHROOM1
	const ILEXFOREST_S_MUSHROOM2
	const ILEXFOREST_L_MUSHROOM

IlexForest_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, IlexForestScytherCallback

IlexForestCharcoalApprenticeScript:
	faceplayeropentext
	checkevent EVENT_HERDED_SCYTHER
	iftrue .DoneScyther
	jumpthisopenedtext
		text "Oh, man… My boss"
		line "is going to be"
		cont "steaming…"

		para "The Scyther that"
		line "Cuts trees for"
		cont "charcoal took off"
		cont "on me."

		para "I can't go looking"
		line "for it here in the"
		cont "Ilex Forest."

		para "It's too big, dark"
		line "and scary for me…"
		done

.DoneScyther:
	jumpthisopenedtext
		text "Wow! Thanks a"
		line "whole bunch!"

		para "My boss's #mon"
		line "hasn't warmed up to"
		cont "me yet…"
		done

IlexForestCharcoalMasterScript:
	faceplayeropentext
	checkevent EVENT_GOT_SCYTHER_CALL
	iftrue .AlreadyGotCut
	writethistext
		text "Ah! My Scyther!"

		para "You found it for"
		line "us, kid?"

		para "Without it, we"
		line "wouldn't be able"
		cont "to Cut trees for"
		cont "charcoal."

		para "Thanks, kid!"

		para "Now, how can I"
		line "thank you…"

		para "I know! Here, take"
		line "this."
		done
	promptbutton
	verbosegiveitem SCYTHER_CALL
	setevent EVENT_GOT_SCYTHER_CALL
	setevent EVENT_ILEX_FOREST_SCYTHER
	setevent EVENT_ILEX_FOREST_APPRENTICE
	setevent EVENT_ILEX_FOREST_CHARCOAL_MASTER
	clearevent EVENT_CHARCOAL_KILN_SCYTHER
	clearevent EVENT_CHARCOAL_KILN_APPRENTICE
	clearevent EVENT_CHARCOAL_KILN_BOSS
	jumpthisopenedtext
		text "That's the Call to"
		line "summon a Scyther"
		cont "to clear any small"
		cont "tree."

		para "Use it as you see"
		line "fit."
		done

.AlreadyGotCut:
	jumpthisopenedtext
		text "Do you want to"
		line "apprentice as a"
		cont "charcoal maker"
		cont "with me?"

		para "You'll be first-"
		line "rate in ten years!"
		done

IlexForestHeadbuttGuyScript:
	faceplayeropentext
	checkevent EVENT_GOT_TM_HEADBUTT
	iftrue .AlreadyGotHeadbutt
	writethistext
		text "What am I doing?"

		para "I'm shaking trees"
		line "using Headbutt."

		para "It's fun. Here,"
		line "you try it too!"
		done
	promptbutton
	verbosegiveitem TM_HEADBUTT
	iffalse_endtext
	setevent EVENT_GOT_TM_HEADBUTT
.AlreadyGotHeadbutt:
	jumpthisopenedtext
		text "Rattle trees with"
		line "Headbutt. Some-"
		cont "times, sleeping"
		cont "#mon or items"
		cont "fall out."
		done

IlexForestShrineScript:
	checkevent EVENT_FOREST_IS_RESTLESS ; this need to set to repeat this event
	iftrue .ForestIsRestless
	sjump .DontDoCelebiEvent

.ForestIsRestless:
	checkitem GS_BALL
	iftrue .AskCelebiEvent
.DontDoCelebiEvent:
	jumpthistext
		text "Ilex Forest"
		line "Shrine…"

		para "It's in honor of"
		line "the forest's"
		cont "protector…"
		done

.AskCelebiEvent:
	opentext
	writethistext
		text "Ilex Forest"
		line "Shrine…"

		para "It's in honor of"
		line "the forest's"
		cont "protector…"

		para "Oh? What is this?"

		para "It's a hole."
		line "It looks like the"

		para "GS Ball would fit"
		line "inside it."

		para "Want to put the GS"
		line "BalL here?"
		done
	yesorno
	iffalse_endtext
.CelebiEvent:
;	takeitem GS_BALL - don't take this, needed to repeat this event
	clearevent EVENT_FOREST_IS_RESTLESS
	setevent EVENT_AZALEA_TOWN_KURT
	setevent EVENT_CELEBI_FATEFUL_ENCOUNTER ; remove after and give proper event to #dex
	disappear ILEXFOREST_LASS1
	clearevent EVENT_ROUTE_6_ILEX_FOREST_GATE_LASS
	writethistext
		text "<PLAYER> put in the"
		line "GS Ball."
		done
	waitclosetext
	pause 20
	showemote EMOTE_SHOCK, PLAYER, 20
	special FadeOutMusic
	applymovement PLAYER, IlexForestPlayerStepsDownMovement
	pause 30
	turnobject PLAYER, DOWN
	pause 20
	clearflag ENGINE_FOREST_IS_RESTLESS
	special CelebiShrineEvent
	loadwildmon CELEBI, 30
	startbattle
	reloadmapafterbattle
	pause 20
	special CheckCaughtCelebi
	iffalse .DidntCatchCelebi
	appear ILEXFOREST_KURT
	applymovement ILEXFOREST_KURT, IlexForestKurtStepsUpMovement
	showthistext
		text "Whew, wasn't that"
		line "something!"

		para "<PLAYER>, that was"
		line "fantastic. Thanks!"

		para "The legends about"
		line "that Shrine were"
		cont "real after all."

		para "I feel inspired by"
		line "what I just saw."

		para "It motivates me to"
		line "make better Balls!"

		para "I'm going!"
		done
	applymovement ILEXFOREST_KURT, IlexForestKurtStepsDownMovement
	disappear ILEXFOREST_KURT
.DidntCatchCelebi:
	special RestartMapMusic
	end

IlexForestPlayerStepsDownMovement:
	fix_facing
	slow_step DOWN
	remove_fixed_facing
	step_end

IlexForestKurtStepsUpMovement:
	step UP
	step UP
	step UP
	step UP
	step_end

IlexForestKurtStepsDownMovement:
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step_end

TrainerBugCatcherWayne:
	generictrainer BUG_CATCHER, WAYNE, EVENT_BEAT_BUG_CATCHER_WAYNE, .SeenText, .BeatenText

.AfterText
	text "A #mon I've"
	line "never seen before"
	cont "fell out of the"
	cont "tree when I used"
	cont "Headbutt."

	para "I ought to use"
	line "Headbutt in other"
	cont "places too."
	done

.SeenText
	text "Let me try out"
	line "#mon that fell"
	cont "out this tree!"
	done

.BeatenText
	text "Oh… And I thought"
	line "they were strong…"
	done

TrainerBugCatcherAdam:
	generictrainer BUG_CATCHER, ADAM, EVENT_BEAT_BUG_CATCHER_ADAM, .SeenText, .BeatenText

.AfterText
	text "TODOTEXT"
	done

.SeenText
	text "TODOTEXT"
	done

.BeatenText
	text "TODOTEXT"
	done

TrainerLassSelina:
	generictrainer LASS, SELINA, EVENT_BEAT_LASS_SELINA, .SeenText, .BeatenText

.AfterText
	text "TODOTEXT"
	done

.SeenText
	text "TODOTEXT"
	done

.BeatenText
	text "TODOTEXT"
	done

TrainerSuperNerdTony:
	generictrainer SUPER_NERD, TONY, EVENT_BEAT_SUPER_NERD_TONY, .SeenText, .BeatenText

.AfterText
	text "TODOTEXT"
	done

.SeenText
	text "TODOTEXT"
	done

.BeatenText
	text "TODOTEXT"
	done

IlexForestScytherCallback:
	checkevent EVENT_GOT_SCYTHER_CALL
	iftrue .Static
	readmem wScytherPosition
	ifequal  1, .PositionOne
	ifequal  2, .PositionTwo
	ifequal  3, .PositionThree
	ifequal  4, .PositionFour
	ifequal  5, .PositionFive
	ifequal  6, .PositionSix
	ifequal  7, .PositionSeven
	ifequal  8, .PositionEight
	ifequal  9, .PositionNine
	ifequal 10, .PositionTen
.Static:
	endcallback

.PositionOne:
	moveobject ILEXFOREST_SCYTHER, 14, 31
	appear ILEXFOREST_SCYTHER
	endcallback

.PositionTwo:
	moveobject ILEXFOREST_SCYTHER, 15, 25
	appear ILEXFOREST_SCYTHER
	endcallback

.PositionThree:
	moveobject ILEXFOREST_SCYTHER, 20, 24
	appear ILEXFOREST_SCYTHER
	endcallback

.PositionFour:
	moveobject ILEXFOREST_SCYTHER, 29, 22
	appear ILEXFOREST_SCYTHER
	endcallback

.PositionFive:
	moveobject ILEXFOREST_SCYTHER, 28, 31
	appear ILEXFOREST_SCYTHER
	endcallback

.PositionSix:
	moveobject ILEXFOREST_SCYTHER, 24, 35
	appear ILEXFOREST_SCYTHER
	endcallback

.PositionSeven:
	moveobject ILEXFOREST_SCYTHER, 22, 31
	appear ILEXFOREST_SCYTHER
	endcallback

.PositionEight:
	moveobject ILEXFOREST_SCYTHER, 15, 29
	appear ILEXFOREST_SCYTHER
	endcallback

.PositionNine:
	moveobject ILEXFOREST_SCYTHER, 10, 35
	appear ILEXFOREST_SCYTHER
	endcallback

.PositionTen:
	moveobject ILEXFOREST_SCYTHER, 6, 28
	appear ILEXFOREST_SCYTHER
	endcallback

IlexForestScytherScript:
	readmem wScytherPosition
	ifequal  1, .Position1
	ifequal  2, .Position2
	ifequal  3, .Position3
	ifequal  4, .Position4
	ifequal  5, .Position5
	ifequal  6, .Position6
	ifequal  7, .Position7
	ifequal  8, .Position8
	ifequal  9, .Position9
	ifequal 10, .Position10

.Position1:
	setval SCYTHER
	special SetMonAsSeen
	faceplayeropentext
	writethistext
		text "It's the missing"
		line "#mon!"
		done
	promptbutton
	cry SCYTHER
	writethistext
		text "Scyther: Scyth!"
		done
	waitclosetext
	applymovement ILEXFOREST_SCYTHER, MovementData_Scyther_Pos1_Pos2
	moveobject ILEXFOREST_SCYTHER, 15, 25
	disappear ILEXFOREST_SCYTHER
	appear ILEXFOREST_SCYTHER
	loadmem wScytherPosition, 2
	end

.Position2:
	scall .CryAndCheckFacing
	ifequal DOWN, .Position2_Down
	applymovement ILEXFOREST_SCYTHER, MovementData_Scyther_Pos2_Pos3
	moveobject ILEXFOREST_SCYTHER, 20, 24
	disappear ILEXFOREST_SCYTHER
	appear ILEXFOREST_SCYTHER
	loadmem wScytherPosition, 3
	end

.Position2_Down:
	applymovement ILEXFOREST_SCYTHER, MovementData_Scyther_Pos2_Pos8
	moveobject ILEXFOREST_SCYTHER, 15, 29
	disappear ILEXFOREST_SCYTHER
	appear ILEXFOREST_SCYTHER
	loadmem wScytherPosition, 8
	end

.Position3:
	scall .CryAndCheckFacing
	ifequal LEFT, .Position3_Left
	applymovement ILEXFOREST_SCYTHER, MovementData_Scyther_Pos3_Pos4
	moveobject ILEXFOREST_SCYTHER, 29, 22
	disappear ILEXFOREST_SCYTHER
	appear ILEXFOREST_SCYTHER
	loadmem wScytherPosition, 4
	end

.Position3_Left:
	applymovement ILEXFOREST_SCYTHER, MovementData_Scyther_Pos3_Pos2
	moveobject ILEXFOREST_SCYTHER, 15, 25
	disappear ILEXFOREST_SCYTHER
	appear ILEXFOREST_SCYTHER
	loadmem wScytherPosition, 2
	end

.Position4:
	scall .CryAndCheckFacing
	ifequal UP, .Position4_Up
	applymovement ILEXFOREST_SCYTHER, MovementData_Scyther_Pos4_Pos5
	moveobject ILEXFOREST_SCYTHER, 28, 31
	disappear ILEXFOREST_SCYTHER
	appear ILEXFOREST_SCYTHER
	loadmem wScytherPosition, 5
	end

.Position4_Up:
	applymovement ILEXFOREST_SCYTHER, MovementData_Scyther_Pos4_Pos3
	moveobject ILEXFOREST_SCYTHER, 20, 24
	disappear ILEXFOREST_SCYTHER
	appear ILEXFOREST_SCYTHER
	loadmem wScytherPosition, 3
	end

.Position5:
	scall .CryAndCheckFacing
	ifequal UP, .Position5_Up
	ifequal LEFT, .Position5_Left
	ifequal RIGHT, .Position5_Right
	applymovement ILEXFOREST_SCYTHER, MovementData_Scyther_Pos5_Pos6
	moveobject ILEXFOREST_SCYTHER, 24, 35
	disappear ILEXFOREST_SCYTHER
	appear ILEXFOREST_SCYTHER
	loadmem wScytherPosition, 6
	end

.Position5_Left:
	applymovement ILEXFOREST_SCYTHER, MovementData_Scyther_Pos5_Pos7
	moveobject ILEXFOREST_SCYTHER, 22, 31
	disappear ILEXFOREST_SCYTHER
	appear ILEXFOREST_SCYTHER
	loadmem wScytherPosition, 7
	end

.Position5_Up:
	applymovement ILEXFOREST_SCYTHER, MovementData_Scyther_Pos5_Pos4_Up
	moveobject ILEXFOREST_SCYTHER, 29, 22
	disappear ILEXFOREST_SCYTHER
	appear ILEXFOREST_SCYTHER
	loadmem wScytherPosition, 4
	end

.Position5_Right:
	applymovement ILEXFOREST_SCYTHER, MovementData_Scyther_Pos5_Pos4_Right
	moveobject ILEXFOREST_SCYTHER, 29, 22
	disappear ILEXFOREST_SCYTHER
	appear ILEXFOREST_SCYTHER
	loadmem wScytherPosition, 4
	end

.Position6:
	scall .CryAndCheckFacing
	ifequal RIGHT, .Position6_Right
	applymovement ILEXFOREST_SCYTHER, MovementData_Scyther_Pos6_Pos7
	moveobject ILEXFOREST_SCYTHER, 22, 31
	disappear ILEXFOREST_SCYTHER
	appear ILEXFOREST_SCYTHER
	loadmem wScytherPosition, 7
	end

.Position6_Right:
	applymovement ILEXFOREST_SCYTHER, MovementData_Scyther_Pos6_Pos5
	moveobject ILEXFOREST_SCYTHER, 28, 31
	disappear ILEXFOREST_SCYTHER
	appear ILEXFOREST_SCYTHER
	loadmem wScytherPosition, 5
	end

.Position7:
	scall .CryAndCheckFacing
	ifequal DOWN, .Position7_Down
	ifequal LEFT, .Position7_Left
	applymovement ILEXFOREST_SCYTHER, MovementData_Scyther_Pos7_Pos8
	moveobject ILEXFOREST_SCYTHER, 15, 29
	disappear ILEXFOREST_SCYTHER
	appear ILEXFOREST_SCYTHER
	loadmem wScytherPosition, 8
	end

.Position7_Left:
	applymovement ILEXFOREST_SCYTHER, MovementData_Scyther_Pos7_Pos6
	moveobject ILEXFOREST_SCYTHER, 24, 35
	disappear ILEXFOREST_SCYTHER
	appear ILEXFOREST_SCYTHER
	loadmem wScytherPosition, 6
	end

.Position7_Down:
	applymovement ILEXFOREST_SCYTHER, MovementData_Scyther_Pos7_Pos5
	moveobject ILEXFOREST_SCYTHER, 28, 31
	disappear ILEXFOREST_SCYTHER
	appear ILEXFOREST_SCYTHER
	loadmem wScytherPosition, 5
	end

.Position8:
	scall .CryAndCheckFacing
	ifequal UP, .Position8_Up
	ifequal LEFT, .Position8_Left
	ifequal RIGHT, .Position8_Right
	applymovement ILEXFOREST_SCYTHER, MovementData_Scyther_Pos8_Pos9
	moveobject ILEXFOREST_SCYTHER, 10, 35
	disappear ILEXFOREST_SCYTHER
	appear ILEXFOREST_SCYTHER
	loadmem wScytherPosition, 9
	end

.Position8_Right:
	applymovement ILEXFOREST_SCYTHER, MovementData_Scyther_Pos8_Pos7
	moveobject ILEXFOREST_SCYTHER, 22, 31
	disappear ILEXFOREST_SCYTHER
	appear ILEXFOREST_SCYTHER
	loadmem wScytherPosition, 7
	end

.Position8_Up:
.Position8_Left:
	applymovement ILEXFOREST_SCYTHER, MovementData_Scyther_Pos8_Pos2
	moveobject ILEXFOREST_SCYTHER, 15, 25
	disappear ILEXFOREST_SCYTHER
	appear ILEXFOREST_SCYTHER
	loadmem wScytherPosition, 2
	end

.Position9:
	scall .CryAndCheckFacing
	ifequal DOWN, .Position9_Down
	ifequal RIGHT, .Position9_Right
	applymovement ILEXFOREST_SCYTHER, MovementData_Scyther_Pos9_Pos10
	moveobject ILEXFOREST_SCYTHER, 6, 28
	disappear ILEXFOREST_SCYTHER
	appear ILEXFOREST_SCYTHER
	loadmem wScytherPosition, 10
	appear ILEXFOREST_BLACK_BELT
	setevent EVENT_CHARCOAL_KILN_BOSS
	setevent EVENT_HERDED_SCYTHER
	end

.Position9_Right:
	applymovement ILEXFOREST_SCYTHER, MovementData_Scyther_Pos9_Pos8_Right
	moveobject ILEXFOREST_SCYTHER, 15, 29
	disappear ILEXFOREST_SCYTHER
	appear ILEXFOREST_SCYTHER
	loadmem wScytherPosition, 8
	end

.Position9_Down:
	applymovement ILEXFOREST_SCYTHER, MovementData_Scyther_Pos9_Pos8_Down
	moveobject ILEXFOREST_SCYTHER, 15, 29
	disappear ILEXFOREST_SCYTHER
	appear ILEXFOREST_SCYTHER
	loadmem wScytherPosition, 8
	end

.Position10:
	reanchormap
	pokepic SCYTHER
	cry SCYTHER
	waitbutton
	closepokepic
	jumpthistextfaceplayer
		text "Scyther: Scyth!"
		done

.CryAndCheckFacing:
	faceplayer
	cry SCYTHER
	showthistext
		text "Scyther: Scyth!"
		done
	readvar VAR_FACING
	end

MovementData_Scyther_Pos1_Pos2:
	big_step UP
	big_step UP
	big_step UP
	big_step UP
	big_step UP
	step_end

MovementData_Scyther_Pos2_Pos3:
	big_step UP
	big_step UP
	big_step RIGHT
	big_step RIGHT
	big_step RIGHT
	big_step RIGHT
	big_step RIGHT
	big_step DOWN
	step_end

MovementData_Scyther_Pos2_Pos8:
	big_step DOWN
	big_step DOWN
	big_step DOWN
	big_step DOWN
	big_step DOWN
	step_end

MovementData_Scyther_Pos3_Pos4:
	big_step RIGHT
	big_step RIGHT
	big_step RIGHT
	big_step RIGHT
	big_step RIGHT
	big_step RIGHT
	step_end

MovementData_Scyther_Pos3_Pos2:
	big_step UP
	big_step LEFT
	big_step LEFT
	big_step LEFT
	big_step LEFT
	step_end

MovementData_Scyther_Pos4_Pos5:
	big_step DOWN
	big_step DOWN
	big_step DOWN
	big_step DOWN
	big_step DOWN
	big_step DOWN
	step_end

MovementData_Scyther_Pos4_Pos3:
	big_step LEFT
	jump_step LEFT
	big_step LEFT
	big_step LEFT
	step_end

MovementData_Scyther_Pos5_Pos6:
	big_step DOWN
	big_step DOWN
	big_step DOWN
	big_step DOWN
	big_step DOWN
	big_step LEFT
	big_step LEFT
	big_step LEFT
	big_step LEFT
	step_end

MovementData_Scyther_Pos5_Pos7:
	big_step LEFT
	big_step LEFT
	big_step LEFT
	big_step LEFT
	step_end

MovementData_Scyther_Pos5_Pos4_Up:
	big_step UP
	big_step UP
	big_step UP
	big_step RIGHT
	big_step UP
	step_end

MovementData_Scyther_Pos5_Pos4_Right:
	big_step RIGHT
	turn_head UP
	step_sleep 1
	turn_head DOWN
	step_sleep 1
	turn_head UP
	step_sleep 1
	big_step DOWN
	big_step DOWN
	fix_facing
	jump_step UP
	step_sleep 8
	step_sleep 8
	remove_fixed_facing
	big_step UP
	big_step UP
	big_step UP
	big_step UP
	big_step UP
	step_end

MovementData_Scyther_Pos6_Pos7:
	big_step LEFT
	big_step LEFT
	big_step LEFT
	big_step UP
	big_step UP
	big_step UP
	big_step RIGHT
	big_step UP
	step_end

MovementData_Scyther_Pos6_Pos5:
	big_step RIGHT
	big_step RIGHT
	big_step RIGHT
	big_step RIGHT
	big_step UP
	big_step UP
	big_step UP
	big_step UP
	step_end

MovementData_Scyther_Pos7_Pos8:
	big_step UP
	big_step UP
	big_step LEFT
	big_step LEFT
	big_step LEFT
	big_step LEFT
	big_step LEFT
	step_end

MovementData_Scyther_Pos7_Pos6:
	big_step DOWN
	big_step LEFT
	big_step DOWN
	big_step DOWN
	big_step DOWN
	big_step RIGHT
	big_step RIGHT
	big_step RIGHT
	step_end

MovementData_Scyther_Pos7_Pos5:
	big_step RIGHT
	big_step RIGHT
	big_step RIGHT
	big_step RIGHT
	big_step RIGHT
	big_step RIGHT
	step_end

MovementData_Scyther_Pos8_Pos9:
	big_step DOWN
	big_step LEFT
	big_step DOWN
	big_step DOWN
	big_step DOWN
	big_step DOWN
	big_step DOWN
	step_end

MovementData_Scyther_Pos8_Pos7:
	big_step RIGHT
	big_step RIGHT
	big_step RIGHT
	big_step RIGHT
	big_step RIGHT
	step_end

MovementData_Scyther_Pos8_Pos2:
	big_step UP
	big_step UP
	big_step UP
	big_step UP
	step_end

MovementData_Scyther_Pos9_Pos10:
	big_step LEFT
	big_step LEFT
	fix_facing
	jump_step RIGHT
	step_sleep 8
	step_sleep 8
	remove_fixed_facing
	big_step LEFT
	big_step LEFT
	big_step UP
	big_step UP
	big_step UP
	big_step UP
	big_step UP
	big_step UP
	step_end

MovementData_Scyther_Pos9_Pos8_Right:
	big_step RIGHT
	big_step RIGHT
	big_step RIGHT
	big_step RIGHT
	big_step UP
	big_step UP
	big_step UP
	big_step UP
	big_step UP
	step_end

MovementData_Scyther_Pos9_Pos8_Down:
	big_step LEFT
	big_step LEFT
	fix_facing
	jump_step RIGHT
	step_sleep 8
	step_sleep 8
	remove_fixed_facing
	big_step RIGHT
	big_step RIGHT
	big_step RIGHT
	big_step RIGHT
	big_step UP
	big_step UP
	big_step UP
	big_step UP
	big_step UP
	step_end

IlexForestLargeMushroomScript:
	scall IlexForestShroomishBattle
	giveitem BIG_MUSHROOM
	getitemname STRING_BUFFER_3, BIG_MUSHROOM
	iffalse IlexForestNoRoomInBagForMushroom
	sjump IlexForestGiveMushroom

IlexForestTinyMushroomScript:
	scall IlexForestShroomishBattle
	random 10
	ifequal 0, .big
	giveitem TINYMUSHROOM
	getitemname STRING_BUFFER_3, TINYMUSHROOM
	sjump .continue

.big
	giveitem BIG_MUSHROOM
	getitemname STRING_BUFFER_3, BIG_MUSHROOM
.continue
	iffalse IlexForestNoRoomInBagForMushroom
IlexForestGiveMushroom:
	disappear LAST_TALKED
	opentext
	writetext IlexForestFoundMushroomText
	playsound SFX_ITEM
	waitsfx
	itemnotify
	endtext

IlexForestShroomishBattle:
	random 3
	ifnotequal 0, .skip
	loadvar VAR_BATTLETYPE, BATTLETYPE_TRAP
	loadwildmon SHROOMISH, 8
	cry SHROOMISH
	startbattle
	reloadmapafterbattle
.skip
	end

IlexForestNoRoomInBagForMushroom:
	opentext
	getitemname STRING_BUFFER_3, TINYMUSHROOM
	writetext IlexForestFoundMushroomText
	promptbutton
	writetext IlexForestNoRoomForMushroomText
	waitendtext

IlexForestFoundMushroomText:
	text_far _PlayerFoundItemText
	text_end

IlexForestNoRoomForMushroomText:
	text_far _CantCarryItemText
	text_end

IlexForestLassText:
	text "Did something"
	line "happen to the"
	cont "forest's guardian?"
	done

IlexForestSignpostText:
	text "Ilex Forest is"
	line "so overgrown with"
	cont "trees that you"
	cont "can't see the sky."

	para "Please watch out"
	line "for items that may"
	cont "have been dropped."
	done

IlexForestRevive:
	itemball REVIVE
IlexForestAntidote:
	itemball ANTIDOTE
IlexForestEther:
	itemball ETHER
