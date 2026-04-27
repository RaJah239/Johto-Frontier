; A library included as part of the Mobile Adapter GB SDK.

setcharmap ascii

; Mobile Adapter protocol commands
DEF MOBILE_COMMAND_HANG_UP_TELEPHONE        EQU $13
DEF MOBILE_COMMAND_READ_CONFIGURATION_DATA  EQU $19
DEF MOBILE_COMMAND_ISP_LOGOUT               EQU $22
DEF MOBILE_COMMAND_CLOSE_TCP_CONNECTION     EQU $24


SECTION "Mobile Adapter SDK", ROMX

MobileSDK_CopyBytes:
; Copy b bytes from hl to de
.loop
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .loop
	ret

Function111f02:
	ld [wMobileSDK_SendCommandID], a
	ld b, $5

Function111f63:
	push de
	ld hl, 0
	ld c, b
	xor a
	cp b
	jr z, .asm_111f71
.asm_111f6c
	call Function111f8d
	jr nz, .asm_111f6c

.asm_111f71
	ld b, $4
.asm_111f73
	call Function111f8d
	jr nz, .asm_111f73
	ld e, l
	ld d, h
	ld hl, $000a
	add hl, bc
	ld c, l
	ld b, h
	pop hl
	ld a, d
	ld [hli], a
	ld a, e
	ld [hli], a
	ld a, $80
	ld [hli], a
	xor a
	ld [hl], a
	ld e, c
	ld d, b
	ret

Function111f8d:
	dec de
	ld a, [de]
	add l
	ld l, a
	ld a, $0
	adc h
	ld h, a
	dec b
	ret

MobilePacket_CloseTCPConnection:
	db $99, $66, MOBILE_COMMAND_CLOSE_TCP_CONNECTION, $00, $00, $01
.End

Function112430:
	ld a, $3
	ld [wc807], a
	ld de, wMobileSDK_PacketBuffer
	ld hl, MobilePacket_CloseTCPConnection
	ld b, MobilePacket_CloseTCPConnection.End - MobilePacket_CloseTCPConnection
	call MobileSDK_CopyBytes
	ld a, [wc86c]
	ld [de], a
	inc de
	inc b
	call Function111f63
	ld a, $a4
	ld hl, wMobileSDK_PacketBuffer
	jmp Function111f02

Function113072:
	call Function113268
	jr nc, Function113089
	ld a, [wMobileSDK_ReceivePacketBuffer]
	cp $9f
	jmp nz, Function1131a9
	push hl
	ld hl, wc990
	res 2, [hl]
	pop hl
	jr Function113095

Function113089:
	ld a, [hl]
	cp $d
	jr z, .asm_113094
	cp $a
	jr z, Function113095
	jr Function113072

.asm_113094
	inc hl

Function113095:
	inc hl
	push bc
	ld a, [wc872]
	ld b, a
	ld a, [wc873]
	or b
	pop bc
	jr z, .asm_1130b3
	ld a, [wc86a]
	cp $23
	jr z, .asm_1130b3
	cp $20
	jr z, .asm_1130b3
	cp $22
	jr z, .asm_1130b3
	jr .asm_1130d6

.asm_1130b3
	xor a
	ld hl, wc86e
	ld [hli], a
	ld [hl], a
	ld hl, wc821
	res 2, [hl]
	ld a, [wc86a]
	cp $13
	jr z, .asm_1130c8
	cp $14
	ret nz

.asm_1130c8
	ld a, $6
	ld [wc86b], a
	ld a, [wMobileSDK_ReceivePacketBuffer]
	cp $9f
	ret z
	jmp Function112430

.asm_1130d6
	ld a, [wc82b]
	ld c, a
	dec b
	dec b
	ld a, b
	ld [wc82d], a
	jr z, .asm_11310d
	ld a, [wc873]
	ld d, a
	ld a, [wc872]
	ld e, a
	dec de
	dec de
	xor a
	or d
	jr nz, .asm_1130f5
	ld a, e
	cp b
	jmp c, Function113206

.asm_1130f5
	ld a, e
	sub b
	ld [wc82b], a
	ld a, d
	sbc $0
	ld [wc82c], a
	ld a, [wc874]
	ld e, a
	ld a, [wc875]
	ld d, a
	inc de
	inc de
	call MobileSDK_CopyBytes

.asm_11310d
	ld a, [wMobileSDK_ReceivePacketBuffer]
	cp $9f
	jr z, .asm_113150
	ld a, [wMobileSDK_ReceivePacketBuffer + 3]
	or a
	jr z, .asm_113150
	ld l, c
	sub c
	ld c, a
	ld a, l
	ld hl, wMobileSDK_ReceivePacketBuffer + 4
	add hl, bc
	ld b, a
	push de
	ld a, [wc82b]
	ld e, a
	ld a, [wc82c]
	ld d, a
	xor a
	or d
	jr nz, .asm_113135
	ld a, e
	cp b
	jmp c, Function113245

.asm_113135
	pop de
	push hl
	ld hl, wc82d
	ld a, [hl]
	add b
	ld [hli], a
	ld a, [hl]
	adc 0
	ld [hl], a
	ld c, b
	pop hl
	call MobileSDK_CopyBytes
	ld hl, wc82b
	ld a, [hl]
	sub c
	ld [hli], a
	ld a, [hl]
	sbc $0
	ld [hl], a

.asm_113150
	ld hl, wc829
	ld a, e
	ld [hli], a
	ld a, d
	ld [hl], a
	ld hl, wc821
	res 2, [hl]
	ld a, $1
	ld [wc86b], a
	ld a, $2
	ld [wc989], a
	ret

Function1131a9:
	ld hl, wc979
	ld de, wc880
	ld b, $0
	ld c, b
	ld a, [hl]
	cp $a
	jr z, .asm_1131c4
.asm_1131b7
	ld a, [hld]
	inc b
	cp $a
	jr nz, .asm_1131b7
	inc hl
	inc hl
	dec b
	ld c, b
	call MobileSDK_CopyBytes

.asm_1131c4
	ld a, [wc82b]
	ld b, a
	add c
	ld c, a
	push bc
	ld a, $ff
	sub b
	ld c, a
	ld b, 0
	ld hl, wMobileSDK_ReceivePacketBuffer + 4
	add hl, bc
	pop bc
	call MobileSDK_CopyBytes
	ld a, c
	ld [wc82d], a
	ld a, $fa
	sub c
	ld [wc82b], a
	ld hl, wc829
	ld a, e
	ld [hli], a
	ld a, d
	ld [hl], a
	ld l, e
	ld h, d
	ld de, wc97a
.asm_1131ef
	xor a
	ld [hli], a
	ld a, l
	cp e
	jr nz, .asm_1131ef
	ld a, d
	cp h
	jr nz, .asm_1131ef
	ld hl, wc821
	res 2, [hl]
	ld hl, wc86b
	dec [hl]
	dec [hl]
	ld a, $4
	ret

Function113206:
	ld a, b
	sub e
	ld [wc991], a
	ld a, [wc821]
	bit 2, a
	ld a, c
	jr nz, .asm_113214
	xor a

.asm_113214
	ld [wc992], a
	ld b, e
	ld c, e
	ld a, [wc874]
	ld e, a
	ld a, [wc875]
	ld d, a
	inc de
	inc de
	call MobileSDK_CopyBytes
	ld a, [wc991]
	ld [wc993], a
	ld b, a
	ld de, wc880
	call MobileSDK_CopyBytes
	ld hl, wc82d
	ld a, c
	ld [hli], a
	xor a
	ld [hl], a
	ld hl, wc821
	set 2, [hl]
	ld a, $3
	ld [wc86b], a
	ret

Function113245:
	ld a, b
	sub e
	ld [wc992], a
	ld [wc82b], a
	ld b, e
	ld c, e
	pop de
	call MobileSDK_CopyBytes
	ld hl, wc82d
	ld a, c
	add [hl]
	ld [hli], a
	ld a, $0
	adc [hl]
	ld [hl], a
	ld hl, wc821
	set 2, [hl]
	ld a, $3
	ld [wc86b], a
	ret

Function113268:
.asm_113268
	dec b
	ld a, [hli]
	cp $a
	ret z
	xor a
	or b
	jr nz, .asm_113268
	scf
	ret
