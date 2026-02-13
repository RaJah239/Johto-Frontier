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
	opentext
	writetext ElmText_Intro
	waitbutton
	closetext
.skipthis1
	applymovement ELMSLAB_ELM, ElmsLab_ElmToDefaultPositionMovement1
	turnobject PLAYER, UP
	applymovement ELMSLAB_ELM, ElmsLab_ElmToDefaultPositionMovement2
	turnobject PLAYER, RIGHT
	opentext
	writetextcheckdialogue ElmText_ChoosePokemon, ElmText_ChoosePokemonMin
	waitbutton
	setscene SCENE_ELMSLAB_CANT_LEAVE
	closetext
	end

ProfElmScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_MASTER_BALL_FROM_ELM
	iftrue .ElmGenericDialogue
	checkflag ENGINE_RISINGBADGE
	iftrue ElmGiveMasterBallScript
.ElmGenericDialogue:
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iffalse .GoOnNowPlayer
	writetext ElmText_CallYou
	waitbutton
	closetext
	end
.GoOnNowPlayer
	writetext ElmText_TakePokemonText
	waitendtext

ElmGiveMasterBallScript:
	writetext ElmGiveMasterBallText1
	promptbutton
	verbosegiveitem MASTER_BALL
	iffalse .notdone
	setevent EVENT_GOT_MASTER_BALL_FROM_ELM
	writetext ElmGiveMasterBallText2
	waitbutton
.notdone
	closetext
	end

LabTryToLeaveScript:
	turnobject ELMSLAB_ELM, DOWN
	opentext
	writetext LabWhereGoingText
	waitbutton
	closetext
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
	ifequal RIGHT, ElmDirectionsScript
	applymovement PLAYER, AfterCyndaquilMovement
	sjump ElmDirectionsScript

.exit_this_scene1
	closetext
.exit_this_scene2
	end

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
	sjump ElmDirectionsScript

.exit_this_scene1
	closetext
.exit_this_scene2
	end

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
	sjump ElmDirectionsScript

.exit_this_scene1
	closetext
.exit_this_scene2
	end

ElmDirectionsScript:
	turnobject PLAYER, UP
	opentext
	isdialogueminimal
	iftrue .skipthis1
	writetext ElmAdventureText1
	promptbutton
.skipthis1
	writetext ElmsLab_GetDexText
	playsound SFX_ITEM
	waitsfx
	setflag ENGINE_POKEDEX

	isdialogueminimal
	iftrue .skipthis2
	writetext ElmsLab_GetDexInfoText
.skipthis2
	promptbutton
	addcellnum PHONE_ELM
	writetext GotElmsNumberText
	waitsfx
	playsound SFX_REGISTER_PHONE_NUMBER
	waitsfx
	closetext
	turnobject ELMSLAB_ELM, LEFT
	opentext
	writetextcheckdialogue ElmAdventureText2, ElmAdventureText2Min
	waitbutton
	closetext
	turnobject ELMSLAB_ELM, DOWN
	opentext
	writetextcheckdialogue ElmAdventureText3, ElmAdventureText3Min
	waitbutton
	closetext
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
	opentext
	writetext HaveFunText
	waitbutton
	closetext
	turnobject PLAYER, DOWN
	setevent EVENT_GOT_A_POKEMON_FROM_ELM
	setscene SCENE_ELMSLAB_AIDE_GIVES_POKE_BALLS
	end

ElmsLabHealingMachine:
	opentext
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iftrue .CanHeal
	writetext ElmsLabHealingMachineText1
	waitbutton
	closetext
	end

.CanHeal:
	writetext ElmsLabHealingMachineText2
	yesorno
	iftrue ElmsLabHealingMachine_HealParty
	closetext
	end

ElmsLabHealingMachine_HealParty:
	special HealParty
	special SaveMusic
	playmusic MUSIC_NONE
	setval HEALMACHINE_ELMS_LAB
	special HealMachineAnim
	pause 30
	special RestoreMusic
	closetext
	end

AideScript_WalkBalls1:
	applymovement ELMSLAB_ELMS_AIDE1, AideWalksRight1
	turnobject PLAYER, DOWN
	scall AideScript_GiveYouBalls
	applymovement ELMSLAB_ELMS_AIDE1, AideWalksLeft1
	end

AideScript_WalkBalls2:
	applymovement ELMSLAB_ELMS_AIDE1, AideWalksRight2
	turnobject PLAYER, DOWN
	scall AideScript_GiveYouBalls
	applymovement ELMSLAB_ELMS_AIDE1, AideWalksLeft2
	end

AideScript_GiveYouBalls:
	opentext
	isdialogueminimal
	iftrue .skip1
	writetext AideText_GiveYouBalls
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
	writetext TakeTypeChartText
	promptbutton
.skip3
	verbosegiveitem TYPE_CODEX
	isdialogueminimal
	iftrue .skip4
	writetext AllTheBestToYouText
	waitbutton
.skip4
	closetext
	end

AideScript_ReceiveTheBalls:
	jumpstd ReceiveItemScript
	end

ElmsAideScript1:
	faceplayer
	opentext
	writetext AideText_ExplainBalls
	waitbutton
	closetext
	end

ElmsLabWindow:
	jumptext ElmsLabWindowText

ElmsLabTrashcan:
	jumptext ElmsLabTrashcanText

ElmsLabPC:
	jumptext ElmsLabPCText

ElmsLabBookshelf:
	jumpstd DifficultBookshelfScript

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

AideWalksRight1:
	step RIGHT
	step RIGHT
	turn_head UP
	step_end

AideWalksRight2:
	step RIGHT
	step RIGHT
	step RIGHT
	turn_head UP
	step_end

AideWalksLeft1:
	step LEFT
	step LEFT
	turn_head DOWN
	step_end

AideWalksLeft2:
	step LEFT
	step LEFT
	step LEFT
	turn_head DOWN
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

AfterCyndaquilMovement:
	step LEFT
	step UP
	turn_head UP
	step_end

AfterTotodileMovement:
	step LEFT
	step LEFT
	step UP
	turn_head UP
	step_end

AfterChikoritaMovement:
	step LEFT
	step LEFT
	step LEFT
	step UP
	turn_head UP
	step_end

ElmText_Intro:
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

ElmText_ChoosePokemon:
	text "Go on <PLAYER>."
	done

ElmText_ChoosePokemonMin:
	text "Take all #mon"
	line "on the table."
	done

ElmText_TakePokemonText:
	text "Go on <PLAYER> and"
	line "take all #mon"
	cont "on the table."
	done

LabWhereGoingText:
	text "Elm: Wait! Where"
	line "are you going?"
	
	para "There's still more"
	line "#mon for you"
	cont "to take."
	done

TakeCyndaquilText:
	text "Elm: You'll take"
	line "Cyndaquil, the"
	cont "fire #mon?"
	done

TakeCyndaquilTextMin:
	text "Take Cyndaquil?"
	done

TakeTotodileText:
	text "Elm: Do you want"
	line "Totodile, the"
	cont "water #mon?"
	done

TakeTotodileTextMin:
	text "Take Totodile?"
	done

TakeChikoritaText:
	text "Elm: So, you like"
	line "Chikorita, the"
	cont "grass #mon?"
	done

TakeChikoritaTextMin:
	text "Take Chikorita?"
	done

ReceivedStarterText:
	text "<PLAYER> received"
	line "@"
	text_ram wStringBuffer3
	text "!"
	done

ElmAdventureText1:
	text "You're going to"
	line "need more to start"
	cont "adventuring."

	para "Take this!"
	done

ElmsLab_GetDexText:
	text "<PLAYER> received"
	line "#dex!"
	done

ElmsLab_GetDexInfoText:
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

ElmAdventureText2:
	text "If your #mon is"
	line "hurt, you should"

	para "heal it with this"
	line "machine."

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

HaveFunText:
	text "Have fun out there"
	line "<PLAYER>"
	done

GotElmsNumberText:
	text "<PLAYER> got Elm's"
	line "phone number."
	done

ElmsLabHealingMachineText1:
	text "I wonder what this"
	line "does?"
	done

ElmsLabHealingMachineText2:
	text "Would you like to"
	line "heal your #mon?"
	done

ElmText_CallYou:
	text "Elm: <PLAY_G>, I'll"
	line "call you if any-"
	cont "thing comes up."
	done

ElmGiveMasterBallText1:
	text "Elm: Hi, <PLAY_G>!"
	line "I've this for you."

	para "It's Master Ball!"
	done

ElmGiveMasterBallText2:
	text "It's the ultimate"
	line "ball! It'll catch"
	cont "any #mon with-"
	cont "out fail."

	para "You'll make better"
	line "use of it than I."
	done

AideText_GiveYouBalls:
	text "<PLAY_G>!"

	para "Use these on your"
	line "adventure!"
	done

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

TakeTypeChartText:
	text "Also, take this"
	line "chart as well!"

	para "It summarizes"
	line "#mon type"
	cont "effectiveness."
	done

AllTheBestToYouText:
	text "All the best to"
	line "you, <PLAYER>!"
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

ElmsLabPCText:
	text "OBSERVATIONS ON"
	line "#MON EVOLUTION"

	para "…It says on the"
	line "screen…"
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
	writetext WantToReadTheClassicRouteText
	yesorno
	iffalse .list
	writetext ClassicRouteText
	waitbutton
	sjump .list

.Placeholder:
	sjump .list

.Done:
	closetext
	end

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

WantToReadTheClassicRouteText:
	text "You are free to"
	line "traverse Johto as"
	cont "you see fit but"

	para "do you want to"
	line "read how vanilla"
	cont "#mon Crystal"
	cont "had players go"
	cont "through Johto?"
	done

ClassicRouteText:
	text "The Classic Route"
	line "through Johto"
	cont "goes:"

	para "New Bark Town,"
	line "Cherrygrove City,"
	cont "Route 30, 31,"
	cont "Violet City,"
	cont "Ruins of Alph,"
	cont "Route 32,"
	cont "Union Cave,"
	cont "Route 33,"
	cont "Azalea Town,"
	cont "Ilex Forest,"
	cont "Route 34,"
	cont "Goldenrod City,"
	cont "Route 35,"
	cont "National Park,"
	cont "Route 36, 37,"
	cont "Ecruteak City,"
	cont "Route 38, 39,"
	cont "Olivine City,"
	cont "Light House,"
	cont "Route 40, 41,"
	cont "Whirl Islands,"
	cont "Cianwood City,"
	cont "Mt.Mortar,"
	cont "Route 42,"
	cont "Mahogany Town,"
	cont "Route 43,"
	cont "Lake of Rage,"
	cont "Route 44,"
	cont "Ice Path,"
	cont "Blackthorn City,"
	cont "Dragon's Den,"
	cont "Route 45, 46,"
	cont "Tohjo Falls,"
	cont "Route 27, 26,"
	cont "Victory Road,"
	cont "Route 23,"
	cont "Indigo Plateau and"
	cont "Mt.Silver."
	done

ElmsAideScript2:
	turnobject ELMSLAB_ELMS_AIDE2, UP
	jumptext AideHelpfulInfoOnBookShelvesText

AideHelpfulInfoOnBookShelvesText:
	text "Those two rows of"
	line "bookshelves have"
	cont "information that I"
	cont "suspect trainers"
	cont "may like."
	done

ElmsLabAdventureTip1:
	jumptext ElmsLabAdventureTip1Text

ElmsLabAdventureTip1Text:
	text "Press Start to"
	line "open the Menu."
	done

ElmsLabAdventureTip2:
	jumptext ElmsLabAdventureTip2Text

ElmsLabAdventureTip2Text:
	text "Record your trip"
	line "with Save!"
	done

ElmsLabAdventureTip3:
	jumptext ElmsLabAdventureTip3Text

ElmsLabAdventureTip3Text:
	text "Open your Pack and"
	line "press Select to"
	cont "move items."
	done

ElmsLabAdventureTip4:
	jumptext ElmsLabAdventureTip4Text

ElmsLabAdventureTip4Text:
	text "Check your #mon"
	line "moves. Press the"

	para "A Button to switch"
	line "moves."
	done

ElmsLabAdventureTip5:
	jumptext ElmsLabAdventureTip5Text

ElmsLabAdventureTip5Text:
	text "Press Start in all"
	line "battles to view"
	cont "the foe's types."
	done

ElmsLabAdventureTip6:
	jumptext ElmsLabAdventureTip6Text

ElmsLabAdventureTip6Text:
	text "Weather usually"
	line "changes when re-"
	cont "entering areas."
	done

ElmsLabAdventureTip7:
	jumptext ElmsLabAdventureTip7Text

ElmsLabAdventureTip7Text:
	text "Talk to trainers"
	line "after battles to"
	cont "rematch them."
	done

ElmsLabAdventureTip8:
	jumptext ElmsLabAdventureTip8Text

ElmsLabAdventureTip8Text:
	text "Press B twice in"
	line "wild encounters to"
	cont "quickly escape."
	done

ElmsLabPorygonPCScript:
	jumpstd PorygonPCScript

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
	bg_event  0,  7, BGEVENT_READ, ElmsLabAdventureTip1
	bg_event  1,  7, BGEVENT_READ, ElmsLabAdventureTip2
	bg_event  2,  7, BGEVENT_READ, ElmsLabAdventureTip3
	bg_event  3,  7, BGEVENT_READ, ElmsLabAdventureTip4
	bg_event  6,  7, BGEVENT_READ, ElmsLabAdventureTip5
	bg_event  7,  7, BGEVENT_READ, ElmsLabAdventureTip6
	bg_event  8,  7, BGEVENT_READ, ElmsLabAdventureTip7
	bg_event  9,  7, BGEVENT_READ, ElmsLabAdventureTip8
	bg_event  9,  3, BGEVENT_READ, ElmsLabTrashcan
	bg_event  5,  0, BGEVENT_READ, ElmsLabWindow
	bg_event  3,  5, BGEVENT_DOWN, ElmsLabPC

	def_object_events
	object_event  5,  2, SPRITE_ELM, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ProfElmScript, -1
	object_event  2,  9, SPRITE_SCIENTIST, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, ElmsAideScript1, -1
	object_event  6,  3, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, CyndaquilPokeBallScript, EVENT_CYNDAQUIL_POKEBALL_IN_ELMS_LAB
	object_event  7,  3, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, TotodilePokeBallScript, EVENT_TOTODILE_POKEBALL_IN_ELMS_LAB
	object_event  8,  3, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, ChikoritaPokeBallScript, EVENT_CHIKORITA_POKEBALL_IN_ELMS_LAB
	object_event  0,  4, SPRITE_PORYGON_OW, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ElmsLabPorygonPCScript, -1
	object_event  7,  3, SPRITE_POKEDEX, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, WorldNotebook, EVENT_ELMS_TRAVEL_NOTEBOOK
	object_event  7,  9, SPRITE_SCIENTIST, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, ElmsAideScript2, -1
