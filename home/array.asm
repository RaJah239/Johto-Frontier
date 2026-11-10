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
; Add bc * a to hl.
	and a
	ret z
.loop
	add hl, bc
	dec a
	jr nz, .loop
	ret

FarFindCurSpeciesInSlots::
; Is [wCurSpecies] among the c (db level / dw species) slots whose first
; species is at a:hl? a = 0 (z) if found, 1 (nz) if not. Switches banks once
; for the whole scan (the Pokedex area page used GetFarByte per slot).
	push de
	ld b, a
	ldh a, [hROMBank]
	push af
	ld a, b
	rst Bankswitch
	push hl
	ld a, [wCurSpecies]
	call GetPokemonIndexFromID
	ld d, h
	ld e, l
	pop hl
.loop
	ld a, [hli]
	cp e
	jr nz, .next
	ld a, [hl]
	cp d
	jr z, .found
.next
	inc hl ; next level
	inc hl ; next species
	dec c
	jr nz, .loop
	ld b, 1
	jr .done
.found
	ld b, 0
.done
	pop af
	rst Bankswitch
	pop de
	ld a, b
	and a
	ret

FarSumCurSpeciesChances::
; a:hl = (db chance / dw species / db level) entries ending in -1 (TreeMons sets): b =
; the sum of the chances of the entries with [wCurSpecies]; hl = just past
; the -1. One bank switch for the whole list. Keeps de.
	push de
	ld b, a
	ldh a, [hROMBank]
	push af
	ld a, b
	rst Bankswitch
	push hl
	ld a, [wCurSpecies]
	call GetPokemonIndexFromID
	ld d, h
	ld e, l ; de = its 16-bit index
	pop hl
	ld b, 0
.loop
	ld a, [hli]
	cp -1
	jr z, .done
	ld c, a ; chance
	ld a, [hli] ; species (dw)
	cp e
	jr nz, .no_match
	ld a, [hl]
	cp d
	jr nz, .no_match
	ld a, b
	add c
	ld b, a
.no_match
	inc hl
	inc hl ; level
	jr .loop
.done
	pop af
	rst Bankswitch
	pop de
	ret
