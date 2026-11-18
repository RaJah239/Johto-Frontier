GiveOddEgg:
_GiveOddEgg:
	; Figure out which egg to give.

	; Compare a random word to probabilities out of $ffff.
	call Random
	ld hl, OddEggProbabilities
	ld c, 0
	ld b, c
.loop
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a

	; Break on $ffff.
	ld a, d
	cp HIGH($ffff)
	jr nz, .not_done
	ld a, e
	cp LOW($ffff)
	jr z, .done
.not_done

	; Break when the random word <= the next probability in de.
	ldh a, [hRandomSub]
	cp d
	jr c, .done
	jr z, .ok
	jr .next
.ok
	ldh a, [hRandomAdd]
	cp e
	jr c, .done
	jr z, .done
.next
	inc bc
	jr .loop
.done

	ld hl, OddEggs
	ld a, PARTYMON_STRUCT_LENGTH
	call AddNTimes

	; Writes to wOddEgg
	ld de, wOddEgg
	ld bc, PARTYMON_STRUCT_LENGTH
	call CopyBytes

	ld a, EGG_TICKET
	ld [wCurItem], a
	ld a, 1
	ld [wItemQuantityChange], a
	ld a, -1
	ld [wCurItemQuantity], a
	ld hl, wNumItems
	call TossItem

	ld hl, wPartyCount
	ld a, [hl]
	ld [wCurPartyMon], a
	inc [hl]
	ld c, a
	ld b, 0
	ld hl, wPartySpecies
	add hl, bc
	ld [hl], EGG
	inc hl
	ld [hl], -1

	ld hl, wPartyMon1Species
	call GetPartyLocation
	ld d, h
	ld e, l
	ld hl, wOddEgg
	ld bc, PARTYMON_STRUCT_LENGTH
	call CopyBytes

	ld a, [wCurPartyMon]
	ld hl, wPartyMonOTs
	call SkipNames
	ld d, h
	ld e, l
	ld hl, .Odd
	ld bc, NAME_LENGTH
	call CopyBytes

	ld a, EGG
	ld [wNamedObjectIndex], a
	call GetPokemonName
	ld a, [wCurPartyMon]
	ld hl, wPartyMonNicknames
	call SkipNames
	ld d, h
	ld e, l
	ld hl, wStringBuffer1
	ld bc, MON_NAME_LENGTH
	jmp CopyBytes

.Odd:
	db "ODD@@@@@@@@@"


INCLUDE "data/events/odd_eggs.asm"
