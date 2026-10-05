BattleCommand_FuryDrive:
; fury drive
	ld bc, wPlayerStatLevels
	ldh a, [hBattleTurn]
	and a
	jr z, .go
	ld bc, wEnemyStatLevels
.go
; check if stats can go higher
; Attack
	ld a, [bc]
	cp MAX_STAT_LEVEL
	jr c, .raise
; Speed
	inc bc
	inc bc
	ld a, [bc]
	cp MAX_STAT_LEVEL
	jr c, .raise
; Special Attack
	inc bc
	ld a, [bc]
	cp MAX_STAT_LEVEL
	jr nc, .cantraise
.raise
; Raise Attack Speed, Special Attack.
; Lower Defense and Special Defence
    ld a, $1
	ld [wBattleAnimParam], a
	farcall AnimateCurrentMove
    ld a, DEFENSE
    ld [wLoweredStat], a
	farcall LowerStatFar
	farcall BattleCommand_SwitchTurn
	farcall BattleCommand_StatDownMessage

    farcall BattleCommand_SwitchTurn
    ld a, SP_DEFENSE
    ld [wLoweredStat], a
	farcall LowerStatFar
    farcall BattleCommand_SwitchTurn
	farcall BattleCommand_StatDownMessage

	farcall ResetMiss
	farcall BattleCommand_SwitchTurn
	farcall BattleCommand_AttackUp2
	farcall BattleCommand_StatUpMessage

	farcall ResetMiss
	farcall BattleCommand_SpecialAttackUp2
	farcall BattleCommand_StatUpMessage

	farcall ResetMiss
	farcall BattleCommand_SpeedUp2
	farjp BattleCommand_StatUpMessage

.cantraise
; Can't raise either stat.
	ld b, ABILITY + 1
	farcall GetStatName
	farcall AnimateFailedMove
	ld hl, WontRiseAnymoreText
	jmp StdBattleTextbox
