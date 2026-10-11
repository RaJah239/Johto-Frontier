LoadOverworldFont::
	; Always write to VRAM bank 0; sprite loading may have left rVBK = 1,
	; which would misplace the font (and banner tiles) into bank 1.
	ldh a, [rVBK]
	push af
	xor a
	ldh [rVBK], a
	ld de, OverworldFontGFX
	ld hl, vTiles1
	lb bc, BANK(OverworldFontGFX), $80
	call Get2bpp
	ld de, OverworldFontSpaceGFX
	ld hl, vTiles2 tile " "
	lb bc, BANK(OverworldFontSpaceGFX), 1
	call Get2bpp
	pop af
	ldh [rVBK], a
	ret

LoadMapNameSignTiles::
; Reload just the map name sign tiles (vTiles1 $8c00, tiles $c0-$cf).
; They live inside the overworld font block, which sprite facing data
; can overwrite; only these 16 tiles need restoring, not the whole font.
	ldh a, [rVBK]
	push af
	xor a
	ldh [rVBK], a
	ld de, OverworldFontGFX + (MAP_NAME_SIGN_START - $80) * LEN_2BPP_TILE
	ld hl, vTiles0 tile MAP_NAME_SIGN_START
	lb bc, BANK(OverworldFontGFX), 16
	call Get2bpp
	pop af
	ldh [rVBK], a
	ret

; The font data sits in its own section so it can be 16-byte aligned
; (ALIGN[4]) without constraining the bank41 code section: LCD-on copies
; of it can then use GDMA instead of stalling one frame per 8 tiles in
; Request2bpp (CheckGDMA rejects misaligned sources).
SECTION "Overworld Font GFX", ROMX, ALIGN[4]

OverworldFontGFX:
INCBIN "gfx/font/overworld.2bpp"

OverworldFontSpaceGFX:
INCBIN "gfx/font/overworld_space.2bpp"
