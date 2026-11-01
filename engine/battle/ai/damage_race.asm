GetDamageRaceHits:
; Simulate a straight 1-on-1 between the two active mons, using current HP,
; stat stages and screens (max-roll damage, no crits).
; Returns b = hits the enemy needs to KO the player's mon
;         c = hits the player's mon needs to KO the enemy
; (255 = can't KO). If the enemy is locked into one move (choice item or
; Encore), only that move counts for the enemy. Preserves hBattleTurn and
; wCurDamage, and reloads both move structs from wCurPlayerMove and
; wCurEnemyMove afterwards.
	ldh a, [hBattleTurn]
	push af
	ld a, [wCurDamage]
	push af
	ld a, [wCurDamage + 1]
	push af
	xor a
	ld [wCriticalHit], a

	call DamageRace_EnemyMaxDamage
	ld hl, wBattleMonHP
	call DamageRace_HitsToKO
	push af
	call DamageRace_PlayerMaxDamage
	ld hl, wEnemyMonHP
	call DamageRace_HitsToKO
	ld c, a
	pop af
	ld b, a

	push bc
	call DamageRace_ReloadMoveStructs
	pop bc
	pop af
	ld [wCurDamage + 1], a
	pop af
	ld [wCurDamage], a
	pop af
	ldh [hBattleTurn], a
	ret

DamageRace_EnemyMaxDamage:
; Return in bc the most damage the enemy can do in one hit with a usable move.
	ld de, wEnemyMonMoves
	ld b, NUM_MOVES + 1
	ld hl, wEnemySubStatus5
	bit SUBSTATUS_ENCORED, [hl]
	jr z, .got_moves
	; locked into one move: only that move counts
	ld a, [wCurEnemyMoveNum]
	add e
	ld e, a
	adc d
	sub e
	ld d, a
	ld b, 1 + 1
.got_moves
	call DamageRace_ResetMax
.loop
	dec b
	jmp z, DamageRace_GetMax
	ld a, [de]
	and a
	jmp z, DamageRace_GetMax
	inc de
	push de
	push bc
	ld de, wEnemyMoveStruct
	call DamageRace_LoadMove
	jr z, .next
	ld a, 1
	ldh [hBattleTurn], a
	callfar EnemyAttackDamage
	callfar BattleCommand_DamageCalc
	callfar BattleCommand_Stab
	call DamageRace_KeepMax
.next
	pop bc
	pop de
	jr .loop

DamageRace_PlayerMaxDamage:
; Return in bc the most damage the player's mon can do in one hit.
	ld de, wBattleMonMoves
	ld b, NUM_MOVES + 1
	call DamageRace_ResetMax
.loop
	dec b
	jmp z, DamageRace_GetMax
	ld a, [de]
	and a
	jmp z, DamageRace_GetMax
	inc de
	push de
	push bc
	ld de, wPlayerMoveStruct
	call DamageRace_LoadMove
	jr z, .next
	xor a
	ldh [hBattleTurn], a
	callfar PlayerAttackDamage
	callfar BattleCommand_DamageCalc
	callfar BattleCommand_Stab
	call DamageRace_KeepMax
.next
	pop bc
	pop de
	jr .loop

DamageRace_LoadMove:
; Copy move a into the move struct at de.
; Returns z to skip it: no power, Explosion, or a two-turn (Solar Beam) move.
	push de
	dec a
	ld hl, Moves
	ld bc, MOVE_LENGTH
	call AddNTimes
	pop de
	push de
	ld a, BANK(Moves)
	call FarCopyBytes
	pop hl
	inc hl ; MOVE_EFFECT
	ld b, [hl]
	inc hl ; MOVE_POWER
	ld a, [hl]
	and a
	ret z
	ld a, b
	cp EFFECT_EXPLOSION
	ret z
	cp EFFECT_SOLARBEAM
	ret z
	or 1 ; nz
	ret

DamageRace_ResetMax:
	xor a
	ld [wEnemySwitchMaxDamage], a
	ld [wEnemySwitchMaxDamage + 1], a
	ret

DamageRace_KeepMax:
; wEnemySwitchMaxDamage (big-endian here) = max(itself, wCurDamage)
	ld a, [wEnemySwitchMaxDamage + 1]
	ld c, a
	ld a, [wCurDamage + 1]
	sub c
	ld a, [wEnemySwitchMaxDamage]
	ld b, a
	ld a, [wCurDamage]
	sbc b
	ret c
	ld a, [wCurDamage]
	ld [wEnemySwitchMaxDamage], a
	ld a, [wCurDamage + 1]
	ld [wEnemySwitchMaxDamage + 1], a
	ret

DamageRace_GetMax:
	ld a, [wEnemySwitchMaxDamage]
	ld b, a
	ld a, [wEnemySwitchMaxDamage + 1]
	ld c, a
	ret

DamageRace_HitsToKO:
; bc = damage per hit, hl = pointer to big-endian HP.
; Return in a the number of hits to bring HP to 0 (255 if bc is 0).
	ld a, b
	or c
	jr nz, .can_damage
	ld a, 255
	ret

.can_damage
	ld a, [hli]
	ld d, a
	ld e, [hl]
	ld h, 0
.loop
	inc h
	ld a, h
	cp 255
	jr z, .done
	ld a, e
	sub c
	ld e, a
	ld a, d
	sbc b
	ld d, a
	jr c, .done ; HP went below 0
	or e
	jr nz, .loop ; HP still above 0
.done
	ld a, h
	ret

DamageRace_ReloadMoveStructs:
	ld a, [wCurPlayerMove]
	and a
	jr z, .enemy
	ld de, wPlayerMoveStruct
	call .copy
.enemy
	ld a, [wCurEnemyMove]
	and a
	ret z
	ld de, wEnemyMoveStruct
.copy
	dec a
	ld hl, Moves
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld a, BANK(Moves)
	jmp FarCopyBytes
