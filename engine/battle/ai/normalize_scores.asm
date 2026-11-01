NormalizeAIMoveScores:
; Called by AIChooseMove after the scoring layers, before it counts the
; scores down. A move that gets a lot of encouragement can go below 0 and
; wrap around to $ff, which would make the AI's favourite move its least
; likely pick. Treat $e0-$ff as negative (-32 to -1) and shift every move's
; score so the lowest becomes 1, keeping the order between moves.
DEF AI_SCORE_BIAS EQU 32

	; find the lowest biased score among the moves the enemy has
	ld hl, wEnemyAIMoveScores
	ld de, wEnemyMonMoves
	ld b, NUM_MOVES
	ld c, $ff
.find_lowest
	ld a, [de]
	inc de
	and a
	jr z, .next_lowest ; empty move slot
	ld a, [hl]
	add AI_SCORE_BIAS
	cp c
	jr nc, .next_lowest
	ld c, a
.next_lowest
	inc hl
	dec b
	jr nz, .find_lowest

	; score = biased score - lowest + 1 (capped at $ff)
	ld hl, wEnemyAIMoveScores
	ld de, wEnemyMonMoves
	ld b, NUM_MOVES
.shift
	ld a, [de]
	inc de
	and a
	jr z, .next_shift
	ld a, [hl]
	add AI_SCORE_BIAS
	sub c
	inc a
	jr nz, .store
	dec a ; $ff
.store
	ld [hl], a
.next_shift
	inc hl
	dec b
	jr nz, .shift
	ret
