BattlePlazaBattleLobby_MapEvents:
	def_warp_events
	warp_event  4, 13, BATTLE_PLAZA, 7
	warp_event  3, 13, BATTLE_PLAZA, 6

	def_coord_events

	def_bg_events
	bg_event  2, 10, BGEVENT_JUMPTEXT, BattleLobbyInfoSignText

	def_object_events
	object_event  3, 10, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_TEAL, OBJECTTYPE_SCRIPT, 0, BattleLobbyReceptionistScript, -1
	object_event  4,  3, SPRITE_UNKNOWN, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, -1

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
	writethistext
		text "Battle Lobby"
		line "Welcomes you!"
		done
	promptbutton
	special TryQuickSave
	iffalse_endtext
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
	writetext BattlePlazasReceptionistGoRightInText
	waitclosetext
	applymovement BATTLEPLAZABATTLELOBBY_RECEPTIONIST, BattlePlazasReceptionist_MoveOutTheWay
	applymovement PLAYER, BattlePlazasPlayer_EnterBattleRoom
	winlosstext BattlePlazasPlayerVictoryText, 0
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
	writetext BattlePlazasBattleLoseText
	waitendtext

.win
	dontrestartmapmusic
	reloadmapafterbattle
	pause 15
	special BattleTowerFade
	warpfacing UP, BATTLE_PLAZA_BATTLE_LOBBY, 3, 11
	turnobject PLAYER, UP
	opentext
	writetext BattlePlazasBattleWinText
	promptbutton
	special LoadPokemonData
	special HealParty
.GivePrize:
	writetext BattlePlazasPrizeText
	verbosegiveitem CRYSTAL
	iffalse BattleLobbyPackFull
	clearevent EVENT_DID_NOT_GET_BATTLE_LOBBY_PRIZE
	endtext

.Cancel:
	writetext BattlePlazasPleaseComeAgainText
	waitclosetext
	turnobject PLAYER, DOWN
	end

BattleLobbyPackFull:
	setevent EVENT_DID_NOT_GET_BATTLE_LOBBY_PRIZE
	writetext BattlePlazasFullPackText
	waitendtext

BattlePlazasReceptionist_MoveOutTheWay:
	step UP
    step RIGHT
    turn_head LEFT
    step_end

BattlePlazasPlayer_EnterBattleRoom:
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

BattlePlazasPleaseComeAgainText:
	text "Do come again."
	done

BattlePlazasReceptionistGoRightInText:
	text "Please go right"
	line "through."
	done

BattlePlazasPlayerVictoryText:
	text "Player Victory!"
	done

BattlePlazasBattleLoseText:
	text "We hope to serve"
	line "you again."
    done

BattlePlazasBattleWinText:
    text "Excellent work!"
    done

BattlePlazasPrizeText:
    text "Please accept"
    line "this prize."
    done

BattlePlazasFullPackText:
	text "Return once you've"
	line "made space for it."
	done

BattleLobbyInfoSignText:
	text "You may fight a"
	line "random trainer"
	cont "here."

	para "Each victory will"
	line "net you a Crystal."
	done
