LoadOverworldMonIcon:
	ld a, e
	ld [wCurIcon], a
	; fallthrough
_LoadOverworldMonIcon:
	ld l, a
	ld h, 0
	add hl, hl
	ld de, IconPointers
	add hl, de
	ld a, [hli]
	ld e, a
	ld d, [hl]
	jmp GetIconBank

SetMenuMonIconColor:
	push hl
	push de
	push bc
	push af

	ld a, [wTempIconSpecies]
	ld [wCurPartySpecies], a
	call GetMenuMonIconPalette
	ld hl, wShadowOAMSprite00Attributes
	jmp _ApplyMenuMonIconColor

SetMenuMonIconColor_NoShiny:
	push hl
	push de
	push bc
	push af

	ld a, [wTempIconSpecies]
	ld [wCurPartySpecies], a
	and a
	call GetMenuMonIconPalette_PredeterminedShininess
	ld hl, wShadowOAMSprite00Attributes
	jr _ApplyMenuMonIconColor

SetDexMonIconColor_NoShiny:
 	push hl
 	push de
 	push bc
 	push af
 
 	ld a, [wTempIconSpecies]
 	ld [wCurPartySpecies], a
 	and a
 	call GetMenuMonIconPalette_PredeterminedShininess
 	ld hl, wShadowOAMSprite00Attributes
 	push af
 	ldh a, [hObjectStructIndex]
 	swap a
 	ld d, 0
 	ld e, a
 	add hl, de
 	pop af
 	jr _ApplyMenuMonIconColor

 SetDexMonIconColor_SpritePage:
 	push hl
 	push de
 	push bc
 	push af
 
 	ld a, [wTempIconSpecies]
 	ld [wCurPartySpecies], a
 	and a
 	ld hl, wPokedexShinyToggle
 	bit 0, [hl]
 	jr z, .not_shiny
 	scf

 .not_shiny
 	call GetMenuMonIconPalette_PredeterminedShininess
 	ld hl, wShadowOAMSprite00Attributes
 	push af
 	ldh a, [hObjectStructIndex]
 	swap a
 	ld d, 0
 	ld e, a
 	add hl, de
 	pop af
 	jr _ApplyMenuMonIconColor

LoadPartyMenuMonIconColors:
	push hl
	push de
	push bc
	push af

	ld a, [wPartyCount]
	sub c
	ld [wCurPartyMon], a
	ld e, a
	ld d, 0

	ld hl, wPartySpecies
	add hl, de
	ld a, [hl]
	ld [wCurPartySpecies], a
	ld a, MON_DVS
	call GetPartyParamLocation
	call GetMenuMonIconPalette
	ld hl, wShadowOAMSprite00Attributes
	push af
	ld a, [wCurPartyMon]
	swap a
	ld d, 0
	ld e, a
	add hl, de
	pop af
	; fallthrough

_ApplyMenuMonIconColor:
	ld c, 4
	ld de, 4
.loop
	ld [hl], a
	add hl, de
	dec c
	jr nz, .loop
	; fallthrough

_FinishMenuMonIconColor:
	jmp PopAFBCDEHL

GetMonPalInBCDE:
; Sets BCDE to mon icon palette.
; Input: c = species, b = shininess (1=true, 0=false)
	ld hl, MonMenuIconPals
	dec c

	; This sets z if mon is shiny.
	dec b
	ld b, 0
	add hl, bc
	ld a, [hl]
	jr z, .shiny
	swap a
.shiny
	and $f

	; Now we have the target color. Get the palette (+ 2 to avoid white).
	ld hl, PartyMenuOBPals + 2
	ld bc, 1 palettes
	call AddNTimes

	push hl
	ld a, BANK(PartyMenuOBPals)
	call GetFarWord
	ld b, h
	ld c, l
	pop hl
	inc hl
	inc hl
	ld a, BANK(PartyMenuOBPals)
	call GetFarWord
	ld d, h
	ld e, l
	ret

GetMenuMonIconPalette:
	ld c, l
	ld b, h
	farcall CheckShininess
GetMenuMonIconPalette_PredeterminedShininess:
	push af
	ld a, [wCurPartySpecies]
	dec a
	ld c, a
	ld b, 0
	ld hl, MonMenuIconPals
	add hl, bc
	ld e, [hl]
	pop af
	ld a, e
	jr c, .shiny
	swap a
.shiny
	ld e, a
	and $f
	ret

LoadMenuMonIcon:
	push hl
	push de
	push bc
	call .LoadIcon
	jmp PopBCDEHL

.LoadIcon:
	ld d, 0
	ld hl, .Jumptable
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

.Jumptable:
; entries correspond to MONICON_* constants
	dw PartyMenu_InitAnimatedMonIcon    ; MONICON_PARTYMENU
	dw NamingScreen_InitAnimatedMonIcon ; MONICON_NAMINGSCREEN
	dw MoveList_InitAnimatedMonIcon     ; MONICON_MOVES
	dw Trade_LoadMonIconGFX             ; MONICON_TRADE
	dw Pokedex_InitAnimatedMonIcon      ; MONICON_UNUSED

PartyMenu_InitAnimatedMonIcon:
	call InitPartyMenuIcon
	jr SetPartyMonIconAnimSpeed

InitPartyMenuIcon:
	call LoadPartyMenuMonIconColors
	ld a, [wCurIconTile]
	push af
	ldh a, [hObjectStructIndex]
	ld hl, wPartySpecies
	ld e, a
	ld d, 0
	add hl, de
	ld a, [hl]
	ld [wCurIcon], a
	ld a, MON_DVS
	call GetPartyParamLocation
	ld a, [wCurIconTile]
	call GetIconGFXWithDVs
	ldh a, [hObjectStructIndex]
; y coord
	add a
	add a
	add a
	add a
	add $1c
	ld d, a
; x coord
	ld e, $10
; type is partymon icon
	ld a, SPRITE_ANIM_OBJ_PARTY_MON
	call _InitSpriteAnimStruct
	pop af
	ld hl, SPRITEANIMSTRUCT_TILE_ID
	add hl, bc
	ld [hl], a
	ret

SetPartyMonIconAnimSpeed:
	push bc
	ldh a, [hObjectStructIndex]
	ld b, a
	call .getspeed
	ld a, b
	pop bc
	ld hl, SPRITEANIMSTRUCT_DURATIONOFFSET
	add hl, bc
	ld [hl], a
	rlca
	rlca
	ld hl, SPRITEANIMSTRUCT_VAR2
	add hl, bc
	ld [hl], a
	ret

.getspeed
	farcall PlacePartymonHPBar
	call GetHPPal
	ld e, d
	ld d, 0
	ld hl, .speeds
	add hl, de
	ld b, [hl]
	ret

.speeds
	db $00 ; HP_GREEN
	db $40 ; HP_YELLOW
	db $80 ; HP_RED

NamingScreen_InitAnimatedMonIcon:
	ld hl, wTempMonDVs
	call SetMenuMonIconColor
	ld a, [wTempIconSpecies]
	ld [wCurIcon], a
	xor a
	call GetIconGFXWithDVs
	depixel 4, 4, 4, 0
	ld a, SPRITE_ANIM_OBJ_PARTY_MON
	call _InitSpriteAnimStruct
	ld hl, SPRITEANIMSTRUCT_ANIM_SEQ_ID
	add hl, bc
	ld [hl], SPRITE_ANIM_FUNC_NULL
	ret

MoveList_InitAnimatedMonIcon:
	ld a, MON_DVS
	call GetPartyParamLocation
	call SetMenuMonIconColor
	ld a, [wTempIconSpecies]
	ld [wCurIcon], a
	xor a
	call GetIconGFXWithDVs
	ld d, 3 * TILE_WIDTH + 2 ; depixel 3, 4, 2, 4
	ld e, 4 * TILE_WIDTH + 4
	ld a, SPRITE_ANIM_OBJ_PARTY_MON
	call _InitSpriteAnimStruct
	ld hl, SPRITEANIMSTRUCT_ANIM_SEQ_ID
	add hl, bc
	ld [hl], SPRITE_ANIM_FUNC_NULL
	ret

Pokedex_InitAnimatedMonIcon:
 	ld a, [wCurPartySpecies]
 	push af
 	ld a, [wTempSpecies]
 	ld [wCurPartySpecies], a
 	call SetDexMonIconColor_NoShiny
 	
 	ld a, [wTempIconSpecies]
 	ld [wCurIcon], a
 	call GetMemIconGFX
 
 	ld a, [wStatsScreenFlags]
 	cp 11
 	jr nz, .evo_page
 	ld a, -1
 	ld [wStatsScreenFlags], a
 	ld d, $88
 	ld e, $20
 	jr .setxdone

.evo_page
 	ld a, [wStatsScreenFlags]
 	inc a
 ; y coord
 	ld c, 32
 	call SimpleMultiply
 	add $28 ;$20
 	ld d, a
 ; x coord
 	ld e, $19 ; $20

.setxdone
 ; type is partymon icon
 	ld a, SPRITE_ANIM_OBJ_PARTY_MON
 	call _InitSpriteAnimStruct
 
 	ld a, [wCurIconTile]
 	sub 10
 	ld hl, SPRITEANIMSTRUCT_TILE_ID
 	add hl, bc
 	ld [hl], a
 
 	ld hl, SPRITEANIMSTRUCT_ANIM_SEQ_ID
 	add hl, bc
 	ld [hl], SPRITE_ANIM_FUNC_NULL
 	
 	pop af
 	ld [wCurPartySpecies], a
 	ret

Trade_LoadMonIconGFX:
	; hl = wPlayerTrademonDVs or wOTTrademonDVs
	ld h, b
	ld l, c
	ld a, [wTempIconSpecies]
	ld [wCurPartySpecies], a
	ld [wCurIcon], a
	push hl
	call GetMenuMonIconPalette
	add a
	add a
	add a
	ld e, a
	farcall SetSecondOBJPalette
	pop hl
	ld a, $62
	ld [wCurIconTile], a
	jr GetIconGFXWithDVs

GetSpeciesIcon:
; Load species icon into VRAM at tile a
	push de
	ld a, MON_DVS
	call GetPartyParamLocation
	call SetMenuMonIconColor
	ld a, [wTempIconSpecies]
	ld [wCurIcon], a
	pop de
	ld a, e
	jr GetIconGFX

FlyFunction_GetMonIcon:
	push de
	ld a, [wTempIconSpecies]
	ld [wCurIcon], a
	pop de
	ld a, e
	call GetIcon_a
; todo: made up this label location... fix this!
; fallthrough
SetOWFlyMonColor:
	; Edit the OBJ 0 palette so that the cursor Pokémon has the right colors.
	ld a, MON_DVS
	call GetPartyParamLocation
	call GetMenuMonIconPalette
	add a
	add a
	add a
	ld e, a
	farjp SetFirstOBJPalette

GetIconGFXWithDVs:
; a = destination tile, hl = DVs for the Pokémon in wCurIcon.
	ld e, a
	ld a, [wCurIcon]
	cp UNOWN
	ld a, e
	jr nz, GetIconGFX
	push af
	call GetUnownIcon
	pop af
	ld l, a
	ld h, 0
	call GetIconVRAMAddress
	call CopyIconGFX
	jr LoadIconHeldItemGFX

GetUnownIcon:
; hl = Unown's DVs. Return the graphics in b:de and the tile count in c.
	predef GetUnownLetter
	ld a, [wUnownLetter]
	dec a
	ld l, a
	ld h, 0
	add hl, hl
	ld de, UnownIconPointers
	add hl, de
	ld a, [hli]
	ld e, a
	ld d, [hl]
	lb bc, BANK("Unown Icons"), 8
	ret

GetMemIconGFX:
	ld a, [wCurIconTile]
GetIconGFX:
	call GetIcon_a
LoadIconHeldItemGFX:
	ld de, 8 tiles
	add hl, de
	ld de, HeldItemIcons
	lb bc, BANK(HeldItemIcons), 2
	call CopyMenuIconTiles
	ld a, [wCurIconTile]
	add 10
	ld [wCurIconTile], a
	ret

HeldItemIcons:
INCBIN "gfx/stats/mail.2bpp"
INCBIN "gfx/stats/item.2bpp"

GetIcon_de:
; Load icon graphics into VRAM starting from tile de.
	ld l, e
	ld h, d
	jr GetIcon

GetIcon_a:
; Load icon graphics into VRAM starting from tile a.
	ld l, a
	ld h, 0

GetIcon:
; Load icon graphics into VRAM starting from tile hl.
	call GetIconVRAMAddress
	push hl
	ld a, [wCurIcon]
	call _LoadOverworldMonIcon
	pop hl

CopyIconGFX:
	push hl
	call CopyMenuIconTiles
	pop hl
	ret

GetIconVRAMAddress:
; One tile is 16 bytes long.
rept 4
	add hl, hl
endr
	assert LOW(vTiles0) == 0
	ld a, h
	add HIGH(vTiles0)
	ld h, a
	ret

GetIconBank:
	ld a, [wCurIcon]
	cp MANKEY ; first species in "Mon Icons 2"
	lb bc, BANK("Mon Icons 1"), 8
	ret c
	ld b, BANK("Mon Icons 2")
	ret

CopyMenuIconTiles:
; Send the icon tiles straight away with H-Blank DMA instead of
; requesting them for the next VBlank: a party of 6 used to take
; 6+ frames to load its icons, now it takes a few scanlines.
	jmp Get2bppViaHDMA


GetStorageIcon_a:
; Load frame 1 icon graphics into VRAM starting from tile a
	ld l, a ; no-optimize hl|bc|de = a * 16 (rept)
	ld h, 0
rept 4
	add hl, hl
endr
	ld de, vTiles0
	add hl, de
	; fallthrough
GetStorageIcon:
	push hl
	ld a, [wCurIcon]
	call _LoadOverworldMonIcon
	ld c, 4
	pop hl
	farjp BillsPC_SafeGet2bpp

FreezeMonIcons:
	ld hl, wSpriteAnimationStructs
	ld e, PARTY_LENGTH
	ld a, [wMenuCursorY]
	ld d, a
.loop
	ld a, [hl]
	and a
	jr z, .next
	cp d
	jr z, .loadwithtwo
	ld a, SPRITE_ANIM_FUNC_NULL
	jr .ok

.loadwithtwo
	ld a, SPRITE_ANIM_FUNC_PARTY_MON_SWITCH

.ok
	push hl
	ld c, l
	ld b, h
	ld hl, SPRITEANIMSTRUCT_ANIM_SEQ_ID
	add hl, bc
	ld [hl], a
	pop hl

.next
	ld bc, $10
	add hl, bc
	dec e
	jr nz, .loop
	ret

UnfreezeMonIcons:
	ld hl, wSpriteAnimationStructs
	ld e, PARTY_LENGTH
.loop
	ld a, [hl]
	and a
	jr z, .next
	push hl
	ld c, l
	ld b, h
	ld hl, SPRITEANIMSTRUCT_ANIM_SEQ_ID
	add hl, bc
	ld [hl], SPRITE_ANIM_FUNC_PARTY_MON
	pop hl
.next
	ld bc, $10
	add hl, bc
	dec e
	jr nz, .loop
	ret

HoldSwitchmonIcon:
	ld hl, wSpriteAnimationStructs
	ld e, PARTY_LENGTH
	ld a, [wSwitchMon]
	ld d, a
.loop
	ld a, [hl]
	and a
	jr z, .next
	cp d
	jr z, .is_switchmon
	ld a, SPRITE_ANIM_FUNC_PARTY_MON_SELECTED
	jr .join_back

.is_switchmon
	ld a, SPRITE_ANIM_FUNC_PARTY_MON_SWITCH
.join_back
	push hl
	ld c, l
	ld b, h
	ld hl, SPRITEANIMSTRUCT_ANIM_SEQ_ID
	add hl, bc
	ld [hl], a
	pop hl
.next
	ld bc, $10
	add hl, bc
	dec e
	jr nz, .loop
	ret

INCLUDE "data/pokemon/menu_icon_pals.asm"

INCLUDE "data/pokemon/icon_pointers.asm"

INCLUDE "data/pokemon/unown_icon_pointers.asm"
