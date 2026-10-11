DEF MAP_NAME_SIGN_START EQU $c0

; number of tiles in each map sign frame (see Signs in gfx/font.asm)
DEF NUM_SIGN_TILES EQU 8

; wLandmarkSignTimer
DEF MAPSIGNSTAGE_1_SLIDEOLD EQU $63
DEF MAPSIGNSTAGE_2_LOADGFX  EQU $57
DEF MAPSIGNSTAGE_3_SLIDEIN  EQU $54
DEF MAPSIGNSTAGE_4_VISIBLE  EQU $48
DEF MAPSIGNSTAGE_5_SLIDEOUT EQU $0c

InitMapNameSign::
	xor a
	ldh [hBGMapMode], a
	ld a, [wMapGroup]
	ld b, a
	ld a, [wMapNumber]
	ld c, a
	call GetWorldMapLocation
	ld [wCurLandmark], a
	call .CheckNationalParkGate
	jr z, .gate

	call GetMapEnvironment
	cp GATE
	jr nz, .not_gate

.gate
	ld a, -1
	ld [wCurLandmark], a

.not_gate
	ld hl, wEnteredMapFromContinue
	bit 1, [hl]
	res 1, [hl]
	jr nz, .dont_do_map_sign

	call .CheckMovingWithinLandmark
	jr z, .dont_do_map_sign
	ld a, [wCurLandmark]
	ld [wPrevLandmark], a

	call .CheckSpecialMap
	jr z, .dont_do_map_sign

; Landmark sign timer: descends $64-$00
; $62-$57: Sliding out (old sign)
; $56-$54: Loading new graphics
; $53-$48: Sliding in
; $47-$0c: Remains visible
; $0b-$00: Sliding out
	ld a, [wLandmarkSignTimer]
	sub MAPSIGNSTAGE_2_LOADGFX
	jr nc, .stage_1_sliding_out
	add MAPSIGNSTAGE_2_LOADGFX
	cp MAPSIGNSTAGE_5_SLIDEOUT
	jr c, .stage_1_sliding_out
	sub MAPSIGNSTAGE_4_VISIBLE
	jr c, .stage_4_visible
	cp MAPSIGNSTAGE_5_SLIDEOUT
	jr c, .stage_3_sliding_in
	; was in stage 2, loading new graphics; just reload them again
	ld a, MAPSIGNSTAGE_2_LOADGFX
	jr .value_ok

.stage_1_sliding_out
	add MAPSIGNSTAGE_2_LOADGFX
	jr .value_ok

.stage_3_sliding_in
	cpl
	add MAPSIGNSTAGE_1_SLIDEOLD + 1 ; a = MAPSIGNSTAGE_1_SLIDEOLD - a
	jr .value_ok

.stage_4_visible
	ld a, MAPSIGNSTAGE_1_SLIDEOLD
.value_ok
	ld [wLandmarkSignTimer], a
	ret

.dont_do_map_sign
	ld a, [wCurLandmark]
	ld [wPrevLandmark], a
	ld a, $90
	ldh [rWY], a
	ldh [hWY], a
	ld a, RETI_INSTRUCTION
	ld [hFunctionInstruction], a
	xor a
	ldh [hLCDCPointer], a
	ret

.CheckMovingWithinLandmark:
	ld a, [wCurLandmark]
	ld c, a
	ld a, [wPrevLandmark]
	cp c
	ret z
	cp LANDMARK_SPECIAL
	ret

.CheckSpecialMap:
; These landmarks do not get pop-up signs.
	cp -1
	ret z
	cp LANDMARK_SPECIAL ; redundant check
	ret z
	ld a, 1
	and a
	ret

.CheckNationalParkGate:
	ld a, [wMapGroup]
	cp GROUP_ROUTE_7_NATIONAL_PARK_GATE
	ret nz
	ld a, [wMapNumber]
	cp MAP_ROUTE_7_NATIONAL_PARK_GATE
	ret z
	cp MAP_ROUTE_8_NATIONAL_PARK_GATE
	ret

PlaceMapNameSign::
	; Sign is slightly delayed to move it away from the map connection setup
	ld hl, wLandmarkSignTimer
	ld a, [hl]
	and a
	jr z, .stage_5_sliding_out
	dec [hl]
	sub MAPSIGNSTAGE_2_LOADGFX
	jr nc, .stage_5_sliding_out
	add MAPSIGNSTAGE_2_LOADGFX
	cp MAPSIGNSTAGE_2_LOADGFX - 1
	ret nc
	sub MAPSIGNSTAGE_3_SLIDEIN
	jr c, .graphics_ok
	jr nz, LoadMapNameSignGFX
	push hl
	call InitMapNameFrame
	call PlaceMapNameCenterAlign
	farcall HDMATransfer_OnlyTopFourRows
	pop hl

.graphics_ok
	ld a, [hl]
	cp MAPSIGNSTAGE_4_VISIBLE
	jr nc, .stage_3_sliding_in
	cp MAPSIGNSTAGE_5_SLIDEOUT
	jr c, .stage_5_sliding_out
	ld a, SCREEN_HEIGHT_PX - 4 * TILE_WIDTH
	jr .got_value

.stage_3_sliding_in
	sub MAPSIGNSTAGE_4_VISIBLE
	add a
	add SCREEN_HEIGHT_PX - 4 * TILE_WIDTH
	jr .got_value

.stage_5_sliding_out
	add a
	cpl
	add SCREEN_HEIGHT_PX + 2 * TILE_WIDTH + 1 ; a = SCREEN_HEIGHT_PX + TILE_WIDTH - a
.got_value
	ldh [rWY], a
	ldh [hWY], a
;	ld a, RETI_INSTRUCTION
;	ld [hFunctionInstruction], a
;	xor a
;	ldh [hLCDCPointer], a
;	ret
	sub SCREEN_HEIGHT_PX
	ret nz
	ldh [hLCDCPointer], a
	ret

LoadMapNameSignGFX:
; Load the current map's sign tiles and palette.
	ld hl, Signs
	ld bc, NUM_SIGN_TILES tiles
	ld a, [wSign]
	call AddNTimes
	ld d, h
	ld e, l
	ld hl, vTiles0 tile (MAP_NAME_SIGN_START + 1)
	lb bc, BANK(Signs), NUM_SIGN_TILES
	call Get2bpp
	; copy the sign palette over the text palette
	ld hl, SignPals
	ld bc, 1 palettes
	ld a, [wSign]
	call AddNTimes
	ld de, wBGPals1 palette PAL_BG_TEXT
	call FarCopyColorWRAM
	; A weather fade lerps the BG palettes over several frames; don't
	; snap them here, or the transition flashes.
	ldh a, [hCGB]
	and a
	jr nz, .check_fade
	jp SetDefaultBGPAndOBP
.check_fade
	ld a, [wWeatherFlags]
	bit WEATHER_FADE_ACTIVE_F, a
	jr nz, .fade_active
	jp SetDefaultBGPAndOBP
.fade_active
	; The fade owns the BG palettes; just request an upload so the
	; new text palette takes effect.
	ld a, TRUE
	ldh [hCGBPalUpdate], a
	ret

SignPals:
	table_width 1 palettes, SignPals
INCLUDE "gfx/signs/signs.pal"
	assert_table_length NUM_SIGNS

InitMapNameFrame:
	hlcoord 0, 0, wAttrmap
	lb bc, 5, SCREEN_WIDTH
	call InitMapSignAttrmap
	; the sign's right column reuses the left column's tiles,
	; flipped via attributes
	ld de, SCREEN_WIDTH
	ld b, 4
	hlcoord 19, 0, wAttrmap
.flip_column
	ld a, [hl]
	or X_FLIP
	ld [hl], a
	add hl, de
	dec b
	jr nz, .flip_column
	jmp PlaceMapNameFrame

PlaceMapNameCenterAlign:
	ld a, [wCurLandmark]
	ld e, a
	farcall GetLandmarkName
	call .GetNameLength
	ld a, SCREEN_WIDTH
	sub c
	srl a
	ld b, 0
	ld c, a
	hlcoord 0, 1
	add hl, bc
	ld de, wStringBuffer1
	call PlaceString

	; check weather and print
	hlcoord 1, 2
	ld a, [wFieldWeather]
	cp WEATHER_RAIN
	jr z, .Raining
	cp WEATHER_SUN
	jr z, .Sunny
	cp WEATHER_SANDSTORM
	jr z, .Sandstorm
	cp WEATHER_HAIL
	ret nz

;.Hailing:
	ld de, .HailingStr
	jr .print_weather

.Raining:
	ld de, .RainingStr
	jr .print_weather

.Sunny:
	ld de, .SunnyStr
	jr .print_weather

.Sandstorm:
	ld de, .SandstormStr
	; fallthrough

.print_weather:
	jmp PlaceString

.GetNameLength:
	ld c, 0
	push hl
	ld hl, wStringBuffer1
.loop
	ld a, [hli]
	cp "@"
	jr z, .stop
	cp "<WBR>"
	jr z, .loop
	inc c
	jr .loop
.stop
	pop hl
	ret

.RainingStr:
	db "Raining@"
.SunnyStr:
	db "Sunny@"
.HailingStr:
	db "Hailing@"
.SandstormStr:
	db "Sandstorm@"

InitMapSignAttrmap:
	ld a, PAL_BG_TEXT | PRIORITY
.loop
	push bc
.inner_loop
	ld [hli], a
	dec c
	jr nz, .inner_loop
	pop bc
	dec b
	jr nz, .loop
	ret

PlaceMapNameFrame:
	hlcoord 0, 0
	; top left
	ld a, MAP_NAME_SIGN_START + 1
	ld [hli], a
	; top row
	ld a, MAP_NAME_SIGN_START + 2
	call .FillTopBottom
	; top right
	ld a, MAP_NAME_SIGN_START + 1
	ld [hli], a
	; left, first line
	ld a, MAP_NAME_SIGN_START + 4
	ld [hli], a
	; first line
	call .FillMiddle
	; right, first line
	ld a, MAP_NAME_SIGN_START + 5
	ld [hli], a

	; left, second line
	ld a, MAP_NAME_SIGN_START + 4
	ld [hli], a
	call .FillMiddle
	ld a, MAP_NAME_SIGN_START + 5
	ld [hli], a

	; bottom left
	ld a, MAP_NAME_SIGN_START + 6
	ld [hli], a
	; bottom
	ld a, MAP_NAME_SIGN_START + 7
	call .FillTopBottom
	; bottom right
	ld a, MAP_NAME_SIGN_START + 6
	ld [hl], a
	ret

.FillMiddle:
	ld c, SCREEN_WIDTH - 2
	ld a, MAP_NAME_SIGN_START + 13
.loop
	ld [hli], a
	dec c
	jr nz, .loop
	ret

.FillTopBottom:
	ld c, (SCREEN_WIDTH - 2) / 4 + 1
	jr .enterloop

.continueloop
	ld [hli], a
	ld [hli], a

.enterloop
	inc a
	ld [hli], a
	ld [hli], a
	dec a
	dec c
	jr nz, .continueloop
	ret
