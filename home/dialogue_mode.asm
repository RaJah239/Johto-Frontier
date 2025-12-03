CheckDialogueMode::
	ld a, [wOptions2]
	bit MINIMAL_DIALOGUE, a
	ret

SkipIntroMode::
	ld a, [wOptions2]
	bit FAST_BOOT, a
	ret

YesSkipIntroMode::
 	ld hl, wOptions2
	set FAST_BOOT, [hl]
	ret

DontSkipIntroMode::
 	ld hl, wOptions2
	res FAST_BOOT, [hl]
	ret

; Used in most mandatory long texts, returns the result of the 'bit' operation,
; which determines if the dialogue option is set to Normal (z=0) or Minimum (z=1)
