ElmsLab_MapEvents:
	def_warp_events
	warp_event  4, 11, NEW_BARK_TOWN, 2
	warp_event  5, 11, NEW_BARK_TOWN, 2

	def_coord_events
	coord_event  4,  6, SCENE_ELMSLAB_CANT_LEAVE, LabTryToLeaveScript
	coord_event  5,  6, SCENE_ELMSLAB_CANT_LEAVE, LabTryToLeaveScript
	coord_event  4,  8, SCENE_ELMSLAB_AIDE_GIVES_POKE_BALLS, AideScript_WalkBalls1
	coord_event  5,  8, SCENE_ELMSLAB_AIDE_GIVES_POKE_BALLS, AideScript_WalkBalls2

	def_bg_events
	bg_event  2,  1, BGEVENT_READ, ElmsLabHealingMachine
	bg_event  0,  7, BGEVENT_JUMPTEXT, ElmsLabAdventureTip1Text
	bg_event  1,  7, BGEVENT_JUMPTEXT, ElmsLabAdventureTip2Text
	bg_event  2,  7, BGEVENT_JUMPTEXT, ElmsLabAdventureTip3Text
	bg_event  3,  7, BGEVENT_JUMPTEXT, ElmsLabAdventureTip4Text
	bg_event  6,  7, BGEVENT_JUMPTEXT, ElmsLabAdventureTip5Text
	bg_event  7,  7, BGEVENT_JUMPTEXT, ElmsLabAdventureTip6Text
	bg_event  8,  7, BGEVENT_JUMPTEXT, ElmsLabAdventureTip7Text
	bg_event  9,  7, BGEVENT_JUMPTEXT, ElmsLabAdventureTip8Text
	bg_event  9,  3, BGEVENT_JUMPTEXT, ElmsLabTrashcanText
	bg_event  5,  0, BGEVENT_JUMPTEXT, ElmsLabWindowText
	bg_event  3,  5, BGEVENT_DOWN, ElmsLabPC

	def_object_events
	object_event  5,  2, SPRITE_ELM, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ProfElmScript, -1
	object_event  2,  9, SPRITE_SCIENTIST, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, AideText_ExplainBalls, -1
	object_event  6,  3, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, CyndaquilPokeBallScript, EVENT_CYNDAQUIL_POKEBALL_IN_ELMS_LAB
	object_event  7,  3, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, TotodilePokeBallScript, EVENT_TOTODILE_POKEBALL_IN_ELMS_LAB
	object_event  8,  3, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, ChikoritaPokeBallScript, EVENT_CHIKORITA_POKEBALL_IN_ELMS_LAB
	object_event  0,  4, SPRITE_PORYGON_OW, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ElmsLabPorygonPCScript, -1
	object_event  7,  3, SPRITE_POKEDEX, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, WorldNotebook, EVENT_ELMS_TRAVEL_NOTEBOOK
	object_event  7,  9, SPRITE_SCIENTIST, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, ElmsAideScript2, -1

	object_const_def
	const ELMSLAB_ELM
	const ELMSLAB_ELMS_AIDE1
	const ELMSLAB_POKE_BALL1
	const ELMSLAB_POKE_BALL2
	const ELMSLAB_POKE_BALL3
	const ELMSLAB_PORYGON_PC
	const ELMSLAB_BOOK
	const ELMSLAB_ELMS_AIDE2

ElmsLab_MapScripts:
	def_scene_scripts
	scene_script ElmsLabMeetElmScene, SCENE_ELMSLAB_MEET_ELM
	scene_script ElmsLabNoop1Scene,   SCENE_ELMSLAB_CANT_LEAVE
	scene_script ElmsLabNoop2Scene,   SCENE_ELMSLAB_NOOP
	scene_const SCENE_ELMSLAB_AIDE_GIVES_POKE_BALLS

	def_callbacks
	callback MAPCALLBACK_OBJECTS, ElmsLabMoveElmCallback

ElmsLabMeetElmScene:
	sdefer ElmsLabWalkUpToElmScript
ElmsLabNoop1Scene:
ElmsLabNoop2Scene:
	end

ElmsLabMoveElmCallback:
	checkscene
	iftrue .Skip ; not SCENE_ELMSLAB_MEET_ELM
	moveobject ELMSLAB_ELM, 3, 4
.Skip:
	endcallback

ElmsLabWalkUpToElmScript:
	applymovement PLAYER, ElmsLab_WalkUpToElmMovement
	showemote EMOTE_SHOCK, ELMSLAB_ELM, 15
	turnobject ELMSLAB_ELM, RIGHT
	isdialogueminimal
	iftrue .skipthis1
	showthistext
		text "Elm: <PLAY_G>!"
		line "There you are!"

		para "You're finally of"
		line "age, meaning it's"
		cont "time to start your"
		cont "very own #mon"
		cont "adventure!"

		para "Ah! Of course, you"
		line "need #mon to"
		cont "do just that!"

		para "So!"

		para "I'd like you to"
		line "take a #mon"
		cont "that I caught on"
		cont "the table."

		para "Wait a moment,"
		line "even better!"

		para "Take them all!"
		done
.skipthis1
	applymovement ELMSLAB_ELM, ElmsLab_ElmToDefaultPositionMovement1
	turnobject PLAYER, UP
	applymovement ELMSLAB_ELM, ElmsLab_ElmToDefaultPositionMovement2
	turnobject PLAYER, RIGHT
	opentext
	writetextcheckdialogue ElmText_ChoosePokemon, ElmText_ChoosePokemonMin
	setscene SCENE_ELMSLAB_CANT_LEAVE
	waitendtext

ElmText_ChoosePokemon:
	text "Go on <PLAYER>."
	done

ElmText_ChoosePokemonMin:
	text "Take all #mon"
	line "on the table."
	done

ElmsLab_WalkUpToElmMovement:
	step UP
	step UP
	step UP
	step UP
	step UP
	step UP
	step UP
	turn_head LEFT
	step_end

ElmsLab_CantLeaveMovement:
	step UP
	step_end

ElmsLab_ElmToDefaultPositionMovement1:
	step UP
	step_end

ElmsLab_ElmToDefaultPositionMovement2:
	step RIGHT
	step RIGHT
	step UP
	turn_head DOWN
	step_end

ProfElmScript:
	checkevent EVENT_GOT_MASTER_BALL_FROM_ELM
	iftrue .ElmGenericDialogue
	checkflag ENGINE_RISINGBADGE
	iftrue .ElmGiveMasterBall
.ElmGenericDialogue:
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iffalse .GoOnNowPlayer
	jumpthistext
		text "Elm: <PLAY_G>, I'll"
		line "call you if any-"
		cont "thing comes up."
		done

.GoOnNowPlayer:
	jumpthistext
		text "Go on <PLAYER> and"
		line "take all #mon"
		cont "on the table."
		done

.ElmGiveMasterBall:
	showthistext
		text "Elm: Hi, <PLAY_G>!"
		line "I've this for you."

		para "It's Master Ball!"
		done
	promptbutton
	verbosegiveitem MASTER_BALL
	iffalse .notdone
	setevent EVENT_GOT_MASTER_BALL_FROM_ELM
	writethistext
		text "It's the ultimate"
		line "ball! It'll catch"
		cont "any #mon with-"
		cont "out fail."

		para "You'll make better"
		line "use of it than I."
		done
	waitbutton
.notdone
	endtext

LabTryToLeaveScript:
	turnobject ELMSLAB_ELM, DOWN
	showthistext
		text "Elm: Wait! Where"
		line "are you going?"
	
		para "There's still more"
		line "#mon for you"
		cont "to take."
		done
	applymovement PLAYER, ElmsLab_CantLeaveMovement
	end

CyndaquilPokeBallScript:
	turnobject ELMSLAB_ELM, DOWN
	isdialogueminimal
	iftrue .skipthis2
	reanchormap
	pokepic CYNDAQUIL
	cry CYNDAQUIL
	waitbutton
	closepokepic
.skipthis2
	opentext
	writetextcheckdialogue TakeCyndaquilText, TakeCyndaquilTextMin
	yesorno
	iffalse .exit_this_scene1
	disappear ELMSLAB_POKE_BALL1
	setevent EVENT_GOT_CYNDAQUIL_FROM_ELM
	isdialogueminimal
	iftrue .skipthis3
	waitsfx
	getmonname STRING_BUFFER_3, CYNDAQUIL
	writetext ReceivedStarterText
	playsound SFX_CAUGHT_MON
	waitsfx
	promptbutton
.skipthis3
	givepoke CYNDAQUIL, 5, BERRY
	closetext
	checkevent EVENT_GOT_TOTODILE_FROM_ELM
	iffalse .exit_this_scene2
	checkevent EVENT_GOT_CHIKORITA_FROM_ELM
	iffalse .exit_this_scene2
	readvar VAR_FACING
	ifequal RIGHT, ElmGivesPokedexScript
	applymovement PLAYER, AfterCyndaquilMovement
	sjump ElmGivesPokedexScript

.exit_this_scene1
	closetext
.exit_this_scene2
	end

TakeCyndaquilText:
	text "Elm: You'll take"
	line "Cyndaquil, the"
	cont "fire #mon?"
	done

TakeCyndaquilTextMin:
	text "Take Cyndaquil?"
	done

ReceivedStarterText:
	text "<PLAYER> received"
	line "@"
	text_ram wStringBuffer3
	text "!"
	done

AfterCyndaquilMovement:
	step LEFT
	step UP
	turn_head UP
	step_end

TotodilePokeBallScript:
	turnobject ELMSLAB_ELM, DOWN
	isdialogueminimal
	iftrue .skipthis4
	reanchormap
	pokepic TOTODILE
	cry TOTODILE
	waitbutton
	closepokepic
.skipthis4
	opentext
	writetextcheckdialogue TakeTotodileText, TakeTotodileTextMin
	yesorno
	iffalse .exit_this_scene1
	disappear ELMSLAB_POKE_BALL2
	setevent EVENT_GOT_TOTODILE_FROM_ELM
	isdialogueminimal
	iftrue .skipthis5
	waitsfx
	getmonname STRING_BUFFER_3, TOTODILE
	writetext ReceivedStarterText
	playsound SFX_CAUGHT_MON
	waitsfx
	promptbutton
.skipthis5
	givepoke TOTODILE, 5, BERRY
	closetext
	checkevent EVENT_GOT_CYNDAQUIL_FROM_ELM
	iffalse .exit_this_scene2
	checkevent EVENT_GOT_CHIKORITA_FROM_ELM
	iffalse .exit_this_scene2
	applymovement PLAYER, AfterTotodileMovement
	sjump ElmGivesPokedexScript

.exit_this_scene1
	closetext
.exit_this_scene2
	end

TakeTotodileText:
	text "Elm: Do you want"
	line "Totodile, the"
	cont "water #mon?"
	done

TakeTotodileTextMin:
	text "Take Totodile?"
	done

AfterTotodileMovement:
	step LEFT
	step LEFT
	step UP
	turn_head UP
	step_end

ChikoritaPokeBallScript:
	turnobject ELMSLAB_ELM, DOWN
	isdialogueminimal
	iftrue .skipthis6
	reanchormap
	pokepic CHIKORITA
	cry CHIKORITA
	waitbutton
	closepokepic
.skipthis6
	opentext
	writetextcheckdialogue TakeChikoritaText, TakeChikoritaTextMin
	yesorno
	iffalse .exit_this_scene1
	disappear ELMSLAB_POKE_BALL3
	setevent EVENT_GOT_CHIKORITA_FROM_ELM
	isdialogueminimal
	iftrue .skipthis7
	waitsfx
	getmonname STRING_BUFFER_3, CHIKORITA
	writetext ReceivedStarterText
	playsound SFX_CAUGHT_MON
	waitsfx
	promptbutton
.skipthis7
	givepoke CHIKORITA, 5, BERRY
	closetext
	checkevent EVENT_GOT_CYNDAQUIL_FROM_ELM
	iffalse .exit_this_scene2
	checkevent EVENT_GOT_TOTODILE_FROM_ELM
	iffalse .exit_this_scene2
	applymovement PLAYER, AfterChikoritaMovement
	sjump ElmGivesPokedexScript

.exit_this_scene1
	closetext
.exit_this_scene2
	end

TakeChikoritaText:
	text "Elm: So, you like"
	line "Chikorita, the"
	cont "grass #mon?"
	done

TakeChikoritaTextMin:
	text "Take Chikorita?"
	done

AfterChikoritaMovement:
	step LEFT
	step LEFT
	step LEFT
	step UP
	turn_head UP
	step_end

ElmGivesPokedexScript:
	turnobject PLAYER, UP
	opentext
	isdialogueminimal
	iftrue .skipthis1
	writethistext
		text "You're going to"
		line "need more to start"
		cont "adventuring."

		para "Take this!"
		done
	promptbutton
.skipthis1
	writethistext
		text "<PLAYER> received"
		line "#dex!"
		done
	playsound SFX_ITEM
	waitsfx
	setflag ENGINE_POKEDEX
	isdialogueminimal
	iftrue .skipthis2
	writethistext
	text "See? This is the"
	line "latest version of"
	cont "the #dex."

	para "It automatically"
	line "records data on"
	cont "#mon you've"
	cont "seen or caught."

	para "It's a hi-tech"
	line "encyclopedia!"

	para "It shows their"
 	line "habitats, how they"
 	cont "evolve, moves and"
 	cont "much more!"
	
 	para "It's first version"
 	line "was created by the"
 	cont "renowned Professor"
 	cont "Oak!"

 	para "No, I didn't make"
 	line "this…"

 	para "A genius in his"
 	line "lab updated his"
 	cont "first #dex and"
 	cont "it was given to me"
 	cont "to pass onto a new"
 	cont "trainer."

 	para "I'll be sure to"
 	line "let him know of"
 	cont "you, <PLAYER>."

	para "Go meet many kinds"
	line "of #mon and"
	cont "maybe even attempt"
	cont "completing that"
	cont "#dex!"

	para "That'll make my old"
	line "mentor proud."
	
	para "I hear his lab is"
	line "in some sort of"
	cont "battle area now…"
	
	para "Wow… that brought"
	line "back memories."
	
	para "You should take my"
	line "phone number."

	para "It may be of use!"
	done
.skipthis2
	promptbutton
	addcellnum PHONE_ELM
	writethistext
		text "<PLAYER> got Elm's"
		line "phone number."
		done
	waitsfx
	playsound SFX_REGISTER_PHONE_NUMBER
	waitsfx
	closetext
	turnobject ELMSLAB_ELM, LEFT
	opentext
	writetextcheckdialogue ElmAdventureText2, ElmAdventureText2Min
	waitclosetext
	turnobject ELMSLAB_ELM, DOWN
	opentext
	writetextcheckdialogue ElmAdventureText3, ElmAdventureText3Min
	waitclosetext
	showemote EMOTE_SHOCK, ELMSLAB_ELM, 15
	turnobject ELMSLAB_ELM, RIGHT
	pause 10
	turnobject PLAYER, RIGHT
	pause 10
	appear ELMSLAB_BOOK
	turnobject ELMSLAB_ELM, DOWN
	pause 20
	turnobject PLAYER, UP
	pause 10
	showthistext
		text "Have fun out there"
		line "<PLAYER>."
		done
	turnobject PLAYER, DOWN
	setevent EVENT_GOT_A_POKEMON_FROM_ELM
	setscene SCENE_ELMSLAB_AIDE_GIVES_POKE_BALLS
	end

ElmAdventureText2:
	text "If your #mon"
	line "get hurt, you may"

	para "heal them with"
	line "this machine."

	para "Feel free to use"
	line "it anytime."
	done

ElmAdventureText2Min:
	text "Can heal #mon"
	line "there."
	done

ElmAdventureText3:
	text "The world is vast,"
	line "so if you're not"
	cont "sure what to do,"
	cont "read that book on"
	cont "the table."
	done

ElmAdventureText3Min:
	text "Check that book if"
	line "first timer."
	done

ElmsLabHealingMachine:
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iftrue .CanHeal
	jumpthistext
		text "I wonder what this"
		line "does?"
		done

.CanHeal:
	opentext
	writethistext
		text "Would you like to"
		line "heal your #mon?"
		done
	yesorno
	iftrue ElmsLabHealingMachine_HealParty
	endtext

ElmsLabHealingMachine_HealParty:
	special HealParty
	special SaveMusic
	playmusic MUSIC_NONE
	setval HEALMACHINE_ELMS_LAB
	special HealMachineAnim
	pause 30
	special RestoreMusic
	endtext

AideScript_WalkBalls1:
	applymovement ELMSLAB_ELMS_AIDE1, AideWalksRight1
	turnobject PLAYER, DOWN
	scall AideScript_GiveYouBalls
	applymovement ELMSLAB_ELMS_AIDE1, AideWalksLeft1
	end

AideWalksRight1:
	step RIGHT
	step RIGHT
	turn_head UP
	step_end

AideWalksLeft1:
	step LEFT
	step LEFT
	turn_head DOWN
	step_end

AideScript_WalkBalls2:
	applymovement ELMSLAB_ELMS_AIDE1, AideWalksRight2
	turnobject PLAYER, DOWN
	scall AideScript_GiveYouBalls
	applymovement ELMSLAB_ELMS_AIDE1, AideWalksLeft2
	end

AideWalksRight2:
	step RIGHT
	step RIGHT
	step RIGHT
	turn_head UP
	step_end

AideWalksLeft2:
	step LEFT
	step LEFT
	step LEFT
	turn_head DOWN
	step_end

AideScript_GiveYouBalls:
	opentext
	isdialogueminimal
	iftrue .skip1
	writethistext
		text "<PLAY_G>!"

		para "Use these on your"
		line "adventure!"
		done
	promptbutton
.skip1
	getitemname STRING_BUFFER_4, POKE_BALL
	scall AideScript_ReceiveTheBalls
	giveitem POKE_BALL, 5
	isdialogueminimal
	iftrue .skip2
	writetext AideText_ExplainBalls
	promptbutton
.skip2
	itemnotify
	setscene SCENE_ELMSLAB_NOOP
	isdialogueminimal
	iftrue .skip3
	writethistext
		text "Also, take this"
		line "chart as well!"

		para "It summarizes"
		line "#mon type"
		cont "effectiveness."
		done
	promptbutton
.skip3
	verbosegiveitem TYPE_CHART
	isdialogueminimal
	iftrue .skip4
	writethistext
		text "All the best to"
		line "you, <PLAYER>!"
		done
	waitbutton
.skip4
	endtext

AideScript_ReceiveTheBalls:
	jumpstd ReceiveItemScript

AideText_ExplainBalls:
	text "To add to your"
	line "#dex, you have"
	cont "to catch #mon."

	para "Throw # balls"
	line "at wild #mon"
	cont "to get them."

	para "More #mon means"
	line "more training but"
	cont "you have Exp.Share"
	cont "in your Options."

	para "Set it ON to share"
	line "EXP. Points with"
	cont "all your #mon."
	
	para "You can learn a"
	line "lot more if you go"
	cont "to Earl's Academy"
	cont "in Violet City."
	done

ElmsLabPC:
	jumpthistext
	text "OBSERVATIONS ON"
	line "#MON EVOLUTION"

	para "…It says on the"
	line "screen…"
	done

ElmsLabWindowText:
	text "The window's open."

	para "A pleasant breeze"
	line "is blowing in."
	done

ElmsLabTrashcanText:
	text "The wrapper from"
	line "the snack Prof.Elm"
	cont "ate is in there…"
	done

WorldNotebook:
	opentext
	writetext AdventuringText
	yesorno
	iffalse .Done
.list:
	loadmenu .MoveEnchancingAbilitiesHeader
	verticalmenu
	closewindow
	ifequal 1, .ClassicRoute
	ifequal 2, .Placeholder
	ifequal 3, .Placeholder
	ifequal 4, .Placeholder
	ifequal 5, .Done
	sjump .list

.ClassicRoute:
	writethistext
		text "You are free to"
		line "traverse Johto as"
		cont "you see fit but"

		para "if you're new, the"
		line "suggested way goes"
		cont "from Route 1 to 19"
		cont "with exploration"
		cont "to all things one"
		cont "may come across."
		done
	waitbutton
	sjump .list

.Placeholder:
	sjump .list

.Done:
	endtext

.MoveEnchancingAbilitiesHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 0, 0, 19, TEXTBOX_Y - 1
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR | STATICMENU_WRAP ; flags
	db 5 ; items
	db "Classic Route@"
	db "Placeholder@"
	db "Placeholder@"
	db "Placeholder@"
	db "Cancel@"

AdventuringText:
	text "It's a book about"
	line "adventuring!"

	para "Read it?"
	done

ElmsAideScript2:
	faceplayer
	pause 10
	turnobject ELMSLAB_ELMS_AIDE2, UP
	pause 30
	jumpthistextfaceplayer
		text "Those two rows of"
		line "bookshelves have"
		cont "information that I"
		cont "suspect trainers"
		cont "may like."
		done

ElmsLabAdventureTip1Text:
	text "Press Start to"
	line "open the Menu."

	para "Record your trip"
	line "with Save!"

	para "Turn ON Fast Boot"
	line "in Options to load"
	cont "your Save quicker."
	done

ElmsLabAdventureTip2Text:
	text "Open your Bag and"
	line "press Select to"
	cont "move items."

	para "Press Start in the"
	line "Bag to auto sort"
	cont "items per pocket"
	cont "whether in or out"
	cont "of battles."
	done

ElmsLabAdventureTip3Text:
	text "In Options Menu,"
	line "switching Dialogue"
	cont "to Minimal will"
	cont "shorten all story"
	cont "related, inter-"
	cont "active NPCs and"
	cont "Battle Facilities"
	cont "text."
	
	para "Only use if one is"
	line "familiar with lost"
	cont "dialogue."
	done

ElmsLabAdventureTip4Text:
	text "Check your #mon"
	line "moves. Press the"

	para "A Button to switch"
	line "moves."
	done

ElmsLabAdventureTip5Text:
	text "Press Start in all"
	line "battles to view"
	cont "the foe's types."
	
	para "In Options Menu,"
	line "setting Battles to"
	cont "Quick, removes a"
	cont "lot of text such"
	cont "as effectiveness"
	cont "to speed up all"
	cont "battles."

	para "Only use if one is"
	line "familiar with lost"
	cont "text."
	done

ElmsLabAdventureTip6Text:
	text "Weather usually"
	line "changes when re-"
	cont "entering areas."
	done

ElmsLabAdventureTip7Text:
	text "Talk to trainers"
	line "after battles to"
	cont "rematch them."
	done

ElmsLabAdventureTip8Text:
	text "In battles, press"
	line "the B button to"
	cont "jump to the lower"
	cont "right Option."
	
	para "Holding B down"
	line "will turbo through"
	cont "text."
	done

ElmsLabPorygonPCScript:
	jumpstd PorygonPCScript
