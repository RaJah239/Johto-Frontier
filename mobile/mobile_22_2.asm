Function8b342::
; Loads the map data pointer, then runs through a
; dw with three dummy functions. Spends a lot of energy
; doing pretty much nothing.
	call GetMapAttributesPointer
	ld d, h
	ld e, l

; Everything between here and "ret" is useless.
	xor a
.loop
	push af
	ld hl, .dw
	rst JumpTable
	pop af
	inc a
	cp 3
	jr nz, .loop
	ret

.dw
	dw .zero
	dw .one
	dw .two

.zero
	ret

.one
	ret

.two
	ret

Function8b677:
	call ClearBGPalettes
	call DisableLCD
	call Function8b690
	call Function8b6bb
	call Function8b6ed
	call EnableLCD
	call Function891ab
	call SetDefaultBGPAndOBP
	ret

Function8b690:
	ld hl, MobileCardListGFX
	ld de, vTiles2
	ld bc, $16 tiles
	ld a, BANK(MobileCardListGFX)
	call FarCopyBytes
	ld hl, MobileCardListGFX tile $15
	ld de, vTiles2 tile $61
	ld bc, 1 tiles
	ld a, BANK(MobileCardListGFX)
	call FarCopyBytes
	ld hl, MobileCardListGFX tile $16
	ld de, vTiles0 tile $ee
	ld bc, 1 tiles
	ld a, BANK(MobileCardListGFX)
	call FarCopyBytes
	ret

Function8b6bb:
	ldh a, [rSVBK]
	push af
	ld a, $5
	ldh [rSVBK], a
	ld hl, Palette_8b6d5
	ld de, wBGPals1
	ld bc, 3 palettes
	call CopyBytes
	pop af
	ldh [rSVBK], a
	call Function8949c
	ret

Palette_8b6d5:
	RGB 31, 31, 31
	RGB 31, 21, 00
	RGB 14, 07, 03
	RGB 00, 00, 00
	RGB 31, 31, 31
	RGB 31, 21, 00
	RGB 22, 09, 17
	RGB 00, 00, 00
	RGB 31, 31, 31
	RGB 31, 21, 00
	RGB 06, 24, 08
	RGB 00, 00, 00

Function8b6ed:
	hlcoord 0, 0, wAttrmap
	ld bc, $012c
	xor a
	call ByteFill
	hlcoord 0, 14, wAttrmap
	ld bc, $0050
	ld a, $7
	call ByteFill
	ret

Function8b703:
	call Mobile22_SetBGMapMode0
	push hl
	ld a, $c
	ld [hli], a
	inc a
	call Function8b73e
	inc a
	ld [hl], a
	pop hl
	push hl
	push bc
	ld de, SCREEN_WIDTH
	add hl, de
.asm_8b717
	push hl
	ld a, $f
	ld [hli], a
	ld a, $7f
	call Function8b73e
	ld a, $11
	ld [hl], a
	pop hl
	ld de, SCREEN_WIDTH
	add hl, de
	dec b
	jr nz, .asm_8b717
	call Function8b732
	pop bc
	pop hl
	jr Function8b744

Function8b732:
	ld a, $12
	ld [hli], a
	ld a, $13
	call Function8b73e
	ld a, $14
	ld [hl], a
	ret

Function8b73e:
	ld d, c
.asm_8b73f
	ld [hli], a
	dec d
	jr nz, .asm_8b73f
	ret

Function8b744:
	ld de, wAttrmap - wTilemap
	add hl, de
	inc b
	inc b
	inc c
	inc c
	xor a
.asm_8b74d
	push bc
	push hl
.asm_8b74f
	ld [hli], a
	dec c
	jr nz, .asm_8b74f
	pop hl
	ld de, SCREEN_WIDTH
	add hl, de
	pop bc
	dec b
	jr nz, .asm_8b74d
	ret

Function8b75d:
	call Mobile22_SetBGMapMode0
	hlcoord 0, 0
	ld a, $1
	ld bc, SCREEN_WIDTH
	call ByteFill
	hlcoord 0, 1
	ld a, $2
	ld [hl], a
	hlcoord 9, 1
	ld c, $b
	call Function8b788
	hlcoord 1, 1
	ld a, $4
	ld e, $8
.asm_8b780
	ld [hli], a
	inc a
	dec e
	jr nz, .asm_8b780
	jr Function8b79e

Function8b788:
.asm_8b788
	ld a, $2
	ld [hli], a
	dec c
	ret z
	ld a, $1
	ld [hli], a
	dec c
	ret z
	ld a, $3
	ld [hli], a
	dec c
	ret z
	ld a, $1
	ld [hli], a
	dec c
	jr nz, .asm_8b788
	ret

Function8b79e:
	hlcoord 0, 1, wAttrmap
	ld a, $1
	ld [hli], a
	hlcoord 9, 1, wAttrmap
	ld e, $b
.asm_8b7a9
	ld a, $2
	ld [hli], a
	dec e
	ret z
	xor a
	ld [hli], a
	dec e
	ret z
	ld a, $1
	ld [hli], a
	dec e
	ret z
	xor a
	ld [hli], a
	dec e
	jr nz, .asm_8b7a9
	ret

Function8b7bd: ; to go
	call Function8b855
	ld hl, MenuHeader_0x8b867
	call CopyMenuHeader
	ld a, [wd030]
	ld [wMenuCursorPosition], a
	ld a, [wd031]
	ld [wMenuScrollPosition], a
	ld a, [wd032]
	and a
	jr z, .asm_8b7e0
	ld a, [wMenuFlags]
	set 3, a
	ld [wMenuFlags], a

.asm_8b7e0
	ld a, [wd0e3]
	and a
	jr z, .asm_8b7ea
	dec a
	ld [wScrollingMenuCursorPosition], a

.asm_8b7ea
	hlcoord 0, 2
	ld b, $b
	ld c, $12
	call Function8b703
	call Function8b75d
	call UpdateSprites
	call Mobile_EnableSpriteUpdates
	call ScrollingMenu
	call Mobile_DisableSpriteUpdates
	ld a, [wMenuJoypad]
	cp B_BUTTON
	jr z, .asm_8b823
	cp D_LEFT
	jr nz, .asm_8b813
	call Function8b832
	jr .asm_8b7ea

.asm_8b813
	cp D_RIGHT
	jr nz, .asm_8b81c
	call Function8b83e
	jr .asm_8b7ea

.asm_8b81c
	ld a, [wMenuSelection]
	cp $ff
	jr nz, .asm_8b824

.asm_8b823
	xor a

.asm_8b824
	ld c, a
	ld a, [wMenuCursorY]
	ld [wd030], a
	ld a, [wMenuScrollPosition]
	ld [wd031], a
	ret

Function8b832:
	ld a, [wMenuScrollPosition]
	ld hl, wMenuDataItems
	sub [hl]
	jr nc, Function8b84b
	xor a
	jr Function8b84b

Function8b83e:
	ld a, [wMenuScrollPosition]
	ld hl, wMenuDataItems
	add [hl]
	cp $24
	jr c, Function8b84b
	ld a, $24

Function8b84b:
	ld [wMenuScrollPosition], a
	ld a, [wMenuCursorY]
	ld [wMenuCursorPosition], a
	ret

Function8b855:
	ld a, $28
	ld hl, wd002
	ld [hli], a
	ld c, $28
	xor a
.asm_8b85e
	inc a
	ld [hli], a
	dec c
	jr nz, .asm_8b85e
	ld a, $ff
	ld [hl], a
	ret

MenuHeader_0x8b867: ; to go
	db MENU_BACKUP_TILES ; flags
	menu_coords 1, 3, 18, 13
	dw MenuData_0x8b870
	db 1 ; default option

	db 0

MenuData_0x8b870: ; to go
	db SCROLLINGMENU_ENABLE_FUNCTION3 | SCROLLINGMENU_DISPLAY_ARROWS | SCROLLINGMENU_ENABLE_RIGHT | SCROLLINGMENU_ENABLE_LEFT ; flags
	db 5, 3 ; rows, columns
	db SCROLLINGMENU_ITEMS_NORMAL ; item format
	dbw 0, wd002
	dba Function8b880
	dba Function8b88c
	dba Function8b8c8

Function8b880:
	ld h, d
	ld l, e
	ld de, wMenuSelection
	lb bc, PRINTNUM_LEADINGZEROS | 1, 2
	call PrintNum
	ret

Function8b88c: ; to go
	call OpenSRAMBank4
	ld h, d
	ld l, e
	push hl
	ld de, String_89116
	call Function8931b
	call Function8932d
	jr c, .asm_8b8a3
	ld hl, 0
	add hl, bc
	ld d, h
	ld e, l

.asm_8b8a3
	pop hl
	push hl
	call PlaceString
	pop hl
	ld d, $0
	ld e, $6
	add hl, de
	push hl
	ld de, String_89116
	call Function8931b
	call Function8934a
	jr c, .asm_8b8c0
	ld hl, $0006
	add hl, bc
	ld d, h
	ld e, l

.asm_8b8c0
	pop hl
	call PlaceString
	call CloseSRAM
	ret

Function8b8c8:
	hlcoord 0, 14
	ld b, $2
	ld c, $12
	call Textbox
	ld a, [wd033]
	ld b, 0
	ld c, a
	ld hl, Unknown_8b903
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld d, h
	ld e, l
	hlcoord 1, 16
	call PlaceString
	hlcoord 0, 13
	ld a, $f
	ld [hl], a
	hlcoord 19, 13
	ld a, $11
	ld [hl], a
	ld a, [wMenuScrollPosition]
	cp $24
	ret c
	hlcoord 0, 13
	ld c, $12
	call Function8b732
	ret

Unknown_8b903:
	dw String_8b90b
	dw String_8b919
	dw String_8b92a
	dw String_8b938

String_8b90b: db "めいしを　えらんでください@"        ; Please select a noun.
String_8b919: db "どの　めいしと　いれかえますか？@"    ; OK to swap with any noun?
String_8b92a: db "あいてを　えらんでください@"        ; Please select an opponent.
String_8b938: db "いれる　ところを　えらんでください@" ; Please select a location.
