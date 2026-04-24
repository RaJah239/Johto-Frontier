Function115d99:
	ld de, MobileDialingGFX
	ld hl, vTiles0 tile $60
	lb bc, BANK(MobileDialingGFX), 20
	call Get2bpp
	xor a
	ld [wc305], a
	ld [wc306], a
	ld [wc309], a
	ld [wc30a], a
	ld [wc30b], a
	ld [wc30c], a
	ld a, $10
	ld [wc307], a
	ld a, $18
	ld [wc308], a
	ret

Function115dc3:
	xor a
	ld [wc305], a
	ld a, $a0
	ld hl, wShadowOAMSprite31
	ld bc, 8 * SPRITEOAMSTRUCT_LENGTH
	call ByteFill
	ret

Function115e18:
	ld a, c
	ld [wc30a], a
	xor a
	ld [wc30b], a
	jr Function115e2b

Function115e2b:
	ld a, [wc30a]
	add a
	ld c, a
	ld b, 0
	ld hl, Unknown_115e59
	add hl, bc
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	push de
	pop hl
	ld a, [wc30b]
	add a
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hli]
	cp $ff
	jr nz, .not_end
	xor a
	ld [wc30b], a
	jr Function115e2b

.not_end
	ld [wc309], a
	ld a, [hl]
	ld [wc30c], a
	ret

Unknown_115e59:
	dw Unknown_115e61
	dw Unknown_115e6c
	dw Unknown_115e76
	dw Unknown_115e79

Unknown_115e61:
	db $04, $08
	db $05, $08
	db $06, $08
	db $07, $08
	db $08, $08
	db -1

Unknown_115e6c:
	db $01, $08
	db $02, $08
	db $03, $08
	db $09, $08
	db $0a, $08
Unknown_115e76:
	db $00, $08
	db -1

Unknown_115e79:
	db $0b, $08
	db $0c, $08
	db $0d, $08
	db $0e, $08
	db $0f, $08
	db $00, $08
	db -1

MobileDialingGFX::
INCBIN "gfx/mobile/dialing.2bpp"

Function11615a:
	xor a
	ld [wc30d], a
	ld [wc319], a
	ld [wc310], a
	ld [wc311], a
	ld [wc312], a
	ld [wc313], a
	ld [wc314], a
	ld [wc314 + 1], a
	ld [wc314 + 4], a
	ld [wc3f6], a
	ld [wc3f8], a
	ld [wc3f2], a
	ld [wc3f4], a
	ld a, $24
	ld [wc3f5], a
	ld a, $7
	ld [wc3f7], a
	ld a, $b0
	ld [wc30e], a
	ld [wc3f1], a
	ld a, $48
	ld [wc30f], a
	ld [wc3f3], a
	ret
