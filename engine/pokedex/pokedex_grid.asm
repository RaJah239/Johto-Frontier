; Polished Crystal-style grid Pokedex main screen (the look of Polished
; Crystal's engine/pokedex/pokedex.asm, drawn with JTest's engine).
;
; Top half: the cursor mon's frontpic, its number, name and type labels, and
; the Seen/Own counts. Bottom half: a scrolling grid of 5 x 3 cells, each with
; the mon's icon, its number and a ball if caught, and a scrollbar.
; A on a seen mon opens the normal dex entry screen (DEXSTATE_DEX_ENTRY_SCR),
; whose B comes back here (DEXSTATE_MAIN_SCR); Select/Start open the option
; and search screens as before.
;
; Graphics: frames, scrollbar track and buttons are static tiles; the number
; rows, the top-right info area and the scrollbar are drawn pixel by pixel
; into WRAM canvases (positions measured from Polished Crystal) and copied to
; VRAM bank 1. Icons are 8x16 sprites from VRAM bank 1, coloured with the
; party menu icon palettes. VRAM bank 1 BG tiles $4e and $60-$7f are left
; alone (the entry screen keeps its page numbers and type labels there).
;
; WRAM: the grid's state and canvases are in WRAMX bank 5 (section "Pokedex
; Grid"), the icon staging in WRAMX bank 6 (scratch). The grid's handlers run
; with bank 5 selected; the DexGrid_* wrappers switch to bank 1 for the dex
; flags, base data and names.

DEF DEXGRID_COLS        EQU 5
DEF DEXGRID_ROWS        EQU 3
DEF DEXGRID_CELLS       EQU DEXGRID_COLS * DEXGRID_ROWS
DEF DEXGRID_CELL_W      EQU 30 ; pixels, line to line
DEF DEXGRID_STRIP_W     EQU 19 ; tiles per number row (columns 0-18)
DEF DEXGRID_TOP_W       EQU 12 ; tiles per top-right canvas row (columns 8-19)
DEF DEXGRID_TOP_X       EQU 64 ; screen x of the top-right canvases
DEF DEXGRID_OVERLAY_W   EQU 5  ; overlay tiles per row

DEF DEXGRID_NUMROW_TILE  EQU $00 ; 3 x 19
DEF DEXGRID_OVERLAY_TILE EQU $39 ; 2 x 5 icon-row tiles, then 5 bottom-row tiles
DEF DEXGRID_TOP_TILE     EQU $80 ; 5 x 12: rows 0, 2, 3, 6, 7
DEF DEXGRID_SCROLL_TILE  EQU $c8 ; 9 (column 19, rows 8-16)
DEF DEXGRID_STATIC_TILE  EQU $d1

; BG palettes
DEF PAL_DEXGRID_GRID     EQU 0 ; white, light gray, red, black
DEF PAL_DEXGRID_PIC      EQU 1
DEF PAL_DEXGRID_TYPES    EQU 2 ; white, type 1, type 2, black
DEF PAL_DEXGRID_BLUE     EQU 3 ; white, light gray, blue, black
DEF PAL_DEXGRID_REDBLUE  EQU 4 ; white, red, blue, light gray (cursor over blue)
; DexGrid_Redraw modes
DEF DEXGRID_REDRAW_CURSOR EQU 0 ; only the cursor moved
DEF DEXGRID_REDRAW_ALL    EQU 1 ; on entry
DEF DEXGRID_REDRAW_DOWN   EQU 2 ; scrolled down a row
DEF DEXGRID_REDRAW_UP     EQU 3 ; scrolled up a row

DEF DEXGRID_SEEN_F       EQU 0 ; wDexGridCellFlags
DEF DEXGRID_CAUGHT_F     EQU 1
DEF DEXGRID_FADED_F      EQU 7 ; icon palette key: seen but not caught
DEF DEXGRID_OBJ_PALS     EQU 8

DEF DEXGRID_THUMB_TOP    EQU 69 ; scrollbar thumb y range (screen)
DEF DEXGRID_THUMB_RANGE  EQU 55

; Shift tables for DexGrid_PutRow (this section is 256-byte aligned):
; page s of DexGridShrTable is v >> s, of DexGridShlTable (v << (8 - s)) & $ff.
DexGridShrTable:
FOR DEXGRID_S, 8
	FOR DEXGRID_V, 256
		db DEXGRID_V >> DEXGRID_S
	ENDR
ENDR
DexGridShlTable:
FOR DEXGRID_S, 8
	FOR DEXGRID_V, 256
		db (DEXGRID_V << (8 - DEXGRID_S)) & $ff
	ENDR
ENDR

Pokedex_InitGridScreen::
	ldh a, [rSVBK]
	push af
	ld a, BANK(wDexGridIndex)
	ldh [rSVBK], a
	call .Init
	pop af
	ldh [rSVBK], a
	ret

.Init:
	xor a
	ldh [hBGMapMode], a
	call ClearSprites
	ld a, 7
	ld [wDexListingHeight], a ; the dex entry screen's up/down uses it
	xor a
	ldh [hSCX], a
	ldh [hSCY], a
	ld a, $a7
	ldh [hWX], a
	ld a, $90
	ldh [hWY], a

	; the selected index is the listing position (the dex entry screen's
	; up/down may have moved it)
	ld a, [wDexListingScrollOffset]
	ld hl, wDexListingCursor
	add [hl]
	call DexGrid_ClampIndex
	ld [wDexGridIndex], a
	call DexGrid_ScrollToIndex

	call DexGrid_LoadStaticGFX
	call DexGrid_SetStaticPalettes
	call DexGrid_DrawCounts
	ld a, TRUE
	ld [wDexGridFullTilemap], a
	ld a, DEXGRID_REDRAW_ALL
	call DexGrid_Redraw

	ldh a, [rLCDC]
	set rLCDC_SPRITE_SIZE, a
	ldh [rLCDC], a

	ld hl, wJumptableIndex
	inc [hl]
	ret

Pokedex_UpdateGridScreen::
	ldh a, [rSVBK]
	push af
	ld a, BANK(wDexGridIndex)
	ldh [rSVBK], a
	call .Update
	pop af
	ldh [rSVBK], a
	ret

.Update:
	ld hl, hJoyPressed
	ld a, [hl]
	and B_BUTTON
	jp nz, .b
	ld a, [hl]
	and A_BUTTON
	jr nz, .a
	ld a, [hl]
	and SELECT
	jr nz, .select
	ld a, [hl]
	and START
	jr nz, .start

	ld a, [wDexGridTopRow]
	ld [wDexGridPrevTopRow], a
	call DexGrid_HandleDPad
	jr c, .moved
	; no move this frame: draw the top half if a move left it behind
	ld a, [wDexGridTopPending]
	and a
	ret z
	jmp DexGrid_DrawTopHalf

.moved
	ld a, [wDexGridPrevTopRow]
	ld hl, wDexGridTopRow
	sub [hl] ; old - new
	ld a, DEXGRID_REDRAW_CURSOR
	jr z, .redraw
	ld a, [wDexGridPrevTopRow]
	inc a
	cp [hl]
	ld a, DEXGRID_REDRAW_DOWN
	jr z, .redraw
	ld a, [wDexGridPrevTopRow]
	dec a
	cp [hl]
	ld a, DEXGRID_REDRAW_UP
	jr z, .redraw
	ld a, DEXGRID_REDRAW_ALL
.redraw
	jmp DexGrid_Redraw

.a
	call DexGrid_GetIndexSpecies
	and a
	ret z
	ld b, a
	call DexGrid_IsSeen
	ret z
	ld a, BANK(wCurPartySpecies)
	ldh [rSVBK], a
	ld a, b
	ld [wTempSpecies], a
	ld [wCurPartySpecies], a
	ld a, BANK(wDexGridIndex)
	ldh [rSVBK], a
	call DexGrid_Leave
	ld a, POKEDEX_SCX
	ldh [hSCX], a
	ld a, DEXSTATE_DEX_ENTRY_SCR
	ld [wJumptableIndex], a
	ld a, DEXSTATE_MAIN_SCR
	ld [wPrevDexEntryJumptableIndex], a
	ret

.select
	ld a, DEXSTATE_OPTION_SCR
	jr .other_screen

.start
	ld a, DEXSTATE_SEARCH_SCR
.other_screen
	push af
	call DexGrid_Leave
	newfarcall Pokedex_BlackOutBG
	pop af
	ld [wJumptableIndex], a
	xor a
	ldh [hSCX], a
	ld a, $a7
	ldh [hWX], a
	jmp DelayFrame

.b
	call DexGrid_Leave
	ld a, DEXSTATE_EXIT
	ld [wJumptableIndex], a
	ret

DexGrid_Leave:
; Back to 8x8 sprites, no sprites and plain attributes for the other screens.
	ldh a, [rLCDC]
	res rLCDC_SPRITE_SIZE, a
	ldh [rLCDC], a
	hlcoord 0, 0, wAttrmap
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	xor a
	call ByteFill
	jmp ClearSprites

; ---------------------------------------------------------------------------
; Cursor and list position
; ---------------------------------------------------------------------------

DexGrid_ClampIndex:
; a = index -> a = index clamped to the list (0 if the list is empty).
	ld b, a
	ld a, [wDexListingEnd]
	and a
	ret z
	dec a
	cp b
	ret c ; past the end: last entry
	ld a, b
	ret

DexGrid_DivMod5:
; a -> c = a / 5, a = a % 5. Preserves b, de, hl.
	ld c, -1
.loop
	inc c
	sub DEXGRID_COLS
	jr nc, .loop
	add DEXGRID_COLS
	ret

DexGrid_NumRows:
; a = rows in the list (at least 1). Preserves b, de, hl.
	ld a, [wDexListingEnd]
	add DEXGRID_COLS - 1
	jr c, .big
	call DexGrid_DivMod5
	ld a, c
	and a
	ret nz
	inc a
	ret
.big
	ld a, (255 + DEXGRID_COLS - 1) / DEXGRID_COLS
	ret

DexGrid_MaxTopRow:
; a = the highest top row (rows - 3, at least 0). Preserves b, de, hl.
	call DexGrid_NumRows
	sub DEXGRID_ROWS
	ret nc
	xor a
	ret

DexGrid_ScrollToIndex:
; Make the row of wDexGridIndex visible, keeping the top row if it already is.
	ld a, [wDexGridIndex]
	call DexGrid_DivMod5 ; c = row
	ld hl, wDexGridTopRow
	ld a, c
	cp [hl]
	jr c, .set ; above the view
	ld a, [hl]
	add DEXGRID_ROWS - 1
	cp c
	jr nc, .clamp ; inside the view
	ld a, c
	sub DEXGRID_ROWS - 1
.set
	ld [hl], a
.clamp
	call DexGrid_MaxTopRow
	ld hl, wDexGridTopRow
	cp [hl]
	ret nc
	ld [hl], a
	ret

DexGrid_HandleDPad:
; Move the cursor with the D-pad (with key repeat). Carry if it moved.
	ld a, [wDexListingEnd]
	and a
	ret z
	ld a, [wDexGridIndex]
	ld d, a
	call DexGrid_DivMod5
	ld e, a ; column
	ld b, c ; row
	ld hl, hJoyLast
	ld a, [hl]
	and D_RIGHT
	jr nz, .right
	ld a, [hl]
	and D_LEFT
	jr nz, .left
	ld a, [hl]
	and D_UP
	jr nz, .up
	ld a, [hl]
	and D_DOWN
	jr nz, .down
	and a
	ret

.right
	ld a, e
	cp DEXGRID_COLS - 1
	jr nc, .no
	ld a, d
	inc a
	ld hl, wDexListingEnd
	cp [hl]
	jr nc, .no
	jr .moved

.left
	ld a, e
	and a
	jr z, .no
	ld a, d
	dec a
	jr .moved

.up
	ld a, d
	sub DEXGRID_COLS
	jr c, .no
	jr .moved

.down
	; the next row, or its last entry if it is shorter
	call DexGrid_NumRows
	dec a
	cp b
	jr z, .no
	jr c, .no
	ld a, d
	add DEXGRID_COLS
	call DexGrid_ClampIndex
	; fallthrough

.moved
	ld [wDexGridIndex], a
	call DexGrid_ScrollToIndex
	scf
	ret

.no
	and a
	ret

DexGrid_SetListingFromIndex:
; Keep wDexListingScrollOffset + wDexListingCursor = wDexGridIndex, in the
; form the listing code (and the dex entry screen's up/down) expects.
	ld a, [wDexListingEnd]
	ld c, a
	ld a, [wDexGridIndex]
	ld b, a
	ld a, c
	cp 8
	jr c, .one_page
	sub 7 ; highest scroll offset
	cp b
	jr c, .near_end
	ld a, b
	ld [wDexListingScrollOffset], a
	xor a
	ld [wDexListingCursor], a
	ret

.near_end
	ld [wDexListingScrollOffset], a
	ld c, a
	ld a, b
	sub c
	ld [wDexListingCursor], a
	ret

.one_page
	xor a
	ld [wDexListingScrollOffset], a
	ld a, b
	ld [wDexListingCursor], a
	ret

DexGrid_GetIndexSpecies:
; a = the species at wDexGridIndex (0 if none).
	ld a, [wDexGridIndex]
	; fallthrough

DexGrid_GetListSpecies:
; a = list index -> a = species there (0 past the end). Preserves bc.
	ld hl, wDexListingEnd
	cp [hl]
	jr nc, .none
	ld e, a
	ld d, 0
	ld hl, wPokedexOrder
	add hl, de
	ld a, [hl]
	ret

.none
	xor a
	ret

DexGrid_GetCellSpecies:
; a = cell (0-14) -> a = species shown there (0 if none). Preserves b.
	ld c, a
	ld a, [wDexGridTopRow]
	ld e, a
	add a
	add a
	add e ; top row * 5
	add c
	jr nc, DexGrid_GetListSpecies
	xor a
	ret

DexGrid_IsSeen:
; nz if species a is seen. Preserves bc, de, hl.
	push hl
	ld hl, CheckSeenMon
	jr DexGrid_CheckFlag

DexGrid_IsCaught:
; nz if species a is caught. Preserves bc, de, hl.
	push hl
	ld hl, CheckCaughtMon
DexGrid_CheckFlag:
	push de
	push bc
	dec a
	ld c, a
	ldh a, [rSVBK]
	ld b, a
	ld a, BANK(wPokedexSeen)
	ldh [rSVBK], a
	ld a, c
	push bc
	call _hl_
	pop bc
	ld a, b
	ldh [rSVBK], a ; (ld and ldh leave the flags alone)
	pop bc
	pop de
	pop hl
	ret

DexGrid_CountFlags:
; a = number of set bits in the b bytes at hl (WRAM bank 1).
	ldh a, [rSVBK]
	push af
	ld a, BANK(wPokedexSeen)
	ldh [rSVBK], a
	call CountSetBits
	ld b, a
	pop af
	ldh [rSVBK], a
	ld a, b
	ret

DexGrid_GetName:
; a = species -> wDexGridName = its name ("@"-terminated).
	ld b, a
	ldh a, [rSVBK]
	push af
	ld a, BANK(wNamedObjectIndex)
	ldh [rSVBK], a
	ld a, b
	ld [wNamedObjectIndex], a
	call GetPokemonName ; de = name (WRAM bank 1)
	ld hl, wDexGridName
	ld c, MON_NAME_LENGTH
.loop
	ld a, BANK(wStringBuffer1)
	ldh [rSVBK], a
	ld a, [de]
	inc de
	ld b, a
	ld a, BANK(wDexGridName)
	ldh [rSVBK], a
	ld [hl], b
	inc hl
	dec c
	jr nz, .loop
	pop af
	ldh [rSVBK], a
	ret

DexGrid_GetTypeIndexes:
; c = type label index of wDexGridSpecies's type 1, b = type 2's.
	ld a, [wDexGridSpecies]
	ld [wCurSpecies], a
	ldh a, [rSVBK]
	push af
	ld a, BANK(wBaseType1)
	ldh [rSVBK], a
	call GetBaseData
	ld a, [wBaseType1]
	ld d, a
	ld a, [wBaseType2]
	ld e, a
	pop af
	ldh [rSVBK], a
	ld c, e
	predef GetMonTypeIndex
	ld b, c
	ld c, d
	predef GetMonTypeIndex
	ret

; ---------------------------------------------------------------------------
; Graphics and palettes
; ---------------------------------------------------------------------------

DexGrid_LoadStaticGFX:
	ld a, 1
	ldh [rVBK], a
	ld de, DexGridStaticGFX
	ld hl, vTiles1 tile (DEXGRID_STATIC_TILE - $80)
	lb bc, BANK(DexGridStaticGFX), DEXGRID_NUM_STATIC_TILES
	call Get2bpp
	xor a
	ldh [rVBK], a
	ret

DexGrid_SetStaticPalettes:
	ld hl, DexGridPalGrid
	ld de, wBGPals1 palette PAL_DEXGRID_GRID
	call .copy
	ld hl, DexGridPalBlue
	ld de, wBGPals1 palette PAL_DEXGRID_BLUE
	call .copy
	ld hl, DexGridPalRedOnBlue
	ld de, wBGPals1 palette PAL_DEXGRID_REDBLUE
	call .copy
	ret

.copy
	ld bc, 1 palettes
	ld a, BANK(wBGPals1)
	jmp FarCopyWRAM

DexGrid_SetMonPalettes:
; Palettes of the cursor mon: its picture and its type labels.
	call DexGrid_IsCursorSeen
	jr z, .unseen
	ld a, [wDexGridSpecies]
	ld de, wBGPals1 palette PAL_DEXGRID_PIC
	newfarcall LoadDexGridMonPalette

	; types: white, type 1, type 2, black
	ld hl, DexGridPalTypesBase
	ld de, wBGPals1 palette PAL_DEXGRID_TYPES
	call DexGrid_SetStaticPalettes.copy
	call DexGrid_GetTypeIndexes
	push bc
	ld de, wBGPals1 palette PAL_DEXGRID_TYPES + 2
	newfarcall LoadMonBaseTypePal ; c = type 1
	pop bc
	ld c, b
	ld de, wBGPals1 palette PAL_DEXGRID_TYPES + 4
	newfarcall LoadMonBaseTypePal ; type 2
	ret

.unseen
	ld hl, DexGridPalUnseen
	ld de, wBGPals1 palette PAL_DEXGRID_PIC
	jp DexGrid_SetStaticPalettes.copy

; ---------------------------------------------------------------------------
; Drawing
; ---------------------------------------------------------------------------

DexGrid_Redraw:
; Redraw the screen for wDexGridIndex / wDexGridTopRow; a = DEXGRID_REDRAW_*.
; The grid is drawn in WRAM, then copied to VRAM in one go just after the next
; VBlank, before the LCD gets to it. The top half is left to
; DexGrid_DrawTopHalf on the next frame without a move (so the cursor keeps
; up with the D-pad), except on entry.
	ld [wDexGridReloadIcons], a
	ld a, [wDexGridT0]
	ld [wDexGridOldT0], a
	ld a, [wDexGridTCount]
	ld [wDexGridOldTCount], a
	ld a, [wDexGridCursorRow]
	ld [wDexGridOldCursorRow], a
	call DexGrid_CursorCell
	call DexGrid_DivMod5
	ld [wDexGridCellCol], a
	ld a, c
	ld [wDexGridCursorRow], a
	call DexGrid_ComputeT0
	call DexGrid_SetListingFromIndex

	ld a, [wDexGridReloadIcons]
	and a
	jr z, .cursor
	call DexGrid_BuildCellCache
	call DexGrid_RenderStrips
	call DexGrid_DrawScrollbar
	call DexGrid_LoadIcons
	; the new OAM and icon palettes must go out with the new icon tiles
	ld a, TRUE
	ldh [hOAMUpdate], a
	call DexGrid_UpdateOAM
.cursor
	call DexGrid_DrawPatches
	ld a, [wDexGridFullTilemap]
	and a
	jr nz, .entry
	call DexGrid_BuildTilemap
	ld a, [wDexGridReloadIcons]
	and a
	jr z, .commit
	lb de, $e4, $e4
	call DmgToCgbObjPals
	xor a
	ldh [hOAMUpdate], a
.commit
	call DelayFrame
	call DexGrid_CommitGrid
	ld a, TRUE
	ld [wDexGridTopPending], a
	ret

.entry
; The previous screen (blacked out, or the dex entry) stays up until the
; grid's tilemap goes to the BG map: the grid's palettes and OAM wait to go
; out in the same frame, so the previous screen never shows in the grid's
; colours (its green background would turn red).
	ld a, TRUE
	call DexGrid_BuildTilemap
	call DexGrid_CommitGrid
	call DexGrid_DrawTopHalf ; (leaves the palettes to us)
	ld a, $e4
	call DmgToCgbBGPals
	lb de, $e4, $e4
	call DmgToCgbObjPals
	ld b, 3 | 1 << 2 ; tiles, attributes, the palettes and OAM in one frame
	newfarcall _SafeCopyTilemapAtOnce
	xor a
	ld [wDexGridFullTilemap], a
	ret

DexGrid_ComputeT0:
; The cursor box's tile columns (wDexGridCellCol's cell):
; t0 = left / 8, count = (left + 30) / 8 - t0 + 1
	call DexGrid_CellLeft
	ld b, a
	srl a
	srl a
	srl a
	ld [wDexGridT0], a
	ld c, a
	ld a, b
	add DEXGRID_CELL_W
	srl a
	srl a
	srl a
	sub c
	inc a
	ld [wDexGridTCount], a
	ret

DexGrid_DrawTopHalf:
; The cursor mon's frontpic, palettes, number, name and types. Everything is
; prepared first, then copied while the LCD draws the lower half of the
; screen, and the palettes go out at the next VBlank, so the new picture
; shows up in one frame with its own colours.
	xor a
	ld [wDexGridTopPending], a
	call DexGrid_GetIndexSpecies
	ld [wDexGridSpecies], a
	call DexGrid_PrepareFrontpic
	call DexGrid_SetMonPalettes
	call DexGrid_DrawTop
	call DexGrid_WaitLowerScreen
	ld a, BANK(sScratch)
	call OpenSRAM
	ld a, [wDexGridPicSource]
	ld e, a
	ld a, [wDexGridPicSource + 1]
	ld d, a
	ld hl, vTiles2
	lb bc, 0, 7 * 7
	call Get2bpp
	call CloseSRAM
	ld de, wDexGridHeader
	ld hl, vTiles1 tile (DEXGRID_TOP_TILE - $80)
	ld c, DEXGRID_TOP_W
	call DexGrid_Upload
	ld de, wDexGridTopA
	ld hl, vTiles1 tile (DEXGRID_TOP_TILE - $80 + DEXGRID_TOP_W)
	ld c, 2 * DEXGRID_TOP_W
	call DexGrid_Upload
	ld a, [wDexGridFullTilemap]
	and a
	ret nz ; on entry, DexGrid_Redraw applies the palettes after the tilemap
	ld a, $e4
	jmp DmgToCgbBGPals

DexGrid_WaitLowerScreen:
; Wait until the LCD is on lines 64-99 (below the picture, with time to copy
; it before the next VBlank).
.loop
	ldh a, [rLY]
	cp 8 * 8
	jr c, .loop
	cp 100
	jr nc, .loop
	ret

DexGrid_PrepareFrontpic:
; Decompress the cursor mon's frontpic (or the question mark) into SRAM;
; wDexGridPicSource = where (SRAM bank 0).
	call DexGrid_IsCursorSeen
	jr z, .question_mark
	ld a, [wDexGridSpecies]
	ld [wCurSpecies], a
	ld b, a
	ldh a, [rSVBK]
	push af
	ld a, BANK(wCurPartySpecies)
	ldh [rSVBK], a
	ld a, b
	ld [wCurPartySpecies], a
	ld a, [wFirstUnownSeen]
	ld [wUnownLetter], a
	newfarcall PrepareFrontpic
	call CloseSRAM
	pop af
	ldh [rSVBK], a
	ld hl, sPaddedEnemyFrontpic
	jr .done

.question_mark
	ld a, BANK(sScratch)
	call OpenSRAM
	newfarcall LoadQuestionMarkPic
	call CloseSRAM
	ld hl, sScratch
.done
	ld a, l
	ld [wDexGridPicSource], a
	ld a, h
	ld [wDexGridPicSource + 1], a
	ret

DexGrid_CommitGrid:
; Copy the grid's prepared tiles to VRAM: all the number rows, scrollbar and
; icons if they were redrawn (else just the old cursor's tiles from the clean
; rows), then the cursor's tiles and the overlay, and the tilemap rows that
; changed.
	ld a, [wDexGridReloadIcons]
	and a
	jr z, .restore
	ld de, wDexGridCleanStrips
	ld hl, vTiles2 tile DEXGRID_NUMROW_TILE
	ld c, DEXGRID_ROWS * DEXGRID_STRIP_W
	call DexGrid_Upload
	ld de, wDexGridScroll
	ld hl, vTiles1 tile (DEXGRID_SCROLL_TILE - $80)
	ld c, 9
	call DexGrid_Upload
	ldh a, [rSVBK]
	push af
	ld a, BANK(wDexGridIcons)
	ldh [rSVBK], a
	ld de, wDexGridIcons
	ld hl, vTiles0
	ld c, DEXGRID_CELLS * 4
	call DexGrid_Upload
	pop af
	ldh [rSVBK], a
	jr .patches

.restore
	ld a, [wDexGridOldCursorRow]
	call .restore_row
	ld a, [wDexGridOldCursorRow]
	inc a
	call .restore_row

.patches
	ld a, [wDexGridCursorRow]
	ld de, wDexGridPatch
	call .upload_patch
	ld a, [wDexGridCursorRow]
	inc a
	cp DEXGRID_ROWS
	jr nc, .overlay
	ld de, wDexGridPatch + DEXGRID_OVERLAY_W tiles
	call .upload_patch
.overlay
	ld de, wDexGridOverlay
	ld hl, vTiles2 tile DEXGRID_OVERLAY_TILE
	ld c, 3 * DEXGRID_OVERLAY_W
	call DexGrid_Upload
	ld a, [wDexGridPushOld]
	cp -1
	call nz, DexGrid_PushOverlayRows
	ld a, [wDexGridPushNew]
	cp -1
	ret z
	jp DexGrid_PushOverlayRows

.restore_row
; number row a's old cursor tiles, from the clean copy
	cp DEXGRID_ROWS
	ret nc
	ld hl, wDexGridOldT0
	call DexGrid_StripTileIndex ; hl = tile index
	push hl
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, hl
	ld de, wDexGridCleanStrips
	add hl, de
	ld d, h
	ld e, l
	pop hl
	call .vram_tile
	ld a, [wDexGridOldTCount]
	ld c, a
	jp DexGrid_Upload

.upload_patch
; patch tiles at de -> number row a, cursor tiles
	push de
	ld hl, wDexGridT0
	call DexGrid_StripTileIndex
	call .vram_tile
	pop de
	ld a, [wDexGridTCount]
	ld c, a
	jp DexGrid_Upload

.vram_tile
; hl = address of number row tile hl
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, hl
	ld bc, vTiles2 tile DEXGRID_NUMROW_TILE
	add hl, bc
	ret

DexGrid_StripTileIndex:
; a = number row, [hl] = tile column -> hl = row * 19 + column. Preserves de.
	ld c, [hl]
	ld b, 0
	ld hl, 0
	push bc
	ld bc, DEXGRID_STRIP_W
	call AddNTimes
	pop bc
	add hl, bc
	ret

DexGrid_DrawPatches:
; The cursor box's tiles in the number rows: its number row with the top edge
; and sides, and the next number row with the bottom edge (the last row's is
; in the overlay), from the clean rows into wDexGridPatch.
	call DexGrid_CursorCell
	call DexGrid_DivMod5
	ld [wDexGridCellCol], a
	ld a, 2 ; red
	ld [wDexGridColor], a
	ld a, [wDexGridCursorRow]
	ld de, wDexGridPatch
	call .copy
	ld hl, wDexGridPatch
	call .edges
	call DexGrid_CursorSides
	ld a, [wDexGridCursorRow]
	inc a
	cp DEXGRID_ROWS
	ret nc
	ld de, wDexGridPatch + DEXGRID_OVERLAY_W tiles
	call .copy
	ld hl, wDexGridPatch + DEXGRID_OVERLAY_W tiles
	; fallthrough

.edges
; two red rows (y 0-1) line to line on the patch at hl; returns d = left line
	ld a, [wDexGridTCount]
	call DexGrid_SetCanvas
	call DexGrid_OverlayLeft
	ld d, a
	ld e, 0
	ld b, DEXGRID_CELL_W + 1
	call DexGrid_HLine
	inc e
	ld b, DEXGRID_CELL_W + 1
	jp DexGrid_HLine

.copy
; number row a's cursor tiles from the clean copy to de
	push de
	ld hl, wDexGridT0
	call DexGrid_StripTileIndex
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, hl
	ld bc, wDexGridCleanStrips
	add hl, bc
	pop de
	ld a, [wDexGridTCount]
	swap a ; * 16
	ld c, a
	ld b, 0
	jp CopyBytes

DexGrid_BuildCellCache:
; wDexGridCellMon / wDexGridCellFlags for the 15 visible cells.
	xor a
.loop
	ld [wDexGridCell], a
	call DexGrid_GetCellSpecies
	ld b, a
	ld c, 0
	and a
	jr z, .store
	call DexGrid_IsSeen
	jr z, .store
	set DEXGRID_SEEN_F, c
	ld a, b
	call DexGrid_IsCaught
	jr z, .store
	set DEXGRID_CAUGHT_F, c
.store
	ld a, [wDexGridCell]
	ld e, a
	ld d, 0
	ld hl, wDexGridCellMon
	add hl, de
	ld [hl], b
	ld hl, wDexGridCellFlags
	add hl, de
	ld [hl], c
	ld a, [wDexGridCell]
	inc a
	cp DEXGRID_CELLS
	jr c, .loop
	ret

DexGrid_CellInfo:
; a = cell -> a = species (0 if none), c = flags. Preserves b, de, hl.
	push hl
	push de
	ld e, a
	ld d, 0
	ld hl, wDexGridCellFlags
	add hl, de
	ld c, [hl]
	ld hl, wDexGridCellMon
	add hl, de
	ld a, [hl]
	pop de
	pop hl
	ret

DexGrid_Upload:
; Copy c tiles at de (WRAM, 16-byte aligned: GDMA) to VRAM bank 1 at hl.
	ld a, 1
	ldh [rVBK], a
	ldh a, [hROMBank]
	ld b, a
	call Get2bpp
	xor a
	ldh [rVBK], a
	ret

DexGrid_SetCanvas:
; hl = canvas base, a = width in tiles
	push hl
	ld [wDexGridCanvasW], a
	ld a, l
	ld [wDexGridCanvas], a
	ld a, h
	ld [wDexGridCanvas + 1], a
	; stride (bytes per tile row) = width * 16
	ld a, [wDexGridCanvasW]
	ld l, a
	ld h, 0
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, hl
	ld a, l
	ld [wDexGridStride], a
	ld a, h
	ld [wDexGridStride + 1], a
	pop hl
	ret

MACRO dexgrid_apply_row
; d = shift table page: look up wDexGridRowMask/Lo/Hi there and write them
; into the 2 bytes at hl (plane 0, plane 1); hl ends at plane 1.
	ld a, [wDexGridRowMask]
	ld e, a
	ld a, [de]
	cpl
	ld c, a ; ~mask
	ld a, [wDexGridRowLo]
	ld e, a
	ld a, [de]
	ld b, a
	ld a, c
	and [hl]
	or b
	ld [hli], a
	ld a, [wDexGridRowHi]
	ld e, a
	ld a, [de]
	ld b, a
	ld a, c
	and [hl]
	or b
	ld [hl], a
ENDM

DexGrid_PutRow:
; Write one 8-pixel row into the current canvas at pixel (d, e): pixels set
; in wDexGridRowMask get colour bits wDexGridRowLo / wDexGridRowHi, the
; others are left alone. Spills into the next tile to the right.
; Preserves bc, de, hl.
	push bc
	push de
	push hl
	ld a, [wDexGridCanvas]
	ld l, a
	ld a, [wDexGridCanvas + 1]
	ld h, a
	; + (x / 8) * 16
	ld a, d
	and %11111000
	ld c, a
	ld b, 0
	sla c
	rl b
	add hl, bc
	; + (y % 8) * 2
	ld a, e
	and %111
	add a
	ld c, a
	ld b, 0
	add hl, bc
	; + (y / 8) * stride
	ld a, e
	and %11111000
	jr z, .got_row
	rrca
	rrca
	rrca
	ld e, a
	ld a, [wDexGridStride]
	ld c, a
	ld a, [wDexGridStride + 1]
	ld b, a
.row_loop
	add hl, bc
	dec e
	jr nz, .row_loop
.got_row
	; left tile: values >> shift
	ld a, d
	and %111
	ld c, a ; shift
	add HIGH(DexGridShrTable)
	ld d, a
	push bc
	dexgrid_apply_row
	pop bc
	; right tile: values << (8 - shift), if any pixel spills
	ld a, c
	and a
	jr z, .done
	add HIGH(DexGridShlTable)
	ld d, a
	ld a, [wDexGridRowMask]
	ld e, a
	ld a, [de]
	and a
	jr z, .done
	ld bc, 1 tiles - 1
	add hl, bc ; (hl was at plane 1)
	dexgrid_apply_row
.done
	pop hl
	pop de
	pop bc
	ret

DexGrid_SetRowColor:
; a = pattern, wDexGridColor = colour (0-3) -> mask/lo/hi for DexGrid_PutRow.
; Preserves bc, de, hl.
	push bc
	ld [wDexGridRowMask], a
	ld b, a
	ld a, [wDexGridColor]
	ld c, a
	xor a
	bit 0, c
	jr z, .lo
	ld a, b
.lo
	ld [wDexGridRowLo], a
	xor a
	bit 1, c
	jr z, .hi
	ld a, b
.hi
	ld [wDexGridRowHi], a
	pop bc
	ret

DexGrid_HLine:
; Colour wDexGridColor from (d, e), b pixels to the right, a tile at a time.
; Preserves de, hl.
	push de
	push hl
.loop
	; n = pixels left in this tile, at most b
	ld a, d
	and %111
	ld c, a
	ld a, 8
	sub c
	cp b
	jr c, .got_n
	ld a, b
.got_n
	ld c, a
	push bc
	ld b, 0
	ld hl, .LeadingOnes
	add hl, bc
	ld a, [hl]
	call DexGrid_SetRowColor
	call DexGrid_PutRow
	pop bc
	ld a, d
	add c
	ld d, a
	ld a, b
	sub c
	ld b, a
	jr nz, .loop
	pop hl
	pop de
	ret

.LeadingOnes:
	db %00000000, %10000000, %11000000, %11100000, %11110000
	db %11111000, %11111100, %11111110, %11111111

DexGrid_BlitGlyph:
; Draw the 8x8 1bpp glyph in wDexGridGlyph at (d, e) in colour wDexGridColor
; (its blank pixels are left alone). Preserves de.
	ld a, e
	and %111
	jr z, .fast
	push de
	ld hl, wDexGridGlyph
	ld b, 8
.loop
	ld a, [hli]
	and a
	jr z, .next
	call DexGrid_SetRowColor
	call DexGrid_PutRow
.next
	inc e
	dec b
	jr nz, .loop
	pop de
	ret

.fast
; y is a multiple of 8: the glyph's rows all go in the same tile row, so the
; address is worked out once.
	push de
	ld a, [wDexGridCanvas]
	ld l, a
	ld a, [wDexGridCanvas + 1]
	ld h, a
	; + (x / 8) * 16
	ld a, d
	and %11111000
	ld c, a
	ld b, 0
	sla c
	rl b
	add hl, bc
	; + (y / 8) * stride
	ld a, e
	and a
	jr z, .got_row
	rrca
	rrca
	rrca
	ld e, a
	ld a, [wDexGridStride]
	ld c, a
	ld a, [wDexGridStride + 1]
	ld b, a
.row_loop
	add hl, bc
	dec e
	jr nz, .row_loop
.got_row
	ld a, d
	and %111
	ld b, a ; shift
	ld a, [wDexGridColor]
	ld c, a
	ld de, wDexGridGlyph
	ld a, 8
.fast_row
	push af
	ld a, [de]
	inc de
	and a
	jr z, .fast_next
	push de
	ld e, a
	ld a, b
	add HIGH(DexGridShrTable)
	ld d, a
	ld a, [de] ; left tile bits
	call .apply
	ld a, b
	and a
	jr z, .no_spill
	add HIGH(DexGridShlTable)
	ld d, a
	ld a, [de] ; right tile bits
	and a
	jr z, .no_spill
	push hl
	push bc
	ld bc, 1 tiles
	add hl, bc
	pop bc
	call .apply
	pop hl
.no_spill
	pop de
.fast_next
	inc hl
	inc hl
	pop af
	dec a
	jr nz, .fast_row
	pop de
	ret

.apply
; set the bits in a to colour c in the row at hl (plane 0, plane 1).
; Preserves bc, de, hl.
	push de
	ld e, a
	cpl
	ld d, a
	ld a, [hl]
	and d
	bit 0, c
	jr z, .plane0
	or e
.plane0
	ld [hli], a
	ld a, [hl]
	and d
	bit 1, c
	jr z, .plane1
	or e
.plane1
	ld [hld], a
	pop de
	ret

DexGrid_BlitBall:
; Draw the caught ball (2bpp) at (d, e). Preserves de.
	push de
	ld hl, DexGridBallGFX
	ld b, 8
.loop
	ld a, [hli]
	ld [wDexGridRowLo], a
	ld c, a
	ld a, [hli]
	ld [wDexGridRowHi], a
	or c
	ld [wDexGridRowMask], a
	call DexGrid_PutRow
	inc e
	dec b
	jr nz, .loop
	pop de
	ret

DexGrid_LoadFontGlyph:
; Copy the standard font glyph of character a to wDexGridGlyph.
	sub $80
	ld l, a
	ld h, 0
	add hl, hl
	add hl, hl
	add hl, hl
	ld bc, Font
	add hl, bc
	ld de, wDexGridGlyph
	ld bc, 8
	ld a, BANK(Font)
	jmp FarCopyBytes

DexGrid_DrawFontString:
; Draw the "@"-terminated string at hl in the standard font from (d, e),
; 8 pixels per character, at most c characters. Spaces are skipped.
.loop
	ld a, [hli]
	cp "@"
	ret z
	push hl
	push bc
	push de
	cp " "
	jr z, .skip
	call DexGrid_LoadFontGlyph
	pop de
	push de
	call DexGrid_BlitGlyph
.skip
	pop de
	pop bc
	pop hl
	ld a, d
	add 8
	ld d, a
	dec c
	jr nz, .loop
	ret

DexGrid_LoadVWFGlyph:
; Copy the VWF glyph of character a to wDexGridGlyph; a = its width.
	sub FIRST_VWF_CHAR
	jr nc, .valid
	ld a, FAILSAFE_VWF_CHAR - FIRST_VWF_CHAR
.valid
	push af
	ld l, a
	ld h, 0
	add hl, hl
	add hl, hl
	add hl, hl
	ld bc, VWFCharacterGFX
	add hl, bc
	ld de, wDexGridGlyph
	ld bc, 8
	ld a, BANK(VWFCharacterGFX)
	call FarCopyBytes
	pop af
	ld c, a
	ld b, 0
	ld hl, VWFWidths
	add hl, bc
	ld a, BANK(VWFWidths)
	jmp GetFarByte

DexGrid_NumberString:
; a = number -> wDexGridNumBuf = 3 digits with leading zeros + "@"
	ld hl, wDexGridNumBuf
	ld c, 100
	call .digit
	ld c, 10
	call .digit
	add "0"
	ld [hli], a
	ld [hl], "@"
	ret

.digit
	ld b, "0" - 1
.digit_loop
	inc b
	sub c
	jr nc, .digit_loop
	add c
	ld [hl], b
	inc hl
	ret

DexGrid_DrawVWFNumber:
; Draw wDexGridNumBuf in the VWF font, right-aligned to x = d (exclusive),
; at y = e, colour wDexGridColor.
	push de
	ld hl, wDexGridNumBuf
	ld b, 0
.width_loop
	ld a, [hli]
	cp "@"
	jr z, .got_width
	push hl
	push bc
	call DexGrid_LoadVWFGlyph
	pop bc
	pop hl
	add b
	ld b, a
	jr .width_loop
.got_width
	pop de
	ld a, d
	sub b
	ld d, a
	ld hl, wDexGridNumBuf
.draw_loop
	ld a, [hli]
	cp "@"
	ret z
	push hl
	push de
	call DexGrid_LoadVWFGlyph
	pop de
	push af
	call DexGrid_BlitGlyph
	pop af
	add d
	ld d, a
	pop hl
	jr .draw_loop

DexGrid_DrawTop:
; The top-right canvases: number (row 0), name and type labels (rows 2-3),
; Seen/Own counts (rows 6-7). Rows 1, 4 and 5 are static.
	ld hl, DexGridTopGFX
	ld de, wDexGridHeader
	ld bc, DEXGRID_TOP_W tiles
	call CopyBytes
	ld hl, DexGridTopGFX + 2 * DEXGRID_TOP_W tiles
	ld de, wDexGridTopA
	ld bc, 2 * DEXGRID_TOP_W tiles
	call CopyBytes
	ld a, 3 ; black
	ld [wDexGridColor], a

	; number (shown even if unseen)
	ld hl, wDexGridHeader
	ld a, DEXGRID_TOP_W
	call DexGrid_SetCanvas
	ld a, [wDexGridSpecies]
	call DexGrid_NumberString
	ld hl, wDexGridNumBuf
	lb de, 92 - DEXGRID_TOP_X, 0
	ld c, 3
	call DexGrid_DrawFontString

	; name
	ld hl, wDexGridTopA
	ld a, DEXGRID_TOP_W
	call DexGrid_SetCanvas
	call DexGrid_IsCursorSeen
	jr z, .unseen
	ld a, [wDexGridSpecies]
	call DexGrid_GetName
	ld hl, wDexGridName
	jr .got_name
.unseen
	ld hl, DexGrid_UnseenName
.got_name
	lb de, 69 - DEXGRID_TOP_X, 16 - 16
	ld c, MON_NAME_LENGTH - 1
	call DexGrid_DrawFontString

	; type labels (row 3 = canvas A row 1)
	call DexGrid_IsCursorSeen
	jr z, .upload
	call DexGrid_GetTypeIndexes
	push bc
	ld a, c
	ld hl, TypeLightIconGFX
	ld de, wDexGridTopA + DEXGRID_TOP_W tiles
	call DexGrid_CopyTypeLabel
	pop bc
	ld a, b
	cp c
	jr z, .border
	ld hl, TypeDarkIconGFX
	ld de, wDexGridTopA + (DEXGRID_TOP_W + 4) tiles
	call DexGrid_CopyTypeLabel
.border
	; the first label covers the box's left border: put it back
	ld hl, wDexGridTopA + DEXGRID_TOP_W tiles
	ld b, 8 * 2
.border_loop
	set 7, [hl]
	inc hl
	dec b
	jr nz, .border_loop

.upload
	ret ; (DexGrid_DrawTopHalf copies rows 0 and 2-3 to VRAM)

DexGrid_DrawCounts:
; The Seen/Own counts (rows 6-7); they don't change while the grid is shown.
	ld hl, DexGridTopGFX + 6 * DEXGRID_TOP_W tiles
	ld de, wDexGridTopB
	ld bc, 2 * DEXGRID_TOP_W tiles
	call CopyBytes
	ld a, 3 ; black
	ld [wDexGridColor], a
	ld hl, wDexGridTopB
	ld a, DEXGRID_TOP_W
	call DexGrid_SetCanvas
	ld hl, wPokedexSeen
	ld b, wEndPokedexSeen - wPokedexSeen
	call DexGrid_CountFlags
	ld d, 84 - DEXGRID_TOP_X
	call .count
	ld hl, wPokedexCaught
	ld b, wEndPokedexCaught - wPokedexCaught
	call DexGrid_CountFlags
	ld d, 134 - DEXGRID_TOP_X
	call .count
	ld de, wDexGridTopB
	ld hl, vTiles1 tile (DEXGRID_TOP_TILE - $80 + 3 * DEXGRID_TOP_W)
	ld c, 2 * DEXGRID_TOP_W
	jmp DexGrid_Upload

.count
; a = count, right-aligned in a 3-digit field from x = d
	push de
	call DexGrid_NumberString
	pop de
	ld hl, wDexGridNumBuf
	ld c, 2 ; the last digit always shows
.lead
	ld a, [hl]
	cp "0"
	jr nz, .lead_done
	ld [hl], " "
	inc hl
	dec c
	jr nz, .lead
.lead_done
	ld hl, wDexGridNumBuf
	ld e, 52 - 48
	ld c, 3
	jmp DexGrid_DrawFontString

DexGrid_UnseenName:
	db "?????@"

DexGrid_IsCursorSeen:
; nz if the cursor is on a seen mon.
	ld a, [wDexGridSpecies]
	and a
	ret z
	jmp DexGrid_IsSeen

DexGrid_CopyTypeLabel:
; Copy type label a (4 tiles of the gfx at hl, in BANK(TypeLightIconGFX)) to
; the canvas at de, its text (colour 3) made white (colour 0) for the white,
; type 1, type 2, black palette.
	push de
	ld bc, 4 tiles
	call AddNTimes
	pop de
	push de
	ld bc, 4 tiles
	ld a, BANK(TypeLightIconGFX)
	call FarCopyBytes
	pop hl
	ld b, 4 * 8
.loop
	ld a, [hli] ; plane 0
	ld c, a
	ld a, [hld] ; plane 1
	and c       ; colour 3 pixels
	cpl
	ld e, a
	and c
	ld [hli], a
	ld a, [hl]
	and e
	ld [hli], a
	dec b
	jr nz, .loop
	ret

DexGrid_RenderStrips:
; Draw the three number rows' numbers and caught balls (no cursor) into
; wDexGridCleanStrips. After a one-row scroll, two of them are just moved.
	ld a, [wDexGridReloadIcons]
	cp DEXGRID_REDRAW_DOWN
	jr z, .down
	cp DEXGRID_REDRAW_UP
	jr z, .up
	xor a
.all_loop
	push af
	call .row
	pop af
	inc a
	cp DEXGRID_ROWS
	jr c, .all_loop
	ret

.down
	ld hl, wDexGridCleanStrips + DEXGRID_STRIP_W tiles
	ld de, wDexGridCleanStrips
	ld bc, 2 * DEXGRID_STRIP_W tiles
	call CopyBytes
	ld a, 2
	jr .row

.up
	ld hl, wDexGridCleanStrips + DEXGRID_STRIP_W tiles
	ld de, wDexGridCleanStrips + 2 * DEXGRID_STRIP_W tiles
	ld bc, DEXGRID_STRIP_W tiles
	call CopyBytes
	ld hl, wDexGridCleanStrips
	ld de, wDexGridCleanStrips + DEXGRID_STRIP_W tiles
	ld bc, DEXGRID_STRIP_W tiles
	call CopyBytes
	xor a
	; fallthrough

.row
	ld [wDexGridStripRow], a
	ld hl, wDexGridCleanStrips
	ld bc, DEXGRID_STRIP_W tiles
	call AddNTimes
	push hl
	ld d, h
	ld e, l
	ld hl, DexGridNumRowGFX
	ld bc, DEXGRID_STRIP_W tiles
	call CopyBytes
	pop hl
	ld a, DEXGRID_STRIP_W
	call DexGrid_SetCanvas

	xor a
.col_loop
	ld [wDexGridCellCol], a
	ld b, a
	ld a, [wDexGridStripRow]
	ld c, a
	add a
	add a
	add c ; row * 5
	add b
	call DexGrid_CellInfo
	and a
	jr z, .next_col
	ld [wDexGridCellSpecies], a
	ld b, 1 ; gray
	bit DEXGRID_SEEN_F, c
	jr z, .got_color
	bit DEXGRID_CAUGHT_F, c
	jr z, .got_color
	call DexGrid_CellLeft
	add 4
	ld d, a
	ld e, 1
	call DexGrid_BlitBall
	ld b, 3 ; caught: black
.got_color
	ld a, b
	ld [wDexGridColor], a
	ld a, [wDexGridCellSpecies]
	call DexGrid_NumberString
	call DexGrid_CellLeft
	add 28
	ld d, a
	ld e, 0
	call DexGrid_DrawVWFNumber
.next_col
	ld a, [wDexGridCellCol]
	inc a
	cp DEXGRID_COLS
	jr c, .col_loop
	ret

DexGrid_CursorSides:
; Draw the cursor box's sides (x = d, d + 1, d + 29, d + 30) over y 0-7 of the
; current canvas.
	ld a, %11000000
	call DexGrid_SetRowColor
	ld e, 0
.loop
	call DexGrid_PutRow
	push de
	ld a, d
	add DEXGRID_CELL_W - 1
	ld d, a
	call DexGrid_PutRow
	pop de
	inc e
	ld a, e
	cp 8
	jr nz, .loop
	ret

DexGrid_CellLeft:
; a = x of the left line of column wDexGridCellCol (1 + 30 * col). Clobbers b.
	ld a, [wDexGridCellCol]
	ld b, a
	add a
	add a
	add a
	add a ; 16
	sub b ; 15
	add a ; 30
	inc a
	ret

DexGrid_CursorCell:
; a = cell of the cursor (0-14). Clobbers b.
	ld a, [wDexGridTopRow]
	ld b, a
	add a
	add a
	add b
	ld b, a
	ld a, [wDexGridIndex]
	sub b
	ret

DexGrid_DrawScrollbar:
	ld hl, DexGridScrollGFX
	ld de, wDexGridScroll
	ld bc, 9 tiles
	call CopyBytes
	; thumb y = top + top row * range / max top row
	call DexGrid_MaxTopRow
	and a
	ld e, DEXGRID_THUMB_TOP
	jr z, .got_y
	ld c, a ; divisor
	ld a, [wDexGridTopRow]
	ld b, a
	ld hl, 0
	ld de, DEXGRID_THUMB_RANGE
.mul
	ld a, b
	and a
	jr z, .mul_done
	add hl, de
	dec b
	jr .mul
.mul_done
	ld e, -1
	ld b, 0
.div
	inc e
	ld a, l
	sub c
	ld l, a
	ld a, h
	sbc b
	ld h, a
	jr nc, .div
	ld a, e
	add DEXGRID_THUMB_TOP
	ld e, a
.got_y
	; 8 rows: black, 6 x (black, blue x 6, black), black
	ld a, e
	sub 8 * 8 ; the canvas starts at y 64
	ld e, a
	ld c, 8
.thumb
	ld a, e
	srl a
	srl a
	srl a
	ld l, a
	ld h, 0
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, hl
	ld a, e
	and 7
	add a
	add l
	ld l, a
	ld a, h
	adc HIGH(wDexGridScroll)
	ld h, a
	ld a, l
	add LOW(wDexGridScroll)
	ld l, a
	jr nc, .no_carry
	inc h
.no_carry
	ld a, c
	cp 8
	jr z, .solid
	cp 1
	jr z, .solid
	ld a, %10000001
	jr .write
.solid
	ld a, $ff
.write
	ld [hli], a
	ld [hl], $ff
	inc e
	dec c
	jr nz, .thumb
	ret

DexGrid_BuildTilemap:
; The static tilemap and attrmap, with the cursor box's sides in the icon
; rows (and its bottom edge in the bottom row) drawn on overlay tiles.
; a = TRUE: build the whole screen (the caller copies it to the BG map);
; FALSE: put back the old cursor's cells, overlay the new ones, and copy just
; the rows that changed to the BG map.
	and a
	jr z, .partial
	ld hl, DexGridStaticTilemap
	decoord 0, 0
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	call CopyBytes
	ld hl, DexGridStaticAttrmap
	decoord 0, 0, wAttrmap
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	call CopyBytes
	call .no_push
	jp DexGrid_ApplyOverlay

.partial
	call DexGrid_RestoreOverlay
	call DexGrid_ApplyOverlay
	call .no_push
	ld a, [wDexGridOldCursorRow]
	ld hl, wDexGridCursorRow
	cp [hl]
	jr nz, .moved
	ld a, [wDexGridOldT0]
	ld hl, wDexGridT0
	cp [hl]
	ret z ; same cells: only the overlay tiles' graphics changed
.moved
	; DexGrid_CommitGrid copies these rows to the BG map
	ld a, [wDexGridOldCursorRow]
	ld [wDexGridPushOld], a
	ld hl, wDexGridCursorRow
	cp [hl]
	ret z
	ld a, [hl]
	ld [wDexGridPushNew], a
	ret

.no_push
	ld a, -1
	ld [wDexGridPushOld], a
	ld [wDexGridPushNew], a
	ret

DexGrid_RestoreOverlay:
; Put the static tiles back where the old cursor's overlay was.
	ld a, [wDexGridOldCursorRow]
	cp DEXGRID_ROWS
	ret nc
	ld b, a
	add a
	add b
	add 9
	push af
	call .row
	pop af
	inc a
	call .row
	ld a, [wDexGridOldCursorRow]
	cp DEXGRID_ROWS - 1
	ret nz
	ld a, SCREEN_HEIGHT - 1
.row
; screen row a, columns old t0 to old t0 + old count - 1
	ld hl, 0
	ld bc, SCREEN_WIDTH
	call AddNTimes
	ld a, [wDexGridOldT0]
	ld c, a
	ld b, 0
	add hl, bc
	push hl
	ld bc, DexGridStaticTilemap
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	push hl
	ld bc, wTilemap
	add hl, bc
	call .copy
	pop hl
	push hl
	ld bc, DexGridStaticAttrmap
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	ld bc, wAttrmap
	add hl, bc
.copy
; copy old count bytes from de to hl
	ld a, [wDexGridOldTCount]
	ld c, a
.copy_loop
	ld a, [de]
	inc de
	ld [hli], a
	dec c
	jr nz, .copy_loop
	ret

DexGrid_PushOverlayRows:
; Copy the screen rows of cursor row a's overlay to the BG map.
	ld b, a
	add a
	add b
	add 9
	push af
	call DexGrid_PushRow
	pop af
	inc a
	call DexGrid_PushRow
	ld a, [wDexGridCursorRow]
	cp DEXGRID_ROWS - 1
	jr z, .bottom
	ld a, [wDexGridOldCursorRow]
	cp DEXGRID_ROWS - 1
	ret nz
.bottom
	ld a, SCREEN_HEIGHT - 1
	; fallthrough

DexGrid_PushRow:
; Copy screen row a of wTilemap and wAttrmap to the BG map, in HBlanks.
	push af
	ld hl, wTilemap
	ld bc, SCREEN_WIDTH
	call AddNTimes
	pop af
	push hl
	ld l, a
	ld h, 0
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, hl
	ldh a, [hBGMapAddress]
	ld e, a
	ldh a, [hBGMapAddress + 1]
	ld d, a
	add hl, de
	ld d, h
	ld e, l
	pop hl
	push de
	push hl
	xor a
	ldh [rVBK], a
	call .copy
	pop hl
	ld bc, wAttrmap - wTilemap
	add hl, bc
	pop de
	ld a, 1
	ldh [rVBK], a
	call .copy
	xor a
	ldh [rVBK], a
	ret

.copy
; 20 bytes from hl to de, 10 per HBlank
	ld c, SCREEN_WIDTH / 10
.chunk
.wait_mode3
	ldh a, [rSTAT]
	and %11
	cp 3
	jr nz, .wait_mode3
	di
.wait_hblank
	ldh a, [rSTAT]
	and %11
	jr nz, .wait_hblank
	REPT 10
	ld a, [hli]
	ld [de], a
	inc de
	ENDR
	ei
	dec c
	jr nz, .chunk
	ret

DexGrid_ApplyOverlay:
	call DexGrid_CursorCell
	call DexGrid_DivMod5
	ld [wDexGridCellCol], a

	; icon rows: screen rows 9 + 3 * row and 10 + 3 * row
	ld a, 2
	ld [wDexGridColor], a
	xor a
.icon_row_loop
	ld [wDexGridOverlayRow], a
	ld a, [wDexGridCursorRow]
	ld b, a
	add a
	add b
	add 9
	ld hl, wDexGridOverlayRow
	add [hl]
	call DexGrid_CopyOverlayRow
	ld a, [wDexGridOverlayRow]
	ld hl, wDexGridOverlay
	ld bc, DEXGRID_OVERLAY_W tiles
	call AddNTimes
	ld a, DEXGRID_OVERLAY_W
	call DexGrid_SetCanvas
	call DexGrid_OverlayLeft
	ld d, a
	call DexGrid_CursorSides
	ld a, [wDexGridOverlayRow]
	inc a
	cp 2
	jr c, .icon_row_loop

	; the bottom edge on the bottom row if the cursor is in the last row
	ld a, [wDexGridCursorRow]
	cp DEXGRID_ROWS - 1
	jr nz, .upload
	ld a, 2
	ld [wDexGridOverlayRow], a
	ld a, SCREEN_HEIGHT - 1
	call DexGrid_CopyOverlayRow
	ld hl, wDexGridOverlay + 2 * DEXGRID_OVERLAY_W tiles
	ld a, DEXGRID_OVERLAY_W
	call DexGrid_SetCanvas
	call DexGrid_OverlayLeft
	ld d, a
	ld b, DEXGRID_CELL_W + 1
.bottom_loop
	; red is colour 2 on the grid palette, 1 on red-over-blue
	push bc
	ld a, d
	srl a
	srl a
	srl a
	ld c, a
	ld b, 0
	ld hl, wDexGridOverlayPal
	add hl, bc
	ld a, [hl]
	cp PAL_DEXGRID_REDBLUE
	ld a, 2
	jr nz, .got_red
	dec a
.got_red
	ld [wDexGridColor], a
	pop bc
	; n = pixels left in this tile, at most b
	ld a, d
	and %111
	ld c, a
	ld a, 8
	sub c
	cp b
	jr c, .got_n
	ld a, b
.got_n
	ld c, a
	push bc
	ld b, c
	ld e, 0
	call DexGrid_HLine
	pop bc
	push bc
	ld b, c
	ld e, 1
	call DexGrid_HLine
	pop bc
	ld a, d
	add c
	ld d, a
	ld a, b
	sub c
	ld b, a
	jr nz, .bottom_loop

.upload
	ret

DexGrid_OverlayLeft:
; a = canvas x of the cursor's left line on the overlay (left - t0 * 8)
	call DexGrid_CellLeft
	ld b, a
	ld a, [wDexGridT0]
	add a
	add a
	add a
	ld c, a
	ld a, b
	sub c
	ret

DexGrid_CopyOverlayRow:
; a = screen row: copy its static tiles t0.. to overlay row
; wDexGridOverlayRow and point the tilemap there. Blue-palette tiles (bottom
; row) become red-over-blue tiles (light gray moved to colour 3).
	ld hl, 0
	ld bc, SCREEN_WIDTH
	call AddNTimes
	ld a, [wDexGridT0]
	ld c, a
	ld b, 0
	add hl, bc
	ld a, l
	ld [wDexGridMapOffset], a
	ld a, h
	ld [wDexGridMapOffset + 1], a
	xor a
	ld [wDexGridTmp], a ; overlay column
.loop
	; overlay tile index k = row * 5 + column
	ld a, [wDexGridOverlayRow]
	ld b, a
	add a
	add a
	add b
	ld b, a
	ld a, [wDexGridTmp]
	add b
	ld [wDexGridTmp + 1], a
	; de = overlay tile k
	ld l, a
	ld h, 0
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, hl
	ld bc, wDexGridOverlay
	add hl, bc
	ld d, h
	ld e, l
	; source: the static tile at this position
	call .MapOffset
	ld bc, wTilemap
	add hl, bc
	ld a, [hl]
	sub DEXGRID_STATIC_TILE
	ld l, a
	ld h, 0
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, hl
	ld bc, DexGridStaticGFX
	add hl, bc
	ld bc, 1 tiles
	push de
	call CopyBytes
	pop de
	; its palette
	call .MapOffset
	ld bc, wAttrmap
	add hl, bc
	ld a, [hl]
	and PALETTE_MASK
	cp PAL_DEXGRID_BLUE
	jr nz, .got_pal
	; light gray (colour 1) -> colour 3, on the red-over-blue palette
	push hl
	ld h, d
	ld l, e
	ld b, 8
.remap
	ld a, [hli] ; plane 0
	ld c, a
	ld a, [hl]  ; plane 1
	cpl
	and c       ; colour 1 pixels
	or [hl]
	ld [hli], a
	dec b
	jr nz, .remap
	pop hl
	ld a, [hl]
	and ~PALETTE_MASK
	or PAL_DEXGRID_REDBLUE
	ld [hl], a
.got_pal
	ld a, [hl]
	and PALETTE_MASK
	ld b, a
	ld a, [wDexGridTmp]
	ld e, a
	ld d, 0
	ld hl, wDexGridOverlayPal
	add hl, de
	ld [hl], b
	; tilemap entry
	call .MapOffset
	ld bc, wTilemap
	add hl, bc
	ld a, [wDexGridTmp + 1]
	add DEXGRID_OVERLAY_TILE
	ld [hl], a
	; next
	ld a, [wDexGridTmp]
	inc a
	ld [wDexGridTmp], a
	ld hl, wDexGridTCount
	cp [hl]
	jp c, .loop
	ret

.MapOffset:
; hl = wDexGridMapOffset + overlay column
	ld a, [wDexGridMapOffset]
	ld l, a
	ld a, [wDexGridMapOffset + 1]
	ld h, a
	ld a, [wDexGridTmp]
	ld c, a
	ld b, 0
	add hl, bc
	ret

; ---------------------------------------------------------------------------
; Icons
; ---------------------------------------------------------------------------

DexGrid_LoadIcons:
; Copy the icons of the visible seen cells (frame 1, reordered for 8x16
; sprites: top-left, bottom-left, top-right, bottom-right) to WRAM bank 6,
; then to VRAM bank 1 OBJ tiles (cell n: tiles 4n-4n+3).
	xor a
.loop
	ld [wDexGridCell], a
	call DexGrid_CellInfo
	bit DEXGRID_SEEN_F, c
	jr z, .next
	ld [wDexGridCellSpecies], a
	; source
	ld a, [wDexGridCellSpecies]
	ld l, a
	ld h, 0
	add hl, hl
	ld bc, IconPointers
	add hl, bc
	ld a, BANK(IconPointers)
	call GetFarWord ; hl = icon gfx
	ld a, [wDexGridCellSpecies]
	cp MANKEY ; first species in "Mon Icons 2"
	ld a, BANK("Mon Icons 1")
	jr c, .got_bank
	ld a, BANK("Mon Icons 2")
.got_bank
	ld [wDexGridTmp], a
	; destination
	push hl
	ld a, [wDexGridCell]
	ld l, a
	ld h, 0
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, hl ; * 64
	ld bc, wDexGridIcons
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	ld a, [wDexGridTmp]
	ld b, a
	ldh a, [rSVBK]
	push af
	ld a, BANK(wDexGridIcons)
	ldh [rSVBK], a
	ld c, 0
	call .tile ; top-left
	ld c, 2
	call .tile ; bottom-left
	ld c, 1
	call .tile ; top-right
	ld c, 3
	call .tile ; bottom-right
	pop af
	ldh [rSVBK], a
.next
	ld a, [wDexGridCell]
	inc a
	cp DEXGRID_CELLS
	jr c, .loop
	ret

.tile
; copy tile c of the icon at hl (bank b) to de, advancing de
	push hl
	push bc
	swap c ; c * 16
	ld a, c
	ld c, b ; bank
	add l
	ld l, a
	jr nc, .no_carry
	inc h
.no_carry
	ld a, c
	ld bc, 1 tiles
	call FarCopyBytes
	pop bc
	pop hl
	ret

DexGrid_UpdateOAM:
; Two 8x16 sprites per visible seen mon; the rest hidden. Each icon gets an
; OBJ palette for its party menu icon colour, faded (halfway to white, like
; Polished Crystal) if the mon is seen but not caught; the palettes are
; handed out as needed, 8 at most.
	ld hl, wDexGridPalKeys
	ld a, -1
	ld bc, DEXGRID_OBJ_PALS
	call ByteFill
	ld hl, wShadowOAM
	xor a
.loop
	ld [wDexGridCell], a
	call DexGrid_CellInfo
	bit DEXGRID_SEEN_F, c
	jr z, .hide
	ld [wDexGridCellSpecies], a
	ld a, c
	ld [wDexGridTmp + 1], a
	; palette key: icon colour, + faded if only seen
	ld a, [wDexGridCellSpecies]
	dec a
	ld c, a
	ld b, 0
	push hl
	ld hl, MonMenuIconPals
	add hl, bc
	ld a, BANK(MonMenuIconPals)
	call GetFarByte
	swap a ; normal palette in the high nibble
	and $f
	ld b, a
	ld a, [wDexGridTmp + 1]
	bit DEXGRID_CAUGHT_F, a
	jr nz, .caught
	set DEXGRID_FADED_F, b
.caught
	call DexGrid_GetPalSlot
	pop hl
	or VRAM_BANK_1
	ld [wDexGridTmp], a
	; y = 24 * row + 72 + 16, x = 30 * col + 1 + 7 + 8
	ld a, [wDexGridCell]
	call DexGrid_DivMod5
	ld [wDexGridCellCol], a
	ld a, c
	add a
	add c ; 3 * row
	add a
	add a
	add a ; 24 * row
	add 72 + 16
	ld d, a
	call DexGrid_CellLeft
	add 7 + 8
	ld e, a
	ld a, [wDexGridCell]
	add a
	add a
	ld c, a ; tile
	ld a, d
	ld [hli], a
	ld a, e
	ld [hli], a
	ld a, c
	ld [hli], a
	ld a, [wDexGridTmp]
	ld [hli], a
	ld a, d
	ld [hli], a
	ld a, e
	add 8
	ld [hli], a
	ld a, c
	add 2
	ld [hli], a
	ld a, [wDexGridTmp]
	ld [hli], a
	jr .next

.hide
	xor a
	ld [hli], a
	inc hl
	inc hl
	inc hl
	ld [hli], a
	inc hl
	inc hl
	inc hl
.next
	ld a, [wDexGridCell]
	inc a
	cp DEXGRID_CELLS
	jp c, .loop
	; hide the other sprites
	ld b, NUM_SPRITE_OAM_STRUCTS - DEXGRID_CELLS * 2
	xor a
.clear
	ld [hli], a
	inc hl
	inc hl
	inc hl
	dec b
	jr nz, .clear
	; fall through

DexGrid_LoadIconPals:
; Fill the OBJ palettes from wDexGridPalKeys.
	xor a
.loop
	ld [wDexGridTmp], a
	ld e, a
	ld d, 0
	ld hl, wDexGridPalKeys
	add hl, de
	ld a, [hl]
	cp -1
	jr z, .next
	ld b, a
	; de = wOBPals1 + slot * 8
	ld a, e
	add a
	add a
	add a
	add LOW(wOBPals1)
	ld e, a
	ld a, 0
	adc HIGH(wOBPals1)
	ld d, a
	push bc
	push de
	; hl = PartyMenuOBPals + colour * 8
	ld a, b
	and %1111
	ld l, a
	ld h, 0
	add hl, hl
	add hl, hl
	add hl, hl
	ld bc, PartyMenuOBPals
	add hl, bc
	ld bc, 1 palettes
	ld a, BANK(PartyMenuOBPals)
	call FarCopyBytes ; (wOBPals1 is in this WRAM bank)
	pop hl
	pop bc
	bit DEXGRID_FADED_F, b
	jr z, .next
	ld c, NUM_PAL_COLORS
.fade
	call DexGrid_FadeColor
	dec c
	jr nz, .fade
.next
	ld a, [wDexGridTmp]
	inc a
	cp DEXGRID_OBJ_PALS
	jr c, .loop
	ret

DexGrid_FadeColor:
; Move the colour at hl halfway to white (each channel c -> (c + 32) / 2);
; hl advances to the next colour. Preserves bc.
	push bc
	ld a, [hli]
	ld e, a
	ld a, [hld]
	ld d, a
	; red: bits 0-4 of e
	ld a, e
	and %11111
	call .fade
	ld b, a ; r'
	; green: bits 5-7 of e, 0-1 of d
	ld a, d
	and %11
	ld c, a
	ld a, e
	and %11100000
	or c
	rlca
	rlca
	rlca ; %gggxxx gg -> rotate: g in bits 0-4
	and %11111
	call .fade
	ld c, a ; g'
	; blue: bits 2-6 of d
	ld a, d
	rrca
	rrca
	and %11111
	call .fade
	; d' = b' << 2 | g' >> 3
	add a
	add a
	ld d, a
	ld a, c
	srl a
	srl a
	srl a
	or d
	ld d, a
	; e' = g' << 5 | r'
	ld a, c
	swap a
	add a
	and %11100000
	or b
	ld [hli], a
	ld [hl], d
	inc hl
	pop bc
	ret

.fade
	add 32
	srl a
	ret

DexGrid_GetPalSlot:
; b = palette key -> a = its OBJ palette slot (handed out if new; slot 0 if
; all 8 are taken). Preserves hl.
	push hl
	ld hl, wDexGridPalKeys
	ld c, 0
.find
	ld a, [hl]
	cp b
	jr z, .found
	cp -1
	jr z, .new
	inc hl
	inc c
	ld a, c
	cp DEXGRID_OBJ_PALS
	jr c, .find
	xor a
	pop hl
	ret
.new
	ld [hl], b
.found
	ld a, c
	pop hl
	ret

; ---------------------------------------------------------------------------
; Data
; ---------------------------------------------------------------------------

DexGridPalRedOnBlue:
	RGB 31, 31, 31
	RGB 26, 10,  6
	RGB 11, 14, 31
	RGB 23, 23, 23

DexGridPalTypesBase:
	RGB 31, 31, 31
	RGB 31, 31, 31
	RGB 31, 31, 31
	RGB  0,  0,  0

DexGridPalUnseen:
; the question mark pic: a gray "?" on white (its background is colour 3)
	RGB 31, 31, 31
	RGB 23, 23, 23
	RGB 14, 14, 14
	RGB 31, 31, 31

INCLUDE "gfx/pokedex/grid_layout.asm"

	ds align[4]
DexGridStaticGFX:
INCBIN "gfx/pokedex/grid_static.2bpp"
DexGridTopGFX:
INCBIN "gfx/pokedex/grid_top.2bpp"
DexGridNumRowGFX:
INCBIN "gfx/pokedex/grid_numrow.2bpp"
DexGridScrollGFX:
INCBIN "gfx/pokedex/grid_scroll.2bpp"
DexGridBallGFX:
INCBIN "gfx/pokedex/grid_ball.2bpp"
