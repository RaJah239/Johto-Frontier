AI_Status:
; Dismiss status moves that don't affect the player.

	ld hl, wEnemyAIMoveScores - 1
	ld de, wEnemyMonMoves
	ld b, NUM_MOVES + 1
.checkmove
	dec b
	ret z

	inc hl
	ld a, [de]
	and a
	ret z

	inc de
	call AIGetEnemyMove

; Check if the opponent is immune to powder/spore moves.      
	ld a, [wEnemyMoveStruct + MOVE_ANIM]
	push bc
	push de
	push hl
	ld hl, PowderMoves_AIStatus ; ensure `PowderMoves_EffectCommands` matches
	call IsInByteArray
	pop hl
	pop de
	pop bc
	jr nc, .normal_check

	ld a, [wBattleMonType1]
	cp GRASS
	jr z, .immune
	ld a, [wBattleMonType2]
	cp GRASS
	jr z, .immune

.normal_check

	ld a, [wEnemyMoveStruct + MOVE_EFFECT]
	cp EFFECT_TOXIC
	jr z, .poisonimmunity
	cp EFFECT_POISON
	jr z, .poisonimmunity
	cp EFFECT_LEECH_SEED
	jr z, .leechseedimmunity
	cp EFFECT_PARALYZE
	jr z, .typeimmunity

	ld a, [wEnemyMoveStruct + MOVE_POWER]
	and a
	jr z, .checkmove

	jr .typeimmunity

.poisonimmunity
	ld a, [wBattleMonType1]
	cp POISON
	jr z, .immune
	cp STEEL
	jr z, .immune
	ld a, [wBattleMonType2]
	cp POISON
	jr z, .immune
	cp STEEL
	jr z, .immune
	jr .typeimmunity

.leechseedimmunity
	ld a, [wBattleMonType1]
	cp GRASS
	jr z, .immune
	ld a, [wBattleMonType2]
	cp GRASS
	jr z, .immune

.typeimmunity
	push hl
	push bc
	push de
	ld a, 1
	ldh [hBattleTurn], a
	callfar BattleCheckTypeMatchup
	pop de
	pop bc
	pop hl

	ld a, [wTypeMatchup]
	and a
	jr nz, .checkmove

.immune
	call AIDiscourageMove
	jmp .checkmove

PowderMoves_AIStatus::
	db POISONPOWDER
	db SLEEP_POWDER
	db STUN_SPORE
	db -1 ; end
