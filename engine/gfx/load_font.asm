INCLUDE "gfx/font.asm"

_LoadStandardFont::
	ld de, Font
	ld hl, vTiles1
	lb bc, BANK(Font), 32 ; "A" to "]"
	call Get1bppViaHDMA
	ld de, Font + 32 * LEN_1BPP_TILE
	ld hl, vTiles1 tile $20
	lb bc, BANK(Font), 26 ; "a" to "z" (skip "┌" to "┘")
	call Get1bppViaHDMA
	ld de, Font + 64 * LEN_1BPP_TILE
	ld hl, vTiles1 tile $40
	lb bc, BANK(Font), 32 ; $c0 to "←"
	call Get1bppViaHDMA
	ld de, Font + 96 * LEN_1BPP_TILE
	ld hl, vTiles1 tile $60
	lb bc, BANK(Font), 32 ; "'" to "9"
	jmp Get1bppViaHDMA

_LoadFontsExtra::
	jr LoadFrame

_LoadFontsBattleExtra::
	ld de, FontBattleExtra
	ld hl, vTiles2 tile $60
	lb bc, BANK(FontBattleExtra), 25
	call Get2bppViaHDMA
	; fallthrough

LoadFrame:
	ld a, [wTextboxFrame]
	maskbits NUM_FRAMES
	ld bc, TEXTBOX_FRAME_TILES * LEN_1BPP_TILE
	ld hl, Frames
	call AddNTimes
	ld d, h
	ld e, l
	ld hl, vTiles0 tile "┌" ; $ba
	lb bc, BANK(Frames), TEXTBOX_FRAME_TILES ; "┌" to "┘"
	call Get1bppViaHDMA
	ld hl, vTiles2 tile " " ; $7f
	ld de, TextboxSpaceGFX
	lb bc, BANK(TextboxSpaceGFX), 1
	jmp Get1bppViaHDMA

LoadBattleFontsHPBar:
	ld de, FontBattleExtra
	ld hl, vTiles2 tile $60
	lb bc, BANK(FontBattleExtra), 12
	call Get2bppViaHDMA
	ld hl, vTiles2 tile $70
	ld de, FontBattleExtra + 16 tiles ; "<DO>"
	lb bc, BANK(FontBattleExtra), 3 ; "<DO>" to "『"
	call Get2bppViaHDMA
	call LoadFrame

LoadHPBar:
	call LoadBattleGenderIcons
	ld de, EnemyHPBarBorderGFX
	ld hl, vTiles2 tile $6c
	lb bc, BANK(EnemyHPBarBorderGFX), 4
	call Get1bppViaHDMA
	ld de, HPExpBarBorderGFX
	ld hl, vTiles2 tile $73
	lb bc, BANK(HPExpBarBorderGFX), 6
	call Get1bppViaHDMA
	ld de, ExpBarGFX
	ld hl, vTiles2 tile $55
	lb bc, BANK(ExpBarGFX), 11
	jmp Get2bppViaHDMA

StatsScreen_LoadFont:
	call _LoadFontsBattleExtra
	; the gender icons, both in color 1 (male, then female)
	ld de, GenderIconsGFX + 2 tiles
	ld hl, vTiles2 tile STATS_GENDER_TILE
	lb bc, BANK(GenderIconsGFX), 1
	call Get2bppViaHDMA
	ld de, GenderIconsGFX + 1 tiles
	ld hl, vTiles2 tile (STATS_GENDER_TILE + 1)
	lb bc, BANK(GenderIconsGFX), 1
	call Get2bppViaHDMA
	ld de, EnemyHPBarBorderGFX
	ld hl, vTiles2 tile $6c
	lb bc, BANK(EnemyHPBarBorderGFX), 4
	call Get1bppViaHDMA
	ld de, HPExpBarBorderGFX
	ld hl, vTiles2 tile $78
	lb bc, BANK(HPExpBarBorderGFX), 1
	call Get1bppViaHDMA
	ld de, HPExpBarBorderGFX + 3 * LEN_1BPP_TILE
	ld hl, vTiles2 tile $76
	lb bc, BANK(HPExpBarBorderGFX), 2
	call Get1bppViaHDMA
	ld de, ExpBarGFX
	ld hl, vTiles2 tile $55
	lb bc, BANK(ExpBarGFX), 10
	call Get2bppViaHDMA
LoadStatsScreenPageTilesGFX:
	ld de, StatsScreenPageTilesGFX
	ld hl, vTiles2 tile $31
	lb bc, BANK(StatsScreenPageTilesGFX), 17
	jmp Get2bppViaHDMA

LoadBattleGenderIcons::
; The battle's male and female icons.
	ld hl, vTiles2 tile BATTLE_GENDER_TILE
	ld de, GenderIconsGFX
	lb bc, BANK(GenderIconsGFX), 2
	jmp Get2bppViaHDMA
