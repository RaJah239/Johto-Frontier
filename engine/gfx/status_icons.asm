; Status condition icons (from Polished Crystal, with FRB for frostbite
; and FNT): in the battle HUDs and the party menu.

	const_def
	const STATUS_ICON_OK  ; 0 (blank)
	const STATUS_ICON_PSN ; 1
	const STATUS_ICON_PAR ; 2
	const STATUS_ICON_SLP ; 3
	const STATUS_ICON_BRN ; 4
	const STATUS_ICON_FRB ; 5
	const STATUS_ICON_TOX ; 6
	const STATUS_ICON_FNT ; 7
DEF NUM_STATUS_ICONS EQU const_value

; Each icon is two tiles. StatusIconGFX draws it in color 1, and
; EnemyStatusIconGFX in color 2, so one palette can hold two of them.
; The tiles go in VRAM bank 1 at BG tiles $e0-$ef, free in battle and in
; the party menu (the ability popup borrows $d4-$e7, but only in battle).

; In battle, both HUDs use BG palette PAL_BATTLE_BG_STATUS: color 1 for
; the player's status, color 2 for the foe's.
DEF BATTLE_STATUS_ICON_PLAYER_TILE EQU $ec
DEF BATTLE_STATUS_ICON_ENEMY_TILE  EQU $ee

; The party menu gives each party slot its own two tiles from $e0, and
; uses BG palettes 4-6 (free there), two status colours in each: see
; PartyStatusIconPalettes.
DEF PARTY_STATUS_ICON_TILE EQU $e0
DEF PARTY_STATUS_ICON_X EQU 4
DEF PARTY_STATUS_ICON_Y EQU 2
DEF PARTY_STATUS_ICON_DRAWN_IN_COLOR_2 EQU $80

GetStatusIconIndex:
; de = status, hl = substatus 5 (for Toxic) or 0. Returns the icon in a.
	ld a, [de]
	ld b, a
	and SLP_MASK
	ld a, STATUS_ICON_SLP
	ret nz
	bit PSN, b
	jr nz, .psn
	ld a, STATUS_ICON_PAR
	bit PAR, b
	ret nz
	ld a, STATUS_ICON_BRN
	bit BRN, b
	ret nz
	ld a, STATUS_ICON_FRB
	bit FRZ, b
	ret nz
	xor a ; STATUS_ICON_OK
	ret

.psn
	ld a, h
	or l
	jr z, .not_toxic
	bit SUBSTATUS_TOXIC, [hl]
	ld a, STATUS_ICON_TOX
	ret nz
.not_toxic
	ld a, STATUS_ICON_PSN
	ret

GetPlayerStatusIconIndex:
	ld de, wBattleMonStatus
	ld hl, wPlayerSubStatus5
	jr GetStatusIconIndex

GetEnemyStatusIconIndex:
	ld de, wEnemyMonStatus
	ld hl, wEnemySubStatus5
	jr GetStatusIconIndex

LoadPlayerStatusIcon::
; Draw the player's status icon in its HUD (row 8, columns 11-12).
	call GetPlayerStatusIconIndex
	ld de, StatusIconGFX
	ld b, BATTLE_STATUS_ICON_PLAYER_TILE
	ld c, 1 ; color
	hlcoord 11, 8
	jr LoadBattleStatusIcon

LoadEnemyStatusIcon::
; Draw the foe's status icon in its HUD (row 1, columns 2-3).
	call GetEnemyStatusIconIndex
	ld de, EnemyStatusIconGFX
	ld b, BATTLE_STATUS_ICON_ENEMY_TILE
	ld c, 2 ; color
	hlcoord 2, 1
	; fallthrough

LoadBattleStatusIcon:
; Draw icon a from gfx de with tiles b..b+1 at hl, its colour in color c
; of PAL_BATTLE_BG_STATUS.
	ld [hl], b
	inc hl
	inc b
	ld [hl], b
	dec b
	push af
	push bc
	call GetStatusIconGFX
	ld a, b
	call StatusIcons_SendTiles
	pop bc
	pop af
	ld e, c
	ld d, PAL_BATTLE_BG_STATUS
	; fallthrough

SetStatusIconColor:
; Set color e of BG palette d to status icon a's colour, in wBGPals1,
; wBGPals2 and straight in the hardware.
	ld hl, StatusIconPals
	add a
	add l
	ld l, a
	adc h
	sub l
	ld h, a
	ld a, [hli]
	ld b, [hl]
	ld c, a ; bc = color

	ld a, d
	add a
	add a
	add e
	add a ; palette * 8 + color * 2
	push af
	ld l, a
	ld h, 0
	push de
	ld de, wBGPals1
	add hl, de
	pop de
	ldh a, [rSVBK]
	push af
	ld a, BANK(wBGPals1)
	ldh [rSVBK], a
	ld [hl], c
	inc hl
	ld [hl], b
	ld de, wBGPals2 - wBGPals1 - 1
	add hl, de
	ld [hl], c
	inc hl
	ld [hl], b
	pop af
	ldh [rSVBK], a
	pop af
	or 1 << rBGPI_AUTO_INCREMENT
	ld e, a
	call StatusIcons_WaitHBlank
	ld a, e
	ldh [rBGPI], a
	ld a, c
	ldh [rBGPD], a
	ld a, b
	ldh [rBGPD], a
	ei
	ret

LoadBattleStatusIconPals::
; Fill the palette at de (WRAM bank 5) with white, the player's status
; colour, the foe's and black, and advance de past it, like the other
; SetBattlePal_* routines in _CGB_BattleColors.
	ldh a, [rSVBK]
	push af
	ld a, BANK(wBGPals1)
	ldh [rSVBK], a
	ld a, LOW(PALRGB_WHITE)
	ld [de], a
	inc de
	ld a, HIGH(PALRGB_WHITE)
	ld [de], a
	inc de
	push de
	call GetPlayerStatusIconIndex
	pop de
	call .color
	push de
	call GetEnemyStatusIconIndex
	pop de
	call .color
	xor a
	ld [de], a
	inc de
	ld [de], a
	inc de
	pop af
	ldh [rSVBK], a
	ret

.color
	ld hl, StatusIconPals
	add a
	add l
	ld l, a
	adc h
	sub l
	ld h, a
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	inc de
	ret

PlacePartyMonStatusIcon::
; Draw the status icon of party mon c, whose status is at de, in its
; party menu row. Nothing for a healthy mon.
	ld h, d
	ld l, e
	inc hl
	inc hl
	assert MON_STATUS + 2 == MON_HP
	ld a, [hli]
	or [hl]
	ld a, STATUS_ICON_FNT
	jr z, .got_icon
	ld hl, 0 ; no Toxic outside battle
	call GetStatusIconIndex
.got_icon
	ld b, a

; the two cells
	ld a, c
	add a ; 2 rows per mon
	add PARTY_STATUS_ICON_Y
	ld hl, wTilemap + PARTY_STATUS_ICON_X
	push bc
	ld bc, SCREEN_WIDTH
	call AddNTimes
	pop bc
	ld a, b
	and a
	jr z, .healthy
	ld a, c
	add a
	add PARTY_STATUS_ICON_TILE
	ld [hli], a
	inc a
	ld [hld], a
	ld de, wAttrmap - wTilemap
	add hl, de
	ld e, b
	ld d, 0
	push hl
	ld hl, PartyStatusIconPalettes
	add hl, de
	ld a, [hl]
	pop hl
	push af
	and PALETTE_MASK
	or VRAM_BANK_1
	ld [hli], a
	ld [hl], a

; the tiles
	pop af
	ld de, StatusIconGFX
	bit 7, a ; PARTY_STATUS_ICON_DRAWN_IN_COLOR_2
	jr z, .got_gfx
	ld de, EnemyStatusIconGFX
.got_gfx
	ld a, b
	call GetStatusIconGFX
	ld a, c
	add a
	add PARTY_STATUS_ICON_TILE
	jr StatusIcons_SendTiles

.healthy
	ld de, wAttrmap - wTilemap
	add hl, de
	xor a
	ld [hli], a
	ld [hl], a
	ret

PartyStatusIconPalettes:
; BG palette for each icon in the party menu; PARTY_STATUS_ICON_DRAWN_IN_COLOR_2
; if it takes its palette's color 2 (and is drawn from EnemyStatusIconGFX)
	table_width 1, PartyStatusIconPalettes
	db 0     ; OK (unused)
	db 4     ; PSN
	db 4 | PARTY_STATUS_ICON_DRAWN_IN_COLOR_2 ; PAR
	db 5     ; SLP
	db 5 | PARTY_STATUS_ICON_DRAWN_IN_COLOR_2 ; BRN
	db 6     ; FRB
	db 4     ; TOX (the PSN colour)
	db 6 | PARTY_STATUS_ICON_DRAWN_IN_COLOR_2 ; FNT
	assert_table_length NUM_STATUS_ICONS

LoadPartyStatusIconPals::
; Fill BG palettes 4-6 in wBGPals1 for the party menu's status icons:
; white, PSN/SLP/FRB, PAR/BRN/FNT, black.
	ldh a, [rSVBK]
	push af
	ld a, BANK(wBGPals1)
	ldh [rSVBK], a
	ld de, wBGPals1 palette 4
	ld hl, .Icons
	ld b, 3
.palette
	ld a, LOW(PALRGB_WHITE)
	ld [de], a
	inc de
	ld a, HIGH(PALRGB_WHITE)
	ld [de], a
	inc de
	ld c, 2
.color
	ld a, [hli]
	push hl
	ld hl, StatusIconPals
	add a
	add l
	ld l, a
	adc h
	sub l
	ld h, a
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	inc de
	pop hl
	dec c
	jr nz, .color
	xor a
	ld [de], a
	inc de
	ld [de], a
	inc de
	dec b
	jr nz, .palette
	pop af
	ldh [rSVBK], a
	ret

.Icons:
	db STATUS_ICON_PSN, STATUS_ICON_PAR
	db STATUS_ICON_SLP, STATUS_ICON_BRN
	db STATUS_ICON_FRB, STATUS_ICON_FNT

GetStatusIconGFX:
; de += icon a * 2 tiles
	swap a
	add a ; * 2 tiles (icons < 8)
	add e
	ld e, a
	adc d
	sub e
	ld d, a
	ret

StatusIcons_SendTiles:
; Write the 2 tiles at de to BG tile a (VRAM bank 1) during H-Blanks.
	sub $80
	ld l, a
	ld h, 0
rept 4
	add hl, hl
endr
	ld bc, vTiles4
	add hl, bc
	ld c, 2 * LEN_2BPP_TILE / 2
.loop
	call StatusIcons_WaitHBlank
	ld a, 1
	ldh [rVBK], a
	ld a, [de]
	ld [hli], a
	inc de
	ld a, [de]
	ld [hli], a
	inc de
	xor a
	ldh [rVBK], a
	ei
	dec c
	jr nz, .loop
	ret

StatusIcons_WaitHBlank:
; di, then wait for the start of H-Blank (or V-Blank) so VRAM can be
; written for a few bytes. The caller does ei. No wait with the LCD off.
	di
	ldh a, [rLCDC]
	bit rLCDC_ENABLE, a
	ret z
.wait_busy
	ldh a, [rSTAT]
	and %10 ; mode 2 or 3
	jr z, .wait_busy
.wait_free
	ldh a, [rSTAT]
	and %10
	jr nz, .wait_free
	ret

StatusIconPals:
	table_width PAL_COLOR_SIZE, StatusIconPals
INCLUDE "gfx/battle/status.pal"
	assert_table_length NUM_STATUS_ICONS

StatusIconGFX:
INCBIN "gfx/battle/status.2bpp"

EnemyStatusIconGFX:
INCBIN "gfx/battle/status-enemy.2bpp"
