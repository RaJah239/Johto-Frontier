SetRAMStateForMobile:
	xor a
	ld hl, wBGMapBuffer
	ld bc, $65
	call ByteFill
	xor a
	ld hl, wMobileWRAM
	ld bc, wMobileWRAMEnd - wMobileWRAM
	call ByteFill
	ldh a, [rIE]
	ld [wBGMapBuffer], a
	ld a, RETI_INSTRUCTION
	ld [hFunctionInstruction], a
	xor a
	ldh [hMapAnims], a
	ldh [hLCDCPointer], a
	ret

EnableMobile:
	xor a
	ld hl, wOverworldMapBlocks
	ld bc, wOverworldMapBlocksEnd - wOverworldMapBlocks
	call ByteFill

	di
	call DoubleSpeed
	xor a
	ldh [rIF], a
	ld a, IE_DEFAULT
	ldh [rIE], a
	ld a, RETI_INSTRUCTION
	ld [hFunctionInstruction], a
	xor a
	ldh [hMapAnims], a
	ldh [hLCDCPointer], a
	ld a, $01
	ldh [hMobileReceive], a
	ldh [hMobile], a
	ei

	ret

DisableMobile:
	di
	xor a
	ldh [hMobileReceive], a
	ldh [hMobile], a
	xor a
	ldh [hVBlank], a
	call NormalSpeed
	xor a
	ldh [rIF], a
	ld a, [wBGMapBuffer]
	ldh [rIE], a
	reti

Function10032e:
	call Function10034d
	ld e, a
	ret nc
	ld [wcd2b], a
	ret

Function10034d:
	ld a, [wc821]
	bit 1, a
	jr nz, .asm_10036a
	bit 2, a
	jr nz, .asm_10037e
	bit 3, a
	jr nz, .asm_100366
	bit 0, a
	jr nz, .asm_100364
	ld a, $01
	and a
	ret

.asm_100364
	xor a
	ret

.asm_100366
	ld a, $02
	and a
	ret

.asm_10036a
	ld a, MOBILEAPI_00
	call MobileAPI
	ld [wcd2c], a
	ld a, h
	ld [wcd2d], a
	ld a, l
	ld [wcd2e], a
	ld a, $ff
	scf
	ret

.asm_10037e
	ld a, $fe
	scf
	ret

AdvanceMobileInactivityTimerAndCheckExpired:
	push bc
	call IncrementMobileInactivityTimerByCFrames
	pop bc
	ld a, [wMobileInactivityTimerMinutes]
	cp b
	jr nc, .timed_out
	and a
	ret

.timed_out
	ld a, $fa
	ld [wcd2b], a
	scf
	ret

IncrementMobileInactivityTimerByCFrames:
	ld hl, wMobileInactivityTimerFrames ; timer?
	ld a, [hl]
	add c
	cp 60
	jr c, .seconds
	xor a

.seconds
	ld [hld], a
	ret c
	ld a, [hl]
	inc a
	cp 60
	jr c, .minutes
	xor a

.minutes
	ld [hld], a
	ret c
	inc [hl]
	ret

Function1006dc:
	ld a, [hld]
	ld c, a
	ldh a, [hSeconds]
	sub c
	jr nc, .asm_1006e5
	add $3c

.asm_1006e5
	ld [de], a
	dec de
	ld a, [hld]
	ld c, a
	ldh a, [hMinutes]
	sbc c
	jr nc, .asm_1006f0
	add $3c

.asm_1006f0
	ld [de], a
	dec de
	ld a, [hl]
	ld c, a
	ldh a, [hHours]
	sbc c
	jr nc, .asm_1006fb
	add MAX_HOUR

.asm_1006fb
	ld [de], a
	ret

Function10079c:
	ld a, [wcd21]
	cp $01
	jr nz, .dont_quit
	ld hl, wcd2a
	bit 5, [hl]
	jr nz, .dont_quit
	ld hl, wcd2a
	bit 6, [hl]
	jr nz, .dont_quit
	ld a, [wcd6a]
	add c
	cp 60
	jr nc, .overflow
	ld [wcd6a], a
	and a
	ret

.overflow
	sub 60
	ld [wcd6a], a
	ld d, b
	push de
	call Function1007f6
	pop de
	jr c, .quit
	ld a, c
	and a
	jr nz, .quit
	ld a, b
	cp 10
	jr nc, .quit
	ld a, d
	and a
	ret z
	ld a, [wcd6b]
	cp b
	ret z
	ld a, b
	ld [wcd6b], a
	call Function1008e0
	and a
	ret

.quit
	call Function1008e0
	ld hl, wcd2a
	set 4, [hl]
	ld a, $fc
	ld [wcd2b], a
	scf
	ret

.dont_quit
	and a
	ret

Function1007f6:
	call UpdateTime
	ld hl, wcd74
	ld de, wcd71
	call Function1006dc
	ld a, $04
	call OpenSRAM
	ld hl, $a802
	call Function100826
	call CloseSRAM
	ld hl, wcd6e
	call Function100826
	ldh a, [hHours]
	ld [wcd72], a
	ldh a, [hMinutes]
	ld [wcd73], a
	ldh a, [hSeconds]
	ld [wcd74], a
	ret

Function100826:
	ld a, [wcd71]
	add [hl]
	sub $3c
	jr nc, .asm_100830
	add $3c

.asm_100830
	ld [hld], a
	ccf
	ld a, [wcd70]
	adc [hl]
	sub $3c
	jr nc, .asm_10083c
	add $3c

.asm_10083c
	ld [hld], a
	ld b, a
	ccf
	ld a, [wcd6f]
	adc [hl]
	ld [hl], a
	ld c, a
	ret

Function1008e0:
	ldh a, [hBGMapMode]
	ld b, a
	ldh a, [hVBlank]
	ld c, a
	push bc
	xor a
	ldh [hBGMapMode], a
	ld a, $03
	ldh [hVBlank], a
	call Function100970
	call Function100902
	call Function100989
	call DelayFrame
	pop bc
	ld a, c
	ldh [hVBlank], a
	ld a, b
	ldh [hBGMapMode], a
	ret

Function100902:
	hlcoord 3, 10
	ld b, $01
	ld c, $0b
	call Textbox
	ld a, [wcd6d]
	ld c, a
	ld a, $0a
	sub c
	ld [wStringBuffer2], a
	jr z, .asm_10093f
	ld de, .string_100966
	hlcoord 4, 11
	call PlaceString
	hlcoord 8, 11
	lb bc, 1, 2
	ld de, wStringBuffer2
	call PrintNum
	ld de, SFX_TWO_PC_BEEPS
	call PlaySFX
	farcall HDMATransferTilemapAndAttrmap_Overworld
	ld c, $3c
	call DelayFrames
	ret

.asm_10093f
	ld de, .string_10095a
	hlcoord 4, 11
	call PlaceString
	ld de, SFX_4_NOTE_DITTY
	call PlaySFX
	farcall HDMATransferTilemapAndAttrmap_Overworld
	ld c, 120
	call DelayFrames
	ret

.string_10095a
	db "たいせん　しゅうりょう@"
.string_100966
	db "のこり　　　ふん！@"

Function100970:
	hlcoord 0, 0
	ld de, w3_dc00
	call Function1009a5
	hlcoord 0, 0, wAttrmap
	ld de, w3_dd68
	call Function1009a5
	call Function1009d2
	call Function1009ae
	ret

Function100989:
	ld hl, w3_dc00
	decoord 0, 0
	call Function1009a5
	call Function1009ae
	farcall HDMATransferTilemapAndAttrmap_Overworld
	ld hl, w3_dd68
	decoord 0, 0, wAttrmap
	call Function1009a5
	ret

Function1009a5:
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	ld a, $03
	call FarCopyWRAM
	ret

Function1009ae:
	ldh a, [rSVBK]
	push af
	ld a, $03
	ldh [rSVBK], a

	ld hl, w3_d800
	decoord 0, 0, wAttrmap
	ld c, SCREEN_WIDTH
	ld b, SCREEN_HEIGHT
.loop_row
	push bc
.loop_col
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .loop_col
	ld bc, BG_MAP_WIDTH - SCREEN_WIDTH
	add hl, bc
	pop bc
	dec b
	jr nz, .loop_row

	pop af
	ldh [rSVBK], a
	ret

Function1009d2:
	ldh a, [rSVBK]
	push af
	ld a, $03
	ldh [rSVBK], a

	ldh a, [rVBK]
	push af
	ld a, $01
	ldh [rVBK], a

	ld hl, w3_d800
	debgcoord 0, 0
	lb bc, $03, $24
	call Get2bpp

	pop af
	ldh [rVBK], a

	pop af
	ldh [rSVBK], a
	ret

Function1009f3:
	ldh a, [hJoyDown]
	and SELECT + A_BUTTON
	cp SELECT + A_BUTTON
	jr nz, .select_a
	ld hl, wcd2a
	set 4, [hl]
	ld a, $f8
	ld [wcd2b], a
	scf
	ret

.select_a
	xor a
	ret

Function100db0:
	ld hl, wcd2a
	bit 3, [hl]
	jr nz, .asm_100dbe
	ld hl, wcd2a
	set 3, [hl]
	scf
	ret

.asm_100dbe
	xor a
	ret

Function100dc0:
	ld a, [wLinkMode]
	cp LINK_MOBILE
	jr nz, .mobile
	ld hl, wcd2a
	bit 3, [hl]
	jr z, .mobile
	scf
	ret

.mobile
	xor a
	ret

Mobile_SetOverworldDelay:
	ld a, 30
	ld [wOverworldDelay], a
	ret

Function100dd8:
	ld c, $01
	ld b, $03
	farcall AdvanceMobileInactivityTimerAndCheckExpired
	jr c, .asm_100dfb
	ld c, $3c
	ld b, $01
	call Function10079c
	jr c, .asm_100dfb
	farcall Function10032e
	ld a, [wcd2b]
	and a
	jr nz, .asm_100dfb
	xor a
	ret

.asm_100dfb
	scf
	ret

MobileComms_CheckInactivityTimer:
	ld a, [wOverworldDelay]
	ld c, a
	ld a, 30
	sub c
	ld c, a
	ld b, 3
	push bc
	farcall AdvanceMobileInactivityTimerAndCheckExpired ; useless to farcall
	pop bc
	jr c, .quit
	ld b, 1
	call Function10079c
	jr c, .quit
	call Function1009f3
	jr c, .quit
	farcall Function10032e ; useless to farcall
	ld a, [wcd2b]
	and a
	jr nz, .quit
	xor a
	ret

.quit
	scf
	ret

Function100f3d:
	; parameter
	ld a, [wStringBuffer2]
	cp $02
	jr z, .two
	cp $01
	jr z, .one
	cp $03
	jr z, .three
	ret

.three
	; what was once in de gets copied to hl,
	; modified by Function100f8d, and put back
	; into this backup
	ld a, [wStringBuffer2 + 1]
	ld l, a
	ld a, [wStringBuffer2 + 2]
	ld h, a
	call Function100f8d
	ld a, l
	ld [wStringBuffer2 + 1], a
	ld a, h
	ld [wStringBuffer2 + 2], a
	ret

.two
	; hl gets backed up to de, then
	; do the same as in .three
	ld d, h
	ld e, l
	ld a, [wStringBuffer2 + 1]
	ld l, a
	ld a, [wStringBuffer2 + 2]
	ld h, a
	call Function100f8d
	ld a, l
	ld [wStringBuffer2 + 1], a
	ld a, h
	ld [wStringBuffer2 + 2], a
	ret

.one
	; de gets copied to hl, then
	; load the backup into de,
	; finally run Function100f8d
	; and store the de result
	ld h, d
	ld l, e
	ld a, [wStringBuffer2 + 1]
	ld e, a
	ld a, [wStringBuffer2 + 2]
	ld d, a
	call Function100f8d
	ld a, e
	ld [wStringBuffer2 + 1], a
	ld a, d
	ld [wStringBuffer2 + 2], a
	ret

Function100f8d:
	push hl
	ld a, [wStringBuffer2 + 4]
	ld l, a
	ld a, [wStringBuffer2 + 5]
	ld h, a
	add hl, bc
	ld a, l
	ld [wStringBuffer2 + 4], a
	ld a, h
	ld [wStringBuffer2 + 5], a
	pop hl
	ld a, [wStringBuffer2 + 3]
	bit 7, a
	res 7, a
	jr z, .sram
	and a
	jr nz, .far_wram
	call CopyBytes
	ret

.far_wram
	and $7f
	call FarCopyWRAM
	ret

.sram
	call OpenSRAM
	call CopyBytes
	call CloseSRAM
	ret
