AI_UseSpeedBoostBeforeKO:
; Called from NormalizeAIMoveScores after the scoring layers.
; If the enemy can KO the player's mon this turn but is slower, survives the
; player's hit this turn, and has a usable move that raises its Speed enough
; to outspeed the player's mon, make that move the clear pick. It boosts now
; and KOs next turn, and stays faster than whatever the player sends in next.
; Speed boosters: Agility (+2), Dragon Dance, Quiver Dance, Flame Charge (+1).
; Exception: if a priority move (e.g. ExtremeSpeed) KOs right now even at its
; lowest roll, that move is picked instead.

	; locked into one move (choice item or Encore): nothing to choose
	ld a, [wEnemySubStatus5]
	bit SUBSTATUS_ENCORED, a
	ret nz

	; must be able to KO the player's mon now...
	farcall CanAIKO
	ret nc
	; ...while being slower...
	farcall DoesAIOutSpeedPlayer
	ret c
	; a priority move that KOs right now beats boosting (and beats being hit
	; first): use it
	call AI_HasPriorityKO
	jr nc, .no_priority_ko
	ld hl, wEnemyAIMoveScores
	ld b, 0
	add hl, bc
	ld [hl], $e0
	ret

.no_priority_ko
	; ...and survive the player's hit while boosting
	farcall CanPlayerKO
	ret c

	ld c, 0 ; move slot
.loop
	ld a, c
	cp NUM_MOVES
	ret z
	ld hl, wEnemyMonMoves
	ld b, 0
	add hl, bc
	ld a, [hl]
	and a
	ret z ; no more moves

	; skip disabled moves and moves with no PP
	ld b, a
	ld a, [wEnemyDisabledMove]
	cp b
	jr z, .next
	ld hl, wEnemyMonPP
	ld a, l
	add c
	ld l, a
	adc h
	sub l
	ld h, a
	ld a, [hl]
	and PP_MASK
	jr z, .next

	; how many Speed stages does it add?
	push bc
	ld a, b
	dec a
	ld hl, Moves + MOVE_EFFECT
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld a, BANK(Moves)
	call GetFarByte
	pop bc
	ld b, 2
	cp EFFECT_SPEED_UP_2
	jr z, .speed_move
	ld b, 1
	cp EFFECT_SPEED_UP
	jr z, .speed_move
	cp EFFECT_SPEED_UP_HIT
	jr z, .speed_move
	cp EFFECT_DRAGON_DANCE
	jr z, .speed_move
	cp EFFECT_QUIVER_DANCE
	jr nz, .next

.speed_move
	push bc
	call AI_FasterAfterSpeedBoost
	pop bc
	jr nc, .next

	; boost first: the lowest score there is (NormalizeAIMoveScores reads
	; $e0 as -32)
	ld hl, wEnemyAIMoveScores
	ld b, 0
	add hl, bc
	ld [hl], $e0
	ret

.next
	inc c
	jr .loop

AI_HasPriorityKO:
; Return carry and the move slot in c if the enemy has a usable damaging move
; with above-normal priority (GetMovePriority, e.g. ExtremeSpeed) that KOs
; the player's mon even at its lowest damage roll (AI_MinRollKOsPlayer).
	ld c, 0 ; move slot
.loop
	ld a, c
	cp NUM_MOVES
	jr z, .no
	ld hl, wEnemyMonMoves
	ld b, 0
	add hl, bc
	ld a, [hl]
	and a
	jr z, .no

	; skip disabled moves and moves with no PP
	ld b, a
	ld a, [wEnemyDisabledMove]
	cp b
	jr z, .next
	ld hl, wEnemyMonPP
	ld a, l
	add c
	ld l, a
	adc h
	sub l
	ld h, a
	ld a, [hl]
	and PP_MASK
	jr z, .next

	; priority above normal?
	push bc
	ld a, [wEnemyMonItem]
	ld c, a
	farcall GetMovePriority_Far
	ld a, b
	pop bc
	cp BASE_PRIORITY + 1
	jr c, .next

	; does it KO at its lowest roll?
	push bc
	ld a, b
	dec a
	ld hl, Moves
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld de, wEnemyMoveStruct
	ld a, BANK(Moves)
	call FarCopyBytes
	ld a, [wEnemyMoveStruct + MOVE_POWER]
	and a
	jr z, .pop_next
	ld a, 1
	ldh [hBattleTurn], a
	callfar EnemyAttackDamage
	callfar BattleCommand_DamageCalc
	callfar BattleCommand_Stab
	farcall AI_MinRollKOsPlayer
	jr c, .pop_yes
.pop_next
	pop bc
.next
	inc c
	jr .loop

.pop_yes
	pop bc
	scf
	ret

.no
	and a
	ret

AI_FasterAfterSpeedBoost:
; b = Speed stages the move adds. Return carry if, with those stages, the
; enemy would outspeed the player's mon (DoesAIOutSpeedPlayer). Uses the
; engine's own stat calculation and restores everything afterwards.
	ld a, [wEnemySpdLevel]
	cp MAX_STAT_LEVEL
	ret nc ; already maxed (carry is clear)
	push af
	add b
	cp MAX_STAT_LEVEL + 1
	jr c, .got_level
	ld a, MAX_STAT_LEVEL
.got_level
	ld [wEnemySpdLevel], a

	; save the enemy's current battle stats
	ld hl, wEnemyMonAttack
	ld b, NUM_BATTLE_STATS
.save
	ld a, [hli]
	ld d, a
	ld a, [hli]
	ld e, a
	push de
	dec b
	jr nz, .save

	ldh a, [hBattleTurn]
	push af
	ld a, 1
	ldh [hBattleTurn], a
	farcall CalcEnemyStats
	farcall DoesAIOutSpeedPlayer
	ld a, 0
	rla
	ld c, a ; 1 if faster
	pop af
	ldh [hBattleTurn], a

	; restore them
	ld hl, wEnemyMonAttack + NUM_BATTLE_STATS * 2 - 1
	ld b, NUM_BATTLE_STATS
.restore
	pop de
	ld a, e
	ld [hld], a
	ld a, d
	ld [hld], a
	dec b
	jr nz, .restore

	pop af
	ld [wEnemySpdLevel], a
	ld a, c
	rra
	ret
