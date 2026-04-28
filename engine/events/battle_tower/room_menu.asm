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
	call ReturnToMapFromSubmenu
BattleTowerRoomMenu_DoNothing:
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
	dw BattleTowerRoomMenu_DoNothing ; unused index
	dw BattleTowerRoomMenu_DoNothing ; unused index
	dw BattleTowerRoomMenu_DoNothing ; unused index
	dw BattleTowerRoomMenu_DoNothing ; unused index
	dw BattleTowerRoomMenu_QuitMessage
	dw BattleTowerRoomMenu_PlaceYesNoMenu
	dw BattleTowerRoomMenu_UpdateYesNoMenu
	dw BattleTowerRoomMenu_DoNothing ; unused index
	dw BattleTowerRoomMenu_DoNothing ; unused index
	dw BattleTowerRoomMenu_DoNothing ; unused index
	dw BattleTowerRoomMenu_DoNothing ; unused index
	dw BattleTowerRoomMenu_DoNothing ; unused index
	dw BattleTowerRoomMenu_DoNothing ; unused index

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
	ret z
.d_up
	ld a, [wcd4a]
	ld hl, wcd4f
	inc [hl]
	cp [hl]
	ret nc
	ld a, $1
	ld [hl], a
	ret

.d_down
	ld hl, wcd4f
	dec [hl]
	ret nz
	ld a, [wcd4a]
	ld [hl], a
	ret

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
	jr BattleTowerRoomMenu_IncrementJumptable

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

Text_CancelBattleRoomChallenge:
	text "Cancel your Battle"
	line "Room challenge?"
	done

BattleTowerRoomMenu_QuitMessage:
	ld hl, Text_CancelBattleRoomChallenge
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

BattleTowerRoomMenu_IncrementJumptable:
	ld hl, wBattleTowerRoomMenuJumptableIndex
	inc [hl]
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
	dw BattleTowerRoomMenu_DoNothing ; unused index
	dw BattleTowerRoomMenu_DoNothing ; unused index
	dw BattleTowerRoomMenu_DoNothing ; unused index
	dw BattleTowerRoomMenu_DoNothing ; unused index
	dw BattleTowerRoomMenu_DoNothing ; unused index
	dw BattleTowerRoomMenu_DoNothing ; unused index
	dw BattleTowerRoomMenu_DoNothing ; unused index
	dw BattleTowerRoomMenu_DoNothing ; unused index
	dw BattleTowerRoomMenu_DoNothing ; unused index
	dw BattleTowerRoomMenu_DoNothing ; unused index
	dw BattleTowerRoomMenu_DoNothing ; unused index
	dw BattleTowerRoomMenu_DoNothing ; unused index
	dw BattleTowerRoomMenu_DoNothing ; unused index
	dw BattleTowerRoomMenu_DoNothing ; unused index
	dw BattleTowerRoomMenu_DoNothing ; unused index
	dw BattleTowerRoomMenu2_PlaceYesNoMenu
	dw BattleTowerRoomMenu2_UpdateYesNoMenu
	dw BattleTowerRoomMenu_DoNothing ; unused index
	dw BattleTowerRoomMenu_DoNothing ; unused index
	dw BattleTowerRoomMenu_DoNothing ; unused index
	dw BattleTowerRoomMenu_DoNothing ; unused index
	dw BattleTowerRoomMenu_DoNothing ; unused index
	dw BattleTowerRoomMenu_DoNothing ; unused index
	dw BattleTowerRoomMenu_DoNothing ; unused index
	dw BattleTowerRoomMenu_DoNothing ; unused index
	dw BattleTowerRoomMenu_DoNothing ; unused index
	dw BattleTowerRoomMenu_DoNothing ; unused index
	dw BattleTowerRoomMenu_DoNothing ; unused index
	dw BattleTowerRoomMenu_DoNothing ; unused index
	dw BattleTowerRoomMenu_DoNothing ; unused index
	dw BattleTowerRoomMenu_DoNothing ; unused index
	dw BattleTowerRoomMenu_DoNothing ; unused index
	dw BattleTowerRoomMenu_DoNothing ; unused index

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

MenuHeader_11a2de:
	db MENU_BACKUP_TILES ; flags
	menu_coords 14, 7, SCREEN_WIDTH - 1, TEXTBOX_Y - 1
	dw NULL
	db 0 ; default option

String_11a2cf: db "Yes@"
String_11a2d3: db "No@"

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

BattleTowerRoomMenu2_IncrementJumptable:
	ld a, [wBattleTowerRoomMenu2JumptableIndex]
	inc a
	ld [wBattleTowerRoomMenu2JumptableIndex], a
	scf
	ret

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
	ret nz
	xor a
	ld [wc31a], a
	ret

BattleTowerRoomMenu_SetMessage:
	ld a, l
	ld [wc31b], a
	ld a, h
	ld [wc31c], a
	ld a, $1
	ld [wc31a], a
	ret

Function11a9f0:
	ld a, $1
	and a
	ret

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
	jmp CloseSRAM

;+=========================================+
;| Parameter: [wScriptVar] = 0..1          |
;|                                         |
;| if [wScriptVar] == FALSE                |
;|    Show expanded menu with 4 options    |
;|    - News - News - ??? - Cancel         |
;| if [wScriptVar] == TRUE                 |
;|    Show BattleTower-Menu with 3 options |
;|    - Challenge - Explanation - Cancel   | 
;+=========================================+

Menu_ChallengeExplanationCancel:
; Show expanded menu with 4 options
	ld a, [wScriptVar]
	and a
	jr nz, .English
	ld a, $4
	ld [wScriptVar], a
	ld hl, MenuHeader_ChallengeExplanationSettingsCancel
	jr .Load_Interpret

; English Menu
.English:
	ld a, $4
	ld [wScriptVar], a
	ld hl, MenuHeader_ChallengeExplanationCancel
.Load_Interpret:
	call LoadMenuHeader
	call Function17d246
	jmp CloseWindow

Function17d246:
	call VerticalMenu
	jr c, .Exit
	ld a, [wScriptVar]
	cp $5
	jr nz, .UsewMenuCursorY
	ld a, [wMenuCursorY]
	cp $3
	ret z
	jr c, .UsewMenuCursorY
	dec a
	jr .LoadToScriptVar

.UsewMenuCursorY:
	ld a, [wMenuCursorY]
.LoadToScriptVar:
	ld [wScriptVar], a
	ret

.Exit:
	ld a, $4
	ld [wScriptVar], a
	ret

MenuHeader_ChallengeExplanationCancel:
	db MENU_BACKUP_TILES ; flags
	menu_coords 0, 0, 14, 7
	dw MenuData_ChallengeExplanationCancel
	db 1 ; default option

MenuData_ChallengeExplanationCancel:
	db STATICMENU_CURSOR | STATICMENU_WRAP ; flags
	db 3
	db "Challenge@"
	db "Explanation@"
	db "Cancel@"

MenuHeader_ChallengeExplanationSettingsCancel:
	db MENU_BACKUP_TILES ; flags
	menu_coords 0, 0, 11, 7
	dw MenuData_ChallengeExplanationSettingsCancel
	db 1 ; default option

MenuData_ChallengeExplanationSettingsCancel:
	db STATICMENU_CURSOR | STATICMENU_WRAP ; flags
	db 3
	db "Challenge@"
	db "Settings@"
	db "Cancel@"

Menu_BattleTowerSettings:
	ld a, $4
	ld [wScriptVar], a
	ld hl, MenuHeader_NormalInverseNeutral
	call LoadMenuHeader
	call Function17d246
	jmp CloseWindow

MenuHeader_NormalInverseNeutral:
	db MENU_BACKUP_TILES ; flags
	menu_coords 0, 0, 15, 7
	dw MenuData_NormalInverseNeutral
	db 1 ; default option

MenuData_NormalInverseNeutral:
	db STATICMENU_CURSOR | STATICMENU_WRAP ; flags
	db 3
	db "Normal Mode@"
	db "Inverse Mode@"
	db "Neutral Mode@"

CheckStringForErrors:
; Valid character ranges:
; $0, $5 - $13, $19 - $1c, $26 - $34, $3a - $3e, $40 - $48, $60 - $ff
.loop
	ld a, [de]
	inc de
	and a ; "<NULL>"
	jr z, .NextChar
	cp FIRST_REGULAR_TEXT_CHAR
	jr nc, .NextChar
	cp "<NEXT>"
	jr z, .NextChar
	cp "@"
	jr z, .Done
	cp "ガ"
	jr c, .Fail
	cp "<PLAY_G>"
	jr c, .NextChar
	cp "<JP_18>" + 1
	jr c, .Fail
	cp "<NI>"
	jr c, .NextChar
	cp "<NO>" + 1
	jr c, .Fail
	cp "<ROUTE>"
	jr c, .NextChar
	cp "<GREEN>" + 1
	jr c, .Fail
	cp "<ENEMY>"
	jr c, .NextChar
	cp "<ENEMY>" + 1
	jr c, .Fail
	cp "<MOM>"
	jr c, .NextChar
.Fail:
	scf
	ret

.NextChar:
	dec c
	jr nz, .loop
.Done:
	and a
	ret
