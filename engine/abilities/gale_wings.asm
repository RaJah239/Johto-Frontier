; ==============================
; === Ability: Gale Wings    ===
; ==============================
; Flying-type moves used by a Gale Wings mon get +1 priority while it's at
; full HP (a normal move then goes like Quick Attack / Extreme Speed). The
; popup shows the first time it uses a Flying move at full HP after it comes
; out (each time it's sent out).

MovePriorityAbilities::
; b = the priority of move c used by species d on side e (0 = player,
; 1 = enemy). Apply the abilities that raise it. For farjp: returns b.
	call GaleWingsPriority
	jr PranksterPriority

GaleWingsPriority_Far::
; GaleWingsPriority for newfarcall (the AI's priority helpers).
GaleWingsPriority:
; Add 1 to b if move c is Flying-type, species d has Gale Wings and the mon
; on side e is at full HP. Preserves c, d and e.
	call GaleWingsQualifies
	ret nc
	call GaleWingsSideHP
	call GaleWingsIsFullHP
	ret nz
	inc b
	ret

GaleWingsQualifies:
; Carry if move c is Flying-type and species d has Gale Wings (whatever its
; HP). Preserves bc and de.
	ld a, c
	and a
	ret z ; no move (and no carry)
	push bc
	push de
	ld a, d
	ld hl, GaleWingsPokemon
	call IsInAbilityList
	pop de
	pop bc
	ret nc
	ld a, c
	call GaleWingsIsFlyingMove
	scf
	ret z
	and a
	ret

GaleWingsSideHP:
; hl = the HP of side e's mon (0 = player, 1 = enemy).
	ld hl, wBattleMonHP
	ld a, e
	and a
	ret z
	ld hl, wEnemyMonHP
	ret

GaleWingsIsFlyingMove:
; z if move a is Flying-type. Preserves bc and de.
	ld hl, Moves + MOVE_TYPE
	call GaleWingsMoveByte
	and TYPE_MASK
	cp FLYING
	ret

GaleWingsIsDamagingMove:
; nz if move a has power. Preserves bc, de and hl.
	push hl
	ld hl, Moves + MOVE_POWER
	call GaleWingsMoveByte
	pop hl
	and a
	ret

GaleWingsMoveByte:
; a = the byte of move a at hl (Moves + MOVE_*). Preserves bc and de.
	push bc
	push de
	dec a
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld a, BANK(Moves)
	call GetFarByte
	pop de
	pop bc
	ret

GaleWingsIsFullHP:
; z if the HP at hl (big endian, followed by the max HP) is full.
; Preserves bc and de.
	push de
	ld a, [hli]
	ld d, a
	ld a, [hli]
	ld e, a
	ld a, [hli]
	cp d
	jr nz, .done
	ld a, [hl]
	cp e
.done
	pop de
	ret

; --- for the AI (newfarcall: they preserve bc, de and hl) ---
GaleWingsSimCheck_Far::
; For the matchup simulation: c = move, d = species, e = side. Carry if
; Gale Wings gives the move priority when the mon is at full HP; then a = 1
; if it's at full HP right now (its priority already counts it), else 0.
	push hl
	call GaleWingsQualifies
	jr nc, .done
	call GaleWingsSideHP
	call GaleWingsIsFullHP
	ld a, 0
	jr nz, .got
	inc a
.got
	scf
.done
	pop hl
	ret

GaleWingsPlayerHasPriority_Far::
; Carry if the player's mon has Gale Wings priority on a Flying attack it
; knows: it has the ability, it's at full HP and it knows one.
	push hl
	ld hl, wBattleMonHP
	call GaleWingsIsFullHP
	pop hl
	jr z, .full
	and a
	ret
.full
	push hl
	push bc
	push de
	ld hl, wBattleMonMoves
	ld a, [wBattleMonSpecies]
	jr GaleWingsHasFlyingAttack

GaleWingsEnemyHasFlyingAttack_Far::
; Carry if the enemy's mon has Gale Wings and knows a Flying attack (at any
; HP).
	push hl
	push bc
	push de
	ld hl, wEnemyMonMoves
	ld a, [wEnemyMonSpecies]
	; fallthrough

GaleWingsHasFlyingAttack:
; (with hl, bc and de pushed) Carry if species a has Gale Wings and one of
; the NUM_MOVES moves at hl is a Flying attack.
	ld d, a
	ld b, NUM_MOVES
.loop
	ld a, [hli]
	and a
	jr z, .no
	ld c, a
	push hl
	call GaleWingsQualifies
	pop hl
	jr nc, .next
	ld a, c
	call GaleWingsIsDamagingMove
	jr nz, .yes
.next
	dec b
	jr nz, .loop
.no
	and a
	jr .done
.yes
	scf
.done
	pop de
	pop bc
	pop hl
	ret

GaleWingsPopup:
; hBattleTurn = the user. Only for Flying moves used at full HP.
	ldh a, [hBattleTurn]
	and a
	ld a, [wCurPlayerMove]
	ld hl, wBattleMonHP
	jr z, .got_move
	ld a, [wCurEnemyMove]
	ld hl, wEnemyMonHP
.got_move
	and a
	ret z
	push hl
	call GaleWingsIsFlyingMove
	pop hl
	ret nz
	call GaleWingsIsFullHP
	ret nz
	ld hl, GaleWingsPokemon
	ld de, GaleWingsText
	ld c, SEND_OUT_POPUP_GALE_WINGS
	jmp SendOutAbilityPopup

GaleWingsText: db "Gale Wings@"

INCLUDE "data/abilities/gale_wings_mons.asm"
