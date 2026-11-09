; The enemy never uses a damaging move that can't affect the player: one the
; player's types are immune to (Foresight, Odor Sleuth and Miracle Eye lift
; those immunities, as in battle) or its ability makes it immune to. It uses
; one only when no usable move would do anything.

AI_DismissImmuneMoves:
; Called by AIChooseMove after every scoring layer and NormalizeAIMoveScores.
; Gives immune moves the worst usable score ($fe) and unusable moves (out of
; PP or disabled) $ff, so no layer's encouragement can pick them over a move
; that works.
	ld c, 0
.loop
	ld hl, wEnemyMonMoves
	ld b, 0
	add hl, bc
	ld a, [hl]
	and a
	ret z
	call EnemyMoveSlotUnusable
	ld a, $ff
	jr c, .set
	call EnemyMoveSlotHasNoEffect
	jr nc, .next
	ld a, $fe
.set
	ld hl, wEnemyAIMoveScores
	ld b, 0
	add hl, bc
	ld [hl], a
.next
	inc c
	ld a, c
	cp NUM_MOVES
	jr nz, .loop
	ret

AI_WildRerollImmuneMove:
; Wild mons pick a usable move at random. c = the slot picked.
; Return carry to pick again: the move can't affect the player and another
; usable move can.
	call EnemyMoveSlotHasNoEffect
	ret nc
	ld e, c
	ld c, 0
.loop
	ld a, c
	cp e
	jr z, .next
	push de
	call EnemyMoveSlotUnusable
	jr c, .next_pop
	call EnemyMoveSlotHasNoEffect
	jr nc, .found
.next_pop
	pop de
.next
	inc c
	ld a, c
	cp NUM_MOVES
	jr nz, .loop
	ld c, e
	and a
	ret

.found
	pop de
	ld c, e
	scf
	ret

EnemyMoveSlotUnusable:
; c = move slot (0-3). Return carry if it's empty, out of PP or disabled.
; Preserves bc.
	ld hl, wEnemyMonMoves
	ld b, 0
	add hl, bc
	ld a, [hl]
	and a
	jr z, .unusable
	ld hl, wEnemyMonPP
	add hl, bc
	ld a, [hl]
	and PP_MASK
	jr z, .unusable
	ld a, [wEnemyDisableCount]
	swap a
	and $f
	dec a ; disabled slot, or $ff
	cp c
	jr z, .unusable
	and a
	ret

.unusable
	scf
	ret

EnemyMoveSlotHasNoEffect:
; c = move slot (0-3). Return carry if the enemy's move there is damaging and
; can't affect the player. Loads the move into wEnemyMoveStruct.
; Preserves bc.
	push bc
	ld hl, wEnemyMonMoves
	ld b, 0
	add hl, bc
	ld a, [hl]
	dec a
	ld hl, Moves
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld de, wEnemyMoveStruct
	ld a, BANK(Moves)
	call FarCopyBytes
	pop bc

; status moves aren't stopped by type (like AI_Types)
	ld a, [wEnemyMoveStruct + MOVE_POWER]
	and a
	ret z

; type immunity; BattleCheckTypeMatchup skips the immunities listed after
; its Foresight marker (Ghost vs Normal/Fighting) when the player is identified
	push bc
	ldh a, [hBattleTurn]
	push af
	ld a, 1
	ldh [hBattleTurn], a
	farcall BattleCheckTypeMatchup
	pop af
	ldh [hBattleTurn], a
	pop bc
	ld a, [wTypeMatchup]
	and a
	jr z, .no_effect

; ability immunity (Levitate, Waterproof, Flame Ward, Grounded, Immunity)
	push bc
	ld a, [wEnemyMoveStruct + MOVE_TYPE]
	and TYPE_MASK
	ld b, a
	farcall AI_IsPlayerImmuneByAbility
	pop bc
	ret

.no_effect
	scf
	ret
