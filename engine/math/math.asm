_Multiply::
; hMultiplier is one byte.
	ldh a, [hMultiplicand]
	ld e, a
	ldh a, [hMultiplicand + 1]
	ld h, a
	ldh a, [hMultiplicand + 2]
	ld l, a

	xor a
	ld d, a
	ldh [hProduct], a
	ldh [hProduct + 1], a
	ldh [hProduct + 2], a
	ldh [hProduct + 3], a
	ldh a, [hMultiplier]
	and a
	ret z
.loop
	rra
	jr nc, .next

	ld c, a ; store multiplier in c

	ldh a, [hProduct + 3]
	add l
	ldh [hProduct + 3], a
	ldh a, [hProduct + 2]
	adc h
	ldh [hProduct + 2], a
	ldh a, [hProduct + 1]
	adc e
	ldh [hProduct + 1], a
	ldh a, [hProduct]
	adc d
	ldh [hProduct], a

	ld a, c ; retrieve multiplier

.next
	add hl, hl
	rl e
	rl d
	and a
	jr nz, .loop
	ret

_Divide::
	ldh a, [hDivisor]
	and a
	ret z

	ld d, a
	ld c, LOW(hDividend)
	ld e, 0 ; remainder so far
.loop
	ldh a, [c]
	ld h, a
	; a zero byte with nothing left over divides to a zero byte
	or e
	jr z, .store
	push bc
	ld b, 8
.loop2
	; shift the next dividend bit into the remainder; h's freed low bit
	; takes the quotient bit
	sla h
	rl e
	jr c, .subtract ; (9-bit remainder: more than the divisor)
	ld a, e
	cp d
	jr c, .next
.subtract
	ld a, e
	sub d
	ld e, a
	inc h
.next
	dec b
	jr nz, .loop2
	pop bc
.store
	ld a, c
	add hMathBuffer - hDividend
	ld l, c
	ld c, a
	ld a, h
	ldh [c], a
	ld c, l
	inc c
	dec b
	jr nz, .loop

	xor a
	ldh [hQuotient], a
	ldh [hQuotient + 1], a
	ldh [hQuotient + 2], a
	ldh [hQuotient + 3], a
	ld a, e
	ldh [hRemainder], a
	ld a, c
	sub LOW(hDividend)
	ld b, a
	ld a, c
	add hMathBuffer - hDividend - 1
	ld c, a
	ldh a, [c]
	ldh [hQuotient + 3], a
	dec b
	ret z
	dec c
	ldh a, [c]
	ldh [hQuotient + 2], a
	dec b
	ret z
	dec c
	ldh a, [c]
	ldh [hQuotient + 1], a
	dec b
	ret z
	dec c
	ldh a, [c]
	ldh [hQuotient], a
	ret
