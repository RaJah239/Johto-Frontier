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
	ld a, c
	and a
	ret z ; no move
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
	ret nz
	ld hl, wBattleMonHP
	ld a, e
	and a
	jr z, .got_hp
	ld hl, wEnemyMonHP
.got_hp
	call GaleWingsIsFullHP
	ret nz
	inc b
	ret

GaleWingsIsFlyingMove:
; z if move a is Flying-type. Preserves bc and de.
	push bc
	push de
	dec a
	ld hl, Moves + MOVE_TYPE
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld a, BANK(Moves)
	call GetFarByte
	pop de
	pop bc
	and TYPE_MASK
	cp FLYING
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
