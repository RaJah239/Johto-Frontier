DEF MOVE_DETAILS_PP_TILE EQU $5f

MoveDetailsMenu_SetupScreen:
	call CopyMenuHeader
	xor a
	ld [wMenuCursorPosition], a
	ld [wMenuScrollPosition], a

	; build the list frame and reserve space for the title row
	hlcoord 0, 0
	lb bc, 11, 18
	call TextboxBorder
	hlcoord 2, 0
	lb bc, 1, 16
	call ClearBox

	; load the PP glyph without disturbing the menu arrows
	ld de, FontBattleExtra + 14 tiles
	ld hl, vTiles2 tile $6e
	lb bc, BANK(FontBattleExtra), 1
	call Get2bppViaHDMA

	; needed for the level symbol on the party-mon variant
	farcall LoadStatsScreenPageTilesGFX
	ld de, StatsScreenPageTilesGFX + ($3e - $31) tiles
	ld hl, vTiles2 tile MOVE_DETAILS_PP_TILE
	lb bc, BANK(StatsScreenPageTilesGFX), 1
	jmp Get2bppViaHDMA

ChooseMoveToLearn::
	ld hl, MoveDetailsMenuPartyMonHeader
	jr MoveDetailsMenu_ChooseMove

ChooseMoveToReplace::
; Forgetting a move: the four known moves and the one being learned, all at once.
	ld hl, MoveDetailsMenuReplaceHeader
	; fallthrough

MoveDetailsMenu_ChooseMove:
	push hl
	farcall FadeOutToWhite
	farcall BlankScreen
	pop hl
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

OpenAllMovesDetailsScreen::
	ld hl, MoveDetailsMenuAllMovesHeader
	call MoveDetailsMenu_SetupScreen
	call .DrawTitle
	ld a, HP_GREEN
	ld [wPlayerHPPal], a
	jr MoveDetailsMenu_Run

.DrawTitle:
	; center the view prompt in the top border
	hlcoord 2, 0
	ld bc, 16
	ld a, "─"
	call ByteFill
	hlcoord 3, 0
	ld de, .ViewText
	jmp PlaceString

.ViewText: db "A Button: View@"

MoveDetailsMenu_Run:
	ld a, [wMenuCursorPosition]
	ld [wMenuCursorY], a
	ld [wMenuScrollPosition], a
.input_loop
	call ScrollingMenu
	ld a, [wMenuCursorY]
	ld [wMenuCursorPosition], a
	ld a, [wMenuJoypad]
	cp D_RIGHT
	jr z, .page_down
	cp D_LEFT
	jr z, .page_up
	cp B_BUTTON
	jr z, .carry
	ld a, [wMenuJoypad]
	cp A_BUTTON
	jr nz, .choose_move
	ld a, [wMenuDataFlags]
	bit SCROLLINGMENU_ENABLE_LEFT, a
	jr nz, .view_move
.choose_move
	ld a, [wMenuSelection]
	ld [wPutativeTMHMMove], a
	and a
	push af
	farcall PartyMoveIcons_Close
	pop af
	ret

.view_move
	ld a, [wMenuSelection]
	and a
	jr z, .input_loop
	ld a, [wMenuScrollPosition]
	push af
	ld a, [wMenuSelection]
	push af
	; Keep the visible Move Dex icons until the preview replaces the BG map.
	call MoveDetailsMenu_PreviewMove
	ld hl, MoveDetailsMenuAllMovesHeader
	call MoveDetailsMenu_SetupScreen
	call OpenAllMovesDetailsScreen.DrawTitle
	pop af
	ld [wMenuSelection], a
	ld b, a
	pop af
	ld [wMenuScrollPosition], a
	ld c, a
	ld a, b
	sub c ; the Move Dex list is numbered from 1
	ld [wMenuCursorPosition], a
	ld [wMenuCursorY], a
	ld a, HP_GREEN
	ld [wPlayerHPPal], a
	jr .input_loop

.carry
	scf
	push af
	farcall PartyMoveIcons_Close
	pop af
	ret

.page_down
	ld b, 1
	jr .page

.page_up
	ld b, -1
.page
	ld a, [wMenuData_ScrollingMenuHeight] ; a page is as many moves as the list shows
	ld c, a
	ld a, [wMenuScrollPosition]
	bit 7, b
	jr nz, .page_up_do
.page_down_do
	ld a, [wMenuScrollPosition]
	add a, c
	ld d, a
	ld a, [wScrollingMenuListSize]
	inc a
	ld b, a
	ld a, [wMenuData_ScrollingMenuHeight]
	ld e, a
	ld a, b
	sub e
	jr nc, .have_max_dn
	xor a
.have_max_dn
	inc a
	ld e, a
	ld a, d
	sub e
	jr nc, .wrapped_dn
	ld a, d
	jr .store_dn
.wrapped_dn
	ld a, d
	sub e
.store_dn
	ld [wMenuScrollPosition], a
	jmp .input_loop

.page_up_do
	ld a, [wMenuScrollPosition]
	sub c
	jr nc, .store_up
	ld a, [wScrollingMenuListSize]
	inc a
	ld b, a
	ld a, [wMenuData_ScrollingMenuHeight]
	ld e, a
	ld a, b
	sub e
	jr nc, .have_max_up
	xor a
.have_max_up
	inc a
	ld e, a
	ld a, [wMenuScrollPosition]
	ld b, a
	ld a, e
	sub c
	add a, b
.store_up
	ld [wMenuScrollPosition], a
	jmp .input_loop

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

MoveDetailsMenuReplaceHeader:
	db MENU_BACKUP_TILES
	menu_coords 1, 1, SCREEN_WIDTH - 2, 11 ; 5 moves, 2 rows each: nothing to scroll
	dw MoveDetailsMenuReplaceData
	db 1

MoveDetailsMenuReplaceData:
	db SCROLLINGMENU_ENABLE_FUNCTION3
	db 5, SCREEN_WIDTH + 2
	db SCROLLINGMENU_ITEMS_NORMAL
	dba wd002
	dba MoveDetailsMenu_PrintMoveName
	dba MoveDetailsMenu_PrintPP
	dba MoveDetailsMenu_PrintMoveDetails

MoveDetailsMenuAllMovesHeader:
	db MENU_BACKUP_TILES
	menu_coords 1, 1, SCREEN_WIDTH - 2, 11 ; 5 moves, 2 rows each (the box has room down to row 11)
	dw MoveDetailsMenuAllMovesData
	db 1

MoveDetailsMenuAllMovesData:
	db SCROLLINGMENU_DISPLAY_ARROWS | SCROLLINGMENU_ENABLE_LEFT | SCROLLINGMENU_ENABLE_RIGHT | SCROLLINGMENU_ENABLE_FUNCTION3
	db 5, SCREEN_WIDTH + 2
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
	ld a, MOVE_DETAILS_PP_TILE
	ld [hli], a
	ld [hl], a
	ret

DEF MOVE_DETAILS_ICON_PAL EQU 6 ; the screen only uses palette 7

MoveDetailsMenu_PrintMoveDetails:
	xor a
	ldh [hBGMapMode], a
	hlcoord 0, 12
	lb bc, 4, 18
	call TextboxBorder

	ld a, [wMenuSelection]
	cp -1
	jr nz, .move
	farcall PartyMoveIcons_Close
	farjp MoveIcons_CommitPage
.move

	push de
	ld a, [wMenuSelection]
	inc a
	pop de
	ret z
	dec a
	ld [wCurSpecies], a
	hlcoord 1, 15
	predef PrintMoveDescription

	ld a, [wCurSpecies]
	ld b, a
	ld c, MOVE_DETAILS_ICON_PAL
	lb de, 13, 10
	farcall MoveIcons_Stage

	ld d, 13
	ld e, 1
	ld c, 5 ; palette 5 is free on this screen
	farcall MoveStatBadges_Stage

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
	hlcoord 14, 14
	call PrintNum
	ld [hl], "<%>"
	jr .print_accuracy

.print_null_chance
	ld de, MoveDetailsMenuNullValueString
	ld bc, 3
	hlcoord 14, 14
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
	hlcoord 5, 14
	call PrintNum
	ld [hl], "<%>"
	jr .print_power

.print_null_accuracy
	ld de, MoveDetailsMenuNullValueString
	ld bc, 3
	hlcoord 5, 14
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
	hlcoord 5, 13
	call PrintNum
	jr .commit

.print_null_power
	hlcoord 5, 13
	ld de, MoveDetailsMenuNullValueString
	ld bc, 3
	call PlaceString
.commit
	farjp MoveIcons_CommitPage

MoveDetailsMenuNullValueString: db "---@"

MoveDetailsMenu_PreviewMove:
	farcall SaveMusic
	ld e, MUSIC_NONE
	call PlayMusic
	ld a, [wBattleMode]
	push af
	ld a, [wBattleMonSpecies]
	push af
	ld a, [wEnemyMonSpecies]
	push af
	ld a, [wTempBattleMonSpecies]
	push af
	ld a, [wTempEnemyMonSpecies]
	push af
	ldh a, [hBattleTurn]
	push af
	ld a, [wMenuSelection]
	push af

	call DisableSpriteUpdates
	xor a
	ldh [hBGMapMode], a
	call ClearSprites
	hlcoord 0, 0
	ld bc, wTilemapEnd - wTilemap
	ld a, " "
	call ByteFill
	hlcoord 0, 0, wAttrmap
	ld bc, wAttrmapEnd - wAttrmap
	ld a, 7
	call ByteFill
	xor a
	ldh [rVBK], a
	ld [wPlayerSubStatus5], a
	ld [wEnemySubStatus5], a
	ld [wBattleMonDVs], a
	ld [wBattleMonDVs + 1], a
	ld [wEnemyMonDVs], a
	ld [wEnemyMonDVs + 1], a
	call LoadStandardFont
	hlcoord 0, 12
	lb bc, 4, 18
	call Textbox
	ld a, WILD_BATTLE
	ld [wBattleMode], a
	ld a, SMEARGLE
	ld [wBattleMonSpecies], a
	ld [wEnemyMonSpecies], a
	ld [wTempBattleMonSpecies], a
	ld [wTempEnemyMonSpecies], a
	ld [wCurPartySpecies], a
	ld de, vTiles2
	predef GetMonFrontpic
	ld de, vTiles2 tile $31
	predef GetMonBackpic
	xor a
	ldh [hGraphicStartTile], a
	lb bc, 7, 7
	hlcoord 12, 0
	predef PlaceGraphic
	ld a, $31
	ldh [hGraphicStartTile], a
	lb bc, 6, 6
	hlcoord 2, 6
	predef PlaceGraphic
	ld a, [wMenuSelection]
	ld [wNamedObjectIndex], a
	call GetMoveName
	hlcoord 1, 13
	call PlaceString
	ld a, [wMenuSelection]
	ld [wCurSpecies], a
	hlcoord 1, 15
	predef PrintMoveDescription
	ldh a, [hCGB]
	and a
	jr z, .copy_preview
	ld de, wBGPals1
	farcall SetBattlePal_Player
	farcall SetBattlePal_Enemy
	farcall ApplyPals
	call SetDefaultBGPAndOBP
	hlcoord 12, 0, wAttrmap
	lb bc, 7, 7
	ld a, PAL_BATTLE_BG_ENEMY
	call FillBoxWithByte
	hlcoord 2, 6, wAttrmap
	lb bc, 6, 6
	ld a, PAL_BATTLE_BG_PLAYER
	call FillBoxWithByte
.copy_preview
	call CopyTilemapAtOnce
	ld b, SCGB_BATTLE_COLORS
	call GetSGBLayout
	call SetDefaultBGPAndOBP
	call .ClearBouncePadding
	xor a
	ldh [hBattleTurn], a
	call .PlayOneSide
	ld a, 1
	ldh [hBattleTurn], a
	call .PlayOneSide
	pop af ; selected move

	pop af
	ldh [hBattleTurn], a
	pop af
	ld [wTempEnemyMonSpecies], a
	pop af
	ld [wTempBattleMonSpecies], a
	pop af
	ld [wEnemyMonSpecies], a
	pop af
	ld [wBattleMonSpecies], a
	pop af
	ld [wBattleMode], a
	farcall RestoreMusic
	farcall BlankScreen
	; The blank map has detached the borrowed badge tiles.
	farcall MoveStatBadges_Hide
	call LoadFontsBattleExtra
	farcall LoadOW_BGPal7
	jmp FadePalettes

.PlayOneSide:
	ld a, [wMenuSelection]
	cp FLY
	jr nz, .hit
	ld a, 1
	ld [wBattleAnimParam], a
	call .Animate
.hit
	xor a
	ld [wBattleAnimParam], a
.Animate
	xor a
	ld [wNumHits], a
	ld [wBattleAnimFlags], a
	ld [wFXAnimID + 1], a
	ld a, [wMenuSelection]
	ld [wFXAnimID], a
	farcall PlayMoveDexBattleAnim
	ret

.ClearBouncePadding:
; Bounce Down scrolls the battler over the hidden rows of the BG map.
	ld d, " "
	call .FillBouncePadding
	ld a, BANK(vBGMap2)
	ldh [rVBK], a
	ld d, PAL_BATTLE_BG_PLAYER
	call .FillBouncePadding
	xor a
	ldh [rVBK], a
	ret

.FillBouncePadding:
	ldh a, [hBGMapAddress + 1]
	add HIGH(BG_MAP_WIDTH * SCREEN_HEIGHT)
	ld h, a
	ld l, LOW(BG_MAP_WIDTH * SCREEN_HEIGHT)
	ld b, BG_MAP_HEIGHT - SCREEN_HEIGHT ; Bounce Down and upward shakes use rows 18-31
.row
	ld c, SCREEN_WIDTH
.tile
	di
	ldh a, [rSTAT]
	and rSTAT_MODE_2
	jr nz, .tile
	ld a, d
	ld [hli], a
	ei
	dec c
	jr nz, .tile
	ld a, BG_MAP_WIDTH - SCREEN_WIDTH
	add l
	ld l, a
	jr nc, .next_row
	inc h
.next_row
	dec b
	jr nz, .row
	ret
