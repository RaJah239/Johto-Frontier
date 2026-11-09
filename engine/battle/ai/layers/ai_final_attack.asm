; this discourages most 0 power moves if the player can KO the AI
AI_Final_Attack:
; Discourage stall moves if the player can KO us
; (repo A used `call ShouldAIBoost / ret nc`, which is carry when boosting
; is safe: the opposite of this layer's purpose)
	call CanPlayerKO
	ret nc

	ld hl, wEnemyAIMoveScores - 1
	ld de, wEnemyMonMoves
	ld c, NUM_MOVES + 1
.checkmove
	inc hl
	dec c
	ret z

	ld a, [de]
	inc de
	and a
	ret z

	push hl
	push de
	push bc
	ld hl, StallMoves
	call IsInByteArray

	pop bc
	pop de
	pop hl
	jr nc, .checkmove

; (repo A: a strong +4, so the AI attacks instead of stalling)
	inc [hl]
	inc [hl]
	inc [hl]
	inc [hl]
	jr .checkmove

INCLUDE "data/battle/ai/stall_moves.asm"
