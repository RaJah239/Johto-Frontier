LoadBattleMenu:
	ld a, [wBattleMode]
	dec a
	ld hl, BattleMenuHeaderTrainer
	jr nz, .trainer
	ld hl, BattleMenuHeaderWild
	; fallthrough

.trainer
	call LoadMenuHeader
	ld a, [wBattleMenuCursorPosition]
	ld [wMenuCursorPosition], a
	call InterpretBattleMenu
	ld a, [wMenuCursorPosition]
	ld [wBattleMenuCursorPosition], a
	jmp ExitMenu

ContestBattleMenu:
	ld hl, ContestBattleMenuHeader
	call LoadMenuHeader
	; fallthrough

CommonBattleMenu:
	ld a, [wBattleMenuCursorPosition]
	ld [wMenuCursorPosition], a
	call _2DMenu
	ld a, [wMenuCursorPosition]
	ld [wBattleMenuCursorPosition], a
	jmp ExitMenu

BattleMenuHeaderWild:
	db MENU_BACKUP_TILES ; flags
	menu_coords 7, 12, SCREEN_WIDTH - 1, SCREEN_HEIGHT - 1
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR | STATICMENU_WRAP | STATICMENU_DISABLE_B ; flags
	dn 2, 2 ; rows, columns
	db 6 ; spacing
	dba .Text
	dbw BANK(@), NULL

.Text:
	db "Fight@"
	db "Pack@"
	db "<PKMN>@"
	db "Run@"

BattleMenuHeaderTrainer:
	db MENU_BACKUP_TILES ; flags
	menu_coords 7, 12, SCREEN_WIDTH - 1, SCREEN_HEIGHT - 1
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR | STATICMENU_WRAP | STATICMENU_DISABLE_B ; flags
	dn 2, 2 ; rows, columns
	db 6 ; spacing
	dba .Text
	dbw BANK(@), NULL

.Text:
	db "Fight@"
	db "Quit@"
	db "<PKMN>@"
	db "Info@"

ContestBattleMenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 4, 12, SCREEN_WIDTH - 1, SCREEN_HEIGHT - 1
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR | STATICMENU_WRAP | STATICMENU_DISABLE_B ; flags
	dn 2, 2 ; rows, columns
	db 6 ; spacing
	dba .Text
	dba .PrintParkBallsRemaining

.Text:
	db "Fight@"
	db "Ball×@"
	db "<PKMN>@"
	db "Run@"

.PrintParkBallsRemaining:
	hlcoord 17, 14
	ld de, wParkBallsRemaining
	lb bc, PRINTNUM_LEADINGZEROS | 1, 2
	jmp PrintNum
