; A library included as part of the Mobile Adapter GB SDK.

setcharmap ascii

; Mobile Adapter protocol commands
DEF MOBILE_COMMAND_BEGIN_SESSION            EQU $10
DEF MOBILE_COMMAND_DIAL_TELEPHONE           EQU $12
DEF MOBILE_COMMAND_HANG_UP_TELEPHONE        EQU $13
DEF MOBILE_COMMAND_TRANSFER_DATA            EQU $15
DEF MOBILE_COMMAND_READ_CONFIGURATION_DATA  EQU $19
DEF MOBILE_COMMAND_TRANSFER_DATA_END        EQU $1f
DEF MOBILE_COMMAND_ISP_LOGOUT               EQU $22
DEF MOBILE_COMMAND_OPEN_TCP_CONNECTION      EQU $23
DEF MOBILE_COMMAND_CLOSE_TCP_CONNECTION     EQU $24
DEF MOBILE_COMMAND_DNS_QUERY                EQU $28
DEF MOBILE_COMMAND_ERROR                    EQU $6e


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

ResetReceivePacketBuffer:
; Clear two bytes at wMobileSDK_ReceivedBytes
	xor a
	ld hl, wMobileSDK_ReceivedBytes
	ld [hli], a
	ld [hl], a
	ret

Function11164f:
	ld hl, wc815
	xor a
	ld [hli], a
	ld a, [wc81f]
	ld b, a
	ld a, [wMobileSDK_AdapterType]
	ld a, b
	srl a
	srl a
	add b
	add b
	ld [hl], a
	ret

Function111664:
	ld hl, wMobileSDK_ReceivedBytes
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	ld a, [wMobileSDK_SendCommandID]
	cp $ff
	jr z, .asm_111679
	ld a, [wc822]
	bit 0, a
	jr z, .asm_11167c
.asm_111679
	ld hl, wMobileSDK_ReceivePacketBufferAlt
.asm_11167c
	add hl, de
	ld [hl], c
	inc de
	ld hl, wMobileSDK_ReceivedBytes
	ld a, e
	ld [hli], a
	ld [hl], d
	ret

_MobileReceive::
	ld a, [wc800]
	rrca
	jmp nc, Function1118bc
	rrca
	jmp c, Function1117e7
	ld hl, wc801
	ld a, [hli]
	ld d, [hl]
	ld e, a
	dec de
	ld a, d
	ld [hld], a
	ld a, e
	ld [hl], a
	cp $2
	jmp nc, Function1118bc
	ld a, d
	or a
	jmp nz, Function1118bc
	ld hl, wc808
	add hl, de
	ldh a, [rSB]
	ld [hl], a
	ld a, $8
	cp l
	jmp nz, Function1118bc
	ld a, [wMobileSDK_SendCommandID]
	cp $ff
	jr z, .asm_111716
	ld a, $f2
	cp [hl]
	jmp z, Function111796
	dec a
	cp [hl]
	jmp z, Function1117a0
	dec a
	cp [hl]
	jmp z, Function1117a0
	ld a, [wc807]
	cp $1
	jr nz, .asm_111716
	ld a, [wc806]
	or a
	jr z, .asm_111778
.asm_111716
	ld a, [wMobileSDK_SendCommandID]
	cp -1
	jr z, .asm_111730
	cp MOBILE_COMMAND_ERROR | $80
	jr z, .asm_111727
	cp MOBILE_COMMAND_TRANSFER_DATA_END | $80
	jr nz, .asm_111727
	ld a, MOBILE_COMMAND_TRANSFER_DATA | $80
.asm_111727
	cp [hl]
	jr nz, asm_11179a
	ld a, [wMobileSDK_AdapterType]
	or a
	jr z, .asm_111730
.asm_111730
	xor a
	ld [wc819], a
	ld a, $3
	ld [wc800], a
	xor a
	ld hl, wc80a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld hl, wc81f
	ld a, [hli]
	ld b, a
	ld a, [hl]
	ld hl, wc815
	ld [hli], a
	ld a, b
	ld [hli], a
	ld a, [wc822]
	bit 0, a
	jr z, .asm_111757
	ld a, $b
	jr .asm_111774
.asm_111757
	ld a, [wMobileSDK_SendCommandID]
	cp -1
	jr z, .asm_11176e
	cp MOBILE_COMMAND_DIAL_TELEPHONE | $80
	jr z, .asm_111772
	cp MOBILE_COMMAND_OPEN_TCP_CONNECTION | $80
	jr z, .asm_111772
	cp MOBILE_COMMAND_DNS_QUERY | $80
	jr z, .asm_111772
	ld a, $20
	jr .asm_111774
.asm_11176e
	ld a, $3
	jr .asm_111774
.asm_111772
	ld a, $60
.asm_111774
	ld [hl], a
	jmp Function1118bc
.asm_111778
	xor a
	ld [wc800], a
Function11177c:
	ld hl, wc820
	ld a, [hld]
	ld e, a
	ld a, [hl]
	dec a
	ld b, $3
.asm_111785
	or a
	rra
	rr e
	dec b
	jr nz, .asm_111785
	or a
	inc a
	ld hl, wc816
	ld [hld], a
	ld [hl], e
	jmp Function1118bc

Function111796:
	ld b, $a
	jr asm_1117a2
asm_11179a:
	xor a
	ld [hli], a
	ld [hl], a
	jmp Function1118bc

Function1117a0:
	ld b, $3
asm_1117a2:
	ld hl, wc822
	set 3, [hl]
	ld hl, wc815
	ld a, [wc820]
	ld [hli], a
	ld a, [wc81f]
	ld [hl], a
	xor a
	ld [wc800], a
	ld hl, wc819
	inc [hl]
	ld a, b
	cp [hl]
	jmp nc, Function1118bc
	xor a
	ld hl, wc806
	ld [hli], a
	ld [wc800], a
	ld a, $6
	ld [hl], a
	ld hl, wc821
	set 1, [hl]
	ld a, $15
	ld [wc80f], a
	ld hl, wc810
	ld a, [wc808]
	and $f
	cp $2
	jr nz, .asm_1117e1
	inc a
.asm_1117e1
	ld [hli], a
	xor a
	ld [hl], a
	jmp Function1118bc

Function1117e7:
	ld a, [wc80b]
	or a
	jr z, .asm_1117f8
	dec a
	jr z, Function11186e
	dec a
	jmp z, Function111884
	jmp Function111892
.asm_1117f8
	ld hl, wc80a
	ld a, [hl]
	or a
	jr nz, .asm_111803
	ld b, $99
	jr .asm_111805
.asm_111803
	ld b, $66
.asm_111805
	ldh a, [rSB]
	cp b
	jr z, .asm_111840
	cp $d2
	jr nz, .asm_111817
	xor a
	ld [wc9ae], a
.asm_111812
	xor a
	ld [hl], a
	jmp Function1118bc
.asm_111817
	ld a, [wc9ae]
	inc a
	ld [wc9ae], a
	cp $14
	jr c, .asm_111812
	ld a, $6
	ld [wc807], a
	ld a, $10
	ld [wc80f], a
	xor a
	ld [wc800], a
	ld hl, wc822
	res 0, [hl]
	ld hl, wc821
	ld a, [hl]
	set 1, a
	and $f
	ld [hl], a
	jr Function1118bc
.asm_111840
	inc [hl]
	ld a, $2
	cp [hl]
	jr nz, Function1118bc
	xor a
	ld [hli], a
	inc [hl]
	ld hl, wMobileSDK_PacketChecksum
	ld b, $3
.asm_11184e
	ld [hli], a
	dec b
	jr nz, .asm_11184e
	ld a, [wc822]
	bit 4, a
	jr z, .asm_111864
	ld b, a
	ld a, [wc821]
	bit 3, a
	jr nz, .asm_111864
	jmp Function11177c
.asm_111864
	ld a, [wc820]
	ld [hli], a
	ld a, [wc81f]
	ld [hl], a
	jr Function1118bc

Function11186e:
	call Function1118c2
	ld a, $4
	cp [hl]
	jr nz, Function1118bc
	xor a
	ld [hli], a
	ldh a, [rSB]
	ld [wc80c], a
	inc [hl]
	or a
	jr nz, Function1118bc
	inc [hl]
	jr Function1118bc

Function111884:
	call Function1118c2
	ld a, [wc80c]
	cp [hl]
	jr nz, Function1118bc
	xor a
	ld [hli], a
	inc [hl]
	jr Function1118bc

Function111892:
	ldh a, [rSB]
	ld c, a
	call Function111664
	ld hl, wc80a
	inc [hl]
	ld a, $2
	cp [hl]
	jr c, .asm_1118b4
	ld a, [wc80a]
	add $11
	ld e, a
	ld d, $c8
	ld a, [de]
	cp c
	jr z, Function1118bc
	ld a, $1
	ld [wc814], a
	jr Function1118bc
.asm_1118b4
	ld a, $4
	cp [hl]
	jr nz, Function1118bc
	xor a
	ld [hli], a
	inc [hl]
Function1118bc:
	ld hl, wc822
	res 1, [hl]
	ret

Function1118c2:
	ldh a, [rSB]
	ld c, a
	ld b, 0
	ld hl, wMobileSDK_PacketChecksum
	ld a, [hli]
	ld l, [hl]
	ld h, a
	add hl, bc
	ld a, h
	ld [wMobileSDK_PacketChecksum], a
	ld a, l
	ld [wMobileSDK_PacketChecksum + 1], a
	call Function111664
	ld hl, wc80a
	inc [hl]
	ret

asm_111a40:
	ld a, $4b

asm_111a47:
	ld hl, wc815
	dec [hl]
	jr nz, asm_111a40
	inc hl
	dec [hl]
	jr nz, asm_111a40
	inc hl
	dec [hl]
	jr z, .asm_111a63
	ld hl, wc81f
	ld a, [hli]
	ld d, a
	ld a, [hl]
	ld hl, wc815
	ld [hli], a
	ld a, d
	ld [hli], a
	jr asm_111a40
.asm_111a63
	di
	ld a, [wc86a]
	cp $2a
	jr z, .asm_111aa8
	ld hl, wc9b2
	inc [hl]
	ld a, [hl]
	cp $1
	jr z, .asm_111a91
	ld hl, wc822
	res 5, [hl]
	res 0, [hl]
	ld hl, wc821
	res 4, [hl]
	ld a, $0
	ld [wc805], a
	ld a, $29
	ld [wc86a], a
	ld a, $1
	ld [wc806], a
	jr .asm_111aa8
.asm_111a91
	ld a, $29
	ld [wc86a], a
	xor a
	ld [wc806], a
	ld [wc86b], a
	ld [wc80b], a
	ld [wc800], a
	ld a, $8
	ld [wc807], a
.asm_111aa8
	call ResetReceivePacketBuffer
	call Function11164f
	ld hl, wc822
	res 5, [hl]
	res 0, [hl]
	ei
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
