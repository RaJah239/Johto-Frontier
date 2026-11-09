DelayFrame::
; Wait for one frame
; (no VBlank comes while the LCD is off: don't wait forever)
	ldh a, [rLCDC]
	bit rLCDC_ENABLE, a
	ret z
	ld a, 1
	ld [wVBlankOccurred], a

; Wait for the next VBlank, halting to conserve battery
.halt
	halt
	nop ; no-optimize nops
	ld a, [wVBlankOccurred]
	and a
	jr nz, .halt
	ret

SFXDelay3::
Delay3::
	ld c, 3
SFXDelayFrames::
DelayFrames::
; Wait c frames
	call DelayFrame
	dec c
	jr nz, DelayFrames
	ret
