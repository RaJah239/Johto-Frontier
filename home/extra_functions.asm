; Used in most mandatory long texts, returns the result of the 'bit' operation,
; which determines if the dialogue option is set to Normal (z=0) or Minimum (z=1)
CheckDialogueMode::
	ld a, [wOptions2]
	bit MINIMAL_DIALOGUE, a
	ret

CheckIfFastBattlesIsOn::
	ld a, [wOptions3]
	bit FAST_BATTLES, a
	ret

CheckQuickNurseHeal::
	ld a, [wOptions2]
	bit NURSE_HEAL, a
	ret

CheckFieldActions::
	ld a, [wOptions3]
	bit FIELD_ACTIONS, a
	ret

; This converts values out of 256 into a value
; out of 100. It achieves this by multiplying
; the value by 100 and dividing it by 256.
ConvertPercentages::

	; Overwrite the "hl" register.
	ld l, a
	ld h, 0
	push af

	; Multiplies the value of the "hl" register by 3.
	add hl, hl
	add a, l
	ld l, a
	adc h
	sub l
	ld h, a

	; Multiplies the value of the "hl" register
	; by 8. The value of the "hl" register
	; is now 24 times its original value.
	add hl, hl
	add hl, hl
	add hl, hl

	; Add the original value of the "hl" value to itself,
	; making it 25 times its original value.
	pop af
	add a, l
	ld l, a
	adc h
	sbc l
	ld h, a

	; Multiply the value of the "hl" register by
	; 4, making it 100 times its original value.
	add hl, hl
	add hl, hl

	; Set the "l" register to 0.5, otherwise the rounded
	; value may be lower than expected. Round the
	; high byte to nearest and drop the low byte.
	ld l, 0.5
	sla l
	sbc a
	and 1
	add a, h
	ret
