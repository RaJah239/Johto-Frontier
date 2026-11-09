CopyCustomBattlePalette:
; Copy custom battle palette b (PAL_BTLCUSTOM_*) to de in WRAM "GBC Video".
; (Its own section, out of "Move Animations", which is full.)
	ld a, b
	ld hl, CustomBattlePalettes
	ld bc, 1 palettes
	call AddNTimes
	jmp FarCopyColorWRAM

CustomBattlePalettes:
INCLUDE "gfx/battle_anims/custom.pal"
