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
	db -1 ; end
