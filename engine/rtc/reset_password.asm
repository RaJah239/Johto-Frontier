_ResetClock:
	ld a, BANK(sRTCStatusFlags)
	call OpenSRAM
	ld a, $80
	ld [sRTCStatusFlags], a
	call CloseSRAM
	ret
