BattleCommand_FakeOut:
	; Only allow this move on the first turn.
	ldh a, [hBattleTurn]
	and a
	ld hl, wPlayerTurnsTaken
	ld b, 0
	jr z, .got_turns_taken
	ld hl, wEnemyTurnsTaken
	inc b
.got_turns_taken
	; Fail if we didn't move first.
	ld a, [wEnemyGoesFirst]
	xor b
	jr nz, .failed

	; Only allow on the first turn.
	ld a, [hl]
	dec a
	ret z

.failed
	farcall AnimateFailedMove
	farcall PrintButItFailed
	farjp EndMoveEffect
