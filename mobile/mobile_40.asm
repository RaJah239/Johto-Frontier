Function100db0:
	ld hl, wcd2a
	bit 3, [hl]
	jr nz, .asm_100dbe
	ld hl, wcd2a
	set 3, [hl]
	scf
	ret

.asm_100dbe
	xor a
	ret

Function100dc0:
	ld a, [wLinkMode]
	cp LINK_MOBILE
	jr nz, .mobile
	ld hl, wcd2a
	bit 3, [hl]
	jr z, .mobile
	scf
	ret

.mobile
	xor a
	ret

Function100f3d:
	; parameter
	ld a, [wStringBuffer2]
	cp $02
	jr z, .two
	cp $01
	jr z, .one
	cp $03
	jr z, .three
	ret

.three
	; what was once in de gets copied to hl,
	; modified by Function100f8d, and put back
	; into this backup
	ld a, [wStringBuffer2 + 1]
	ld l, a
	ld a, [wStringBuffer2 + 2]
	ld h, a
	call Function100f8d
	ld a, l
	ld [wStringBuffer2 + 1], a
	ld a, h
	ld [wStringBuffer2 + 2], a
	ret

.two
	; hl gets backed up to de, then
	; do the same as in .three
	ld d, h
	ld e, l
	ld a, [wStringBuffer2 + 1]
	ld l, a
	ld a, [wStringBuffer2 + 2]
	ld h, a
	call Function100f8d
	ld a, l
	ld [wStringBuffer2 + 1], a
	ld a, h
	ld [wStringBuffer2 + 2], a
	ret

.one
	; de gets copied to hl, then
	; load the backup into de,
	; finally run Function100f8d
	; and store the de result
	ld h, d
	ld l, e
	ld a, [wStringBuffer2 + 1]
	ld e, a
	ld a, [wStringBuffer2 + 2]
	ld d, a
	call Function100f8d
	ld a, e
	ld [wStringBuffer2 + 1], a
	ld a, d
	ld [wStringBuffer2 + 2], a
	ret

Function100f8d:
	push hl
	ld a, [wStringBuffer2 + 4]
	ld l, a
	ld a, [wStringBuffer2 + 5]
	ld h, a
	add hl, bc
	ld a, l
	ld [wStringBuffer2 + 4], a
	ld a, h
	ld [wStringBuffer2 + 5], a
	pop hl
	ld a, [wStringBuffer2 + 3]
	bit 7, a
	res 7, a
	jr z, .sram
	and a
	jr nz, .far_wram
	call CopyBytes
	ret

.far_wram
	and $7f
	call FarCopyWRAM
	ret

.sram
	call OpenSRAM
	call CopyBytes
	call CloseSRAM
	ret
