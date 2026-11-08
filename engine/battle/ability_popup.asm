; Ability popup: Polished Crystal's ability slide-in (engine/battle/ability_gfx.asm
; in Polished Crystal), drawn over the user's picture. A black band slides in
; over the picture, then "NICKNAME's" (top line) and the ability name (bottom
; line) are typed into it in white, in the variable-width font.
;
; Unlike Polished Crystal, the popup is synchronous: it slides in, stays for
; ABILITY_POPUP_HOLD_FRAMES and is removed before ShowAbilityPopup returns.
; It borrows VRAM bank 1 tiles ABILITY_SLIDE_TILE.. (also used by large
; animated frontpics) and puts their old contents back afterwards.
; It works on the screen's BG map directly (only its own 2 x 10 area) and
; never touches wTilemap / wAttrmap: in battle wAttrmap can be stale (e.g.
; the move info box's Textbox leaves the text palette in it), so copying
; it to the screen would recolour the picture and the HUD.

ShowAbilityPopup::
; Call it with a plain farcall:
;   b = bank of the ability name
;   c = side: ABILITY_POPUP_PLAYER or ABILITY_POPUP_ENEMY
;   de = ability name, terminated with "@" (or $00)
; No-op outside of battle (wBattleMode = 0) or with ability banners off.
	ld a, [wBattleMode]
	and a
	ret z

	ld a, [wOptions4]
	bit ABILITY_BANNERS, a
	ret nz

	ld a, c
	ld [wAbilityPopupSide], a
	call AbilityPopup_CopyAbilityName
	call AbilityPopup_BuildPkmnName

	ldh a, [hBGMapMode]
	push af
	xor a
	ldh [hBGMapMode], a ; the tilemap and attrmap change together below
	ldh a, [rSVBK]
	push af
	ld a, BANK(wAbilityTiles)
	ldh [rSVBK], a

	call AbilityPopup_SaveRegion
	ld hl, vTiles4 tile (ABILITY_SLIDE_TILE - $80)
	ld de, wAbilityTilesBackup
	ld b, ABILITY_SLIDE_TILES
	ld a, 1
	ldh [rVBK], a
.backup_loop
	ld c, LEN_2BPP_TILE
	call AbilityPopup_ReadVRAM
	dec b
	jr nz, .backup_loop
	xor a
	ldh [rVBK], a

	call AbilityPopup_CopyPicTiles
	call AbilityPopup_UploadTiles

	; point the area at the popup tiles (VRAM bank 1, above sprites),
	; keeping each tile's palette for now so the picture looks the same
	ld hl, wAbilityPopupSavedAttrs
	ld de, wAbilityPopupNewTiles
	ld b, ABILITY_SLIDE_TILE
	ld c, ABILITY_SLIDE_TILES
.new_tiles
	ld a, b
	ld [de], a ; tile
	push de
	push hl
	ld a, [hl]
	or VRAM_BANK_1 | PRIORITY
	ld hl, ABILITY_SLIDE_TILES
	add hl, de
	ld [hl], a ; attribute
	pop hl
	pop de
	inc hl
	inc de
	inc b
	dec c
	jr nz, .new_tiles
	ld de, wAbilityPopupNewTiles
	call AbilityPopup_WriteRegion

	ld de, SFX_ABILITY_SLIDEOUT
	call WaitPlaySFX

	call AbilityPopup_Slide

	; the band is drawn: switch to the text palette (white on black)
	ld hl, wAbilityPopupSavedAttrs
	ld de, wAbilityPopupNewAttrs
	ld c, ABILITY_SLIDE_TILES
.text_pal
	ld a, [hli]
	and ~(PALETTE_MASK | X_FLIP | Y_FLIP)
	or PAL_BATTLE_BG_TEXT | VRAM_BANK_1 | PRIORITY
	ld [de], a
	inc de
	dec c
	jr nz, .text_pal
	ld de, wAbilityPopupNewTiles
	call AbilityPopup_WriteRegion

	call AbilityPopup_DrawText

	ld c, ABILITY_POPUP_HOLD_FRAMES
	call DelayFrames

	; take it away: the area first, so nothing shows the borrowed tiles
	ld de, wAbilityPopupSavedTiles
	call AbilityPopup_WriteRegion
	ld a, 1
	ldh [rVBK], a
	ld de, wAbilityTilesBackup
	ld hl, vTiles4 tile (ABILITY_SLIDE_TILE - $80)
	ld c, ABILITY_SLIDE_TILES
	ldh a, [hROMBank]
	ld b, a
	call Get2bpp ; aligned WRAM -> VRAM: GDMA, no frame wait
	xor a
	ldh [rVBK], a

	pop af
	ldh [rSVBK], a
	pop af
	ldh [hBGMapMode], a
	ret

AbilityPopup_CopyAbilityName:
; Copy the ability name at b:de into wAbilityName, cut short if it would
; be wider than ABILITY_SLIDE_TEXT_MAX pixels.
	ld hl, wAbilityName
	ld c, ABILITY_POPUP_NAME_LENGTH - 1
.loop
	push hl
	push bc
	ld h, d
	ld l, e
	ld a, b
	call GetFarByte
	pop bc
	pop hl
	and a
	jr z, .done
	cp "@"
	jr z, .done
	ld [hli], a
	ld [hl], "@"
	push de
	push hl
	ld de, wAbilityName
	call AbilityPopup_CheckWidth
	pop hl
	pop de
	jr c, .too_wide
	inc de
	dec c
	jr nz, .loop
.done
	ld [hl], "@"
	ret

.too_wide
	dec hl
	ld [hl], "@"
	ret

AbilityPopup_BuildPkmnName:
; wAbilityPkmn = the user's nickname + "'s", cut short like the ability name.
	ld a, [wAbilityPopupSide]
	and a
	ld de, wBattleMonNickname
	jr z, .got_name
	ld de, wEnemyMonNickname
.got_name
	ld hl, wAbilityPkmn
	ld c, MON_NAME_LENGTH - 1
.loop
	ld a, [de]
	cp "@"
	jr z, .add_s
	ld [hli], a
	inc de
	dec c
	jr nz, .loop
.add_s
	ld [hl], "'s"
	inc hl
	ld [hl], "@"
.check
	push hl
	ld de, wAbilityPkmn
	call AbilityPopup_CheckWidth
	pop hl
	ret nc
	; too wide: drop the last character
	dec hl
	ld [hl], "@"
	jr .check

AbilityPopup_CheckWidth:
; Carry if the string at de is wider than ABILITY_SLIDE_TEXT_MAX pixels.
	call GetVWFLength
	cp ABILITY_SLIDE_TEXT_MAX + 1
	ccf
	ret

assert wAbilityPopupSavedAttrs == wAbilityPopupSavedTiles + ABILITY_SLIDE_TILES
assert wAbilityPopupNewAttrs == wAbilityPopupNewTiles + ABILITY_SLIDE_TILES

AbilityPopup_RegionVRAM:
; hl = the popup's top-left entry in the screen's BG map. Clobbers de.
	ld a, [wAbilityPopupSide]
	and a
	ld de, ABILITY_SLIDE_PLAYER_Y * BG_MAP_WIDTH + ABILITY_SLIDE_PLAYER_X
	jr z, .got_offset
	ld de, ABILITY_SLIDE_ENEMY_Y * BG_MAP_WIDTH + ABILITY_SLIDE_ENEMY_X
.got_offset
	ldh a, [hBGMapAddress]
	ld l, a
	ldh a, [hBGMapAddress + 1]
	ld h, a
	add hl, de
	ret

AbilityPopup_SaveRegion:
; Read the tiles (wAbilityPopupSavedTiles) and attributes
; (wAbilityPopupSavedAttrs) the popup covers from the screen.
	ld de, wAbilityPopupSavedTiles
	xor a
	call .rows
	ld a, 1
.rows
	ldh [rVBK], a
	push de
	call AbilityPopup_RegionVRAM
	pop de
	ld b, ABILITY_SLIDE_HEIGHT
.row
	push hl
	ld c, ABILITY_SLIDE_WIDTH
	call AbilityPopup_ReadVRAM
	pop hl
	push de
	ld de, BG_MAP_WIDTH
	add hl, de
	pop de
	dec b
	jr nz, .row
	xor a
	ldh [rVBK], a
	ret

AbilityPopup_WriteRegion:
; Write the popup area's tiles from de and its attributes from
; de + ABILITY_SLIDE_TILES to the screen, just below the area so no
; frame shows half of it.
	push de
	call AbilityPopup_WaitBelowRegion
	pop de
	push de
	ld hl, ABILITY_SLIDE_TILES
	add hl, de
	ld d, h
	ld e, l
	ld a, 1 ; attributes first
	call .rows
	pop de
	xor a
.rows
	ldh [rVBK], a
	push de
	call AbilityPopup_RegionVRAM
	pop de
	ld b, ABILITY_SLIDE_HEIGHT
.row
	push hl
	ld c, ABILITY_SLIDE_WIDTH
	call AbilityPopup_WriteVRAM
	pop hl
	push de
	ld de, BG_MAP_WIDTH
	add hl, de
	pop de
	dec b
	jr nz, .row
	xor a
	ldh [rVBK], a
	ret

AbilityPopup_WaitBelowRegion:
; Wait for the scanline right below the popup area.
	ldh a, [rLCDC]
	bit rLCDC_ENABLE, a
	ret z
	ld a, [wAbilityPopupSide]
	and a
	ld b, (ABILITY_SLIDE_PLAYER_Y + ABILITY_SLIDE_HEIGHT) * TILE_WIDTH
	jr z, .wait
	ld b, (ABILITY_SLIDE_ENEMY_Y + ABILITY_SLIDE_HEIGHT) * TILE_WIDTH
.wait
	ldh a, [rLY]
	cp b
	jr nz, .wait
	ret

AbilityPopup_WaitHBlank:
; di, then wait for the start of H-Blank (or V-Blank) so VRAM can be
; accessed for a few bytes. The caller does ei. No wait with the LCD off.
	di
	ldh a, [rLCDC]
	bit rLCDC_ENABLE, a
	ret z
.wait_busy
	ldh a, [rSTAT]
	and %10 ; mode 2 or 3
	jr z, .wait_busy
.wait_free
	ldh a, [rSTAT]
	and %10
	jr nz, .wait_free
	ret

AbilityPopup_ReadVRAM:
; Copy c bytes (an even number) from VRAM at hl to de, two per H-Blank.
; Advances hl and de. Preserves b.
.chunk
	call AbilityPopup_WaitHBlank
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	inc de
	ei
	dec c
	dec c
	jr nz, .chunk
	ret

AbilityPopup_WriteVRAM:
; Copy c bytes (an even number) from de to VRAM at hl, two per H-Blank.
; Advances hl and de. Preserves b.
.chunk
	call AbilityPopup_WaitHBlank
	ld a, [de]
	ld [hli], a
	inc de
	ld a, [de]
	ld [hli], a
	inc de
	ei
	dec c
	dec c
	jr nz, .chunk
	ret

AbilityPopup_CopyPicTiles:
; Copy the graphics of the tiles under the popup into wAbilityTiles, so the
; band can slide over the picture. Reads each tile from the VRAM bank its
; attribute points at.
	ld de, wAbilityTiles
	ld hl, wAbilityPopupSavedTiles
	ld b, ABILITY_SLIDE_TILES
.loop
	push bc
	push hl
	ld a, [hl] ; tile id
	push de
	ld de, wAbilityPopupSavedAttrs - wAbilityPopupSavedTiles
	add hl, de
	ld c, [hl] ; attribute
	pop de
	; hl = VRAM address of tile a (BG tiles $80-$ff at $8800, $00-$7f at $9000)
	xor $80
	swap a
	ld h, a
	and $f0
	ld l, a
	xor h
	ld h, a
	push de
	ld de, vTiles1
	add hl, de
	pop de
	ld a, c
	and VRAM_BANK_1
	jr z, .got_bank
	ld a, 1
.got_bank
	ldh [rVBK], a
	ld c, LEN_2BPP_TILE
	call AbilityPopup_ReadVRAM
	xor a
	ldh [rVBK], a
	pop hl
	inc hl
	pop bc
	dec b
	jr nz, .loop
	ret

AbilityPopup_UploadTiles:
; Copy wAbilityTiles to the popup's VRAM bank 1 tiles.
	ld a, 1
	ldh [rVBK], a
	ld de, wAbilityTiles
	ld hl, vTiles4 tile (ABILITY_SLIDE_TILE - $80)
	ld c, ABILITY_SLIDE_TILES
	ldh a, [hROMBank]
	ld b, a
	call Get2bpp ; aligned WRAM -> VRAM: GDMA, no frame wait
	xor a
	ldh [rVBK], a
	ret

AbilityPopup_Slide:
; Slide the black band in, one tile column per frame, with a slanted front
; edge. The player's band comes in from the left, the enemy's from the right.
	ld a, [wAbilityPopupSide]
	and a
	; start at the bottom row of the upper (leftmost) tile
	ld hl, wAbilityTiles + 7 * 2 + 1
	ld bc, 2 tiles
	jr z, .got_start
	; start at the bottom row of the upper rightmost tile
	ld hl, wAbilityTiles + 7 * 2 + 1 + (ABILITY_SLIDE_WIDTH - 1) tiles
	ld bc, 0 tiles
.got_start
	ld d, ABILITY_SLIDE_WIDTH
	push bc
	jr .handle_slide_loop
.slide_loop
	call .Fill2Tiles
	pop bc
	add hl, bc
	push bc
.handle_slide_loop
	push bc
	push de
	call .DoSlide
	pop de
	pop bc
	call DelayFrame
	dec d
	jr nz, .slide_loop
	pop bc
	ret

.Fill2Tiles:
; Fill the column's 2 tiles; hl points to the last row of the bottom tile + 1.
	dec hl
	call .do_fill_loop
	ld bc, -(ABILITY_SLIDE_WIDTH - 1) tiles
	add hl, bc
.do_fill_loop
	ld c, 1 tiles
	ld a, -1
.fill_loop
	ld [hld], a
	dec c
	jr nz, .fill_loop
	ret

.DoSlide:
; Draw the slanted front edge into the current column, then upload.
	lb bc, -1, 8
	push bc
.slide_loop1
	ld a, [hl]
	or b
	ld [hld], a
	ld a, [hl]
	or b
	ld [hld], a
	call .ShiftB
	dec c
	jr nz, .slide_loop1
	ld bc, ABILITY_SLIDE_WIDTH tiles + 1
	add hl, bc
	pop bc
.slide_loop2
	ld a, [hl]
	or b
	ld [hli], a
	ld a, [hl]
	or b
	ld [hli], a
	call .ShiftB
	dec c
	jr nz, .slide_loop2
	push hl
	call AbilityPopup_UploadTiles
	pop hl
	ret

.ShiftB:
	ld a, [wAbilityPopupSide]
	and a
	jr nz, .ShiftEnemyB
	sla b
	ret
.ShiftEnemyB
	srl b
	ret

AbilityPopup_DrawText:
; Type the two lines into the band, one character per frame.
	; First, try to center the combined string with some overlap.
	ld de, wAbilityPkmn
	call GetVWFLength
	ld b, a
	ld de, wAbilityName
	call GetVWFLength
	ld c, a
	add b
	sub ABILITY_SLIDE_OVERLAP
	jr c, .short ; both very short
	cp ABILITY_SLIDE_TEXT_WIDTH
	jr c, .center_text

	; too long to center: name at the left edge, ability at the right edge
	lb bc, 0, ABILITY_SLIDE_TEXT_WIDTH
	jr .got_offsets

.short
	xor a
.center_text
	; c = right end of the ability name, b = left end of the nickname
	srl a
	add ABILITY_SLIDE_TEXT_WIDTH / 2
	ld c, a
	ld a, ABILITY_SLIDE_TEXT_WIDTH
	sub c
	ld b, a

.got_offsets
	; skip the band's slanted edge: the enemy's is on the left
	ld a, [wAbilityPopupSide]
	and a
	ld a, 1
	jr z, .got_extra_offset
	ld a, TILE_WIDTH
.got_extra_offset
	push af
	add b
	ld b, a
	pop af
	add c
	ld c, a

	ld de, wAbilityPkmn
	ld hl, wAbilityTiles
	push bc
	ld c, b
	call .PlaceString
	ld de, wAbilityName
	call GetVWFLength
	pop bc
	; right-align the ability name at c
	ld h, a
	ld a, c
	sub h
	ld c, a
	ld de, wAbilityName
	ld hl, wAbilityTiles + ABILITY_SLIDE_WIDTH tiles
	; fallthrough

.PlaceString:
; Place the string at de into the tiles at hl from pixel c.
	ld a, [de]
	newfarcall PlaceNextVWFCharInverted
	ret z
	push de
	push bc
	push hl
	call AbilityPopup_UploadTiles
	call DelayFrame
	pop hl
	pop bc
	pop de
	jr .PlaceString
