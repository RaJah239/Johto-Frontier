PrintMonTypes:
; Print one or both types of [wCurSpecies]
; on the stats screen at hl.

	push hl
	call GetBaseData
	pop hl

	push hl
	ld a, [wBaseType1]
	call .Print

	; Single-typed monsters really
	; have two of the same type.
	ld a, [wBaseType1]
	ld b, a
	ld a, [wBaseType2]
	cp b
	pop hl
	jr z, .hide_type_2

	ld bc, SCREEN_WIDTH
	add hl, bc

.Print:
	ld b, a
	jmp PrintType

.hide_type_2
	; Erase any type name that was here before.
	; Seems to be pointless in localized versions.
	ld a, " "
	ld bc, SCREEN_WIDTH - 3
	add hl, bc
	ld [hl], a
	inc bc
	add hl, bc
	ld bc, NAME_LENGTH_JAPANESE - 1
	jmp ByteFill

GetHiddenPowerType:
	ld hl, wPartyMon1DVs
	ld bc, PARTYMON_STRUCT_LENGTH
	ld a, [wCurPartyMon]
	call AddNTimes
	jr HiddenPowerType

GetHiddenPowerBattleType:
	ld hl, wBattleMonDVs
	ldh a, [hBattleTurn]
	and a
	jr z, HiddenPowerType
	ld hl, wEnemyMonDVs
	; fallthrough

HiddenPowerType:
    ; Def & 3
    ld a, [hl]
    and %0011
    ld b, a

    ; + (Atk & 3) << 2
    ld a, [hl]
    and %0011 << 4
    swap a
    add a
    add a
    or b

; Skip Normal
    inc a

; Skip Bird
    cp BIRD
    ret c
    inc a

; Skip unused types
    cp UNUSED_TYPES
    ret c
    add UNUSED_TYPES_END - UNUSED_TYPES
    ret

PrintBattleMoveType:
; Print the type of move b at hl.
    push hl
    ld a, b
    cp HIDDEN_POWER
    jr z, .print_hidden_power
    dec a
    ld bc, MOVE_LENGTH
    ld hl, Moves
    call AddNTimes
    ld de, wStringBuffer1
    ld a, BANK(Moves)
    call FarCopyBytes
    ld a, [wStringBuffer1 + MOVE_TYPE]
    pop hl

    ld b, a
    jr PrintType

.print_hidden_power
    call GetHiddenPowerBattleType
    pop hl
    ld b, a
    jr PrintType

PrintMoveType:
; Print the type of move b at hl.

	push hl
	ld a, b
	cp HIDDEN_POWER
	jr z, .print_hidden_power
	cp HIDDEN_FORCE
	jr z, .print_hidden_power
	dec a
	ld bc, MOVE_LENGTH
	ld hl, Moves
	call AddNTimes
	ld de, wStringBuffer1
	ld a, BANK(Moves)
	call FarCopyBytes
	ld a, [wStringBuffer1 + MOVE_TYPE]
	and TYPE_MASK
	pop hl

	ld b, a
	jr PrintType

.print_hidden_power
	call GetHiddenPowerType
	pop hl
	ld b, a
	; fallthrough

PrintType:
; Print type b at hl.

	ld a, b

	push hl
	add a
	ld hl, TypeNames
	ld e, a
	ld d, 0
	add hl, de
	ld a, [hli]
	ld e, a
	ld d, [hl]
	pop hl

	jmp PlaceString

GetTypeName:
; Copy the name of type [wNamedObjectIndex] to wStringBuffer1.

	ld a, [wNamedObjectIndex]
	ld hl, TypeNames
	ld e, a
	ld d, 0
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, wStringBuffer1
	ld bc, MOVE_NAME_LENGTH
	jmp CopyBytes

INCLUDE "data/types/names.asm"
