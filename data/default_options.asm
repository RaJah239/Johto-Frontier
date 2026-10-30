DefaultOptions:
; wOptions: instant text speed
	db TEXT_DELAY_NONE
; wSaveFileExists: no
	db FALSE
; wTextboxFrame: frame 1
	db FRAME_1
; wTextboxFlags: use text speed, Knockout Flair on
	db (1 << FAST_TEXT_DELAY_F) | (1 << KNOCKOUT_FLAIR_F)
; wOptions2
	db 1 << MINIMAL_DIALOGUE
; wOptions3
	db $00
; wOptions4
	db $00
.End
	assert DefaultOptions.End - DefaultOptions == wOptionsEnd - wOptions
