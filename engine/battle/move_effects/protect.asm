BattleCommand_Protect:
	call ProtectChance
	ret c

	ld a, BATTLE_VARS_SUBSTATUS1
	call GetBattleVarAddr
	set SUBSTATUS_PROTECT, [hl]

	farcall AnimateCurrentMove

	ld hl, ProtectedItselfText
	jmp StdBattleTextbox

ProtectChance:
	ld de, wPlayerProtectCount
	ldh a, [hBattleTurn]
	and a
	jr z, .got_count
	ld de, wEnemyProtectCount
.got_count

	farcall CheckOpponentWentFirst
	jr nz, .failed

; Can't have a substitute.

	ld a, BATTLE_VARS_SUBSTATUS4
	call GetBattleVar
	bit SUBSTATUS_SUBSTITUTE, a
	jr nz, .failed

; Protect always fails if used on consecutive turns.
	ld a, [de]
	and a
	jr nz, .failed

; Another consecutive Protect use.
	ld a, 1
	ld [de], a

	and a
	ret

.failed
	xor a
	ld [de], a
	farcall AnimateFailedMove
	farcall PrintButItFailed
	scf
	ret
