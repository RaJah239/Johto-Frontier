OaksLab_MapEvents:
	def_warp_events
	warp_event  4, 11, BATTLE_PLAZA, 4
	warp_event  5, 11, BATTLE_PLAZA, 4

	def_coord_events
	coord_event  4,  6, SCENE_OAKS_LAB_NAYRU62, Nayru62CoordScript1
	coord_event  5,  6, SCENE_OAKS_LAB_NAYRU62, Nayru62CoordScript2

	def_bg_events
	bg_event  6,  1, BGEVENT_JUMPSTD, DIFFICULT_BOOKSHELF_SCRIPT
	bg_event  7,  1, BGEVENT_JUMPSTD, DIFFICULT_BOOKSHELF_SCRIPT
	bg_event  8,  1, BGEVENT_JUMPSTD, DIFFICULT_BOOKSHELF_SCRIPT
	bg_event  9,  1, BGEVENT_JUMPSTD, DIFFICULT_BOOKSHELF_SCRIPT
	bg_event  0,  7, BGEVENT_JUMPSTD, DIFFICULT_BOOKSHELF_SCRIPT
	bg_event  1,  7, BGEVENT_JUMPSTD, DIFFICULT_BOOKSHELF_SCRIPT
	bg_event  2,  7, BGEVENT_JUMPSTD, DIFFICULT_BOOKSHELF_SCRIPT
	bg_event  3,  7, BGEVENT_JUMPSTD, DIFFICULT_BOOKSHELF_SCRIPT
	bg_event  6,  7, BGEVENT_JUMPSTD, DIFFICULT_BOOKSHELF_SCRIPT
	bg_event  7,  7, BGEVENT_JUMPSTD, DIFFICULT_BOOKSHELF_SCRIPT
	bg_event  8,  7, BGEVENT_JUMPSTD, DIFFICULT_BOOKSHELF_SCRIPT
	bg_event  9,  7, BGEVENT_JUMPSTD, DIFFICULT_BOOKSHELF_SCRIPT
	bg_event  4,  0, BGEVENT_JUMPTEXT, OaksLabPoster1Text
	bg_event  5,  0, BGEVENT_JUMPTEXT, OaksLabPoster2Text
	bg_event  9,  3, BGEVENT_JUMPTEXT, OaksLabTrashcanText
	bg_event  0,  1, BGEVENT_JUMPTEXT, OaksLabPCText

	def_object_events
	chanseyheal_event 8, 4
	porygonpc_event 0, 4, PAL_NPC_RED
	object_event  4,  2, SPRITE_OAK, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, OakScript, -1
	object_event  3,  5, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, Nayru62Script, EVENT_OAKSLAB_NAYRU62
	object_event  1,  8, SPRITE_SCIENTIST, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, OaksAssistant1Text, -1
	object_event  7,  8, SPRITE_SCIENTIST, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, OaksAssistant2Text, -1

	object_const_def
	const OAKSLAB_CHANSEY
	const OAKSLAB_PORYGON_PC
	const OAKSLAB_OAK
	const OAKSLAB_NAYRU62
	const OAKSLAB_SCIENTIST1
	const OAKSLAB_SCIENTIST2

OaksLab_MapScripts:
	def_scene_scripts
	scene_script OaksLabNoop1Scene, SCENE_OAKS_LAB_NAYRU62
	scene_script OaksLabFNoop2Scene, SCENE_OAKS_LAB_NOOP

	def_callbacks

OaksLabNoop1Scene:
OaksLabFNoop2Scene:
	end

OakScript:
	faceplayeropentext
	checkevent EVENT_TALKED_TO_OAK_IN_BATTLE_PLAZA
	iftrue .CheckPokedexOrBattle
	writethistext
		text "Oak: Ah, <PLAY_G>!"
		line "I've heard of you"
		cont "from Elm."

		para "You made it far"
		line "from New Bark!"

		para "Give my regards"
		line "to Elm when you"
		cont "see him."

		para "My lab was moved"
		line "here from another"
		cont "region."

		para "I was a serious"
		line "#mon trainer"
		cont "aback and still"
		cont "dabble in battles"
		cont "today."

		para "Talk to me again"
		line "if you think you"
		cont "are up for a ser-"
		cont "ious challenge."
		done
	promptbutton
	setevent EVENT_TALKED_TO_OAK_IN_BATTLE_PLAZA
.CheckPokedex:
	writethistext
		text "How is your #-"
		line "dex coming?"

		para "Let's see…"
		done
	waitbutton
	special ProfOaksPCBoot
	jumpthisopenedtext
		text "If you're in the"
		line "area, I hope you"
		cont "come visit again."
		done

.CheckPokedexOrBattle:
	writethistext
		text "Say, <PLAYER>,"
		line "are you up for"
		cont "a practice battle?"
		done
	yesorno
	iffalse .CheckPokedex
	writethistext
		text "Great! Don't worry"
		line "about losing here."

		para "You'll not get a"
		line "whiteout."

		para "Let's both of us"
		line "do our best 8-)"
		done
	waitclosetext
	special SaveMusic
	winlosstext .BeatenText, 0
	loadtrainer POKEMON_PROF, OAK1
	startbattle
	reloadmap
	special RestoreMusic
	special HealParty
	jumpthistext
		text "That was pretty"
		line "fun, wasn't it?"

		para "Drop by anytime"
		line "for another go."
		done

.BeatenText
	text "Seems you love"
	line "battling as much"
	cont "as I did in my"
	cont "youth!"
	done

Nayru62CoordScript1:
	turnobject PLAYER, LEFT
	turnobject OAKSLAB_NAYRU62, RIGHT
	showemote EMOTE_SHOCK, OAKSLAB_NAYRU62, 15
	waitsfx
	applymovement OAKSLAB_NAYRU62, OaksLabNayru62ApproachesMovement1
	turnobject OAKSLAB_NAYRU62, DOWN
	turnobject PLAYER, UP
	opentext
	writetext Nayru62IntroText
	waitbutton
	scall Nayru62ScriptNoOpenText
	applymovement OAKSLAB_NAYRU62, OaksLabNayru62LeavesMovement1
	setscene SCENE_OAKS_LAB_NOOP
	end

OaksLabNayru62ApproachesMovement1:
	step RIGHT
	step_end

OaksLabNayru62LeavesMovement1:
	step LEFT
	step_end

Nayru62CoordScript2:
	turnobject PLAYER, LEFT
	turnobject OAKSLAB_NAYRU62, RIGHT
	showemote EMOTE_SHOCK, OAKSLAB_NAYRU62, 15
	waitsfx
	applymovement OAKSLAB_NAYRU62, OaksLabNayru62ApproachesMovement2
	turnobject OAKSLAB_NAYRU62, DOWN
	turnobject PLAYER, UP
	opentext
	writetext Nayru62IntroText
	waitbutton
	scall Nayru62ScriptNoOpenText
	applymovement OAKSLAB_NAYRU62, OaksLabNayru62LeavesMovement2
	setscene SCENE_OAKS_LAB_NOOP
	end

OaksLabNayru62ApproachesMovement2:
	step RIGHT
	step RIGHT
	step_end

OaksLabNayru62LeavesMovement2:
	step LEFT
	step LEFT
	step_end

Nayru62Script:
	faceplayeropentext
Nayru62ScriptNoOpenText:
	checkevent EVENT_SHINY_CHARM_OBTAINED
	iftrue .AreYouMakingingUseOfTheShinyCharm
	writethistext
		text "Nayru62: Have you"
		line "registered all 252"
		cont "#mon yet?"
		done
	promptbutton
	readvar VAR_DEXCAUGHT
	ifequal 252, .PokedexCompleted
	jumpthisopenedtext
		text "Seems like you've"
		line "a bit more to go."
		
		para "Come visit me when"
		line "it's completed."
		
		para "I'll have a gift"
		line "for you then."
		
		para "In the meantime,"
		line "work hard on it!"
		
		para "I'm cheering for"
		line "you!"
		done

.PokedexCompleted
	closetext
	playsound SFX_1ST_PLACE
	pause 100
	showemote EMOTE_SHOCK, OAKSLAB_NAYRU62, 15
	turnobject OAKSLAB_NAYRU62, LEFT
	turnobject OAKSLAB_NAYRU62, UP
	turnobject OAKSLAB_NAYRU62, DOWN
	turnobject OAKSLAB_NAYRU62, RIGHT
	turnobject OAKSLAB_NAYRU62, LEFT
	turnobject OAKSLAB_NAYRU62, UP
	turnobject OAKSLAB_NAYRU62, DOWN
	turnobject OAKSLAB_NAYRU62, RIGHT
	turnobject OAKSLAB_NAYRU62, LEFT
	turnobject OAKSLAB_NAYRU62, UP
	turnobject OAKSLAB_NAYRU62, DOWN
	turnobject OAKSLAB_NAYRU62, RIGHT
	faceplayeropentext
	writethistext
		text "OH MY!!!"
		
		para "This is incredibly"
		line "rare and amazing!"
		
		para "Fantastic job on"
		line "your endeavor!"
		
		para "I know it must've"
		line "taken you a long"
		cont "time to accomplish"
		cont "this feat!"
		
		para "I have this item"
		line "for you! Take it!"
		done
	promptbutton
	verbosegiveitem SHINY_CHARM
	setevent EVENT_SHINY_CHARM_OBTAINED
	jumpthisopenedtext
		text "That's the one and"
		line "only Shiny Charm!"
		
		para "With this item in"
		line "your bag, the odds"
		cont "of finding a shiny"
		cont "#mon jumps to"
		cont "1<%> per encounter!"
		
		para "Isn't that just"
		line "awesome! Have fun"
		cont "shiny hunting!"
		done

.AreYouMakingingUseOfTheShinyCharm
	jumpthisopenedtext
		text "Nayru62: Why hello"
		line "there <PLAY_G>."
		
		para "Making use of the"
		line "Shiny Charm?"
		
		para "Recall, with it in"
		line "your bag, there's"
		cont "a 1<%> chance to"
		cont "find a shiny #-"
		cont "#mon per en-"
		cont "counter!"
		done

Nayru62IntroText:
	text "<PLAY_G>! Prof.Oak"
	line "has told me about"
	cont "you!"

	para "I've not introduced"
	line "myself yet!"

	para "I'm Nayru62!"

	para "I'm the one who"
	line "upgraded the Prof's"
	cont "#dex that you"
	cont "have been using."
	
	para "His previous need-"
	line "ed some augments."

	para "What? You've really"
	line "enjoyed it!?"

	para "Well, I'm thrilled!"

	para "Say, if you record"
	line "the data of all"
	cont "252 #mon on it,"
	cont "come see me. Wait,"
	cont "let's check now?"
	done

OaksAssistant1Text:
	text "The Prof's #mon"
	line "Talk radio program"
	cont "is pre-recorded."
	done

OaksAssistant2Text:
	text "This lab is has"
	line "been in operation"
	cont "for 3 years now."
	done

OaksLabPoster1Text:
	text "Press Start to"
	line "open the Menu."
	done

OaksLabPoster2Text:
	text "The Save option is"
	line "on the Menu."

	para "Use it in a timely"
	line "manner."
	done

OaksLabTrashcanText:
	text "There's nothing in"
	line "here…"
	done

OaksLabPCText:
	text "There's an e-mail"
	line "message on the PC."

	para "…"

	para "Prof.Oak, how is"
	line "your research"
	cont "coming along?"

	para "I'm still plugging"
	line "away."

	para "ELM in NEW BARK"
	line "TOWN 8-)"
	done
