; Type and category icons for moves (from Polished Crystal), shown in the
; battle move menu.

DEF MOVE_ICON_TILES EQU 6 ; 2 category tiles, then 4 type tiles

; In battle the icons use BG tiles $79-$7e (free in battle) and the unused
; BG palette PAL_BATTLE_BG_6. The icon cells only take that palette while
; the move menu is open, so the player's back sprite under the move info
; box keeps its own colours when the menu closes.
DEF BATTLE_MOVE_ICON_TILE EQU $79
DEF BATTLE_MOVE_ICON_X EQU 1
DEF BATTLE_MOVE_ICON_Y EQU 9
; first scanline below the move info box
DEF BATTLE_MOVE_BOX_END_LY EQU 12 * TILE_WIDTH

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
; Fill palette hl (in wBGPals1) for type icon c and category icon e:
; color 0 from palette 0, colors 1-2 the category, color 3 the type.
; Also copies it to the same palette in wBGPals2. The caller has it sent
; to the hardware.
	ldh a, [rSVBK]
	push af
	ld a, BANK(wBGPals1)
	ldh [rSVBK], a
	push hl
	ld a, [wBGPals1]
	ld [hli], a
	ld a, [wBGPals1 + 1]
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

	pop hl ; palette in wBGPals1
	ld de, wBGPals2 - wBGPals1
	add hl, de
	ld d, h
	ld e, l
	ld bc, -(wBGPals2 - wBGPals1)
	add hl, bc
	ld bc, 1 palettes
	call CopyBytes

	pop af
	ldh [rSVBK], a
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

BattleMoveIcons_Draw::
; Show the type and category icons of move b in the battle move info box.
	call GetMoveIconIndices
	push bc
	push de

	hlcoord BATTLE_MOVE_ICON_X, BATTLE_MOVE_ICON_Y
	ld a, BATTLE_MOVE_ICON_TILE
	ld b, MOVE_ICON_TILES
.place
	ld [hli], a
	inc a
	dec b
	jr nz, .place
	hlcoord BATTLE_MOVE_ICON_X, BATTLE_MOVE_ICON_Y, wAttrmap
	ld a, PAL_BATTLE_BG_6
	ld bc, MOVE_ICON_TILES
	call ByteFill

; Change everything while the screen is drawn below the box, so no frame
; shows a mix of the old and new icons, tiles or colours.
	call MoveIcons_WaitBelowBattleBox
	pop de
	pop bc
	push bc
	push de
	ld hl, wBGPals1 palette PAL_BATTLE_BG_6
	call LoadMoveIconPalette

; Write the palette straight to the hardware too: H-Blank time is enough,
; and the next V-Blank doesn't have to send all of them.
	ldh a, [rSVBK]
	push af
	ld a, BANK(wBGPals1)
	ldh [rSVBK], a
	ld hl, wBGPals1 palette PAL_BATTLE_BG_6
	ld b, (1 << rBGPI_AUTO_INCREMENT) | (PAL_BATTLE_BG_6 palettes)
	ld c, 1 palettes
.palette
	call MoveIcons_WaitHBlank
	ld a, b
	ldh [rBGPI], a
	ld a, [hli]
	ldh [rBGPD], a
	ld a, [hli]
	ldh [rBGPD], a
	ei
	inc b
	inc b
	dec c
	dec c
	jr nz, .palette
	pop af
	ldh [rSVBK], a

	pop de
	call GetCategoryIconGFX
	ld hl, vTiles2 tile BATTLE_MOVE_ICON_TILE
	ld c, 2 * LEN_2BPP_TILE
.category
	call MoveIcons_WaitHBlank
	ld a, [de]
	ld [hli], a
	inc de
	ld a, [de]
	ld [hli], a
	inc de
	ei
	dec c
	dec c
	jr nz, .category

	pop bc
	push hl
	call GetTypeIconGFX
	pop hl
	ld c, 4 * LEN_1BPP_TILE
.type
	call MoveIcons_WaitHBlank
	ld a, [de]
	ld [hli], a
	ld [hli], a
	inc de
	ei
	dec c
	jr nz, .type
	; fallthrough

BattleMoveIcons_WriteMap:
; Copy the icon cells' tiles and attributes from wTilemap/wAttrmap to the
; BG map. Interrupts may come in between, so this restores rVBK itself.
	ldh a, [hBGMapAddress]
	add LOW(BATTLE_MOVE_ICON_Y * BG_MAP_WIDTH + BATTLE_MOVE_ICON_X)
	ld l, a
	ldh a, [hBGMapAddress + 1]
	adc HIGH(BATTLE_MOVE_ICON_Y * BG_MAP_WIDTH + BATTLE_MOVE_ICON_X)
	ld h, a
	decoord BATTLE_MOVE_ICON_X, BATTLE_MOVE_ICON_Y
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
	call MoveIcons_WaitBelowBattleBox
	jr BattleMoveIcons_WriteMap

MoveIcons_WaitBelowBattleBox:
	ldh a, [rLCDC]
	bit rLCDC_ENABLE, a
	ret z
.wait
	ldh a, [rLY]
	cp BATTLE_MOVE_BOX_END_LY
	jr nz, .wait
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
