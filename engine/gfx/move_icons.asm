; Type and category icons for moves (from Polished Crystal).

DEF MOVE_ICON_TILES EQU 6 ; 2 category tiles, then 4 type tiles

; As BG tiles, the icons use tiles $79-$7e (VRAM bank 0), free on every
; screen that shows them.
DEF MOVE_ICON_TILE EQU $79

; In battle the icons are sprites over the move info box (see below), so
; no BG palette is needed and the cells under them keep their colors. They
; borrow OBJ palette PAL_BATTLE_OB_GRAY, which nothing on screen uses while
; the move menu is open.
DEF BATTLE_MOVE_ICON_X EQU 1
DEF BATTLE_MOVE_ICON_Y EQU 9

; The Battle Plaza's TM and tutor menus draw over the map, so they borrow
; a map palette that no cell left on screen uses (never the water one,
; which the tileset animates), keep it in wMoveIconSavedPalette and give
; it back when the box is cleared or the menu closes.
DEF PLAZA_MOVE_ICON_X EQU 10
DEF PLAZA_MOVE_ICON_Y EQU 13

; The pack's BG palettes are all in use too, so in the TM pocket the
; icons are sprites as well, with OBJ palette 7.
; Sprite icons use OBJ tiles $7a-$7f in VRAM bank 1 and the last six OAM
; entries. These slots and OBJ palettes 6-7 stay reserved while the pack
; is open; switching pockets only clears their shadow OAM entries.
DEF MOVE_ICON_OBJ_TILE EQU $7a
DEF MOVE_ICON_FIRST_OAM EQU NUM_SPRITE_OAM_STRUCTS - MOVE_ICON_TILES
DEF TMHM_MOVE_ICON_OBJ_PAL EQU 7
DEF TMHM_MOVE_ICON_X EQU 10
DEF TMHM_MOVE_ICON_Y EQU 13

; POW/ACC/EFF are three-tile word icons, with the same 8px height as types.
; They borrow tile IDs absent from the current tilemap and restore them
; when the menu closes, so map graphics remain intact.
DEF MOVE_STAT_BADGE_WIDTH EQU 3
DEF MOVE_STAT_BADGE_TILES EQU MOVE_STAT_BADGE_WIDTH * 3

; The TM pocket has no free BG palette, so its badges use OBJ palette 6
; and nine OAM entries immediately before the move icons' last six.
DEF MOVE_STAT_OBJ_TILE EQU $80
DEF MOVE_STAT_OBJ_PAL EQU 6
DEF MOVE_STAT_FIRST_OAM EQU MOVE_ICON_FIRST_OAM - MOVE_STAT_BADGE_TILES

; scratch while drawing
DEF hMoveIconPalette  EQUS "hMathBuffer"
DEF hMoveIconRow      EQUS "hMathBuffer + 1"
DEF hMoveIconCol      EQUS "hMathBuffer + 2"
DEF hMoveIconType     EQUS "hMathBuffer + 3"
DEF hMoveIconCategory EQUS "hMathBuffer + 4"

GetMoveIconIndices:
; b = move. Returns c = type icon index, e = category icon index.
	ld a, b
	push af
	dec a
	ld hl, Moves + MOVE_TYPE
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld a, BANK(Moves)
	call GetFarByte
	ld d, a
	pop af
	ld b, a ; move
	ld a, d

; category: PHYSICAL/SPECIAL/STATUS in bits 6-7 -> 0/1/2
	rlca
	rlca
	and %11
	jr nz, .got_category
	ld a, STATUS >> 6
.got_category
	dec a
	ld e, a

	ld a, b
	cp HIDDEN_POWER
	jr z, .hidden_power
	cp HIDDEN_FORCE
	jr z, .hidden_power
	ld a, d
	and TYPE_MASK
	jr .got_type

.hidden_power
	push de
	farcall GetHiddenPowerTypeInB
	pop de
	ld a, b
.got_type
	cp TYPES_END
	ld c, TYPE_ICON_UNKNOWN
	ret nc
	ld hl, MoveTypeIconIndices
	add l
	ld l, a
	adc h
	sub l
	ld h, a
	ld c, [hl]
	ret

LoadMoveIconPalette:
; Fill the palette at hl (WRAM bank 5) for type icon c and category icon
; e: color 0 the text palette's background, colors 1-2 the category,
; color 3 the type.
	ldh a, [rSVBK]
	push af
	ld a, BANK(wBGPals1)
	ldh [rSVBK], a
	ld a, [wBGPals1 palette 7]
	ld [hli], a
	ld a, [wBGPals1 palette 7 + 1]
	ld [hli], a
	push hl
	ld hl, MoveCategoryIconPals
	ld a, e
	add a
	add a
	add l
	ld l, a
	adc h
	sub l
	ld h, a
	pop de
rept 4
	ld a, [hli]
	ld [de], a
	inc de
endr
	ld hl, MoveTypeIconPals
	ld a, c
	add a
	add l
	ld l, a
	adc h
	sub l
	ld h, a
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	pop af
	ldh [rSVBK], a
	ret

MoveIcons_SendPalette:
; Send the palette at hl (WRAM bank 5) to the hardware in H-Blanks:
; c = LOW(rBGPI) or LOW(rOBPI), b = its palette * 1 palettes.
	ldh a, [rSVBK]
	push af
	ld a, BANK(wBGPals1)
	ldh [rSVBK], a
	set rBGPI_AUTO_INCREMENT, b
	ld e, 1 palettes / 2
.loop
	call MoveIcons_WaitHBlank
	ld a, b
	ldh [c], a
	inc c ; data port
	ld a, [hli]
	ldh [c], a
	ld a, [hli]
	ldh [c], a
	dec c ; index port
	ei
	inc b
	inc b
	dec e
	jr nz, .loop
	pop af
	ldh [rSVBK], a
	ret

MoveIcons_SendTiles:
; Stage the category and type graphics for GDMA instead of spending
; one H-Blank on each pair of bytes. hl = destination, b = VRAM bank.
	ld a, b
	ldh [rVBK], a
	push hl
	ldh a, [hMoveIconCategory]
	ld e, a
	call GetCategoryIconGFX
	pop hl
	push hl
	lb bc, BANK(MoveCategoryIconGFX), 2
	call Get2bppViaHDMA
	pop hl
	ld bc, 2 tiles
	add hl, bc
	push hl
	ldh a, [hMoveIconType]
	ld c, a
	call GetTypeIconGFX
	pop hl
	lb bc, BANK(MoveTypeIconGFX), 4
	call Get1bppViaHDMA
	xor a
	ldh [rVBK], a
	ret

MoveIcons_GetIndices:
; b = move: hMoveIconType and hMoveIconCategory
	call GetMoveIconIndices
	ld a, c
	ldh [hMoveIconType], a
	ld a, e
	ldh [hMoveIconCategory], a
	ret

MoveIcons_Stage::
; Prepare icons while the caller builds a page with hBGMapMode = 0.
; The caller commits the complete page once with MoveIcons_CommitPage.
	call MoveIcons_PrepareBG
	call MoveIcons_LoadBGTiles
	ld a, TRUE
	ldh [hCGBPalUpdate], a
	ret

MoveIcons_CommitPage::
; These pages change BG attributes too, even when map sprite updates are
; disabled. Force both maps into the same VBlank7 commit, plus palettes.
	ld b, 3
	farjp SafeCopyTilemapAtOnce

MoveIcons_PrepareBG:
	ld a, c
	ldh [hMoveIconPalette], a
	ld a, d
	ldh [hMoveIconRow], a
	ld a, e
	ldh [hMoveIconCol], a
	call MoveIcons_GetIndices

; the cells in wTilemap and wAttrmap
	call MoveIcons_TilemapAddress
	push hl
	ld a, MOVE_ICON_TILE
	ld c, MOVE_ICON_TILES
.place
	ld [hli], a
	inc a
	dec c
	jr nz, .place
	pop hl
	ld bc, wAttrmap - wTilemap
	add hl, bc
	ldh a, [hMoveIconPalette]
	and PALETTE_MASK
	ld bc, MOVE_ICON_TILES
	call ByteFill


; the palette: in wBGPals1 and wBGPals2, and straight to the hardware
	ldh a, [hMoveIconPalette]
	and PALETTE_MASK
	ld l, a
	ld h, 0
	add hl, hl
	add hl, hl
	add hl, hl ; * 1 palettes
	ld bc, wBGPals2
	add hl, bc
	push hl
	ldh a, [hMoveIconType]
	ld c, a
	ldh a, [hMoveIconCategory]
	ld e, a
	call LoadMoveIconPalette
	pop hl
	push hl
	ld d, h
	ld e, l
	ld bc, wBGPals1 - wBGPals2
	add hl, bc
	ld b, d
	ld c, e
	ld d, h
	ld e, l
	ld h, b
	ld l, c
	ldh a, [rSVBK]
	push af
	ld a, BANK(wBGPals1)
	ldh [rSVBK], a
	ld bc, 1 palettes
	call CopyBytes
	pop af
	ldh [rSVBK], a
	pop hl
	ret

MoveIcons_LoadBGTiles:
	ld hl, vTiles2 tile MOVE_ICON_TILE
	ld b, BANK(vTiles2)
	jmp MoveIcons_SendTiles

PlazaMoveStatBadges_Stage::
; Borrow a free palette just like the Battle Plaza's move icons do.
	ldh a, [rSVBK]
	push af
	ld a, BANK(wMoveStatBadgeTileIds)
	ldh [rSVBK], a
	ld a, [wMoveStatBadgeActive]
	and a
	jr nz, .reuse_palette
	call MoveStatBadges_FindFreePalette
	jr nc, .have_palette
	ld a, PAL_BG_ROOF ; same fallback used by PlazaMoveIcons_Stage
	ld c, a
	jr .show
.have_palette
	ld c, a
	jr .show
.reuse_palette
	ld a, [wMoveStatPalette]
	ld c, a
.show
	ld d, PLAZA_MOVE_ICON_Y
	ld e, 1
	pop af
	ldh [rSVBK], a
	; fallthrough

MoveStatBadges_Stage::
; Compact POW/ACC/EFF: d = top row, e = column, c = free BG palette.
	ldh a, [rSVBK]
	push af
	ld a, BANK(wMoveStatBadgeTileIds)
	ldh [rSVBK], a
	ld a, d
	ld [wMoveStatRow], a
	ld a, e
	ld [wMoveStatCol], a
	ld a, c
	ld [wMoveStatPalette], a
	ld a, 3
	ld [wMoveStatRows], a

	ld a, [wMoveStatBadgeActive]
	and a
	jr nz, .ready
	call MoveStatBadges_AllocateTiles
	jr c, .done
	call MoveStatBadges_SaveTiles
	call MoveStatBadges_LoadTiles
	call MoveStatBadges_SavePalette
	ld a, TRUE
	ld [wMoveStatBadgeActive], a
.ready
	call MoveStatBadges_LoadPalette
	call MoveStatBadges_WriteTilemap
.done
	pop af
	ldh [rSVBK], a
	ret

BattleMoveStatEffBadge_Show::
; Every battle BG palette can be in use. Keep EFF on sprites so the
; textbox, description and HUD palettes are never borrowed or recolored.
	ldh a, [rSVBK]
	push af
	ld a, BANK(wMoveStatBadgeTileIds)
	ldh [rSVBK], a
	call MoveStatBadges_PrepareSprites
	ld hl, wShadowOAMSprite00 + MOVE_STAT_FIRST_OAM * OBJ_SIZE
for badge_tile, MOVE_STAT_BADGE_WIDTH
	ld a, (13 + 2) * TILE_WIDTH
	ld [hli], a
	ld a, (1 + 1 + badge_tile) * TILE_WIDTH
	ld [hli], a
	ld a, MOVE_STAT_OBJ_TILE + MOVE_STAT_BADGE_WIDTH * 2 + badge_tile
	ld [hli], a
	ld a, MOVE_STAT_OBJ_PAL | VRAM_BANK_1
	ld [hli], a
endr
	pop af
	ldh [rSVBK], a
	ret

MoveStatBadges_FindFreePalette:
; Return c = a BG palette not used by any visible cell, or carry if none.
; Water animations update their palette even under a map menu.
	xor a
	ldh [hMoveIconType], a
.candidate
	ldh a, [hMoveIconType]
	cp 8
	jr nc, .none
	cp PAL_BG_WATER
	jr z, .used
	ld c, a
	ld hl, wAttrmap
	ld de, SCREEN_WIDTH * SCREEN_HEIGHT
.scan
	ld a, [hli]
	and PALETTE_MASK
	cp c
	jr z, .used
	dec de
	ld a, d
	or e
	jr nz, .scan
	ldh a, [hMoveIconType]
	ld c, a
	and a
	ret
.used
	ldh a, [hMoveIconType]
	inc a
	ldh [hMoveIconType], a
	jr .candidate
.none
	scf
	ret

MoveStatBadges_AllocateTiles:
; Mark tile usage in one screen pass. The backup is not live yet, so its
; first 128 bytes can be scratch until SaveTiles fills the real backup.
	xor a
	ld hl, wMoveStatTileBackup
	ld bc, $80
	call ByteFill
	ld hl, wTilemap
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
.scan
	ld a, [hli]
	cp $7f ; never borrow the textbox space tile
	jr nc, .next_cell
	push hl
	add LOW(wMoveStatTileBackup)
	ld l, a
	adc HIGH(wMoveStatTileBackup)
	sub l
	ld h, a
	ld [hl], 1
	pop hl
.next_cell
	dec bc
	ld a, b
	or c
	jr nz, .scan

	ld hl, wMoveStatTileBackup
	ld bc, $55
	add hl, bc ; keep Move Dex badges above the Smeargle picture tiles
	ld de, wMoveStatBadgeTileIds
	ld b, MOVE_STAT_BADGE_TILES
	ld c, $55
.candidate
	ld a, [hli]
	and a
	jr nz, .next_candidate
	ld a, c
	ld [de], a
	inc de
	dec b
	jr z, .allocated
.next_candidate
	inc c
	ld a, c
	cp $7f
	jr c, .candidate
	ld hl, wMoveStatTileBackup
	ld c, 0
.low_candidate
	ld a, [hli]
	and a
	jr nz, .next_low_candidate
	ld a, c
	ld [de], a
	inc de
	dec b
	jr z, .allocated
.next_low_candidate
	inc c
	ld a, c
	cp $55
	jr c, .low_candidate
	scf
	ret
.allocated
	and a
	ret

MoveStatBadges_SaveTiles:
	ldh a, [rSVBK]
	push af
	ld a, BANK(wMoveStatTileBackup)
	ldh [rSVBK], a
	xor a
	ldh [rVBK], a
	ld hl, wMoveStatTileBackup
	ld de, wMoveStatBadgeTileIds
	ld a, MOVE_STAT_BADGE_TILES
	ld [wMoveStatWorkCount], a
.tile
	ld a, [de]
	inc de
	push de
	push hl
	ld l, a
	ld h, 0
rept 4
	add hl, hl
endr
	ld bc, vTiles2
	add hl, bc
	ld d, h
	ld e, l ; source tile
	pop hl ; backup destination
	ld c, LEN_2BPP_TILE
.byte
	call MoveIcons_WaitHBlank
	ld a, [de]
	inc de
	ld [hli], a
	ld a, [de]
	inc de
	ld [hli], a
	ei
	dec c
	dec c
	jr nz, .byte
	pop de
	ld a, [wMoveStatWorkCount]
	dec a
	ld [wMoveStatWorkCount], a
	jr nz, .tile
	pop af
	ldh [rSVBK], a
	ret

MoveStatBadges_LoadTiles:
	ld de, MoveStatBadgeGFX
	jr MoveStatBadges_CopyTiles

MoveStatBadges_CopyTiles:
; de = aligned source in this ROM bank or the selected WRAM bank.
	xor a
	ldh [rVBK], a
	ld hl, wMoveStatBadgeTileIds
	ld a, MOVE_STAT_BADGE_TILES
	ld [wMoveStatWorkCount], a
.tile
	ld a, [hli]
	push hl
	push de
	ld l, a
	ld h, 0
rept 4
	add hl, hl
endr
	ld bc, vTiles2
	add hl, bc
	lb bc, BANK(MoveStatBadgeGFX), 1
	call SafeHDMATransfer
	pop hl
	ld bc, LEN_2BPP_TILE
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	ld a, [wMoveStatWorkCount]
	dec a
	ld [wMoveStatWorkCount], a
	jr nz, .tile
	ret

MoveStatBadges_SavePalette:
	ld a, [wMoveStatPalette]
	ldh [hMoveIconPalette], a
	ldh a, [rSVBK]
	push af
	ld a, BANK(wBGPals1)
	ldh [rSVBK], a
	ldh a, [hMoveIconPalette]
	add a
	add a
	add a
	ld l, a
	ld h, 0
	ld bc, wBGPals1
	add hl, bc
	ld de, wMoveStatSavedPalette
	ld bc, 1 palettes
	call CopyBytes
	pop af
	ldh [rSVBK], a
	ret

MoveStatBadges_LoadPalette:
	ld a, [wMoveStatPalette]
	ldh [hMoveIconPalette], a
	ldh a, [rSVBK]
	push af
	ld a, BANK(wBGPals1)
	ldh [rSVBK], a
	ldh a, [hMoveIconPalette]
	add a
	add a
	add a
	ld l, a
	ld h, 0
	ld bc, wBGPals1
	add hl, bc
	ld d, h
	ld e, l
	ld hl, MoveStatBadgePals
	ld bc, 1 palettes
	call CopyBytes

	ldh a, [hMoveIconPalette]
	add a
	add a
	add a
	ld l, a
	ld h, 0
	ld bc, wBGPals1
	add hl, bc
	push hl
	ld de, wBGPals2 - wBGPals1
	add hl, de
	ld d, h
	ld e, l
	pop hl
	ld bc, 1 palettes
	call CopyBytes
	ldh a, [hMoveIconPalette]
	add a
	add a
	add a
	ld b, a
	ld c, LOW(rBGPI)
	ldh a, [hMoveIconPalette]
	add a
	add a
	add a
	ld l, a
	ld h, 0
	ld de, wBGPals1
	add hl, de
	call MoveIcons_SendPalette
	pop af
	ldh [rSVBK], a
	ret

MoveStatBadges_WriteTilemap:
	ld a, [wMoveStatRows]
	ld [wMoveStatRowsLeft], a
	ld bc, wMoveStatBadgeTileIds
.row
	push bc
	call MoveStatBadges_TilemapAddress
	push hl
	ld bc, wAttrmap - wTilemap
	add hl, bc
	ld d, h
	ld e, l ; attributes
	pop hl ; tile map
	pop bc
	ld a, [bc]
	inc bc
	ld [hli], a
	ld a, [bc]
	inc bc
	ld [hli], a
	ld a, [bc]
	inc bc
	ld [hli], a
	ld a, [wMoveStatPalette]
	ld [de], a
	inc de
	ld [de], a
	inc de
	ld [de], a
	inc de
	ld a, [wMoveStatRowsLeft]
	dec a
	ld [wMoveStatRowsLeft], a
	jr nz, .row
	ret

MoveStatBadges_GetCoords:
; Use the same coordinates for drawing, visible detachment and cleanup.
	ld a, [wMoveStatRowsLeft]
	ld b, a
	ld a, [wMoveStatRows]
	sub b
	ld b, a
	ld a, [wMoveStatRow]
	ld d, a
	ld a, [wMoveStatCol]
	ld e, a
	ld a, b
	cp 2
	jr c, .row
	ld b, 1 ; EFF shares ACC's row, below Category
	ld a, e
	add 9
	ld e, a
.row
	ld a, d
	add b
	ld d, a
	ret

MoveStatBadges_TilemapAddress:
	call MoveStatBadges_GetCoords
	ld a, d
	ldh [hMoveIconRow], a
	ld a, e
	ldh [hMoveIconCol], a
	jmp MoveIcons_TilemapAddress

MoveStatBadges_DetachBG:
; The visible map must stop using the borrowed tile IDs before RestoreTiles.
	ldh a, [rSVBK]
	push af
	ld a, BANK(wMoveStatBadgeActive)
	ldh [rSVBK], a
	ld a, [wMoveStatBadgeActive]
	and a
	jr z, .done
	ld a, [wMoveStatRows]
	ld [wMoveStatRowsLeft], a
.row
	call MoveStatBadges_GetCoords
	ld b, MOVE_STAT_BADGE_WIDTH
	call MoveIcons_ClearVisibleCells
	ld a, [wMoveStatRowsLeft]
	dec a
	ld [wMoveStatRowsLeft], a
	jr nz, .row
.done
	pop af
	ldh [rSVBK], a
	ret

MoveIcons_ClearVisibleCells:
; Blank b visible BG cells at row d, column e, with the text palette.
; Stop automatic copies so VBlank cannot put stale icon IDs back afterwards.
	xor a
	ldh [hBGMapMode], a
	ld l, d
	ld h, 0
rept 5
	add hl, hl
endr
	ld a, e
	add l
	ld l, a
	adc h
	sub l
	ld h, a
	ldh a, [hBGMapAddress]
	ld e, a
	ldh a, [hBGMapAddress + 1]
	ld d, a
	add hl, de
.cell
	call MoveIcons_WaitHBlank
	xor a
	ldh [rVBK], a
	ld a, " "
	ld [hl], a
	ld a, 1
	ldh [rVBK], a
	ld a, PAL_BG_TEXT
	ld [hli], a
	xor a
	ldh [rVBK], a
	ei
	dec b
	jr nz, .cell
	ret

PartyMoveIcons_Close::
; Detach both kinds of BG icons before returning borrowed graphics.
	call MoveStatBadges_DetachBG
	lb de, 13, 10
	ld b, MOVE_ICON_TILES
	call MoveIcons_ClearVisibleCells
	; fallthrough

MoveStatBadges_Hide::
; Caller has detached the visible cells; now restore the borrowed resources.
	ldh a, [rSVBK]
	push af
	ld a, BANK(wMoveStatBadgeTileIds)
	ldh [rSVBK], a
	ld a, [wMoveStatBadgeActive]
	and a
	jr nz, .active
	pop af
	ldh [rSVBK], a
	ret
.active
	ld a, [wMoveStatRows]
	ld [wMoveStatRowsLeft], a
.clear_row
	call MoveStatBadges_TilemapAddress
	push hl
	ld a, " "
	ld bc, MOVE_STAT_BADGE_WIDTH
	call ByteFill
	pop hl
	ld bc, wAttrmap - wTilemap
	add hl, bc
	ld a, PAL_BG_TEXT
	ld bc, MOVE_STAT_BADGE_WIDTH
	call ByteFill
	ld a, [wMoveStatRowsLeft]
	dec a
	ld [wMoveStatRowsLeft], a
	jr nz, .clear_row
	call MoveStatBadges_RestoreTiles
	call MoveStatBadges_RestorePalette
	xor a
	ld [wMoveStatBadgeActive], a
	pop af
	ldh [rSVBK], a
	ret

MoveStatBadges_RestoreTiles:
	ld de, wMoveStatTileBackup
	jmp MoveStatBadges_CopyTiles

MoveStatBadges_RestorePalette:
	ld a, [wMoveStatPalette]
	ldh [hMoveIconPalette], a
	ldh a, [rSVBK]
	push af
	ld a, BANK(wBGPals1)
	ldh [rSVBK], a
	ldh a, [hMoveIconPalette]
	add a
	add a
	add a
	ld l, a
	ld h, 0
	ld bc, wBGPals1
	add hl, bc
	ld d, h
	ld e, l
	ld hl, wMoveStatSavedPalette
	ld bc, 1 palettes
	call CopyBytes

	ldh a, [hMoveIconPalette]
	add a
	add a
	add a
	ld l, a
	ld h, 0
	ld bc, wBGPals1
	add hl, bc
	ld de, wBGPals2 - wBGPals1
	add hl, de
	ld d, h
	ld e, l
	ld hl, wMoveStatSavedPalette
	ld bc, 1 palettes
	call CopyBytes
	ldh a, [hMoveIconPalette]
	add a
	add a
	add a
	ld b, a
	ld c, LOW(rBGPI)
	ldh a, [hMoveIconPalette]
	add a
	add a
	add a
	ld l, a
	ld h, 0
	ld de, wBGPals1
	add hl, de
	call MoveIcons_SendPalette
	pop af
	ldh [rSVBK], a
	ret

PlazaMoveIcons_PrepareMenu::
; The list and move box cover rows 3-17. Clear the exposed header before
; drawing its counters, so leftover map colors cannot exhaust the two BG
; palettes needed by Type/Category and POW/ACC/EFF. The caller has already
; backed up the map for exit; no extra visible redraw is needed here.
	xor a
	ldh [hBGMapMode], a
	hlcoord 0, 0
	lb bc, 3, SCREEN_WIDTH
	call ClearBox
	hlcoord 0, 0, wAttrmap
	ld a, PAL_BG_TEXT
	ld bc, 3 * SCREEN_WIDTH
	jmp ByteFill

PlazaMoveIcons_Stage::
; Show the icons of move [wCurSpecies] in the Battle Plaza TM counter's
; and Move Tutor's move info box.
	call PlazaMoveIcons_SetCoords
	ld a, [wMoveIconBorrowedPalette]
	and a
	jr nz, .got_palette

; Free the icon cells first, so they don't count as using a palette.
	hlcoord PLAZA_MOVE_ICON_X, PLAZA_MOVE_ICON_Y, wAttrmap
	ld a, PAL_BG_TEXT
	ld bc, MOVE_ICON_TILES
	call ByteFill

; Mark the palettes the cells on screen use...
	hlcoord 0, 0, wAttrmap
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	ld d, 0
.scan
	ld a, [hli]
	and PALETTE_MASK
	call .Bit
	or d
	ld d, a
	dec bc
	ld a, b
	or c
	jr nz, .scan

; ...and take the first free one in .Preference.
	ld hl, .Preference
.find
	ld a, [hli]
	cp -1
	jr z, .fallback
	ld c, a
	call .Bit
	and d
	jr nz, .find
	ld a, c
	jr .borrow
.fallback
	ld a, PAL_BG_ROOF
.borrow
; keep the map's own colors to give back
	or $80
	ld [wMoveIconBorrowedPalette], a
	call .PaletteAddress
	ld de, wMoveIconSavedPalette
	ld bc, 1 palettes
	ldh a, [rSVBK]
	push af
	ld a, BANK(wBGPals1)
	ldh [rSVBK], a
	call CopyBytes
	pop af
	ldh [rSVBK], a

.got_palette
	ld a, [wMoveIconBorrowedPalette]
	and PALETTE_MASK
	ld c, a
	ld a, [wCurSpecies]
	ld b, a
	lb de, PLAZA_MOVE_ICON_Y, PLAZA_MOVE_ICON_X
	jmp MoveIcons_Stage

.Bit:
; a = 1 << a
	ld e, a
	ld a, 1
	inc e
.bit_loop
	dec e
	ret z
	add a
	jr .bit_loop

.PaletteAddress:
; hl = palette [wMoveIconBorrowedPalette] in wBGPals1
	ld a, [wMoveIconBorrowedPalette]
	and PALETTE_MASK
	ld l, a
	ld h, 0
	add hl, hl
	add hl, hl
	add hl, hl ; * 1 palettes
	ld bc, wBGPals1
	add hl, bc
	ret

.Preference:
	db PAL_BG_ROOF, PAL_BG_BROWN, PAL_BG_YELLOW, PAL_BG_GREEN, PAL_BG_RED, PAL_BG_GRAY, -1

PlazaMoveIcons_Close::
; Release the visible BG references before restoring either borrowed palette.
	call MoveStatBadges_DetachBG
	ld a, [wMoveIconBorrowedPalette]
	and a
	jr z, .detached
	lb de, PLAZA_MOVE_ICON_Y, PLAZA_MOVE_ICON_X
	ld b, MOVE_ICON_TILES
	call MoveIcons_ClearVisibleCells
.detached
	; fallthrough

PlazaMoveIcons_Hide::
; Blank the icon cells and give the borrowed palette back to the map,
; when the box is cleared or the menu closes.
	call MoveStatBadges_Hide
	call PlazaMoveIcons_SetCoords
	hlcoord PLAZA_MOVE_ICON_X, PLAZA_MOVE_ICON_Y
	ld a, " "
	ld bc, MOVE_ICON_TILES
	call ByteFill
	hlcoord PLAZA_MOVE_ICON_X, PLAZA_MOVE_ICON_Y, wAttrmap
	ld a, PAL_BG_TEXT
	ld bc, MOVE_ICON_TILES
	call ByteFill

	ld a, [wMoveIconBorrowedPalette]
	and a
	ret z
	call PlazaMoveIcons_Stage.PaletteAddress
	ld d, h
	ld e, l
	ld hl, wMoveIconSavedPalette
	ld bc, 1 palettes
	ldh a, [rSVBK]
	push af
	ld a, BANK(wBGPals1)
	ldh [rSVBK], a
	push de
	call CopyBytes ; wBGPals1
	pop hl
	ld de, wBGPals2 - wBGPals1
	add hl, de
	ld d, h
	ld e, l
	ld hl, wMoveIconSavedPalette
	ld bc, 1 palettes
	call CopyBytes ; wBGPals2
	pop af
	ldh [rSVBK], a
	xor a
	ld [wMoveIconBorrowedPalette], a
	ld a, TRUE
	ldh [hCGBPalUpdate], a
	ret

PlazaMoveIcons_SetCoords:
	ld a, PLAZA_MOVE_ICON_Y
	ldh [hMoveIconRow], a
	ld a, PLAZA_MOVE_ICON_X
	ldh [hMoveIconCol], a
	ret

BattleMoveIcons_Draw::
; Show the type and category icons of move b in the battle move info box.
	ld c, PAL_BATTLE_OB_GRAY
	lb de, BATTLE_MOVE_ICON_Y, BATTLE_MOVE_ICON_X
	scf ; battle updates the visible icon cells immediately
	jr MoveIcons_ShowSprites

BattleMoveIcons_Hide::
; when the move menu closes, or its box shows "Disabled!"
	ld c, PAL_BATTLE_OB_GRAY
	jmp MoveIcons_HideSprites

TMHMMoveIcons_Show::
; Reuse the current icons unless the hovered move changed.
	ldh a, [rSVBK]
	push af
	ld a, BANK(wTMHMDisplayedMove)
	ldh [rSVBK], a
	ld a, [wCurSpecies]
	ld b, a
	ld a, [wTMHMDisplayedMove]
	cp b
	jr z, .unchanged
	ld a, b
	ld [wTMHMDisplayedMove], a
	pop af
	ldh [rSVBK], a
	ld c, TMHM_MOVE_ICON_OBJ_PAL
	lb de, TMHM_MOVE_ICON_Y, TMHM_MOVE_ICON_X
	and a ; the TM pocket commits the icons and page together
	jr MoveIcons_ShowSprites
.unchanged
	pop af
	ldh [rSVBK], a
	ret

MoveIcons_ShowSprites:
; Show the type and category icons of move b as six sprites over the
; cells starting at row d, column e, with OBJ palette c.
; Carry: wait below the icon row before changing visible graphics.
	push af
	ld a, c
	ldh [hMoveIconPalette], a
	ld a, d
	ldh [hMoveIconRow], a
	ld a, e
	ldh [hMoveIconCol], a
	call MoveIcons_GetIndices
	pop af
	push af
	call c, MoveIcons_WaitBelowRow

	ldh a, [hMoveIconPalette]
	ld l, a
	ld h, 0
	add hl, hl
	add hl, hl
	add hl, hl ; * 1 palettes
	ld bc, wOBPals2
	add hl, bc
	push hl
	ldh a, [hMoveIconType]
	ld c, a
	ldh a, [hMoveIconCategory]
	ld e, a
	call LoadMoveIconPalette
	pop hl
	pop af
	jr nc, .staged_palette
	ldh a, [hMoveIconPalette]
	add a
	add a
	add a ; * 1 palettes
	ld b, a
	ld c, LOW(rOBPI)
	call MoveIcons_SendPalette
	jr .tiles
.staged_palette
	ld a, TRUE
	ldh [hCGBPalUpdate], a
.tiles
	ld hl, vTiles3 tile MOVE_ICON_OBJ_TILE
	ld b, BANK(vTiles3)
	call MoveIcons_SendTiles

	ldh a, [hMoveIconCol]
	inc a
	add a
	add a
	add a ; (col + 1) * TILE_WIDTH
	ld b, a
	ldh a, [hMoveIconRow]
	add 2
	add a
	add a
	add a ; (row + 2) * TILE_WIDTH
	ld d, a
	ldh a, [hMoveIconPalette]
	or VRAM_BANK_1
	ld e, a
	ld c, MOVE_ICON_OBJ_TILE
	ld hl, wShadowOAMSprite00 + MOVE_ICON_FIRST_OAM * OBJ_SIZE
.oam
	ld a, d
	ld [hli], a ; y
	ld a, b
	ld [hli], a ; x
	add TILE_WIDTH
	ld b, a
	ld a, c
	ld [hli], a ; tile
	inc c
	ld a, e
	ld [hli], a ; attributes
	ld a, c
	cp MOVE_ICON_OBJ_TILE + MOVE_ICON_TILES
	jr nz, .oam
	ret

TMHM_MoveIcons_Init::
; These OBJ slots are reserved for the pack. Load fixed badges while its
; LCD is off, with no per-pocket VRAM reads, backups or restoration waits.
	call TMHM_MoveStatBadges_LoadTiles
	ldh a, [rSVBK]
	push af
	ld a, BANK(wOBPals1)
	ldh [rSVBK], a
	ld hl, MoveStatBadgePals
	ld de, wOBPals1 palette MOVE_STAT_OBJ_PAL
	ld bc, 1 palettes
	call CopyBytes
	ld hl, MoveStatBadgePals
	ld de, wOBPals2 palette MOVE_STAT_OBJ_PAL
	ld bc, 1 palettes
	call CopyBytes
	ld a, BANK(wTMHMDisplayedMove)
	ldh [rSVBK], a
	xor a
	ld [wTMHMDisplayedMove], a
	pop af
	ldh [rSVBK], a
	ret

TMHM_MoveStatBadges_Show::
; Fixed graphics/palette were loaded with the pack; just place nine sprites.
	jmp TMHM_MoveStatBadges_DrawSprites

MoveStatBadges_PrepareSprites:
; Caller selected the badge state/backup WRAM bank.
	ld a, [wMoveStatObjBadgesActive]
	and a
	jr nz, .loaded
	call TMHM_MoveStatBadges_SaveTiles
	call TMHM_MoveStatBadges_LoadTiles
	ld a, TRUE
	ld [wMoveStatObjBadgesActive], a
.loaded
	jmp TMHM_MoveStatBadges_LoadPalette

TMHMMoveIcons_Close::
; The slots stay reserved until the pack closes. Stage their removal with
; the next pocket page, without waiting for OAM or rewriting live tiles.
	xor a
	ldh [hBGMapMode], a
	ld hl, wShadowOAMSprite00 + MOVE_STAT_FIRST_OAM * OBJ_SIZE
	ld bc, (MOVE_STAT_BADGE_TILES + MOVE_ICON_TILES) * OBJ_SIZE
	call ByteFill
	ldh a, [rSVBK]
	push af
	ld a, BANK(wTMHMDisplayedMove)
	ldh [rSVBK], a
	xor a
	ld [wTMHMDisplayedMove], a
	pop af
	ldh [rSVBK], a
	ret

BattleMoveStatEffBadge_Close::
; Keep the battle's type/category sprites, but remove EFF from hardware
; OAM before its tile data and OBJ palette are restored.
	xor a
	ldh [hBGMapMode], a
	ld hl, wShadowOAMSprite00 + MOVE_STAT_FIRST_OAM * OBJ_SIZE
	ld bc, MOVE_STAT_BADGE_TILES * OBJ_SIZE
	call ByteFill
	call MoveIcons_FlushOAM
	jr TMHM_MoveStatBadges_Hide

MoveIcons_FlushOAM:
; Use a complete OAM DMA in a safe VBlank interval. The transfer also
; works with the LCD off and does not depend on hOAMUpdate being enabled.
.wait
	di
	ldh a, [rLCDC]
	bit rLCDC_ENABLE, a
	jr z, .copy
	ldh a, [rLY]
	cp LY_VBLANK
	jr c, .next
	cp LY_VBLANK + 7
	jr c, .copy
.next
	ei
	jr .wait
.copy
	call hTransferShadowOAM
	ei
	ret

TMHM_MoveStatBadges_Hide::
; Caller has removed the hardware OAM references before restoring graphics.
	ldh a, [rSVBK]
	push af
	ld a, BANK(wMoveStatBadgeTileIds)
	ldh [rSVBK], a
	ld a, [wMoveStatObjBadgesActive]
	and a
	jr nz, .active
	pop af
	ldh [rSVBK], a
	ret
.active
	ld hl, wShadowOAMSprite00 + MOVE_STAT_FIRST_OAM * OBJ_SIZE
	ld bc, MOVE_STAT_BADGE_TILES * OBJ_SIZE
	xor a
	call ByteFill
	call TMHM_MoveStatBadges_RestoreTiles
	call TMHM_MoveStatBadges_RestorePalette
	xor a
	ld [wMoveStatObjBadgesActive], a
	pop af
	ldh [rSVBK], a
	ret

TMHM_MoveStatBadges_DrawSprites:
	ld hl, .oam
	ld de, wShadowOAMSprite00 + MOVE_STAT_FIRST_OAM * OBJ_SIZE
	ld bc, MOVE_STAT_BADGE_TILES * OBJ_SIZE
	jmp CopyBytes
.oam
for badge, 3
for piece, MOVE_STAT_BADGE_WIDTH
	if badge == 0
		db (13 + 2) * TILE_WIDTH, (1 + 1 + piece) * TILE_WIDTH ; POW
	elif badge == 1
		db (14 + 2) * TILE_WIDTH, (1 + 1 + piece) * TILE_WIDTH ; ACC
	else
		db (14 + 2) * TILE_WIDTH, (TMHM_MOVE_ICON_X + 1 + piece) * TILE_WIDTH ; EFF
	endc
	db MOVE_STAT_OBJ_TILE + badge * MOVE_STAT_BADGE_WIDTH + piece
	db MOVE_STAT_OBJ_PAL | VRAM_BANK_1
endr
endr

TMHM_MoveStatBadges_SaveTiles:
	ldh a, [rSVBK]
	push af
	ld a, BANK(wMoveStatObjTileBackup)
	ldh [rSVBK], a
	ld a, BANK(vTiles3)
	ldh [rVBK], a
	ld hl, vTiles3 tile MOVE_STAT_OBJ_TILE
	ld de, wMoveStatObjTileBackup
	ld c, MOVE_STAT_BADGE_TILES * LEN_2BPP_TILE
.copy
	call MoveIcons_WaitHBlank
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	inc de
	ei
	dec c
	dec c
	jr nz, .copy
	pop af
	ldh [rSVBK], a
	xor a
	ldh [rVBK], a
	ret

TMHM_MoveStatBadges_LoadTiles:
	ld de, MoveStatBadgeGFX
	; fallthrough

TMHM_MoveStatBadges_CopyTiles:
	ld a, BANK(vTiles3)
	ldh [rVBK], a
	ld hl, vTiles3 tile MOVE_STAT_OBJ_TILE
	lb bc, BANK(MoveStatBadgeGFX), MOVE_STAT_BADGE_TILES
	call SafeHDMATransfer
	xor a
	ldh [rVBK], a
	ret

TMHM_MoveStatBadges_LoadPalette:
	ldh a, [rSVBK]
	push af
	ld a, BANK(wOBPals2)
	ldh [rSVBK], a
	ld hl, MoveStatBadgePals
	ld de, wOBPals2 palette MOVE_STAT_OBJ_PAL
	ld bc, 1 palettes
	call CopyBytes
	ld hl, wOBPals2 palette MOVE_STAT_OBJ_PAL
	ld b, MOVE_STAT_OBJ_PAL * 1 palettes
	ld c, LOW(rOBPI)
	call MoveIcons_SendPalette
	pop af
	ldh [rSVBK], a
	ret

TMHM_MoveStatBadges_RestorePalette:
	ldh a, [rSVBK]
	push af
	ld a, BANK(wOBPals1)
	ldh [rSVBK], a
	ld hl, wOBPals1 palette MOVE_STAT_OBJ_PAL
	ld de, wOBPals2 palette MOVE_STAT_OBJ_PAL
	ld bc, 1 palettes
	call CopyBytes
	ld hl, wOBPals2 palette MOVE_STAT_OBJ_PAL
	ld b, MOVE_STAT_OBJ_PAL * 1 palettes
	ld c, LOW(rOBPI)
	call MoveIcons_SendPalette
	pop af
	ldh [rSVBK], a
	ld a, TRUE
	ldh [hCGBPalUpdate], a
	ret

TMHM_MoveStatBadges_RestoreTiles:
	ld de, wMoveStatObjTileBackup
	jr TMHM_MoveStatBadges_CopyTiles

MoveIcons_HideSprites:
; Take the icon sprites away and give OBJ palette c back.
	ld hl, wShadowOAMSprite00 + MOVE_ICON_FIRST_OAM * OBJ_SIZE
	push bc
	ld bc, MOVE_ICON_TILES * OBJ_SIZE
	xor a
	call ByteFill
	pop bc
	ld l, c
	ld h, 0
	add hl, hl
	add hl, hl
	add hl, hl ; * 1 palettes
	ld bc, wOBPals1
	add hl, bc
	ld de, wOBPals2 - wOBPals1
	ld b, h
	ld c, l
	add hl, de
	ld d, h
	ld e, l
	ld h, b
	ld l, c
	ldh a, [rSVBK]
	push af
	ld a, BANK(wOBPals1)
	ldh [rSVBK], a
	ld bc, 1 palettes
	call CopyBytes
	pop af
	ldh [rSVBK], a
	ld a, TRUE
	ldh [hCGBPalUpdate], a
	ret

MoveIcons_TilemapAddress:
; hl = the wTilemap address of the cell at hMoveIconRow/Col
	ldh a, [hMoveIconCol]
	ld l, a
	ld h, 0
	ld bc, wTilemap
	add hl, bc
	ld bc, SCREEN_WIDTH
	ldh a, [hMoveIconRow]
	jmp AddNTimes

MoveIcons_WaitBelowRow:
; Wait for the first scanline below row hMoveIconRow.
	ldh a, [rLCDC]
	bit rLCDC_ENABLE, a
	ret z
	ldh a, [hMoveIconRow]
	inc a
	add a
	add a
	add a ; * TILE_WIDTH
	ld b, a
.wait
	ldh a, [rLY]
	cp b
	jr nz, .wait
	ret

GetCategoryIconGFX:
; de = category icon e's graphics
	ld hl, MoveCategoryIconGFX
	ld a, e
	swap a ; * 2 tiles = * 32
	add a
	ld e, a
	ld d, 0
	add hl, de
	ld d, h
	ld e, l
	ret

GetTypeIconGFX:
; de = type icon c's graphics
	ld l, c
	ld h, 0
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, hl ; * 4 tiles * LEN_1BPP_TILE
	ld de, MoveTypeIconGFX
	add hl, de
	ld d, h
	ld e, l
	ret

MoveIcons_WaitHBlank:
; di, then wait for the start of H-Blank (or V-Blank) so VRAM can be
; written for a few bytes. The caller does ei. No wait with the LCD off.
	di
	ldh a, [rLCDC]
	bit rLCDC_ENABLE, a
	ret z
.wait_busy
	ldh a, [rLY]
	cp LY_VBLANK
	ret nc ; do not hold a pending VBlank interrupt until the next frame
	ldh a, [rSTAT]
	and %10 ; mode 2 or 3
	jr z, .wait_busy
.wait_free
	ldh a, [rSTAT]
	and %10
	jr nz, .wait_free
	ret

DEF TYPE_ICON_UNKNOWN EQU 18

MoveTypeIconIndices:
; JT type -> icon in gfx/battle/types.png
	table_width 1, MoveTypeIconIndices
	db  0 ; NORMAL
	db  1 ; FIGHTING
	db  2 ; FLYING
	db  3 ; POISON
	db  4 ; GROUND
	db  5 ; ROCK
	db TYPE_ICON_UNKNOWN ; BIRD
	db  6 ; BUG
	db  7 ; GHOST
	db  8 ; STEEL
	ds UNUSED_TYPES_END - UNUSED_TYPES, TYPE_ICON_UNKNOWN ; unused, CURSE_TYPE
	db  9 ; FIRE
	db 10 ; WATER
	db 11 ; GRASS
	db 12 ; ELECTRIC
	db 13 ; PSYCHIC_TYPE
	db 14 ; ICE
	db 15 ; DRAGON
	db 16 ; DARK
	db 17 ; FAIRY
	db 14 ; ICE2
	assert_table_length TYPES_END

MoveCategoryIconPals:
INCLUDE "gfx/battle/categories.pal"

MoveTypeIconPals:
INCLUDE "gfx/battle/types.pal"

MoveCategoryIconGFX:
INCBIN "gfx/battle/categories.2bpp"

MoveTypeIconGFX:
INCBIN "gfx/battle/types.1bpp"

MoveStatBadgePals:
	RGB 31, 31, 31 ; white lettering
	RGB 20, 04, 10 ; POW: wine
	RGB 00, 20, 15 ; ACC: teal
	RGB 11, 10, 22 ; EFF: indigo

align 4
MoveStatBadgeGFX:
INCBIN "gfx/battle/move_stat_badges.2bpp"
