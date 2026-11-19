	; DebugColor_GFX tile IDs
	const_def $6a
	const DEBUGTEST_TICKS_1 ; $6a
	const DEBUGTEST_TICKS_2 ; $6b
	const DEBUGTEST_WHITE   ; $6c
	const DEBUGTEST_LIGHT   ; $6d
	const DEBUGTEST_DARK    ; $6e
	const DEBUGTEST_BLACK   ; $6f
	const DEBUGTEST_0       ; $70
	const DEBUGTEST_1       ; $71
	const DEBUGTEST_2       ; $72
	const DEBUGTEST_3       ; $73
	const DEBUGTEST_4       ; $74
	const DEBUGTEST_5       ; $75
	const DEBUGTEST_6       ; $76
	const DEBUGTEST_7       ; $77
	const DEBUGTEST_8       ; $78
	const DEBUGTEST_9       ; $79
	const DEBUGTEST_A       ; $7a
	const DEBUGTEST_B       ; $7b
	const DEBUGTEST_C       ; $7c
	const DEBUGTEST_D       ; $7d
	const DEBUGTEST_E       ; $7e
	const DEBUGTEST_F       ; $7f

	; Palette editor state indexes
	const_def
	const DEBUGCOLORMAIN_INITSCREEN     ; 0
	const DEBUGCOLORMAIN_UPDATESCREEN   ; 1
	const DEBUGCOLORMAIN_UPDATEPALETTES ; 2
	const DEBUGCOLORMAIN_JOYPAD         ; 3

DebugColor_InitVRAM:
	ld a, $1
	ldh [rVBK], a
	ld hl, STARTOF(VRAM)
	ld bc, SIZEOF(VRAM)
	xor a
	call ByteFill

	ld a, $0
	ldh [rVBK], a
	ld hl, STARTOF(VRAM)
	ld bc, SIZEOF(VRAM)
	xor a
	call ByteFill

	hlcoord 0, 0, wAttrmap
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	xor a
	call ByteFill

	hlcoord 0, 0
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT

	xor a
	call ByteFill
	jmp ClearSprites

DebugColor_LoadGFX:
	ld hl, DebugColor_GFX
	ld de, vTiles2 tile DEBUGTEST_TICKS_1
	ld bc, 22 tiles
	call CopyBytes

	ld hl, DebugColor_UpArrowGFX
	ld de, vTiles0
	ld bc, 1 tiles
	call CopyBytes

; Invert the font colors.
	call LoadStandardFont
	ld hl, vTiles1
	ld bc, $80 tiles
.loop
	ld a, [hl]
	cpl
	ld [hli], a
	dec bc
	ld a, c
	or b
	jr nz, .loop
	ret

DebugColor_InitPalettes:
	ldh a, [hCGB]
	and a
	ret z

	ldh a, [rSVBK]
	push af
	ld a, BANK(wBGPals2)
	ldh [rSVBK], a

	ld hl, Palette_DebugBG
	ld de, wBGPals2
	ld bc, 16 palettes
	call CopyBytes

	ld a, 1 << rBGPI_AUTO_INCREMENT
	ldh [rBGPI], a
	ld hl, Palette_DebugBG
	ld c, 8 palettes
	xor a
.bg_loop
	ldh [rBGPD], a
	dec c
	jr nz, .bg_loop

	ld a, 1 << rOBPI_AUTO_INCREMENT
	ldh [rOBPI], a
	ld hl, Palette_DebugOB
	ld c, 8 palettes
.ob_loop
	ld a, [hli]
	ldh [rOBPD], a
	dec c
	jr nz, .ob_loop

	ld a, LOW(palred 20 + palgreen 20 + palblue 20)
	ld [wDebugLightColor + 0], a
	ld a, HIGH(palred 20 + palgreen 20 + palblue 20)
	ld [wDebugLightColor + 1], a
	ld a, LOW(palred 10 + palgreen 10 + palblue 10)
	ld [wDebugDarkColor + 0], a
	ld a, HIGH(palred 10 + palgreen 10 + palblue 10)
	ld [wDebugDarkColor + 1], a

	pop af
	ldh [rSVBK], a
	ret

Palette_DebugBG:
INCLUDE "gfx/debug/bg.pal"

Palette_DebugOB:
INCLUDE "gfx/debug/ob.pal"

DebugColor_InitScreen:
	xor a
	ldh [hBGMapMode], a
	hlcoord 0, 0
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	ld a, DEBUGTEST_BLACK
	call ByteFill
	hlcoord 1, 3
	lb bc, 7, 18
	ld a, DEBUGTEST_WHITE
	call DebugColor_FillBoxWithByte
	hlcoord 11, 0
	lb bc, 2, 3
	ld a, DEBUGTEST_LIGHT
	call DebugColor_FillBoxWithByte
	hlcoord 16, 0
	lb bc, 2, 3
	ld a, DEBUGTEST_DARK
	call DebugColor_FillBoxWithByte
	call DebugColor_LoadRGBMeter
	call DebugColor_SetRGBMeter
	ld a, [wDebugColorCurMon]
	inc a
	ld [wCurPartySpecies], a
	ld [wTextDecimalByte], a
	hlcoord 0, 1
	ld de, wTextDecimalByte
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNum
	ld a, [wDebugColorIsTrainer]
	and a
	jr nz, .trainer

; mon
	ld a, UNOWN_A
	ld [wUnownLetter], a
	call GetPokemonName
	hlcoord 4, 1
	call PlaceString
	xor a
	ld [wBoxAlignment], a
	hlcoord 12, 3
	call _PrepMonFrontpic
	ld de, vTiles2 tile $31
	predef GetMonBackpic
	ld a, $31
	ldh [hGraphicStartTile], a
	hlcoord 2, 4
	lb bc, 6, 6
	predef PlaceGraphic

	ld a, [wDebugColorIsShiny]
	and a
	jr z, .normal
; shiny
	ld de, .ShinyText
	jr .place_text
.normal
	ld de, .NormalText
.place_text
	hlcoord 7, 17
	call PlaceString
	hlcoord 0, 17
	ld de, .SwitchText
	call PlaceString
	jr .done

.trainer
	ld a, [wTextDecimalByte]
	ld [wTrainerClass], a
	callfar GetTrainerAttributes
	ld de, wStringBuffer1
	hlcoord 4, 1
	call PlaceString
	ld de, vTiles2
	callfar GetTrainerPic
	xor a
	ld [wTempEnemyMonSpecies], a
	ldh [hGraphicStartTile], a
	hlcoord 2, 3
	lb bc, 7, 7
	predef PlaceGraphic

.done
	ld a, DEBUGCOLORMAIN_UPDATESCREEN
	ld [wJumptableIndex], a
	ret

.ShinyText:
	db "Shiny", DEBUGTEST_BLACK, DEBUGTEST_BLACK, "@" ; Rare (shiny)

.NormalText:
	db "Normal@" ; Normal

.SwitchText:
	db DEBUGTEST_A, "Swap▶@" ; (A) Switches

DebugColor_LoadRGBMeter:
	decoord 0, 11, wAttrmap
	hlcoord 2, 11
	ld a, 1
	call .load_meter
	decoord 0, 13, wAttrmap
	hlcoord 2, 13
	ld a, 2
	call .load_meter
	decoord 0, 15, wAttrmap
	hlcoord 2, 15
	ld a, 3
.load_meter:
	push af
	ld a, DEBUGTEST_TICKS_1
	ld [hli], a
	ld bc, 15
	ld a, DEBUGTEST_TICKS_2
	call ByteFill
	ld l, e
	ld h, d
	pop af
	ld bc, 20 * 2
	jmp ByteFill

DebugColor_SetRGBMeter:
	ld a, [wDebugColorCurMon]
	inc a
	ld l, a
	ld h, 0
	add hl, hl
	add hl, hl
	ld de, wDebugOriginalColors
	add hl, de
	ld de, wDebugMiddleColors
	ld bc, 4
	call CopyBytes
	xor a
	ld [wDebugColorRGBJumptableIndex], a
	ld [wDebugColorCurColor], a
	ld de, wDebugLightColor
	jmp DebugColor_CalculateRGB

DebugColor_UpdateScreen:
	ld a, 2
	ldh [hBGMapMode], a
	call DelayFrame
	call DelayFrame
	call DelayFrame
	call WaitBGMap

	ld a, DEBUGCOLORMAIN_UPDATEPALETTES
	ld [wJumptableIndex], a
	ret

DebugColor_UpdatePalettes:
	ldh a, [rSVBK]
	push af
	ld a, BANK(wBGPals2)
	ldh [rSVBK], a

	ld hl, wBGPals2
	ld de, wDebugMiddleColors
	ld c, 1
	call DebugColor_LoadPalettes_White_Col1_Col2_Black

	hlcoord 10, 2
	ld de, wDebugLightColor
	call DebugColor_PrintHexColor
	hlcoord 15, 2
	ld de, wDebugDarkColor
	call DebugColor_PrintHexColor

	ld a, TRUE
	ldh [hCGBPalUpdate], a

	ld a, DEBUGCOLORMAIN_JOYPAD
	ld [wJumptableIndex], a

	pop af
	ldh [rSVBK], a
	ret

DebugColor_PrintHexColor:
	inc hl
	inc hl
	inc hl
	ld a, [de]
	call .place_tile
	ld a, [de]
	swap a
	call .place_tile
	inc de
	ld a, [de]
	call .place_tile
	ld a, [de]
	swap a
.place_tile:
	and $f
	add DEBUGTEST_0
	ld [hld], a
	ret

DebugColor_SelectColorBox:
	ld hl, hJoyLast
	ld a, [hl]
	and D_DOWN
	jr nz, DebugColor_NextRGBColor
	ld a, [hl]
	and D_LEFT
	jr nz, .light
	ld a, [hl]
	and D_RIGHT
	jr nz, .dark
	ret

.light
	xor a ; FALSE
	ld [wDebugColorCurColor], a
	ld de, wDebugLightColor
	jmp DebugColor_CalculateRGB

.dark
	ld a, TRUE
	ld [wDebugColorCurColor], a
	ld de, wDebugDarkColor
	jmp DebugColor_CalculateRGB

DebugColor_ChangeRedValue:
	ld hl, hJoyLast
	ld a, [hl]
	and D_DOWN
	jr nz, DebugColor_NextRGBColor
	ld a, [hl]
	and D_UP
	jr nz, DebugColor_PreviousRGBColor
	ld hl, wDebugRedChannel
	jr DebugColor_UpdateRGBColor

DebugColor_ChangeGreenValue:
	ld hl, hJoyLast
	ld a, [hl]
	and D_DOWN
	jr nz, DebugColor_NextRGBColor
	ld a, [hl]
	and D_UP
	jr nz, DebugColor_PreviousRGBColor
	ld hl, wDebugGreenChannel
	jr DebugColor_UpdateRGBColor

DebugColor_ChangeBlueValue:
	ld hl, hJoyLast
	ld a, [hl]
	and D_UP
	jr nz, DebugColor_PreviousRGBColor
	ld hl, wDebugBlueChannel
	; fallthrough

DebugColor_UpdateRGBColor:
	ldh a, [hJoyLast]
	and D_RIGHT
	jr nz, .increment
	ldh a, [hJoyLast]
	and D_LEFT
	jr nz, .decrement
	ret

.increment
	ld a, [hl]
	cp 31
	ret nc
	inc [hl]
	jr .done

.decrement
	ld a, [hl]
	and a
	ret z
	dec [hl]

.done
	call DebugColor_CalculatePalette
	ld a, DEBUGCOLORMAIN_UPDATEPALETTES
	ld [wJumptableIndex], a
	ret

DebugColor_PreviousRGBColor:
	ld hl, wDebugColorRGBJumptableIndex
	dec [hl]
	ret

DebugColor_NextRGBColor:
	ld hl, wDebugColorRGBJumptableIndex
	inc [hl]
	ret

DebugColor_CalculatePalette:
	ld a, [wDebugRedChannel]
	and %00011111
	ld e, a
	ld a, [wDebugGreenChannel]
	and %00000111
	add a
	swap a
	or e
	ld e, a
	ld a, [wDebugGreenChannel]
	and %00011000
	add a
	swap a
	ld d, a
	ld a, [wDebugBlueChannel]
	and %00011111
	add a
	add a
	or d
	ld d, a
	ld a, [wDebugColorCurColor]
	and a
	jr z, .light

; dark
	ld a, e
	ld [wDebugDarkColor + 0], a
	ld a, d
	ld [wDebugDarkColor + 1], a
	ret

.light
	ld a, e
	ld [wDebugLightColor + 0], a
	ld a, d
	ld [wDebugLightColor + 1], a
	ret

DebugColor_CalculateRGB:
	ld a, [de]
	and %00011111
	ld [wDebugRedChannel], a
	ld a, [de]
	and %11100000
	swap a
	srl a
	ld b, a
	inc de
	ld a, [de]
	and %00000011
	swap a
	srl a
	or b
	ld [wDebugGreenChannel], a
	ld a, [de]
	and %01111100
	srl a
	srl a
	ld [wDebugBlueChannel], a
	ret

DebugColor_LoadPalettes_White_Col1_Col2_Black:
.loop
	ld a, LOW(PALRGB_WHITE)
	ld [hli], a
	ld a, HIGH(PALRGB_WHITE)
	ld [hli], a
rept 4
	ld a, [de]
	inc de
	ld [hli], a
endr
	xor a
	ld [hli], a
	ld [hli], a
	dec c
	jr nz, .loop
	ret

DebugColor_FillBoxWithByte:
; For some reason, we have another copy of FillBoxWithByte here
.row
	push bc
	push hl
.col
	ld [hli], a
	dec c
	jr nz, .col
	pop hl
	ld bc, SCREEN_WIDTH
	add hl, bc
	pop bc
	dec b
	jr nz, .row
	ret
DebugColor_PlaceCursor:
	ld a, DEBUGTEST_BLACK
	hlcoord 10, 0
	ld [hl], a
	hlcoord 15, 0
	ld [hl], a
	hlcoord 1, 11
	ld [hl], a
	hlcoord 1, 13
	ld [hl], a
	hlcoord 1, 15
	ld [hl], a

	ld a, [wJumptableIndex]
	cp DEBUGCOLORMAIN_JOYPAD
	jmp nz, ClearSprites

	ld a, [wDebugColorRGBJumptableIndex]
	and a
	jr z, .place_cursor
	dec a
	hlcoord 1, 11
	ld bc, 2 * SCREEN_WIDTH
	call AddNTimes
	ld [hl], "▶"

.place_cursor
	ld a, [wDebugColorCurColor]
	and a
	jr z, .light
; dark
	hlcoord 15, 0
	jr .place
.light
	hlcoord 10, 0
.place
	ld [hl], "▶"

	ld b, $70 ; initial tile id
	ld c, 5 ; initial palette
	ld hl, wShadowOAM
	ld de, wDebugRedChannel
	call .placesprite
	ld de, wDebugGreenChannel
	call .placesprite
	ld de, wDebugBlueChannel
	; fallthrough

.placesprite:
	ld a, b
	ld [hli], a ; y
	ld a, [de]
	add a
	add a
	add 3 * TILE_WIDTH
	ld [hli], a ; x
	xor a
	ld [hli], a ; tile id
	ld a, c
	ld [hli], a ; attributes
	ld a, 2 * TILE_WIDTH
	add b
	ld b, a
	inc c
	ret

DebugColor_UpArrowGFX:
INCBIN "gfx/debug/up_arrow.2bpp"

DebugColor_GFX:
INCBIN "gfx/debug/color_test.2bpp"
