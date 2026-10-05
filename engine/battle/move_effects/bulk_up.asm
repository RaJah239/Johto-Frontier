BattleCommand_BulkUp:
; bulk_up
	ld bc, wPlayerStatLevels
	ldh a, [hBattleTurn]
	and a
	jr z, .go
	ld bc, wEnemyStatLevels
.go
; If no stats can be increased, don't.
; Attack
	ld a, [bc]
	cp MAX_STAT_LEVEL
	jr c, .raise
; Defense
	inc bc
	ld a, [bc]
	cp MAX_STAT_LEVEL
	jr nc, .cantraise
.raise
; Raise Attack and Defense, and lower Speed.
	ld a, $1
	ld [wBattleAnimParam], a
	farcall AnimateCurrentMove
	farcall BattleCommand_SwitchTurn
	farcall ResetMiss
	farcall BattleCommand_SwitchTurn
	farcall BattleCommand_AttackUp
	farcall BattleCommand_StatUpMessage
	farcall ResetMiss
	farcall BattleCommand_DefenseUp
	farjp BattleCommand_StatUpMessage

.cantraise
; Can't raise either stat.
	ld b, ABILITY + 1
	farcall GetStatName
	farcall AnimateFailedMove
	ld hl, WontRiseAnymoreText
	jmp StdBattleTextbox
