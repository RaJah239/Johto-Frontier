; Smooth fades for the Newbox PC (Bill's PC storage screen).
;
; The PC writes its party/box mon palettes straight into the hardware from
; H-Blank (LCDBillsPC1-3, which read wBillsPC_PalList and wBGPals1), so a
; normal FadePalettes (wBGPals2 only) would leave the icons at full colour.
; These routines fade wBGPals1/wOBPals1, wBGPals2/wOBPals2 and
; wBillsPC_PalList together, from a backup of the real colours.

DEF BILLSPC_FADE_LEVELS EQU 8 ; level 0 = white, 8 = full colour (one frame each)

BillsPC_FadeStart:
; Back up the PC's palettes and turn them all white (level 0). Call before
; the H-Blank palette code is enabled and before the screen is shown.
	call BillsPC_FadeBackupPals
	xor a
	jr BillsPC_FadeSetLevel

BillsPC_FadeIn:
; Fade from white to the colours saved by BillsPC_FadeStart.
	ld a, 1
.loop
	push af
	call BillsPC_FadeSetLevel
	call DelayFrame
	pop af
	inc a
	cp BILLSPC_FADE_LEVELS + 1
	jr nz, .loop
	ret

BillsPC_FadeOut:
; Fade the PC screen out to white (palettes are left white).
	call BillsPC_FadeBackupPals
	ld a, BILLSPC_FADE_LEVELS - 1
.loop
	push af
	call BillsPC_FadeSetLevel
	call DelayFrame
	pop af
	sub 1
	jr nc, .loop
	ret

BillsPC_FadeBackupPals:
	ldh a, [rSVBK]
	push af
	ld a, BANK(wBGPals1)
	ldh [rSVBK], a
	ld hl, wBGPals1 ; wBGPals1 and wOBPals1 are consecutive
	ld de, wBillsPC_FadeBackup
	ld bc, 16 palettes
	call CopyBytes
	ld hl, wBillsPC_PalList
	ld bc, wBillsPC_PartyList - wBillsPC_PalList
	call CopyBytes
	pop af
	ldh [rSVBK], a
	ret

BillsPC_FadeSetLevel:
; a = level (0 = white .. BILLSPC_FADE_LEVELS = backup colours).
; Writes wBGPals1/wOBPals1 + wBGPals2/wOBPals2 and wBillsPC_PalList.
	ld [wBillsPC_FadeLevel], a
	ldh a, [rSVBK]
	push af
	ld a, BANK(wBGPals1)
	ldh [rSVBK], a

	ld hl, wBillsPC_FadeBackup
	ld de, wBGPals1
	ld a, 16 * NUM_PAL_COLORS
.pals
	push af
	push de
	call .FadeColor ; bc = faded colour
	pop de
	push hl
	ld h, d
	ld l, e
	; wBGPals2 / wOBPals2 = wBGPals1 / wOBPals1 + $80 (the section is ALIGN[8])
	ld a, c
	ld [hli], a
	ld a, b
	ld [hld], a
	set 7, l
	ld a, c
	ld [hli], a
	ld a, b
	ld [hli], a
	res 7, l
	ld d, h
	ld e, l
	pop hl
	pop af
	dec a
	jr nz, .pals

	ld de, wBillsPC_PalList
	ld a, (wBillsPC_PartyList - wBillsPC_PalList) / 2
.list
	push af
	push de
	call .FadeColor
	pop de
	ld a, c
	ld [de], a
	inc de
	ld a, b
	ld [de], a
	inc de
	pop af
	dec a
	jr nz, .list

	pop af
	ldh [rSVBK], a
	ld a, TRUE
	ldh [hCGBPalUpdate], a
	ret

.FadeColor:
; hl = source colour (RGB555, little endian) -> bc = faded colour, hl += 2
	ld a, [hli]
	ld e, a ; gggrrrrr
	ld a, [hli]
	ld d, a ; 0bbbbbgg
	push hl
	; red
	ld a, e
	and %11111
	call .FadeChannel
	ld l, a
	; green
	ld a, d
	and %11
	add a
	add a
	add a
	ld h, a
	ld a, e
	swap a
	rrca
	and %111
	or h
	call .FadeChannel
	ld h, a
	; blue
	ld a, d
	rrca
	rrca
	and %11111
	call .FadeChannel
	; high byte = blue << 2 | green >> 3
	add a
	add a
	ld b, a
	ld a, h
	rrca
	rrca
	rrca
	and %11
	or b
	ld b, a
	; low byte = green << 5 | red
	ld a, h
	swap a
	add a
	and %11100000
	or l
	ld c, a
	pop hl
	ret

.FadeChannel:
; a = channel (0-31) -> a = 31 - (31 - a) * level / BILLSPC_FADE_LEVELS
	cpl
	and %11111
	ld c, a
	ld a, [wBillsPC_FadeLevel]
	ld b, a
	xor a
	inc b
.mul
	dec b
	jr z, .got
	add c
	jr .mul
.got
	assert BILLSPC_FADE_LEVELS == 8
	srl a
	srl a
	srl a
	cpl
	and %11111
	ret
