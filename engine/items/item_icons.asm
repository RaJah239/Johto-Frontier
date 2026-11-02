; Item icons in the Pack (each pocket, incl. TMs/HMs) and the Mart buy menu.
; Ported from TimKun55's pokecrystal; most icons are from Polished Crystal.

DEF ITEM_ICON_TILE      EQU $60 ; 9 tiles, $60-$68 (free in the Pack and Mart screens)
DEF PACK_ITEM_ICON_PAL  EQU 7
DEF MART_ITEM_ICON_PAL  EQU 6

UpdateItemIconAndDescription::
	farcall UpdateItemDescription
	ld a, [wMenuSelection]
	ld e, PACK_ITEM_ICON_PAL
	jmp LoadItemIcon

MartUpdateItemIcon::
; Buy menu: the icon sits in the left column's panel (see InitMartLeftColumn).
	ld a, [wMenuSelection]
	ld e, MART_ITEM_ICON_PAL
	jmp LoadItemIcon


DEF ITEM_ICON_PANEL_TILE EQU ITEM_ICON_TILE + 9 ; 9 tiles, $69-$71
	const_def ITEM_ICON_PANEL_TILE
	const PANEL_TOP_LEFT
	const PANEL_TOP
	const PANEL_TOP_RIGHT
	const PANEL_LEFT
	const PANEL_RIGHT
	const PANEL_BOTTOM_LEFT
	const PANEL_BOTTOM
	const PANEL_BOTTOM_RIGHT
	const PANEL_BACKGROUND ; the Pack's checkered background

LoadItemIconPanelGFX::
; The white, outlined 5x5 panel the icon sits in (Polished Crystal style).
	ld de, ItemIconPanelGFX
	ld hl, vTiles2 tile ITEM_ICON_PANEL_TILE
	lb bc, BANK(ItemIconPanelGFX), 9
	jmp Request2bpp

PlacePackItemIconTiles::
; The icon panel fills the left column below the pack picture (rows 6-10,
; above the TM pocket's taller move box, which starts on row 11).
	hlcoord 0, 6
	call PlaceItemIconPanel
	hlcoord 1, 7
	jr PlaceItemIconTiles

PlaceItemIconPanel:
; Place the 5x5 icon panel at hl.
	ld de, SCREEN_WIDTH - 5
	ld a, PANEL_TOP_LEFT
	ld [hli], a
	inc a ; PANEL_TOP
	ld [hli], a
	ld [hli], a
	ld [hli], a
	inc a ; PANEL_TOP_RIGHT
	ld [hli], a
	add hl, de
	ld b, 3
.side
	ld a, PANEL_LEFT
	ld [hli], a
	inc hl
	inc hl
	inc hl
	inc a ; PANEL_RIGHT
	ld [hli], a
	add hl, de
	dec b
	jr nz, .side
	ld a, PANEL_BOTTOM_LEFT
	ld [hli], a
	inc a ; PANEL_BOTTOM
	ld [hli], a
	ld [hli], a
	ld [hli], a
	inc a ; PANEL_BOTTOM_RIGHT
	ld [hl], a
	ret

PlaceItemIconTiles::
; Place the 3x3 icon tiles at hl.
	ld a, ITEM_ICON_TILE
	ld de, SCREEN_WIDTH - 3
	ld b, 3
.row
	ld c, 3
.col
	ld [hli], a
	inc a
	dec c
	jr nz, .col
	add hl, de
	dec b
	jr nz, .row
	ret

InitMartLeftColumn::
; Polished Crystal-style buy menu: a checkered column left of the item list
; (rows 3-11) with the item icon in a panel at its bottom (rows 7-11).
	call LoadItemIconPanelGFX
	hlcoord 0, 3
	ld de, SCREEN_WIDTH - 5
	ld a, PANEL_BACKGROUND
	ld b, 4
.row
	ld c, 5
.col
	ld [hli], a
	dec c
	jr nz, .col
	add hl, de
	dec b
	jr nz, .row
	hlcoord 0, 7
	call PlaceItemIconPanel
	hlcoord 1, 8
	call PlaceItemIconTiles
	hlcoord 1, 8, wAttrmap
	lb bc, 3, 3
	ld a, MART_ITEM_ICON_PAL
	call FillBoxWithByte
	farjp ApplyAttrmap

LoadTMHMIcon::
; wCurSpecies = the TM/HM's move: the disc icon in the move type's colors.
	ld hl, TmHmIcon
	lb bc, BANK(TmHmIcon), 9
	ld de, vTiles2 tile ITEM_ICON_TILE
	call DecompressRequest2bpp
	ld a, [wCurSpecies]
	dec a
	ld hl, Moves + MOVE_TYPE
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld a, BANK(Moves)
	call GetFarByte
	and TYPE_MASK
	cp TYPES_END
	jr c, .got_type
	xor a ; NORMAL
.got_type
	ld l, a
	ld h, 0
	add hl, hl
	add hl, hl
	ld bc, TMHMTypeIconPalettes
	add hl, bc
	ld e, PACK_ITEM_ICON_PAL
	jr LoadItemIconPalette

ClearTMHMIcon::
; Cancel in the TM/HM pocket.
	xor a ; NO_ITEM
	ld e, PACK_ITEM_ICON_PAL
	; fallthrough

LoadItemIcon:
; a = item id (anything above NUM_ITEMS, like -1 for Cancel, shows the
; "no item" icon), e = BG palette to color it with
	cp NUM_ITEMS + 1
	jr c, .got_item
	xor a ; NO_ITEM
.got_item
	push de
	push af
	ld l, a
	ld h, 0
	ld b, h
	ld c, l
	add hl, hl
	add hl, bc
	ld bc, ItemIconPointers
	add hl, bc
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld c, 9
	ld de, vTiles2 tile ITEM_ICON_TILE
	call DecompressRequest2bpp
	pop af
	ld l, a
	ld h, 0
	add hl, hl
	add hl, hl
	ld bc, ItemIconPalettes
	add hl, bc
	pop de
	; fallthrough

LoadItemIconPalette:
; hl = icon colors 1 and 2 (in this bank), e = BG palette.
; Color 0 is white and color 3 black. Written to both palette buffers
; so it shows right away.
	ld a, e
	add a
	add a
	add a
	ld c, a
	ld b, 0
	ldh a, [rSVBK]
	push af
	ld a, BANK(wBGPals1)
	ldh [rSVBK], a
	ld d, h
	ld e, l
	push bc
	ld hl, wBGPals1
	add hl, bc
	call .Copy
	pop bc
	ld hl, wBGPals2
	add hl, bc
	call .Copy
	pop af
	ldh [rSVBK], a
	ld a, TRUE
	ldh [hCGBPalUpdate], a
	ret

.Copy:
	push de
	ld a, LOW(PALRGB_WHITE)
	ld [hli], a
	ld a, HIGH(PALRGB_WHITE)
	ld [hli], a
	ld c, 2 * 2
.loop
	ld a, [de]
	inc de
	ld [hli], a
	dec c
	jr nz, .loop
	xor a
	ld [hli], a
	ld [hl], a
	pop de
	ret

INCLUDE "data/items/icon_pointers.asm"

ItemIconPalettes:
	table_width 2 * 2
INCLUDE "gfx/items/items.pal"
	assert_table_length NUM_ITEMS + 1

TMHMTypeIconPalettes:
	table_width 2 * 2
INCLUDE "gfx/items/tm_hm_types.pal"
	assert_table_length TYPES_END
