INCLUDE "engine/events/battle_tower/battle_tower.asm"

Clears5_a89a:
	ld a, BANK(s5_a89a)
	call OpenSRAM
	ld hl, s5_a89a
	xor a
	ld [hli], a
	ld [hl], a
	call CloseSRAM
	ret

CheckBTMonMovesForErrors:
	ld a, 6
	ld c, a
	ld hl, wBT_OTTempMon1Moves
.loop
	push hl
	ld a, [hl]
	cp NUM_ATTACKS + 1
	jr c, .okay
	ld a, TACKLE
	ld [hl], a

.okay
	inc hl
	ld b, NUM_MOVES - 1
.loop2
	ld a, [hl]
	and a
	jr z, .loop3
	cp NUM_ATTACKS + 1
	jr c, .next

.loop3
	xor a
	ld [hl], a
	inc hl
	dec b
	jr nz, .loop3
	jr .done

.next
	inc hl
	dec b
	jr nz, .loop2

.done
	pop hl
	ld de, NICKNAMED_MON_STRUCT_LENGTH
	add hl, de
	dec c
	jr nz, .loop
	ret

Function170cc6:
	ldh a, [rSVBK]
	push af
	ld a, BANK(wDecompressScratch)
	ldh [rSVBK], a
	ld hl, PichuAnimatedMobileGFX
	ld de, wDecompressScratch
	call Decompress
	ld a, 1
	ldh [rVBK], a
	ld de, wDecompressScratch
	ld hl, vTiles0
	lb bc, BANK(wDecompressScratch), 193
	call Get2bpp
	xor a
	ldh [rVBK], a
	ld hl, ElectroBallMobileGFX
	ld de, wDecompressScratch
	call Decompress
	ld de, wBGPals1
	ld hl, vTiles0
	lb bc, BANK(wDecompressScratch), 83
	call Get2bpp
	pop af
	ldh [rSVBK], a
	ret

Function170d02:
	ld a, $1
	ldh [rVBK], a
	ld de, PichuBorderMobileGFX
	ld hl, vTiles0 tile $c1
	lb bc, BANK(PichuBorderMobileGFX), 24
	call Get2bpp
	xor a
	ldh [rVBK], a
	ret

PichuAnimatedMobileGFX:
INCBIN "gfx/mobile/pichu_animated.2bpp.lz"

ElectroBallMobileGFX:
INCBIN "gfx/mobile/electro_ball.2bpp.lz"

PichuBorderMobileGFX:
INCBIN "gfx/mobile/pichu_border.2bpp"

Function171c87:
	call DisableLCD
	ld hl, AsciiFontGFX
	ld de, vTiles2 tile $00
	ld bc, $6e tiles
	call CopyBytes
	ld hl, PasswordSlowpokeLZ
	ld de, vTiles0 tile $00
	call Decompress
	call EnableLCD
	ld hl, PasswordTopTilemap
	decoord 0, 0
	ld bc, $168
	call CopyBytes
	ld hl, MobilePasswordAttrmap
	decoord 0, 0, wAttrmap
	ld bc, $168
	call CopyBytes
	hlcoord 3, 2
	ld de, String_172e31
	call PlaceString
	hlcoord 3, 16
	ld de, String_172e3f
	call PlaceString
	ret

Function171ccd:
	ldh a, [rSVBK]
	push af
	ld a, $5
	ldh [rSVBK], a
	ld hl, MobilePasswordPalettes
	ld de, wBGPals1
	ld bc, 8 palettes
	call CopyBytes
	ld hl, wOBPals1 palette 0 color 1
	ld a, LOW(PALRGB_WHITE)
	ld [hli], a
	ld a, HIGH(PALRGB_WHITE)
	ld [hl], a
	call SetDefaultBGPAndOBP
	pop af
	ldh [rSVBK], a
	ret

Function171cf0:
	xor a
	hlcoord 4, 15
	ld [hli], a
	ld [hli], a
	ld a, [wcd4b]
	xor $1
	ld [wcd4b], a
	and a
	jr nz, .shifted
	ld hl, PasswordBottomTilemap
	decoord 0, 7
	ld bc, $8c
	call CopyBytes
	hlcoord 3, 16
	ld de, String_172e3f
	jmp PlaceString

.shifted
	ld hl, PasswordShiftTilemap
	decoord 0, 7
	ld bc, $8c
	call CopyBytes
	hlcoord 3, 16
	ld de, String_172e4e
	jmp PlaceString

MobilePasswordPalettes:
INCLUDE "gfx/mobile/mobile_password.pal"

AsciiFontGFX:
INCBIN "gfx/mobile/ascii_font.2bpp"

PasswordTopTilemap:
INCBIN "gfx/mobile/password_top.tilemap"

PasswordBottomTilemap:
INCBIN "gfx/mobile/password_bottom.tilemap"

PasswordShiftTilemap:
INCBIN "gfx/mobile/password_shift.tilemap"

ChooseMobileCenterTilemap:
INCBIN "gfx/mobile/mobile_center.tilemap"

MobilePasswordAttrmap:
INCBIN "gfx/mobile/password.attrmap"

ChooseMobileCenterAttrmap:
INCBIN "gfx/mobile/mobile_center.attrmap"

PasswordSlowpokeLZ:
INCBIN "gfx/pokedex/slowpoke.2bpp.lz"

String_172e31:
	db "パスワード<WO>いれてください@"
String_172e3f:
	db "きりかえ　やめる　　けってい@"
String_172e4e:
	db "きりかえ　やめる　　"

Function172e78:
	ld a, $7f
	hlcoord 0, 0
	ld bc, $168
	call ByteFill
	ld a, $7
	hlcoord 0, 0, wAttrmap
	ld bc, $168
	call ByteFill
	call DisableLCD
	ld hl, Stadium2N64GFX
	ld de, vTiles2 tile $00
	ld bc, $61 tiles
	call CopyBytes
	call EnableLCD
	ld hl, Stadium2N64Tilemap
	decoord 0, 0
	ld bc, $168
	call CopyBytes
	ld hl, Stadium2N64Attrmap
	decoord 0, 0, wAttrmap
	ld bc, $168
	call CopyBytes
	ret

Function172eb9:
	ldh a, [rSVBK]
	push af
	ld a, $5
	ldh [rSVBK], a
	ld hl, Palette_172edf
	ld de, wBGPals1
	ld bc, 8 palettes
	call CopyBytes
	ld hl, Palette_172edf
	ld de, wBGPals2
	ld bc, 8 palettes
	call CopyBytes
	call SetDefaultBGPAndOBP
	pop af
	ldh [rSVBK], a
	ret

Palette_172edf:
	RGB  5, 12, 17
	RGB 31, 31, 31
	RGB 18, 25, 28
	RGB 10, 17, 21
	RGB  6, 13, 18
	RGB 31, 31, 31
	RGB 20, 26, 28
	RGB 12, 19, 23
	RGB  3, 10, 16
	RGB 31, 31, 31
	RGB  6, 13, 18
	RGB 20, 26, 28
	RGB  0,  0,  0
	RGB  0,  0,  0
	RGB  0,  0,  0
	RGB  0,  0,  0
	RGB  0,  0,  0
	RGB  0,  0,  0
	RGB  0,  0,  0
	RGB  0,  0,  0
	RGB  0,  0,  0
	RGB  0,  0,  0
	RGB  0,  0,  0
	RGB  0,  0,  0
	RGB  5,  5, 16
	RGB  8, 19, 28
	RGB  0,  0,  0
	RGB 31, 31, 31
	RGB 31, 31, 31
	RGB  0,  0,  0
	RGB  0,  0,  0
	RGB  0,  0,  0

Stadium2N64GFX:
INCBIN "gfx/mobile/stadium2_n64.2bpp"

Stadium2N64Tilemap:
if DEF(_CRYSTAL11)
; BUG: Crystal 1.1 corrupted this tilemap by treating $0a bytes as
; Unix newlines, and converting them to $0d $0a Windows newlines.
INCBIN "gfx/mobile/stadium2_n64_corrupt.tilemap"
else
INCBIN "gfx/mobile/stadium2_n64.tilemap"
endc

Stadium2N64Attrmap:
INCBIN "gfx/mobile/stadium2_n64.attrmap"
