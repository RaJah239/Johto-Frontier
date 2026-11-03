DrawKrisPackGFX:
	ld hl, PackFGFXPointers
	add hl, de
	add hl, de
	ld a, [hli]
	ld e, a
	ld d, [hl]
	ld b, BANK(PackFGFX)
	farjp LoadPackFrameGFX

PackFGFXPointers:
	dw PackFGFX + (PACK_FRAME_WIDTH * PACK_FRAME_HEIGHT tiles) * 1 ; ITEM_POCKET
	dw PackFGFX + (PACK_FRAME_WIDTH * PACK_FRAME_HEIGHT tiles) * 4 ; BALL_POCKET
	dw PackFGFX + (PACK_FRAME_WIDTH * PACK_FRAME_HEIGHT tiles) * 0 ; KEY_ITEM_POCKET
	dw PackFGFX + (PACK_FRAME_WIDTH * PACK_FRAME_HEIGHT tiles) * 3 ; TM_HM_POCKET
	dw PackFGFX + (PACK_FRAME_WIDTH * PACK_FRAME_HEIGHT tiles) * 5 ; FRUIT_POCKET
	dw PackFGFX + (PACK_FRAME_WIDTH * PACK_FRAME_HEIGHT tiles) * 2 ; BATTLE_POCKET

