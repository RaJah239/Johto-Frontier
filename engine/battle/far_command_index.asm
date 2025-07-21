Find_Command:
; Find the appropriate battle command based on the move effect.
; Based on code from engine/battle/ai/redundant.asm
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar

	ld hl, FarCommand_BattleCommands
	ld de, 3
	call IsInArray
	ret nc

	inc hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

FarCommand_BattleCommands:
	dbw EFFECT_FALSE_SWIPE, 	BattleCommand_FalseSwipe
	dbw EFFECT_PAIN_SPLIT,      BattleCommand_PainSplit
	dbw EFFECT_DISABLE, 		BattleCommand_Disable
	dbw EFFECT_SELFDESTRUCT, 	BattleCommand_Selfdestruct
	dbw EFFECT_THIEF, 			BattleCommand_Thief
	dbw EFFECT_TOXIC_SPIKES,	BattleCommand_ToxicSpikes
	dbw EFFECT_THUNDER,			BattleCommand_ThunderAccuracy
	dbw EFFECT_HAIL,			BattleCommand_StartHail
	dbw EFFECT_FORESIGHT,       BattleCommand_Foresight
	dbw EFFECT_FAKE_OUT,        BattleCommand_FakeOut
	dbw EFFECT_FREEZE_DRY,      BattleCommand_FreezeDry
	dbw EFFECT_SUCKER_PUNCH,    BattleCommand_SuckerPunch
	db -1 ; end
