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
	call AnimateCurrentMove
	call BattleCommand_SwitchTurn
	call ResetMiss
	call BattleCommand_SwitchTurn
	call BattleCommand_AttackUp
	call BattleCommand_StatUpMessage
	call ResetMiss
	call BattleCommand_SpeedUp
	jp BattleCommand_StatUpMessage
.cantraise
; Can't raise either stat.
	ld b, ABILITY + 1
	call GetStatName
	call AnimateFailedMove
	ld hl, WontRiseAnymoreText
	jp StdBattleTextbox