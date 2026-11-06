ReadAndPrintLinkBattleRecord:
	call ClearTilemap
	call ClearSprites
	call .PrintBattleRecord
	hlcoord 0, 8
	ld b, NUM_LINK_BATTLE_RECORDS
	ld de, sLinkBattleRecord1Name
.loop
	push bc
	push hl
	push de
	ld a, [de]
	and a
	jr z, .PrintFormatString
	ld a, [wSavedAtLeastOnce]
	and a
	jr z, .PrintFormatString
	push hl
	push hl
	ld h, d
	ld l, e
	ld de, wLinkBattleRecordName
	ld bc, NAME_LENGTH - 1
	call CopyBytes
	ld a, "@"
	ld [de], a
	inc de ; wLinkBattleRecordWins
	ld bc, 6
	call CopyBytes
	ld de, wLinkBattleRecordName
	pop hl
	call PlaceString
	pop hl
	ld de, 26
	add hl, de
	push hl
	ld de, wLinkBattleRecordWins
	lb bc, 2, 4
	call PrintNum
	pop hl
	ld de, 5
	add hl, de
	push hl
	ld de, wLinkBattleRecordLosses
	lb bc, 2, 4
	call PrintNum
	pop hl
	ld de, 5
	add hl, de
	ld de, wLinkBattleRecordDraws
	lb bc, 2, 4
	call PrintNum
	jr .next

.PrintFormatString:
	ld de, .Format
	call PlaceString
.next
	pop hl
	ld bc, LINK_BATTLE_RECORD_LENGTH
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	ld bc, 2 * SCREEN_WIDTH
	add hl, bc
	pop bc
	dec b
	jr nz, .loop
	ret

.PrintBattleRecord:
	hlcoord 1, 0
	ld de, .Record
	call PlaceString

	hlcoord 0, 6
	ld de, .Result
	call PlaceString

	hlcoord 0, 2
	ld de, .Total
	call PlaceString

	hlcoord 6, 4
	ld de, sLinkBattleWins
	call .PrintZerosIfNoSaveFileExists
	ret c

	lb bc, 2, 4
	call PrintNum

	hlcoord 11, 4
	ld de, sLinkBattleLosses
	call .PrintZerosIfNoSaveFileExists

	lb bc, 2, 4
	call PrintNum

	hlcoord 16, 4
	ld de, sLinkBattleDraws
	call .PrintZerosIfNoSaveFileExists

	lb bc, 2, 4
	jmp PrintNum

.PrintZerosIfNoSaveFileExists:
	ld a, [wSavedAtLeastOnce]
	and a
	ret nz
	ld de, .Scores
	call PlaceString
	scf
	ret

.Scores:
	db "   0    0    0@"

.Format:
	db "  ---  <LF>"
	db "         -    -    -@"
.Record:
	db "<PLAYER>'s Record@"
.Result:
	db "Result Win Lose Draw@"
.Total:
	db "Total  Win Lose Draw@"

AddLastLinkBattleToLinkRecord:
	ld hl, wOTPlayerID
	ld de, wStringBuffer1
	ld bc, 2
	call CopyBytes
	ld hl, wOTPlayerName
	ld bc, NAME_LENGTH - 1
	call CopyBytes
	ld hl, sLinkBattleStats - (LINK_BATTLE_RECORD_LENGTH - 6)
	call .StoreResult
	ld hl, sLinkBattleRecord
	ld d, NUM_LINK_BATTLE_RECORDS
.loop
	push hl
	inc hl
	inc hl
	ld a, [hl]
	dec hl
	dec hl
	and a
	jr z, .copy
	push de
	ld bc, LINK_BATTLE_RECORD_LENGTH - 6
	ld de, wStringBuffer1
	call CompareBytesLong
	pop de
	pop hl
	jr c, .done
	ld bc, LINK_BATTLE_RECORD_LENGTH
	add hl, bc
	dec d
	jr nz, .loop
	ld bc, -LINK_BATTLE_RECORD_LENGTH
	add hl, bc
	push hl

.copy
	ld d, h
	ld e, l
	ld hl, wStringBuffer1
	ld bc, LINK_BATTLE_RECORD_LENGTH - 6
	call CopyBytes
	ld b, 6
	xor a
.loop2
	ld [de], a
	inc de
	dec b
	jr nz, .loop2
	pop hl

.done
	call .StoreResult
	jr .FindOpponentAndAppendRecord

.StoreResult:
	ld a, [wBattleResult]
	and $f
	cp LOSE
	ld bc, (sLinkBattleRecord1Wins - sLinkBattleRecord1) + 1
	jr c, .okay ; WIN
	ld bc, (sLinkBattleRecord1Losses - sLinkBattleRecord1) + 1
	jr z, .okay ; LOSE
	; DRAW
	ld bc, (sLinkBattleRecord1Draws - sLinkBattleRecord1) + 1
.okay
	add hl, bc
	call .CheckOverflow
	ret nc
	inc [hl]
	ret nz
	dec hl
	inc [hl]
	ret

.CheckOverflow:
	dec hl
	ld a, [hl]
	inc hl
	cp HIGH(MAX_LINK_RECORD)
	ret c
	ld a, [hl]
	cp LOW(MAX_LINK_RECORD)
	ret

.FindOpponentAndAppendRecord:
	ld b, NUM_LINK_BATTLE_RECORDS
	ld hl, sLinkBattleRecord1End - 1
	ld de, wLinkBattleRecordBuffer
.loop3
	push bc
	push de
	push hl
	call .LoadPointer
	pop hl
	ld a, e
	pop de
	ld [de], a
	inc de
	ld a, b
	ld [de], a
	inc de
	ld a, c
	ld [de], a
	inc de
	ld bc, LINK_BATTLE_RECORD_LENGTH
	add hl, bc
	pop bc
	dec b
	jr nz, .loop3
	ld b, $0
	ld c, $1
.loop4
	ld a, b
	add b
	add b
	ld e, a
	ld d, 0
	ld hl, wLinkBattleRecordBuffer
	add hl, de
	push hl
	ld a, c
	add c
	add c
	ld e, a
	ld d, 0
	ld hl, wLinkBattleRecordBuffer
	add hl, de
	ld d, h
	ld e, l
	pop hl
	push bc
	ld c, 3
	call CompareBytes
	pop bc
	jr z, .equal
	jr nc, .done2

.equal
	inc c
	ld a, c
	cp $5
	jr nz, .loop4
	inc b
	ld c, b
	inc c
	ld a, b
	cp $4
	jr nz, .loop4
	ret

.done2
	push bc
	ld a, b
	ld bc, LINK_BATTLE_RECORD_LENGTH
	ld hl, sLinkBattleRecord
	call AddNTimes
	push hl
	ld de, wLinkBattleRecordBuffer
	ld bc, LINK_BATTLE_RECORD_LENGTH
	call CopyBytes
	pop hl
	pop bc
	push hl
	ld a, c
	ld bc, LINK_BATTLE_RECORD_LENGTH
	ld hl, sLinkBattleRecord
	call AddNTimes
	pop de
	push hl
	ld bc, LINK_BATTLE_RECORD_LENGTH
	call CopyBytes
	ld hl, wLinkBattleRecordBuffer
	ld bc, LINK_BATTLE_RECORD_LENGTH
	pop de
	jmp CopyBytes

.LoadPointer:
	ld e, $0
	ld a, [hld]
	ld c, a
	ld a, [hld]
	ld b, a
	ld a, [hld]
	add c
	ld c, a
	ld a, [hld]
	adc b
	ld b, a
	jr nc, .okay2
	inc e

.okay2
	ld a, [hld]
	add c
	ld c, a
	ld a, [hl]
	adc b
	ld b, a
	ret nc
	inc e
	ret
