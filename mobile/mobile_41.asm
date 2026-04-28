_MobilePrintNum::
; Supports signed 31-bit integers (up to 10 digits)
; b: Bits 0-4 = # bytes
;    Bit 7 = set if negative
; c: Number of digits
; de: highest byte of number to convert
; hl: where to print the converted string
	push bc
	xor a
	ldh [hPrintNumBuffer + 0], a
	ldh [hPrintNumBuffer + 1], a
	ldh [hPrintNumBuffer + 2], a
	ld a, b
	and $f
	cp $1
	jr z, .one_byte
	cp $2
	jr z, .two_bytes
	cp $3
	jr z, .three_bytes
; four bytes
	ld a, [de]
	ldh [hPrintNumBuffer + 0], a
	inc de

.three_bytes
	ld a, [de]
	ldh [hPrintNumBuffer + 1], a
	inc de

.two_bytes
	ld a, [de]
	ldh [hPrintNumBuffer + 2], a
	inc de

.one_byte
	ld a, [de]
	ldh [hPrintNumBuffer + 3], a
	inc de

	push de
	xor a
	ldh [hPrintNumBuffer + 8], a
	ld a, b
	ldh [hPrintNumBuffer + 9], a
	ld a, c
	cp 2
	jr z, .two_digits
	ld de, ._2
	cp 3
	jr z, .three_to_nine_digits
	ld de, ._3
	cp 4
	jr z, .three_to_nine_digits
	ld de, ._4
	cp 5
	jr z, .three_to_nine_digits
	ld de, ._5
	cp 6
	jr z, .three_to_nine_digits
	ld de, ._6
	cp 7
	jr z, .three_to_nine_digits
	ld de, ._7
	cp 8
	jr z, .three_to_nine_digits
	ld de, ._8
	cp 9
	jr z, .three_to_nine_digits
	ld de, ._9

.three_to_nine_digits
	inc de
	inc de
	inc de
	dec a
	dec a

.digit_loop
	push af
	call .Function1062b2
	call .Function1062ff
rept 4
	inc de
endr
	pop af
	dec a
	jr nz, .digit_loop

.two_digits
	ld c, 0
	ldh a, [hPrintNumBuffer + 3]
.mod_ten_loop
	cp 10
	jr c, .simple_divide_done
	sub 10
	inc c
	jr .mod_ten_loop

.simple_divide_done
	ld b, a
	ldh a, [hPrintNumBuffer + 8]
	or c
	ldh [hPrintNumBuffer + 8], a
	jr nz, .create_digit
	call .LoadMinusTenIfNegative
	jr .done

.create_digit
	ld a, "0"
	add c
	ld [hl], a

.done
	call .Function1062ff
	ld a, "0"
	add b
	ld [hli], a
	pop de
	pop bc
	ret

._9
	dd 1000000000
._8
	dd 100000000
._7
	dd 10000000
._6
	dd 1000000
._5
	dd 100000
._4
	dd 10000
._3
	dd 1000
._2
	dd 100

.Function1062b2:
	ld c, $0
.asm_1062b4
	ld a, [de]
	dec de
	ld b, a
	ldh a, [hPrintNumBuffer + 3]
	sub b
	ldh [hPrintNumBuffer + 7], a
	ld a, [de]
	dec de
	ld b, a
	ldh a, [hPrintNumBuffer + 2]
	sbc b
	ldh [hPrintNumBuffer + 6], a
	ld a, [de]
	dec de
	ld b, a
	ldh a, [hPrintNumBuffer + 1]
	sbc b
	ldh [hPrintNumBuffer + 5], a
	ld a, [de]
	inc de
	inc de
	inc de
	ld b, a
	ldh a, [hPrintNumBuffer + 0]
	sbc b
	ldh [hPrintNumBuffer + 4], a
	jr c, .asm_1062eb
	ldh a, [hPrintNumBuffer + 4]
	ldh [hPrintNumBuffer + 0], a
	ldh a, [hPrintNumBuffer + 5]
	ldh [hPrintNumBuffer + 1], a
	ldh a, [hPrintNumBuffer + 6]
	ldh [hPrintNumBuffer + 2], a
	ldh a, [hPrintNumBuffer + 7]
	ldh [hPrintNumBuffer + 3], a
	inc c
	jr .asm_1062b4

.asm_1062eb
	ldh a, [hPrintNumBuffer + 8]
	or c
	jr z, .LoadMinusTenIfNegative
	ld a, -10
	add c
	ld [hl], a
	ldh [hPrintNumBuffer + 8], a
	ret

.LoadMinusTenIfNegative:
	ldh a, [hPrintNumBuffer + 9]
	bit 7, a
	ret z

	ld [hl], -10
	ret

.Function1062ff:
	ldh a, [hPrintNumBuffer + 9]
	bit 7, a
	jr nz, .asm_10630d
	bit 6, a
	jr z, .asm_10630d
	ldh a, [hPrintNumBuffer + 8]
	and a
	ret z

.asm_10630d
	inc hl
	ret
