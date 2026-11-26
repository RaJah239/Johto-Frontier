Pokepic::
	ld hl, PokepicMenuHeader
	call CopyMenuHeader
	call MenuBox
	call UpdateSprites
	call ApplyTilemap
	ld de, wBGPals1 palette PAL_BG_TEXT color 1
	farcall LoadPokepicPalette
	call UpdateTimePals
	xor a
	ldh [hBGMapMode], a
	ld a, [wCurPartySpecies]
	ld [wCurSpecies], a
	call GetBaseData
	ld de, vTiles1
	predef GetMonFrontpic
	ld a, [wMenuBorderTopCoord]
	inc a
	ld b, a
	ld a, [wMenuBorderLeftCoord]
	inc a
	ld c, a
	call Coord2Tile
	ld a, $80
	ldh [hGraphicStartTile], a
	lb bc, 7, 7
	predef PlaceGraphic
	jmp WaitBGMap

ClosePokepic::
	ld hl, PokepicMenuHeader
	call CopyMenuHeader
	call ClearMenuBoxInterior
	call WaitBGMap
	call GetMemSGBLayout
	xor a
	ldh [hBGMapMode], a
	call LoadOverworldTilemapAndAttrmapPals
	call CopyTilemapAtOnce
	call UpdateSprites
	farcall EnableDynPalUpdates
	; Flush the restored OBJ palettes without replacing the Pokepic text colors.
	farcall ApplyOBPals
	ld a, TRUE
	ldh [hCGBPalUpdate], a
	call DelayFrame
	jmp LoadStandardFont

PokepicMenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 6, 4, 14, 13
	dw NULL
	db 1 ; default option

PrerollWildPokepic::
; For the pokepic of a wild mon about to be battled (wildpokepic): roll its
; DVs now, as its battle would, so the picture shows whether it's shiny.
; LoadEnemyMon then uses them. Species in wScriptVar.
	ld a, [wScriptVar]
	ld [wPokepicWildSpecies], a
	ld a, [wBattleType]
	cp BATTLETYPE_FORCESHINY
	lb bc, ATKDEFDV_SHINY, SPDSPCDV_SHINY
	jr z, .got_dvs
	farcall RollWildDVs
.got_dvs
	ld a, b
	ld [wPokepicWildDVs], a
	ld a, c
	ld [wPokepicWildDVs + 1], a
	ret
