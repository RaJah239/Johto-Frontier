DefaultOptions:
; wOptions: instant text speed
	db TEXT_DELAY_NONE
; wSaveFileExists: no
	db FALSE
; wTextboxFrame: frame 1
	db FRAME_1
; wTextboxFlags: use text speed
	db 1 << FAST_TEXT_DELAY_F
; wOptions2
	db 0 << RUNNING_SHOES
	db 1 << MINIMAL_DIALOGUE

	db $00
	db $00
.End
	assert DefaultOptions.End - DefaultOptions == wOptionsEnd - wOptions
