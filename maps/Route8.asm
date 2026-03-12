Route8_MapEvents:
	def_warp_events
	warp_event 18,  8, ROUTE_8_NATIONAL_PARK_GATE, 3
	warp_event 18,  9, ROUTE_8_NATIONAL_PARK_GATE, 4
	warp_event 47, 13, ROUTE_8_RUINS_OF_ALPH_GATE, 1
	warp_event 48, 13, ROUTE_8_RUINS_OF_ALPH_GATE, 2

	def_coord_events
	coord_event 20,  7, SCENE_ROUTE8_SUICUNE, Route8SuicuneScript
	coord_event 22,  7, SCENE_ROUTE8_SUICUNE, Route8SuicuneScript

	def_bg_events
	bg_event 29,  1, BGEVENT_JUMPTEXT, Route8TrainerTips2Text
	bg_event 45, 11, BGEVENT_JUMPTEXT, RuinsOfAlphNorthSignText
	bg_event 55,  7, BGEVENT_JUMPTEXT, Route8SignText
	bg_event 21,  7, BGEVENT_JUMPTEXT, Route8TrainerTips1Text
	bg_event 21,  4, BGEVENT_JUMPSTD, NO_BERRY_OR_FRUIT_SCRIPT
	bg_event 50,  4, BGEVENT_JUMPSTD, NO_BERRY_OR_FRUIT_SCRIPT
	bg_event 51,  5, BGEVENT_JUMPSTD, NO_BERRY_OR_FRUIT_SCRIPT

	def_object_events
	object_event 20, 12, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_GENERICTRAINER, 3, TrainerPsychicMark, -1
	object_event 31, 14, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_GENERICTRAINER, 5, TrainerSchoolboyAlan, -1
	object_event 37,  6, SPRITE_SUDOWOODO, SPRITEMOVEDATA_SUDOWOODO, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SudowoodoScript, EVENT_ROUTE_8_SUDOWOODO
	object_event 51,  7, SPRITE_LASS, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 2, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route8LassText, -1
	object_event 44,  9, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route8RockSmashGuyScript, -1
	object_event 46,  6, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ArthurScript, EVENT_ROUTE_8_ARTHUR_OF_THURSDAY
	object_event 21,  6, SPRITE_SUICUNE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_SAW_SUICUNE_ON_ROUTE_8
	object_event 21,  4, SPRITE_BERRY, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_WHITE, OBJECTTYPE_SCRIPT, 0, Route8BerryTree1, EVENT_ROUTE_8_BERRY_1
	object_event 51,  5, SPRITE_BERRY, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, Route8BerryTree2, EVENT_ROUTE_8_BERRY_2
	object_event 50,  4, SPRITE_APRICORN, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, Route8ApricornTree1, EVENT_ROUTE_8_APRICORN_1

	object_const_def
	const ROUTE8_YOUNGSTER1
	const ROUTE8_YOUNGSTER2
	const ROUTE8_WEIRD_TREE
	const ROUTE8_LASS1
	const ROUTE8_FISHER
	const ROUTE8_ARTHUR
	const ROUTE8_SUICUNE
	const ROUTE8_BERRY_TREE1
	const ROUTE8_BERRY_TREE2
	const ROUTE8_APRICORN_TREE1

Route8_MapScripts:
	def_scene_scripts
	scene_script Route8Noop1Scene, SCENE_ROUTE8_NOOP
	scene_script Route8Noop2Scene, SCENE_ROUTE8_SUICUNE

	def_callbacks
	callback MAPCALLBACK_OBJECTS, Route8ArthurCallback

Route8Noop1Scene:
Route8Noop2Scene:
	end

Route8ArthurCallback:
	readvar VAR_WEEKDAY
	ifequal THURSDAY, .ArthurAppears
	disappear ROUTE8_ARTHUR
	endcallback

.ArthurAppears:
	appear ROUTE8_ARTHUR
	endcallback

Route8SuicuneScript:
	showemote EMOTE_SHOCK, PLAYER, 15
	pause 15
	playsound SFX_WARP_FROM
	turnobject PLAYER, UP
	applymovement ROUTE8_SUICUNE, Route8SuicuneMovement
	disappear ROUTE8_SUICUNE
	turnobject PLAYER, DOWN
	pause 10
	setscene SCENE_ROUTE8_NOOP
	clearevent EVENT_SAW_SUICUNE_AT_CIANWOOD_CITY
	setmapscene CIANWOOD_CITY, SCENE_CIANWOODCITY_SUICUNE_AND_EUSINE
	end

Route8SuicuneMovement:
	set_sliding
	fast_jump_step DOWN
	fast_jump_step DOWN
	fast_jump_step DOWN
	fast_jump_step RIGHT
	fast_jump_step RIGHT
	fast_jump_step RIGHT
	remove_sliding
	step_end

SudowoodoScript:
	checkitem SQUIRTBOTTLE
	iftrue .Fight
	waitsfx
	playsound SFX_SANDSTORM
	applymovement ROUTE8_WEIRD_TREE, SudowoodoShakeMovement
	end

.Fight:
	opentext
	writethistext
		text "It's a weird tree."
		line "Use Squirtbottle?"
		done
	yesorno
	iffalse_endtext
	closetext
WateredWeirdTreeScript:: ; export (for when you use Squirtbottle from pack)
	showthistext
		text "<PLAYER> used the"
		line "Squirtbottle."
		done
	waitsfx
	playsound SFX_SANDSTORM
	applymovement ROUTE8_WEIRD_TREE, SudowoodoShakeMovement
	showthistext
		text "The weird tree"
		line "doesn't like the"
		cont "Squirtbottle!"

		para "The weird tree"
		line "attacked!"
		done
	setevent EVENT_FOUGHT_SUDOWOODO
	loadwildmon SUDOWOODO, 20
	startbattle
	ifequal DRAW, DidntCatchSudowoodo
	disappear ROUTE8_WEIRD_TREE
	reloadmapafterbattle
	end

SudowoodoShakeMovement:
	tree_shake
	step_end

DidntCatchSudowoodo:
	reloadmapafterbattle
	applymovement ROUTE8_WEIRD_TREE, WeirdTreeMovement_Flee
	disappear ROUTE8_WEIRD_TREE
	special RefreshSprites
	end

WeirdTreeMovement_Flee:
	fast_jump_step UP
	fast_jump_step UP
	step_end

Route8RockSmashGuyScript:
	faceplayeropentext
	checkevent EVENT_GOT_TM_BRICK_BREAK
	iftrue .AlreadyGotRockSmash
	checkevent EVENT_FOUGHT_SUDOWOODO
	iftrue .ClearedSudowoodo
	jumpthisopenedtext
		text "Wa-hey!"

		para "I was going to"
		line "snap that tree"
		cont "with my straight-"
		cont "arm punch."

		para "But I couldn't!"
		line "I'm a failure!"
		done

.ClearedSudowoodo:
	writethistext
		text "Did you clear that"
		line "wretched tree?"

		para "I'm impressed!"

		para "I want you to"
		line "have this."
		done
	promptbutton
	verbosegiveitem TM_BRICK_BREAK
	iffalse_endtext
	setevent EVENT_GOT_TM_BRICK_BREAK
.AlreadyGotRockSmash:
	jumpthisopenedtext
		text "That happens to be"
		line "Brick Break."

		para "You can shatter"
		line "rocks with just a"
		cont "single well-aimed"
		cont "smack."

		para "If any rocks are"
		line "in your way, just"
		cont "smash 'em up!"

		para "It breaks Reflect"
		line "and Light Screen"
		cont "in battle too!"
		done

TrainerSchoolboyAlan:
	generictrainer SCHOOLBOY, ALAN, EVENT_BEAT_SCHOOLBOY_ALAN, .SeenText, .BeatenText

.AfterText
	text "Darn. I study five"
	line "hours a day too."

	para "There's more to"
	line "learning than just"
	cont "reading books."
	done

.SeenText
	text "Thanks to my stud-"
	line "ies, I'm ready for"
	cont "any #mon!"
	done

.BeatenText
	text "Oops! Computation"
	line "error?"
	done

TrainerPsychicMark:
	generictrainer PSYCHIC_T, MARK, EVENT_BEAT_PSYCHIC_MARK, .SeenText, .BeatenText

.AfterText
	text "I'd be strong if"
	line "only I could tell"
	cont "what my opponent"
	cont "was thinking."
	done

.SeenText
	text "I'm going to read"
	line "your thoughts!"
	done

.BeatenText
	text "I misread you!"
	done

ArthurScript:
	faceplayeropentext
	checkevent EVENT_GOT_HARD_STONE_FROM_ARTHUR
	iftrue .AlreadyGotStone
	readvar VAR_WEEKDAY
	ifnotequal THURSDAY, ArthurNotThursdayScript
	checkevent EVENT_MET_ARTHUR_OF_THURSDAY
	iftrue .MetArthur
	writethistext
		text "Arthur: Who are"
		line "you?"

		para "I'm Arthur of"
		line "Thursday."
		done
	promptbutton
	setevent EVENT_MET_ARTHUR_OF_THURSDAY
.MetArthur:
	writethistext
		text "Here. You can have"
		line "this."
		done
	promptbutton
	verbosegiveitem HARD_STONE
	iffalse_endtext
	setevent EVENT_GOT_HARD_STONE_FROM_ARTHUR
	jumpthisopenedtext
	text "Arthur: A #mon"
	line "that uses rock-"
	cont "type moves should"
	cont "hold on to that."

	para "It pumps up rock-"
	line "type attacks."
	done

.AlreadyGotStone:
	jumpthisopenedtext
		text "Arthur: I'm Arthur"
		line "of Thursday. I'm"
		cont "the second son out"
		cont "of seven children."
		done

ArthurNotThursdayScript:
	jumpthisopenedtext
		text "Arthur: Today's"
		line "not Thursday. How"
		cont "disappointing."
		done

Route8LassText:
	text "I am going west to"
	line "Goldenrod City for"
	cont "a shopping spree."
	
	para "The Dept.Store has"
	line "unmatched variety."
	done

Route8SignText:
	text "Route 8"
	done

RuinsOfAlphNorthSignText:
	text "Ruins Of Alph"
	line "North Entrance"
	done

Route8TrainerTips1Text:
	text "Trainer Tips"

	para "#mon stats do"
	line "not vary within"
	cont "the same species."

	para "Core Trait and if"
	line "of alternate color"
	cont "are all their uni-"
	cont "que differences."
	done

Route8TrainerTips2Text:
	text "Trainer Tips"

	para "Use Dig or Escape"
	line "Rope to return to"
	cont "the entrance of"
	cont "caves and certain"
	cont "landmarks."
	
	text "Teleport returns"
	line "you to the last"
	cont "#mon Center"
	cont "visited regardless"
	cont "of where you are"
	cont "presently."

	para "They're convenient"
	line "for exploring"
	done

Route8BerryTree1:
	setval ICE_BERRY
	jumpstd BerryOrFruitScript
Route8BerryTree2:
	setval BERRY
	jumpstd BerryOrFruitScript
Route8ApricornTree1:
	setval PNK_APRICORN
	jumpstd BerryOrFruitScript
