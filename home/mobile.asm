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
