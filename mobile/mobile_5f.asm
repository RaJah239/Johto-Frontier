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

CheckStringForErrors_IgnoreTerminator:
; Find control chars
.loop
	ld a, [de]
	inc de
	and a
	jr z, .next
	cp "<DEXEND>" + 1
	jr nc, .next
	cp "<NEXT>"
	jr z, .next
	cp "@"
	jr z, .next

	cp "ガ"
	jr c, .end
	cp "<PLAY_G>"
	jr c, .next
	cp "<JP_18>" + 1
	jr c, .end
	cp "<NI>"
	jr c, .next
	cp "<NO>" + 1
	jr c, .end
	cp "<ROUTE>"
	jr c, .next
	cp "<GREEN>" + 1
	jr c, .end
	cp "<ENEMY>"
	jr c, .next
	cp "<ENEMY>" + 1
	jr c, .end
	cp "<MOM>"
	jr c, .next

.end
	scf
	ret

.next
	dec c
	jr nz, .loop
	and a
	ret

Function17d0f3:
	ld a, [wMobileMonSpecies]
	ld [wOTTrademonSpecies], a
	ld [wCurPartySpecies], a
	ld a, [wcd81]
	ld [wc74e], a
	ld hl, wMobileMonOT
	ld de, wOTTrademonOTName
	ld bc, NAME_LENGTH_JAPANESE - 1
	call CopyBytes
	ld a, "@"
	ld [de], a
	ld a, [wMobileMonID]
	ld [wOTTrademonID], a
	ld a, [wMobileMonID + 1]
	ld [wOTTrademonID + 1], a
	ld hl, wMobileMonDVs
	ld a, [hli]
	ld [wOTTrademonDVs], a
	ld a, [hl]
	ld [wOTTrademonDVs + 1], a
	ld bc, wMobileMonSpecies
	farcall GetCaughtGender
	ld a, c
	ld [wOTTrademonCaughtData], a
	call SpeechTextbox
	call FadeToMenu
	farcall Function10804d
	farcall Function17d1f1
	ld a, $1
	ld [wForceEvolution], a
	ld a, LINK_TRADECENTER
	ld [wLinkMode], a
	farcall EvolvePokemon
	xor a
	ld [wLinkMode], a
	farcall SaveAfterLinkTrade
	ld a, BANK(s5_a800)
	call OpenSRAM
	ld a, BANK(s5_a800)
	ld [s5_a800], a
	call CloseSRAM
	ld a, [wMapGroup]
	ld b, a
	ld a, [wMapNumber]
	ld c, a
	call GetMapSceneID
	ld a, d
	or e
	jr z, .asm_17d180
	ld a, $1
	ld [de], a

.asm_17d180
	call CloseSubmenu
	call RestartMapMusic
	ret

Mobile_CopyDefaultOTName:
	ld hl, Mobile5F_PlayersName
	ld de, wMobileMonOT
	ld bc, NAME_LENGTH_JAPANESE - 1
	call CopyBytes
	ret

Mobile5F_PlayersName:
	db "クりス@@"

Mobile_CopyDefaultNickname:
	ld hl, .DefaultNickname
	ld de, wMobileMonNick
	ld bc, NAME_LENGTH_JAPANESE - 1
	call CopyBytes
	ret

.DefaultNickname:
	db "？？？？？"

Mobile_CopyDefaultMail:
	ld a, "@"
	ld hl, wMobileMonMail
	ld bc, MAIL_MSG_LENGTH + 1
	call ByteFill
	ld hl, .DefaultMessage
	ld de, wMobileMonMail
	ld bc, .DefaultMessageEnd - .DefaultMessage
	call CopyBytes
	ret

.DefaultMessage:
	db "こんにちは@"
.DefaultMessageEnd:

Mobile_CopyDefaultMailAuthor:
	ld a, "@"
	ld de, wMobileMonMailAuthor
	ld bc, NAME_LENGTH_JAPANESE - 1
	call ByteFill
	ld hl, Mobile5F_PlayersName
	ld de, wMobileMonMailAuthor
	ld bc, NAME_LENGTH_JAPANESE - 1
	call CopyBytes
	ret

CheckStringContainsLessThanBNextCharacters:
.loop
	ld a, [de]
	inc de
	cp "<NEXT>"
	jr nz, .next_char
	dec b
	jr z, .done

.next_char
	dec c
	jr nz, .loop
	and a
	ret

.done
	scf
	ret

Function17d1f1:
	ld a, [wCurPartySpecies]
	dec a
	call SetSeenAndCaughtMon

	ld a, [wCurPartySpecies]
	cp UNOWN
	jr nz, .asm_17d223

	ld hl, wPartyMon1DVs
	ld a, [wPartyCount]
	dec a
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	predef GetUnownLetter
	callfar UpdateUnownDex
	ld a, [wFirstUnownSeen]
	and a
	jr nz, .asm_17d223

	ld a, [wUnownLetter]
	ld [wFirstUnownSeen], a

.asm_17d223
	ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Parameter: [wScriptVar] = 0..1
;
; if [wScriptVar] == FALSE
;    Show expanded menu with 4 options
;    - News - News - ??? - Cancel
; if [wScriptVar] == TRUE
;    Show BattleTower-Menu with 3 options
;    - Challenge - Explanation - Cancel
Menu_ChallengeExplanationCancel:
	ld a, [wScriptVar]
	and a
	jr nz, .English
	ld a, $4
	ld [wScriptVar], a
	ld hl, MenuHeader_ChallengeExplanationSettingsCancel ; Show expanded menu with 4 options
	jr .Load_Interpret

.English:
	ld a, $4
	ld [wScriptVar], a
	ld hl, MenuHeader_ChallengeExplanationCancel ; English Menu

.Load_Interpret:
	call LoadMenuHeader
	call Function17d246
	call CloseWindow
	ret

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

Function17d3f6:
	call ClearBGPalettes
	call ClearSprites
	call ClearScreen
	farcall HDMATransferTilemapAndAttrmap_Overworld

Function17d405:
	call DisableLCD
	ld hl, vTiles0 tile $ee
	ld de, wc608
	ld bc, 1 tiles
	call CopyBytes
	ld a, $1
	ldh [rVBK], a
	ld hl, PokemonNewsGFX
	ld de, vTiles1
	ld bc, $48 tiles
	call CopyBytes
	xor a
	ld hl, vTiles2 tile $7f
	ld bc, 1 tiles
	call ByteFill
	ld hl, wc608
	ld de, vTiles0 tile $ee
	ld bc, 1 tiles
	call CopyBytes
	xor a
	ldh [rVBK], a
	call EnableLCD
	ldh a, [rSVBK]
	push af
	ld a, $5
	ldh [rSVBK], a
	ld hl, PokemonNewsPalettes
	ld de, wBGPals1
	ld bc, 8 palettes
	call CopyBytes
	call SetDefaultBGPAndOBP
	pop af
	ldh [rSVBK], a
	ret

Function17d5f6:
	ld a, $5
	ldh [rSVBK], a
	ld hl, wc608
	ld de, wBGPals1
	ld bc, 8 palettes
	call CopyBytes
	ld a, $4
	ldh [rSVBK], a
	ret

Function17d60b:
	ld a, $5
	call OpenSRAM
	ld hl, $b1d3
	ld de, wc608
	ld bc, $20
	call CopyBytes
	ld a, [$b1b1]
	ld c, a
	ld a, [$b1b2]
	ld b, a
	ld a, [$b1b3]
	ld l, a
	ld a, [$b1b4]
	ld h, a
	call CloseSRAM
	ld a, $6
	call OpenSRAM
	ld de, wc708
	ld a, c
	and a
	jr z, .asm_17d684
.asm_17d63b
	push bc
	ld a, l
	ld [de], a
	inc de
	ld a, h
	ld [de], a
	inc de
	ld bc, $a
	add hl, bc
	pop bc
	ld a, [hli]
	ld [wcd4a], a
	ld a, [hli]
	ld [wcd49], a
	push hl
	push de
	ld hl, wc608
	ld e, b
	ld d, $0
	add hl, de
	ld a, [hli]
	ld [wcd4b], a
	ld a, [hl]
	ld [wcd4c], a
	pop de
	pop hl
	inc b
	inc b
	dec c
	dec c
	jr z, .asm_17d684
	push bc
	push de
	ld a, [wcd49]
	ld c, a
	ld a, [wcd4a]
	ld b, a
	ld a, [wcd4b]
	ld e, a
	ld a, [wcd4c]
	ld d, a
.asm_17d67a
	add hl, de
	dec bc
	ld a, c
	or b
	jr nz, .asm_17d67a
	pop de
	pop bc
	jr .asm_17d63b

.asm_17d684
	call CloseSRAM
	ld a, $5
	call OpenSRAM
	ld hl, wc708
	ld de, $b1b3
	ld a, [$b1b1]
	ld c, a
	ld a, [$b1b2]
	ld b, a
	call CopyBytes
	call CloseSRAM
	ret

Function17d711:
.crash_loop
	cp $31
	jr nc, .crash_loop
	ld e, a
	ld d, 0
	ld hl, Jumptable17d72a
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

Jumptable17d72a:
	dw Function17d78c
	dw Function17d78d
	dw Function17d7b4
	dw Function17d7c2
	dw Function17d7d3
	dw Function17d7e5
	dw Function17d818
	dw Function17d833
	dw Function17d85d
	dw Function17d902
	dw Function17d93a
	dw Function17d98b
	dw Function17d9e3
	dw Function17da31
	dw Function17da9c
	dw Function17dadc
	dw Function17db2d
	dw Function17db56
	dw Function17db77
	dw Function17dbe9
	dw Function17dc1f
	dw Function17dc9f
	dw Function17dca9
	dw Function17dccf
	dw Function17dd13
	dw Function17dd30
	dw Function17dd49
	dw Function17ddcd
	dw Function17de32
	dw Function17de91
	dw Function17ded9
	dw Function17e0fd
	dw Function17e133
	dw Function17e165
	dw Function17e1a1
	dw Function17e254
	dw Function17e261
	dw Function17e270
	dw Function17e27f
	dw Function17e293
	dw Function17e2a7
	dw IncCrashCheckPointer_SaveGameData
	dw IncCrashCheckPointer_SaveAfterLinkTrade
	dw IncCrashCheckPointer_SaveBox
	dw IncCrashCheckPointer_SaveChecksum
	dw IncCrashCheckPointer_SaveTrainerRankingsChecksum
	dw Function17e3e0
	dw Function17e3f0
	dw Function17e409

Function17d78c:
	ret

Function17d78d:
	call IncCrashCheckPointer
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	call HlToCrashCheckPointer
	ld a, BANK(s6_a006)
	call OpenSRAM
	ld hl, s6_a006
	add hl, bc
	ld de, w4_d000
	ld bc, $1000
	call CopyBytes
	call CloseSRAM
	xor a
	ld [wcd77], a
	call ClearBGPalettes
	ret

Function17d7b4:
	call IncCrashCheckPointer
	ld a, [hli]
	ld e, a
	ld d, 0
	call PlayMusic2
	call HlToCrashCheckPointer
	ret

Function17d7c2:
	call IncCrashCheckPointer
	ld a, [hli]
	ld e, a
	ld d, 0
	call PlaySFX
	call WaitSFX
	call HlToCrashCheckPointer
	ret

Function17d7d3:
	call IncCrashCheckPointer
	ld a, [hli]
	dec a
	ld e, a
	ld d, 0
	call PlayCry
	call WaitSFX
	call HlToCrashCheckPointer
	ret

Function17d7e5:
	call IncCrashCheckPointer
	ld a, [hli]
	ld [wcd4f], a
	ld a, [hli]
	ld [wcd50], a
	ld a, [hli]
	ld [wcd51], a
	ld a, [hli]
	ld [wcd52], a
	ld a, [hli]
	add a
	add a
	add a
	add $98
	ld [wcd53], a
	ld de, wcd4f
	call Function17e613
	ld a, [hli]
	ld [wcd53], a
	ld de, wcd4f
	call Function17e691
	call HlToCrashCheckPointer
	ret

Function17d818:
	call IncCrashCheckPointer
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	call HlToCrashCheckPointer
	call Function17e447
	ld e, l
	ld d, h
	hlcoord 0, 0
	add hl, bc
	call PlaceString
	ret

Function17d833:
	call IncCrashCheckPointer
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	call HlToCrashCheckPointer
	push de
	push bc
	call Function17e32b
	pop bc
	pop de
	call Function17e43d
	ld c, l
	ld b, h
	hlcoord 0, 0
	add hl, de
	ld e, l
	ld d, h
	farcall Function11c08f
	call Function17e349
	ret

Function17d85d:
	call IncCrashCheckPointer
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	push hl
	ld hl, wBGPals1
	add hl, de
	ld de, wcc60
.asm_17d86c
	ld a, [hli]
	ld [de], a
	inc de
	and a
	jr nz, .asm_17d86c
	pop hl
	ld de, wc608
	ld c, $0
.asm_17d878
	ld a, [hli]
	cp $ff
	jr z, .asm_17d8c7
	ld [wcd4f], a
	ld a, [hli]
	ld [wcd50], a
	ld a, [hli]
	ld [wcd51], a
	ld a, [hli]
	ld [wcd52], a
	ld a, [wcd51]
	push af
	cp $c0
	jr c, .asm_17d89b
	ld a, [wcd4f]
	ldh [rSVBK], a
	jr .asm_17d8a1

.asm_17d89b
	ld a, [wcd4f]
	call OpenSRAM

.asm_17d8a1
	push hl
	ld a, [wcd50]
	ld l, a
	ld a, [wcd51]
	ld h, a
	ld a, [wcd52]
.asm_17d8ad
	push af
	ld a, [hli]
	ld [de], a
	inc de
	inc c
	pop af
	dec a
	jr nz, .asm_17d8ad
	pop hl
	pop af
	cp $c0
	jr c, .asm_17d8c2
	ld a, $4
	ldh [rSVBK], a
	jr .asm_17d878

.asm_17d8c2
	call CloseSRAM
	jr .asm_17d878

.asm_17d8c7
	call HlToCrashCheckPointer
	push bc
	ld a, $3
	ldh [rSVBK], a
	ld hl, wc608
	ld de, wBGPals1
	ld b, $0
	call CopyBytes
	ld a, $4
	ldh [rSVBK], a
	call Function17e32b
	pop bc
	ld a, c
	ld [wcd3b], a
	xor a
	ld [wcf66], a
	farcall Function118329
	ld a, [wMobileErrorCodeBuffer]
	and a
	jr z, .asm_17d8fe
	cp $a
	jr z, .asm_17d8fe
	call Function17e309
	ret

.asm_17d8fe
	call Function17e349
	ret

Function17d902:
	call IncCrashCheckPointer
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	push de
	call HlToCrashCheckPointer
	call Function17e32b
	pop de
	ld hl, wBGPals1
	add hl, de
	ld de, wcc60
.asm_17d918
	ld a, [hli]
	ld [de], a
	inc de
	and a
	jr nz, .asm_17d918
	xor a
	ld [wcf66], a
	farcall Function11837a
	ld a, [wMobileErrorCodeBuffer]
	and a
	jr z, .asm_17d936
	cp $a
	jr z, .asm_17d936
	call Function17e309
	ret

.asm_17d936
	call Function17e349
	ret

Function17d93a:
	call IncCrashCheckPointer
	ld de, wc708
	ld bc, $5
	call CopyBytes
	call HlToCrashCheckPointer
	call Function17e32b
	ldh a, [rSVBK]
	push af
	ld a, $1
	ldh [rSVBK], a
	ld a, [wc70c]
	call Function17e6de
	ld a, [wc70a]
	ld [wCurPartySpecies], a
	ld a, [wc70c]
	ld e, a
	farcall LoadMonPaletteAsNthBGPal
	call SetDefaultBGPAndOBP
	ld a, [wc708]
	ld l, a
	ld a, [wc709]
	ld h, a
	ld a, [wc70b]
	ld c, a
	decoord 0, 0
	add hl, de
	ld e, l
	ld d, h
	farcall HOF_AnimateFrontpic
	pop af
	ldh [rSVBK], a
	call Function17e349
	ret

Function17d98b:
	call IncCrashCheckPointer
	ld de, wc708
	ld bc, $4
	call CopyBytes
	call HlToCrashCheckPointer
	call Function17e32b
	ldh a, [rSVBK]
	push af
	ld a, $1
	ldh [rSVBK], a
	ld a, [wc70b]
	call Function17e6de
	ld a, [wc70a]
	ld [wTrainerClass], a
	ld a, [wc70b]
	ld e, a
	farcall LoadTrainerClassPaletteAsNthBGPal
	call SetDefaultBGPAndOBP
	ld a, [wc708]
	ld e, a
	ld a, [wc709]
	ld d, a
	push de
	ld de, vTiles2
	farcall GetTrainerPic
	pop hl
	decoord 0, 0
	add hl, de
	ld bc, $707
	predef PlaceGraphic
	pop af
	ldh [rSVBK], a
	call Function17e349
	ret

Function17d9e3:
	call IncCrashCheckPointer
	ld de, wc708
	ld bc, $7
	call CopyBytes
	call HlToCrashCheckPointer
	ld a, [wc70b]
	push af
	cp $c0
	jr c, .asm_17da01
	ld a, [wc70c]
	ldh [rSVBK], a
	jr .asm_17da07

.asm_17da01
	ld a, [wc70c]
	call OpenSRAM

.asm_17da07
	ld a, [wc708]
	ld l, a
	ld a, [wc709]
	ld h, a
	ld a, [wc70a]
	ld e, a
	ld a, [wc70b]
	ld d, a
	ld a, [wc70d]
	ld c, a
	ld a, [wc70e]
	ld b, a
	call CopyBytes
	pop af
	cp $c0
	jr c, .asm_17da2d
	ld a, $4
	ldh [rSVBK], a
	jr .asm_17da30

.asm_17da2d
	call CloseSRAM

.asm_17da30
	ret

Function17da31:
	call IncCrashCheckPointer
	ld de, wc708
	ld bc, $4
	call CopyBytes
	call HlToCrashCheckPointer
	ld a, [wc709]
	push af
	cp $c0
	jr c, .asm_17da4f
	ld a, [wc70a]
	ldh [rSVBK], a
	jr .asm_17da55

.asm_17da4f
	ld a, [wc70a]
	call OpenSRAM

.asm_17da55
	ld a, [wc708]
	ld e, a
	ld a, [wc709]
	ld d, a
	ld a, [wc70b]
	ld c, a
	bit 7, c
	jr nz, .asm_17da70
	ld hl, Unknown_17da8c
	ld b, $0
	add hl, bc
	ld a, [de]
	or [hl]
	ld [de], a
	jr .asm_17da7d

.asm_17da70
	ld hl, Unknown_17da94
	ld a, c
	and $7f
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [de]
	and [hl]
	ld [de], a

.asm_17da7d
	pop af
	cp $c0
	jr c, .asm_17da88
	ld a, $4
	ldh [rSVBK], a
	jr .asm_17da8b

.asm_17da88
	call CloseSRAM

.asm_17da8b
	ret

Unknown_17da8c:
for x, 8
	db 1 << x
endr

Unknown_17da94:
for x, 8
	db ~(1 << x)
endr

Function17da9c:
	ld a, [wcd31]
	dec a
	jr z, .asm_17dabd
	push af
	call Function17e566
	pop af
	ld [wcd31], a
	ld hl, wcd24
	ld a, [wcd2e]
	sub [hl]
	ld [wcd2e], a
	call Function17e55b
	call Function17e5af
.asm_17daba
	jmp IncCrashCheckPointer

.asm_17dabd
	ld a, [wcd2f]
	and a
	jr z, .asm_17daba
	ld hl, wcd24
	sub [hl]
	ld [wcd2f], a
	ld a, [wcd2e]
	sub [hl]
	ld [wcd2e], a
	call Function17e451
	call Function17e55b
	call Function17e5af
	jr .asm_17daba

Function17dadc:
	ld a, [wcd2e]
	ld hl, wcd24
	add [hl]
	ld hl, wcd42
	cp [hl]
	jr z, .asm_17db0e
	jr nc, .asm_17db0e
	ld hl, wcd31
	ld a, [wcd2b]
	cp [hl]
	jr z, .asm_17db11
	call Function17e566
	ld a, [wcd31]
	inc a
	ld [wcd31], a
	ld hl, wcd24
	ld a, [wcd2e]
	add [hl]
	ld [wcd2e], a
	call Function17e55b
	call Function17e5af

.asm_17db0e
	jmp IncCrashCheckPointer

.asm_17db11
	ld hl, wcd24
	ld a, [wcd2f]
	add [hl]
	ld [wcd2f], a
	ld a, [wcd2e]
	add [hl]
	ld [wcd2e], a
	call Function17e451
	call Function17e55b
	call Function17e5af
	jr .asm_17db0e

Function17db2d:
	ld a, [wcd30]
	ld hl, wcd24
	cp [hl]
	jr z, .asm_17db53
	ld hl, wcd42
	ld a, [wcd2e]
	inc a
	cp [hl]
	jr z, .asm_17db53
	ld [wcd2e], a
	call Function17e566
	ld a, [wcd30]
	inc a
	ld [wcd30], a
	call Function17e55b
	call Function17e5af

.asm_17db53
	jmp IncCrashCheckPointer

Function17db56:
	ld a, [wcd30]
	cp $1
	jr z, .asm_17db74
	call Function17e566
	ld a, [wcd30]
	dec a
	ld [wcd30], a
	ld a, [wcd2e]
	dec a
	ld [wcd2e], a
	call Function17e55b
	call Function17e5af

.asm_17db74
	jmp IncCrashCheckPointer

Function17db77:
	ld hl, wcd2d
	ld a, [wcd2f]
	add [hl]
	ld hl, wcd42
	cp [hl]
	jr z, .asm_17dbae
	jr nc, .asm_17dbae
	call Function17e566
	ld hl, wcd2d
	ld a, [wcd2f]
	add [hl]
	ld [wcd2f], a
	ld a, [wcd2e]
	add [hl]
	ld hl, wcd42
	cp [hl]
	jr c, .asm_17db9f
	ld a, [hl]
	dec a

.asm_17db9f
	ld [wcd2e], a
	call Function17dbb1
	call Function17e451
	call Function17e55b
	call Function17e5af

.asm_17dbae
	jmp IncCrashCheckPointer

Function17dbb1:
	ld hl, wcd2f
	ld a, [wcd42]
	sub [hl]
	ld hl, wcd2d
	cp [hl]
	ret nc
	ld a, $1
	ld [wcd30], a
	ld [wcd31], a
	ld a, [wcd24]
	ld c, a
	ld a, [wcd24]
	ld b, a
	ld a, [wcd2e]
	ld hl, wcd2f
	sub [hl]
.asm_17dbd4
	and a
	ret z
	push af
	ld hl, wcd30
	ld a, b
	cp [hl]
	jr nz, .asm_17dbe4
	ld a, $1
	ld [hl], a
	ld hl, wcd31

.asm_17dbe4
	inc [hl]
	pop af
	dec a
	jr .asm_17dbd4

Function17dbe9:
	ld hl, wcd2d
	ld a, [wcd2f]
	sub [hl]
	bit 7, a
	jr z, .asm_17dbf5
	xor a

.asm_17dbf5
	ld [wcd2f], a
	ld a, [wcd30]
	dec a
	ld c, a
	ld a, [wcd31]
	ld b, a
	xor a
	ld hl, wcd24
.asm_17dc05
	dec b
	jr z, .asm_17dc0b
	add [hl]
	jr .asm_17dc05

.asm_17dc0b
	add c
	ld hl, wcd2f
	add [hl]
	ld [wcd2e], a
	call Function17e451
	call Function17e55b
	call Function17e5af
	jmp IncCrashCheckPointer

Function17dc1f:
	call IncCrashCheckPointer
	ld de, wc688
	ld bc, $6
	call CopyBytes
	call Function17e32b
	ldh a, [rSVBK]
	push af
	ld a, $1
	ldh [rSVBK], a
	ld hl, wc688
	ld a, $40
	ld [wc708], a
	ld a, [hli]
	ld [wc70a], a
	add $5
	ld [wc70c], a
	ld a, [hli]
	ld [wc709], a
	add $4
	ld [wc70b], a
	ld a, $96
	ld [wc70d], a
	ld a, $5c
	ld [wc70e], a
	ld a, $1
	ld [wc70f], a
	ld hl, wc708
	call LoadMenuHeader
	call VerticalMenu
	jr nc, .asm_17dc6e
	ld a, $2
	ld [wMenuCursorY], a

.asm_17dc6e
	call CloseWindow
	pop af
	ldh [rSVBK], a
	ld a, [wMenuCursorY]
	cp $1
	jr nz, .asm_17dc85
	ld a, [wc68a]
	ld l, a
	ld a, [wc68a + 1]
	ld h, a
	jr .asm_17dc8d

.asm_17dc85
	ld a, [wc68a + 2]
	ld l, a
	ld a, [wc68a + 3]
	ld h, a

.asm_17dc8d
	push hl
	call Function17e349
	pop hl
	call Function17e40f
	ret

Function17dc9f:
	call IncCrashCheckPointer
	call HlToCrashCheckPointer
;	call RotateFourPalettesLeft
	ret

Function17dca9:
	call IncCrashCheckPointer
	call HlToCrashCheckPointer

Function17dcaf:
	ld a, $5
	ldh [rSVBK], a
	ld hl, wBGPals1
	ld de, 1 palettes
	ld c, 8
.asm_17dcbb
	push hl
	ld a, $ff
	ld [hli], a
	ld a, $7f
	ld [hl], a
	pop hl
	add hl, de
	dec c
	jr nz, .asm_17dcbb
	ld a, $4
	ldh [rSVBK], a
	ret

Function17dccf:
	call IncCrashCheckPointer
	push hl
	ld a, [wcd4b]
	ld l, a
	ld a, [wcd4c]
	ld h, a
	ld a, [wcd2e]
	ld c, a
	ld b, 0
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld c, a
	ld a, [hl]
	ld b, a
	call Function17e43d
	call HlToCrashCheckPointer
.asm_17dced
	ld a, [wMobileCrashCheckPointer]
	ld l, a
	ld a, [wMobileCrashCheckPointer + 1]
	ld h, a
	ld a, [hl]
	cp $ff
	jr z, .asm_17dd0d
.crash_loop
	cp $31
	jr nc, .crash_loop
	call Function17d711
	ld a, [wcd77]
	bit 7, a
	jr nz, .asm_17dd0d
	and a
	jr z, .asm_17dd11
	jr .asm_17dced

.asm_17dd0d
	pop hl
	jmp HlToCrashCheckPointer

.asm_17dd11
	pop hl
	ret

Function17dd13:
	call IncCrashCheckPointer
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	call HlToCrashCheckPointer
	call Function17e447
	push hl
	hlcoord 0, 0
	add hl, bc
	push hl
	pop bc
	pop hl
	call PrintTextboxTextAt
	ret

Function17dd30:
	call IncCrashCheckPointer
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	ld a, [hli]
	ld c, a
	ld b, 0
	ld a, [hli]
	push af
	call HlToCrashCheckPointer
	pop af
	hlcoord 0, 0
	add hl, de
	call Function17e600
	ret

Function17dd49:
	call IncCrashCheckPointer
	ld de, wc708
	ld bc, $a
	call CopyBytes
	ld a, [wc711]
	ld c, a
	ld b, 0
	call CopyBytes
	ld a, [wc70a]
	cp $c0
	jr c, .sram
	ld a, [wc708]
	ldh [rSVBK], a
	jr .got_bank

.sram
	ld a, [wc708]
	call OpenSRAM

.got_bank
	ld a, [wc709]
	ld l, a
	ld a, [wc70a]
	ld h, a
	ld de, wc688
	ld a, [wc711]
	ld c, a
	ld b, 0
	call CopyBytes
	ld a, [wc70a]
	cp $c0
	jr c, .close_sram
	ld a, $4
	ldh [rSVBK], a
	jr .exited_bank

.close_sram
	call CloseSRAM

.exited_bank
	ld a, [wc711]
	ld c, a
	ld hl, wc712
	ld de, wc688
.loop
	ld a, [de]
	inc de
	cp [hl]
	inc hl
	jr z, .next
	jr c, .load
	jr .load2

.next
	dec c
	jr nz, .loop
	ld a, [wc70d]
	ld l, a
	ld a, [wc70e]
	ld h, a
	jr .done

.load2
	ld a, [wc70f]
	ld l, a
	ld a, [wc710]
	ld h, a
	jr .done

.load
	ld a, [wc70b]
	ld l, a
	ld a, [wc70c]
	ld h, a

.done
	call Function17e40f
	ret

Function17ddcd:
	call IncCrashCheckPointer
	ld de, wc708
	ld bc, $8
	call CopyBytes
	ld a, [wc70a]
	cp $c0
	jr c, .asm_17dde7
	ld a, [wc708]
	ldh [rSVBK], a
	jr .asm_17dded

.asm_17dde7
	ld a, [wc708]
	call OpenSRAM

.asm_17dded
	ld a, [wc709]
	ld e, a
	ld a, [wc70a]
	ld d, a
	ld a, [de]
	ld [wc710], a
	ld a, [wc70b]
	ld c, a
	ld b, 0
	ld a, [wc70a]
	cp $c0
	jr c, .asm_17de0c
	ld a, $4
	ldh [rSVBK], a
	jr .asm_17de0f

.asm_17de0c
	call CloseSRAM

.asm_17de0f
	push hl
	ld hl, Unknown_17da8c
	add hl, bc
	ld a, [hl]
	ld hl, wc710
	and [hl]
	pop hl
	jr nz, .asm_17de26
	ld a, [wc70e]
	ld l, a
	ld a, [wc70f]
	ld h, a
	jr .asm_17de2e

.asm_17de26
	ld a, [wc70c]
	ld l, a
	ld a, [wc70d]
	ld h, a

.asm_17de2e
	call Function17e40f
	ret

Function17de32:
	call IncCrashCheckPointer
	ld de, wc708
	ld bc, $9
	call CopyBytes
	ld a, [wc710]
	ld c, a
	ld b, 0
	call CopyBytes
	ld a, $6
	call OpenSRAM
	call Function17f4f6
	ld a, [wc708]
	ld e, a
	ld a, [wc709]
	ld d, a
	add hl, de
	ld e, l
	ld d, h
	ld a, [wc710]
	ld c, a
	ld hl, wc711
.asm_17de61
	ld a, [de]
	inc de
	cp [hl]
	inc hl
	jr z, .asm_17de6b
	jr c, .asm_17de82
	jr .asm_17de78

.asm_17de6b
	dec c
	jr nz, .asm_17de61
	ld a, [wc70c]
	ld l, a
	ld a, [wc70d]
	ld h, a
	jr .asm_17de8a

.asm_17de78
	ld a, [wc70e]
	ld l, a
	ld a, [wc70f]
	ld h, a
	jr .asm_17de8a

.asm_17de82
	ld a, [wc70a]
	ld l, a
	ld a, [wc70b]
	ld h, a

.asm_17de8a
	call CloseSRAM
	call Function17e40f
	ret

Function17de91:
	call IncCrashCheckPointer
	ld de, wc708
	ld bc, $7
	call CopyBytes
	ld a, $6
	call OpenSRAM
	call Function17f4f6
	ld a, [wc708]
	ld e, a
	ld a, [wc709]
	ld d, a
	add hl, de
	ld e, l
	ld d, h
	ld a, [wc70a]
	ld c, a
	ld b, 0
	ld hl, Unknown_17da8c
	add hl, bc
	ld a, [hl]
	ld l, e
	ld h, d
	and [hl]
	jr nz, .asm_17deca
	ld a, [wc70d]
	ld l, a
	ld a, [wc70e]
	ld h, a
	jr .asm_17ded2

.asm_17deca
	ld a, [wc70b]
	ld l, a
	ld a, [wc70c]
	ld h, a

.asm_17ded2
	call CloseSRAM
	call Function17e40f
	ret

Function17ded9:
	call IncCrashCheckPointer
	ld de, wc708
	ld bc, $1f
	call CopyBytes
	call Function17e32b
	ldh a, [rSVBK]
	push af
	ld a, $1
	ldh [rSVBK], a
	ld hl, wc708
	ld a, [hli]
	ld [wCurPartySpecies], a
	ld [wTempEnemyMonSpecies], a
	ld a, [hli]
	ld [wCurPartyLevel], a
	ld a, [hli]
	ld b, a
	ld a, [wPartyCount]
	cp $6
	jmp nc, Function17e026
	xor a
	ld [wMonType], a
	push hl
	push bc
	predef TryAddMonToParty
	farcall SetCaughtData
	pop bc
	pop hl
	bit 1, b
	jr z, .asm_17df33
	push bc
	push hl
	ld a, [wPartyCount]
	dec a
	ld hl, wPartyMonNicknames
	call SkipNames
	ld d, h
	ld e, l
	pop hl
	call CopyBytes
	pop bc
	jr .asm_17df37

.asm_17df33
	ld de, $6
	add hl, de

.asm_17df37
	bit 2, b
	jr z, .asm_17df5a
	push bc
	push hl
	ld a, [wPartyCount]
	dec a
	ld hl, wPartyMonOTs
	call SkipNames
	ld d, h
	ld e, l
	pop hl
	call CopyBytes
	ld a, [hli]
	ld b, a
	push hl
	farcall SetGiftPartyMonCaughtData
	pop hl
	pop bc
	jr .asm_17df5e

.asm_17df5a
	ld de, $7
	add hl, de

.asm_17df5e
	bit 3, b
	jr z, .asm_17df79
	push bc
	push hl
	ld a, [wPartyCount]
	dec a
	ld hl, wPartyMon1ID
	call GetPartyLocation
	ld d, h
	ld e, l
	pop hl
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	pop bc
	jr .asm_17df7b

.asm_17df79
	inc hl
	inc hl

.asm_17df7b
	bit 4, b
	jr z, .asm_17dfd0
	push bc
	push hl
	ld a, [wPartyCount]
	dec a
	ld hl, wPartyMon1DVs
	call GetPartyLocation
	ld d, h
	ld e, l
	pop hl
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	push hl
	ld a, [wPartyCount]
	dec a
	ld hl, wPartyMon1Species
	call GetPartyLocation
	ld a, [hl]
	ld [wCurSpecies], a
	call GetBaseData
	ld a, [wPartyCount]
	dec a
	ld hl, wPartyMon1MaxHP
	call GetPartyLocation
	ld d, h
	ld e, l
	push hl
	ld b, FALSE
	farcall CalcMonStats
	ld a, [wPartyCount]
	dec a
	ld hl, wPartyMon1HP
	call GetPartyLocation
	ld d, h
	ld e, l
	pop hl
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	pop hl
	pop bc
	jr .asm_17dfd2

.asm_17dfd0
	inc hl
	inc hl

.asm_17dfd2
	bit 5, b
	jr z, .asm_17dfea
	push bc
	push hl
	ld a, [wPartyCount]
	dec a
	ld hl, wPartyMon1Item
	call GetPartyLocation
	ld d, h
	ld e, l
	pop hl
	ld a, [hli]
	ld [de], a
	pop bc
	jr .asm_17dfeb

.asm_17dfea
	inc hl

.asm_17dfeb
	bit 6, b
	jr z, .asm_17e01f
	push bc
	push hl
	ld a, [wPartyCount]
	dec a
	ld hl, wPartyMon1Moves
	call GetPartyLocation
	ld d, h
	ld e, l
	pop hl
	push de
	ld bc, $4
	call CopyBytes
	pop de
	push hl
	push de
	ld a, [wPartyCount]
	dec a
	ld hl, wPartyMon1PP
	call GetPartyLocation
	ld d, h
	ld e, l
	pop hl
	predef FillPP
	pop hl
	pop bc
	jr asm_17e0ee

.asm_17e01f
	ld de, $4
	add hl, de
	jr asm_17e0ee

Function17e026:
	ret

asm_17e0ee:
	ld a, [hli]
	ld h, [hl]
	ld l, a
	pop af
	ldh [rSVBK], a
	push hl
	call Function17e349
	pop hl
	call Function17e40f
	ret

Function17e0fd:
	call IncCrashCheckPointer
	ld de, wc708
	ld bc, $6
	call CopyBytes
	ldh a, [rSVBK]
	push af
	ld a, $1
	ldh [rSVBK], a
	ld hl, wc708
	ld a, [hli]
	ld [wCurItem], a
	ld a, [hli]
	ld [wItemQuantityChange], a
	push hl
	ld hl, wNumItems
	call ReceiveItem
	pop hl
	jr c, .asm_17e127
	inc hl
	inc hl

.asm_17e127
	ld a, [hli]
	ld b, a
	ld a, [hl]
	ld h, a
	ld l, b
	pop af
	ldh [rSVBK], a
	call Function17e40f
	ret

Function17e133:
	ret

Function17e165:
	call IncCrashCheckPointer
	ld de, wc708
	ld bc, $5
	call CopyBytes
	ldh a, [rSVBK]
	push af
	ld a, $1
	ldh [rSVBK], a
	ld hl, wc708
	ld a, [hli]
	ld [wCurItem], a
	push hl
	ld hl, wNumItems
	call CheckItem
	pop hl
	jr c, .asm_17e195
	push hl
	ld hl, wNumPCItems
	call CheckItem
	pop hl
	jr c, .asm_17e195
	inc hl
	inc hl

.asm_17e195
	ld a, [hli]
	ld b, a
	ld a, [hl]
	ld h, a
	ld l, b
	pop af
	ldh [rSVBK], a
	call Function17e40f
	ret

Function17e1a1:
	call IncCrashCheckPointer
	ld de, wc708
	ld bc, $d
	call CopyBytes
	ld a, [wc70a]
	cp $c0
	jr c, .asm_17e1bb
	ld a, [wc708]
	ldh [rSVBK], a
	jr .asm_17e1c1

.asm_17e1bb
	ld a, [wc708]
	call OpenSRAM

.asm_17e1c1
	ld a, [wc709]
	ld l, a
	ld a, [wc70a]
	ld h, a
	ld de, wc608
	ld a, [wc70b]
	ld c, a
	ld b, 0
	call CopyBytes
	ld a, [wc70a]
	cp $c0
	jr c, .asm_17e1e2
	ld a, $4
	ldh [rSVBK], a
	jr .asm_17e1e5

.asm_17e1e2
	call CloseSRAM

.asm_17e1e5
	ld a, [wc70e]
	cp $c0
	jr c, .asm_17e1f3
	ld a, [wc70c]
	ldh [rSVBK], a
	jr .asm_17e1f9

.asm_17e1f3
	ld a, [wc70c]
	call OpenSRAM

.asm_17e1f9
	ld a, [wc70d]
	ld l, a
	ld a, [wc70e]
	ld h, a
	ld de, wc688
	ld a, [wc70b]
	ld c, a
	ld b, 0
	call CopyBytes
	ld a, [wc70e]
	cp $c0
	jr c, .asm_17e21a
	ld a, $4
	ldh [rSVBK], a
	jr .asm_17e21d

.asm_17e21a
	call CloseSRAM

.asm_17e21d
	ld a, [wc70b]
	ld c, a
	ld hl, wc688
	ld de, wc608
.asm_17e227
	ld a, [de]
	inc de
	cp [hl]
	inc hl
	jr z, .asm_17e231
	jr c, .asm_17e23e
	jr .asm_17e248

.asm_17e231
	dec c
	jr nz, .asm_17e227
	ld a, [wc711]
	ld l, a
	ld a, [wc712]
	ld h, a
	jr .asm_17e250

.asm_17e23e
	ld a, [wc70f]
	ld l, a
	ld a, [wc710]
	ld h, a
	jr .asm_17e250

.asm_17e248
	ld a, [wc712 + 1]
	ld l, a
	ld a, [wc712 + 2]
	ld h, a

.asm_17e250
	call Function17e40f
	ret

Function17e254:
	call IncCrashCheckPointer
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	ld a, [hli]
	ld [de], a
	call HlToCrashCheckPointer
	ret

Function17e261:
	call IncCrashCheckPointer
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	ld a, [de]
	add [hl]
	ld [de], a
	inc hl
	call HlToCrashCheckPointer
	ret

Function17e270:
	call IncCrashCheckPointer
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	ld a, [de]
	sub [hl]
	ld [de], a
	inc hl
	call HlToCrashCheckPointer
	ret

Function17e27f:
	call IncCrashCheckPointer
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	call HlToCrashCheckPointer
	ld l, c
	ld h, b
	ld a, [de]
	add [hl]
	ld [de], a
	ret

Function17e293:
	call IncCrashCheckPointer
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	call HlToCrashCheckPointer
	ld l, c
	ld h, b
	ld a, [de]
	sub [hl]
	ld [de], a
	ret

Function17e2a7:
	call IncCrashCheckPointer
	call HlToCrashCheckPointer
	call Function17e32b
	xor a
	ld [wcf66], a
	farcall Function118233
	ld de, PostalMarkGFX
	ld hl, vTiles2 tile $60
	lb bc, BANK(PostalMarkGFX), 1
	call Get2bpp
	ld a, [wMobileErrorCodeBuffer]
	and a
	jr z, .asm_17e2d8
	cp $a
	jr z, .asm_17e2f7
	cp $b
	jr z, .asm_17e300
	call Function17e309
	ret

.asm_17e2d8
	call Function17d60b
	call Function17e349
	xor a
	ld [wcd7a], a
	ld a, $5
	call OpenSRAM
	ld hl, $aa73
	ld de, $aa7f
	ld bc, $c
	call CopyBytes
	call CloseSRAM
	ret

.asm_17e2f7
	call Function17e349
	ld a, $1
	ld [wcd7a], a
	ret

.asm_17e300
	call Function17e349
	ld a, $2
	ld [wcd7a], a
	ret

Function17e309:
	ld a, $2
	ld [wc303], a
	call Function17dcaf
	call ClearScreen
	call Function17e349
	call Function17d5f6
	farcall DisplayMobileError
	call Function17e349
	call Function17dcaf
	xor a
	ld [wcd77], a
	ret

Function17e32b:
	ld a, $5
	call OpenSRAM
	ld hl, wc608
	ld de, $b0b1
	ld bc, $40
	call CopyBytes
	ld hl, wBGMapBuffer
	ld bc, $5b
	call CopyBytes
	call CloseSRAM
	ret

Function17e349:
	ld a, $5
	call OpenSRAM
	ld hl, $b0b1
	ld de, wc608
	ld bc, $40
	call CopyBytes
	ld de, wBGMapBuffer
	ld bc, $5b
	call CopyBytes
	call CloseSRAM
	ret

MACRO inc_crash_check_pointer_farcall
	call IncCrashCheckPointer
	call HlToCrashCheckPointer ; redundant
	ldh a, [rSVBK]
	push af
	ld a, $1
	ldh [rSVBK], a
	rept _NARG
		farcall \1
		shift
	endr
	pop af
	ldh [rSVBK], a
	ret
ENDM

IncCrashCheckPointer_SaveGameData:
	inc_crash_check_pointer_farcall SaveGameData

IncCrashCheckPointer_SaveAfterLinkTrade:
	inc_crash_check_pointer_farcall SaveAfterLinkTrade

IncCrashCheckPointer_SaveBox:
	inc_crash_check_pointer_farcall DoNothing

IncCrashCheckPointer_SaveChecksum:
	inc_crash_check_pointer_farcall SaveChecksum

IncCrashCheckPointer_SaveTrainerRankingsChecksum:
	inc_crash_check_pointer_farcall UpdateTrainerRankingsChecksum2, BackupGSBallFlag

Function17e3e0:
	call IncCrashCheckPointer
	ld a, [hli]
	ld c, a
	call HlToCrashCheckPointer
	ld a, $1
	ldh [hBGMapMode], a
	call DelayFrames
	ret

Function17e3f0:
	call IncCrashCheckPointer
	call HlToCrashCheckPointer
.asm_17e3f6
	call JoyTextDelay
	ld hl, hJoyPressed
	ld a, [hl]
	and $1
	ret nz
	ld a, [hl]
	and $2
	ret nz
	call WaitBGMap
	jr .asm_17e3f6

Function17e409:
	ld hl, wcd77
	set 7, [hl]
	ret

Function17e40f:
	ld de, wBGPals1
	add hl, de
	jr HlToCrashCheckPointer

IncCrashCheckPointer:
	ld a, [wMobileCrashCheckPointer]
	ld l, a
	ld a, [wMobileCrashCheckPointer + 1]
	ld h, a
	inc hl

HlToCrashCheckPointer:
	ld a, l
	ld [wMobileCrashCheckPointer], a
	ld a, h
	ld [wMobileCrashCheckPointer + 1], a
	ret

Function17e43d:
	ld a, [wBGMapBuffer]
	ld l, a
	ld a, [wcd21]
	ld h, a
	add hl, bc
	ret

Function17e447:
	ld a, [wBGMapBuffer]
	ld l, a
	ld a, [wcd21]
	ld h, a
	add hl, de
	ret

Function17e451:
	ld a, [wcd42]
	and a
	ret z
	call Function17e51b
	call Function17e4dd
	ld a, [wcd2e]
	push af
	ld a, [wcd49]
	ld l, a
	ld a, [wcd4a]
	ld h, a
	ld a, [wcd2f]
	ld [wcd2e], a
	ld c, a
	ld b, 0
	add hl, bc
	add hl, bc
	push hl
	hlcoord 0, 0
	ld bc, $14
	ld a, [wcd23]
	call AddNTimes
	ld a, [wCreditsTimer]
	ld c, a
	ld b, 0
	add hl, bc
	pop bc
	ld a, [wMobileCommsJumptableIndex]
.asm_17e48b
	push af
	push hl
	ld a, [wcd24]
.asm_17e490
	push af
	push hl
	ld a, [bc]
	inc bc
	ld e, a
	ld a, [bc]
	inc bc
	ld d, a
	push bc
	push hl
	ld a, [wBGMapBuffer]
	ld l, a
	ld a, [wcd21]
	ld h, a
	add hl, de
	push hl
	pop de
	pop hl
	call PlaceString
	pop bc
	pop hl
	ld a, [wcd26]
	ld e, a
	ld d, 0
	add hl, de
	ld a, [wcd2e]
	inc a
	ld [wcd2e], a
	ld e, a
	ld a, [wcd42]
	cp e
	jr z, .asm_17e4d5
	pop af
	dec a
	jr nz, .asm_17e490
	pop hl
	ld a, [wcd27]
	ld de, $14
.asm_17e4cb
	add hl, de
	dec a
	jr nz, .asm_17e4cb
	pop af
	dec a
	jr nz, .asm_17e48b
	jr .asm_17e4d8

.asm_17e4d5
	pop af
	pop hl
	pop af

.asm_17e4d8
	pop af
	ld [wcd2e], a
	ret

Function17e4dd:
	ld a, [wcd2c]
	and $1
	ret z
	ld a, [wcd29]
	hlcoord 0, 0
	ld bc, $14
	call AddNTimes
	ld a, [wcd28]
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [wcd2f]
	and a
	jr z, .asm_17e4ff
	ld a, $61
	ld [hl], a

.asm_17e4ff
	ld a, [wcd2a]
	ld bc, $14
	call AddNTimes
	ld a, [wcd42]
	ld c, a
	ld a, [wcd2e]
	ld b, a
	ld a, [wcd24]
	add b
	cp c
	ret z
	ret nc
	ld a, $ee
	ld [hl], a
	ret

Function17e51b:
	ld a, [wcd28]
	ld hl, wCreditsTimer
	sub [hl]
	inc a
	ld [wcd4f], a
	hlcoord 0, 0
	ld bc, $14
	ld a, [wcd23]
	dec a
	call AddNTimes
	ld a, [wCreditsTimer]
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [wMobileCommsJumptableIndex]
	ld c, a
	ld a, [wcd27]
	call SimpleMultiply
.asm_17e544
	push af
	push hl
	ld a, [wcd4f]
	ld c, a
	ld b, 0
	ld a, $7f
	call ByteFill
	pop hl
	ld bc, $14
	add hl, bc
	pop af
	dec a
	jr nz, .asm_17e544
	ret

Function17e55b:
	ld a, [wcd42]
	and a
	ret z
	ld a, $ed
	call Function17e571
	ret

Function17e566:
	ld a, [wcd42]
	and a
	ret z
	ld a, $7f
	call Function17e571
	ret

Function17e571:
	push af
	hlcoord 0, 0
	ld bc, $14
	ld a, [wcd23]
	call AddNTimes
	ld a, [wCreditsTimer]
	ld c, a
	ld b, 0
	add hl, bc
	dec hl
	push hl
	ld a, [wcd31]
	dec a
	ld c, a
	ld a, [wcd27]
	call SimpleMultiply
	ld l, $0
	ld h, l
	ld bc, $14
	call AddNTimes
	ld a, [wcd30]
	dec a
	ld c, a
	ld a, [wcd26]
	call SimpleMultiply
	ld c, a
	ld b, 0
	add hl, bc
	pop bc
	add hl, bc
	pop af
	ld [hl], a
	ret

Function17e5af:
	ld a, [wcd2c]
	and $2
	ret z
	ld a, [wcd43]
	ld l, a
	ld a, [wMobileInactivityTimerMinutes]
	ld h, a
	bccoord 0, 0
	add hl, bc
	ld bc, $ffec
	add hl, bc
	ld a, [wMobileInactivityTimerSeconds]
	ld c, a
	ld b, 0
	ld a, [wMobileInactivityTimerFrames]
	call Function17e600
	ld a, [wcd2e]
	ld c, a
	ld b, 0
	ld a, [wcd4d]
	ld l, a
	ld a, [wcd4e]
	ld h, a
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	ld a, [wBGMapBuffer]
	ld l, a
	ld a, [wcd21]
	ld h, a
	add hl, de
	push hl
	pop de
	ld a, [wcd43]
	ld l, a
	ld a, [wMobileInactivityTimerMinutes]
	ld h, a
	bccoord 0, 0
	add hl, bc
	call PlaceString
	ret

Function17e600:
.asm_17e600
	push af
	push hl
	push bc
	ld a, $7f
	call ByteFill
	pop bc
	pop hl
	ld de, $14
	add hl, de
	pop af
	dec a
	jr nz, .asm_17e600
	ret

Function17e613:
	push hl
	hlcoord 0, 0
	ld bc, $14
	ld a, [de]
	inc de
	push af
	ld a, [de]
	inc de
	and a
.asm_17e620
	jr z, .asm_17e626
	add hl, bc
	dec a
	jr .asm_17e620

.asm_17e626
	pop af
	ld c, a
	ld b, 0
	add hl, bc
	push hl
	ld a, [wcd53]
	ld [hli], a
	ld a, [de]
	inc de
	dec a
	dec a
	jr z, .asm_17e63f
	ld c, a
	ld a, [wcd53]
	inc a
.asm_17e63b
	ld [hli], a
	dec c
	jr nz, .asm_17e63b

.asm_17e63f
	ld a, [wcd53]
	add $2
	ld [hl], a
	pop hl
	ld bc, $14
	add hl, bc
	ld a, [de]
	dec de
	dec a
	dec a
	jr z, .asm_17e674
	ld b, a
.asm_17e651
	push hl
	ld a, [wcd53]
	add $3
	ld [hli], a
	ld a, [de]
	dec a
	dec a
	jr z, .asm_17e664
	ld c, a
	ld a, $7f
.asm_17e660
	ld [hli], a
	dec c
	jr nz, .asm_17e660

.asm_17e664
	ld a, [wcd53]
	add $4
	ld [hl], a
	pop hl
	push bc
	ld bc, $14
	add hl, bc
	pop bc
	dec b
	jr nz, .asm_17e651

.asm_17e674
	ld a, [wcd53]
	add $5
	ld [hli], a
	ld a, [de]
	dec a
	dec a
	jr z, .asm_17e689
	ld c, a
	ld a, [wcd53]
	add $6
.asm_17e685
	ld [hli], a
	dec c
	jr nz, .asm_17e685

.asm_17e689
	ld a, [wcd53]
	add $7
	ld [hl], a
	pop hl
	ret

Function17e691:
	push hl
	ld hl, NULL
	ld bc, $14
	ld a, [de]
	inc de
	push af
	ld a, [de]
	inc de
	inc de
	and a
.asm_17e69f
	jr z, .asm_17e6a5
	add hl, bc
	dec a
	jr .asm_17e69f

.asm_17e6a5
	pop af
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [de]
	dec de
.asm_17e6ac
	push af
	push hl
	ld a, [de]
.asm_17e6af
	push af
	push hl
	push hl
	bccoord 0, 0
	add hl, bc
	ld a, [hl]
	cp $7f
	jr z, .asm_17e6c2
	ld a, [wcd53]
	add $8
	jr .asm_17e6c7

.asm_17e6c2
	ld a, [wcd53]
	jr .asm_17e6c7

.asm_17e6c7
	pop hl
	bccoord 0, 0, wAttrmap
	add hl, bc
	ld [hl], a
	pop hl
	inc hl
	pop af
	dec a
	jr nz, .asm_17e6af
	pop hl
	ld bc, $14
	add hl, bc
	pop af
	dec a
	jr nz, .asm_17e6ac
	pop hl
	ret

Function17e6de:
	push af
	ld a, [wc708]
	ld l, a
	ld a, [wc709]
	ld h, a
	decoord 0, 0, wAttrmap
	add hl, de
	pop af
	ld b, $7
.asm_17e6ee
	push hl
	ld c, $7
.asm_17e6f1
	ld [hli], a
	dec c
	jr nz, .asm_17e6f1
	pop hl
	ld de, $14
	add hl, de
	dec b
	jr nz, .asm_17e6ee
	ret

PokemonNewsGFX:
INCBIN "gfx/mobile/pokemon_news.2bpp"

PostalMarkGFX:
INCBIN "gfx/font/postal_mark.2bpp"

PokemonNewsPalettes:
INCLUDE "gfx/mobile/pokemon_news.pal"

Function17f4f6:
	ld a, [wcd6a]
	ld l, a
	ld a, [wcd6b]
	ld h, a
	ld a, [wcd47]
	ld c, a
	ld a, [wBGMapPalBuffer]
	ld b, a
	ld a, [wcd2e]
.asm_17f509
	and a
	ret z
	dec a
	add hl, bc
	jr .asm_17f509

BattleTowerMobileError:
	call FadeToMenu
	xor a
	ld [wc303], a
	ldh a, [rSVBK]
	push af
	ld a, $1
	ldh [rSVBK], a

	call DisplayMobileError

	pop af
	ldh [rSVBK], a
	call ExitAllMenus
	ret

DisplayMobileError:
.loop
	call JoyTextDelay
	call .RunJumptable
	ld a, [wc303]
	bit 7, a
	jr nz, .quit
	farcall HDMATransferAttrmapAndTilemapToWRAMBank3
	jr .loop

.quit
	call .deinit
	ret

.deinit
	ld a, [wMobileErrorCodeBuffer]
	cp $22
	jr z, .asm_17f597
	cp $31
	jr z, .asm_17f58a
	cp $33
	ret nz
	ld a, [wMobileErrorCodeBuffer + 1]
	cp $1
	ret nz
	ld a, [wMobileErrorCodeBuffer + 2]
	cp $2
	ret nz
	jr .asm_17f5a1

.asm_17f58a
	ld a, [wMobileErrorCodeBuffer + 1]
	cp $3
	ret nz
	ld a, [wMobileErrorCodeBuffer + 2]
	and a
	ret nz
	jr .asm_17f5a1

.asm_17f597
	ld a, [wMobileErrorCodeBuffer + 1]
	and a
	ret nz
	ld a, [wMobileErrorCodeBuffer + 2]
	and a
	ret nz

.asm_17f5a1
	ld a, BANK(sMobileLoginPassword)
	call OpenSRAM
	xor a
	ld [sMobileLoginPassword], a
	call CloseSRAM
	ret

.RunJumptable:
	jumptable .Jumptable, wc303

.Jumptable:
	dw Function17f5c3
	dw Function17ff23
	dw Function17f5d2

Function17f5c3:
	call Function17f5e4
	farcall FinishExitMenu
	ld a, $1
	ld [wc303], a
	ret

Function17f5d2:
	call Function17f5e4
	farcall HDMATransferAttrmapAndTilemapToWRAMBank3
	call SetDefaultBGPAndOBP
	ld a, $1
	ld [wc303], a
	ret

Function17f5e4:
	ld a, $8
	ld [wMusicFade], a
	ld de, MUSIC_NONE
	ld a, e
	ld [wMusicFadeID], a
	ld a, d
	ld [wMusicFadeID + 1], a
	ld a, " "
	hlcoord 0, 0
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	call ByteFill
	ld a, $6
	hlcoord 0, 0, wAttrmap
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	call ByteFill
	hlcoord 2, 1
	ld b, $1
	ld c, $e
	call Function3eea
	hlcoord 1, 4
	ld b, $c
	ld c, $10
	call Function3eea
	hlcoord 3, 2
	ld de, MobileCommunicationErrorText
	call PlaceString
	call Function17ff3c
	jr nc, .asm_17f632
	hlcoord 11, 2
	call Function17f6b7

.asm_17f632
	ld a, [wMobileErrorCodeBuffer]
	cp $d0
	jr nc, .asm_17f684
	cp $10
	jr c, .asm_17f679
	sub $10
	cp $24
	jr nc, .asm_17f679
	ld e, a
	ld d, 0
	ld hl, MobileErrorCodeTable
	add hl, de
	add hl, de
	ld a, [wMobileErrorCodeBuffer + 1]
	ld e, a
	ld a, [wMobileErrorCodeBuffer + 2]
	ld d, a
	ld a, [hli]
	ld c, a
	ld a, [hl]
	ld h, a
	ld l, c
	ld a, [hli]
	and a
	jr z, .asm_17f679
	ld c, a
.asm_17f65d
	ld a, [hli]
	ld b, a
	ld a, [hli]
	cp $ff
	jr nz, .asm_17f667
	cp b
	jr z, .asm_17f66e

.asm_17f667
	xor d
	jr nz, .asm_17f674
	ld a, b
	xor e
	jr nz, .asm_17f674

.asm_17f66e
	ld a, [hli]
	ld e, a
	ld a, [hl]
	ld d, a
	jr .asm_17f67d

.asm_17f674
	inc hl
	inc hl
	dec c
	jr nz, .asm_17f65d

.asm_17f679
	ld a, $d9
	jr .asm_17f684

.asm_17f67d
	hlcoord 2, 6
	call PlaceString
	ret

.asm_17f684
	sub $d0
	ld e, a
	ld d, 0
	ld hl, Table_17f699
	add hl, de
	add hl, de
	ld a, [hli]
	ld e, a
	ld a, [hl]
	ld d, a
	hlcoord 2, 6
	call PlaceString
	ret

Table_17f699:
	dw MobileErrorCode_101_000_Text
	dw MobileErrorCode_101_001_Text
	dw MobileErrorCode_101_002_Text
	dw MobileErrorCode_101_003_Text
	dw MobileErrorCode_101_004_Text
	dw MobileErrorCode_101_005_Text
	dw MobileErrorCode_101_006_Text
	dw MobileErrorCode_101_007_Text
	dw MobileErrorCode_101_008_Text
	dw MobileErrorCode_101_009_Text
	dw MobileErrorCode_101_009_Text


Function17f6b7:
	ld a, [wMobileErrorCodeBuffer]
	call .bcd_two_digits
	inc hl
	ld a, [wMobileErrorCodeBuffer + 2]
	and $f
	call .bcd_digit
	ld a, [wMobileErrorCodeBuffer + 1]
	call .bcd_two_digits
	ret

.bcd_two_digits
	ld c, a
	and $f0
	swap a
	call .bcd_digit
	ld a, c
	and $f

.bcd_digit
	add "0"
	ld [hli], a
	ret

MobileCommunicationErrorText:
	db "つうしんエラー　　　ー@"


MobileErrorCodeTable:
	dw MobileErrorCodes_10
	dw MobileErrorCodes_11
	dw MobileErrorCodes_12
	dw MobileErrorCodes_13
	dw MobileErrorCodes_14
	dw MobileErrorCodes_15
	dw MobileErrorCodes_16
	dw MobileErrorCodes_17
	dw MobileErrorCodes_20
	dw MobileErrorCodes_20
	dw MobileErrorCodes_20
	dw MobileErrorCodes_20
	dw MobileErrorCodes_20
	dw MobileErrorCodes_20
	dw MobileErrorCodes_20
	dw MobileErrorCodes_20
	dw MobileErrorCodes_20
	dw MobileErrorCodes_21
	dw MobileErrorCodes_22
	dw MobileErrorCodes_23
	dw MobileErrorCodes_24
	dw MobileErrorCodes_25
	dw MobileErrorCodes_26
	dw MobileErrorCodes_30
	dw MobileErrorCodes_30
	dw MobileErrorCodes_30
	dw MobileErrorCodes_30
	dw MobileErrorCodes_30
	dw MobileErrorCodes_30
	dw MobileErrorCodes_30
	dw MobileErrorCodes_30
	dw MobileErrorCodes_30
	dw MobileErrorCodes_30
	dw MobileErrorCodes_31
	dw MobileErrorCodes_32
	dw MobileErrorCodes_33

MobileErrorCodes_10: db 1
	dw $000, MobileErrorCode_10_000_Text

MobileErrorCodes_11: db 1
	dw $000, MobileErrorCode_11_000_Text

MobileErrorCodes_12: db 1
	dw $000, MobileErrorCode_12_000_Text

MobileErrorCodes_13: db 1
	dw $000, MobileErrorCode_13_000_Text

MobileErrorCodes_14: db 1
	dw $000, MobileErrorCode_14_000_Text

MobileErrorCodes_15: db 4
	dw $000, MobileErrorCode_15_000_Text
	dw $001, MobileErrorCode_15_001_Text
	dw $002, MobileErrorCode_15_002_Text
	dw $003, MobileErrorCode_15_003_Text

MobileErrorCodes_16: db 1
	dw $000, MobileErrorCode_CommuncationErrorText

MobileErrorCodes_17: db 1
	dw $000, MobileErrorCode_CommuncationErrorText

MobileErrorCodes_20: db 1
	dw $000, MobileErrorCode_CommuncationErrorText

MobileErrorCodes_21: db 1
	dw $000, MobileErrorCode_CommuncationErrorText

MobileErrorCodes_22: db 1
	dw $000, MobileErrorCode_22_000_Text

MobileErrorCodes_23: db 1
	dw $000, MobileErrorCode_23_000_Text

MobileErrorCodes_24: db 1
	dw $000, MobileErrorCode_ServerConnectionFailedText

MobileErrorCodes_25: db 1
	dw $000, MobileErrorCode_25_000_Text

MobileErrorCodes_26: db 1
	dw $000, MobileErrorCode_26_000_Text

MobileErrorCodes_30: db 17
	dw $000, MobileErrorCode_CommuncationErrorText
	dw $221, MobileErrorCode_ServerConnectionFailedText
	dw $421, MobileErrorCode_ServerConnectionFailedText
	dw $450, MobileErrorCode_30_450_Text
	dw $451, MobileErrorCode_ServerConnectionFailedText
	dw $452, MobileErrorCode_ServerConnectionFailedText
	dw $500, MobileErrorCode_CommuncationErrorText
	dw $501, MobileErrorCode_CommuncationErrorText
	dw $502, MobileErrorCode_CommuncationErrorText
	dw $503, MobileErrorCode_CommuncationErrorText
	dw $504, MobileErrorCode_CommuncationErrorText
	dw $550, MobileErrorCode_30_550_Text
	dw $551, MobileErrorCode_30_551_Text
	dw $552, MobileErrorCode_ServerConnectionFailedText
	dw $553, MobileErrorCode_30_553_Text
	dw $554, MobileErrorCode_ServerConnectionFailedText
	dw -1, MobileErrorCode_ServerConnectionFailedText

MobileErrorCodes_31: db 5
	dw $000, MobileErrorCode_CommuncationErrorText
	dw $002, MobileErrorCode_31_002_Text
	dw $003, MobileErrorCode_31_003_Text
	dw $004, MobileErrorCode_CommuncationErrorText
	dw -1, MobileErrorCode_ServerConnectionFailedText

MobileErrorCodes_32: db 17
	dw $000, MobileErrorCode_CommuncationErrorText
	dw $301, MobileErrorCode_CommuncationErrorText
	dw $302, MobileErrorCode_CommuncationErrorText
	dw $400, MobileErrorCode_CommuncationErrorText
	dw $401, MobileErrorCode_CommuncationErrorText
	dw $403, MobileErrorCode_32_403_Text
	dw $404, MobileErrorCode_32_404_Text
	dw $405, MobileErrorCode_CommuncationErrorText
	dw $406, MobileErrorCode_CommuncationErrorText
	dw $407, MobileErrorCode_CommuncationErrorText
	dw $408, MobileErrorCode_32_408_Text
	dw $500, MobileErrorCode_ServerErrorText
	dw $501, MobileErrorCode_CommuncationErrorText
	dw $502, MobileErrorCode_ServerErrorText
	dw $503, MobileErrorCode_32_503_Text
	dw $504, MobileErrorCode_ServerErrorText
	dw -1, MobileErrorCode_ServerErrorText

MobileErrorCodes_33: db 19
	dw $101, MobileErrorCode_33_101_Text
	dw $102, MobileErrorCode_33_102_Text
	dw $103, MobileErrorCode_33_103_Text
	dw $104, MobileErrorCode_33_104_Text
	dw $105, MobileErrorCode_33_105_Text
	dw $106, MobileErrorCode_33_106_Text
	dw $201, MobileErrorCode_33_201_Text
	dw $202, MobileErrorCode_CommuncationErrorText
	dw $203, MobileErrorCode_33_203_Text
	dw $204, MobileErrorCode_CommuncationErrorText
	dw $205, MobileErrorCode_ServerErrorText
	dw $206, MobileErrorCode_33_206_Text
	dw $299, MobileErrorCode_33_299_Text
	dw $301, MobileErrorCode_ServerErrorText
	dw $401, MobileErrorCode_ServerErrorText
	dw $402, MobileErrorCode_ServerErrorText
	dw $403, MobileErrorCode_ServerErrorText
	dw $404, MobileErrorCode_ServerErrorText
	dw -1, MobileErrorCode_ServerErrorText

MobileErrorCode_10_000_Text:
; The Mobile Adapter is not properly plugged in.
; Ensure you have taken a good look at and properly followed the instructions.
	db   "モバイルアダプタが　ただしく"
	next "さしこまれていません"
	next "とりあつかいせつめいしょを"
	next "ごらんのうえ　しっかりと"
	next "さしこんで　ください"
	db   "@"

MobileErrorCode_11_000_Text:
MobileErrorCode_13_000_Text:
; Could not connect because either the phone cannot make the call, or the telephone line is busy.
; Please wait for a while and call again.
	db   "でんわが　うまく　かけられないか"
	next "でんわかいせんが　こんでいるので"
	next "つうしん　できません"
	next "しばらく　まって"
	next "かけなおして　ください"
	db   "@"

MobileErrorCode_12_000_Text:
; As the telephone line is busy, the phone was not able to gather enough information (?)
; Please wait for a while and call again.
	db   "でんわかいせんが　こんでいるため"
	next "でんわが　かけられません"
	next "しばらく　まって"
	next "かけなおして　ください"
	db   "@"

MobileErrorCode_15_000_Text:
MobileErrorCode_15_001_Text:
MobileErrorCode_15_002_Text:
MobileErrorCode_15_003_Text:
; There is an error with the Mobile Adapter.
; Please wait for a little while before calling again.
; If the problem persists, please contact the Mobile Support Center.
	db   "モバイルアダプタの　エラーです"
	next "しばらく　まって"
	next "かけなおして　ください"
	next "なおらない　ときは"
	next "モバイルサポートセンターへ"
	next "おといあわせください"
	db   "@"

MobileErrorCode_CommuncationErrorText:
; Communication error.
; Please wait a moment, and then try again.
; If the issue persists, please contact the Mobile Support Center.
	db   "つうしんエラーです"
	next "しばらく　まって"
	next "かけなおして　ください"
	next "なおらない　ときは"
	next "モバイルサポートセンターへ"
	next "おといあわせください"
	db   "@"

MobileErrorCode_22_000_Text:
; There is a mistake either with the login password, or the login ID.
; Please confirm the password, wait for a while, and try again.
	db   "ログインパスワードか"
	next "ログイン　アイディーに"
	next "まちがいがあります"
	next "パスワードを　かくにんして"
	next "しばらく　まって"
	next "かけなおして　ください"
	db   "@"

MobileErrorCode_23_000_Text:
; The call was ended.
; Please see the instruction manual, wait a moment, and try again.
	db   "でんわが　きれました"
	next "とりあつかいせつめいしょを"
	next "ごらんのうえ"
	next "しばらく　まって"
	next "かけなおして　ください"
	db   "@"

MobileErrorCode_ServerErrorText:
; There was a communication error with the mobile center.
; Please wait a moment and then try again.
	db   "モバイルセンターの"
	next "つうしんエラーです"
	next "しばらくまって"
	next "かけなおして　ください"
	db   "@"

MobileErrorCode_14_000_Text:
MobileErrorCode_25_000_Text:
; The Mobile Adapter's details have expired and the information is not correct.
; Please use the Mobile Trainer to repeat the initial registration (process).
	db   "モバイルアダプタに"
	next "とうろくされた　じょうほうが"
	next "ただしく　ありません"
	next "モバイルトレーナーで"
	next "しょきとうろくを　してください"
	db   "@"

MobileErrorCode_32_503_Text:
; Could not connect because the Mobile Center is busy.
; Please wait a moment and try again.
; For details, please see the instruction manual.
	db   "モバイルセンターが"
	next "こんでいて　つながりません"
	next "しばらくまって"
	next "かけなおして　ください"
	next "くわしくは　とりあつかい"
	next "せつめいしょを　ごらんください"
	db   "@"

MobileErrorCode_30_450_Text:
MobileErrorCode_30_550_Text:
MobileErrorCode_30_551_Text:
MobileErrorCode_30_553_Text:
; There is a mistake with the email address of the addressee.
; Please replace with a / the correct email address.
	db   "あてさき　メールアドレスに"
	next "まちがいがあります"
	next "ただしい　メールアドレスを"
	next "いれなおしてください"
	db   "@"

MobileErrorCode_31_002_Text:
; There is a mistake with the email address.
; Please see the instruction manual, and use the Mobile Trainer to repeat the initial registration (process).
	db   "メールアドレスに"
	next "まちがいが　あります"
	next "とりあつかいせつめいしょを"
	next "ごらんのうえ"
	next "モバイルトレーナーで"
	next "しょきとうろくを　してください"
	db   "@"

MobileErrorCode_31_003_Text:
MobileErrorCode_33_201_Text:
; There is either an error with the login password, or an error with the Mobile Center.
; Please confirm the password, wait a moment, and then try again.
	db   "ログインパスワードに"
	next "まちがいが　あるか"
	next "モバイルセンターの　エラーです"
	next "パスワードを　かくにんして"
	next "しばらく　まって"
	next "かけなおして　ください"
	db   "@"

MobileErrorCode_32_403_Text:
MobileErrorCode_32_404_Text:
; Cannot read data.
; Please wait a moment, and then try again.
; If the issue persists, please contact the Mobile Support Center.
	db   "データの　よみこみが　できません"
	next "しばらくまって"
	next "かけなおして　ください"
	next "なおらない　ときは"
	next "モバイルサポートセンターへ"
	next "おといあわせください"
	db   "@"

MobileErrorCode_26_000_Text:
MobileErrorCode_32_408_Text:
; Out of time.
; The call was ended.
; Please try again.
; For details, please see the instruction manual.
	db   "じかんぎれです"
	next "でんわが　きれました"
	next "でんわを　かけなおしてください"
	next "くわしくは　とりあつかい"
	next "せつめいしょを　ごらんください"
	db   "@"

MobileErrorCode_33_101_Text:
; The service cannot be used if payments for usage fees are late.
; For details, please see the instruction manual.
	db   "ごりよう　りょうきんの　"
	next "おしはらいが　おくれたばあいには"
	next "ごりようが　できなくなります"
	next "くわしくは　とりあつかい"
	next "せつめいしょを　ごらんください"
	db   "@"

MobileErrorCode_33_102_Text:
MobileErrorCode_33_299_Text:
; Your access to this service has been restricted. Service cannot be used.
; For details, please see the instruction manual.
	db   "おきゃくさまの　ごつごうにより"
	next "ごりようできません"
	next "くわしくは　とりあつかい"
	next "せつめいしょを　ごらんください"
	db   "@"

MobileErrorCode_ServerConnectionFailedText:
; The telephone line is busy. Due to this error, the Mobile Center cannot communicate.
; Please wait for a little while and call again.
	db   "でんわかいせんが　こんでいるか"
	next "モバイルセンターの　エラーで"
	next "つうしんが　できません"
	next "しばらく　まって"
	next "かけなおして　ください"
	db   "@"

MobileErrorCode_33_103_Text:
; Service cannot be used this month because usage fees have exceeded conditions.
; For details, please see the instruction manual.
	db   "ごりよう　りょうきんが"
	next "じょうげんを　こえているため"
	next "こんげつは　ごりようできません"
	next "くわしくは　とりあつかい"
	next "せつめいしょを　ごらんください"
	db   "@"

MobileErrorCode_33_106_Text:
; Cannot communicate because the Mobile Center is currently undergoing maintenance.
; Please wait a moment, then try again.
	db   "げんざい　モバイルセンターの"
	next "てんけんを　しているので"
	next "つうしんが　できません"
	next "しばらく　まって"
	next "かけなおして　ください"
	db   "@"

MobileErrorCode_33_104_Text:
MobileErrorCode_33_105_Text:
MobileErrorCode_33_203_Text:
MobileErrorCode_33_206_Text:
MobileErrorCode_101_004_Text:
; Cannot read data.
; For details, please see the instruction manual.
	db   "データの　よみこみが　できません"
	next "くわしくは　とりあつかい"
	next "せつめいしょを　ごらんください"
	db   "@"

MobileErrorCode_101_006_Text:
; Call ended because more than 3 minutes elapsed with no input.
	db   "３ぷん　いじょう　なにも"
	next "にゅうりょく　しなかったので"
	next "でんわが　きれました"
	db   "@"

MobileErrorCode_101_001_Text:
MobileErrorCode_101_002_Text:
; Could not connect properly.
; Please try again from the beginning (of the process).
	db   "つうしんが　うまく"
	next "できませんでした"
	next "もういちど　はじめから"
	next "やりなおしてください"
	db   "@"

MobileErrorCode_101_003_Text:
MobileErrorCode_101_008_Text:
MobileErrorCode_101_009_Text:
; Cannot read data.
; Please wait a moment, then try again.
; If the issue persists, please contact the Mobile Support Center.
	db   "データの　よみこみが　できません"
	next "しばらくまって"
	next "かけなおして　ください"
	next "なおらない　ときは"
	next "モバイルサポートセンターへ"
	next "おといあわせください"
	db   "@"

MobileErrorCode_101_007_Text:
; Call ended due to long waiting time.
	db   "まちじかんが　ながいので"
	next "でんわが　きれました"
	db   "@"

MobileErrorCode_101_005_Text:
; (Your adapter's) type differs from the other user’s Mobile Adapter.
; For details, please see the instruction manual.
	db   "あいての　モバイルアダプタと"
	next "タイプが　ちがいます"
	next "くわしくは　とりあつかい"
	next "せつめいしょを　ごらんください"
	db   "@"

MobileErrorCode_101_000_Text:
; Either bad communication status, or the other user called was the incorrect user.
; Please confirm and try again.
	db   "つうしんの　じょうきょうが"
	next "よくないか　かけるあいてが"
	next "まちがっています"
	next "もういちど　かくにんをして"
	next "でんわを　かけなおして　ください"
	db   "@"

Function17ff23:
	ldh a, [hJoyPressed]
	and a
	ret z
	ld a, $8
	ld [wMusicFade], a
	ld a, [wMapMusic]
	ld [wMusicFadeID], a
	xor a
	ld [wMusicFadeID + 1], a
	ld hl, wc303
	set 7, [hl]
	ret

Function17ff3c:
	ld a, [wMobileErrorCodeBuffer]
	cp $d0
	ret c
	hlcoord 10, 2
	ld de, String_17ff68
	call PlaceString
	ld a, [wMobileErrorCodeBuffer]
	push af
	sub $d0
	inc a
	ld [wMobileErrorCodeBuffer], a
	hlcoord 14, 2
	ld de, wMobileErrorCodeBuffer
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNum
	pop af
	ld [wMobileErrorCodeBuffer], a
	and a
	ret

String_17ff68:
	db "１０１@"
