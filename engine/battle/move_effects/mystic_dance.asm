BattleCommand_MysticDance:
; mysticdance
	ld bc, wPlayerStatLevels
	ldh a, [hBattleTurn]
	and a
	jr z, .go
	ld bc, wEnemyStatLevels
.go
; Check Speed
	inc bc
	inc bc
	ld a, [bc]
	cp MAX_STAT_LEVEL
	jr c, .raise

; Check Special Attack
	inc bc
	ld a, [bc]
	cp MAX_STAT_LEVEL
	jr c, .raise

.cantraise
; Can't raise either stat.
	ld b, ABILITY + 1
	farcall GetStatName
	farcall AnimateFailedMove
	ld hl, WontRiseAnymoreText
	jmp StdBattleTextbox

.raise
; Raise Special Attack and Speed.
	ld a, $1
	ld [wBattleAnimParam], a
	farcall AnimateCurrentMove
	farcall BattleCommand_SwitchTurn
	farcall ResetMiss
	farcall BattleCommand_SwitchTurn
	farcall BattleCommand_SpecialAttackUp
	farcall BattleCommand_StatUpMessage
	farcall ResetMiss
	farcall BattleCommand_SpeedUp
	farjp BattleCommand_StatUpMessage
