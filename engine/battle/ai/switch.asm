CheckPlayerMoveTypeMatchups:
; check how well the moves you've already used
; fare against the enemy's pokemon
; used to score a potential switch
	push hl
	push de
	push bc
	ld a, BASE_AI_SWITCH_SCORE
	ld [wEnemyAISwitchScore], a
	ld hl, wPlayerUsedMoves
	ld a, [hl]
	and a
	jr z, .unknown_moves

	lb de, NUM_MOVES, 0
.loop
	ld a, [hli]
	and a
	jr z, .exit
	push hl
	dec a
	ld hl, Moves + MOVE_POWER
	newfarcall GetMoveAttr
	and a
	jr z, .next

	inc hl
	newfarcall GetMoveByte
	ld hl, wEnemyMonType
	newfarcall CheckTypeMatchup
	ld a, [wTypeMatchup]
	ld a, [wTypeMatchup]
	cp EFFECTIVE
 	jr z, .neutral
 	jr c, .super_effective

; not very effective
	ld a, e
	cp 1 ; 0.1
	jr nc, .next
	ld e, 1
	jr .next

.neutral
	ld e, 2
	jr .next

.super_effective
	ld a, [wEnemyAISwitchScore]
	sub 6
	ld [wEnemyAISwitchScore], a
	pop hl
	jr .done

.next
	pop hl
	dec d
	jr nz, .loop

.exit
	ld a, e
	cp 2
	jr z, .done
	call .IncreaseScore
	ld a, e
	and a
	jr nz, .done
	call .IncreaseScore

.done
 	jmp PopBCDEHL

.unknown_moves
	ld a, [wBattleMonType1]
	ld b, a
	ld hl, wEnemyMonType1
	newfarcall CheckTypeMatchup
	ld a, [wTypeMatchup]
	cp EFFECTIVE
	jr c, .ok
	jr c, .se
 	call .IncreaseScore
 	jr .ok
 .se
	call .DecreaseScore
.ok
	ld a, [wBattleMonType2]
	cp b
	jr z, .done
	newfarcall CheckTypeMatchup
	ld a, [wTypeMatchup]
	cp EFFECTIVE
	jr z, .done
 	jr c, .se2
 	call .IncreaseScore
 	jr .done
 .se2
 	call .DecreaseScore
 	jr .done

.DecreaseScore:
	ld a, [wEnemyAISwitchScore]
	dec a
	ld [wEnemyAISwitchScore], a
	ret

.IncreaseScore:
	ld a, [wEnemyAISwitchScore]
	inc a
	ld [wEnemyAISwitchScore], a
	ret

FindAliveEnemyMons:
; carry if the enemy has no other alive mon; else c = bit mask of them
	ld a, [wOTPartyCount]
	cp 2
	jr c, .only_one

	ld d, a
	ld e, 0
	ld b, 1 << (PARTY_LENGTH - 1)
	ld c, 0
	ld hl, wOTPartyMon1HP

.loop
	ld a, [wCurOTMon]
	cp e
	jr z, .next

	push bc
	ld b, [hl]
	inc hl
	ld a, [hld]
	or b
	pop bc
	jr z, .next

	ld a, c
	or b
	ld c, a

.next
	srl b
	push bc
	ld bc, PARTYMON_STRUCT_LENGTH
	add hl, bc
	pop bc
	inc e
	dec d
	jr nz, .loop

	ld a, c
	and a
	jr nz, .more_than_one

.only_one
	scf
	ret

.more_than_one
	and a
	ret
