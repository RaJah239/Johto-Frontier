; A library included as part of the Mobile Adapter GB SDK.

setcharmap ascii

; Mobile Adapter protocol commands
DEF MOBILE_COMMAND_BEGIN_SESSION            EQU $10
DEF MOBILE_COMMAND_END_SESSION              EQU $11
DEF MOBILE_COMMAND_DIAL_TELEPHONE           EQU $12
DEF MOBILE_COMMAND_HANG_UP_TELEPHONE        EQU $13
DEF MOBILE_COMMAND_TRANSFER_DATA            EQU $15
DEF MOBILE_COMMAND_TELEPHONE_STATUS         EQU $17
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

MobileSDK_CopyString:
; Copy bytes from hl to de until a 0 is encountered.
; Include the 0 in the copy, and count the number of
; nonzero bytes copied.  Keep the de pointer at the
; copied zero.
.loop
	ld a, [hli]
	ld [de], a
	or a
	ret z
	inc de
	inc bc
	jr .loop

MobileSDK_CopyStringLen:
; Copy bytes from hl to de until a 0 is encountered,
; or a bytes have been copied, whichever comes first.
; Add the byte count to the count previously stored
; in bc.
	push bc
	ld c, $0
	ld b, a
	dec b
.loop
	ld a, [hli]
	ld [de], a
	or a
	jr z, .done
	inc de
	inc c
	dec b
	jr nz, .loop
	xor a
	ld [de], a

.done
	ld a, c
	pop bc
	add c
	ld c, a
	ld a, b
	adc 0
	ld b, a
	ret

ResetReceivePacketBuffer:
; Clear two bytes at wMobileSDK_ReceivedBytes
	xor a
	ld hl, wMobileSDK_ReceivedBytes
	ld [hli], a
	ld [hl], a
	ret

Function1100b4:
	push bc
.loop
	di
	ld a, [wc800]
	ld b, a
	ld a, [wc80b]
	ld c, a
	ld a, [wc822]
	ei
	or a
	bit 0, a
	jr z, .done
	ld a, b
	or a
	jr nz, .loop
	ld a, c
	cp $4
	jr z, .loop
	xor a
	ld [wc80f], a
	ld hl, wc821
	set 1, [hl]
	scf
.done
	pop bc
	ret

Function110226:
	ld a, $21
	ld [wc80f], a
	ld hl, wc821
	set 1, [hl]
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

Function111686:
	xor a
	ldh [rTAC], a
	ld c, LOW(rIE)
	ldh a, [c]
	and ~(1 << SERIAL | 1 << TIMER)
	ldh [c], a
	ld a, [wMobileSDK_PacketBuffer + 1]
	ld [wc86a], a
	ld a, [wMobileSDK_PacketBuffer]
	ld c, a
	ld hl, wc821
	ld a, [hl]
	or c
	ld [hl], a
	ret

Function1116a0:
	ld a, $1
	jr Function1116a9

Function1116a4:
	set 1, [hl]
	ld a, [wc86a]

Function1116a9:
	ld [wMobileSDK_PacketBuffer + 1], a
	ld hl, wc815
	xor a
	ld [hli], a
	ld a, [wc81f]
	rla
	ld [hl], a
	ld hl, wc821
	ld a, [hl]
	ld b, a
	and $d
	ld [hl], a
	ld a, $2
	and b
	ld [wMobileSDK_PacketBuffer], a
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

_Timer:: ; herenext
	call Function11214e
	jmp z, Function111b21
	call Function111f97
	call Function111686
	call Function111f02
	jmp Function111b3b
	jr z, Function111ab9
	jr z, Function111abd


asm_111a40:
	ld a, $4b

Function111a42:
	ldh [rSB], a
	jmp Function111b2e

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
	jmp Function111b3b

Function111ab9:
	ld a, $80
	jr Function111a42

Function111abd:
	ld a, [wc814]
	or a
	jr nz, .asm_111acb
	ld a, [wMobileSDK_ReceivePacketBuffer]
	xor $80
	jmp Function111a42
.asm_111acb
	ld hl, wc819
	inc [hl]
	ld a, $3
	cp [hl]
	jr z, .asm_111afe
	call ResetReceivePacketBuffer
	ld a, $3
	ld [wc800], a
	xor a
	ld hl, wc80a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ld hl, wc815
	ld a, [wc820]
	ld [hli], a
	ld a, [wc81f]
	ld [hli], a
	ld a, [wc822]
	bit 0, a
	jr z, .asm_111af9
	ld a, $b
	jr .asm_111afb
.asm_111af9
	ld a, $20
.asm_111afb
	ld [hli], a
	jr .asm_111b1c
.asm_111afe
	ld hl, wc806
	xor a
	ld [hli], a
	ld [wc800], a
	ld a, $6
	ld [hl], a
	ld hl, wc821
	set 1, [hl]
	ld a, $15
	ld [wc80f], a
	ld a, $2
	ld [wc810], a
	xor a
	ld [wc810 + 1], a
.asm_111b1c
	ld a, $f1
	jmp Function111a42

Function111b21:
	ld hl, wc803
	ld a, [hli]
	ld e, a
	ld d, [hl]
	ld a, [de]
	ldh [rSB], a
	inc de
	ld a, d
	ld [hld], a
	ld [hl], e

Function111b2e:
	ld hl, wc822
	set 1, [hl]
	ld a, (0 << rSC_ON) | (1 << rSC_CGB) | (1 << rSC_CLOCK)
	ldh [rSC], a
	ld a, (1 << rSC_ON) | (1 << rSC_CGB) | (1 << rSC_CLOCK)
	ldh [rSC], a

Function111b3b:
	ret

PacketSendEmptyBody:
	ld de, 10

Function111f02:
	ld [wMobileSDK_SendCommandID], a
	ld b, $5

PacketSendBytes:
; hl = bytes
; de = size
; b = ?
	call Function1100b4
	ret c
	ld a, [wc800]
	cp $0
	jr z, .asm_111f17
	call Function110226
	scf
	ret
.asm_111f17
	ldh a, [rSC]
	and 1 << rSC_ON
	jr nz, .asm_111f17
	di
	ld a, [wMobileSDK_SendCommandID]
	cp $ff
	jr z, .asm_111f35
	ld a, l
	ld [wc81c], a
	ld a, h
	ld [wc81d], a
	ld a, e
	ld [wc81a], a
	ld a, d
	ld [wc81b], a
.asm_111f35
	ld a, e
	ld [wc801], a
	ld a, d
	ld [wc802], a
	ld a, l
	ld [wc803], a
	ld a, h
	ld [wc804], a
	ld hl, wc807
	ld a, [hl]
	cp b
	jr z, .asm_111f4f
	ld [wc805], a
.asm_111f4f
	ld a, b
	ld [wc807], a
	xor a
	ld [wc806], a
	ld a, $1
	ld [wc800], a
	ld hl, wc822
	set 5, [hl]
	reti

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

Function111f97:
	ld hl, wc822
	bit 0, [hl]
	ret nz
	ld a, [wc807]
	cp $2
	jr c, .done
	cp $5
	jr z, .done
	cp $6
	jr nz, .hang_up
	ld a, [wc80f]
	cp $22
	jr z, .done
	cp $23
	jr z, .done
	cp $26
	jr z, .done
	swap a
	and $f
	cp $1
	jr z, .done
	cp $0
	jr z, .done
	cp $8
	jr nz, .hang_up
.done
	scf
	ret
.hang_up
	ld b, $5
	ld hl, wMobileSDK_SendCommandID
	ld a, [hl]
	cp -1
	jr z, .begin_session
	ld a, MOBILE_COMMAND_TELEPHONE_STATUS | $80
	ld [hl], a
	ld hl, MobilePacket_TelephoneStatus
	ld de, MobilePacket_TelephoneStatus.End - MobilePacket_TelephoneStatus
	call PacketSendBytes
	ld hl, wc822
	set 0, [hl]
	ret
.begin_session
	ld hl, MobilePacket_BeginSession
	ld de, MobilePacket_BeginSession.End - MobilePacket_BeginSession
	jmp PacketSendBytes

	ds 14

MobilePacket_BeginSession:
	db $99, $66, MOBILE_COMMAND_BEGIN_SESSION, $00, $00, $08, "NINTENDO", $02, $77, $80, $00
.End

MobilePacket_EndSession:
	db $99, $66, MOBILE_COMMAND_END_SESSION, $00, $00, $00, $00, $11, $80, $00
.End

MobilePacket_TelephoneStatus:
	db $99, $66, MOBILE_COMMAND_TELEPHONE_STATUS, $00, $00, $00, $00, $17, $80, $00
.End

MobilePacket_ReadConfigurationDataPart1:
	db $99, $66, MOBILE_COMMAND_READ_CONFIGURATION_DATA, $00, $00, $02, $00, $60, $00, $7b, $80, $00
.End

MobilePacket_ReadConfigurationDataPart2:
	db $99, $66, MOBILE_COMMAND_READ_CONFIGURATION_DATA, $00, $00, $02, $60, $60, $00, $db, $80, $00
.End

MobilePacket_CloseTCPConnection:
	db $99, $66, MOBILE_COMMAND_CLOSE_TCP_CONNECTION, $00, $00, $01
.End

Function11214e: ; here
	dw Function112969
	dw Function112a56
	dw Function112b71
	dw Function112bec
	dw Function112bbb
	dw Function1134cb
	dw Function113519
	dw Function113e42
	dw Function113ef2
	dw Function113f2d
	dw Function113672
	dw Function113626

Function112251:
	xor a
	ld [wc821], a
	ld [wc807], a
	inc a
	ld [wc86a], a
	ret

Function11225d:
	ld [wc80f], a
	ld a, $5
	ld [wc86a], a
	ld hl, wc821
	ret

Mobile_EndSession:
	ld a, MOBILE_COMMAND_END_SESSION | $80
	ld hl, MobilePacket_EndSession
	jmp PacketSendEmptyBody

Function11234b:
	ld a, [wMobileSDK_PacketBuffer + 5]
	add $a
	ld e, a
	ld d, 0
	ld hl, wMobileSDK_PacketBuffer
	ld a, b
	jmp Function111f02

Function11236b:
	ld a, $99
	ld de, $000c
	jmp Function111f02

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

Function1127c5:
	ld de, $000b
	ld a, $95
	jmp Function111f02

Function1127e1:
	call Function112807
	ld hl, wc832

Function1127e7:
	ld a, [hli]
	cp $d
	ret nz
	ld a, [hl]
	cp $a
	ret nz
	ld a, $20
	ld [hl], a
	ret

Function1127f3:
	call Function112807
	ld hl, wc82f
	ld a, [hli]
	cp $d
	ret nz
	ld a, [hli]
	cp $a
	ret nz
	ld a, [hli]
	cp $2e
	ret nz
	jr Function1127e7

Function112807:
	push bc
	push de
	ld hl, wMobileSDK_ReceivePacketBuffer + 3
	ld a, [hl]
	dec a
	jr z, .asm_11282d
	ld c, a
	cp $5
	jr nc, .asm_112830
	ld a, $5
	sub c
	ld b, a
	ld e, c
	ld d, $0
	ld hl, wc82f
	add hl, de
	ld de, wc82f
	call MobileSDK_CopyBytes
	ld hl, wMobileSDK_ReceivePacketBuffer + 5
	ld b, c
.asm_11282a
	call MobileSDK_CopyBytes

.asm_11282d
	pop de
	pop bc
	ret

.asm_112830
	sub $5
	ld c, a
	ld b, 0
	ld hl, wMobileSDK_ReceivePacketBuffer + 5
	add hl, bc
	ld b, $5
	ld de, wc82f
	jr .asm_11282a

Function1128d3:
	ld hl, wc821
	res 0, [hl]
	res 2, [hl]
	ret

Function112969:
	dec a
	jr z, .asm_112970
	dec a
	jr z, .asm_112989
	ret

.asm_112970
	ld a, [wMobileSDK_ReceivePacketBuffer]
	cp $9f
	jr z, .asm_112986
	call Function1127e1
	jr z, .asm_112986
	ld hl, wc86b
	dec [hl]
	ld hl, wMobileSDK_PacketBuffer + 32
	jmp Function1127c5

.asm_112986
	jmp Function112430

.asm_112989
	xor a
	ld [wc86d], a
	ld a, $2
	ld [wc86a], a
	ld hl, wc821
	res 0, [hl]
	res 7, [hl]
	set 5, [hl]
	ret

Function112a2c:
	ld hl, wc821
	set 1, [hl]
	res 0, [hl]
	ld hl, wc80f
	ld a, $31
	ld [hli], a
	ld a, e
	ld [hli], a
	ld [hl], d
	ld a, $5
	ld [wc86a], a
	ret

Function112a42:
	ld hl, wc810
	xor a
	ld [hli], a
	ld [hl], a
	xor a
	ld [wc86d], a
	ld a, $31
	call Function11225d
	set 1, [hl]
	res 0, [hl]
	ret

Function112a56:
	dec a
	jr z, .asm_112a5a
	ret

.asm_112a5a
	call Function1127e1
	jr nz, .asm_112a95
	ld hl, wc880
	ld a, [hli]
	cp $2b
	jr nz, .asm_112aa6
.asm_112a67
	ld a, [hli]
	cp $20
	jr nz, .asm_112a67
	call Function112aac
	ld a, [wc86e]
	ld c, a
	ld a, [wc86e + 1]
	ld b, a
	ld a, e
	ld [bc], a
	inc bc
	ld a, d
	ld [bc], a
	call Function112aac
	ld hl, wc86e
	ld a, [hli]
	ld h, [hl]
	ld l, a
	inc hl
	inc hl
	ld a, e
	ld [hli], a
	ld a, d
	ld [hli], a
	ld a, c
	ld [hli], a
	ld a, $4
	ld [wc86a], a
	jmp Function1128d3

.asm_112a95
	ld a, [wMobileSDK_ReceivePacketBuffer]
	cp $9f
	jr z, Function112a42
	ld hl, wc86b
	dec [hl]
	ld hl, wMobileSDK_PacketBuffer + 128
	jmp Function1127c5

.asm_112aa6
	ld de, $0005
	jr Function112a2c

Function112aac:
	ld a, [wc872]
	push af
	ld a, [wc873]
	push af
	ld a, [wc874]
	push af
	ld bc, 0
	ld de, 0
.asm_112abe
	ld a, [hli]
	cp $d
	jr z, .asm_112b04
	cp $20
	jr z, .asm_112b04
	and $f
	ld b, a
	sla e
	rl d
	rl c
	ld a, e
	ld [wc872], a
	ld a, d
	ld [wc873], a
	ld a, c
	ld [wc874], a
	sla e
	rl d
	rl c
	sla e
	rl d
	rl c
	ld a, [wc872]
	add e
	ld e, a
	ld a, [wc873]
	adc d
	ld d, a
	ld a, [wc874]
	adc c
	ld c, a
	ld a, b
	add e
	ld e, a
	ld a, $0
	adc d
	ld d, a
	ld a, $0
	adc c
	ld c, a
	jr .asm_112abe

.asm_112b04
	pop af
	ld [wc874], a
	pop af
	ld [wc873], a
	pop af
	ld [wc872], a
	ret

Function112b71:
	dec a
	jr z, .asm_112b75
	ret

.asm_112b75
	call Function1127e1
	jr nz, .asm_112ba3
	ld hl, wc880
	ld a, [hli]
	cp $2b
	jr nz, .asm_112bb5
.asm_112b82
	ld a, [hli]
	cp $20
	jr nz, .asm_112b82
.asm_112b87
	ld a, [hli]
	cp $20
	jr nz, .asm_112b87
	call Function112aac
	ld hl, wc86e
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, e
	ld [hli], a
	ld a, d
	ld [hli], a
	ld a, c
	ld [hli], a
	ld a, $4
	ld [wc86a], a
	jmp Function1128d3

.asm_112ba3
	ld a, [wMobileSDK_ReceivePacketBuffer]
	cp $9f
	jmp z, Function112a42
	ld hl, wc86b
	dec [hl]
	ld hl, wMobileSDK_PacketBuffer + 128
	jmp Function1127c5

.asm_112bb5
	ld de, $0004
	jmp Function112a2c

Function112bbb:
	dec a
	jr z, .asm_112bbf
	ret

.asm_112bbf
	call Function1127e1
	jr nz, .asm_112bd4
	ld hl, wc880
	ld a, [hli]
	cp $2b
	jr nz, .asm_112be6
	ld a, $4
	ld [wc86a], a
	jmp Function1128d3

.asm_112bd4
	ld a, [wMobileSDK_ReceivePacketBuffer]
	cp $9f
	jmp z, Function112a42
	ld hl, wc86b
	dec [hl]
	ld hl, wMobileSDK_PacketBuffer + 128
	jmp Function1127c5

.asm_112be6
	ld de, $0004
	jmp Function112a2c

Function112bec:
	dec a
	jr z, .asm_112bf7
	dec a
	jmp z, .asm_112cdb
	dec a
	ret nz
	dec [hl]
	ret

.asm_112bf7
	ld a, [wc880]
	cp $2d
	jr nz, .asm_112c03
	call Function1127e1
	jr z, .asm_112c0b

.asm_112c03
	ld a, [wc821]
	bit 2, a
	jmp z, .asm_112cef

.asm_112c0b
	ld hl, wc86b
	inc [hl]
	ld hl, wc880
	ld a, [hli]
	cp $2b
	jmp nz, Function112d20
	ld b, $7f
.asm_112c1a
	ld a, [hli]
	dec b
	cp $a
	jr nz, .asm_112c1a
	push hl
	ld hl, wc98f
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	ld a, b
	ld [wc82d], a
	ld a, [hli]
	ld h, [hl]
	sub b
	ld l, a
	ld a, h
	sbc $0
	ld h, a
	jr nc, .asm_112c56
	cp $ff
	jr nz, .asm_112c56
	ld hl, wc991
	ld a, [hli]
	ld c, a
	inc hl
	ld a, b
	sub c
	ld [hli], a
	ld a, [wc82b]
	ld [hl], a
	ld hl, wc827
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, c
	ld [hli], a
	xor a
	ld [hl], a
	pop hl
	ld b, c
	jmp MobileSDK_CopyBytes

.asm_112c56
	ld [wc993], a
	ld a, [wc82b]
	ld c, a
	ld [wc994], a
	push hl
	ld a, l
	sub c
	ld l, a
	ld a, h
	sbc $0
	ld h, a
	jr nc, .asm_112c9f
	cp $ff
	jr nz, .asm_112c9f
	ld a, c
	ld [wMobileSDK_ReceivePacketBuffer + 1], a
	ld a, [wMobileSDK_ReceivePacketBuffer + 3]
	sub c
	pop hl
	ld c, l
	pop hl
	push af
	call MobileSDK_CopyBytes
	pop af
	push de
	ld hl, wMobileSDK_ReceivePacketBuffer + 4
	ld e, a
	ld d, 0
	add hl, de
	pop de
	ld b, c
	call MobileSDK_CopyBytes
	ld a, [wMobileSDK_ReceivePacketBuffer + 1]
	sub c
	ld [wc994], a
	ld hl, wc827
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wc991]
	ld [hli], a
	xor a
	ld [hl], a
	ret

.asm_112c9f
	ld [wc994], a
	ld a, l
	ld [wc82b], a
	ld a, h
	ld [wc82c], a
	pop hl
	pop hl
	call MobileSDK_CopyBytes
	ld a, [wMobileSDK_ReceivePacketBuffer + 3]
	sub c
	push de
	ld hl, wMobileSDK_ReceivePacketBuffer + 4
	ld e, a
	ld d, 0
	add hl, de
	pop de
	ld b, c
	call MobileSDK_CopyBytes
	ld a, [wc82d]
	add c
	ld [wc82d], a
	ld a, [wc82e]
	adc 0
	ld [wc82e], a
	ld hl, wc829
	ld a, e
	ld [hli], a
	ld a, d
	ld [hl], a
	ld hl, wc821
	res 2, [hl]

.asm_112cdb
	ld a, [wc821]
	bit 2, a
	jr z, .asm_112cea
	ld a, $2
	ld [wc86b], a
	jr .asm_112d09

.asm_112cea
	call Function1127f3
	jr z, .asm_112d01

.asm_112cef
	ld a, [wMobileSDK_ReceivePacketBuffer]
	cp $9f
	jmp z, Function112a42
	ld hl, wc86b
	dec [hl]
	ld hl, wMobileSDK_PacketBuffer + 128
	jmp Function1127c5

.asm_112d01
	ld a, $4
	ld [wc86a], a
	call Function1128d3

.asm_112d09
	ld a, [wc86e]
	ld l, a
	ld a, [wc86e + 1]
	or l
	ret z
	ld hl, wc827
	ld a, [hli]
	ld e, a
	ld d, [hl]
	ld hl, wc82d
	ld b, $2
	jmp MobileSDK_CopyBytes

Function112d20:
	ld a, [wc86a]
	cp $1a
	jr nz, .asm_112d2d
	ld de, $0004
	jmp Function112a2c

.asm_112d2d
	ld de, $0004
	jmp Function112a2c

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

Function1134cb:
	dec a
	jr z, .asm_1134d9
	dec a
	jr z, .asm_1134f4
	dec a
	jr z, .asm_1134fc
	dec a
	jr z, .asm_11350e
	dec [hl]
	ret

.asm_1134d9
	ld a, [wMobileSDK_ReceivePacketBuffer + 4]
	cp $0
	jr z, .asm_1134f0
	cp $ff
	jr z, .asm_1134f0
	ld a, [wc985]
	ld [wc86a], a
	ld hl, wc821
	res 0, [hl]
	ret

.asm_1134f0
	inc [hl]
	inc [hl]
	jr .asm_1134fc

.asm_1134f4
	ld a, MOBILE_COMMAND_TELEPHONE_STATUS | $80
	ld hl, MobilePacket_TelephoneStatus
	jmp PacketSendEmptyBody

.asm_1134fc
	ld hl, wc86e
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wMobileSDK_ReceivePacketBuffer + 6]
	cp $f0
	jr c, .asm_11350b
	set 7, [hl]

.asm_11350b
	jmp Mobile_EndSession

.asm_11350e
	ld a, [wc86a]
	cp $1e
	jmp nz, Function112251
	jmp Function1116a0

Function113519:
	dec a
	jr z, .asm_113527
	dec a
	jr z, .asm_11352d
	dec a
	jr z, .asm_11353c
	dec a
	jr z, .asm_11353f
	dec [hl]
	ret

.asm_113527
	ld hl, MobilePacket_ReadConfigurationDataPart1
	jmp Function11236b

.asm_11352d
	ld hl, wc829
	ld a, LOW(wc8ca + 22)
	ld [hli], a
	ld a, HIGH(wc8ca + 22)
	ld [hli], a
	ld hl, MobilePacket_ReadConfigurationDataPart2
	jmp Function11236b

.asm_11353c
	jmp Mobile_EndSession

.asm_11353f
	ld hl, wc880
	ld a, [hli]
	cp "M"
	jr nz, .asm_113586
	ld a, [hld]
	cp "A"
	jr nz, .asm_113586
	ld b, $be
	ld de, 0
.asm_113551
	ld a, [hli]
	add e
	ld e, a
	ld a, $0
	adc d
	ld d, a
	dec b
	jr nz, .asm_113551
	ld a, [hli]
	cp d
	jr nz, .asm_11358a
	ld a, [hl]
	cp e
	jr nz, .asm_11358a
	ld a, [wc86e]
	ld e, a
	ld a, [wc86e + 1]
	ld d, a
	ld hl, .asm_11357e
	push hl
	ld a, [wc86a]
	cp $25
	jr z, Function1135ba
	cp $26
	jr z, Function11359d
	cp $27
	jr z, Function1135ad
.asm_11357e
	ld a, $1
	ld [wc835], a
	jmp Function1116a0

.asm_113586
	ld a, $25
	jr .asm_11358c

.asm_11358a
	ld a, $14

.asm_11358c
	call Function11225d
	jmp Function1116a4

Function113592:
	push de
	ld l, e
	ld h, d
	xor a
	ld [hl], a
	inc de
	call MobileSDK_CopyBytes
	pop de
	ret

Function11359d:
	ld b, $20
	call Function113592
	ld a, $21
	ld hl, wc88c
	call MobileSDK_CopyStringLen
	xor a
	ld [de], a
	ret

Function1135ad:
	ld b, $1e
	call Function113592
	ld a, $1f
	ld hl, wc8ac
	jmp MobileSDK_CopyStringLen

Function1135ba:
	ld b, $65
	call Function113592
	ld hl, wc8f6
	call Function1135eb
	ld a, $11
	ld hl, wc8fe
	call MobileSDK_CopyStringLen
	inc de
	ld hl, wc90e
	call Function1135eb
	ld a, $11
	ld hl, wc916
	call MobileSDK_CopyStringLen
	inc de
	ld hl, wc926
	call Function1135eb
	ld a, $11
	ld hl, wc92e
	jmp MobileSDK_CopyStringLen

Function1135eb:
	ld b, $8
.asm_1135ed
	ld a, [hl]
	swap a
	and $f
	cp $f
	jr z, .asm_11361c
	or $30
	cp $3a
	call z, Function113620
	cp $3b
	call z, Function113623
	ld [de], a
	inc de
	ld a, [hli]
	and $f
	cp $f
	jr z, .asm_11361c
	or $30
	cp $3a
	call z, Function113620
	cp $3b
	call z, Function113623
	ld [de], a
	inc de
	dec b
	jr nz, .asm_1135ed

.asm_11361c
	xor a
	ld [de], a
	inc de
	ret

Function113620:
	ld a, $23
	ret

Function113623:
	ld a, $2a
	ret

Function113626:
	dec a
	jr z, .asm_113634
	dec a
	jr z, .asm_113639
	dec a
	jr z, .asm_11366c
	dec a
	jr z, .asm_11366f
	dec [hl]
	ret

.asm_113634
	ld b, $9a
	jmp Function11234b

.asm_113639
	ld a, [wc882]
	or a
	jr nz, .asm_113642
	inc [hl]
	jr .asm_11366c

.asm_113642
	ld de, wMobileSDK_PacketBuffer + 5
	ld c, a
	inc a
	ld [de], a
	inc de
	ld a, $80
	ld [de], a
	inc de
	ld hl, wc880
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld b, c
	call MobileSDK_CopyBytes
	ld b, c
	inc b
	call Function111f63
	ld a, [wMobileSDK_PacketBuffer + 5]
	add $a
	ld e, a
	ld d, 0
	ld a, $9a
	ld hl, wMobileSDK_PacketBuffer
	jmp Function111f02

.asm_11366c
	jmp Mobile_EndSession

.asm_11366f
	jmp Function1116a0

Function113672:
	dec a
	jr z, .asm_113680
	dec a
	jr z, .asm_113686
	dec a
	jr z, .asm_1136bb
	dec a
	jr z, .asm_1136be
	dec [hl]
	ret

.asm_113680
	ld hl, wMobileSDK_PacketBuffer
	jmp Function11236b

.asm_113686
	ld a, [wc882]
	or a
	jr z, .asm_113693
	cp $81
	jr nc, .asm_113693
	inc [hl]
	jr .asm_1136bb

.asm_113693
	ld hl, wMobileSDK_PacketBuffer + 7
	sub $80
	ld [hld], a
	ld a, $80
	ld [hl], a
	ld de, wMobileSDK_PacketBuffer + 8
	ld b, $2
	call Function111f63
	ld hl, wc880
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, $0080
	add hl, de
	ld e, h
	ld a, l
	ld hl, wc829
	ld [hli], a
	ld [hl], e
	ld hl, wMobileSDK_PacketBuffer
	jmp Function11236b

.asm_1136bb
	jmp Mobile_EndSession

.asm_1136be
	jmp Function1116a0

Function113a40:
.asm_113a40
	or a
	push hl
	ld a, [hli]
	rla
	ld a, [hl]
	rla
	ld [hli], a
	ld a, [hl]
	rla
	ld [hli], a
	ld a, [hl]
	rla
	ld [hl], a
	pop hl
	ld a, [hl]
	rla
	ld [hl], a
	dec b
	jr nz, .asm_113a40
	ret

Function113e42:
	dec a
	jr z, .asm_113e4f
	dec a
	jr z, .asm_113e85
	dec a
	jr z, .asm_113ea8
	dec a
	jr z, .asm_113eb0
	ret

.asm_113e4f
	ld a, [wc807]
	cp $8
	jr nz, .asm_113e58
.asm_113e56
	dec [hl]
	ret

.asm_113e58
	xor a
	ld [wc86d], a
	ld a, $2
	ld [wc86a], a
	ld hl, wc821
	ld a, [hl]
	and $10
	set 5, a
	ld [hl], a
	jr Function113eb8

.asm_113e6d
	ld a, [wc86d]
	or a
	ld a, [wMobileSDK_ReceivePacketBuffer]
	jr z, .asm_113e81
	cp $9f
	jr z, .asm_113e85
	cp $a4
	jr z, .asm_113e85
.asm_113e7e
	jmp Function112430

.asm_113e81
	cp $a3
	jr z, .asm_113e7e

.asm_113e85
	xor a
	ld [wc86d], a
	ld [wMobileSDK_SendCommandID], a
	ld a, $2
	ld [wc86a], a
	ld a, $3
	ld [wc807], a
	ld hl, wc821
	ld a, [hl]
	and $10
	set 5, a
	ld [hl], a
	ld hl, wc822
	bit 0, [hl]
	call z, Function111f97
	ret

.asm_113ea8
	ld a, [wc807]
	cp $8
	jr z, .asm_113e56
	ret

.asm_113eb0
	ld a, $1
	ld [wc86b], a
	jr .asm_113e6d

Function113eb8:
	ld a, $ff
	ld [wMobileSDK_SendCommandID], a
	ld hl, wc822
	res 5, [hl]
	res 0, [hl]
	jmp Function111f97

Function113ef2:
	dec a
	jr z, .asm_113efa
	dec a
	jr z, .asm_113f03
	dec [hl]
	ret

.asm_113efa
	ld a, [wc807]
	cp $8
	jr nz, Function113eb8
	dec [hl]
	ret

.asm_113f03
	ld a, $26
	call Function11225d
	ld a, $2a
	ld [wc86a], a
	ld hl, wc820
	ld a, [hld]
	ld h, [hl]
	ld l, a
	ld e, l
	ld d, h
	add hl, de
	add hl, de
	ld e, l
	ld d, h
	ld hl, wc815
	ld e, a
	ld [hli], a
	ld a, d
	ld [hl], a
	xor a
	ld [wc800], a
	ld hl, wMobileSDK_PacketBuffer
	ld a, $2
	ld [hli], a
	dec a
	ld [hl], a
	ret

Function113f2d:
	dec a
	jr z, .asm_113f35
	dec a
	jr z, .asm_113f4f
	dec [hl]
	ret

.asm_113f35
	ld a, [wc807]
	cp $8
	jr nz, .asm_113f3e
	dec [hl]
	ret

.asm_113f3e
	xor a
	ld [wMobileSDK_ReceivePacketBuffer], a
	ld [wMobileSDK_ReceivePacketBufferAlt], a
	ld a, [wMobileSDK_SendCommandID]
	cp $91
	jr z, .asm_113f4f
	jr Function113eb8

.asm_113f4f
	xor a
	ld [wc86d], a
	ld hl, wc821
	set 0, [hl]
	ld hl, wc822
	xor a
	ld [hl], a
	xor a
	ld [wc80b], a
	xor a
	ld [wMobileSDK_PacketBuffer], a
	ld hl, wc820
	ld a, [hld]
	ld h, [hl]
	ld l, a
	ld e, l
	ld d, h
	add hl, de
	add hl, de
	ld e, l
	ld d, h
	ld hl, wc815
	ld e, a
	ld [hli], a
	ld a, d
	ld [hl], a
	xor a
	ld [wc800], a
	ld hl, wMobileSDK_PacketBuffer
	xor a
	ld [hli], a
	inc a
	ld [hl], a
	ret
