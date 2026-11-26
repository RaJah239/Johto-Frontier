; Instant palette changes for the Newbox PC (Bill's PC storage screen).
; H-Blank reads wBGPals1 and wBillsPC_PalList for the mon icons, while
; V-Blank reads wBGPals2/wOBPals2. Update all three before showing the screen.

BillsPC_FadeStart:
; Keep the screen white until its tilemap and H-Blank palettes are ready.
	call BillsPC_FadeBackupPals
	jr BillsPC_SetWhitePals

BillsPC_FadeIn:
; Restore the finished palettes directly, then let V-Blank display them.
	ldh a, [rSVBK]
	push af
	ld a, BANK(wBGPals1)
	ldh [rSVBK], a
	ld hl, wBillsPC_FadeBackup
	ld de, wBGPals1 ; BG and OBJ palettes are consecutive
	ld bc, 16 palettes
	call CopyBytesInBlocksOfEight
	ld hl, wBillsPC_FadeBackup
	ld de, wBGPals2
	ld bc, 16 palettes
	call CopyBytesInBlocksOfEight
	ld hl, wBillsPC_FadeBackup + 16 palettes
	ld de, wBillsPC_PalList
	ld bc, wBillsPC_PartyList - wBillsPC_PalList
	call CopyBytes
	pop af
	ldh [rSVBK], a
	ld a, TRUE
	ldh [hCGBPalUpdate], a
	jmp DelayFrame

BillsPC_FadeOut:
; Display white before the tilemap and H-Blank handler are cleared.
	call BillsPC_SetWhitePals
	jmp DelayFrame

BillsPC_FadeBackupPals:
	ldh a, [rSVBK]
	push af
	ld a, BANK(wBGPals1)
	ldh [rSVBK], a
	ld hl, wBGPals1
	ld de, wBillsPC_FadeBackup
	ld bc, 16 palettes
	call CopyBytesInBlocksOfEight
	ld hl, wBillsPC_PalList
	ld bc, wBillsPC_PartyList - wBillsPC_PalList
	call CopyBytes
	pop af
	ldh [rSVBK], a
	ret

BillsPC_SetWhitePals:
	ldh a, [rSVBK]
	push af
	ld a, BANK(wBGPals1)
	ldh [rSVBK], a
	ld hl, wBGPals1
	ld b, 16 * NUM_PAL_COLORS
	call BillsPC_WriteWhite
	ld hl, wBGPals2
	ld b, 16 * NUM_PAL_COLORS
	call BillsPC_WriteWhite
	ld hl, wBillsPC_PalList
	ld b, (wBillsPC_PartyList - wBillsPC_PalList) / 2
	call BillsPC_WriteWhite
	pop af
	ldh [rSVBK], a
	ld a, TRUE
	ldh [hCGBPalUpdate], a
	ret

BillsPC_WriteWhite:
; Fill b RGB555 colours with $7fff, the same white as fade level 0.
	ld a, $ff
	ld [hli], a
	ld a, $7f
	ld [hli], a
	dec b
	jr nz, BillsPC_WriteWhite
	ret
