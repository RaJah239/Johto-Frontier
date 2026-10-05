BattleCommand_Curse:
	ld de, wBattleMonType1
	ld bc, wPlayerStatLevels
	ldh a, [hBattleTurn]
	and a
	jr z, .go
	ld de, wEnemyMonType1
	ld bc, wEnemyStatLevels

.go
; Curse is different for Ghost-types.

	ld a, [de]
	cp GHOST
	jr z, .ghost
	inc de
	ld a, [de]
	cp GHOST
	jr z, .ghost

; If no stats can be increased, don't.

; Attack
	ld a, [bc]
	cp MAX_STAT_LEVEL
	jr c, .raise

; Defense
	inc bc
	ld a, [bc]
	cp MAX_STAT_LEVEL
	jmp nc, .cantraise

.raise
; Lower Speed, then raise Attack and Defense.
	ld a, $1
	ld [wBattleAnimParam], a
	farcall AnimateCurrentMove
	ld a, SPEED
	ld [wLoweredStat], a
	farcall LowerStatFar
	farcall BattleCommand_SwitchTurn
	farcall BattleCommand_StatDownMessage
	farcall ResetMiss
	farcall BattleCommand_SwitchTurn
	farcall BattleCommand_AttackUp
	farcall BattleCommand_StatUpMessage
	farcall ResetMiss
	farcall BattleCommand_DefenseUp
	farjp BattleCommand_StatUpMessage

.ghost

; Cut HP in half and put a curse on the opponent.

	farcall CheckHiddenOpponent
	jr nz, .failed

	farcall CheckSubstituteOpp
	jr nz, .failed

	ld a, BATTLE_VARS_SUBSTATUS1_OPP
	call GetBattleVarAddr
	bit SUBSTATUS_CURSE, [hl]
	jr nz, .failed

	set SUBSTATUS_CURSE, [hl]
	farcall AnimateCurrentMove
	callfar GetHalfMaxHP
	farcall SubtractHPFromUser
	farcall UpdateUserInParty
	ld hl, PutACurseText
	jmp StdBattleTextbox

.failed
	farcall AnimateFailedMove
	farjp PrintButItFailed

.cantraise
; Can't raise either stat.
	ld b, ABILITY + 1
	farcall GetStatName
	farcall AnimateFailedMove
	ld hl, WontRiseAnymoreText
	jmp StdBattleTextbox
