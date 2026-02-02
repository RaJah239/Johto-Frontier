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

StartMenu::
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
	and a
	call z, AEqualsTwo
	ld [wMenuCursorPosition], a
	call .DrawDayTimeBox
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
	call ExitMenu
.ReturnEnd2:
	call CloseText
	call UpdateTimePals
	ret

.GetInput:
; Return carry on exit, and no-carry on selection.
	xor a
	ldh [hBGMapMode], a
	call .DrawDayTimeBox
	call SetUpMenu
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
	jr .loop
.a
	call PlayClickSFX
	and a
	ret
.b
	scf
	ret

.ExitMenuRunScript:
	call ExitMenu
	ld a, HMENURETURN_SCRIPT
	ldh [hMenuReturn], a
	ret

.ExitMenuRunScriptCloseText:
	call ExitMenu
	ld a, HMENURETURN_SCRIPT
	ldh [hMenuReturn], a
	jr .ReturnEnd2

.ExitMenuCallFuncCloseText:
	call ExitMenu
	ld hl, wQueuedScriptAddr
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wQueuedScriptBank]
	rst FarCall
	jr .ReturnEnd2

.ReturnRedraw:
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
	dw StartMenu_Pokedex,  .PokedexString,  .EmptyDesc
	dw StartMenu_Pokemon,  .PartyString,    .EmptyDesc
	dw StartMenu_Pack,     .PackString,     .EmptyDesc
	dw StartMenu_Status,   .StatusString,   .EmptyDesc
	dw StartMenu_Save,     .SaveString,     .EmptyDesc
	dw StartMenu_Option,   .OptionString,   .EmptyDesc
	dw StartMenu_Exit,     .ExitString,     .EmptyDesc
	dw StartMenu_Pokegear, .PokegearString, .EmptyDesc
	dw StartMenu_Quit,     .QuitString,     .EmptyDesc
	dw StartMenu_Warp,     .WarpString,     .EmptyDesc

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

.EmptyDesc:
	db   "@"

.OpenMenu:
	ld a, [wMenuSelection]
	call .GetMenuEmptyTextPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

.MenuString:
	push de
	ld a, [wMenuSelection]
	call .GetMenuEmptyTextPointer
	inc hl
	inc hl
	ld a, [hli]
	ld d, [hl]
	ld e, a
	pop hl
	call PlaceString
	ret

.MenuDesc:
	push de
	ld a, [wMenuSelection]
	cp $ff
	jr z, .none
	call .GetMenuEmptyTextPointer
rept 4
	inc hl
endr
	ld a, [hli]
	ld d, [hl]
	ld e, a
	pop hl
	call PlaceString
	ret
.none
	pop de
	ret

.GetMenuEmptyTextPointer:
	ld e, a
	ld d, 0
	ld hl, wMenuDataPointerTableAddr
	ld a, [hli]
	ld h, [hl]
	ld l, a
rept 6
	add hl, de
endr
	ret

.SetUpMenuItems:
	xor a
	ld [wWhichIndexSet], a
	call .FillMenuList

	ld hl, wStatusFlags
	bit STATUSFLAGS_POKEDEX_F, [hl]
	jr z, .no_pokedex
	ld a, STARTMENUITEM_POKEDEX
	call .AppendMenuList
.no_pokedex

	ld a, [wPartyCount]
	and a
	jr z, .no_pokemon
	ld a, STARTMENUITEM_POKEMON
	call .AppendMenuList
.no_pokemon

	ld a, [wLinkMode]
	and a
	jr nz, .no_pack
	ld hl, wStatusFlags2
	bit STATUSFLAGS2_BUG_CONTEST_TIMER_F, [hl]
	jr nz, .no_pack
	ld a, STARTMENUITEM_PACK
	call .AppendMenuList
.no_pack

	ld hl, wPokegearFlags
	bit POKEGEAR_OBTAINED_F, [hl]
	jr z, .no_pokegear
	ld a, STARTMENUITEM_POKEGEAR
	call .AppendMenuList
.no_pokegear

	ld a, STARTMENUITEM_STATUS
	call .AppendMenuList

	ld a, [wLinkMode]
	and a
	jr nz, .no_save
	ld hl, wStatusFlags2
	bit STATUSFLAGS2_BUG_CONTEST_TIMER_F, [hl]
	ld a, STARTMENUITEM_QUIT
	jr nz, .write
	ld a, STARTMENUITEM_SAVE
.write
	call .AppendMenuList
.no_save

	ld a, STARTMENUITEM_OPTION
	call .AppendMenuList

	; Bug Catching contest must always have the Exit Option
	ld hl, wStatusFlags2
	bit STATUSFLAGS2_BUG_CONTEST_TIMER_F, [hl]
	jr nz, .bug_contest_or_fast_travel_not_obtained

	ld a, [wLinkMode]
	and a
	jr nz, .bug_contest_or_fast_travel_not_obtained

	ld a, [wLinkMode]
	and a
	jr nz, .bug_contest_or_fast_travel_not_obtained

	; check if end game fast travel has been obtained
	ld hl, wPokegearFlags
	bit ENGINE_START_MENU_WARP_F, [hl]
	jr z, .bug_contest_or_fast_travel_not_obtained
	ld a, STARTMENUITEM_WARP
	call .AppendMenuList
	jr .next

.bug_contest_or_fast_travel_not_obtained
	ld a, STARTMENUITEM_EXIT
	call .AppendMenuList
.next
	ld a, c
	ld [wMenuItemsList], a
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
	hlcoord 0, 13
	lb bc, 5, 11
	call ClearBox

	; text box
	hlcoord 0, 13
	lb bc, 3, 9
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
	bccoord 1, 15
	call TextCommand_DAY
	ld a, [hHours]
	ld b, a
	ld a, [hMinutes]
	ld c, a
	decoord 1, 14
	farcall PrintHoursMins

	ld a, [wFieldWeather]
	cp WEATHER_RAIN
	jr z, .PrintRaining

	cp WEATHER_SUN
	jr z, .PrintSunny

	cp WEATHER_SANDSTORM
	jr z, .PrintSandstorm

	cp WEATHER_HAIL
	jr z, .PrintHailing
	jr .PrintClearSkies

.PrintRaining:
	hlcoord 1, 16
	ld de, .RainingStr
	call PlaceString
	jr .done

.PrintSunny:
	hlcoord 1, 16
	ld de, .SunnyStr
	call PlaceString
	jr .done

.PrintSandstorm:
	hlcoord 1, 16
	ld de, .SandstormStr
	call PlaceString
	jr .done

.PrintHailing:
	hlcoord 1, 16
	ld de, .HailingStr
	call PlaceString
	jr .done

.PrintClearSkies:
	hlcoord 1, 16
	ld de, .ClearStr
	call PlaceString
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

.RainingStr:
 	db "Raining@"
.SunnyStr:
 	db "Sunny@"
.HailingStr:
 	db "Hailing@"
.SandstormStr:
 	db "Sandstorm@"
.ClearStr:
	db "Clear@"
.HardModeString:
	db "Hard Mode@"

.DrawBugContestStatusBox:
	ld hl, wStatusFlags2
	bit STATUSFLAGS2_BUG_CONTEST_TIMER_F, [hl]
	ret z
	farcall StartMenu_DrawBugContestStatusBox
	ret

.DrawBugContestStatus:
	ld hl, wStatusFlags2
	bit STATUSFLAGS2_BUG_CONTEST_TIMER_F, [hl]
	jr nz, .contest
	ret
.contest
	farcall StartMenu_PrintBugContestStatus
	ret

AEqualsTwo:
	ld a, 2
	ret

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
	map_id ROUTE_32
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
	map_id ROUTE_26
	map_id ROUTE_23
DEF NUM_FAST_TRAVEL_WARP_MAPS EQU (@ - {CURRENT_TABLE_START}) / CURRENT_TABLE_WIDTH

; map_names.asm
Fast_Travel_Warp_Strings:
	table_width 3
	dba Cianwood_Map_Name20
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
	dba Olivine_Map_Name14
	dba Cianwood_Map_Name16
	dba Cianwood_Map_Name3
	dba Fast_Ship_Map_Name10
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
	ld hl, .WhereToText
	call PrintText
	call DelayFrame
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
    call PlaySFX
	ret

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
	call ScrollingMenu
	ld a, [wMenuJoypad]
	cp B_BUTTON
	jr z, .cancel
	ld a, [wMenuSelection]
	cp -1
	jr nz, .done

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
	db SCROLLINGMENU_DISPLAY_ARROWS ; flags
	; if "columns" is > 0, a second menu function is expected,
	; and the game will crash if it does not exist!
	db 5, 0 ; rows, columns
	db SCROLLINGMENU_ITEMS_NORMAL ; item format
	dba .Maps
	dba .PrintMapNames
	dba NULL
	dba NULL

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
