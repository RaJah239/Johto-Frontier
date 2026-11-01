FindMonInOTPartyToSwitchIntoBattle:
; Choose which OT mon to send out, evaluating the player's active moveset.
; Priority:
; 0. A mon that takes the least damage from the player's last move, if it
;    takes 0x (immune), 1/4x or 1/2x from it (in that order).
; 1. A mon that has a super-effective move against the player's active mon.
; 2. A mon that takes 0x or <=0.5x damage from every damaging move the
;    player's active mon knows.
; 3. A mon that takes the least damage from the player's active mon's moves.
; Returns the 0-based party index in b.
	ldh a, [hBattleTurn]
	ld [wEnemySwitchSavedTurn], a
	ld a, [wCurDamage]
	ld [wEnemySwitchSavedDamage], a
	ld a, [wCurDamage + 1]
	ld [wEnemySwitchSavedDamage + 1], a
	call OTSwitchSaveActiveMon
	call OTSwitchFindResistsLastMove
	jr c, .done
	call OTSwitchFindResistsAll
	jr c, .done
	call OTSwitchFindSuperEffective
	jr c, .done
	call OTSwitchFindLeastDamage

.done
	push bc
	call OTSwitchRestoreActiveMon
	pop bc
	ld a, [wEnemySwitchSavedTurn]
	ldh [hBattleTurn], a
	ld a, [wEnemySwitchSavedDamage]
	ld [wCurDamage], a
	ld a, [wEnemySwitchSavedDamage + 1]
	ld [wCurDamage + 1], a
	ret

OTSwitchSaveActiveMon:
	ld a, [wEnemyMonSpecies]
	ld [wEnemySwitchSavedMonSpecies], a
	ld a, [wEnemyMonItem]
	ld [wEnemySwitchSavedMonItem], a
	ld a, [wEnemyMonLevel]
	ld [wEnemySwitchSavedMonLevel], a
	ld hl, wEnemyMonDefense
	ld de, wEnemySwitchSavedMonDefense
	ld bc, 2
	call CopyBytes
	ld hl, wEnemyMonSpclDef
	ld de, wEnemySwitchSavedMonSpclDef
	ld bc, 2
	call CopyBytes
	ld a, [wEnemyMonType1]
	ld [wEnemySwitchSavedMonType1], a
	ld a, [wEnemyMonType2]
	ld [wEnemySwitchSavedMonType2], a
	ld hl, wEnemyDefense
	ld de, wEnemySwitchSavedMonBoostedDefense
	ld bc, 2
	call CopyBytes
	ld hl, wEnemySpDef
	ld de, wEnemySwitchSavedMonBoostedSpclDef
	ld bc, 2
	jmp CopyBytes

OTSwitchRestoreActiveMon:
	ld a, [wEnemySwitchSavedMonSpecies]
	ld [wEnemyMonSpecies], a
	ld a, [wEnemySwitchSavedMonItem]
	ld [wEnemyMonItem], a
	ld a, [wEnemySwitchSavedMonLevel]
	ld [wEnemyMonLevel], a
	ld hl, wEnemySwitchSavedMonDefense
	ld de, wEnemyMonDefense
	ld bc, 2
	call CopyBytes
	ld hl, wEnemySwitchSavedMonSpclDef
	ld de, wEnemyMonSpclDef
	ld bc, 2
	call CopyBytes
	ld a, [wEnemySwitchSavedMonType1]
	ld [wEnemyMonType1], a
	ld a, [wEnemySwitchSavedMonType2]
	ld [wEnemyMonType2], a
	ld hl, wEnemySwitchSavedMonBoostedDefense
	ld de, wEnemyDefense
	ld bc, 2
	call CopyBytes
	ld hl, wEnemySwitchSavedMonBoostedSpclDef
	ld de, wEnemySpDef
	ld bc, 2
	jmp CopyBytes

OTSwitchFindSuperEffective:
	xor a
	ld [wEnemySwitchCandidate], a
.loop
	ld a, [wEnemySwitchCandidate]
	ld b, a
	ld a, [wOTPartyCount]
	cp b
	jr z, .none
	ld a, [wCurOTMon]
	cp b
	jr z, .next
	call OTSwitchIsAliveCandidate
	jr nc, .next
	call OTSwitchHasSuperEffectiveMove
	jr nc, .next
	ld a, [wEnemySwitchCandidate]
	ld b, a
	scf
	ret

.next
	ld a, [wEnemySwitchCandidate]
	inc a
	ld [wEnemySwitchCandidate], a
	jr .loop

.none
	and a
	ret

OTSwitchFindResistsLastMove:
; Find the OT mon that takes the least damage from the player's last move:
; immune (0x) first, then 1/4x, then 1/2x. Ties go to the earlier party slot.
; Returns carry and the 0-based party index in b, or no carry if no mon
; takes 1/2x or less (or the player's last move isn't a damaging move).
	ld a, [wLastPlayerMove]
	and a
	jr z, .none
	dec a
	ld hl, Moves
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld de, wPlayerMoveStruct
	ld a, BANK(Moves)
	call FarCopyBytes
	ld a, [wPlayerMoveStruct + MOVE_POWER]
	and a
	jr z, .none

	; best matchup so far; a candidate must beat this (i.e. be <= 1/2x)
	ld a, NOT_VERY_EFFECTIVE + 1
	ld [wEnemySwitchBestDamage], a
	ld a, -1
	ld [wEnemySwitchBestIndex], a
	xor a
	ld [wEnemySwitchCandidate], a
.loop
	ld a, [wEnemySwitchCandidate]
	ld b, a
	ld a, [wOTPartyCount]
	cp b
	jr z, .done
	ld a, [wCurOTMon]
	cp b
	jr z, .next
	call OTSwitchIsAliveCandidate
	jr nc, .next
	call OTSwitchLastMoveMatchup
	ld c, a
	ld a, [wEnemySwitchBestDamage]
	cp c
	jr c, .next ; worse
	jr z, .next ; tie: keep the earlier mon
	ld a, c
	ld [wEnemySwitchBestDamage], a
	ld a, [wEnemySwitchCandidate]
	ld [wEnemySwitchBestIndex], a
.next
	ld hl, wEnemySwitchCandidate
	inc [hl]
	jr .loop

.done
	ld a, [wEnemySwitchBestIndex]
	cp -1
	jr z, .none
	ld b, a
	scf
	ret

.none
	and a
	ret

OTSwitchLastMoveMatchup:
; Return in a the type matchup of the move in wPlayerMoveStruct
; against OT party member b (NO_EFFECT if it has Levitate vs a Ground move).
	ld a, [wPlayerMoveStruct + MOVE_TYPE]
	and TYPE_MASK
	cp GROUND
	jr nz, .type_chart
	push bc
	ld hl, wOTPartySpecies
	ld c, b
	ld b, 0
	add hl, bc
	ld a, [hl]
	ld hl, LevitatePokemon
	call IsInByteArray
	pop bc
	jr nc, .type_chart
	xor a ; NO_EFFECT
	ret

.type_chart
	call OTSwitchLoadCandidateTypes
	call SetPlayerTurn
	callfar BattleCheckTypeMatchup
	ld a, [wTypeMatchup]
	ret

OTSwitchFindResistsAll:
	call OTSwitchPlayerHasDamagingMove
	jr nc, .none
	xor a
	ld [wEnemySwitchCandidate], a
.loop
	ld a, [wEnemySwitchCandidate]
	ld b, a
	ld a, [wOTPartyCount]
	cp b
	jr z, .none
	ld a, [wCurOTMon]
	cp b
	jr z, .next
	call OTSwitchIsAliveCandidate
	jr nc, .next
	call OTSwitchCandidateResistsAll
	jr nc, .next
	ld a, [wEnemySwitchCandidate]
	ld b, a
	scf
	ret

.next
	ld a, [wEnemySwitchCandidate]
	inc a
	ld [wEnemySwitchCandidate], a
	jr .loop

.none
	and a
	ret

OTSwitchFindLeastDamage:
	ld a, $ff
	ld [wEnemySwitchBestDamage], a
	ld [wEnemySwitchBestDamage + 1], a
	xor a
	ld [wEnemySwitchBestIndex], a
	ld [wEnemySwitchCandidate], a
.loop
	ld a, [wEnemySwitchCandidate]
	ld b, a
	ld a, [wOTPartyCount]
	cp b
	jr z, .done
	ld a, [wCurOTMon]
	cp b
	jr z, .next
	call OTSwitchIsAliveCandidate
	jr nc, .next
	call OTSwitchCandidateMaxDamage
	ld a, [wEnemySwitchMaxDamage]
	ld e, a
	ld a, [wEnemySwitchMaxDamage + 1]
	ld d, a
	ld a, [wEnemySwitchBestDamage]
	ld c, a
	ld a, [wEnemySwitchBestDamage + 1]
	ld b, a
	ld a, d
	cp b
	jr c, .better
	jr nz, .next
	ld a, e
	cp c
	jr nc, .next
.better
	ld a, e
	ld [wEnemySwitchBestDamage], a
	ld a, d
	ld [wEnemySwitchBestDamage + 1], a
	ld a, [wEnemySwitchCandidate]
	ld [wEnemySwitchBestIndex], a
.next
	ld a, [wEnemySwitchCandidate]
	inc a
	ld [wEnemySwitchCandidate], a
	jr .loop

.done
	ld a, [wEnemySwitchBestIndex]
	ld b, a
	ret

OTSwitchIsAliveCandidate:
	push bc
	ld hl, wOTPartyMon1HP
	ld a, b
	call GetPartyLocation
	ld a, [hli]
	or [hl]
	pop bc
	jr nz, .alive
	and a
	ret

.alive
	scf
	ret

OTSwitchHasSuperEffectiveMove:
	push bc
	ld hl, wOTPartyMon1Moves
	ld a, b
	call GetPartyLocation
	pop bc
	ld b, NUM_MOVES
.loop
	ld a, [hli]
	and a
	jr z, .no
	push hl
	push bc
	dec a
	ld hl, Moves
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld de, wEnemyMoveStruct
	ld a, BANK(Moves)
	call FarCopyBytes
	call SetEnemyTurn
	callfar BattleCheckTypeMatchup
	ld a, [wTypeMatchup]
	pop bc
	pop hl
	cp EFFECTIVE + 1
	jr nc, .yes
	dec b
	jr nz, .loop
.no
	and a
	ret

.yes
	scf
	ret

OTSwitchPlayerHasDamagingMove:
	ld hl, wBattleMonMoves
	ld b, NUM_MOVES
.loop
	ld a, [hli]
	and a
	jr z, .no
	push hl
	push bc
	dec a
	ld hl, Moves
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld de, wPlayerMoveStruct
	ld a, BANK(Moves)
	call FarCopyBytes
	pop bc
	pop hl
	ld a, [wPlayerMoveStruct + MOVE_POWER]
	and a
	jr nz, .yes
	dec b
	jr nz, .loop
.no
	and a
	ret

.yes
	scf
	ret

OTSwitchCandidateResistsAll:
	call OTSwitchLoadCandidateTypes
	call SetPlayerTurn
	ld hl, wBattleMonMoves
	ld b, NUM_MOVES
.loop
	ld a, [hli]
	and a
	jr z, .yes
	push hl
	push bc
	dec a
	ld hl, Moves
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld de, wPlayerMoveStruct
	ld a, BANK(Moves)
	call FarCopyBytes
	pop bc
	pop hl
	ld a, [wPlayerMoveStruct + MOVE_POWER]
	and a
	jr z, .next
	push hl
	push bc
	callfar BattleCheckTypeMatchup
	ld a, [wTypeMatchup]
	pop bc
	pop hl
	cp NOT_VERY_EFFECTIVE + 1
	jr nc, .no
.next
	dec b
	jr nz, .loop
.yes
	scf
	ret

.no
	and a
	ret

OTSwitchLoadCandidateTypes:
; Copy the base types of OT party member b into wEnemyMonType.
	push bc
	ld hl, wOTPartySpecies
	ld c, b
	ld b, 0
	add hl, bc
	ld a, [hl]
	pop bc
	dec a
	ld hl, BaseData + BASE_TYPES
	ld bc, BASE_DATA_SIZE
	call AddNTimes
	ld de, wEnemyMonType
	ld bc, BASE_CATCH_RATE - BASE_TYPES
	ld a, BANK(BaseData)
	jmp FarCopyBytes

OTSwitchCandidateMaxDamage:
; Return in wEnemySwitchMaxDamage the largest amount of damage the player's
; active mon can deal to OT party member b.
	push bc
	ld hl, wOTPartyMon1
	ld a, b
	call GetPartyLocation
	pop bc
	ld a, [hl]
	ld [wCurSpecies], a
	ld [wEnemyMonSpecies], a
	ld de, MON_ITEM
	add hl, de
	ld a, [hl]
	ld [wEnemyMonItem], a
	push bc
	ld hl, wOTPartyMon1
	ld a, b
	call GetPartyLocation
	pop bc
	ld de, MON_LEVEL
	add hl, de
	ld a, [hl]
	ld [wEnemyMonLevel], a
	push bc
	ld hl, wOTPartyMon1
	ld a, b
	call GetPartyLocation
	pop bc
	ld de, MON_DEF
	add hl, de
	ld a, [hli]
	ld [wEnemyMonDefense], a
	ld [wEnemyDefense], a
	ld a, [hl]
	ld [wEnemyMonDefense + 1], a
	ld [wEnemyDefense + 1], a
	push bc
	ld hl, wOTPartyMon1
	ld a, b
	call GetPartyLocation
	pop bc
	ld de, MON_SDF
	add hl, de
	ld a, [hli]
	ld [wEnemyMonSpclDef], a
	ld [wEnemySpDef], a
	ld a, [hl]
	ld [wEnemyMonSpclDef + 1], a
	ld [wEnemySpDef + 1], a
	call GetBaseData
	ld a, [wBaseType1]
	ld [wEnemyMonType1], a
	ld a, [wBaseType2]
	ld [wEnemyMonType2], a
	xor a
	ld [wEnemySwitchMaxDamage], a
	ld [wEnemySwitchMaxDamage + 1], a
	ld [wCriticalHit], a
	call SetPlayerTurn
	ld hl, wBattleMonMoves
	ld b, NUM_MOVES
.loop
	ld a, [hli]
	and a
	jr z, .done
	push hl
	push bc
	dec a
	ld hl, Moves
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld de, wPlayerMoveStruct
	ld a, BANK(Moves)
	call FarCopyBytes
	pop bc
	pop hl
	ld a, [wPlayerMoveStruct + MOVE_POWER]
	and a
	jr z, .next
	push hl
	push bc
	callfar PlayerAttackDamage
	callfar BattleCommand_DamageCalc
	callfar BattleCommand_Stab
	pop bc
	pop hl
	ld a, [wCurDamage]
	ld e, a
	ld a, [wCurDamage + 1]
	ld d, a
	ld a, [wEnemySwitchMaxDamage]
	ld c, a
	ld a, [wEnemySwitchMaxDamage + 1]
	cp d
	jr c, .update
	jr nz, .next
	ld a, c
	cp e
	jr nc, .next
.update
	ld a, e
	ld [wEnemySwitchMaxDamage], a
	ld a, d
	ld [wEnemySwitchMaxDamage + 1], a
.next
	dec b
	jr nz, .loop
.done
	ret
