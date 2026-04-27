MobileReceive::
	ldh a, [hROMBank]
	push af
	ld a, BANK(_MobileReceive)
	ld [wc981], a
	rst Bankswitch

	call _MobileReceive
	pop bc
	ld a, b
	ld [wc981], a
	rst Bankswitch

	ret

MobileTimer::
	push af
	push bc
	push de
	push hl

	ldh a, [hMobile]
	and a
	jr z, .pop_ret

	xor a
	ldh [rTAC], a

; Turn off timer interrupt
	ldh a, [rIF]
	and 1 << VBLANK | 1 << LCD_STAT | 1 << SERIAL | 1 << JOYPAD
	ldh [rIF], a

	ld a, [wc86a]
	or a
	jr z, .pop_ret

	ld a, [wc822]
	bit 1, a
	jr nz, .skip_timer

	ldh a, [rSC]
	and 1 << rSC_ON
	jr nz, .skip_timer

	ldh a, [hROMBank]
	push af
	ld a, BANK(_Timer)
	ld [wc981], a
	rst Bankswitch

	call _Timer

	pop bc
	ld a, b
	ld [wc981], a
	rst Bankswitch

.skip_timer
	ldh a, [rTMA]
	ldh [rTIMA], a

	ld a, 1 << rTAC_ON | rTAC_65536_HZ
	ldh [rTAC], a

.pop_ret
	pop hl
	pop de
	pop bc
	pop af
	reti
