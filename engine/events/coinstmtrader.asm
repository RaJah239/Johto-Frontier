DEF NUMBER_OF_TMS EQU 50

CoinsTMTrader:
	
	call LoadStandardMenuHeader
	ld c, $1
	xor a
	ld [wMenuScrollPosition], a

	ld a, c
	ld [wMenuSelection], a
	call SelectTM
	ld a, c
	ld [wScriptVar], a
	and a
	jr z, .done
	ld [wCurItem], a
	
.done
	ret
	
SelectTM:
	ld hl, .MenuHeader
	call CopyMenuHeader
	ld a, [wMenuSelection]
	ld [wMenuCursorPosition], a
	xor a
	ldh [hBGMapMode], a
	call InitScrollingMenu
	call UpdateSprites
	call ScrollingMenu
	ld a, [wMenuJoypad]
	cp B_BUTTON
	jr z, .nope
	ld a, [wMenuSelection]
	cp -1
	jr nz, .done

.nope
	xor a ; FALSE

.done
	ld c, a
	ret
	
.MenuHeader
	db MENU_BACKUP_TILES ; flags
	menu_coords 1, 1, 18, 10
	dw .MenuData
	db 1 ; default option
	
	db 0

.MenuData:
	db SCROLLINGMENU_DISPLAY_ARROWS
	db 5, 0
	db SCROLLINGMENU_ITEMS_NORMAL
	dba .tmnumber
	dba .tmname
;	dba
	
.tmnumber
	db NUMBER_OF_TMS
DEF x = 1
rept NUMBER_OF_TMS
	db x
DEF x = x + 1
endr
	db -1
	
.tmname
	ld a, [wMenuSelection]
	call GetTMs
	ld a, [hl]
	push de
	ld [wNamedObjectIndex], a
	call GetItemName
	cp TM01
	jr c, .place_string
	ld hl, wStringBuffer1
	ld de, wStringBuffer4
	ld bc, STRING_BUFFER_LENGTH
	call CopyBytes
	ld de, wStringBuffer4 + STRLEN("TM##")
	callfar AppendTMHMMoveName
	ld de, wStringBuffer4
.place_string:
	pop hl
	call PlaceString
	ret

GetTMs:
	dec a
	ld hl, TMMenuItems
	ld b, 0
	ld c, a
	add hl, bc
	ret

TMMenuItems:
	db TM_DYNAMICPUNCH
	db TM_HEADBUTT
	db TM_CURSE
	db TM_ROLLOUT
	db TM_ROAR
	db TM_TOXIC
	db TM_ZAP_CANNON
	db TM_ROCK_SMASH
	db TM_PSYCH_UP
	db TM_HIDDEN_POWER
	db TM_SUNNY_DAY
	db TM_SWEET_SCENT
	db TM_SNORE
	db TM_BLIZZARD
	db TM_HYPER_BEAM
	db TM_ICY_WIND
	db TM_PROTECT
	db TM_RAIN_DANCE
	db TM_GIGA_DRAIN
	db TM_ENDURE
	db TM_FRUSTRATION
	db TM_SOLARBEAM
	db TM_IRON_TAIL
	db TM_DRAGONBREATH
	db TM_THUNDER
	db TM_EARTHQUAKE
	db TM_RETURN
	db TM_DIG
	db TM_PSYCHIC_M
	db TM_SHADOW_BALL
	db TM_MUD_SLAP
	db TM_DOUBLE_TEAM
	db TM_ICE_PUNCH
	db TM_SWAGGER
	db TM_SLEEP_TALK
	db TM_SLUDGE_BOMB
	db TM_SANDSTORM
	db TM_FIRE_BLAST
	db TM_SWIFT
	db TM_DEFENSE_CURL
	db TM_THUNDERPUNCH
	db TM_DREAM_EATER
	db TM_DETECT
	db TM_REST
	db TM_ATTRACT
	db TM_THIEF
	db TM_STEEL_WING
	db TM_FIRE_PUNCH
	db TM_FURY_CUTTER
	db TM_NIGHTMARE
