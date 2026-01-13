AI_Aggressive:
; Use whatever does the most damage.

; Discourage all damaging moves but the one that does the most damage.
; If no damaging move deals damage to the player (immune),
; no move will be discouraged

; Figure out which attack does the most damage and put it in c.
	ld hl, wEnemyMonMoves
	ld bc, 0
	ld de, 0
.checkmove
	inc b
	ld a, b
	cp NUM_MOVES + 1
	jr z, .gotstrongestmove

	ld a, [hli]
	and a
	jr z, .gotstrongestmove

	push hl
	push de
	push bc
	call AIGetEnemyMove
	ld a, [wEnemyMoveStruct + MOVE_POWER]
	and a
	jr z, .nodamage
	call AIDamageCalc
	pop bc
	pop de
	pop hl

; don't encourage explosion
	ld a, [wEnemyMoveStruct + MOVE_EFFECT]
	cp EFFECT_SELFDESTRUCT
	jr z, .checkmove

; Dismiss ground move if the player has levitate
; =========================
; === Ability: Levitate ===
; =========================
	ld a, [wEnemyMoveStruct + MOVE_TYPE]
	and TYPE_MASK
	cp GROUND
	jr nz, .check_poison_immune
	ld a, [wBattleMonSpecies]
	push hl
	push de
	push bc
	ld hl, LevitatePokemon
	call IsInByteArray
	pop bc
	pop de
	pop hl
	jr c, .checkmove

.check_poison_immune
; Dismiss poison move if the player has immunity
; =========================
; === Ability: Immunity ===
; =========================
	cp POISON
	jr nz, .continue
	ld a, [wBattleMonSpecies]
	push hl
	push de
	push bc
	ld hl, ImmunityPokemon_AI
	call IsInByteArray
	pop bc
	pop de
	pop hl
	jr c, .checkmove

.continue
; Update current move if damage is highest so far
	ld a, [wCurDamage + 1]
	cp e
	ld a, [wCurDamage]
	sbc d
	jr c, .checkmove

	ld a, [wCurDamage + 1]
	ld e, a
	ld a, [wCurDamage]
	ld d, a
	ld c, b
	jr .checkmove

.nodamage
	pop bc
	pop de
	pop hl
	jr .checkmove

.gotstrongestmove
; Nothing we can do if no attacks did damage.
	ld a, c
	and a
	ret z

; Discourage moves that do less damage unless they're reckless too.
	ld hl, wEnemyAIMoveScores - 1
	ld de, wEnemyMonMoves
	ld b, 0
.checkmove2
	inc b
	ld a, b
	cp NUM_MOVES + 1
	ret z

; Ignore this move if it is the highest damaging one.
	cp c
	ld a, [de]
	inc de
	inc hl
	jr z, .checkmove2

	call AIGetEnemyMove

; Ignore this move if its power is 0 or 1.
; Moves such as Seismic Toss, Hidden Power,
; Counter have a base power of 1.
	ld a, [wEnemyMoveStruct + MOVE_POWER]
	cp 2
	jr c, .checkmove2

; If we made it this far, discourage this move.
.discourage
	inc [hl]
	jr .checkmove2
