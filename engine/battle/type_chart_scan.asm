; Type chart scans, kept in the same bank as the type charts
; (data/types/type_matchups.asm) so each byte is a plain read instead of a
; far read. Damage calculations (and the AI, which simulates many of them)
; run these all the time. The callers in effect_commands.asm pick the chart
; and work out whether the Ghost immunities after -2 apply (GetTypeChart).

TypeMatchupScan::
; wTypeMatchup = the effectiveness (EFFECTIVE = 1x) of type d against types
; b and c in chart hl. e = nz if the Ghost immunities (after -2) don't apply.
	ld a, EFFECTIVE
	ld [wTypeMatchup], a
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
; BattleCommand_Stab's pass over chart hl for move type b against the
; target's types d and e: wCurDamage is multiplied by each matchup (an
; immunity sets wAttackMissed), and wTypeModifier gets the multiplier (STAB
; bit kept). c = nz if the Ghost immunities (after -2) don't apply.
; Also sets wTypeMatchup, as TypeMatchupScan would (one pass for both).
	ld a, EFFECTIVE
	ld [wTypeMatchup], a
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
	ld a, [hl]
	call MultiplyTypeMatchup
	push hl
	push bc
	ld a, [wTypeModifier]
	and STAB_DAMAGE
	ld b, a
	ld a, [hl]
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
	inc hl ; past the multiplier
	jr .loop
