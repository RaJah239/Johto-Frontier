IsInByteArray::
	ld de, 1
; fallthrough

IsInArray::
; Find value a for every de bytes in array hl.
; Return index in b and carry if found.

	ld b, 0
	ld c, a
.loop
	ld a, [hl]
	cp -1
	jr z, .NotInArray
	cp c
	jr z, .InArray
	inc b
	add hl, de
	jr .loop

.NotInArray:
	and a
	ret

.InArray:
	scf
	ret

SkipNames::
; Skip a names.
	ld bc, NAME_LENGTH
	; fallthrough

AddNTimes::
; Add bc * a to hl. Preserves bc and de; a = 0 afterwards.
	cp 16
	jr nc, .shift_add
	and a
	ret z
.loop
	add hl, bc
	dec a
	jr nz, .loop
	ret

.shift_add
; Large a (move, item and species tables): one step per bit of a, not per
; unit (at most 8 steps instead of up to 255).
	push bc
.bit
	srl a
	jr nc, .no_add
	add hl, bc ; (keeps the zero flag from srl)
.no_add
	jr z, .done
	sla c
	rl b
	jr .bit
.done
	pop bc
	ret

FarFindCurSpeciesInSlots::
; Is [wCurSpecies] among the c (level, species) slots whose first species
; byte is at a:hl? a = 0 (z) if found, 1 (nz) if not. Switches banks once
; for the whole scan (the Pokedex area page used GetFarByte per slot).
	ld b, a
	ldh a, [hROMBank]
	push af
	ld a, b
	rst Bankswitch
	ld a, [wCurSpecies]
	ld b, a
.loop
	ld a, [hli]
	inc hl
	cp b
	jr z, .found
	dec c
	jr nz, .loop
	ld b, 1
	jr .done
.found
	ld b, 0
.done
	pop af
	rst Bankswitch
	ld a, b
	and a
	ret

FarSumCurSpeciesChances::
; a:hl = (chance, species, level) entries ending in -1 (TreeMons sets): b =
; the sum of the chances of the entries with [wCurSpecies]; hl = just past
; the -1. One bank switch for the whole list. Keeps de.
	push de
	ld b, a
	ldh a, [hROMBank]
	push af
	ld a, b
	rst Bankswitch
	ld a, [wCurSpecies]
	ld c, a
	ld b, 0
.loop
	ld a, [hli]
	cp -1
	jr z, .done
	ld d, a ; chance
	ld a, [hli]
	inc hl
	cp c
	jr nz, .loop
	ld a, b
	add d
	ld b, a
	jr .loop
.done
	pop af
	rst Bankswitch
	pop de
	ret

IsInFarByteList::
; Carry if a is in the $ff-terminated byte list at d:hl. Switches banks once
; instead of once per byte. Returns e = a = the value (z, carry) on a match,
; a = $ff (nz, no carry) otherwise; hl is past the byte that ended the
; search. Preserves bc and d.
	ld e, a
	ldh a, [hROMBank]
	push af
	ld a, d
	rst Bankswitch
.loop
	ld a, [hli]
	cp $ff
	jr z, .no
	cp e
	jr nz, .loop
	pop af
	rst Bankswitch
	ld a, e
	cp e ; z
	scf
	ret

.no
	pop af
	rst Bankswitch
	ld a, $ff
	and a ; nz, no carry
	ret
