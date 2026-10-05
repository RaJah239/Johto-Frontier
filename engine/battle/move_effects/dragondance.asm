BattleCommand_DragonDance:
; dragondance
	ld bc, wPlayerStatLevels
	ldh a, [hBattleTurn]
	and a
	jr z, .go
	ld bc, wEnemyStatLevels
.go
; check if stats can go higher
; Attack
    ld a, [bc]
	ld a, [bc]
	cp MAX_STAT_LEVEL
	jr c, .raise
; Speed
	inc bc
	inc bc
	ld a, [bc]
	cp MAX_STAT_LEVEL
	jr nc, .cantraise
.raise
; Raise Attack and Speed.
    ld a, $1
	ld [wBattleAnimParam], a
	farcall AnimateCurrentMove
	farcall BattleCommand_SwitchTurn
	farcall ResetMiss
	farcall BattleCommand_SwitchTurn
	farcall BattleCommand_AttackUp
	farcall BattleCommand_StatUpMessage
	farcall ResetMiss
	farcall BattleCommand_SpeedUp
	farjp BattleCommand_StatUpMessage

.cantraise
; Can't raise either stat.
	ld b, ABILITY + 1
	farcall GetStatName
	farcall AnimateFailedMove
	ld hl, WontRiseAnymoreText
	jmp StdBattleTextbox
