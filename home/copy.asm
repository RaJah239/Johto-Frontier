CopyBytes::
; copy bc bytes from hl to de
	inc b ; we bail the moment b hits 0, so include the last run
	inc c ; same thing; include last byte
	jr .HandleLoop
.CopyByte:
	ld a, [hli]
	ld [de], a
	inc de
.HandleLoop:
	dec c
	jr nz, .CopyByte
	dec b
	jr nz, .CopyByte
	ret

SwapBytes::
; swap bc bytes between hl and de
.Loop:
	; stash [hl] away on the stack
	ld a, [hl]
	push af

	; copy a byte from [de] to [hl]
	ld a, [de]
	ld [hli], a

	; retrieve the previous value of [hl]; put it in [de]
	pop af
	ld [de], a
	inc de

	; handle loop stuff
	dec bc
	ld a, b
	or c
	jr nz, .Loop
	ret

ByteFill::
; fill bc bytes with the value of a, starting at hl
; Writes 8 bytes per loop pass (about twice as fast as one byte per pass:
; map changes clear ~1800 bytes with this). Preserves de; returns a = value
; and bc = 0, like before.
	push de
	ld d, a
	ld a, c
	and %111
	ld e, a ; leftover bytes
	; bc /= 8
	srl b
	rr c
	srl b
	rr c
	srl b
	rr c
	ld a, d
	inc b ; we bail the moment b hits 0, so include the last run
	inc c ; same thing; include last block
	jr .HandleLoop
.Put8Bytes:
rept 8
	ld [hli], a
endr
.HandleLoop:
	dec c
	jr nz, .Put8Bytes
	dec b
	jr nz, .Put8Bytes
	inc e
	jr .HandleLeftover
.PutByte:
	ld [hli], a
.HandleLeftover:
	dec e
	jr nz, .PutByte
	pop de
	ret

GetFarByte::
; retrieve a single byte from a:hl, and return it in a.
	; bankswitch to new bank
	ldh [hTempBank], a
	ldh a, [hROMBank]
	push af
	ldh a, [hTempBank]
	rst Bankswitch

	; get byte from new bank
	ld a, [hl]
	ldh [hFarByte], a

	; bankswitch to previous bank
	pop af
	rst Bankswitch

	; return retrieved value in a
	ldh a, [hFarByte]
	ret

GetFarWord::
; retrieve a word from a:hl, and return it in hl.
	; bankswitch to new bank
	ldh [hTempBank], a
	ldh a, [hROMBank]
	push af
	ldh a, [hTempBank]
	rst Bankswitch

	; get word from new bank, put it in hl
	ld a, [hli]
	ld h, [hl]
	ld l, a

	; bankswitch to previous bank and return
	pop af
	rst Bankswitch
	ret

FarCopyColorWRAM::
 	ld a, BANK("GBC Video")
 	; fallthrough
FarCopyWRAM::
	ldh [hTempBank], a
	ldh a, [rSVBK]
	push af
	ldh a, [hTempBank]
	ldh [rSVBK], a

	call CopyBytes

	pop af
	ldh [rSVBK], a
	ret

GetFarWRAMByte::
	ldh [hTempBank], a
	ldh a, [rSVBK]
	push af
	ldh a, [hTempBank]
	ldh [rSVBK], a
	ld a, [hl]
	ldh [hFarByte], a
	pop af
	ldh [rSVBK], a
	ldh a, [hFarByte]
	ret
