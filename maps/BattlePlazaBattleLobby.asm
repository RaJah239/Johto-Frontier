	object_const_def
	const BATTLEPLAZABATTLELOBBY_RECEPTIONIST
	const BATTLEPLAZABATTLELOBBY_ENEMY

BattlePlazaBattleLobby_MapScripts:
	def_scene_scripts

	def_callbacks

BattleLobbyReceptionistScript:
	opentext
	checkevent EVENT_DID_NOT_GET_BATTLE_LOBBY_PRIZE
	iftrue .GivePrize
	writetext BattleLobbyIntroText
	promptbutton
	special TryQuickSave
.ChooseMode
	loadmenu .BattleLobbyModeTypeSelectionHeader
	verticalmenu
	closewindow
	ifequal 1, .PreviousMode
	ifequal 2, .NormalMode
	ifequal 3, .InverseMode
	ifequal 4, .NeutralMode
	ifequal 5, .Cancel
	sjump .ChooseMode

.BattleLobbyModeTypeSelectionHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 0, 0, 15, TEXTBOX_Y - 1
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR | STATICMENU_WRAP ; flags
	db 5 ; items
	db "Previous Mode@"
	db "Normal Mode@"
	db "Inverse Mode@"
	db "Neutral Mode@"
	db "Cancel@"

.InverseMode:
	setevent EVENT_BATTLE_LOBBY_INVERSE_BATTLE
	clearevent EVENT_BATTLE_LOBBY_TYPELESS_BATTLE
	loadvar VAR_BATTLETYPE, BATTLETYPE_INVERSE
	sjump .StartBattle

.NeutralMode:
	setevent EVENT_BATTLE_LOBBY_TYPELESS_BATTLE
	clearevent EVENT_BATTLE_LOBBY_INVERSE_BATTLE
	loadvar VAR_BATTLETYPE, BATTLETYPE_TYPELESS
	sjump .StartBattle

.PreviousMode:
	checkevent EVENT_BATTLE_LOBBY_INVERSE_BATTLE
	iftrue .InverseMode
	checkevent EVENT_BATTLE_LOBBY_TYPELESS_BATTLE
	iftrue .NeutralMode
	; fallthrough

.NormalMode:
	clearevent EVENT_BATTLE_LOBBY_INVERSE_BATTLE
	clearevent EVENT_BATTLE_LOBBY_TYPELESS_BATTLE
	loadvar VAR_BATTLETYPE, BATTLETYPE_NORMAL
	; fallthrough

.StartBattle:
	writetext BattleLobbyReceptionistGoRightInText
	waitbutton
	closetext
	applymovement BATTLEPLAZABATTLELOBBY_RECEPTIONIST, BattleLobbyReceptionist_MoveOutTheWay
	applymovement PLAYER, BattleLobbyPlayer_EnterBattleRoom
	winlosstext BattleLobbyPlayerVictoryText, 0
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
	warpfacing UP, BATTLE_PLAZA_BATTLE_LOBBY, 3, 11
	turnobject PLAYER, UP
	special LoadPokemonData
	special HealParty
	opentext
	writetext BattleLobbyBattleLoseText
	waitendtext

.win
	dontrestartmapmusic
	reloadmapafterbattle
	pause 15
	special BattleTowerFade
	warpfacing UP, BATTLE_PLAZA_BATTLE_LOBBY, 3, 11
	turnobject PLAYER, UP
	opentext
	writetext BattleLobbyBattleWinText
	promptbutton
	special LoadPokemonData
	special HealParty
.GivePrize:
	writetext BattleLobbyPrizeText
	verbosegiveitem CRYSTAL
	iffalse BattleLobbyPackFull
	clearevent EVENT_DID_NOT_GET_BATTLE_LOBBY_PRIZE
	closetext
	end

.Cancel:
	writetext BattleLobbyPleaseComeAgainText
	waitbutton
	closetext
	turnobject PLAYER, DOWN
	end

BattleLobbyPackFull:
	setevent EVENT_DID_NOT_GET_BATTLE_LOBBY_PRIZE
	writetext BattleLobbyFullPackText
	waitendtext

BattleLobbyReceptionist_MoveOutTheWay:
	step UP
    step RIGHT
    turn_head LEFT
    step_end

BattleLobbyPlayer_EnterBattleRoom:
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

CheckHardModeASM:
    ld a, [wOptions2]
    bit HARD_MODE, a
    jr z, .off

.on
    ld a, 1
    ld [wScriptVar], a
    ret

.off
    xor a
    ld [wScriptVar], a
    ret

BattleLobbyIntroText:
	text "Battle Lobby"
	line "Welcomes you!"
	done

BattleLobbyPleaseComeAgainText:
	text "Do come again."
	done

BattleLobbyReceptionistGoRightInText:
	text "Please go right"
	line "through."
	done

BattleLobbyPlayerVictoryText:
	text "Player Victory!"
	done

BattleLobbyBattleLoseText:
	text "We hope to serve"
	line "you again."
    done

BattleLobbyBattleWinText:
    text "Excellent work!"
    done

BattleLobbyPrizeText:
    text "Please accept"
    line "this prize."
    done

BattleLobbyFullPackText:
	text "Return once you've"
	line "made space for it."
	done

BattleLobbyInfoSign:
	jumptext BattleLobbyInfoSignText

BattleLobbyInfoSignText:
	text "You may fight a"
	line "random trainer"
	cont "here."

	para "Each victory will"
	line "net you a Crystal."
	done

BattlePlazaBattleLobby_MapEvents:
	def_warp_events
	warp_event  4, 13, BATTLE_PLAZA, 7
	warp_event  3, 13, BATTLE_PLAZA, 6

	def_coord_events

	def_bg_events
	bg_event  2, 10, BGEVENT_READ, BattleLobbyInfoSign

	def_object_events
	object_event  3, 10, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_TEAL, OBJECTTYPE_SCRIPT, 0, BattleLobbyReceptionistScript, -1
	object_event  4,  3, SPRITE_UNKNOWN, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, -1
