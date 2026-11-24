; StartMenu.Items indexes
	const_def
	const STARTMENUITEM_POKEDEX  ; 0
	const STARTMENUITEM_POKEMON  ; 1
	const STARTMENUITEM_PACK     ; 2
	const STARTMENUITEM_STATUS   ; 3
	const STARTMENUITEM_SAVE     ; 4
	const STARTMENUITEM_OPTION   ; 5
	const STARTMENUITEM_EXIT     ; 6
	const STARTMENUITEM_POKEGEAR ; 7
	const STARTMENUITEM_QUIT     ; 8
	const STARTMENUITEM_WARP     ; 9
	const STARTMENUITEM_GIVEUP   ; 10

StartMenu::
	newfarcall PrepareWeatherForFullScreen
	call ClearWindowData

	ld de, SFX_MENU
	call PlaySFX

	farcall ReanchorBGMap_NoOAMUpdate

	ld hl, wStatusFlags2
	bit STATUSFLAGS2_BUG_CONTEST_TIMER_F, [hl]
	ld hl, .MenuHeader
	jr z, .GotMenuData
	ld hl, .ContestMenuHeader

.GotMenuData:
	call LoadMenuHeader
	call .SetUpMenuItems
	ld a, [wBattleMenuCursorPosition]
	ld [wMenuCursorPosition], a
	call .DrawDayTimeBox

	; Load the icons and draw the time now
	call .PrepareIcons
	call .PrintDayTime

	call DrawVariableLengthMenuBox
	call .DrawBugContestStatusBox
	call SafeUpdateSprites
	call HDMATransferTilemapAndAttrmap_Menu
	farcall LoadFonts_NoOAMUpdate
	call .DrawBugContestStatus
	call UpdateTimePals
	jr .Select

.Reopen:
	call UpdateSprites
	call UpdateTimePals
	call .SetUpMenuItems
	ld a, [wBattleMenuCursorPosition]
	ld [wMenuCursorPosition], a

.Select:
	call .GetInput
	jr c, .Exit
	call .DrawDayTimeBox
	ld a, [wMenuCursorPosition]
	ld [wBattleMenuCursorPosition], a
	call PlayClickSFX
	call PlaceHollowCursor
	call .OpenMenu

; Menu items have different return functions.
; For example, saving exits the menu.
	ld hl, .MenuReturns
	ld e, a
	ld d, 0
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

.MenuReturns:
	dw .Reopen
	dw .Exit
	dw .ExitMenuCallFuncCloseText
	dw .ExitMenuRunScriptCloseText
	dw .ExitMenuRunScript
	dw .ReturnEnd
	dw .ReturnRedraw

.Exit:
	ldh a, [hOAMUpdate]
	push af
	ld a, 1
	ldh [hOAMUpdate], a
	call LoadFontsExtra
	pop af
	ldh [hOAMUpdate], a
.ReturnEnd:
	call .ExitMenuRestore
.ReturnEnd2:
	call CloseText
	jmp UpdateTimePals

.GetInput:
; Return carry on exit, and no-carry on selection.
	xor a
	ldh [hBGMapMode], a
	call .DrawDayTimeBox

	call .PrepareIcons
	; Draw the time before SetUpMenu, which commits the tilemap: otherwise the
	; box is committed once without the time and it blinks in a frame later
	call .PrintDayTime

	call SetUpMenu
	ld hl, wMenuJoypadFilter
	set SELECT_F, [hl]
	ld a, $ff
	ld [wMenuSelection], a
.loop
	call .PrintDayTime
	call GetScrollingMenuJoypad
	ld a, [wMenuJoypad]
	cp B_BUTTON
	jr z, .b
	cp A_BUTTON
	jr z, .a
	ldh a, [hJoyPressed]
	bit SELECT_F, a
	jr z, .loop
	jr .Carry

.a
	call PlayClickSFX
	and a
	ret
.b
	scf
	ret

.ExitMenuRunScript:
	call .ExitMenuRestore
	ld a, HMENURETURN_SCRIPT
	ldh [hMenuReturn], a
	ret

.ExitMenuRunScriptCloseText:
	call .ExitMenuRestore
	ld a, HMENURETURN_SCRIPT
	ldh [hMenuReturn], a
	jr .ReturnEnd2

.ExitMenuCallFuncCloseText:
	call .ExitMenuRestore
	ld hl, wQueuedScriptAddr
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wQueuedScriptBank]
	rst FarCall
	jr .ReturnEnd2

.Carry:
; Select picked up the entry under the cursor: Up/Down move it past the
; unlocked entries, A or Select drops it (and keeps the order), B puts it back
	ld a, [wMenuSelection]
	cp -1
	jr z, .GetInput
	ld [wStartMenuCarried], a
	call PlayClickSFX
.carry_redraw
	call .ShowCarried
	call .DrawCarrying
.carry_loop
	call JoyTextDelay
	call GetMenuJoypad
	bit A_BUTTON_F, a
	jr nz, .drop
	bit SELECT_F, a
	jr nz, .drop
	bit B_BUTTON_F, a
	jr nz, .cancel
	ld b, -1
	bit D_UP_F, a
	jr nz, .carry_move
	bit D_DOWN_F, a
	jr z, .carry_loop
	ld b, 1
.carry_move
	call .MoveCarried
	jr c, .carry_loop
	jr .carry_redraw

.drop
	call StartMenu_SaveOrder
	call PlayClickSFX
	jr .carry_done

.cancel
	call StartMenu_LoadOrder
.carry_done
	call .ShowCarried
	jmp .GetInput

.ShowCarried:
; put the cursor on the carried entry and rebuild the list
	ld hl, wStartMenuOrder
	ld c, 1
.find_carried
	ld a, [hl]
	push hl
	push bc
	call .GetSlotEntry
	pop bc
	pop hl
	ld b, a
	ld a, [wStartMenuCarried]
	cp b
	jr z, .found_carried
	inc hl
	ld a, b
	cp -1
	jr z, .find_carried
	inc c
	jr .find_carried

.found_carried
	ld a, c
	ld [wMenuCursorPosition], a
	jmp .BuildMenuItems

.MoveCarried:
; swap the carried entry's slot with the nearest unlocked slot in direction b
; (-1 up, 1 down); carry if there's none
	ld hl, wStartMenuOrder
	ld c, 0 ; the index of hl in the order
.find_slot
	ld a, [hl]
	push hl
	push bc
	call .GetSlotEntry
	pop bc
	pop hl
	ld d, a
	ld a, [wStartMenuCarried]
	cp d
	jr z, .found_slot
	inc hl
	inc c
	jr .find_slot

.found_slot
	ld d, h
	ld e, l
.next_slot
	ld a, c
	add b
	ld c, a
	cp NUM_START_MENU_SLOTS ; (-1 counts as too big)
	jr nc, .no_slot
	bit 7, b
	jr nz, .previous
	inc hl
	jr .check_slot
.previous
	dec hl
.check_slot
	ld a, [hl]
	push hl
	push de
	push bc
	call .GetSlotEntry
	pop bc
	pop de
	pop hl
	cp -1
	jr z, .next_slot
	ld a, [de]
	ld c, [hl]
	ld [hl], a
	ld a, c
	ld [de], a
	and a
	ret

.no_slot
	scf
	ret

.DrawCarrying:
; the menu with a hollow cursor on the carried entry and the move help
	xor a
	ldh [hBGMapMode], a
	call .DrawDayTimeBox
	call SetUpMenu
	call PlaceHollowCursor
	hlcoord 1, 15
	ld de, .CarryingDesc
	call PlaceString
	hlcoord 1, 16
	ld de, .CarryingOK
	call PlaceString
	jmp ApplyTilemap

.CarryingDesc: db   "▲▼: Move@"
.CarryingOK: db   "A: OK@"

.ReturnRedraw:
	call .RestoreIconPalettes
	farcall ClearSavedObjPals
	farcall DisableDynPalUpdates
	call ClearBGPalettes
	call Call_ExitMenu
	call ReloadTilesetAndPalettes
	call .DrawDayTimeBox
	call DrawVariableLengthMenuBox
	call .DrawBugContestStatus
	call UpdateSprites
	call FinishExitMenu
	jmp .Reopen

.MenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 10, 0, SCREEN_WIDTH - 1, SCREEN_HEIGHT - 1
	dw .MenuData
	db 1 ; default selection

.ContestMenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 10, 2, SCREEN_WIDTH - 1, SCREEN_HEIGHT - 1
	dw .MenuData
	db 1 ; default selection

.MenuData:
	db STATICMENU_CURSOR | STATICMENU_WRAP | STATICMENU_ENABLE_START ; flags
	dn 0, 0 ; rows, columns
	dw wMenuItemsList
	dw .MenuString
	dw .Items

.Items:
; entries correspond to STARTMENUITEM_* constants
	dw StartMenu_Pokedex,  .PokedexString
	dw StartMenu_Pokemon,  .PartyString
	dw StartMenu_Pack,     .PackString
	dw StartMenu_Status,   .StatusString
	dw StartMenu_Save,     .SaveString
	dw StartMenu_Option,   .OptionString
	dw StartMenu_Exit,     .ExitString
	dw StartMenu_Pokegear, .PokegearString
	dw StartMenu_Quit,     .QuitString
	dw StartMenu_Warp,     .WarpString
	dw StartMenu_GiveUp,   .GiveUpString

.PokedexString:  db "#dex@"
.PartyString:    db "#mon@"
.PackString:     db "Bag@"
.StatusString:   db "<PLAYER>@"
.SaveString:     db "Save@"
.OptionString:   db "Options@"
.ExitString:     db "Exit@"
.PokegearString: db "<POKE>Gear@"
.QuitString:     db "Quit@"
.WarpString:     db "Warp@"
.GiveUpString:   db "Give Up@"

.OpenMenu:
	ld a, [wMenuSelection]
	call .GetMenuItemEntry
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

.MenuString:
	push de
	ld a, [wMenuSelection]
	call .GetMenuItemEntry
	inc hl
	inc hl
	ld a, [hli]
	ld d, [hl]
	ld e, a
	pop hl
	jmp PlaceString

.GetMenuItemEntry:
	ld e, a
	ld d, 0
	ld hl, wMenuDataPointerTableAddr
	ld a, [hli]
	ld h, [hl]
	ld l, a
rept 4 ; two pointers per menu item
	add hl, de
endr
	ret

.SetUpMenuItems:
	call StartMenu_LoadOrder
.BuildMenuItems:
; the entries of wStartMenuOrder's unlocked slots, in that order
	xor a
	ld [wWhichIndexSet], a
	call .FillMenuList
	ld hl, wStartMenuOrder
.build_loop
	ld a, [hl]
	push hl
	push de
	push bc
	call .GetSlotEntry
	pop bc
	pop de
	cp -1
	call nz, .AppendMenuList
	pop hl
	inc hl
	ld a, l
	sub LOW(wStartMenuOrder + NUM_START_MENU_SLOTS)
	jr nz, .build_loop
	ld a, c
	ld [wMenuItemsList], a
	ret

.GetSlotEntry:
; a = the STARTMENUITEM_* that slot a shows, or -1 while it's locked
	ld e, a
	ld d, 0
	ld hl, .SlotEntries
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

.SlotEntries:
; entries correspond to SMSLOT_* constants
	dw .SlotPokedex
	dw .SlotPokemon
	dw .SlotPack
	dw .SlotPokegear
	dw .SlotStatus
	dw .SlotSave
	dw .SlotOption
	dw .SlotExit
	assert @ - .SlotEntries == NUM_START_MENU_SLOTS * 2

.SlotPokedex:
	ld a, [wStatusFlags]
	bit STATUSFLAGS_POKEDEX_F, a
	jr z, .locked
	ld a, STARTMENUITEM_POKEDEX
	ret

.SlotPokemon:
	ld a, [wPartyCount]
	and a
	jr z, .locked
	ld a, STARTMENUITEM_POKEMON
	ret

.SlotPack:
	ld a, [wLinkMode]
	and a
	jr nz, .locked
	ld a, [wStatusFlags2]
	bit STATUSFLAGS2_BUG_CONTEST_TIMER_F, a
	jr nz, .locked
	ld a, STARTMENUITEM_PACK
	ret

.SlotPokegear:
	ld a, [wPokegearFlags]
	bit POKEGEAR_OBTAINED_F, a
	jr z, .locked
	ld a, STARTMENUITEM_POKEGEAR
	ret

.SlotStatus:
	ld a, STARTMENUITEM_STATUS
	ret

.SlotSave:
	ld a, [wLinkMode]
	and a
	jr nz, .locked
	ld a, [wStatusFlags2]
	bit STATUSFLAGS2_BUG_CONTEST_TIMER_F, a
	ld a, STARTMENUITEM_QUIT
	ret nz
	ld a, STARTMENUITEM_SAVE
	ret

.SlotOption:
	ld a, STARTMENUITEM_OPTION
	ret

.SlotExit:
	; The Grand Gauntlet battle rooms have no warps of their own, so in
	; there Exit/Warp is swapped for Give Up: abandon the run and warp
	; back to the lobby stairs.
	; All 50 battle rooms share the same group, consecutive map numbers.
	ld a, [wMapGroup]
	cp GROUP_BATTLE_PLAZA_GRAND_GAUNTLET_BATTLE_ROOM_1
	jr nz, .not_gauntlet_battle_room
	ld a, [wMapNumber]
	cp MAP_BATTLE_PLAZA_GRAND_GAUNTLET_BATTLE_ROOM_1
	jr c, .not_gauntlet_battle_room
	cp MAP_BATTLE_PLAZA_GRAND_GAUNTLET_BATTLE_ROOM_50 + 1
	jr nc, .not_gauntlet_battle_room
	ld a, STARTMENUITEM_GIVEUP
	ret

.not_gauntlet_battle_room
	; Bug Catching contest must always have the Exit Option
	ld a, [wStatusFlags2]
	bit STATUSFLAGS2_BUG_CONTEST_TIMER_F, a
	jr nz, .exit
	ld a, [wLinkMode]
	and a
	jr nz, .exit
	; check if end game fast travel has been obtained
	ld a, [wPokegearFlags]
	bit ENGINE_START_MENU_WARP_F, a
	jr z, .exit
	ld a, STARTMENUITEM_WARP
	ret

.exit
	ld a, STARTMENUITEM_EXIT
	ret

.locked
	ld a, -1
	ret

.FillMenuList:
	xor a
	ld hl, wMenuItemsList
	ld [hli], a
	ld a, -1
	ld bc, wMenuItemsListEnd - (wMenuItemsList + 1)
	call ByteFill
	ld de, wMenuItemsList + 1
	ld c, 0
	ret

.AppendMenuList:
	ld [de], a
	inc de
	inc c
	ret

.DrawDayTimeBox:
	; place white box
	hlcoord 0, 14
	lb bc, 4, 10
	call ClearBox

	; text box: the day and weather on top, the time below
	hlcoord 0, 14
	lb bc, 2, 8
	call Textbox

	ld de, ENGINE_BUG_CONTEST_TIMER
	ld b, CHECK_FLAG
	farcall EngineFlagAction
	ret nz

	ld a, [wOptions2]
	bit HARD_MODE, a
	ret z

	; place white box
	hlcoord 0, 0
	lb bc, 3, 10
	call ClearBox

	; hard mode's text box
	hlcoord 0, 0
	lb bc, 1, 9
	jmp Textbox

.PrintDayTime:
	call .DrawDayTimeBox
	ldh a, [hHours]
	ld b, a
	ldh a, [hMinutes]
	ld c, a
	decoord 1, 16
	farcall PrintHoursMins
	hlcoord 7, 16
	ld a, [hli]
	ld b, [hl]
	hlcoord 6, 16
	ld [hli], a
	ld [hl], b
	hlcoord 8, 16
	ld [hl], " "
	call .PlaceIcons
.done:
	ld a, [wOptions2]
	bit HARD_MODE, a
	ret z

	ld de, ENGINE_BUG_CONTEST_TIMER
	ld b, CHECK_FLAG
	farcall EngineFlagAction
	ret nz

	hlcoord 1, 1
	ld de, .HardModeString
	jmp PlaceString

.HardModeString:
	db "Hard Mode@"

; Day and weather icons: 24x8 badges (3 tiles), the day on the left
; weather on the right of the box's first line (the box is 8 tiles wide inside)
; They use the free tiles $79-$7e, like the move icons, and two BG
; palettes that no cell on screen uses (the same borrowing the Battle Plaza
; menus do; the palettes come back with UpdateTimePals when the menu closes).
DEF START_MENU_ICON_TILE EQU $79
DEF START_MENU_ICON_WIDTH EQU 3

.PlaceIcons:
	hlcoord 1, 15
	ld a, START_MENU_ICON_TILE
	ld [hli], a
	inc a
	ld [hli], a
	inc a
	ld [hl], a
	hlcoord 6, 15
	ld a, START_MENU_ICON_TILE + START_MENU_ICON_WIDTH
	ld [hli], a
	inc a
	ld [hli], a
	inc a
	ld [hl], a
	ret

.PrepareIcons:
; Load the badges for today's day and weather. They are drawn in the text
; palette, whose two spare colors are set to the day's and the weather's color,
; so no map palette is touched. The text palette is given back on exit.
	call .RestoreIconPalettes
	call .SaveTextPalette
	call .WeatherBadgeIndex
	push af
	ld de, WeatherBadgeGFX
	ld hl, vTiles2 tile (START_MENU_ICON_TILE + START_MENU_ICON_WIDTH)
	call .LoadBadgeTiles
	call GetWeekday
	push af
	ld de, DayBadgeGFX
	ld hl, vTiles2 tile START_MENU_ICON_TILE
	call .LoadBadgeTiles
	pop af
	ld hl, DayColors
	ld de, wBGPals1 palette PAL_BG_TEXT color 1
	call .SetColor
	pop af
	ld hl, WeatherColors
	ld de, wBGPals1 palette PAL_BG_TEXT color 2
	call .SetColor
	call .PlaceIcons
	ld a, TRUE
	ldh [hCGBPalUpdate], a
	ret

.SetColor:
; Write color a of the table at hl to de in wBGPals1 and wBGPals2.
	ld c, a
	ld b, 0
	add hl, bc
	add hl, bc
	ldh a, [rSVBK]
	push af
	ld a, BANK(wBGPals1)
	ldh [rSVBK], a
	ld a, [hli]
	ld c, a
	ld b, [hl]
	ld a, c
	ld [de], a
	inc de
	ld a, b
	ld [de], a
	dec de
	ld hl, wBGPals2 - wBGPals1
	add hl, de
	ld a, c
	ld [hli], a
	ld [hl], b
	pop af
	ldh [rSVBK], a
	ret

.ExitMenuRestore:
	call .RestoreIconPalettes
	jmp ExitMenu

.SaveTextPalette:
; Remember the text palette's own colors (the icons change two of them).
	ldh a, [rSVBK]
	push af
	ld a, BANK(wBGPals1)
	ldh [rSVBK], a
	ld a, TRUE
	ld [wStartMenuTextPaletteSaved], a
	ld hl, wBGPals1 palette PAL_BG_TEXT
	ld de, wStartMenuSavedTextPalette
	ld bc, 1 palettes
	call CopyBytes
	pop af
	ldh [rSVBK], a
	ret

.RestoreIconPalettes:
; Give the text palette its colors back.
	ldh a, [rSVBK]
	push af
	ld a, BANK(wBGPals1)
	ldh [rSVBK], a
	ld a, [wStartMenuTextPaletteSaved]
	and a
	jr z, .nothing_saved
	xor a
	ld [wStartMenuTextPaletteSaved], a
	ld hl, wStartMenuSavedTextPalette
	ld de, wBGPals1 palette PAL_BG_TEXT
	ld bc, 1 palettes
	call CopyBytes
	ld hl, wStartMenuSavedTextPalette
	ld de, wBGPals2 palette PAL_BG_TEXT
	ld bc, 1 palettes
	call CopyBytes
	ld a, TRUE
	ldh [hCGBPalUpdate], a
.nothing_saved
	pop af
	ldh [rSVBK], a
	ret

.WeatherBadgeIndex:
; a = 0 rain, 1 sun, 2 sandstorm, 3 hail, 4 clear
	ld a, [wFieldWeather]
	ld c, 0
	cp WEATHER_RAIN
	jr z, .got_weather
	inc c
	cp WEATHER_SUN
	jr z, .got_weather
	inc c
	cp WEATHER_SANDSTORM
	jr z, .got_weather
	inc c
	cp WEATHER_HAIL
	jr z, .got_weather
	inc c
.got_weather
	ld a, c
	ret

.LoadBadgeTiles:
; Copy 3 tiles of badge a from the table at de to VRAM at hl.
	push hl
	ld l, a
	ld h, 0
	ld b, h
	ld c, l
	add hl, hl
	add hl, bc
rept 4
	add hl, hl
endr
	add hl, de
	ld d, h
	ld e, l
	pop hl
	lb bc, BANK(DayBadgeGFX), START_MENU_ICON_WIDTH
	jmp Get2bppViaHDMA

.DrawBugContestStatusBox:
	ld hl, wStatusFlags2
	bit STATUSFLAGS2_BUG_CONTEST_TIMER_F, [hl]
	ret z
	farjp StartMenu_DrawBugContestStatusBox

.DrawBugContestStatus:
	ld hl, wStatusFlags2
	bit STATUSFLAGS2_BUG_CONTEST_TIMER_F, [hl]
	ret z
.contest
	farjp StartMenu_PrintBugContestStatus

StartMenu_Warp:
	call Fast_Travel_Warp
	; fallthrough

StartMenu_Exit:
; Exit the menu.
	ld a, 1
	ret

StartMenu_Quit:
; Retire from the bug catching contest.

	ld hl, .StartMenuContestEndText
	call StartMenuYesNo
	jr c, .DontEndContest
	ld a, BANK(BugCatchingContestReturnToGateScript)
	ld hl, BugCatchingContestReturnToGateScript
	call FarQueueScript
	ld a, 4
	ret

.DontEndContest:
	ld a, 0
	ret

.StartMenuContestEndText:
	text_far _StartMenuContestEndText
	text_end

StartMenu_GiveUp:
; abandon a grand gauntlet run from the battle room replaces the party
; with a single level-50 Ditto and warps back to the lobby stairs
	ld hl, .GiveUpConfirmText1
	call StartMenuNoYes
	jr c, .DontGiveUp
	ld hl, .GiveUpConfirmText2
	call StartMenuNoYes
	jr c, .DontGiveUp
	ld hl, .GiveUpConfirmText3
	call StartMenuNoYes
	jr c, .DontGiveUp
	ld a, BANK(GrandGauntletGiveUpScript)
	ld hl, GrandGauntletGiveUpScript
	call FarQueueScript
	ld a, 4 ; .ExitMenuRunScript
	ret

.DontGiveUp:
	ld a, 0 ; .Reopen
	ret

.GiveUpConfirmText1:
	text_far _GrandGauntletGiveUpConfirmText1
	text_end

.GiveUpConfirmText2:
	text_far _AreYouReallyReallySureText
	text_end

.GiveUpConfirmText3:
	text_far _GrandGauntletGiveUpConfirmText3
	text_end

StartMenu_Save:
; Save the game.

	call BufferScreen
	farcall SaveMenu
	jr nc, .saved
	ld a, 0
	ret

.saved
	ld a, 1
	ret

StartMenu_Option:
; Game options.

	call FadeToMenu
	farcall Option
	ld a, 6
	ret

StartMenu_Status:
; Player status.

	call FadeToMenu
	farcall TrainerCard
	call CloseSubmenu
	ld a, 0
	ret

StartMenu_Pokedex:
	ld a, [wPartyCount]
	and a
	jr z, .empty

	call FadeToMenu
	farcall Pokedex
	call CloseSubmenu

.empty
	ld a, 0
	ret

StartMenu_Pokegear:
	call FadeToMenu
	farcall PokeGear
	call CloseSubmenu
	ld a, 0
	ret

StartMenu_Pack:
	call FadeToMenu
	farcall Pack
	ld a, [wPackUsedItem]
	and a
	jr nz, .used_item
	call CloseSubmenu
	ld a, 0
	ret

.used_item
	call ExitAllMenus
	ld a, 4
	ret

StartMenu_Pokemon:
	ld a, [wPartyCount]
	and a
	jr z, .return

	call FadeToMenu

.choosemenu
	xor a
	ld [wPartyMenuActionText], a ; Choose a POKéMON.
	call ClearBGPalettes

.menu
	farcall LoadPartyMenuGFX
	farcall InitPartyMenuWithCancel
	farcall InitPartyMenuGFX

.menunoreload
	farcall WritePartyMenuTilemap
	farcall PlacePartyMenuText
	call WaitBGMap
	call SetDefaultBGPAndOBP
	call DelayFrame
	farcall PartyMenuSelect
	jr c, .return ; if cancelled or pressed B

	call PokemonActionSubmenu
	cp 3
	jr z, .menu
	and a
	jr z, .choosemenu
	cp 1
	jr z, .menunoreload
	cp 2
	jr z, .quit

.return
	call CloseSubmenu
	ld a, 0
	ret

.quit
	ld a, b
	push af
	call ExitAllMenus
	pop af
	ret

; map_constants.asm
Fast_Travel_Warp_Locations:
	table_width 2
	map_id BATTLE_PLAZA
	map_id NEW_BARK_TOWN
	map_id CHERRYGROVE_CITY
	map_id VIOLET_CITY
	map_id RUINS_OF_ALPH_OUTSIDE
	map_id ROUTE_4
	map_id AZALEA_TOWN
	map_id GOLDENROD_CITY
	map_id NATIONAL_PARK
	map_id ECRUTEAK_CITY
	map_id SILVER_CAVE_OUTSIDE
	map_id OLIVINE_CITY
	map_id POWER_PLANT_OUTSIDE
	map_id CIANWOOD_CITY
	map_id MT_MORTAR_SQUARE
	map_id MAHOGANY_TOWN
	map_id LAKE_OF_RAGE
	map_id BLACKTHORN_CITY
	map_id ROUTE_20
	map_id ROUTE_21
DEF NUM_FAST_TRAVEL_WARP_MAPS EQU (@ - {CURRENT_TABLE_START}) / CURRENT_TABLE_WIDTH

; map_names.asm
Fast_Travel_Warp_Strings:
	table_width 3
	dba Battle_Plaza_Name1
	dba New_Bark_Map_Name4
	dba Cherrygrove_Map_Name3
	dba Violet_Map_Name5
	dba Dungeons_Map_Name22
	dba Violet_Map_Name1
	dba Azalea_Map_Name7
	dba Goldenrod_Map_Name2
	dba Dungeons_Map_Name15
	dba Ecruteak_Map_Name9
	dba Silver_Map_Name1
	dba Olivine_Map_Name13
	dba Cianwood_Map_Name12
	dba Cianwood_Map_Name3
	dba Fast_Ship_Map_Name3
	dba Mahogany_Map_Name7
	dba Lake_of_Rage_Map_Name6
	dba Blackthorn_Map_Name10
	dba New_Bark_Map_Name1
	dba Indigo_Map_Name2
	assert_table_length NUM_FAST_TRAVEL_WARP_MAPS

Fast_Travel_Warp:
	xor a
	ld [wMenuScrollPosition], a
	ld a, $1
	ld [wMenuSelection], a
	call SetUpTextbox
.loop
	ld hl, wOptions
	set NO_TEXT_SCROLL, [hl]
	push hl
	ld hl, .WhereToText
	call PrintText
	pop hl
	res NO_TEXT_SCROLL, [hl]
	call UpdateSprites
	call Fast_Travel_LocationMenu
	ret z
	
	ld hl, Fast_Travel_Warp_Locations
	ld bc, 2
	dec a
	call AddNTimes
	push hl
	pop hl

	; Default warp number 
	; change if your maps use 0-based or a different default
	ld a, 1
	ld [wNextWarp], a
	ld a, [hli]
	ld [wNextMapGroup], a
	ld a, [hli]
	ld [wNextMapNumber], a
	ld a, MAPSETUP_DOOR
	ldh [hMapEntryMethod], a
	ld a, MAPSTATUS_ENTER
	call LoadMapStatus

	; play warping sound effect
    call WaitSFX
    ld de, SFX_WARP_TO
    jmp PlaySFX

.WhereToText
	text "Where would you"
	line "like to be warped?"
	done

Fast_Travel_LocationMenu:
	ld hl, .MenuHeader
	call CopyMenuHeader
	ld a, [wMenuSelection]
	ld [wMenuCursorPosition], a
	xor a
	ld [wWhichIndexSet], a
	ldh [hBGMapMode], a
	call InitScrollingMenu
	call UpdateSprites
.input_loop
	call ScrollingMenu
	ld a, [wMenuJoypad]
	cp B_BUTTON
	jr z, .cancel
	cp A_BUTTON
	jr nz, .input_loop ; D_LEFT/D_RIGHT handed back by the menu: keep browsing
	ld a, [wMenuSelection]
	cp -1
	ret nz

.cancel
	xor a
	ret

.done
	ret

.MenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 1, 1, 18, 10
	dw .MenuData
	db 1 ; default option

	db 0

.MenuData:
	; ENABLE_LEFT | ENABLE_RIGHT are the pair ScrollingMenu_CanWrap
	; requires for the list to loop (plus ENABLE_FUNCTION3, whose bit
	; doubles as STATICMENU_WRAP). They also hand D_LEFT/D_RIGHT back to
	; the caller, which the input loop above ignores.
	db SCROLLINGMENU_DISPLAY_ARROWS | SCROLLINGMENU_ENABLE_LEFT | SCROLLINGMENU_ENABLE_RIGHT | SCROLLINGMENU_ENABLE_FUNCTION3 ; flags
	; if "columns" is > 0, a second menu function is expected,
	; and the game will crash if it does not exist!
	db 5, 0 ; rows, columns
	db SCROLLINGMENU_ITEMS_NORMAL ; item format
	dba .Maps
	dba .PrintMapNames
	dba NULL
	dba .NoOp ; function 3 runs on every redraw; keep it harmless

.Maps:
	db NUM_FAST_TRAVEL_WARP_MAPS
for x, NUM_FAST_TRAVEL_WARP_MAPS
	db x + 1
endr
	db -1

.PrintMapNames:
	push de
	ld a, [wMenuSelection]
	call Fast_Travel_GetName
	pop hl
	call FarPlaceString
.NoOp:
	ret

Fast_Travel_GetName:
	ld hl, Fast_Travel_Warp_Strings
	ld bc, 3
	dec a
	call AddNTimes
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld e, a
	ld d, [hl]
	ret

DayBadgeGFX:
INCBIN "gfx/start_menu/day_badges.2bpp"

WeatherBadgeGFX:
INCBIN "gfx/start_menu/weather_badges.2bpp"

DayColors:
	RGB 28, 06, 06 ; Sunday
	RGB 29, 15, 03 ; Monday
	RGB 23, 19, 00 ; Tuesday
	RGB 06, 21, 09 ; Wednesday
	RGB 08, 14, 28 ; Thursday
	RGB 18, 09, 26 ; Friday
	RGB 28, 10, 20 ; Saturday

WeatherColors:
; the dominant colour of each battle weather icon (gfx/battle/weather)
	RGB 03, 05, 21 ; rain      (battle dark blue)
	RGB 31, 16, 01 ; sun       (battle orange)
	RGB 20, 15, 03 ; sandstorm (battle brown)
	RGB 01, 04, 31 ; hail      (battle blue)
	RGB 08, 12, 31 ; clear     (battle sky blue)

StartMenu_LoadOrder:
; wStartMenuOrder = the saved slot order, or the default one if it isn't valid
	ldh a, [rSVBK]
	push af
	ld hl, wStartMenuOrderSaved
	ld de, wStartMenuOrder
	ld c, 0
.loop
	ld a, BANK(wStartMenuOrderSaved)
	ldh [rSVBK], a
	ld a, [hli]
	ld b, a
	ld a, BANK(wStartMenuOrder)
	ldh [rSVBK], a
	ld a, b
	call .Unpack
	jr z, .unpacked
	ld a, b
	swap a
	call .Unpack
	jr nz, .loop
.unpacked
	pop af
	ldh [rSVBK], a
; each slot must be there once
	ld b, 0
.check
	ld hl, wStartMenuOrder
	ld c, NUM_START_MENU_SLOTS
.search
	ld a, [hli]
	cp b
	jr z, .next
	dec c
	jr nz, .search
	ld hl, wStartMenuOrder
	xor a
.default
	ld [hli], a
	inc a
	cp NUM_START_MENU_SLOTS
	jr nz, .default
	ret

.next
	inc b
	ld a, b
	cp NUM_START_MENU_SLOTS
	jr nz, .check
	ret

.Unpack:
; [de++] = (a & $f) xor c, c++; z after the last slot
	and $f
	xor c
	ld [de], a
	inc de
	inc c
	ld a, c
	cp NUM_START_MENU_SLOTS
	ret

StartMenu_SaveOrder:
; wStartMenuOrderSaved = wStartMenuOrder, two slots per byte
	ldh a, [rSVBK]
	push af
	ld hl, wStartMenuOrder
	ld de, wStartMenuOrderSaved
	ld c, 0
.loop
	ld a, BANK(wStartMenuOrder)
	ldh [rSVBK], a
	ld a, [hli]
	xor c
	and $f
	ld b, a
	inc c
	ld a, [hli]
	xor c
	swap a
	and $f0
	or b
	ld b, a
	inc c
	ld a, BANK(wStartMenuOrderSaved)
	ldh [rSVBK], a
	ld a, b
	ld [de], a
	inc de
	ld a, c
	cp NUM_START_MENU_SLOTS
	jr c, .loop
	pop af
	ldh [rSVBK], a
	ret
