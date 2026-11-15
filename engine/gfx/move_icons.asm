; Type and category icons for moves (from Polished Crystal).

DEF MOVE_ICON_TILES EQU 6 ; 2 category tiles, then 4 type tiles

; As BG tiles, the icons use tiles $79-$7e (VRAM bank 0), free on every
; screen that shows them.
DEF MOVE_ICON_TILE EQU $79

; In battle they use the unused BG palette PAL_BATTLE_BG_6. The icon cells
; only take that palette while the move menu is open, so the player's back
; sprite under the move info box keeps its own colours when it closes.
DEF BATTLE_MOVE_ICON_X EQU 1
DEF BATTLE_MOVE_ICON_Y EQU 9

; The Battle Plaza's TM and tutor menus draw over the map, so they borrow
; a map palette that no cell left on screen uses (never the water one,
; which the tileset animates), keep it in wMoveIconSavedPalette and give
; it back when the box is cleared or the menu closes.
DEF PLAZA_MOVE_ICON_X EQU 10
DEF PLAZA_MOVE_ICON_Y EQU 12

; The pack's BG palettes are all in use, so in the TM pocket the icons
; are sprites: OBJ tiles $7a-$7f in VRAM bank 1, OBJ palette 7 and the
; last six OAM entries. Leaving the pack reloads all of those.
DEF MOVE_ICON_OBJ_TILE EQU $7a
DEF MOVE_ICON_OBJ_PAL  EQU 7
DEF MOVE_ICON_FIRST_OAM EQU NUM_SPRITE_OAM_STRUCTS - MOVE_ICON_TILES
DEF TMHM_MOVE_ICON_X EQU 10
DEF TMHM_MOVE_ICON_Y EQU 12

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
; Write the category and type icon tiles to hl in VRAM bank b during
; H-Blanks.
	push hl
	ldh a, [hMoveIconCategory]
	ld e, a
	call GetCategoryIconGFX
	pop hl
	ld c, 2 * LEN_2BPP_TILE
.category
	call MoveIcons_WaitHBlank
	ld a, b
	ldh [rVBK], a
	ld a, [de]
	ld [hli], a
	inc de
	ld a, [de]
	ld [hli], a
	inc de
	xor a
	ldh [rVBK], a
	ei
	dec c
	dec c
	jr nz, .category

	push hl
	ldh a, [hMoveIconType]
	ld c, a
	call GetTypeIconGFX
	pop hl
	ld c, 4 * LEN_1BPP_TILE
.type
	call MoveIcons_WaitHBlank
	ld a, b
	ldh [rVBK], a
	ld a, [de]
	ld [hli], a
	ld [hli], a
	inc de
	xor a
	ldh [rVBK], a
	ei
	dec c
	jr nz, .type
	ret

MoveIcons_GetIndices:
; b = move: hMoveIconType and hMoveIconCategory
	call GetMoveIconIndices
	ld a, c
	ldh [hMoveIconType], a
	ld a, e
	ldh [hMoveIconCategory], a
	ret

BattleMoveIcons_Draw::
; Show the type and category icons of move b in the battle move info box.
	ld c, PAL_BATTLE_BG_6
	lb de, BATTLE_MOVE_ICON_Y, BATTLE_MOVE_ICON_X
	; fallthrough

MoveIcons_Show::
; Show the type and category icons of move b in the six cells starting at
; row d, column e of the screen, using BG palette c.
; The tiles, the palette and those cells are written straight to VRAM in
; H-Blanks while the screen is drawn below the cells, so this costs no
; frames and no frame shows a mix of the old and new icons.
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

	call MoveIcons_WaitBelowRow

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
	ldh a, [hMoveIconPalette]
	and PALETTE_MASK
	add a
	add a
	add a ; * 1 palettes
	ld b, a
	ld c, LOW(rBGPI)
	call MoveIcons_SendPalette

; the tiles
	ld hl, vTiles2 tile MOVE_ICON_TILE
	ld b, BANK(vTiles2)
	call MoveIcons_SendTiles
	; fallthrough

MoveIcons_WriteMap:
; Copy the tiles and attributes of the six cells at hMoveIconRow/Col from
; wTilemap/wAttrmap to the BG map.
	call MoveIcons_TilemapAddress
	ld d, h
	ld e, l
	ldh a, [hMoveIconRow]
	ld l, a
	ld h, 0
rept 5
	add hl, hl
endr ; * BG_MAP_WIDTH
	ldh a, [hMoveIconCol]
	add l
	ld l, a
	ldh a, [hBGMapAddress]
	add l
	ld l, a
	ldh a, [hBGMapAddress + 1]
	adc h
	ld h, a
	ld bc, wAttrmap - wTilemap
	ld a, MOVE_ICON_TILES
.loop
	push af
	call MoveIcons_WaitHBlank
	ld a, [de] ; tile
	ld [hl], a
	push de
	ld a, e
	add c
	ld e, a
	ld a, d
	adc b
	ld d, a
	ld a, 1
	ldh [rVBK], a
	ld a, [de] ; attribute
	ld [hli], a
	xor a
	ldh [rVBK], a
	pop de
	inc de
	ei
	pop af
	dec a
	jr nz, .loop
	ret

BattleMoveIcons_Restore::
; Give the icon cells back the player's palette once the move menu has
; closed and wTilemap holds the battle scene again.
	ld a, [wAttrmap + BATTLE_MOVE_ICON_Y * SCREEN_WIDTH + BATTLE_MOVE_ICON_X]
	cp PAL_BATTLE_BG_6
	ret nz
	hlcoord BATTLE_MOVE_ICON_X, BATTLE_MOVE_ICON_Y, wAttrmap
	ld a, PAL_BATTLE_BG_PLAYER
	ld bc, MOVE_ICON_TILES
	call ByteFill
	ld a, BATTLE_MOVE_ICON_Y
	ldh [hMoveIconRow], a
	ld a, BATTLE_MOVE_ICON_X
	ldh [hMoveIconCol], a
	call MoveIcons_WaitBelowRow
	jmp MoveIcons_WriteMap

PlazaMoveIcons_Show::
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
	jmp MoveIcons_Show

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

PlazaMoveIcons_Hide::
; Blank the icon cells and give the borrowed palette back to the map,
; when the box is cleared or the menu closes.
	call PlazaMoveIcons_SetCoords
	hlcoord PLAZA_MOVE_ICON_X, PLAZA_MOVE_ICON_Y
	ld a, " "
	ld bc, MOVE_ICON_TILES
	call ByteFill
	hlcoord PLAZA_MOVE_ICON_X, PLAZA_MOVE_ICON_Y, wAttrmap
	ld a, PAL_BG_TEXT
	ld bc, MOVE_ICON_TILES
	call ByteFill
	call MoveIcons_WaitBelowRow
	call MoveIcons_WriteMap

	ld a, [wMoveIconBorrowedPalette]
	and a
	ret z
	call PlazaMoveIcons_Show.PaletteAddress
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

TMHMMoveIcons_Show::
; Show the icons of move [wCurSpecies] as sprites in the TM pocket's move
; info box.
	ld a, [wCurSpecies]
	ld b, a
	call MoveIcons_GetIndices
	ld a, TMHM_MOVE_ICON_Y
	ldh [hMoveIconRow], a
	call MoveIcons_WaitBelowRow

	ld hl, wOBPals2 palette MOVE_ICON_OBJ_PAL
	push hl
	ldh a, [hMoveIconType]
	ld c, a
	ldh a, [hMoveIconCategory]
	ld e, a
	call LoadMoveIconPalette
	pop hl
	lb bc, MOVE_ICON_OBJ_PAL palettes, LOW(rOBPI)
	call MoveIcons_SendPalette

	ld hl, vTiles3 tile MOVE_ICON_OBJ_TILE
	ld b, BANK(vTiles3)
	call MoveIcons_SendTiles

	ld hl, wShadowOAMSprite00 + MOVE_ICON_FIRST_OAM * OBJ_SIZE
	lb bc, (TMHM_MOVE_ICON_X + 1) * TILE_WIDTH, MOVE_ICON_OBJ_TILE
	ld e, MOVE_ICON_TILES
.oam
	ld a, (TMHM_MOVE_ICON_Y + 2) * TILE_WIDTH
	ld [hli], a ; y
	ld a, b
	ld [hli], a ; x
	add TILE_WIDTH
	ld b, a
	ld a, c
	ld [hli], a ; tile
	inc c
	ld a, MOVE_ICON_OBJ_PAL | VRAM_BANK_1
	ld [hli], a
	dec e
	jr nz, .oam
	ret

TMHMMoveIcons_Hide::
; Take the TM pocket's icon sprites away and give OBJ palette 7 back.
	ld hl, wShadowOAMSprite00 + MOVE_ICON_FIRST_OAM * OBJ_SIZE
	ld bc, MOVE_ICON_TILES * OBJ_SIZE
	xor a
	call ByteFill
	ldh a, [rSVBK]
	push af
	ld a, BANK(wOBPals1)
	ldh [rSVBK], a
	ld hl, wOBPals1 palette MOVE_ICON_OBJ_PAL
	ld de, wOBPals2 palette MOVE_ICON_OBJ_PAL
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
