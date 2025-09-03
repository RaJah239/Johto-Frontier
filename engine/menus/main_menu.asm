	; MainMenuItems indexes
	const_def
	const MAINMENU_NEW_GAME               ; 0
	const MAINMENU_CONTINUE               ; 1

	; MainMenu.Strings and MainMenu.Jumptable indexes
	const_def
	const MAINMENUITEM_CONTINUE			; 0
	const MAINMENUITEM_NEW_GAME			; 1
	const MAINMENUITEM_OPTION			; 2
	const MAINMENUITEM_SET_TIME			; 3
	const MAINMENUITEM_ABOUT			; 4
	const MAINMENUITEM_DEBUG_ROOM		; 5

MainMenu:
	farcall DeleteSavedMusic
.loop
	xor a
	ld [wDisableTextAcceleration], a
	call ClearTilemapEtc
	ld b, SCGB_DIPLOMA
	call GetSGBLayout
	call SetDefaultBGPAndOBP
	ld hl, wGameTimerPaused
	res GAME_TIMER_COUNTING_F, [hl]
	call MainMenu_GetWhichMenu
	ld [wWhichIndexSet], a
	call MainMenu_PrintCurrentVersion
	call MainMenu_PrintCurrentTimeAndDay
	ld hl, .MenuHeader
	call LoadMenuHeader
	call MainMenuJoypadLoop
	call CloseWindow
	ret c
	call ClearTilemap
	ld a, [wMenuSelection]
	ld hl, .Jumptable
	rst JumpTable
	jr .loop

.MenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 0, 0, 13, 7
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR ; flags
	db 0 ; items
	dw MainMenuItems
	dw PlaceMenuStrings
	dw .Strings

.Strings:
; entries correspond to MAINMENUITEM_* constants
	db "Continue@"
	db "New Game@"
	db "Options@"
	db "Set Time@"
	db "About@"
if DEF(_DEBUG)
	db "Debug Room@"
endc

.Jumptable:
; entries correspond to MAINMENUITEM_* constants
	dw MainMenu_Continue
	dw MainMenu_NewGame
	dw MainMenu_Option
	dw MainMenu_SetTime
	dw MainMenu_About
if DEF(_DEBUG)
	dw MainMenu_DebugRoom
endc

MainMenuItems:
; entries correspond to MAINMENU_* constants

	; MAINMENU_NEW_GAME
	db 3
	db MAINMENUITEM_NEW_GAME
	db MAINMENUITEM_OPTION
	db MAINMENUITEM_ABOUT
	db -1

	; MAINMENU_CONTINUE
	db 5 + DEF(_DEBUG)
	db MAINMENUITEM_CONTINUE
	db MAINMENUITEM_NEW_GAME
	db MAINMENUITEM_OPTION
	db MAINMENUITEM_SET_TIME
	db MAINMENUITEM_ABOUT
if DEF(_DEBUG)
	db MAINMENUITEM_DEBUG_ROOM
endc
	db -1

MainMenu_GetWhichMenu:
	ld a, [wSaveFileExists]
	and a
	jr nz, .next
	ld a, MAINMENU_NEW_GAME
	ret

.next
	ldh a, [hCGB]
	cp TRUE
	ld a, MAINMENU_CONTINUE
	ret

MainMenuJoypadLoop:
	call SetUpMenu
.loop
	call MainMenu_PrintCurrentTimeAndDay
	ld a, [w2DMenuFlags1]
	set 5, a
	ld [w2DMenuFlags1], a
	call GetScrollingMenuJoypad
	ld a, [wMenuJoypad]
	cp B_BUTTON
	jr z, .b_button
	cp A_BUTTON
	jr z, .a_button
	jr .loop

.a_button
	call PlayClickSFX
	and a
	ret

.b_button
	scf
	ret

MainMenu_PrintCurrentVersion:
	lb bc, 1, 4
	ld a, [wSaveFileExists]
	and a
	jr nz, .has_save_file

	; no save file
	hlcoord 14, 15
	call Textbox
	hlcoord 15, 16
	jr .no_save_file

.time_unset_version_number
	; shift version number box for unset time
	hlcoord 14, 9
	call Textbox
	hlcoord 15, 10
	jr .no_save_file

.has_save_file
	; check if time is unset
	call CheckRTCStatus
	and $80
	jr nz, .time_unset_version_number

	; continue normally for set time
	hlcoord 14, 11
	call Textbox
	hlcoord 15, 12
.no_save_file
	ld de, .VersionString
	jmp PlaceString

.VersionString
	db "v0.1"	; Version number goes here
	db "@"

MainMenu_PrintCurrentTimeAndDay:
	ld a, [wSaveFileExists]
	and a
	ret z
	xor a
	ldh [hBGMapMode], a
	call .PlaceBox
	ld hl, wOptions
	ld a, [hl]
	push af
	set NO_TEXT_SCROLL, [hl]
	call .PlaceTime
	pop af
	ld [wOptions], a
	ld a, $1
	ldh [hBGMapMode], a
	ret

.PlaceBox:
	call CheckRTCStatus
	and %10000000 ; Day count exceeded 16383
	jr nz, .TimeFail
	hlcoord 0, 14
	lb bc, 2, 18
	jmp Textbox

.TimeFail:
	jmp SpeechTextbox

.PlaceTime:
	ld a, [wSaveFileExists]
	and a
	ret z
	call CheckRTCStatus
	and $80
	jr nz, .PrintSetTime
	call UpdateTime

	; day
	call GetWeekday
	ld b, a
	decoord 1, 15
	call .PrintDayOfWeek

    ; hour
    decoord 4, 16
	ldh a, [hHours]
	ld c, a
    farcall PrintHour

    ; minute(s)
    ld [hl], ":"
	inc hl
	ld de, hMinutes
	lb bc, PRINTNUM_LEADINGZEROS | 1, 2
	call PrintNum
    ; second
    ld [hl], ":"
	inc hl
	ld de, hSeconds
	lb bc, PRINTNUM_LEADINGZEROS | 1, 2
	jmp PrintNum

.PrintSetTime:
	hlcoord 1, 14
	ld de, .SetTimeString
	jmp PlaceString

.SetTimeString:
	db "Select Continue to"
	next "set the time.@"

.PrintDayOfWeek:
	push de
	ld hl, .Days
	ld a, b
	call GetNthString
	ld d, h
	ld e, l
	pop hl
	call PlaceString
	ld h, b
	ld l, c
	ld de, .Day
	jmp PlaceString

.Days:
	db "Sun@"
	db "Mon@"
	db "Tues@"
	db "Wednes@"
	db "Thurs@"
	db "Fri@"
	db "Satur@"
.Day:
	db "day@"

ClearTilemapEtc:
	xor a
	ldh [hMapAnims], a
	call ClearTilemap
	call LoadFontsExtra
	call LoadStandardFont
	jmp ClearWindowData

MainMenu_NewGame:
	farjp NewGame

MainMenu_Option:
	farjp Option

MainMenu_Continue:
	farjp Continue

MainMenu_SetTime:
	farjp _SetTime

MainMenu_About:
	farjp AboutSpeech
