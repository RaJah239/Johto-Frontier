	object_const_def
	const BATTLETOWERBATTLEROOM_YOUNGSTER
	const BATTLETOWERBATTLEROOM_RECEPTIONIST

BattleTowerBattleRoom_MapScripts:
	def_scene_scripts
	scene_script BattleTowerBattleRoomEnterScene, SCENE_BATTLETOWERBATTLEROOM_ENTER
	scene_script BattleTowerBattleRoomNoopScene,  SCENE_BATTLETOWERBATTLEROOM_NOOP

	def_callbacks

BattleTowerBattleRoomEnterScene:
	disappear BATTLETOWERBATTLEROOM_YOUNGSTER
	sdefer Script_BattleRoom
	setscene SCENE_BATTLETOWERBATTLEROOM_NOOP
	; fallthrough
BattleTowerBattleRoomNoopScene:
	end

Script_BattleRoom:
	applymovement PLAYER, MovementData_BattleTowerBattleRoomPlayerWalksIn
; beat all 3 opponents in a row
Script_BattleRoomLoop:
	setval BATTLETOWERBATTLEROOM_YOUNGSTER
	special LoadOpponentTrainerAndPokemonWithOTSprite
	appear BATTLETOWERBATTLEROOM_YOUNGSTER
	warpsound
	waitsfx
	applymovement BATTLETOWERBATTLEROOM_YOUNGSTER, MovementData_BattleTowerBattleRoomOpponentWalksIn
	opentext
	battletowertext BATTLETOWERTEXT_INTRO
	promptbutton
	closetext
	checkevent EVENT_BATTLE_TOWER_TYPELESS_MODE
	iftrue .Typeless
	checkevent EVENT_BATTLE_TOWER_INVERSE_MODE
	iftrue .Inverse
	sjump .Merge2
.Inverse:
	loadvar VAR_BATTLETYPE, BATTLETYPE_INVERSE
	sjump .Merge2
.Typeless:
	loadvar VAR_BATTLETYPE, BATTLETYPE_TYPELESS
.Merge2:
	special BattleTowerBattle ; predef StartBattle
	special FadeOutPalettes
	reloadmap
	ifnotequal $0, Script_FailedBattleTowerChallenge
	readmem wNrOfBeatenBattleTowerTrainers
	ifequal BATTLETOWER_STREAK_LENGTH, Script_BeatenAllTrainers
	applymovement BATTLETOWERBATTLEROOM_YOUNGSTER, MovementData_BattleTowerBattleRoomOpponentWalksOut
	warpsound
	disappear BATTLETOWERBATTLEROOM_YOUNGSTER
	applymovement BATTLETOWERBATTLEROOM_RECEPTIONIST, MovementData_BattleTowerBattleRoomReceptionistWalksToPlayer
	applymovement PLAYER, MovementData_BattleTowerBattleRoomPlayerTurnsToFaceReceptionist
	opentext
	writetext Text_YourMonWillBeHealedToFullHealth
	waitbutton
	closetext
	special SaveMusic
	playmusic MUSIC_HEAL
	special FadeOutPalettes
	special LoadMapPalettes
	pause 60
	special FadeInPalettes_EnableDynNoApply
	special RestoreMusic
	opentext
	writetext Text_NextUpOpponentNo
	yesorno
	iffalse Script_DontBattleNextOpponent
Script_ContinueAndBattleNextOpponent:
	closetext
	applymovement PLAYER, MovementData_BattleTowerBattleRoomPlayerTurnsToFaceNextOpponent
	applymovement BATTLETOWERBATTLEROOM_RECEPTIONIST, MovementData_BattleTowerBattleRoomReceptionistWalksAway
	sjump Script_BattleRoomLoop

Script_DontBattleNextOpponent:
	writetext Text_SaveAndEndTheSession
	yesorno
	iffalse Script_DontSaveAndEndTheSession
	setval BATTLETOWERACTION_SAVELEVELGROUP ; save level group
	special BattleTowerAction
	setval BATTLETOWERACTION_SAVEOPTIONS ; choose reward
	special BattleTowerAction
	setval BATTLETOWERACTION_SAVE_AND_QUIT ; quicksave
	special BattleTowerAction
	pause 5
	playsound SFX_SAVE
	waitsfx
	pause 10
	special FadeOutPalettes
	special Reset
Script_DontSaveAndEndTheSession:
	writetext Text_CancelYourBattleRoomChallenge
	yesorno
	iffalse Script_ContinueAndBattleNextOpponent
	setval BATTLETOWERACTION_CHALLENGECANCELED
	special BattleTowerAction
	setval BATTLETOWERACTION_06
	special BattleTowerAction
	closetext
	special FadeOutPalettes
	warpfacing UP, BATTLE_TOWER_1F, 7, 7
	opentext
	sjump Script_BattleTowerHopeToServeYouAgain

Script_FailedBattleTowerChallenge:
	pause 30
	special BattleTowerFade
	warpfacing UP, BATTLE_TOWER_1F, 7, 7
	setval BATTLETOWERACTION_CHALLENGECANCELED
	special BattleTowerAction

	callasm CheckCopyEnemyPartyFlag
	ifequal 1, .ResetBattleTowerMirrorModePointsScript

	; check if hard mode was on
    callasm CheckHardModeASM
	iftrue .SetBattleTowerHardModePointsToZero

	callasm ResetBattleTowerPoints
.finish_setting_battle_points_to_zero
	; give back player their party
	setval 0
	writemem wCopyEnemyParty

	opentext
	special TryQuickSave
	writetextend Text_ThanksForVisiting

.SetBattleTowerHardModePointsToZero
	callasm ResetHardModeBattleTowerPoints
	sjump .finish_setting_battle_points_to_zero

.ResetBattleTowerMirrorModePointsScript:
	; check if hard mode was on
    callasm CheckHardModeASM
	iftrue .SetBattleTowerMirrorModeHardModePointsToZero

	callasm ResetBattleTowerMirrorModePoints
	sjump .finish_setting_battle_points_to_zero

.SetBattleTowerMirrorModeHardModePointsToZero
	callasm ResetBattleTowerMirrorModeHardModePoints
	sjump .finish_setting_battle_points_to_zero

ResetBattleTowerMirrorModePoints:
	; determine mode and pick WRAM pointer
	CheckEventFlag EVENT_BATTLE_TOWER_INVERSE_MODE
	jr nz, .inverse

	CheckEventFlag EVENT_BATTLE_TOWER_TYPELESS_MODE
	jr nz, .typeless

.normal
	ld hl, wBattleTowerMirrorModeNormalPoints
	jr .set_zero

.inverse
	ld hl, wBattleTowerMirrorModeInversePoints
	jr .set_zero

.typeless
	ld hl, wBattleTowerMirrorModeTypelessPoints

.set_zero
	ld a, 0
	ld [hl], a
	ret

ResetBattleTowerPoints:
	; determine mode and pick WRAM pointer
	CheckEventFlag EVENT_BATTLE_TOWER_INVERSE_MODE
	jr nz, .inverse

	CheckEventFlag EVENT_BATTLE_TOWER_TYPELESS_MODE
	jr nz, .typeless

.normal
	ld hl, wBattleTowerNormalPoints
	jr .set_zero

.inverse
	ld hl, wBattleTowerInversePoints
	jr .set_zero

.typeless
	ld hl, wBattleTowerTypelessPoints

.set_zero
	ld a, 0
	ld [hl], a
	ret

ResetBattleTowerMirrorModeHardModePoints:
	; determine mode and pick WRAM pointer
	CheckEventFlag EVENT_BATTLE_TOWER_INVERSE_MODE
	jr nz, .inverse

	CheckEventFlag EVENT_BATTLE_TOWER_TYPELESS_MODE
	jr nz, .typeless

.normal
	ld hl, wBattleTowerMirrorModeHardModeNormalPoints
	jr .set_zero

.inverse
	ld hl, wBattleTowerMirrorModeHardModeInversePoints
	jr .set_zero

.typeless
	ld hl, wBattleTowerMirrorModeHardModeTypelessPoints

.set_zero
	ld a, 0
	ld [hl], a
	ret

ResetHardModeBattleTowerPoints:
	; determine mode and pick WRAM pointer
	CheckEventFlag EVENT_BATTLE_TOWER_INVERSE_MODE
	jr nz, .inverse

	CheckEventFlag EVENT_BATTLE_TOWER_TYPELESS_MODE
	jr nz, .typeless

.normal
	ld hl, wBattleTowerHardModeNormalPoints
	jr .set_zero

.inverse
	ld hl, wBattleTowerHardModeInversePoints
	jr .set_zero

.typeless
	ld hl, wBattleTowerHardModeTypelessPoints

.set_zero
	ld a, 0
	ld [hl], a
	ret

Script_BeatenAllTrainers:
	pause 30
	special BattleTowerFade
	warpfacing UP, BATTLE_TOWER_1F, 7, 7
Script_BeatenAllTrainers2:
	opentext
	writetext Text_CongratulationsYouveBeatenAllTheTrainers
	sjump Script_GivePlayerPointsThenPrize

BattleTowerBattleRoom_MapEvents:
	def_warp_events
	warp_event  3,  7, BATTLE_TOWER_HALLWAY, 4
	warp_event  4,  7, BATTLE_TOWER_HALLWAY, 4

	def_coord_events

	def_bg_events

	def_object_events
	object_event  4,  0, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_BATTLE_TOWER_BATTLE_ROOM_YOUNGSTER
	object_event  1,  6, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, -1
