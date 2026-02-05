	object_const_def
	const BATTLEPLAZABATTLEHALL_RECEPTIONIST
	const BATTLEPLAZABATTLEHALL_ENEMY

BattlePlazaBattleHall_MapScripts:
	def_scene_scripts

	def_callbacks

BattleHallReceptionistScript:
	opentext
	checkevent EVENT_DID_NOT_GET_BATTLE_HALL_PRIZE
	iftrue .GivePrize
	writetext BattleHallIntroText
	promptbutton
	writetext BattleHallAskWantToBattleText
	yesorno
	iffalse .Declined
	writetext BattleHallReceptionistSaveText
	yesorno
	iffalse .Declined
	special TryQuickSave
.ChooseMode
	loadmenu .BattleHallModeTypeSelectionHeader
	verticalmenu
	closewindow
	ifequal 1, .PreviousMode
	ifequal 2, .NormalMode
	ifequal 3, .InverseMode
	ifequal 4, .TypelessMode
	sjump .ChooseMode

.BattleHallModeTypeSelectionHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 0, 0, 15, TEXTBOX_Y - 3
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR ; flags
	db 4 ; items
	db "Previous Mode@"
	db "Normal Mode@"
	db "Inverse Mode@"
	db "Typeless Mode@"

.InverseMode:
	setevent EVENT_BATTLE_HALL_INVERSE_BATTLE
	clearevent EVENT_BATTLE_HALL_TYPELESS_BATTLE
	loadvar VAR_BATTLETYPE, BATTLETYPE_INVERSE
	sjump .StartBattle

.TypelessMode:
	setevent EVENT_BATTLE_HALL_TYPELESS_BATTLE
	clearevent EVENT_BATTLE_HALL_INVERSE_BATTLE
	loadvar VAR_BATTLETYPE, BATTLETYPE_TYPELESS
	sjump .StartBattle

.PreviousMode:
	checkevent EVENT_BATTLE_HALL_INVERSE_BATTLE
	iftrue .InverseMode
	checkevent EVENT_BATTLE_HALL_TYPELESS_BATTLE
	iftrue .TypelessMode
	; fallthrough

.NormalMode:
	clearevent EVENT_BATTLE_HALL_INVERSE_BATTLE
	clearevent EVENT_BATTLE_HALL_TYPELESS_BATTLE
	loadvar VAR_BATTLETYPE, BATTLETYPE_NORMAL
	; fallthrough

.StartBattle:
	writetext BattleHallReceptionistGoRightInText
	waitbutton
	closetext
	applymovement BATTLEPLAZABATTLEHALL_RECEPTIONIST, BattleHallReceptionist_MoveOutTheWay
	applymovement PLAYER, BattleHallPlayer_EnterBattleRoom
	winlosstext BattleHallPlayerVictoryText, 0
.sample
	random 3
	ifequal 0, .Red
	ifequal 1, .Blue
	ifequal 2, .Maxima
	sjump .sample

.Red
	loadtrainer RED, RED1
	sjump .finish

.Blue
	loadtrainer BLUE, BLUE1
	sjump .finish

.Maxima
	loadtrainer MAXIMA, MAXIMA1
	; fallthrough

.finish
	startbattle
	ifequal WIN, .win
	dontrestartmapmusic
	reloadmap
	pause 15
	special BattleTowerFade
	warpfacing UP, BATTLE_PLAZA_BATTLE_HALL, 3, 11
	turnobject PLAYER, UP
	special LoadPokemonData
	special HealParty
	jumptext BattleHallBattleLoseText

.win
	dontrestartmapmusic
	reloadmapafterbattle
	pause 15
	special BattleTowerFade
	warpfacing UP, BATTLE_PLAZA_BATTLE_HALL, 3, 11
	turnobject PLAYER, UP
	opentext
	writetext BattleHallBattleWinText
	promptbutton
	special LoadPokemonData
	special HealParty
	sjump .GivePrize

.Declined:
	writetext BattleHallPleaseComeAgainText
	waitbutton
	closetext
	turnobject PLAYER, DOWN
	end

.GivePrize:
	writetext BattleHallPrizeText
	verbosegiveitem CRYSTAL
	iffalse BattleHallPackFull
	clearevent EVENT_DID_NOT_GET_BATTLE_HALL_PRIZE
	closetext
	end

BattleHallPackFull:
	setevent EVENT_DID_NOT_GET_BATTLE_HALL_PRIZE
	writetextend BattleHallFullPackText

BattleHallReceptionist_MoveOutTheWay:
	step UP
    step RIGHT
    turn_head LEFT
    step_end

BattleHallPlayer_EnterBattleRoom:
	step UP
	step UP
	step UP
	step UP
	step UP
	step UP
	step UP
	step UP
	turn_head RIGHT
	step_end

BattleHallIntroText:
	text "Welcome to the"
	line "Battle Hall."

	para "You may fight a"
	line "random trainer"
	cont "here."

	para "Each victory will"
	line "net you a Crystal."
	done

BattleHallAskWantToBattleText:
	text "Would you like to"
	line "battle?"
	done

BattleHallPleaseComeAgainText:
	text "Do come again."
	done

BattleHallReceptionistSaveText:
	text "You must save your"
	line "game. Alright?"
	done

BattleHallReceptionistGoRightInText:
	text "Please go right"
	line "through."
	done

BattleHallPlayerVictoryText:
	text "Player Victory!"
	done

BattleHallBattleLoseText:
	text "We hope to serve"
	line "you again."
    done

BattleHallBattleWinText:
    text "Excellent work!"
    done

BattleHallPrizeText:
    text "Please accept"
    line "this prize."
    done

BattleHallFullPackText:
	text "Your pack's full."
	
	para "Return once you've"
	line "made space for it."
	done

BattlePlazaBattleHall_MapEvents:
	def_warp_events
	warp_event  4, 13, BATTLE_PLAZA, 7
	warp_event  3, 13, BATTLE_PLAZA, 6

	def_coord_events

	def_bg_events

	def_object_events
	object_event  3, 10, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_TEAL, OBJECTTYPE_SCRIPT, 0, BattleHallReceptionistScript, -1
	object_event  4,  3, SPRITE_UNKNOWN, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, -1
