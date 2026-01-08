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
	dbw EFFECT_AVALANCHE,       BattleCommand_Avalanche
	dbw EFFECT_RAIN_DANCE,      BattleCommand_StartRain
	dbw EFFECT_SUNNY_DAY,       BattleCommand_StartSun
	dbw EFFECT_SANDSTORM,       BattleCommand_StartSandstorm
	dbw EFFECT_BARRIER,         BattleCommand_Barrier
	dbw EFFECT_TRICK_ROOM,		BattleCommand_TrickRoom
	dbw EFFECT_TAUNT,           BattleCommand_Taunt
	dbw EFFECT_BRICK_BREAK,     BattleCommand_BreakScreens
	dbw EFFECT_OHKO,            BattleCommand_OHKO
	dbw EFFECT_SPLASH,          BattleCommand_Splash
	dbw EFFECT_LEECH_SEED,      BattleCommand_LeechSeed
	dbw EFFECT_NIGHTMARE,       BattleCommand_Nightmare
	db -1 ; end
