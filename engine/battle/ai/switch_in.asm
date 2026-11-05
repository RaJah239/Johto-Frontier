FindMonInOTPartyToSwitchIntoBattle:
; Choose which OT mon to send out, evaluating the player's active moveset.
; Priority:
; 0. A mon that takes the least damage from the player's last move, if it
;    takes 0x (immune), 1/4x or 1/2x from it (in that order).
; 1. A mon that takes 0x or <=0.5x damage from every damaging move the
;    player's active mon knows.
; 2. A mon that has a super-effective move against the player's active mon.
; 3. A mon that takes the least damage from the player's active mon's moves.
; Mons that Spikes / Stealth Rock on our side would KO as they come in are
; skipped in every step as long as at least one alive mon would survive them;
; on top of that, mons weak (> 1x) to the player's last move are skipped as
; long as at least one of the remaining mons isn't (OTSwitchComputeAvoidMask).
;
; Replacing a fainted mon (our active mon is at 0 HP, e.g. the player just
; KO'd it) uses a different order instead:
; 1. A mon whose own type is super effective against the player's mon and
;    that has a damaging move that's super effective against it, preferring
;    4x over 2x (OTSwitchFindKOReplacementAttacker).
; 2. A mon that takes 0x or <=0.5x from every damaging move the player knows.
; 3. A mon that takes the least damage from the player's moves.
; Returns the 0-based party index in b.
	ldh a, [hBattleTurn]
	ld [wEnemySwitchSavedTurn], a
	ld a, [wCurDamage]
	ld [wEnemySwitchSavedDamage], a
	ld a, [wCurDamage + 1]
	ld [wEnemySwitchSavedDamage + 1], a
	call OTSwitchSaveActiveMon
	call OTSwitchComputeAvoidMask

	; replacing a fainted mon (the player KO'd it): go on the attack
	ld a, [wEnemyMonHP]
	ld b, a
	ld a, [wEnemyMonHP + 1]
	or b
	jr nz, .voluntary
	call OTSwitchFindKOReplacementAttacker
	jr c, .done
	call OTSwitchFindResistsAll
	jr c, .done
	call OTSwitchFindLeastDamage
	jr .done

.voluntary
	call OTSwitchFindResistsLastMove
	jr c, .done
	call OTSwitchFindResistsAll
	jr c, .done
	call OTSwitchFindSuperEffective
	jr c, .done
	call OTSwitchFindLeastDamage

.done
	xor a
	ld [wEnemySwitchAvoidMask], a
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
	; during FindMonInOTPartyToSwitchIntoBattle, mons weak to the player's
	; last move count as unavailable (wEnemySwitchAvoidMask)
	ld a, [wEnemySwitchAvoidMask]
	and a
	jr z, .available
	push bc
	inc b
.shift
	dec b
	jr z, .test
	rrca
	jr .shift
.test
	pop bc
	bit 0, a
	jr z, .available
	and a
	ret

.available
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

AllSwitchInsWeakToLastMove:
; Return carry if the player's last move is a damaging move and every alive
; OT mon other than the active one takes more than 1x from it (type matchup;
; Levitate counts as immune to Ground). Used to cancel voluntary AI switches.
; Preserves hBattleTurn and the active mon's data, and reloads both move
; structs afterwards.
	ldh a, [hBattleTurn]
	push af
	call OTSwitchSaveActiveMon
	call .check
	push af
	call OTSwitchRestoreActiveMon
	farcall DamageRace_ReloadMoveStructs
	pop bc ; result flags in c
	pop af
	ldh [hBattleTurn], a
	push bc
	pop af
	ret

.check
	ld a, [wLastPlayerMove]
	and a
	ret z ; no last move (carry is clear)
	dec a
	ld hl, Moves
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld de, wPlayerMoveStruct
	ld a, BANK(Moves)
	call FarCopyBytes
	ld a, [wPlayerMoveStruct + MOVE_POWER]
	and a
	ret z ; status move (carry is clear)

	xor a
	ld [wEnemySwitchCandidate], a
.loop
	ld a, [wEnemySwitchCandidate]
	ld b, a
	ld a, [wOTPartyCount]
	cp b
	jr z, .all_weak
	ld a, [wCurOTMon]
	cp b
	jr z, .next
	call OTSwitchIsAliveCandidate
	jr nc, .next
	call OTSwitchLastMoveMatchup
	cp EFFECTIVE + 1
	jr c, .not_all_weak ; this one takes 1x or less
.next
	ld hl, wEnemySwitchCandidate
	inc [hl]
	jr .loop

.not_all_weak
	and a
	ret

.all_weak
	scf
	ret

OTSwitchComputeAvoidMask:
; Set wEnemySwitchAvoidMask bit n for every alive OT mon n (other than the
; active one) that:
; - entry hazards would KO on the way in, if at least one alive mon would
;   survive them (OTSwitchComputeHazardMask), and then
; - takes more than 1x from the player's last damaging move, if at least one
;   of the mons still available takes 1x or less.
; If no mon passes a filter, that filter is dropped so the normal choice
; still happens. Uses wEnemySwitchCandidate, wEnemySwitchBestIndex and
; wEnemySwitchHazardMask as scratch.
	call OTSwitchComputeHazardMask
	ld a, [wEnemySwitchAvoidMask]
	ld [wEnemySwitchHazardMask], a ; fallback if every mon left is weak
	xor a
	ld [wEnemySwitchBestIndex], a ; nonzero once a safe mon is found
	ld a, [wLastPlayerMove]
	and a
	ret z
	dec a
	ld hl, Moves
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld de, wPlayerMoveStruct
	ld a, BANK(Moves)
	call FarCopyBytes
	ld a, [wPlayerMoveStruct + MOVE_POWER]
	and a
	ret z

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
	cp EFFECTIVE + 1
	jr nc, .weak
	ld a, TRUE
	ld [wEnemySwitchBestIndex], a
	jr .next

.weak
	call OTSwitchCandidateBit
	ld hl, wEnemySwitchAvoidMask
	or [hl]
	ld [hl], a

.next
	ld hl, wEnemySwitchCandidate
	inc [hl]
	jr .loop

.done
	ld a, [wEnemySwitchBestIndex]
	and a
	ret nz
	; every available mon is weak: only avoid the ones hazards would KO
	ld a, [wEnemySwitchHazardMask]
	ld [wEnemySwitchAvoidMask], a
	ret

OTSwitchCandidateBit:
; Return a = 1 << [wEnemySwitchCandidate].
	ld a, [wEnemySwitchCandidate]
	ld c, a
	inc c
	ld a, 1
.loop
	dec c
	ret z
	add a
	jr .loop

OTSwitchComputeHazardMask:
; Set wEnemySwitchAvoidMask bit n for every alive OT mon n (other than the
; active one) that the entry hazards on our side would KO as it switches in,
; but only if at least one alive mon would survive them; otherwise leave it
; 0 (the last mon(s) still get sent in). Uses wEnemySwitchCandidate,
; wEnemySwitchBestIndex and wEnemySwitchHazardMask as scratch.
	xor a
	ld [wEnemySwitchAvoidMask], a
	ld [wEnemySwitchHazardMask], a
	ld [wEnemySwitchBestIndex], a ; nonzero once a survivor is found
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
	call OTSwitchCandidateFaintsOnEntry
	jr c, .faints
	ld a, TRUE
	ld [wEnemySwitchBestIndex], a
	jr .next

.faints
	call OTSwitchCandidateBit
	ld hl, wEnemySwitchHazardMask
	or [hl]
	ld [hl], a
.next
	ld hl, wEnemySwitchCandidate
	inc [hl]
	jr .loop

.done
	ld a, [wEnemySwitchBestIndex]
	and a
	ret z ; nothing survives: avoid none
	ld a, [wEnemySwitchHazardMask]
	ld [wEnemySwitchAvoidMask], a
	ret

AllSwitchInsFaintOnEntry:
; Return carry if Spikes / Stealth Rock on our side would KO every alive OT
; mon other than the active one as it switches in. Used to cancel voluntary
; AI switches. Preserves hBattleTurn and the active mon's data.
	ld a, [wEnemyScreens]
	and (1 << SCREENS_SPIKES) | (1 << SCREENS_STEALTH_ROCK)
	ret z ; no damaging hazards (carry is clear)
	ldh a, [hBattleTurn]
	push af
	call OTSwitchSaveActiveMon
	call .check
	push af
	call OTSwitchRestoreActiveMon
	pop bc ; result flags in c
	pop af
	ldh [hBattleTurn], a
	push bc
	pop af
	ret

.check
	xor a
	ld [wEnemySwitchCandidate], a
.loop
	ld a, [wEnemySwitchCandidate]
	ld b, a
	ld a, [wOTPartyCount]
	cp b
	jr z, .all_faint
	ld a, [wCurOTMon]
	cp b
	jr z, .next
	call OTSwitchIsAliveCandidate
	jr nc, .next
	call OTSwitchCandidateFaintsOnEntry
	jr nc, .survivor
.next
	ld hl, wEnemySwitchCandidate
	inc [hl]
	jr .loop

.survivor
	and a
	ret

.all_faint
	scf
	ret

OTSwitchCandidateFaintsOnEntry:
; b = OT party index. Return carry if the entry hazards on our side would
; deal at least its current HP as it switches in, using the same rules as
; SpikesDamage (core.asm):
; - Hazard Guard mons, Spin Guard mons (they clear hazards first) and
;   Heavy Boots holders take nothing.
; - Spikes: 1/8 max HP; not Flying types or SpikesImmunePokemon.
; - Stealth Rock: 1/8 max HP; 1/4 if Rock is super effective, 1/16 if it's
;   resisted (or no effect); not MagicGuardPokemon.
; Toxic Spikes and Sticky Web do no damage. Preserves b; overwrites
; wEnemyMonType and hBattleTurn.
	ld a, [wEnemyScreens]
	and (1 << SCREENS_SPIKES) | (1 << SCREENS_STEALTH_ROCK)
	ret z ; carry is clear
	push bc
	call .check
	pop bc
	ret

.check
	xor a
	ld [wEnemySwitchHazardDamage], a
	ld [wEnemySwitchHazardDamage + 1], a
	ld hl, wOTPartySpecies
	ld e, b
	ld d, 0
	add hl, de
	ld a, [hl]
	ld [wEnemySwitchHazardSpecies], a

	; immune to all hazards
	ld hl, HazardGuardMons
	ld d, BANK(HazardGuardMons)
	call OTSwitchIsInFarList
	jmp c, .survives
	ld a, [wEnemySwitchHazardSpecies]
	ld hl, SpinGuardPokemon
	ld d, BANK(SpinGuardPokemon)
	call OTSwitchIsInFarList
	jmp c, .survives

	; Heavy Boots
	push bc
	ld hl, wOTPartyMon1Item
	ld a, b
	call GetPartyLocation
	ld a, [hl]
	pop bc
	and a
	jr z, .no_item
	dec a
	push bc
	ld hl, ItemAttributes + ITEMATTR_EFFECT
	ld bc, ITEMATTR_STRUCT_LENGTH
	call AddNTimes
	ld a, BANK(ItemAttributes)
	call GetFarByte
	pop bc
	cp HELD_HEAVY_BOOTS
	jmp z, .survives
.no_item

	push bc
	call OTSwitchLoadCandidateTypes
	pop bc

	; Spikes: 1/8
	ld a, [wEnemyScreens]
	bit SCREENS_SPIKES, a
	jr z, .stealth_rock
	ld a, [wEnemyMonType1]
	cp FLYING
	jr z, .stealth_rock
	ld a, [wEnemyMonType2]
	cp FLYING
	jr z, .stealth_rock
	ld a, [wEnemySwitchHazardSpecies]
	ld hl, SpikesImmunePokemon
	ld d, BANK(SpikesImmunePokemon)
	call OTSwitchIsInFarList
	jr c, .stealth_rock
	call OTSwitchCandidateQuarterHP
	srl a
	call OTSwitchAddHazardDamage

.stealth_rock
	ld a, [wEnemyScreens]
	bit SCREENS_STEALTH_ROCK, a
	jr z, .compare
	push bc
	ld a, [wEnemySwitchHazardSpecies]
	ld hl, MagicGuardPokemon
	call IsInByteArray
	pop bc
	jr c, .compare
	call SetEnemyTurn
	callfar CheckStealthRockTypeMatchup
	ld a, [wTypeMatchup]
	ld d, a
	call OTSwitchCandidateQuarterHP ; preserves de
	ld e, a
	ld a, d
	cp EFFECTIVE + 1
	ld a, e
	jr nc, .add_stealth_rock ; super effective: 1/4
	ld a, d
	cp EFFECTIVE - 1
	ld a, e
	jr nc, .eighth ; neutral: 1/8
	srl a ; resisted: 1/16
.eighth
	srl a
.add_stealth_rock
	call OTSwitchAddHazardDamage

.compare
	; carry if damage >= current HP
	push bc
	ld hl, wOTPartyMon1HP
	ld a, b
	call GetPartyLocation
	pop bc
	ld a, [wEnemySwitchHazardDamage]
	cp [hl]
	jr c, .survives
	jr nz, .faints
	inc hl
	ld a, [wEnemySwitchHazardDamage + 1]
	cp [hl]
	jr c, .survives
.faints
	scf
	ret

.survives
	and a
	ret

OTSwitchAddHazardDamage:
; Add a (at least 1) to wEnemySwitchHazardDamage.
	and a
	jr nz, .add
	inc a
.add
	ld hl, wEnemySwitchHazardDamage + 1
	add [hl]
	ld [hld], a
	ret nc
	inc [hl]
	ret

OTSwitchCandidateQuarterHP:
; b = OT party index. Return a = its max HP / 4, at least 1 (like
; GetQuarterMaxHP). Preserves bc and de.
	push bc
	push de
	ld hl, wOTPartyMon1MaxHP
	ld a, b
	call GetPartyLocation
	ld a, [hli]
	ld b, a
	ld c, [hl]
	srl b
	rr c
	srl b
	rr c
	ld a, c
	pop de
	pop bc
	and a
	ret nz
	inc a
	ret

OTSwitchIsInFarList:
; Return carry if species a is in the -1-terminated list at d:hl.
; Preserves bc.
	ld e, a
.loop
	ld a, d
	call GetFarByte
	inc hl
	cp -1
	jr z, .no
	cp e
	jr nz, .loop
	scf
	ret

.no
	and a
	ret

DEF wEnemySwitchSimStats EQUS "wEnemySwitchSavedMonSpecies" ; 11 bytes: wEnemyStats
DEF wEnemySwitchSimTypes EQUS "wEnemySwitchSavedMonBoostedSpclDef" ; 2 bytes: wEnemyMonType1-2

OTSwitchFindWinningReplacement:
; Find an alive OT mon other than the active one that wins a 1-on-1 against
; each candidate is loaded as the active enemy mon
; (its own stats, healing and boosts, with no stat stages)
; checked with GetDamageRaceHits
; among the winners, the one that takes the least damage
; from the player's last move is picked
; ties go to the earlier party slot
; Returns the 0-based party index in b, or -1 if no mon wins.
	ldh a, [hBattleTurn]
	push af
	call OTSwitchSimSave
	ld a, -1
	ld [wEnemySwitchSimBestIndex], a
	ld [wEnemySwitchSimBestMatchup], a ; 255: none yet
	xor a
	ld [wEnemySwitchSimCandidate], a
.loop
	ld a, [wEnemySwitchSimCandidate]
	ld b, a
	ld a, [wOTPartyCount]
	cp b
	jr z, .done
	ld a, [wCurOTMon]
	cp b
	jr z, .next
	call OTSwitchIsAliveCandidate
	jr nc, .next
	ld a, [wEnemySwitchSimCandidate]
	ld b, a
	call OTSwitchSimLoadCandidate
	call OTSwitchSimWins
	jr nc, .next
	ld a, [wEnemySwitchSimCandidate]
	ld b, a
	call OTSwitchSimLastMoveMatchup
	ld c, a
	ld a, [wEnemySwitchSimBestMatchup]
	cp c
	jr c, .next ; a better matchup is already known
	jr z, .next ; tie: keep the earlier mon
	ld a, c
	ld [wEnemySwitchSimBestMatchup], a
	ld a, [wEnemySwitchSimCandidate]
	ld [wEnemySwitchSimBestIndex], a
.next
	ld hl, wEnemySwitchSimCandidate
	inc [hl]
	jr .loop

.done
	call OTSwitchSimRestore
	ld a, [wEnemySwitchSimBestIndex]
	ld b, a
	pop af
	ldh [hBattleTurn], a
	ret

OTSwitchSimSave:
; Save the active enemy mon and its stat state before simulating candidates.
	ld hl, wEnemyMon
	ld de, wEnemySwitchSimMon
	call OTSwitchSimCopyMon
	ld hl, wEnemyStats
	ld de, wEnemySwitchSimStats
	ld bc, 11
	call CopyBytes
	ld hl, wEnemyStatLevels
	ld de, wEnemySwitchSimLevels
	ld bc, NUM_LEVEL_STATS
	call CopyBytes
	ld a, [wEnemySubStatus5]
	ld [wEnemySwitchSimSubStatus5], a
	ld hl, wEnemyMonType1
	ld de, wEnemySwitchSimTypes
	ld bc, 2
	call CopyBytes
	ld a, [wCurPartyMon]
	ld [wEnemySwitchSimParty], a
	ld a, [wCurPartyLevel]
	ld [wEnemySwitchSimParty + 1], a
	ret

OTSwitchSimRestore:
; Put back the state saved by OTSwitchSimSave. The species variables the
; candidate loads overwrote are scratch, so they go back to the active species.
	ld hl, wEnemySwitchSimMon
	ld de, wEnemyMon
	call OTSwitchSimRestoreMon
	ld hl, wEnemySwitchSimStats
	ld de, wEnemyStats
	ld bc, 11
	call CopyBytes
	ld hl, wEnemySwitchSimLevels
	ld de, wEnemyStatLevels
	ld bc, NUM_LEVEL_STATS
	call CopyBytes
	ld a, [wEnemySwitchSimSubStatus5]
	ld [wEnemySubStatus5], a
	ld hl, wEnemySwitchSimTypes
	ld de, wEnemyMonType1
	ld bc, 2
	call CopyBytes
	ld a, [wEnemySwitchSimParty]
	ld [wCurPartyMon], a
	ld a, [wEnemySwitchSimParty + 1]
	ld [wCurPartyLevel], a
	ld a, [wEnemyMonSpecies]
	ld [wCurPartySpecies], a
	ld [wCurSpecies], a
	ld [wTempEnemyMonSpecies], a
	jmp GetBaseData ; base data of the active mon again

OTSwitchSimCopyMon:
; Copy wEnemyMon (in WRAM bank 1) to wEnemySwitchSimMon (another WRAM bank).
; Each byte goes through a bank switch, since both can't be mapped at once.
	ldh a, [rSVBK]
	push af
	ld c, wEnemyMonEnd - wEnemyMon
.loop
	ld a, BANK(wEnemyMon)
	ldh [rSVBK], a
	ld a, [hli]
	push af
	ld a, BANK(wEnemySwitchSimMon)
	ldh [rSVBK], a
	pop af
	ld [de], a
	inc de
	dec c
	jr nz, .loop
	pop af
	ldh [rSVBK], a
	ret

OTSwitchSimRestoreMon:
; Copy wEnemySwitchSimMon back to wEnemyMon (see OTSwitchSimCopyMon).
	ldh a, [rSVBK]
	push af
	ld c, wEnemyMonEnd - wEnemyMon
.loop
	ld a, BANK(wEnemySwitchSimMon)
	ldh [rSVBK], a
	ld a, [hli]
	push af
	ld a, BANK(wEnemyMon)
	ldh [rSVBK], a
	pop af
	ld [de], a
	inc de
	dec c
	jr nz, .loop
	pop af
	ldh [rSVBK], a
	ret

OTSwitchSimLoadCandidate:
; Load OT party member b into wEnemyMon with no stat stages, Encore or
; choice lock, and work out its battle stats.
	ld a, b
	ld [wCurPartyMon], a
	ld hl, wOTPartyMon1Level
	call GetPartyLocation
	ld a, [hl]
	ld [wCurPartyLevel], a
	ld hl, wOTPartySpecies
	ld c, b
	ld b, 0
	add hl, bc
	ld a, [hl]
	ld [wTempEnemyMonSpecies], a
	farcall LoadEnemyMon
	ld a, BASE_STAT_LEVEL
	ld b, NUM_LEVEL_STATS
	ld hl, wEnemyStatLevels
.reset_levels
	ld [hli], a
	dec b
	jr nz, .reset_levels
	xor a
	ld [wEnemySubStatus5], a
	ld a, [wBaseType1]
	ld [wEnemyMonType1], a
	ld a, [wBaseType2]
	ld [wEnemyMonType2], a
	farjp CalcEnemyStats

OTSwitchSimWins:
; Return carry if the simulated enemy mon wins the 1-on-1: it needs fewer
; hits to KO the player's mon, or the same number and it's faster.
	farcall GetDamageRaceHits ; b = its hits, c = the player's hits
	ld a, b
	cp c
	jr c, .wins
	ret nz
	farcall DoesAIOutSpeedPlayer
	ret
.wins
	scf
	ret

OTSwitchSimLastMoveMatchup:
; Return in a the type matchup of the player's last move against OT party
; member b. A last move that isn't damaging counts as neutral (EFFECTIVE).
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
	jmp OTSwitchLastMoveMatchup
.none
	ld a, EFFECTIVE
	ret

OTSwitchFindKOReplacementAttacker:
; Find the OT mon whose own type is super effective against the player's mon
; and that has a damaging move that's super effective against it. Among
; those, pick the one with the strongest such move (4x beats 2x); ties go
; to the earlier party slot. Returns carry and the 0-based index in b.
	xor a
	ld [wEnemySwitchBestDamage], a ; best move matchup so far
	ld [wEnemySwitchCandidate], a
	dec a
	ld [wEnemySwitchBestIndex], a
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
	call OTSwitchTypeIsSuperEffective
	jr nc, .next
	call OTSwitchBestMoveMatchup
	cp EFFECTIVE + 1
	jr c, .next ; no super-effective damaging move
	ld c, a
	ld a, [wEnemySwitchBestDamage]
	cp c
	jr nc, .next ; not better than the best so far
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

OTSwitchTypeIsSuperEffective:
; Return carry if either of OT mon wEnemySwitchCandidate's own types is super
; effective against the player's active mon.
	ld a, [wEnemySwitchCandidate]
	ld b, a
	call OTSwitchLoadCandidateTypes
	ld a, [wEnemyMonType1]
	call .check
	ret c
	ld a, [wEnemyMonType2]
.check
	ld [wEnemyMoveStruct + MOVE_TYPE], a
	call SetEnemyTurn
	callfar BattleCheckTypeMatchup
	ld a, [wTypeMatchup]
	cp EFFECTIVE + 1
	ccf
	ret

OTSwitchBestMoveMatchup:
; Return in a the best type matchup of OT mon wEnemySwitchCandidate's damaging
; moves against the player's active mon (0 if the player's ability makes it
; immune to that move's type).
	ld a, [wEnemySwitchCandidate]
	ld hl, wOTPartyMon1Moves
	call GetPartyLocation
	ld c, 0 ; best so far
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
	ld de, wEnemyMoveStruct
	ld a, BANK(Moves)
	call FarCopyBytes
	ld a, [wEnemyMoveStruct + MOVE_POWER]
	and a
	jr z, .skip
	ld a, [wEnemyMoveStruct + MOVE_TYPE]
	and TYPE_MASK
	ld b, a
	farcall AI_IsPlayerImmuneByAbility
	jr c, .skip
	call SetEnemyTurn
	callfar BattleCheckTypeMatchup
	ld a, [wTypeMatchup]
	pop bc
	cp c
	jr c, .next
	ld c, a
	jr .next

.skip
	pop bc
.next
	pop hl
	dec b
	jr nz, .loop
.done
	ld a, c
	ret
