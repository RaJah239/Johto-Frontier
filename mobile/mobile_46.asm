BattleTowerRoomMenu_DoNothing:
	ret

_BattleTowerRoomMenu:
	xor a
	ld [wcd38], a
	call BattleTowerRoomMenu_InitRAM
	ld a, $3
	ld [wcd33], a
	ld a, $d
	ld [wcd34], a
	ld a, $4
	ld [wc3f0], a
	ldh a, [rSVBK]
	push af
	ld a, $3
	ldh [rSVBK], a
.loop
	call JoyTextDelay
	call Function118473
	ld a, [wBattleTowerRoomMenuJumptableIndex]
	cp $f
	jr c, .skip
	ld a, [wcd34]
	ld [wBattleTowerRoomMenuJumptableIndex], a
.skip
	call BattleTowerRoomMenu_Jumptable
	call BattleTowerRoomMenu_WriteMessage
	call DelayFrame
	ld a, [wBattleTowerRoomMenuJumptableIndex]
	ld hl, wcd33
	cp [hl]
	jr nz, .loop
	xor a
	ld [w3_d000], a
	pop af
	ldh [rSVBK], a
	call BattleTowerRoomMenu_Cleanup
	call Function118180 ; remove this
	call ReturnToMapFromSubmenu
	ret

Function118180: ; remove this
	ld a, [wScriptVar]
	and a
	ret nz
	ld a, [wcd38]
	and a
	ret z
	ld a, BANK(s5_a89c) ; aka BANK(s5_a8b2)
	call OpenSRAM
	ld hl, wcd69
	ld de, s5_a89c
	ld bc, 22
	call CopyBytes

	ldh a, [rSVBK]
	push af
	ld a, BANK(w3_d202)
	ldh [rSVBK], a

	ld de, w3_d202
	ld c, $96
	farcall CheckStringForErrors_IgnoreTerminator
	jr c, .return_d3

	ld de, w3_d202
	lb bc, 1, $96
	farcall CheckStringContainsLessThanBNextCharacters
	jr c, .return_d3

	ld hl, w3_d202
	ld de, s5_a8b2
	ld bc, 150
	call CopyBytes
.reset_banks
	pop af
	ldh [rSVBK], a
	call CloseSRAM
	ret

.return_d3
	ld a, $d3
	ld [wMobileErrorCodeBuffer], a
	ld [wScriptVar], a
	jr .reset_banks

Function118284:
	call BattleTowerRoomMenu_InitRAM
	ld a, $19
	ld [wcd33], a
	ld a, $1e
	ld [wcd34], a
	ld a, $5
	ld [wc3f0], a
	ldh a, [rSVBK]
	push af
	ld a, $3
	ldh [rSVBK], a
.asm_11829d
	call JoyTextDelay
	call Function118473
	ld a, [wBattleTowerRoomMenuJumptableIndex]
	cp $20
	jr c, .asm_1182b0
	ld a, [wcd34]
	ld [wBattleTowerRoomMenuJumptableIndex], a
.asm_1182b0
	call Function1186f5
	call BattleTowerRoomMenu_WriteMessage
	call DelayFrame
	ld a, [wBattleTowerRoomMenuJumptableIndex]
	ld hl, wcd33
	cp [hl]
	jr nz, .asm_11829d
	pop af
	ldh [rSVBK], a
	call BattleTowerRoomMenu_Cleanup
	ret

Function118329:
	call BattleTowerRoomMenu_InitRAM
	ld a, $15
	ld [wcd33], a
	ld a, $16
	ld [wcd34], a
	ld a, $6
	ld [wc3f0], a
	ldh a, [rSVBK]
	push af
	ld a, $3
	ldh [rSVBK], a
.asm_118342
	call JoyTextDelay
	call Function118473
	ld a, [wBattleTowerRoomMenuJumptableIndex]
	cp $18
	jr c, .asm_118355
	ld a, [wcd34]
	ld [wBattleTowerRoomMenuJumptableIndex], a

.asm_118355
	call Function118671
	call BattleTowerRoomMenu_WriteMessage
	call DelayFrame
	ld a, [wBattleTowerRoomMenuJumptableIndex]
	ld hl, wcd33
	cp [hl]
	jr nz, .asm_118342
	pop af
	ldh [rSVBK], a
	call BattleTowerRoomMenu_Cleanup
	ret

Function11837a:
	call BattleTowerRoomMenu_InitRAM
	ld a, $16
	ld [wcd33], a
	ld a, $17
	ld [wcd34], a
	ld a, $6
	ld [wc3f0], a
	ldh a, [rSVBK]
	push af
	ld a, $3
	ldh [rSVBK], a
.asm_118393
	call JoyTextDelay
	call Function118473
	ld a, [wBattleTowerRoomMenuJumptableIndex]
	cp $19
	jr c, .asm_1183a6
	ld a, [wcd34]
	ld [wBattleTowerRoomMenuJumptableIndex], a

.asm_1183a6
	call Function1186b2
	call BattleTowerRoomMenu_WriteMessage
	call DelayFrame
	ld a, [wBattleTowerRoomMenuJumptableIndex]
	ld hl, wcd33
	cp [hl]
	jr nz, .asm_118393
	pop af
	ldh [rSVBK], a
	call BattleTowerRoomMenu_Cleanup
	ret

BattleTowerRoomMenu_InitRAM:
	di
	ldh a, [rIE]
	ld [wcd32], a
	call DoubleSpeed
	xor a
	ldh [rIF], a
	ld [wMobileErrorCodeBuffer], a
	ld [wMobileErrorCodeBuffer + 1], a
	ld [wMobileErrorCodeBuffer + 2], a
	ld [wcd80], a
	ld [wcd65], a
	ld [wcd66], a
	ld [wcd67], a
	ld [wcd68], a
	ld [wc31a], a
	ld [wcd89], a
	ld [wcd8a], a
	ld [wcd8b], a
	ld [wc3ec], a
	ld [wc3ed], a
	ld [wc3ee], a
	ld [wc3ef], a
	ld hl, wStateFlags
	ld a, [hl]
	ld [wcd7f], a
	set LAST_12_SPRITE_OAM_STRUCTS_RESERVED_F, [hl]
	ld a, (1 << SERIAL) | (1 << TIMER) | (1 << LCD_STAT) | (1 << VBLANK)
	ldh [rIE], a
	ld a, $1
	ldh [hMobileReceive], a
	ldh [hMobile], a
	ei
	jmp CloseSRAM

BattleTowerRoomMenu_Cleanup:
	di
	xor a
	ldh [hMobileReceive], a
	ldh [hMobile], a
	ldh [hVBlank], a
	call DoubleSpeed
	xor a
	ldh [rIF], a
	ld a, [wcd32]
	ldh [rIE], a
	ei
	ld a, [wcd7f]
	ld [wStateFlags], a
	ld a, [wMobileErrorCodeBuffer]
	ld [wScriptVar], a
	ret

Function118473:
	ld a, [wcd65]
	and a
	ret z
	ld a, [wcd66]
	inc a
	ld [wcd66], a
	cp 60
	ret nz
	xor a
	ld [wcd66], a
	ld a, [wcd67]
	inc a
	ld [wcd67], a
	cp 60
	ret nz
	ld a, [wcd68]
	inc a
	ld [wcd68], a
	cp 99
	jr z, .ninety_nine
	xor a
	ld [wcd67], a
	ret

.ninety_nine
	xor a
	ld [wcd65], a
	ret

BattleTowerRoomMenu_Jumptable:
	jumptable .Jumptable, wBattleTowerRoomMenuJumptableIndex

.Jumptable:
	dw BattleTowerRoomMenu_PickLevelMessage
	dw BattleTowerRoomMenu_PlacePickLevelMenu
	dw BattleTowerRoomMenu_UpdatePickLevelMenu
	dw BattleTowerRoomMenu_DoNothing
	dw BattleTowerRoomMenu_PartyMonTopsThisLevelMessage
	dw BattleTowerRoomMenu_WaitForMessage
	dw BattleTowerRoomMenu_DelayRestartMenu
	dw BattleTowerRoomMenu_QuitMessage
	dw BattleTowerRoomMenu_PlaceYesNoMenu
	dw BattleTowerRoomMenu_UpdateYesNoMenu
	dw BattleTowerRoomMenu_UberRestrictionMessage
	dw BattleTowerRoomMenu_WaitForMessage
	dw BattleTowerRoomMenu_DelayRestartMenu
	dw Function118e76 ; mobile
	dw BattleTowerRoomMenu_CallRoomMenu2 ; mobile
	dw Function118e76 ; mobile

Function118671:
	jumptable .Jumptable, wBattleTowerRoomMenuJumptableIndex

.Jumptable:
	dw Function118866
	dw Function118880
	dw Function11878d
	dw Function1188b0
	dw Function11878d
	dw Function1188b8
	dw Function11878d
	dw Function1188c0
	dw Function11878d
	dw Function1188c8
	dw Function11878d
	dw Function118903
	dw Function119380
	dw Function119388
	dw Function1193a0 ; to go
	dw Function11878d
	dw Function118e6d
	dw Function11878d
	dw Function118e76
	dw Function118e7e
	dw Function11878d
	dw BattleTowerRoomMenu_DoNothing
	dw Function118e76
	dw BattleTowerRoomMenu_CallRoomMenu2
	dw Function118e76

Function1186b2:
	jumptable .Jumptable, wBattleTowerRoomMenuJumptableIndex

.Jumptable:
	dw Function118866
	dw Function118880
	dw Function11878d
	dw Function1188b0
	dw Function11878d
	dw Function1188b8
	dw Function11878d
	dw Function1188c0
	dw Function11878d
	dw Function1188c8
	dw Function11878d
	dw Function118903
	dw Function119380
	dw Function1193e3
	dw Function1193fb
	dw Function11878d
	dw Function119413
	dw Function118e6d
	dw Function11878d
	dw Function118e76
	dw Function118e7e
	dw Function11878d
	dw BattleTowerRoomMenu_DoNothing
	dw Function118e76
	dw BattleTowerRoomMenu_CallRoomMenu2
	dw Function118e76

Function1186f5:
	jumptable .Jumptable, wBattleTowerRoomMenuJumptableIndex

.Jumptable:
	dw Function11886a
	dw Function118880
	dw Function11878d
	dw Function1188b0
	dw Function11878d
	dw Function1188b8
	dw Function11878d
	dw Function1188c0
	dw Function11878d
	dw Function1188c8
	dw Function11878d
	dw Function118903
	dw SetStadiumDownloadURL
	dw Function11878d
	dw Function119451
	dw Function1195f8
	dw Function119612
	dw Function119629
	dw Function119648
	dw Function11878d
	dw Function118e6d
	dw Function11878d
	dw Function118e76
	dw Function118e7e
	dw Function11878d
	dw BattleTowerRoomMenu_DoNothing
	dw Function11967d
	dw Function119685
	dw Function119665
	dw Function11966d
	dw Function118e76
	dw BattleTowerRoomMenu_CallRoomMenu2
	dw Function118e76

Function11878d:
	ld a, [wc821]
	bit 1, a
	jr nz, .asm_1187af
	bit 2, a
	jr nz, .asm_1187d1
	bit 0, a
	jr nz, .asm_1187aa
	ld a, [wcd89]
	and $1
	jr z, .asm_1187a7
	ld a, $3
	ldh [rSVBK], a
.asm_1187a7
	jmp BattleTowerRoomMenu_IncrementJumptable
.asm_1187aa
	call Function118821
	ret
.asm_1187af
	ld a, MOBILEAPI_00
	call MobileAPI
	ld [wMobileErrorCodeBuffer], a
	ld a, l
	ld [wMobileErrorCodeBuffer + 1], a
	ld a, h
	ld [wMobileErrorCodeBuffer + 2], a
	ld a, MOBILEAPI_05
	call MobileAPI
	ld a, [wc3f0]
	ld [wc319], a
	ld a, [wcd34]
	ld [wBattleTowerRoomMenuJumptableIndex], a
	ret
.asm_1187d1
	ld hl, wcd89
	bit 0, [hl]
	jr nz, .asm_118803
	set 0, [hl]
	ld a, BANK(w6_d000)
	ldh [rSVBK], a
	ld de, w6_d000
	ld bc, $1000
	ld a, [hl]
	add a
	jr c, .asm_1187f9
	add a
	jr c, .asm_1187fd
	add a
	jr c, .asm_1187f5
	ld a, MOBILEAPI_12
	jr .asm_1187ff
.asm_1187f5
	ld a, MOBILEAPI_14
	jr .asm_1187ff
.asm_1187f9
	ld a, MOBILEAPI_15
	jr .asm_1187ff
.asm_1187fd
	ld a, MOBILEAPI_16
.asm_1187ff
	call MobileAPI
	ret
.asm_118803
	ld a, $d3

SetMobileErrorCode:
	ld [wMobileErrorCodeBuffer], a
	xor a
	ld [wMobileErrorCodeBuffer + 1], a
	ld [wMobileErrorCodeBuffer + 2], a
	ld a, MOBILEAPI_05
	call MobileAPI
	ld a, [wc3f0]
	ld [wc319], a
	ld a, [wcd34]
	ld [wBattleTowerRoomMenuJumptableIndex], a
	ret

Function118821:
	ld a, [wc319]
	cp $3
	jr c, .asm_11884a
	cp $4
	jr z, .asm_11884a
	ldh a, [hJoyDown]
	cp $5
	jr nz, .asm_11884a
	ld a, MOBILEAPI_05
	call MobileAPI
	ld a, $a
	ld [wMobileErrorCodeBuffer], a
	ld a, [wc3f0]
	ld [wc319], a
	ld a, [wcd34]
	ld [wBattleTowerRoomMenuJumptableIndex], a
	scf
	ret
.asm_11884a
	and a
	ret

Function118866:
	ld a, 2
	jr asm_11886f

Function11886a:
	ld a, 1
	jr asm_11886f

asm_11886f:
	ld [wBGMapPalBuffer], a
	ld a, $0
	ld [wBattleTowerRoomMenu2JumptableIndex], a
	call BattleTowerRoomMenu_IncrementJumptable
	ld a, [wcd33]
	ld [wMobileInactivityTimerSeconds], a

Function118880:
	call BattleTowerRoomMenu2
	ret c
	xor a
	ld [wcf64], a
	ld [wc807], a
	ld de, wcd81
	ld hl, $46
	ld a, MOBILEAPI_01
	jmp Function119e2b

Function1188b0:
	ld de, wc346
	ld a, MOBILEAPI_06
	jmp Function119e2b

Function1188b8:
	ld de, wc3ac
	ld a, MOBILEAPI_07
	jmp Function119e2b

Function1188c0:
	ld de, wEmailAddress
	ld a, MOBILEAPI_08
	jmp Function119e2b

Function1188c8:
	ld a, $1
	ld [wcd65], a
	ld hl, wc708
.asm_1188d3
	ld a, [de]
	inc de
	ld [hli], a
	and a
	jr nz, .asm_1188d3
	call Function119eb4
	call Function119ec2
	ld hl, wc708
	ld a, MOBILEAPI_03
	jmp Function119e2b

Function118903:
	ld a, [wc3f0]
	ld [wc319], a
	ld c, $1
	farcall Function115e18
	ld a, $8
	ld [wBattleTowerRoomMenu2JumptableIndex], a
	call BattleTowerRoomMenu2
	jmp BattleTowerRoomMenu_IncrementJumptable

BattleTowerRoomMenu_PickLevelMessage:
	call BattleTowerRoomMenu_IncrementJumptable
BattleTowerRoomMenu_PlacePickLevelMenu:
	ld a, [wc31a]
	and a
	ret nz
	ld hl, MenuHeader_119cf7
	call LoadMenuHeader
	call MenuBox
	call MenuBoxCoord2Tile
	call ApplyTilemap
	hlcoord 16, 8, wAttrmap
	ld a, $40
	or [hl]
	ld [hl], a
	call WaitBGMap2
	ld a, $1
	ld [wcd4f], a
	ld a, $1
	ldh [rSVBK], a
	ld hl, Strings_L50 ; Address to list of strings with the choosable levels
	ld a, 2                 ; 10 levels to choose from, including 'Cancel'-option
	ld [wcd4a], a
	ld a, l
	ld [wcd4b], a
	ld a, h
	ld [wcd4c], a
	ld a, $3
	ldh [rSVBK], a
	call BattleTowerRoomMenu_IncrementJumptable

BattleTowerRoomMenu_UpdatePickLevelMenu:
	hlcoord 13, 8
	ld de, String_119d07
	call PlaceString
	hlcoord 13, 10
	ld de, String_119d07
	call PlaceString
	ld a, [wcd4b]
	ld l, a
	ld a, [wcd4c]
	ld h, a
	ld d, $0
	ld a, [wcd4f]
	dec a
	rlca
	rlca
	rlca
	ld e, a
	add hl, de
	ld a, l
	ld e, a
	ld a, h
	ld d, a
	ldh a, [rSVBK]
	push af
	ld a, $1
	ldh [rSVBK], a
	ld bc, wStringBuffer3
.asm_1189b5
	ld a, [hli]
	cp $50
	jr z, .asm_1189c4
	cp $7f
	jr z, .asm_1189c2
	ld [bc], a
	inc bc
	jr .asm_1189b5

.asm_1189c2
	ld a, $50

.asm_1189c4
	ld [bc], a
	pop af
	ldh [rSVBK], a
	hlcoord 13, 9
	call PlaceString
	ld hl, hJoyPressed
	ld a, [hl]
	and B_BUTTON
	jr nz, .b_button
	ld a, [hl]
	and A_BUTTON
	jr nz, .a_button
	ld a, [hl]
	and D_DOWN
	jr nz, .d_down
	ld a, [hl]
	and D_UP
	jr nz, .d_up
.asm_1189e5
	ret

.d_down
	ld hl, wcd4f
	dec [hl]
	jr nz, .asm_1189e5
	ld a, [wcd4a]
	ld [hl], a
	jr .asm_1189e5

.d_up
	ld a, [wcd4a]
	ld hl, wcd4f
	inc [hl]
	cp [hl]
	jr nc, .asm_1189e5
	ld a, $1
	ld [hl], a
	jr .asm_1189e5

.a_button
	call PlayClickSFX
	ld a, [wcd4f]
	ld hl, wcd4a
	cp [hl]
	jr z, .asm_118a3c
	dec a
	and $fe
	srl a
	ld [wcf65], a
	ldh a, [rSVBK]
	push af
	ld a, $1
	ldh [rSVBK], a
	call CloseWindow
	pop af
	ldh [rSVBK], a

	ld a, [wcd4f]
	ld [w3_d800], a
	jmp BattleTowerRoomMenu_IncrementJumptable

.b_button
	call PlayClickSFX

.asm_118a3c
	ldh a, [rSVBK]
	push af
	ld a, $1
	ldh [rSVBK], a
	call CloseWindow
	pop af
	ldh [rSVBK], a
	ld a, $7
	ld [wBattleTowerRoomMenuJumptableIndex], a
	ld a, $0
	ld [wMobileInactivityTimerFrames], a
	ret

SetStadiumDownloadURL:
	ld hl, StadiumDownloadURL
	ld de, wcc60
	ld bc, $80
	call CopyBytes
	ld de, w3_d000
	ld bc, $1000
	jr Function118b10

Function118b10:
	push de
	push bc
	ld a, $8
	ld [wBattleTowerRoomMenu2JumptableIndex], a
	call BattleTowerRoomMenu2
	call Function118b24
	pop bc
	pop de
	ld a, MOBILEAPI_15
	jmp Function119e2b

Function118b24:
	ld hl, wc346
	ld a, LOW(wc708)
	ld [hli], a
	ld a, HIGH(wc708)
	ld [hli], a
	ld a, LOW(wcc60)
	ld [hli], a
	ld a, HIGH(wcc60)
	ld [hli], a
	call Function119eb4
	call Function119ec2 ; to go
	ld a, $80
	ld [wcd89], a
	ld hl, wc346
	ret

pushc
setcharmap ascii

StadiumDownloadURL:
	db "http://gameboy.datacenter.ne.jp/cgb/download?name=/01/CGB-BXTJ/POKESTA/menu.cgb", 0

popc

Function118e39:
	ld a, [hli]
	and a
	jr nz, Function118e39
	dec hl

asm_118e3e:
	ld a, [hld]
	cp $2f
	jr nz, asm_118e3e
	inc hl
	inc hl
	ld de, wcd85
	ld c, $4
.asm_118e4a
	ld a, [hli]
	cp $2e
	jr z, .asm_118e63
	cp $30
	jr c, .asm_118e67
	cp $3a
	jr nc, .asm_118e67
	sub $30
	add $f6
	ld [de], a
	inc de
	dec c
	jr nz, .asm_118e4a
	ld de, wcd85
.asm_118e63
	ld a, $50
	ld [de], a
	ret
.asm_118e67
	ld a, $f3
	ld [de], a
	inc de
	jr .asm_118e63

Function118e6d:
	xor a
	ld [wcd65], a
	ld a, MOBILEAPI_05
	jmp Function119e2b

Function118e76:
	; Call $c in BattleTowerRoomMenu2
	ld a, $c
	ld [wBattleTowerRoomMenu2JumptableIndex], a
	jmp BattleTowerRoomMenu_IncrementJumptable

Function118e7e:
	call BattleTowerRoomMenu2
	ret c
	ld a, MOBILEAPI_1B
	jmp Function119e2b

BattleTowerRoomMenu_CallRoomMenu2:
	call BattleTowerRoomMenu2
	ret c
	ld a, [wcd33]
	ld [wBattleTowerRoomMenuJumptableIndex], a
	ret

Function119192:
	inc b
	inc c
	jr .asm_11919e

.asm_119196
	ld a, [hli]
	ld [de], a
	inc de
	ld a, $bf
	cp d
	jr c, .asm_1191a6

.asm_11919e
	dec c
	jr nz, .asm_119196
	dec b
	jr nz, .asm_119196
	and a
	ret

.asm_1191a6
	ld a, $d3
	call SetMobileErrorCode
	scf
	ret

Function119380:
	ld a, $80
	ld [wcd49], a
	jmp BattleTowerRoomMenu_IncrementJumptable

Function119388:
	ld hl, wcd49
	dec [hl]
	ret nz
	ld hl, wcc60
	call Function118e39
	ld a, $9
	ld [wBattleTowerRoomMenu2JumptableIndex], a
	ld a, $10
	ld [wMobileInactivityTimerSeconds], a
	call BattleTowerRoomMenu_IncrementJumptable

Function1193a0: ; to go
	call BattleTowerRoomMenu2
	ret c
	call DelayFrame
	ld a, $8
	ld [wBattleTowerRoomMenu2JumptableIndex], a
	call BattleTowerRoomMenu2
	ld hl, wc346
	ld a, LOW(w3_d000)
	ld [hli], a
	ld a, HIGH(w3_d000)
	ld [hli], a
	ld a, [wcd3b]
	ld [hli], a
	xor a
	ld [hli], a
	ld a, LOW(wc708)
	ld [hli], a
	ld a, HIGH(wc708)
	ld [hli], a
	ld a, LOW(wcc60)
	ld [hli], a
	ld a, HIGH(wcc60)
	ld [hli], a
	call Function119eb4
	call Function119ec2
	ld a, $40
	ld [wcd89], a
	ld hl, wc346
	ld de, w3_de00
	ld bc, $200
	ld a, MOBILEAPI_16
	jmp Function119e2b

Function1193e3:
	ld hl, wcd49
	dec [hl]
	ret nz
	ld hl, wcc60
	call Function118e39
	ld a, $9
	ld [wBattleTowerRoomMenu2JumptableIndex], a
	ld a, $11
	ld [wMobileInactivityTimerSeconds], a
	call BattleTowerRoomMenu_IncrementJumptable

Function1193fb:
	call BattleTowerRoomMenu2
	ret c
	call DelayFrame
	ld a, $8
	ld [wBattleTowerRoomMenu2JumptableIndex], a
	call BattleTowerRoomMenu2
	ld de, w3_d000
	ld bc, $1000
	jmp Function118b10

Function119413:
	ld a, $6 ; ???
	call OpenSRAM
	ld a, [w3_d000]
	ld c, a
	ld a, [w3_d000 + 1]
	ld b, a
	dec bc
	dec bc
	ld hl, wd002
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	call Function119192
	ret c
	ld a, [wcd89]
	and $1
	jr z, .asm_119447
	ld a, BANK(w6_d000)
	ldh [rSVBK], a
	ld a, [w6_d000]
	ld c, a
	ld a, [w6_d000 + 1]
	ld b, a
	ld hl, w6_d000 + 2
	call Function119192
	ret c

.asm_119447
	ld a, BANK("Battle Tower RAM")
	ldh [rSVBK], a
	call CloseSRAM
	jmp BattleTowerRoomMenu_IncrementJumptable

Function119451:
	ld a, [wcd89]
	and $1
	jr z, .asm_11945d
	ld a, $d3
	jmp SetMobileErrorCode
.asm_11945d
	xor a
	ld [wcd50], a
	call Function119694
	ld a, b
	ld [wcd49], a
	call Function1196cd
	ld a, [wd002]
	ld hl, wd003

Function119471:
	push af
	ld a, [hli]
	ld [wc608], a
	ld a, [hli]
	ld [wc608 + 3], a
	ld a, [hli]
	ld [wc608 + 1], a
	ld a, [hli]
	ld [wc608 + 2], a
	ld a, [hli]
	ld [wc608 + 4], a
	ld a, [hli]
	ld [wc608 + 5], a
	push hl
	ld a, [wc608]
	cp $ff
	jr z, .asm_1194a7
	ld a, [wc608 + 2]
	cp $ff
	jr z, .asm_1194a7
	ld a, [wc608 + 1]
	cp $ff
	jr nz, .asm_1194a7
	call Function119584
	jr c, .asm_11950c
	jr .asm_1194f0
.asm_1194a7
	ld hl, wc608
	ld de, wc608 + 3
	ld c, $3
.asm_1194af
	ld a, [de]
	inc de
	cp [hl]
	inc hl
	jr c, .asm_1194f3
	jr z, .asm_1194b9
	jr nc, .asm_1194bc
.asm_1194b9
	dec c
	jr nz, .asm_1194af
.asm_1194bc
	ld c, $3
	ld hl, wcd49
	ld de, wc608
.asm_1194c4
	ld a, [de]
	inc de
	cp $ff
	jr z, .asm_1194d1
	cp [hl]
	jr z, .asm_1194d1
	jr c, .asm_1194d5
	jr nc, .asm_1194f0
.asm_1194d1
	inc hl
	dec c
	jr nz, .asm_1194c4
.asm_1194d5
	ld c, $3
	ld hl, wcd49
	ld de, wc608 + 3
.asm_1194dd
	ld a, [de]
	inc de
	cp $ff
	jr z, .asm_1194ea
	cp [hl]
	jr c, .asm_1194f0
	jr z, .asm_1194ea
	jr nc, .asm_11950c
.asm_1194ea
	inc hl
	dec c
	jr nz, .asm_1194dd
	jr .asm_11950c
.asm_1194f0
	pop hl
	jr .asm_119557
.asm_1194f3
	ld c, $3
	ld hl, wcd49
	ld de, wc608
.asm_1194fb
	ld a, [de]
	inc de
	cp $ff
	jr z, .asm_119508
	cp [hl]
	jr c, .asm_11950c
	jr z, .asm_119508
	jr nc, .asm_1194d5
.asm_119508
	inc hl
	dec c
	jr nz, .asm_1194fb
.asm_11950c
	pop hl
	ld a, $1
	ld [wcd50], a
	ld a, l
	ld [wc608], a
	ld a, h
	ld [wc608 + 1], a
	ld de, wcd69
	ld c, $10
	ld b, $0
.asm_119521
	ld a, [de]
	inc de
	cp [hl]
	inc hl
	jr nz, .asm_119528
	inc b
.asm_119528
	dec c
	jr nz, .asm_119521
	ld a, $10
	cp b
	jr z, .asm_119536
rept 4
	inc hl
endr
	jr .asm_11957a
.asm_119536
	ld a, [hli]
	cp $50
	jr nz, .asm_119552
	ld a, [hli]
	cp $33
	jr nz, .asm_119553
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	ld a, [wcd83]
	cp c
	jr nz, .asm_119576
	ld a, [wcd84]
	cp b
	jr nz, .asm_119576
	jr .asm_11955b
.asm_119552
	inc hl
.asm_119553
	inc hl
	inc hl
	jr .asm_11955b
.asm_119557
	ld de, $14
	add hl, de
.asm_11955b
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	add hl, de
	pop af
	dec a
	jmp nz, Function119471
	ld a, [wcd50]
	and a
	jr z, .asm_119571
	ld a, $1a
	ld [wBattleTowerRoomMenuJumptableIndex], a
	ret
.asm_119571
	ld a, $d8
	jmp SetMobileErrorCode
.asm_119576
	ld a, $10
	jr .asm_11957c
.asm_11957a
	ld a, $f
.asm_11957c
	ld [wBattleTowerRoomMenuJumptableIndex], a
	pop af
	call Function1195c4
	ret

Function119584:
	ld a, [wc608]
	ld b, a
	ld a, [wc608 + 3]
	ld c, a
	cp b
	jr c, .asm_11959c
	ld a, [wcd49]
	cp b
	jr c, .asm_1195c2
.asm_119595
	cp c
	jr c, .asm_1195a2
	jr z, .asm_1195a2
	jr .asm_1195c2
.asm_11959c
	ld a, [wcd49]
	cp b
	jr c, .asm_119595
.asm_1195a2
	ld a, [wc608 + 2]
	ld b, a
	ld a, [wc608 + 5]
	ld c, a
	cp b
	jr c, .asm_1195ba
	ld a, [wcd4b]
	cp b
	jr c, .asm_1195c2
.asm_1195b3
	cp c
	jr c, .asm_1195c0
	jr z, .asm_1195c0
	jr .asm_1195c2
.asm_1195ba
	ld a, [wcd4b]
	cp b
	jr c, .asm_1195b3
.asm_1195c0
	scf
	ret
.asm_1195c2
	and a
	ret

Function1195c4:
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	ld de, $a5
	ld a, b
	cp d
	jr c, .asm_1195d9
	jr z, .asm_1195d3
	jr nc, .asm_1195f3
.asm_1195d3
	ld a, c
	cp e
	jr z, .asm_1195d9
	jr nc, .asm_1195f3
.asm_1195d9
	ld de, wcc60
	call CopyBytes
	xor a
	ld [de], a
	ld a, [wc608]
	ld l, a
	ld a, [wc608 + 1]
	ld h, a
	ld de, wcd69
	ld bc, $10
	call CopyBytes
	ret
.asm_1195f3
	ld a, $d8
	jmp SetMobileErrorCode

Function1195f8:
	ld a, $11
	ld [wBattleTowerRoomMenu2JumptableIndex], a
	ld a, $1c
	ld [wMobileInactivityTimerSeconds], a
	ld a, $f
	ld [wMobileInactivityTimerFrames], a
	ld a, $14
	ld [wcd47], a
	call BattleTowerRoomMenu_IncrementJumptable
	jmp BattleTowerRoomMenu_IncrementJumptable

Function119612:
	ld a, $14
	ld [wBattleTowerRoomMenu2JumptableIndex], a
	ld a, $1c
	ld [wMobileInactivityTimerSeconds], a
	ld a, $10
	ld [wMobileInactivityTimerFrames], a
	ld a, $14
	ld [wcd47], a
	jmp BattleTowerRoomMenu_IncrementJumptable

Function119629:
	call BattleTowerRoomMenu2
	ret c
	ld a, LOW(wcc60)
	ld l, a
	ld a, HIGH(wcc60)
	ld h, a
	call Function118e39
	ld a, $9
	ld [wBattleTowerRoomMenu2JumptableIndex], a
	ld a, $1c
	ld [wMobileInactivityTimerSeconds], a
	ld a, $14
	ld [wcd47], a
	call BattleTowerRoomMenu_IncrementJumptable

Function119648:
	call BattleTowerRoomMenu2
	ret c
	call DelayFrame
	ld a, $8
	ld [wBattleTowerRoomMenu2JumptableIndex], a
	call BattleTowerRoomMenu2
	call Function118b24
	ld de, w3_d000
	ld bc, $1000
	ld a, MOBILEAPI_15
	jmp Function119e2b

Function119665:
	ld a, $1a
	ld [wBattleTowerRoomMenu2JumptableIndex], a
	call BattleTowerRoomMenu_IncrementJumptable

Function11966d:
	call BattleTowerRoomMenu2
	ret c
	ld a, [wcd47]
	ld [wBattleTowerRoomMenuJumptableIndex], a
	ld a, $a
	ld [wMobileErrorCodeBuffer], a
	ret

Function11967d:
	ld a, $18
	ld [wBattleTowerRoomMenu2JumptableIndex], a
	call BattleTowerRoomMenu_IncrementJumptable

Function119685:
	call BattleTowerRoomMenu2
	ret c
	ld a, $14
	ld [wBattleTowerRoomMenuJumptableIndex], a
	ld a, $a
	ld [wMobileErrorCodeBuffer], a
	ret

Function119694:
	ld b, 0
	ld hl, Unknown_1196b8
.asm_119699
	ld de, wc708
	ld a, [de]
	inc de
	cp [hl]
	inc hl
	jr nz, .asm_1196af
	ld a, [de]
	inc de
	cp [hl]
	inc hl
	jr nz, .asm_1196b0
	ld a, [de]
	inc de
	cp [hl]
	inc hl
	jr nz, .asm_1196b1
	ret
.asm_1196af
	inc hl
.asm_1196b0
	inc hl
.asm_1196b1
	inc b
	ld a, b
	cp $7
	jr nz, .asm_119699
	ret

pushc
setcharmap ascii

Unknown_1196b8:
	db "Mon"
	db "Tue"
	db "Wed"
	db "Thu"
	db "Fri"
	db "Sat"
	db "Sun"

popc

Function1196cd:
	ld de, wc719
	call Function1196de
	ld [wcd4a], a
	inc de
	call Function1196de
	ld [wcd4b], a
	ret

Function1196de:
	ld a, [de]
	inc de
	; b = ([de] - 48) * 2
	; c = ([de] - 48) * 10
	sub $30
	add a
	ld b, a
	add a
	add a
	add b
	ld c, a
	add hl, bc
	ld a, [de]
	inc de
	sub $30
	add c
	ret

BattleTowerRoomMenu_UberRestrictionMessage: ; to go
	ld hl, Text_UberRestriction
	call BattleTowerRoomMenu_SetMessage
	call BattleTowerRoomMenu_IncrementJumptable
	jr BattleTowerRoomMenu_WaitForMessage

BattleTowerRoomMenu_PartyMonTopsThisLevelMessage:
	ld hl, Text_PartyMonTopsThisLevel
	call BattleTowerRoomMenu_SetMessage
	call BattleTowerRoomMenu_IncrementJumptable

BattleTowerRoomMenu_WaitForMessage:
	ld a, [wc31a]
	and a
	ret nz
	ld a, $80
	ld [wcd50], a
	call BattleTowerRoomMenu_IncrementJumptable

BattleTowerRoomMenu_DelayRestartMenu:
	; Loops while (--[wcd50] != 0),
	;   to create some sort of "delay" after the message is written on the screen,
	;   before starting the menu again.
	ld hl, wcd50
	dec [hl]
	ret nz
	ld a, $0
	ld [wBattleTowerRoomMenuJumptableIndex], a
	ret

BattleTowerRoomMenu_QuitMessage:
	ld a, [wcd38]
	and a
	jr z, .asm_119cd1
	dec a
	jr z, .asm_119cd6
	ld hl, Text_QuitReadingNews
	jr .asm_119cd9

.asm_119cd1
	ld hl, Text_CancelBattleRoomChallenge
	jr .asm_119cd9

.asm_119cd6
	ld hl, Text_ExitGymLeaderHonorRoll

.asm_119cd9
	call BattleTowerRoomMenu_SetMessage
	call BattleTowerRoomMenu_IncrementJumptable

BattleTowerRoomMenu_PlaceYesNoMenu:
	ld a, [wc31a]
	and a
	ret nz
	ld a, $f
	ld [wBattleTowerRoomMenu2JumptableIndex], a
	call BattleTowerRoomMenu_IncrementJumptable

BattleTowerRoomMenu_UpdateYesNoMenu:
	; Only ever called when [wBattleTowerRoomMenu2JumptableIndex] is $10
	call BattleTowerRoomMenu2
	ret c
	ld a, [wMobileInactivityTimerFrames]
	ld [wBattleTowerRoomMenuJumptableIndex], a
	ret

MenuHeader_119cf7:
	db MENU_BACKUP_TILES ; flags
	menu_coords 12, 7, SCREEN_WIDTH - 1, TEXTBOX_Y - 1
	dw NULL
	db 0 ; default option

String_119d07:
	db "   ▼@"

Strings_L50:
	db "Enter @@"
	db "Cancel@@"

Function119e2b:
	call MobileAPI

BattleTowerRoomMenu_IncrementJumptable:
	ld hl, wBattleTowerRoomMenuJumptableIndex
	inc [hl]
	ret

Function119eb4:
	xor a
	ld [wc3cc], a
	ld de, wc3ac
.loop
	ld a, [de]
	inc de
	ld [hli], a
	and a
	jr nz, .loop
	ret

Function119ec2: ; to go
	ld a, BANK(sMobileLoginPassword)
	call OpenSRAM
	xor a
	ld [sMobileLoginPassword + MOBILE_LOGIN_PASSWORD_LENGTH], a
	ld de, sMobileLoginPassword + 1
.loop
	ld a, [de]
	inc de
	ld [hli], a
	and a
	jr nz, .loop
	call CloseSRAM
	ret

BattleTowerRoomMenu2:
	ldh a, [rSVBK]
	ld [wcd8c], a
	ld a, $1
	ldh [rSVBK], a

	call .RunJumptable

	ld a, [wcd8c]
	ldh [rSVBK], a
	ld a, $1
	ldh [hBGMapMode], a
	ret

.RunJumptable:
	jumptable .Jumptable, wBattleTowerRoomMenu2JumptableIndex

.Jumptable:
	dw Function119f3f
	dw Function119f45
	dw Function119f56
	dw Function119f76
	dw Function119f98 ; to go
	dw Function11a113
	dw Function11a129
	dw Function11a131
	dw Function11a13d
	dw Function11a14b
	dw Function11a16d
	dw Function11a192
	dw Function11a2e6
	dw Function11a302
	dw Function11a33a
	dw BattleTowerRoomMenu2_PlaceYesNoMenu
	dw BattleTowerRoomMenu2_UpdateYesNoMenu
	dw Function11a357
	dw Function11a36b
	dw Function11a38d
	dw Function11a3c5
	dw Function11a3d9
	dw Function11a3f9
	dw Function11a41b
	dw Function11a452
	dw Function11a47a
	dw Function11a488
	dw Function11a49e
	dw Function11a4db
	dw Function11a4e8
	dw Function11a4fe
	dw Function11a466
	dw Function11a47a

Function119f3f:
	call Function11a5b9
	jmp BattleTowerRoomMenu2_IncrementJumptable

Function119f45:
	hlcoord 4, 2
	ld de, String_11a661
	call PlaceString
	ld a, $80
	ld [wMobileInactivityTimerMinutes], a
	jmp BattleTowerRoomMenu2_IncrementJumptable

Function119f56:
	ld a, [wMobileInactivityTimerMinutes]
	and a
	jr z, .asm_119f62
	dec a
	ld [wMobileInactivityTimerMinutes], a
	scf
	ret

.asm_119f62
	call Function11a63c
	hlcoord 4, 2
	ld de, String_11a6aa
	call PlaceString
	ld a, $80
	ld [wMobileInactivityTimerMinutes], a
	jmp BattleTowerRoomMenu2_IncrementJumptable

Function119f76:
	ld a, [wMobileInactivityTimerMinutes]
	and a
	jr z, .asm_119f82
	dec a
	ld [wMobileInactivityTimerMinutes], a
	scf
	ret

.asm_119f82
	call Function11a63c
	hlcoord 4, 2
	ld de, String_11a679
	call PlaceString
	call Function11a5f5
	xor a
	ld [wMobileInactivityTimerMinutes], a
	jmp BattleTowerRoomMenu2_IncrementJumptable

Function119f98: ; to go
	call Function11a536
	ret c
	call PlayClickSFX
	ld a, [wMobileInactivityTimerMinutes]
	and a
	jr nz, .asm_119fef
	call ExitMenu
	call Function11a63c
	xor a
	ld [wScriptVar], a
	call Function11a00e
	ld a, [wScriptVar]
	and a
	jr z, .asm_119fd4
	call ExitMenu
	farcall HDMATransferTilemapAndAttrmap_Overworld
	farcall Function115dc3
	ld a, [wcd33]
	ld [wcf66], a
	ld a, $a
	ld [wMobileErrorCodeBuffer], a
	scf
	ret

.asm_119fd4
	hlcoord 4, 2
	ld de, String_11a692
	call PlaceString
	ld a, $1
	ld [wc30d], a
	ld a, $1
	ld [wc314], a
	farcall HDMATransferTilemapAndAttrmap_Overworld
	and a
	ret

.asm_119fef
	call ExitMenu
	call ExitMenu
	farcall HDMATransferTilemapAndAttrmap_Overworld
	ld a, [wMobileInactivityTimerSeconds]
	ld [wcf66], a
	farcall Function115dc3
	ld a, $a
	ld [wMobileErrorCodeBuffer], a
	scf
	ret

Function11a00e: ; to go
	ld a, BANK(sMobileLoginPassword)
	call OpenSRAM
	ld a, [sMobileLoginPassword]
	and a
	jr z, .asm_11a02a
	ld a, [sMobileLoginPassword + 1]
	call CloseSRAM
	and a
	ret nz
	ld a, BANK(sMobileLoginPassword)
	call OpenSRAM
	xor a
	ld [sMobileLoginPassword], a

.asm_11a02a
	call CloseSRAM
	ld a, [wBGMapPalBuffer]
	and a
	jr z, .asm_11a039
	dec a
	jr z, .asm_11a081
	jmp Function11a0ca

.asm_11a039
	ld a, BANK(w3_d800)
	ldh [rSVBK], a
	ld hl, wc608
	ld de, w3_d800
	ld bc, 246
	call CopyBytes
	ld a, $1
	ldh [rSVBK], a
	call FadeToMenu
	farcall Function11765d
	call Function11a9ce
	ld a, BANK(w3_d800)
	ldh [rSVBK], a
	ld hl, w3_d800
	ld de, wc608
	ld bc, 246
	call CopyBytes
	ld a, $1
	ldh [rSVBK], a
	ld c, $0
	farcall Function115e18
	ld a, $1
	ld [wc305], a
	ret

.asm_11a081
	xor a
	ld [wMenuBorderLeftCoord], a
	ld [wMenuBorderTopCoord], a
	ld a, $13
	ld [wMenuBorderRightCoord], a
	ld a, $5
	ld [wMenuBorderBottomCoord], a
	call PushWindow
	farcall Function11765d
	farcall Function117ab4
	call ExitMenu
	farcall HDMATransferTilemapAndAttrmap_Overworld
	ld c, $0
	farcall Function115e18
	ld a, $1
	ld [wc305], a
	ret

Function11a0ca:
	xor a
	ld [wMenuBorderLeftCoord], a
	ld [wMenuBorderTopCoord], a
	ld a, $13
	ld [wMenuBorderRightCoord], a
	ld a, $11
	ld [wMenuBorderBottomCoord], a
	call PushWindow
	farcall Function11765d
	call ExitMenu
	farcall HDMATransferTilemapAndAttrmap_Overworld
	ld c, $0
	farcall Function115e18
	ld a, $1
	ld [wc305], a
	ret

Function11a113:
	call Function11a63c
	ld c, $1
	farcall Function115e18
	hlcoord 4, 2
	ld de, String_11a6c8
	call PlaceString
	and a
	ret

Function11a129:
	ld a, $80
	ld [wMobileInactivityTimerMinutes], a
	jmp BattleTowerRoomMenu2_IncrementJumptable

Function11a131:
	ld hl, wMobileInactivityTimerMinutes
	dec [hl]
	ret nz
	ld a, [wBattleTowerRoomMenu2JumptableIndex]
	inc a
	ld [wBattleTowerRoomMenu2JumptableIndex], a

Function11a13d:
	call Function11a63c
	hlcoord 4, 2
	ld de, String_11a6d2
	call PlaceString
	and a
	ret

Function11a14b:
	ld hl, wcd85
	ld a, [hl]
	cp $f3
	jr nz, .asm_11a155
	and a
	ret

.asm_11a155
	call Function11a1d6
	ret c
	call Function11a63c
	hlcoord 4, 2
	ld de, String_11a6f1
	call PlaceString
	ld a, $80
	ld [wMobileInactivityTimerMinutes], a
	jmp BattleTowerRoomMenu2_IncrementJumptable

Function11a16d:
	ld a, [wMobileInactivityTimerMinutes]
	and a
	jr z, .asm_11a179
	dec a
	ld [wMobileInactivityTimerMinutes], a
	scf
	ret

.asm_11a179
	call Function11a63c
	call Function11a1e6
	hlcoord 4, 2
	ld de, wc346
	call PlaceString
	call Function11a5f5
	xor a
	ld [wMobileInactivityTimerMinutes], a
	jmp BattleTowerRoomMenu2_IncrementJumptable

Function11a192:
	call Function11a536
	ret c
	call PlayClickSFX
	ld a, [wMobileInactivityTimerMinutes]
	and a
	jr nz, .asm_11a1b6
	call ExitMenu
	farcall HDMATransferTilemapAndAttrmap_Overworld
	call Function11a63c
	hlcoord 4, 2
	ld de, String_11a6d2
	call PlaceString
	and a
	ret

.asm_11a1b6
	call ExitMenu
	farcall HDMATransferTilemapAndAttrmap_Overworld
	ld a, [wMobileInactivityTimerSeconds]
	ld [wcf66], a
	ld [wcd80], a
	call Function11a63c
	hlcoord 4, 2
	ld de, String_11a6d2
	call PlaceString
	scf
	ret

Function11a1d6:
	ld a, [wcd85]
	cp $50
	jr nz, .asm_11a1e4
	ld a, $d3
	call SetMobileErrorCode
	scf
	ret

.asm_11a1e4
	and a
	ret

Function11a1e6:
	ld hl, String_11a706
	ld de, wc346
	call Function11a1ff
	ld hl, wcd85
	call Function11a1ff
	ld hl, String_11a70b
	call Function11a1ff
	ld a, $50
	ld [de], a
	ret

Function11a1ff:
.asm_11a1ff
	ld a, [hli]
	cp $50
	ret z
	ld [de], a
	inc de
	jr .asm_11a1ff

BattleTowerRoomMenu2_PlaceYesNoMenu:
	ld hl, MenuHeader_11a2de
	call LoadMenuHeader
	call MenuBox
	call MenuBoxCoord2Tile
	call ApplyTilemap
	hlcoord 16, 8
	ld de, String_11a2cf
	call PlaceString
	hlcoord 16, 10
	ld de, String_11a2d3
	call PlaceString
	hlcoord 15, 8
	ld a, $ed
	ld [hl], a
	xor a
	ld [wMobileInactivityTimerMinutes], a
	jmp BattleTowerRoomMenu2_IncrementJumptable

BattleTowerRoomMenu2_UpdateYesNoMenu:
	ld hl, hJoyPressed
	ld a, [hl]
	and A_BUTTON
	jr nz, .a_button
	ld a, [hl]
	and B_BUTTON
	jr nz, .b_button
	ld a, [hl]
	and D_UP
	jr nz, .d_up
	ld a, [hl]
	and D_DOWN
	jr nz, .d_down
.asm_11a24c
	call Function11a9f0
	scf
	ret

.d_up
	xor a
	ld [wcd8a], a
	ld [wcd8b], a
	ld a, [wMobileInactivityTimerMinutes]
	and a
	jr z, .asm_11a24c
	xor a
	ld [wMobileInactivityTimerMinutes], a
	hlcoord 15, 8
	ld a, $ed
	ld [hl], a
	hlcoord 15, 10
	ld a, $7f
	ld [hl], a
	jr .asm_11a24c

.d_down
	xor a
	ld [wcd8a], a
	ld [wcd8b], a
	ld a, [wMobileInactivityTimerMinutes]
	and a
	jr nz, .asm_11a24c
	inc a
	ld [wMobileInactivityTimerMinutes], a
	hlcoord 15, 8
	ld a, $7f
	ld [hl], a
	hlcoord 15, 10
	ld a, $ed
	ld [hl], a
	jr .asm_11a24c

.a_button
	xor a
	ld [wcd8a], a
	ld [wcd8b], a
	call PlayClickSFX
	ld a, [wMobileInactivityTimerMinutes]
	and a
	jr nz, .exit_no_carry
	call ExitMenu
	farcall HDMATransferTilemapAndAttrmap_Overworld
	ld a, [wMobileInactivityTimerFrames]
	cp $0
	jr z, .asm_11a2b4
	ld a, [wcd47]
	jr .exit_carry

.asm_11a2b4
	ld a, [wcd33]

.exit_carry
	ld [wcf66], a
	ld a, $a
	ld [wMobileErrorCodeBuffer], a
	scf
	ret

.b_button
	call PlayClickSFX

.exit_no_carry
	call ExitMenu
	farcall HDMATransferTilemapAndAttrmap_Overworld
	and a
	ret

String_11a2cf:
	db "Yes@"

String_11a2d3:
	db "No@"

MenuHeader_11a2de:
	db MENU_BACKUP_TILES ; flags
	menu_coords 14, 7, SCREEN_WIDTH - 1, TEXTBOX_Y - 1
	dw NULL
	db 0 ; default option

Function11a2e6:
	call Function11a63c
	ld c, $2
	farcall Function115e18
	hlcoord 4, 2
	ld de, String_11a71e
	call PlaceString
	ld a, $80
	ld [wMobileInactivityTimerMinutes], a
	jmp BattleTowerRoomMenu2_IncrementJumptable

Function11a302:
	ld a, [wMobileInactivityTimerMinutes]
	and a
	jr z, .asm_11a30e
	dec a
	ld [wMobileInactivityTimerMinutes], a
	scf
	ret

.asm_11a30e
	call Function11a63c
	hlcoord 4, 2
	ld de, String_11a72a
	call PlaceString
	hlcoord 9, 4
	ld de, wcd68
	lb bc, PRINTNUM_LEADINGZEROS | 1, 2
	call PrintNum
	hlcoord 14, 4
	ld de, wcd67
	lb bc, PRINTNUM_LEADINGZEROS | 1, 2
	call PrintNum
	ld a, $80
	ld [wMobileInactivityTimerMinutes], a
	jmp BattleTowerRoomMenu2_IncrementJumptable

Function11a33a:
	ld a, [wMobileInactivityTimerMinutes]
	and a
	jr z, .asm_11a346
	dec a
	ld [wMobileInactivityTimerMinutes], a
	scf
	ret

.asm_11a346
	call ExitMenu
	farcall HDMATransferTilemapAndAttrmap_Overworld
	farcall Function115dc3
	and a
	ret

Function11a357:
	call Function11a63c
	hlcoord 4, 2
	ld de, String_11a743
	call PlaceString
	ld a, $80
	ld [wMobileInactivityTimerMinutes], a
	jmp BattleTowerRoomMenu2_IncrementJumptable

Function11a36b:
	ld a, [wMobileInactivityTimerMinutes]
	and a
	jr z, .asm_11a377
	dec a
	ld [wMobileInactivityTimerMinutes], a
	scf
	ret

.asm_11a377
	call Function11a63c
	hlcoord 4, 2
	ld de, String_11a755
	call PlaceString
	call Function11a5f5
	xor a
	ld [wMobileInactivityTimerMinutes], a
	jmp BattleTowerRoomMenu2_IncrementJumptable

Function11a38d:
	call Function11a536
	ret c
	call PlayClickSFX
	ld a, [wMobileInactivityTimerMinutes]
	and a
	jr nz, .asm_11a3b1
	call ExitMenu
	farcall HDMATransferTilemapAndAttrmap_Overworld
	call Function11a63c
	hlcoord 4, 2
	ld de, String_11a6d2
	call PlaceString
	and a
	ret

.asm_11a3b1
	call ExitMenu
	farcall HDMATransferTilemapAndAttrmap_Overworld
	ld a, [wMobileInactivityTimerSeconds]
	ld [wcf66], a
	ld [wcd80], a
	scf
	ret

Function11a3c5:
	call Function11a63c
	hlcoord 4, 2
	ld de, String_11a762
	call PlaceString
	ld a, $80
	ld [wMobileInactivityTimerMinutes], a
	jmp BattleTowerRoomMenu2_IncrementJumptable

Function11a3d9:
	ld a, [wMobileInactivityTimerMinutes]
	and a
	jr z, .asm_11a3e5
	dec a
	ld [wMobileInactivityTimerMinutes], a
	scf
	ret

.asm_11a3e5
	call Function11a63c
	hlcoord 4, 2
	ld de, String_11a779
	call PlaceString
	ld a, $80
	ld [wMobileInactivityTimerMinutes], a
	jmp BattleTowerRoomMenu2_IncrementJumptable

Function11a3f9:
	ld a, [wMobileInactivityTimerMinutes]
	and a
	jr z, .asm_11a405
	dec a
	ld [wMobileInactivityTimerMinutes], a
	scf
	ret

.asm_11a405
	call Function11a63c
	hlcoord 4, 2
	ld de, String_11a755
	call PlaceString
	call Function11a5f5
	xor a
	ld [wMobileInactivityTimerMinutes], a
	jmp BattleTowerRoomMenu2_IncrementJumptable

Function11a41b:
	call Function11a536
	ret c
	call PlayClickSFX
	ld a, [wMobileInactivityTimerMinutes]
	and a
	jr nz, .asm_11a43f
	call ExitMenu
	farcall HDMATransferTilemapAndAttrmap_Overworld
	call Function11a63c
	hlcoord 4, 2
	ld de, String_11a6d2
	call PlaceString
	and a
	ret

.asm_11a43f
	call ExitMenu
	farcall HDMATransferTilemapAndAttrmap_Overworld
	ld a, $1c
	ld [wcf66], a
	ld [wcd80], a
	scf
	ret

Function11a452:
	call Function11a63c
	hlcoord 4, 2
	ld de, String_11a791
	call PlaceString
	ld a, $80
	ld [wMobileInactivityTimerMinutes], a
	jmp BattleTowerRoomMenu2_IncrementJumptable

Function11a466:
	call Function11a63c
	hlcoord 4, 2
	ld de, String_11a7c1
	call PlaceString
	ld a, $80
	ld [wMobileInactivityTimerMinutes], a
	jmp BattleTowerRoomMenu2_IncrementJumptable

Function11a47a:
	ld a, [wMobileInactivityTimerMinutes]
	and a
	jr z, .asm_11a486
	dec a
	ld [wMobileInactivityTimerMinutes], a
	scf
	ret

.asm_11a486
	and a
	ret

Function11a488:
	call Function11a63c
	hlcoord 4, 2
	ld de, String_11a7ac
	call PlaceString
	call Function11a5f5
	xor a
	ld [wMobileInactivityTimerMinutes], a
	jmp BattleTowerRoomMenu2_IncrementJumptable

Function11a49e:
	call Function11a536
	ret c
	call PlayClickSFX
	ld a, [wMobileInactivityTimerMinutes]
	and a
	jr nz, .asm_11a4c7
	call ExitMenu
	farcall HDMATransferTilemapAndAttrmap_Overworld
	call Function11a63c
	hlcoord 4, 2
	ld de, String_11a6d2
	call PlaceString
	ld a, $14
	ld [wcf66], a
	and a
	ret

.asm_11a4c7
	call ExitMenu
	farcall HDMATransferTilemapAndAttrmap_Overworld
	ld a, [wMobileInactivityTimerFrames]
	ld [wcf66], a
	ld [wcd80], a
	scf
	ret

Function11a4db:
	call Function11a63c
	ld de, String_11a6db
	hlcoord 4, 2
	call PlaceString
	ret

Function11a4e8:
	call Function11a63c
	hlcoord 4, 2
	ld de, String_11a7d7
	call PlaceString
	call Function11a5f5
	xor a
	ld [wMobileInactivityTimerMinutes], a
	jmp BattleTowerRoomMenu2_IncrementJumptable

Function11a4fe:
	call Function11a536
	ret c
	call PlayClickSFX
	ld a, [wMobileInactivityTimerMinutes]
	and a
	jr nz, .asm_11a522
	call ExitMenu
	farcall HDMATransferTilemapAndAttrmap_Overworld
	call Function11a63c
	hlcoord 4, 2
	ld de, String_11a6d2
	call PlaceString
	and a
	ret

.asm_11a522
	call ExitMenu
	farcall HDMATransferTilemapAndAttrmap_Overworld
	ld a, [wMobileInactivityTimerSeconds]
	ld [wcf66], a
	ld [wcd80], a
	scf
	ret

Function11a536:
	ld hl, hJoyPressed
	ld a, [hl]
	and A_BUTTON
	jr nz, .asm_11a5a7
	ld a, [hl]
	and B_BUTTON
	jr nz, .asm_11a5a2
	ld a, [hl]
	and D_UP
	jr nz, .asm_11a564
	ld a, [hl]
	and D_DOWN
	jr nz, .asm_11a583
.asm_11a54d
	ld a, [wBattleTowerRoomMenu2JumptableIndex]
	cp $4
	jr z, .asm_11a562
	call Function11a9f0
	jr nz, .asm_11a562
	call ExitMenu
	farcall HDMATransferTilemapAndAttrmap_Overworld

.asm_11a562
	scf
	ret

.asm_11a564
	xor a
	ld [wcd8a], a
	ld [wcd8b], a
	ld a, [wMobileInactivityTimerMinutes]
	and a
	jr z, .asm_11a54d
	xor a
	ld [wMobileInactivityTimerMinutes], a
	hlcoord 15, 7
	ld a, $ed
	ld [hl], a
	hlcoord 15, 9
	ld a, $7f
	ld [hl], a
	jr .asm_11a54d

.asm_11a583
	xor a
	ld [wcd8a], a
	ld [wcd8b], a
	ld a, [wMobileInactivityTimerMinutes]
	and a
	jr nz, .asm_11a54d
	inc a
	ld [wMobileInactivityTimerMinutes], a
	hlcoord 15, 7
	ld a, $7f
	ld [hl], a
	hlcoord 15, 9
	ld a, $ed
	ld [hl], a
	jr .asm_11a54d

.asm_11a5a2
	ld a, $1
	ld [wMobileInactivityTimerMinutes], a

.asm_11a5a7
	xor a
	ld [wcd8a], a
	ld [wcd8b], a
	and a
	ret

BattleTowerRoomMenu2_IncrementJumptable:
	ld a, [wBattleTowerRoomMenu2JumptableIndex]
	inc a
	ld [wBattleTowerRoomMenu2JumptableIndex], a
	scf
	ret

Function11a5b9:
	xor a
	ld [wMenuBorderLeftCoord], a
	ld [wMenuBorderTopCoord], a
	ld a, $13
	ld [wMenuBorderRightCoord], a
	ld a, $5
	ld [wMenuBorderBottomCoord], a
	call PushWindow
	hlcoord 0, 0, wAttrmap
	ld b, $6
	ld c, $14
	hlcoord 0, 0
	ld b, $4
	ld c, $12
	call Function3eea
	farcall HDMATransferTilemapAndAttrmap_Overworld
	call UpdateSprites
	ld c, $0
	farcall Function115e18
	ld a, $1
	ld [wc305], a
	ret

Function11a5f5:
	ld a, $e
	ld [wMenuBorderLeftCoord], a
	ld a, $13
	ld [wMenuBorderRightCoord], a
	ld a, $6
	ld [wMenuBorderTopCoord], a
	ld a, $a
	ld [wMenuBorderBottomCoord], a
	call PushWindow
	hlcoord 14, 6, wAttrmap
	ld b, $5
	ld c, $6
	hlcoord 14, 6
	ld b, $3
	ld c, $4
	call Function3eea
	hlcoord 16, 7
	ld de, String_11a2cf
	call PlaceString
	hlcoord 16, 9
	ld de, String_11a2d3
	call PlaceString
	hlcoord 15, 7
	ld a, $ed
	ld [hl], a
	farcall HDMATransferTilemapAndAttrmap_Overworld
	ret

Function11a63c:
	hlcoord 4, 1
	ld de, String_11a7f4
	call PlaceString
	hlcoord 4, 2
	ld de, String_11a7f4
	call PlaceString
	hlcoord 4, 3
	ld de, String_11a7f4
	call PlaceString
	hlcoord 4, 4
	ld de, String_11a7f4
	call PlaceString
	ret

String_11a661:
	db   "これから　モバイルセンターに"
	next "でんわ<WO>かけます@"

String_11a679:
	db   "モバイルアダプタ<NO>じゅんびは"
	next "できて　いますか？@"

String_11a692:
	db   "でんわ<WO>かけています"
	next "しばらく　おまちください@"

String_11a6aa:
	db   "でんわをかけると　つうわりょう"
	next "せつぞくりょう<GA>かかります@"

String_11a6c8:
	db   "せつぞく　しました@"

String_11a6d2:
	db   "つうしん　ちゅう@"

String_11a6db:
	db   "つうしん　ちゅう"
	next "セレクト　エーでちゅうし@"

String_11a6f1:
	db   "この　サービスには"
	next "つうわりょう<NO>ほかに@"

String_11a706:
	db   "おかね<GA>@"

String_11a70b:
	db   "えん"
	next "かかります　よろしい　ですか？@"

String_11a71e:
	db   "つうしん　しゅうりょう@"

String_11a72a:
	db   "つないだ　じかん"
	next "　　やく　　　ふん　　　びょう@"

String_11a743:
	db   "もっていない　データが"
	next "あります！@"

String_11a755:
	db   "データ<WO>よみこみますか？@"

String_11a762:
	db   "おなじ　データ<WO>よみこんだ"
	next "こと<GA>ありますが@"

String_11a779:
	db   "そのデータ<WA>なくなっているか"
	next "こわれて　います@"

String_11a791:
	db   "もっている　データと"
	next "おなじデータしか　ありません！@"

String_11a7ac:
	db   "データ<NO>よみこみを"
	next "ちゅうし　しますか？@"

String_11a7c1:
	db   "あたらしい　ニュースは"
	next "ありません　でした@"

String_11a7d7:
	db   "あたらしいニュース<GA>あります"
	next "ニュース<WO>よみこみますか？@"

String_11a7f4:
	db   "　　　　　　　　　　　　　　　@"

Function11a80c:
	ld de, hDivisor
	ld bc, hDividend
	ld hl, Unknown_11a89a
	call Function11a88c
	ld bc, hQuotient + 1
	ld hl, Unknown_11a8ba
	call Function11a88c
	ld bc, hPrintNumBuffer + 2
	ld hl, Unknown_11a8da
	call Function11a88c
	xor a
	ld b, a
	ldh a, [hDivisor]
	and $f
	ld e, a
	ldh a, [hPrintNumBuffer + 6]
	and $f
	call Function11a884
	ld e, a
	ldh a, [hPrintNumBuffer + 8]
	and $f
	call Function11a884
	ld [wcd62], a
	ld e, b
	xor a
	ld b, a
	ldh a, [hDivisor]
	and $f0
	swap a
	call Function11a884
	ld e, a
	ldh a, [hPrintNumBuffer + 6]
	and $f0
	swap a
	call Function11a884
	ld e, a
	ldh a, [hPrintNumBuffer + 8]
	and $f0
	swap a
	call Function11a884
	ld [wcd63], a
	ld e, b
	xor a
	ld b, a
	ldh a, [hMathBuffer]
	and $f
	call Function11a884
	ld e, a
	ldh a, [hPrintNumBuffer + 7]
	and $f
	call Function11a884
	ld e, a
	ldh a, [hPrintNumBuffer + 9]
	and $f
	call Function11a884
	ld [wcd64], a
	ret

Function11a884:
	add e
	cp $a
	ret c
	sub $a
	inc b
	ret

Function11a88c:
	ld a, [bc]
	add a
	ld c, a
	xor a
	ld b, a
	add hl, bc
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	inc de
	ret

Unknown_11a89a:
for x, 16
	bcd x % 100, x / 100
endr

Unknown_11a8ba:
for x, 0, 16**2, 16
	bcd x % 100, x / 100
endr

Unknown_11a8da:
for x, 0, 16**3, 16**2
	bcd x % 100, x / 100
endr

BattleTowerRoomMenu_WriteMessage:
	jumptable .Jumptable, wc31a

.Jumptable:
	dw BattleTowerRoomMenu_WriteMessage_DoNothing
	dw Function11a90f
	dw Function11a971

Function11a90f:
	ld a, $1
	ldh [rSVBK], a
	call SpeechTextbox
	ld a, $50
	ld hl, wc320
	ld bc, $008c
	call ByteFill
	ld a, [wc31b]
	ld l, a
	ld a, [wc31c]
	ld h, a
	ld de, wc320
.asm_11a92c
	ld a, [hli]
	cp $57
	jr z, .asm_11a94f
	cp $0
	jr z, .asm_11a92c
	cp $50
	jr z, .asm_11a92c
	cp $1
	jr z, .asm_11a941
	ld [de], a
	inc de
	jr .asm_11a92c

.asm_11a941
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
.asm_11a945
	ld a, [bc]
	inc bc
	cp $50
	jr z, .asm_11a92c
	ld [de], a
	inc de
	jr .asm_11a945

.asm_11a94f
	xor a
	ld [wc31f], a
	ld a, LOW(wc320)
	ld [wc31b], a
	ld a, HIGH(wc320)
	ld [wc31c], a
	hlcoord 1, 14
	ld a, l
	ld [wc31d], a
	ld a, h
	ld [wc31e], a
	ld hl, wc31a
	inc [hl]
	ld a, $3
	ldh [rSVBK], a

BattleTowerRoomMenu_WriteMessage_DoNothing:
	ret

Function11a971:
	ld hl, wc31f
	ldh a, [hJoyDown]
	and a
	jr nz, .asm_11a97f
	ld a, [hl]
	and a
	jr z, .asm_11a97f
	dec [hl]
	ret

.asm_11a97f
	ld a, [wOptions]
	and $7
	ld [hl], a
	ld hl, wcd8d
	ld a, [wc31b]
	ld e, a
	ld a, [wc31c]
	ld d, a
	ld a, [de]
	inc de
	ld [hli], a
	ld a, e
	ld [wc31b], a
	ld a, d
	ld [wc31c], a
	ld a, $50
	ld [hl], a
	ld a, [wc31d]
	ld l, a
	ld a, [wc31e]
	ld h, a
	ld de, wcd8d
	call PlaceString
	ld a, c
	ld [wc31d], a
	ld a, b
	ld [wc31e], a
	ld a, [wcd8d]
	cp $50
	jr nz, .asm_11a9bf
	xor a
	ld [wc31a], a

.asm_11a9bf
	ret

BattleTowerRoomMenu_SetMessage:
	ld a, l
	ld [wc31b], a
	ld a, h
	ld [wc31c], a
	ld a, $1
	ld [wc31a], a
	ret

Function11a9ce:
	call ClearBGPalettes
	call ReloadTilesetAndPalettes
	call Call_ExitMenu
	call GSReloadPalettes
	farcall FinishExitMenu
	call UpdateSprites
	ret

Function11a9f0:
	ld a, $1
	and a
	ret

Text_QuitReadingNews:
	text "Quit reading NEWS?"
	done

Text_PartyMonTopsThisLevel:
	text "A party #MON"
	line "tops this level."
	done

Text_UberRestriction:
	text_ram wcd49
	text " may go"
	line "only to BATTLE"

	para "ROOMS that are"
	line "Lv.70 or higher."
	done

Text_CancelBattleRoomChallenge:
	text "Cancel your BATTLE"
	line "ROOM challenge?"
	done

Text_ExitGymLeaderHonorRoll:
	text "Exit GYM LEADER"
	line "HONOR ROLL?"
	done

AddMobileMonToParty: ; used by `_GiveOddEgg:`
	ld hl, wPartyCount
	ld a, [hl]
	ld e, a
	inc [hl]

	ld a, [wMobileMonSpeciesPointer]
	ld l, a
	ld a, [wMobileMonSpeciesPointer + 1]
	ld h, a
	inc hl
	ld bc, wPartySpecies
	ld d, e
.loop1
	inc bc
	dec d
	jr nz, .loop1
	ld a, e
	ld [wCurPartyMon], a
	ld a, [hl]
	ld [bc], a
	inc bc
	ld a, -1
	ld [bc], a

	ld hl, wPartyMon1Species
	ld bc, PARTYMON_STRUCT_LENGTH
	ld a, e
	ld [wMobileMonIndex], a
.loop2
	add hl, bc
	dec a
	and a
	jr nz, .loop2
	ld e, l
	ld d, h
	ld a, [wMobileMonStructPointer]
	ld l, a
	ld a, [wMobileMonStructPointer + 1]
	ld h, a
	ld bc, PARTYMON_STRUCT_LENGTH
	call CopyBytes

	ld hl, wPartyMonOTs
	ld bc, NAME_LENGTH
	ld a, [wMobileMonIndex]
.loop3
	add hl, bc
	dec a
	and a
	jr nz, .loop3
	ld e, l
	ld d, h
	ld a, [wMobileMonOTPointer]
	ld l, a
	ld a, [wMobileMonOTPointer + 1]
	ld h, a
	ld bc, MON_NAME_LENGTH - 1
	call CopyBytes
	ld a, "@"
	ld [de], a

	ld hl, wPartyMonNicknames
	ld bc, MON_NAME_LENGTH
	ld a, [wMobileMonIndex]
.loop4
	add hl, bc
	dec a
	and a
	jr nz, .loop4
	ld e, l
	ld d, h
	ld a, [wMobileMonNicknamePointer]
	ld l, a
	ld a, [wMobileMonNicknamePointer + 1]
	ld h, a
	ld bc, MON_NAME_LENGTH - 1
	call CopyBytes
	ld a, "@"
	ld [de], a

	ld hl, sPartyMail
	ld bc, MAIL_STRUCT_LENGTH
	ld a, [wMobileMonIndex]
.loop5
	add hl, bc
	dec a
	and a
	jr nz, .loop5
	ld a, BANK(sPartyMail)
	call OpenSRAM
	ld e, l
	ld d, h
	ld a, [wMobileMonMailPointer]
	ld l, a
	ld a, [wMobileMonMailPointer + 1]
	ld h, a
	ld bc, MAIL_STRUCT_LENGTH
	call CopyBytes

	call CloseSRAM
	ret
