CountSetBits16::
; Count the set bits in the b bytes at hl (the dex flags: more than 255 can
; be set): hl = the count, also big-endian in wSpeciesNumberBuffer, for
; PrintNum. Clobbers af, bc and de.
	ld de, 0
.next
	ld a, [hli]
	ld c, 8
.count
	srl a
	jr nc, .not_set
	inc de
.not_set
	dec c
	jr nz, .count
	dec b
	jr nz, .next
	ld a, d
	ld [wSpeciesNumberBuffer], a
	ld a, e
	ld [wSpeciesNumberBuffer + 1], a
	ld h, d
	ld l, e
	ret

CountSetBits::
; Count the number of set bits in b bytes starting from hl.
; Return in a, c and [wNumSetBits].
	ld c, 0
.next
	ld a, [hli]
	ld e, a
	ld d, 8

.count
	srl e
	ld a, 0
	adc c
	ld c, a
	dec d
	jr nz, .count

	dec b
	jr nz, .next

	ld a, c
	ld [wNumSetBits], a
	ret

GetWeekday::
	ld a, [wCurDay]
.mod
	sub 7
	jr nc, .mod
	add 7
	ret

; The Pokedex flags are indexed by 16-bit species index - 1. These take
; a = species ID; CHECK_FLAG returns nz (and c != 0) if the flag is set.

SetSeenAndCaughtMon::
	push af
	ld hl, wPokedexCaught
	ld b, SET_FLAG
	call PokedexFlagAction
	pop af
	; fallthrough

SetSeenMon::
	ld hl, wPokedexSeen
	ld b, SET_FLAG
	jr PokedexFlagAction

CheckCaughtMon::
	ld hl, wPokedexCaught
	ld b, CHECK_FLAG
	jr PokedexFlagAction

CheckSeenMon::
	ld hl, wPokedexSeen
	ld b, CHECK_FLAG
	; fallthrough

PokedexFlagAction::
; Perform action b on species a's flag in array hl.
	push hl
	call GetPokemonIndexFromID
	ld d, h
	ld e, l
	pop hl
	; fallthrough

PokedexFlagActionByIndex::
; Perform action b on the flag of 16-bit species index de in array hl.
	dec de
	call FlagAction
	ld a, c
	and a
	ret
