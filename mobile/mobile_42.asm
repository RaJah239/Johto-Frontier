MACRO add_mobiletradeanim
\1_MobileTradeCmd:
	dw \1
ENDM

MACRO mobiletradeanim
	db (\1_MobileTradeCmd - MobileTradeAnim_JumptableLoop.Jumptable) / 2
ENDM

MobileTradeAnim_ClearBGMap:
	ld a, $1
	ldh [rVBK], a
	hlbgcoord 0, 0
	ld bc, 2 * BG_MAP_HEIGHT * BG_MAP_WIDTH
	ld a, $0
	call ByteFill
	ld a, $0
	ldh [rVBK], a
	hlbgcoord 0, 0
	ld bc, 2 * BG_MAP_HEIGHT * BG_MAP_WIDTH
	ld a, $7f
	call ByteFill
	ret

MobileTradeAnim_GetFrontpic:
	push de
	push af
	predef GetUnownLetter
	pop af
	ld [wCurPartySpecies], a
	ld [wCurSpecies], a
	call GetBaseData
	pop de
	predef GetMonFrontpic
	ret

Function108201:
	push de
	push af
	predef GetUnownLetter
	pop af
	ld [wCurPartySpecies], a
	ld [wCurSpecies], a
	call GetBaseData
	pop de
	predef GetAnimatedFrontpic
	ret

Function108229:
	ld [wCurPartySpecies], a
	hlcoord 7, 2
	ld d, $0
	ld e, ANIM_MON_TRADE
	predef LoadMonAnimation
	ret

MobileTradeAnim_JumptableLoop:
	add_mobiletradeanim GetMobileTradeAnimByte                ; 00
	add_mobiletradeanim MobileTradeAnim_GetTrademon3          ; 0a
	add_mobiletradeanim MobileTradeAnim_ShowOTMonFromTrade    ; 0b
	add_mobiletradeanim MobileTradeAnim_ShowPlayerMonForGTS   ; 0d
	add_mobiletradeanim MobileTradeAnim_ShowOTMonFromGTS      ; 0e
	add_mobiletradeanim MobileTradeAnim_FadeToBlack           ; 12

GetMobileTradeAnimByte:
	ld hl, wTradeAnimAddress
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld a, [de]
	ld [wJumptableIndex], a
	inc de
	ld [hl], d
	dec hl
	ld [hl], e
	ret

WaitMobileTradeSpriteAnims:
.loop
	push bc
	farcall PlaySpriteAnimations
	pop bc
	call DelayFrame
	dec c
	jr nz, .loop
	ret

Function1082db:
.loop
	farcall PlaySpriteAnimations
	farcall SetUpPokeAnim
	farcall HDMATransferTilemapToWRAMBank3
	jr nc, .loop
	ret

Function1082f0:
.loop
	call Function108b78
	call DelayFrame
	dec c
	jr nz, .loop
	ret

MobileTradeAnim_ShowOTMonFromTrade:
	call ClearBGPalettes
	call ClearSprites
	call ClearTilemap
	call DisableLCD
	call MobileTradeAnim_ClearBGMap
	ld a, [wOTTrademonSpecies]
	ld [wCurPartySpecies], a
	ld hl, wOTTrademonDVs
	ld de, vTiles2
	call Function108201
	call EnableLCD
	farcall DeinitializeAllSprites
	xor a
	ldh [hSCX], a
	ldh [hSCY], a
	ld a, $7
	ldh [hWX], a
	ld a, $90
	ldh [hWY], a
	depixel 10, 11, 4, 0
	ld a, SPRITE_ANIM_OBJ_MOBILE_TRADE_OT_BALL
	call InitSpriteAnimStruct
	call Function108b45
	ld a, $1
	call Function108b98
	call Function108af4
	ld c, 48
	call WaitMobileTradeSpriteAnims
	ld de, SFX_BALL_POOF
	call PlaySFX
	call MobileTradeAnim_DisplayReceivedMon
	xor a
	ldh [hSCX], a
	ldh [hSCY], a
	ld a, $7
	ldh [hWX], a
	ld a, $50
	ldh [hWY], a
	ld a, [wOTTrademonSpecies]
	ld [wCurPartySpecies], a
	ld a, [wOTTrademonDVs]
	ld [wTempMonDVs], a
	ld a, [wOTTrademonDVs + 1]
	ld [wTempMonDVs + 1], a
	ld b, SCGB_PLAYER_OR_MON_FRONTPIC_PALS
	call GetSGBLayout
	ld a, %11100100 ; 3,2,1,0
	call DmgToCgbBGPals
	call Function108963
	ld a, [wOTTrademonSpecies]
	call Function108229
	call Function1082db
	call Function108c16
	call GetMobileTradeAnimByte
	ret

MobileTradeAnim_ShowPlayerMonForGTS:
	ld de, MUSIC_EVOLUTION
	call PlayMusic2
	ld a, $80
	ldh [hSCX], a
	xor a
	ldh [hSCY], a
	ld a, $87
	ldh [hWX], a
	ld a, $50
	ldh [hWY], a
	call MobileTradeAnim_DisplayMonToBeSent
	ld a, [wPlayerTrademonSpecies]
	ld [wCurPartySpecies], a
	ld hl, wPlayerTrademonDVs
	call Function10898a
	call DelayFrame
	ld de, TradeBallGFX
	ld hl, vTiles0
	lb bc, BANK(TradeBallGFX), 6
	call Request2bpp
	ld de, TradePoofGFX
	ld hl, vTiles0 tile $06
	lb bc, BANK(TradePoofGFX), 12
	call Request2bpp
	ld a, [wPlayerTrademonDVs]
	ld [wTempMonDVs], a
	ld a, [wPlayerTrademonDVs + 1]
	ld [wTempMonDVs + 1], a
	ld b, SCGB_PLAYER_OR_MON_FRONTPIC_PALS
	call GetSGBLayout
	ld a, %11100100 ; 3,2,1,0
	call DmgToCgbBGPals
	call WaitBGMap
.loop
	ldh a, [hWX]
	cp $7
	jr z, .done
	sub $4
	ldh [hWX], a
	ldh a, [hSCX]
	sub $4
	ldh [hSCX], a
	call DelayFrame
	jr .loop

.done
	ld a, $7
	ldh [hWX], a
	xor a
	ldh [hSCX], a
	ld a, [wPlayerTrademonSpecies]
	call GetCryIndex
	jr c, .skip_cry
	ld e, c
	ld d, b
	call PlayCry

.skip_cry
	ld c, 80
	call DelayFrames
	call Function108c2b
	depixel 10, 11, 4, 0
	ld a, SPRITE_ANIM_OBJ_MOBILE_TRADE_SENT_BALL
	call InitSpriteAnimStruct
	ld de, SFX_BALL_POOF
	call PlaySFX
	hlcoord 0, 0
	ld bc, 12 * SCREEN_WIDTH
	ld a, " "
	call ByteFill
	ld c, 80
	call WaitMobileTradeSpriteAnims
	call GetMobileTradeAnimByte
	ret

MobileTradeAnim_ShowOTMonFromGTS:
	call ClearBGPalettes
	call ClearSprites
	call ClearTilemap
	call DisableLCD
	call MobileTradeAnim_ClearBGMap
	ld a, [wOTTrademonSpecies]
	ld [wCurPartySpecies], a
	ld hl, wOTTrademonDVs
	ld de, vTiles2
	call Function108201
	call EnableLCD
	farcall DeinitializeAllSprites
	call DelayFrame
	ld de, TradeBallGFX
	ld hl, vTiles0
	lb bc, BANK(TradeBallGFX), 6
	call Request2bpp
	ld de, TradePoofGFX
	ld hl, vTiles0 tile $06
	lb bc, BANK(TradePoofGFX), 12
	call Request2bpp
	xor a
	ldh [hSCX], a
	ldh [hSCY], a
	ld a, $7
	ldh [hWX], a
	ld a, $90
	ldh [hWY], a
	depixel 10, 11, 4, 0
	ld a, SPRITE_ANIM_OBJ_MOBILE_TRADE_OT_BALL
	call InitSpriteAnimStruct
	call Function108b45
	ld a, $1
	call Function108b98
	call Function108af4
	ld c, 48
	call WaitMobileTradeSpriteAnims
	ld de, SFX_BALL_POOF
	call PlaySFX
	call MobileTradeAnim_DisplayReceivedMon
	xor a
	ldh [hSCX], a
	ldh [hSCY], a
	ld a, $7
	ldh [hWX], a
	ld a, $50
	ldh [hWY], a
	ld a, [wOTTrademonSpecies]
	ld [wCurPartySpecies], a
	ld a, [wOTTrademonDVs]
	ld [wTempMonDVs], a
	ld a, [wOTTrademonDVs + 1]
	ld [wTempMonDVs + 1], a
	ld b, SCGB_PLAYER_OR_MON_FRONTPIC_PALS
	call GetSGBLayout
	ld a, %11100100 ; 3,2,1,0
	call DmgToCgbBGPals
	ld a, [wOTTrademonSpecies]
	ld hl, wOTTrademonDVs
	call Function10898a
	ld a, [wOTTrademonSpecies]
	call Function108229
	call Function1082db
	call Function108c40
	call GetMobileTradeAnimByte
	ret

MobileTradeAnim_GetTrademon3:
	ld c, 40
	ld hl, wBGPals2 palette 6
	call Function1082f0
	call Function108af4
	call GetMobileTradeAnimByte
	ret

MobileTradeAnim_FadeToBlack:
.loop
	ldh a, [rBGP]
	and a
	jr z, .blank
	add a
	add a
	call DmgToCgbBGPals
	call DmgToCgbObjPal0
	ld c, 4
	call DelayFrames
	jr .loop

.blank
	xor a
	call DmgToCgbBGPals
	call DmgToCgbObjPal0
	call GetMobileTradeAnimByte
	ret

Function108963:
	ld de, vTiles2 tile $31
	call DelayFrame
	ld hl, vTiles2
	lb bc, BANK(TradeGameBoyLZ), $31
	call Request2bpp
	call WaitTop
	call MobileTradeAnim_ClearTilemap
	hlcoord 7, 2
	xor a
	ldh [hGraphicStartTile], a
	lb bc, 7, 7
	predef PlaceGraphic
	call WaitBGMap
	ret

Function10898a:
	ld de, vTiles2
	call MobileTradeAnim_GetFrontpic
	call WaitTop
	call MobileTradeAnim_ClearTilemap
	hlcoord 7, 2
	xor a
	ldh [hGraphicStartTile], a
	lb bc, 7, 7
	predef PlaceGraphic
	call WaitBGMap
	ret

MobileTradeAnim_DisplayMonToBeSent:
	ld de, wPlayerTrademonSpecies
	ld a, [de]
	cp EGG
	jr z, MobileTradeAnim_DisplayEggData
	call MobileTradeAnim_LoadMonTemplate
	ld de, wPlayerTrademonSpecies
	call MobileTradeAnim_MonDisplay_PrintSpeciesNumber
	ld de, wPlayerTrademonSpeciesName
	call MobileTradeAnim_MonDisplay_PrintSpeciesName
	ld a, [wPlayerTrademonCaughtData]
	ld de, wPlayerTrademonOTName
	call MobileTradeAnim_MonDisplay_PrintOTNameAndGender
	ld de, wPlayerTrademonID
	call MobileTradeAnim_MonDisplay_PrintIDNumber
	call MobileTradeAnim_MonDisplay_UpdateBGMap
	ret

MobileTradeAnim_DisplayReceivedMon:
	ld de, wOTTrademonSpecies
	ld a, [de]
	cp EGG
	jr z, MobileTradeAnim_DisplayEggData
	call MobileTradeAnim_LoadMonTemplate
	ld de, wOTTrademonSpecies
	call MobileTradeAnim_MonDisplay_PrintSpeciesNumber
	ld de, wOTTrademonSpeciesName
	call MobileTradeAnim_MonDisplay_PrintSpeciesName
	ld a, [wOTTrademonCaughtData]
	ld de, wOTTrademonOTName
	call MobileTradeAnim_MonDisplay_PrintOTNameAndGender
	ld de, wOTTrademonID
	call MobileTradeAnim_MonDisplay_PrintIDNumber
	call MobileTradeAnim_MonDisplay_UpdateBGMap
	ret

MobileTradeAnim_DisplayEggData:
	call WaitTop
	call MobileTradeAnim_ClearTilemap
	ld a, HIGH(vBGMap1)
	ldh [hBGMapAddress + 1], a
	hlcoord 5, 0
	ld b, 6
	ld c, 9
	call Textbox
	hlcoord 6, 2
	ld de, .EggTemplate
	call PlaceString
	call MobileTradeAnim_MonDisplay_UpdateBGMap
	ret

.EggTemplate:
	db   "タマゴ"
	next "おや/？？？？？"
	next "<ID>№<DOT>？？？？？"
	db   "@"

MobileTradeAnim_LoadMonTemplate:
	call WaitTop
	call MobileTradeAnim_ClearTilemap
	ld a, HIGH(vBGMap1)
	ldh [hBGMapAddress + 1], a
	hlcoord 4, 0
	ld b,  6
	ld c, 10
	call Textbox
	hlcoord 5, 0
	ld de, .MonTemplate
	call PlaceString
	ret

.MonTemplate:
	db   "─　№<DOT>"
	next ""
	next "おや／"
	next "<ID>№<DOT>"
	db   "@"

MobileTradeAnim_MonDisplay_UpdateBGMap:
	call WaitBGMap
	call WaitTop
	ld a, HIGH(vBGMap0)
	ldh [hBGMapAddress + 1], a
	ret

MobileTradeAnim_MonDisplay_PrintSpeciesNumber:
	hlcoord 9, 0
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNum
	ret

MobileTradeAnim_MonDisplay_PrintSpeciesName:
	hlcoord 5, 2
	call PlaceString
	ret

MobileTradeAnim_MonDisplay_PrintOTNameAndGender:
	cp $3
	jr c, .got_gender
	xor a
.got_gender
	push af
	hlcoord 8, 4
	call PlaceString
	inc bc
	pop af
	ld hl, .GenderChars
	ld d, 0
	ld e, a
	add hl, de
	ld a, [hl]
	ld [bc], a
	ret

.GenderChars:
	db " "
	db "♂"
	db "♀"

MobileTradeAnim_MonDisplay_PrintIDNumber:
	hlcoord 8, 6
	lb bc, PRINTNUM_LEADINGZEROS | 2, 5
	call PrintNum
	ret

MobileTradeAnim_ClearTilemap:
	hlcoord 0, 0
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	ld a, " "
	call ByteFill
	ret

Function108af4:
	ldh a, [rSVBK]
	push af
	ld a, $5
	ldh [rSVBK], a
	ld a, [wcf65]
	and $1
	jr z, .copy_MobileTradeOB1Palettes
	ld hl, MobileTradeOB2Palettes
	ld de, wOBPals1
	ld bc, 8 palettes
	call CopyBytes
	ld hl, MobileTradeOB2Palettes
	ld de, wOBPals2
	ld bc, 8 palettes
	call CopyBytes
	jr .done_copy

.copy_MobileTradeOB1Palettes
	ld hl, MobileTradeOB1Palettes
	ld de, wOBPals1
	ld bc, 8 palettes
	call CopyBytes
	ld hl, MobileTradeOB1Palettes
	ld de, wOBPals2
	ld bc, 8 palettes
	call CopyBytes

.done_copy
	pop af
	ldh [rSVBK], a
	ld a, %11100100 ; 3,2,1,0
	call DmgToCgbObjPal0
	ld a, %11100100 ; 3,2,1,0
	call DmgToCgbBGPals
	call DelayFrame
	ret

Function108b45:
	ldh a, [rSVBK]
	push af
	ld a, $5
	ldh [rSVBK], a
	ld de, PALRGB_WHITE
	ld hl, wBGPals1
	ld a, e
	ld [hli], a
	ld d, a
	ld [hli], a
	pop af
	ldh [rSVBK], a
	ret

Function108b78:
	ldh a, [rSVBK]
	push af
	ld a, $5
	ldh [rSVBK], a
	ld a, c
	and $2
	jr z, .Orange
	ld de, PALRGB_WHITE
	jr .load_pal

.Orange:
	ld de, palred 31 + palgreen 15 + palblue 1
.load_pal
	ld a, e
	ld [hli], a
	ld a, d
	ld [hld], a
	pop af
	ldh [rSVBK], a
	ld a, TRUE
	ldh [hCGBPalUpdate], a
	ret

Palette_108b98:
; removed

Function108b98:
	ld d, a
	ldh a, [rSVBK]
	push af
	ld a, $5
	ldh [rSVBK], a
	ld a, [wcf65]
	and $1
	xor d
	jr z, .asm_108bad
	ld hl, Palette_108b98 palette 1
	jr .asm_108bb0

.asm_108bad
	ld hl, Palette_108b98
.asm_108bb0
	ld de, wBGPals1 palette 7
	ld bc, 8 palettes
	call CopyBytes
	pop af
	ldh [rSVBK], a
	ret

Function108c16:
	ld a, $90
	ldh [hWY], a
	ld hl, .MobileTakeGoodCareOfMonText
	call PrintText
	ld c, 80
	call DelayFrames
	ret

.MobileTakeGoodCareOfMonText:
	text_far _MobileTakeGoodCareOfMonText
	text_end

Function108c2b:
	ld a, $90
	ldh [hWY], a
	ld hl, .MobilePlayersMonTrade2Text
	call PrintText
	ld c, 80
	call DelayFrames
	ret

.MobilePlayersMonTrade2Text:
	text_far _MobilePlayersMonTrade2Text
	text_end

Function108c40:
	ld a, $90
	ldh [hWY], a
	ld a, [wcf65]
	and %10000000
	jr z, .Getmon
	ld hl, .MobileTradeCameBackText
	call PrintText
	ld c, 80
	call DelayFrames
	ret

.Getmon:
	ld hl, .MobileTakeGoodCareOfText
	call PrintText
	ld c, 80
	call DelayFrames
	ret

.MobileTakeGoodCareOfText:
	text_far _MobileTakeGoodCareOfText
	text_end

.MobileTradeCameBackText:
	text_far _MobileTradeCameBackText
	text_end

MobileTradeOB1Palettes:
INCLUDE "gfx/mobile/mobile_trade_ob1.pal"

MobileTradeOB2Palettes:
INCLUDE "gfx/mobile/mobile_trade_ob2.pal"
