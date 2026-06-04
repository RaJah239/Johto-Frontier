MoveDetailsMenu_SetupScreen:
	call CopyMenuHeader
	xor a
	ld [wMenuCursorPosition], a
	ld [wMenuScrollPosition], a

	; Build the list frame and reserve space for the title row.
	hlcoord 0, 0
	lb bc, 9, 18
	call TextboxBorder
	hlcoord 2, 0
	lb bc, 1, 16
	call ClearBox

	; Load the PP glyph without disturbing the menu arrows.
	ld de, FontBattleExtra + 14 tiles
	ld hl, vTiles2 tile $6e
	lb bc, BANK(FontBattleExtra), 1
	call Get2bppViaHDMA

	; Needed for the level symbol on the party-mon variant.
	farcall LoadStatsScreenPageTilesGFX
	ret

MoveDetailsMenu_Run:
	call ScrollingMenu
	ld a, [wMenuJoypad]
	cp B_BUTTON
	jr z, .carry
	ld a, [wMenuSelection]
	ld [wPutativeTMHMMove], a
	and a
	ret

.carry
	scf
	ret

ChooseMoveToLearn::
	farcall FadeOutToWhite
	farcall BlankScreen
	ld hl, MoveDetailsMenuPartyMonHeader
	call MoveDetailsMenu_SetupScreen

	xor a
	ld [wMonType], a
	ld hl, wPartyMonNicknames
	ld a, [wCurPartyMon]
	call GetNickname
	hlcoord 3, 0
	call PlaceString

	farcall CopyMonToTempMon
	hlcoord 14, 0
	call PrintLevel
	jr MoveDetailsMenu_Run

ChooseEggMoveToLearn::
	jmp ChooseMoveToLearn

OpenAllMovesDetailsScreen::
	ld hl, MoveDetailsMenuAllMovesHeader
	call MoveDetailsMenu_SetupScreen
	ld a, HP_GREEN
	ld [wPlayerHPPal], a
	jmp MoveDetailsMenu_Run

MoveDetailsMenuPartyMonHeader:
	db MENU_BACKUP_TILES
	menu_coords 1, 1, SCREEN_WIDTH - 2, 9
	dw MoveDetailsMenuPartyMonData
	db 1

MoveDetailsMenuPartyMonData:
	db SCROLLINGMENU_DISPLAY_ARROWS | SCROLLINGMENU_ENABLE_FUNCTION3
	db 4, SCREEN_WIDTH + 2
	db SCROLLINGMENU_ITEMS_NORMAL
	dba wd002
	dba MoveDetailsMenu_PrintMoveName
	dba MoveDetailsMenu_PrintPP
	dba MoveDetailsMenu_PrintMoveDetails

MoveDetailsMenuAllMovesHeader:
	db MENU_BACKUP_TILES
	menu_coords 1, 1, SCREEN_WIDTH - 2, 9
	dw MoveDetailsMenuAllMovesData
	db 1

MoveDetailsMenuAllMovesData:
	db SCROLLINGMENU_DISPLAY_ARROWS | SCROLLINGMENU_ENABLE_FUNCTION3
	db 4, SCREEN_WIDTH + 2
	db SCROLLINGMENU_ITEMS_NORMAL
	dba MoveDetailsMenuAllMovesList
	dba MoveDetailsMenu_PrintMoveName
	dba MoveDetailsMenu_PrintPP
	dba MoveDetailsMenu_PrintMoveDetails

	assert NUM_REAL_MOVES <= $fe
MoveDetailsMenuAllMovesList:
	db NUM_REAL_MOVES
for x, NUM_REAL_MOVES
	db x + 1
endr
	db -1

MoveDetailsMenu_PrintMoveName:
	push de
	ld a, [wMenuSelection]
	ld [wNamedObjectIndex], a
	call GetMoveName
	pop hl
	jmp PlaceString

MoveDetailsMenu_PrintPP:
	ld hl, wStringBuffer1
	ld bc, wStringBuffer2 - wStringBuffer1
	ld a, " "
	call ByteFill
	ld a, [wMenuSelection]
	inc a
	ret z
	dec a
	push de

	ld a, [wMenuSelection]
	ld bc, MOVE_LENGTH
	ld hl, (Moves + MOVE_PP) - MOVE_LENGTH
	call AddNTimes
	ld a, BANK(Moves)
	call GetFarByte
	ld [wBuffer1], a
	ld hl, wStringBuffer1 + 9
	ld de, wBuffer1
	lb bc, 1, 2
	call PrintNum
	ld hl, wStringBuffer1 + 14
	ld [hl], "@"

	pop hl
	ld de, wStringBuffer1
	call PlaceString

	ld bc, 6
	add hl, bc
	ld a, $3e
	ld [hli], a
	ld [hl], a
	ret

MoveDetailsMenu_FixCancelBorder:
	hlcoord 0, 9
	ld [hl], "│"
	inc hl
	ret

MoveDetailsMenu_PrintMoveDetails:
	hlcoord 0, 10
	lb bc, 6, 18
	call TextboxBorder

	ld a, [wMenuSelection]
	cp -1
	jr z, MoveDetailsMenu_FixCancelBorder

	push de
	ld a, [wMenuSelection]
	inc a
	pop de
	ret z
	dec a
	ld [wCurSpecies], a
	hlcoord 1, 14
	predef PrintMoveDescription

	ld a, [wCurSpecies]
	ld b, a
	hlcoord 10, 11
	predef PrintMoveType

	hlcoord 0, 9
	ld de, MoveDetailsMenuTypeTopString
	call PlaceString
	hlcoord 0, 10
	ld de, MoveDetailsMenuTypeBottomString
	call PlaceString
	hlcoord 1, 10
	ld de, MoveDetailsMenuAttackString
	call PlaceString
	hlcoord 1, 12
	ld de, MoveDetailsMenuChanceString
	call PlaceString
	hlcoord 1, 11
	ld de, MoveDetailsMenuAccuracyString
	call PlaceString

	ld a, [wCurSpecies]
	ld b, a
	farcall GetMoveCategoryName
	hlcoord 10, 12
	ld de, wStringBuffer1
	call PlaceString

	ld a, [wMenuSelection]
	ld bc, MOVE_LENGTH
	ld hl, (Moves + MOVE_CHANCE) - MOVE_LENGTH
	call AddNTimes
	ld a, BANK(Moves)
	call GetFarByte
	cp 1
	jr c, .print_null_chance
	call ConvertPercentages
	ld [wBuffer1], a
	ld de, wBuffer1
	lb bc, 1, 3
	hlcoord 5, 12
	call PrintNum
	ld [hl], "<%>"
	jr .print_accuracy

.print_null_chance
	ld de, MoveDetailsMenuNullValueString
	ld bc, 3
	hlcoord 5, 12
	call PlaceString

.print_accuracy
	ld a, [wMenuSelection]
	ld bc, MOVE_LENGTH
	ld hl, (Moves + MOVE_EFFECT) - MOVE_LENGTH
	call AddNTimes
	ld a, BANK(Moves)
	call GetFarByte

	ld hl, PerfectAccuracyEffects
	call IsInByteArray
	jr c, .print_null_accuracy

	ld a, [wMenuSelection]
	ld bc, MOVE_LENGTH
	ld hl, (Moves + MOVE_ACC) - MOVE_LENGTH
	call AddNTimes
	ld a, BANK(Moves)
	call GetFarByte
	call ConvertPercentages
	ld [wBuffer1], a
	ld de, wBuffer1
	lb bc, 1, 3
	hlcoord 5, 11
	call PrintNum
	ld [hl], "<%>"
	jr .print_power

.print_null_accuracy
	ld de, MoveDetailsMenuNullValueString
	ld bc, 3
	hlcoord 5, 11
	call PlaceString

.print_power
	ld a, [wMenuSelection]
	ld bc, MOVE_LENGTH
	ld hl, (Moves + MOVE_POWER) - MOVE_LENGTH
	call AddNTimes
	ld a, BANK(Moves)
	call GetFarByte
	cp 2
	jr c, .print_null_power
	ld [wBuffer1], a
	ld de, wBuffer1
	lb bc, 1, 3
	hlcoord 5, 10
	jmp PrintNum

.print_null_power
	hlcoord 5, 10
	ld de, MoveDetailsMenuNullValueString
	ld bc, 3
	jmp PlaceString

MoveDetailsMenuTypeTopString:
	db "┌───────┐@"

MoveDetailsMenuTypeBottomString:
	db "│       └──────────┐@"

MoveDetailsMenuAttackString:
	db "Pow/@"

MoveDetailsMenuNullValueString:
	db "---@"

MoveDetailsMenuAccuracyString:
	db "Acc/@"

MoveDetailsMenuChanceString:
	db "Eff/@"
