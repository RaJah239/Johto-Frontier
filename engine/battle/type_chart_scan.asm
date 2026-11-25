; Type chart scans, kept in the same bank as the type charts
; (data/types/type_matchups.asm) so each byte is a plain read instead of a
; far read. Damage calculations (and the AI, which simulates many of them)
; run these all the time. The callers in effect_commands.asm pick the chart
; and work out whether the Ghost immunities after -2 apply (GetTypeChart).

TypeMatchupScan::
; wTypeMatchup = the effectiveness (EFFECTIVE = 1x) of type d against types
; b and c in the chart described at hl (see TypeChart_Normal). e = nz if the
; Ghost immunities (the Foresight list) don't apply.
	ld a, EFFECTIVE
	ld [wTypeMatchup], a
	ld a, d
	or b
	or c
	cp 32
	jr nc, .fallback ; not a type the matrices cover: read the whole list
	push hl
	ld a, [hl]
	and a
	jr z, .regular_done ; no matrix: a chart without entries
	call GetTypeMatrixRow
	ld a, l
	or b
	ld l, a
	ld a, [hl]
	cp EFFECTIVE
	jr z, .second
	call MultiplyTypeMatchup
	and a
	jr z, .immune
.second
	ld a, b
	cp c
	jr z, .regular_done ; one type: count it once
	ld a, l
	and %11100000
	or c
	ld l, a
	ld a, [hl]
	cp EFFECTIVE
	jr z, .regular_done
	call MultiplyTypeMatchup
	and a
	jr z, .immune
.regular_done
	pop hl
	ld a, e
	and a
	ret nz ; Foresight, Scrappy...: the Ghost immunities don't apply
	inc hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jr .loop

.immune
	pop hl
	ret

.fallback
	inc hl
	inc hl
	inc hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
.loop
	ld a, [hli]
	cp d
	jr z, .attacker
	inc a
	ret z ; -1: end
	inc a
	jr z, .foresight ; -2
	inc hl
	inc hl
	jr .loop

.foresight
	ld a, e
	and a
	ret nz
	jr .loop

.attacker
	ld a, [hli]
	cp b
	jr z, .match
	cp c
	jr z, .match
	inc hl
	jr .loop

.match
	ld a, [hli]
	call MultiplyTypeMatchup
	and a
	ret z ; immune: nothing more to do
	jr .loop

GetTypeMatrixRow:
; hl = the row for attacker d of the matrix whose high byte is in a.
	ld h, a
	ld a, d
GetTypeMatrixRow_A:
; hl = row a (0-31) of the page-aligned matrix whose high byte is in h.
; Rows are 32 bytes: low byte (a & 7) * 32, high byte h + a / 8.
	rrca
	rrca
	rrca
	ld l, a
	and %00000011
	add h
	ld h, a
	ld a, l
	and %11100000
	ld l, a
	ret

MultiplyTypeMatchup:
; wTypeMatchup = wTypeMatchup * a / 10, also in a. Preserves bc, de, hl.
	ldh [hMultiplicand + 2], a
	xor a
	ldh [hDividend + 0], a
	ldh [hMultiplicand + 0], a
	ldh [hMultiplicand + 1], a
	ld a, [wTypeMatchup]
	ldh [hMultiplier], a
	call Multiply
	call DivideProductBy10
	ldh a, [hQuotient + 3]
	ld [wTypeMatchup], a
	ret

DivideProductBy10:
; hQuotient = hProduct / 10, hRemainder = the remainder, as Divide would
; (hProduct must be below $1000000). A shift-and-subtract loop instead of
; the generic Divide: several times faster. Preserves bc, de, hl.
	push hl
	push bc
	ldh a, [hProduct + 1]
	ld c, a
	ldh a, [hProduct + 2]
	ld h, a
	ldh a, [hProduct + 3]
	ld l, a
	xor a ; remainder
	ld b, 24
.loop
	add hl, hl
	rl c
	rla
	cp 10
	jr c, .next
	sub 10
	inc l ; (the bit the shift freed)
.next
	dec b
	jr nz, .loop
	ldh [hRemainder], a
	xor a
	ldh [hQuotient + 0], a
	ld a, c
	ldh [hQuotient + 1], a
	ld a, h
	ldh [hQuotient + 2], a
	ld a, l
	ldh [hQuotient + 3], a
	pop bc
	pop hl
	ret

StabTypeScan::
; BattleCommand_Stab's pass over the chart described at hl for move type b
; against the target's types d and e: wCurDamage is multiplied by each
; matchup (an immunity sets wAttackMissed), and wTypeModifier gets the
; multiplier (STAB bit kept). c = nz if the Ghost immunities (the Foresight
; list) don't apply. Also sets wTypeMatchup, as TypeMatchupScan would.
; Matchups are applied in the list's order, as a scan of the list would.
	ld a, EFFECTIVE
	ld [wTypeMatchup], a
	ld a, b
	or d
	or e
	cp 32
	jr nc, .fallback
	push hl
	push bc
	push de
	ld a, [hl]
	and a
	jr z, .regular_done
	ld h, a
	ld a, b
	call GetTypeMatrixRow_A
	; first type: b = multiplier, c = position in the list
	ld a, l
	or d
	ld l, a
	ld b, [hl]
	ld a, h
	add 4 ; the position matrix
	ld h, a
	ld c, [hl]
	ld a, d
	cp e
	jr z, .one_type
	ld a, l
	and %11100000
	or e
	ld l, a
	ld e, [hl] ; second type's position
	ld a, h
	sub 4
	ld h, a
	ld d, [hl] ; second type's multiplier
	ld a, e
	cp c
	jr c, .second_first
	; first type first ($ff = no entry, and $ff sorts last)
	ld a, c
	inc a
	jr z, .regular_done
	ld a, b
	call StabApplyMultiplier
	ld a, e
	inc a
	jr z, .regular_done
	ld a, d
	call StabApplyMultiplier
	jr .regular_done

.second_first
	ld a, d
	call StabApplyMultiplier
	ld a, c
	inc a
	jr z, .regular_done
	ld a, b
	call StabApplyMultiplier
	jr .regular_done

.one_type
	ld a, c
	inc a
	jr z, .regular_done
	ld a, b
	call StabApplyMultiplier
.regular_done
	pop de
	pop bc
	pop hl
	ld a, c
	and a
	ret nz ; the Ghost immunities don't apply
	inc hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jr .loop

.fallback
	inc hl
	inc hl
	inc hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
.loop
	ld a, [hli]
	cp b
	jr z, .attacker
	inc a
	ret z ; -1: end
	inc a
	jr z, .foresight ; -2
	inc hl
	inc hl
	jr .loop

.foresight
	ld a, c
	and a
	ret nz
	jr .loop

.attacker
	ld a, [hli]
	cp d
	jr z, .match
	cp e
	jr z, .match
	inc hl
	jr .loop

.match
	ld a, [hli]
	call StabApplyMultiplier
	jr .loop

StabApplyMultiplier:
; Apply one matchup multiplier a to wTypeMatchup, wTypeModifier,
; wAttackMissed and wCurDamage (see StabTypeScan). Preserves bc, de, hl.
	push hl
	push bc
	ld c, a
	call MultiplyTypeMatchup
	ld a, [wTypeModifier]
	and STAB_DAMAGE
	ld b, a
	ld a, c
	and a
	jr nz, .not_immune
	; immune: treat it as a miss, no damage
	inc a
	ld [wAttackMissed], a
	xor a
.not_immune
	ldh [hMultiplier], a
	add b
	ld [wTypeModifier], a

	xor a
	ldh [hMultiplicand + 0], a
	ld hl, wCurDamage
	ld a, [hli]
	ldh [hMultiplicand + 1], a
	ld a, [hld]
	ldh [hMultiplicand + 2], a
	call Multiply

	ldh a, [hProduct + 1]
	ld b, a
	ldh a, [hProduct + 2]
	or b
	ld b, a
	ldh a, [hProduct + 3]
	or b
	jr z, .store ; no damage

	; / 10 (at least 1)
	call DivideProductBy10
	ldh a, [hQuotient + 2]
	ld b, a
	ldh a, [hQuotient + 3]
	or b
	jr nz, .store
	ld a, 1
	ldh [hMultiplicand + 2], a

.store
	ldh a, [hMultiplicand + 1]
	ld [hli], a
	ldh a, [hMultiplicand + 2]
	ld [hl], a
	pop bc
	pop hl
	ret
