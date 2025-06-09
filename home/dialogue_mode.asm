CheckDialogueMode::
	ld a, [wOptions2]
	bit MINIMAL_DIALOGUE, a
	ret

; Used in most mandatory long texts, returns the result of the 'bit' operation,
; which determines if the dialogue option is set to Normal (z=0) or Minimum (z=1)
