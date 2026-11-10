; 16-bit species / move index conversions (see engine/16/table_functions.asm)

MACRO ___conversion_table_homecall
	; macro arguments: homecall type, function label
	; all functions clobber af and hl (except for outputs) and preserve bc and de
	; homecall types:
	; - read: ID to index conversion (in: a = 8-bit ID; out: hl = 16-bit index)
	; - write: index to ID conversion (in: hl = 16-bit index; out: a = 8-bit ID)
	; - lock: ID locking (in: a = ID (or zero to unlock), l = position; out: a = preserved)
	if strcmp("\1", "read") && strcmp("\1", "write") && strcmp("\1", "lock")
		fail "16-bit homecall: invalid call type"
	endc

	if strcmp("\1", "write")
		ld h, a
	endc
	ldh a, [hROMBank]
	push af
	ld a, BANK(\2)
	rst Bankswitch
	if !strcmp("\1", "read")
		ld a, h
	endc
	call \2
	if strcmp("\1", "read")
		ld l, a
	endc
	pop af
	rst Bankswitch
	if strcmp("\1", "read")
		ld a, l
	endc
	ret
ENDM

MACRO ___conversion_table_homecall_readlocked
	; macro argument: table name
	; in: a = position
	; out: a = 8-bit ID; everything else preserved
	push hl
	add LOW(\1LockedEntries)
	ld l, a
	ldh a, [rSVBK]
	ld h, a
	ld a, BANK(\1LockedEntries)
	ldh [rSVBK], a
	ld a, h
	ld h, HIGH(\1LockedEntries)
	ld l, [hl]
	ldh [rSVBK], a
	ld a, l
	pop hl
	ret
ENDM

; in: a = 8-bit ID
; out: hl = 16-bit index; a clobbered
GetPokemonIndexFromID::
	___conversion_table_homecall read, _GetPokemonIndexFromID

; in: hl = 16-bit index
; out: a = 8-bit ID, hl clobbered
GetPokemonIDFromIndex::
	___conversion_table_homecall write, _GetPokemonIDFromIndex

; in: a = 8-bit ID or zero (to clear), l = position
; out: a = unchanged, hl = clobbered
LockPokemonID::
	___conversion_table_homecall lock, _LockPokemonID

if MON_TABLE_LOCKED_ENTRIES
; in: a = position
; out: a = 8-bit ID; everything else preserved
GetLockedPokemonID::
	___conversion_table_homecall_readlocked wPokemonIndexTable
endc

; in: a = 8-bit ID
; out: hl = 16-bit index; a clobbered
GetMoveIndexFromID::
	___conversion_table_homecall read, _GetMoveIndexFromID

; in: hl = 16-bit index
; out: a = 8-bit ID, hl clobbered
GetMoveIDFromIndex::
	___conversion_table_homecall write, _GetMoveIDFromIndex

; in: a = 8-bit ID or zero (to clear), l = position
; out: a = unchanged, hl = clobbered
LockMoveID::
	___conversion_table_homecall lock, _LockMoveID

if MOVE_TABLE_LOCKED_ENTRIES
; in: a = position
; out: a = 8-bit ID; everything else preserved
GetLockedMoveID::
	___conversion_table_homecall_readlocked wMoveIndexTable
endc

IsSpeciesInList::
; a = species ID, hl = a list of 16-bit species indexes (dw, ending with -1):
; carry if the species is in it. Preserves bc and de.
	push de
	push hl
	call GetPokemonIndexFromID
	ld d, h
	ld e, l
	pop hl
.loop
	ld a, [hli]
	and [hl] ; $ff only at the end (-1)
	inc a
	jr z, .done ; (carry clear)
	dec hl
	ld a, [hli]
	cp e
	jr nz, .next
	ld a, [hl]
	cp d
	jr z, .found
.next
	inc hl
	jr .loop
.found
	scf
.done
	pop de
	ret

IsSpeciesInFarList::
; Like IsSpeciesInList, for a list at d:hl. Clobbers de.
	ld e, a
	ldh a, [hROMBank]
	push af
	ld a, d
	rst Bankswitch
	ld a, e
	call IsSpeciesInList
	pop de
	ld a, d
	rst Bankswitch ; (flags untouched)
	ret

_CompareSpeciesIndex::
; (cp_species) z if species ID a is the 16-bit species index in the dw after
; the call, which is skipped. Preserves a, bc, de and hl; carry is clear.
	push hl
	push de
	push bc
	push af
	ld hl, sp + 8 ; the return address
	ld e, [hl]
	inc hl
	ld d, [hl] ; de = the dw
	inc de
	inc de
	ld [hl], d
	dec hl
	ld [hl], e ; return past it
	dec de
	ld a, [de]
	ld b, a
	dec de
	ld a, [de]
	ld c, a ; bc = the index to compare with
	pop af
	push af
	call GetPokemonIndexFromID
	ld a, l
	xor c
	ld c, a
	ld a, h
	xor b
	or c
	ld c, 0
	jr nz, .got_flags
	ld c, 1 << 7 ; z
.got_flags
	ld hl, sp + 0
	ld [hl], c ; the pushed f
	pop af
	pop bc
	pop de
	pop hl
	ret

PrintSpeciesNumber::
; a = species ID, hl = where: print its № (its 16-bit index), three digits with
; leading zeros. Preserves hl. Clobbers af, bc and de.
	assert NUM_POKEMON < 1000, "PrintSpeciesNumber prints three digits"
	push hl
	call GetPokemonIndexFromID
	ld a, h
	ld [wSpeciesNumberBuffer], a
	ld a, l
	ld [wSpeciesNumberBuffer + 1], a
	pop hl
	push hl
	ld de, wSpeciesNumberBuffer
	lb bc, PRINTNUM_LEADINGZEROS | 2, 3
	call PrintNum
	pop hl
	ret
