ClearSprites::
; Erase OAM data
	ld hl, wShadowOAM
	assert (wShadowOAMEnd - wShadowOAM) % 8 == 0
	ld b, (wShadowOAMEnd - wShadowOAM) / 8
	xor a
.loop
rept 8
	ld [hli], a
endr
	dec b
	jr nz, .loop
	ret

HideSprites::
; Set all OAM y-positions to 160 to hide them offscreen
	ld hl, wShadowOAMSprite00YCoord
	ld de, SPRITEOAMSTRUCT_LENGTH
	assert NUM_SPRITE_OAM_STRUCTS % 4 == 0
	ld b, NUM_SPRITE_OAM_STRUCTS / 4
	ld a, SCREEN_WIDTH_PX
.loop
rept 4
	ld [hl], a ; y
	add hl, de
endr
	dec b
	jr nz, .loop
	ret
