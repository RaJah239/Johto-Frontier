GetNextTrainerDataByte:
	ld a, [wTrainerGroupBank]
	call GetFarByte
	inc hl
	ret

ReadTrainerParty:
	ld a, [wInBattleTowerBattle]
	bit 0, a
	ret nz

	ld a, [wLinkMode]
	and a
	ret nz

	ld hl, wOTPartyCount
	xor a
	ld [hli], a
	dec a
	ld [hl], a

	ld hl, wOTPartyMons
	ld bc, PARTYMON_STRUCT_LENGTH * PARTY_LENGTH
	xor a
	call ByteFill

	ld a, [wOtherTrainerClass]

	dec a
	ld c, a
	ld b, 0
	ld hl, TrainerGroups
	add hl, bc
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld [wTrainerGroupBank], a	
	ld a, [hli]
	ld h, [hl]
	ld l, a

	ld a, [wOtherTrainerID]
	ld b, a
.skip_trainer
	dec b
	jr z, .got_trainer
.loop
	call GetNextTrainerDataByte
	inc a
	jr nz, .loop
	jr .skip_trainer

.got_trainer
	call GetNextTrainerDataByte
	cp "@"
	jr nz, .got_trainer ; Skip name.

	call GetNextTrainerDataByte
	ld [wOtherTrainerType], a
	ld d, h
	ld e, l
	call ReadTrainerPartyPieces
	jmp ComputeTrainerReward

ReadTrainerPartyPieces:
	ld h, d
	ld l, e
; Random?
	bit TRAINERTYPE_RANDOM_F, a
	jr z, .not_random
	call GetNextTrainerDataByte
	ld [wRandomTrainerNumPokemon], a
	call GetNextTrainerDataByte
	ld b, a ; list number, skip this many $ff after bank switch
	ld a, BANK(RandomPartyLists)
	ld [wTrainerGroupBank], a
	ld hl, RandomPartyLists
.random_skiploop
	ld a, b
	and a
	jr z, .skipdone
.random_innerskiploop
	call GetNextTrainerDataByte
	cp -1
	jr nz, .random_innerskiploop
	dec b
	jr .random_skiploop
.skipdone
	call GetNextTrainerDataByte
	ld [wRandomTrainerTotalPokemon], a
	push hl
.start_random
	ld hl, wRandomTrainerRandomNumbers
	ld a, [wRandomTrainerTotalPokemon]
	call RandomRange
	ld b, a
	ld a, [wOTPartyCount]
	ld c, a
	inc c
.repeats_loop
	dec c
	jr z, .no_repeats
	ld a, [hli]
	cp b
	jr z, .start_random
	jr .repeats_loop
.no_repeats
	ld [hl], b
	pop hl
	push hl
	; skip b $fe delimiters
.random_skiploop2
	ld a, b
	and a
	jr z, .skipdone2
.random_innerskiploop2
	call GetNextTrainerDataByte
	cp $fe
	jr nz, .random_innerskiploop2
	dec b
	jr .random_skiploop2
.skipdone2
.not_random
.loop
; end?
	call GetNextTrainerDataByte
	cp -1
	ret z

	; save a
	push af

	ld a, [wOptions2]
	bit HARD_MODE, a
	jr z, .skip_level_scaling

	; restore a (which held the original value)
	pop af

	; apply level scaling
	ld b, a
	ld a, [wBaseLevel]
	add a, b
	jr .level_scaling_done

; level
.skip_level_scaling
	pop af ; discard original 'a' if we didn't use it

.level_scaling_done
	ld [wCurPartyLevel], a

; species
	call GetNextTrainerDataByte
	ld [wCurPartySpecies], a

; add to party
	ld a, OTPARTYMON
	ld [wMonType], a
	push hl
	predef TryAddMonToParty
	pop hl

; nickname?
	ld a, [wOtherTrainerType]
	bit TRAINERTYPE_NICKNAME_F, a
	jr z, .no_nickname

	call GetNextTrainerDataByte
	cp "@"
	jr z, .no_nickname

	push de
	ld de, wStringBuffer2
	ld [de], a
	inc de
.copy_nickname
	call GetNextTrainerDataByte
	ld [de], a
	inc de
	cp "@"
	jr nz, .copy_nickname

	push hl
	ld a, [wOTPartyCount]
	dec a
	ld hl, wOTPartyMonNicknames
	ld bc, MON_NAME_LENGTH
	call AddNTimes
	ld d, h
	ld e, l
	ld hl, wStringBuffer2
	ld bc, MON_NAME_LENGTH
	call CopyBytes
	pop hl
	pop de

.no_nickname
; dvs?
	ld a, [wOtherTrainerType]
	bit TRAINERTYPE_DVS_F, a
	jr z, .no_dvs

	push hl
	ld a, [wOTPartyCount]
	dec a
	ld hl, wOTPartyMon1DVs
	call GetPartyLocation
	ld d, h
	ld e, l
	pop hl

; When reading DVs, treat PERFECT_DV as $ff
	call GetNextTrainerDataByte
	and a ; cp PERFECT_DV
	jr nz, .atk_def_dv_ok
	ld a, $ff
.atk_def_dv_ok
	ld [de], a
	inc de
	call GetNextTrainerDataByte
	and a ; cp PERFECT_DV
	jr nz, .spd_spc_dv_ok
	ld a, $ff
.spd_spc_dv_ok
	ld [de], a

.no_dvs
; evs?
	push hl
	ld a, [wOTPartyCount]
	dec a
	ld hl, wOTPartyMon1EVs
	call GetPartyLocation
	ld d, h
	ld e, l

	ld a, [wOtherTrainerType]
	bit TRAINERTYPE_EVS_F, a
	jr z, .auto_evs

	pop hl

	ld c, NUM_STATS
.evs_loop
	call GetNextTrainerDataByte
	ld [de], a
	inc de
	dec c
	jr nz, .evs_loop
	jr .evs_done

.auto_evs
	; auto-set all trainer EVs based on badges
    ld hl, wJohtoBadges

	bit RISINGBADGE, [hl]
	ld a, 252
	jr nz, .write_evs

	bit GLACIERBADGE, [hl]
	ld a, 223
	jr nz, .write_evs

	bit MINERALBADGE, [hl]
	ld a, 191
	jr nz, .write_evs

	bit STORMBADGE, [hl]
	ld a, 159
	jr nz, .write_evs

	bit FOGBADGE, [hl]
	ld a, 127
	jr nz, .write_evs

	bit PLAINBADGE, [hl]
	ld a, 95
	jr nz, .write_evs

	bit HIVEBADGE, [hl]
	ld a, 63
	jr nz, .write_evs

	bit ZEPHYRBADGE, [hl]
	ld a, 31
	jr nz, .write_evs

    ; No badges → 0 EVs
    xor a
    ; fallthrough

.write_evs:
rept NUM_STATS
    ld [de], a ; 'a' contains EV value
    inc de
endr
    pop hl

.evs_done
; item?
	ld a, [wOtherTrainerType]
	bit TRAINERTYPE_ITEM_F, a
	jr z, .no_item

	push hl
	ld a, [wOTPartyCount]
	dec a
	ld hl, wOTPartyMon1Item
	call GetPartyLocation
	ld d, h
	ld e, l
	pop hl

	call GetNextTrainerDataByte
	ld [de], a
.no_item
; moves?
	ld a, [wOtherTrainerType]
	bit TRAINERTYPE_MOVES_F, a
	jr z, .no_moves

	push hl
	ld a, [wOTPartyCount]
	dec a
	ld hl, wOTPartyMon1Moves
	call GetPartyLocation
	ld d, h
	ld e, l
	pop hl

	ld b, NUM_MOVES
.copy_moves
	call GetNextTrainerDataByte
	ld [de], a
	inc de
	dec b
	jr nz, .copy_moves

	push hl

	ld a, [wOTPartyCount]
	dec a
	ld hl, wOTPartyMon1
	call GetPartyLocation
	ld d, h
	ld e, l
	ld hl, MON_PP
	add hl, de

	push hl
	ld hl, MON_MOVES
	add hl, de
	pop de

	ld b, NUM_MOVES
.copy_pp
	ld a, [hli]
	and a
	jr z, .copied_pp

	push hl
	push bc
	dec a
	ld hl, Moves + MOVE_PP
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld a, BANK(Moves)
	call GetFarByte
	pop bc
	pop hl

	ld [de], a
	inc de
	dec b
	jr nz, .copy_pp

.copied_pp
	pop hl
.no_moves
; Custom DVs or EVs affect stats, so recalculate them 
; after TryAddMonToParty
	push hl

	ld a, [wOTPartyCount]
	dec a
	ld hl, wOTPartyMon1MaxHP
	call GetPartyLocation
	ld d, h
	ld e, l

	ld a, [wOTPartyCount]
	dec a
	ld hl, wOTPartyMon1EVs - 1
	call GetPartyLocation

; recalculate stats
	ld b, TRUE
	push de
	predef CalcMonStats
	pop hl

; copy max HP to current HP
	inc hl
	ld c, [hl]
	dec hl
	ld b, [hl]
	dec hl
	ld [hl], c
	dec hl
	ld [hl], b

	pop hl

	ld a, [wOtherTrainerType]
	bit TRAINERTYPE_RANDOM_F, a
	jr nz, .random_loop
	jmp .loop

.random_loop
	ld a, [wRandomTrainerNumPokemon]
	dec a
	ld [wRandomTrainerNumPokemon], a
	jmp nz, .start_random
	pop hl
	ret

ReadPlayerPartyAsTrainerParty:
    ; clear OT party count
	ld hl, wOTPartyCount
	xor a
	ld [hli], a
	dec a
	ld [hl], a

    ; clear OT party mons
	ld hl, wOTPartyMons
	ld bc, PARTYMON_STRUCT_LENGTH * PARTY_LENGTH
	xor a
	call ByteFill

; now get the trainer class and id so we can get the trainer name
	ld a, [wOtherTrainerClass]
	dec a
	ld c, a
	ld b, 0
	ld hl, TrainerGroups
	add hl, bc
	add hl, bc
    add hl, bc
	ld a, [hli]
	ld [wTrainerGroupBank], a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wOtherTrainerID]
	ld b, a
.skip_trainer
	dec b
	jr z, .got_trainer
.loop
	call GetNextTrainerDataByte
	cp -1
	jr nz, .loop
	jr .skip_trainer
.got_trainer

.skip_name
	call GetNextTrainerDataByte
	cp "@"
	jr nz, .skip_name

; here a is the trainer type eg TRAINERTYPE_ITEM_MOVES
	call GetNextTrainerDataByte
	ld [wOtherTrainerType], a

; hl is the trainer data from parties, copy it to de
	ld d, h
	ld e, l
	call ReadPlayerPartyAsTrainerPartyPieces

.done
	jp ComputeTrainerReward

ReadPlayerPartyAsTrainerPartyPieces:
; copy de back to hl, why?
	ld h, d
	ld l, e

	ld a, [wPartyCount]
	ld c, a
	ld b, 1

.loop
; end?
; are we at the end of the trainer data, ret if so
    push bc

; level
    ld hl, wPartyMon1Level
    pop bc
    call IncrementToCurrentMon
    push bc
	ld a, [hl]
    ld [wCurPartyLevel], a

; species
	ld hl, wPartyMon1Species
    pop bc
    call IncrementToCurrentMon
    push bc
	ld a, [hl]
	ld [wCurPartySpecies], a

; add to party
	ld a, OTPARTYMON
	ld [wMonType], a
	predef TryAddMonToParty

; DVs and EVs
    pop bc
    ld a, b
    cp 1
    push bc
    jp z, .firstMon
    cp 2
    jp z, .secondMon
    cp 3
    jp z, .thirdMon
    cp 4
    jp z, .forthMon
    cp 5
    jp z, .fifthMon
    cp 6
    jp z, .sixthMon

.firstMon
; First Mon DVs
    ld a, [wPartyMon1DVs]
    ld [wOTPartyMon1DVs], a
    ld a, [wPartyMon1DVs + 1]
    ld [wOTPartyMon1DVs + 1], a
; First Mon EVs
    ld a, [wPartyMon1HPEV]
    ld [wOTPartyMon1HPEV], a
    ld a, [wPartyMon1HPEV + 1]
    ld [wOTPartyMon1HPEV + 1], a
    ld a, [wPartyMon1AtkEV]
    ld [wOTPartyMon1AtkEV], a
    ld a, [wPartyMon1AtkEV + 1]
    ld [wOTPartyMon1AtkEV + 1], a
    ld a, [wPartyMon1DefEV]
    ld [wOTPartyMon1DefEV], a
    ld a, [wPartyMon1DefEV + 1]
    ld [wOTPartyMon1DefEV + 1], a
    ld a, [wPartyMon1SpdEV]
    ld [wOTPartyMon1SpdEV], a
    ld a, [wPartyMon1SpdEV + 1]
    ld [wOTPartyMon1SpdEV + 1], a
    ld a, [wPartyMon1SpclAtkEV]
    ld [wOTPartyMon1SpclAtkEV], a
    ld a, [wPartyMon1SpclAtkEV + 1]
    ld [wOTPartyMon1SpclAtkEV + 1], a
    ld a, [wPartyMon1SpclDefEV]
    ld [wOTPartyMon1SpclDefEV], a
    ld a, [wPartyMon1SpclDefEV + 1]
    ld [wOTPartyMon1SpclDefEV + 1], a
    jp .recalc

.secondMon
; Second Mon DVs
    ld a, [wPartyMon2DVs]
    ld [wOTPartyMon2DVs], a
    ld a, [wPartyMon2DVs + 1]
    ld [wOTPartyMon2DVs + 1], a
; Second Mon EVs
    ld a, [wPartyMon2HPEV]
    ld [wOTPartyMon2HPEV], a
    ld a, [wPartyMon2HPEV + 1]
    ld [wOTPartyMon2HPEV + 1], a
    ld a, [wPartyMon2AtkEV]
    ld [wOTPartyMon2AtkEV], a
    ld a, [wPartyMon2AtkEV + 1]
    ld [wOTPartyMon2AtkEV + 1], a
    ld a, [wPartyMon2DefEV]
    ld [wOTPartyMon2DefEV], a
    ld a, [wPartyMon2DefEV + 1]
    ld [wOTPartyMon2DefEV + 1], a
    ld a, [wPartyMon2SpdEV]
    ld [wOTPartyMon2SpdEV], a
    ld a, [wPartyMon2SpdEV + 1]
    ld [wOTPartyMon2SpdEV + 1], a
    ld a, [wPartyMon2SpclAtkEV]
    ld [wOTPartyMon2SpclAtkEV], a
    ld a, [wPartyMon2SpclAtkEV + 1]
    ld [wOTPartyMon2SpclAtkEV + 1], a
    ld a, [wPartyMon2SpclDefEV]
    ld [wOTPartyMon2SpclDefEV], a
    ld a, [wPartyMon2SpclDefEV + 1]
    ld [wOTPartyMon2SpclDefEV + 1], a
    jp .recalc

.thirdMon
; Third Mon DVs
    ld a, [wPartyMon3DVs]
    ld [wOTPartyMon3DVs], a
    ld a, [wPartyMon3DVs + 1]
    ld [wOTPartyMon3DVs + 1], a
; Third Mon EVs
    ld a, [wPartyMon3HPEV]
    ld [wOTPartyMon3HPEV], a
    ld a, [wPartyMon3HPEV + 1]
    ld [wOTPartyMon3HPEV + 1], a
    ld a, [wPartyMon3AtkEV]
    ld [wOTPartyMon3AtkEV], a
    ld a, [wPartyMon3AtkEV + 1]
    ld [wOTPartyMon3AtkEV + 1], a
    ld a, [wPartyMon3DefEV]
    ld [wOTPartyMon3DefEV], a
    ld a, [wPartyMon3DefEV + 1]
    ld [wOTPartyMon3DefEV + 1], a
    ld a, [wPartyMon3SpdEV]
    ld [wOTPartyMon3SpdEV], a
    ld a, [wPartyMon3SpdEV + 1]
    ld [wOTPartyMon3SpdEV + 1], a
    ld a, [wPartyMon3SpclAtkEV]
    ld [wOTPartyMon3SpclAtkEV], a
    ld a, [wPartyMon3SpclAtkEV + 1]
    ld [wOTPartyMon3SpclAtkEV + 1], a
    ld a, [wPartyMon3SpclDefEV]
    ld [wOTPartyMon3SpclDefEV], a
    ld a, [wPartyMon3SpclDefEV + 1]
    ld [wOTPartyMon3SpclDefEV + 1], a
    jp .recalc

.forthMon
; Fourth Mon DVs
    ld a, [wPartyMon4DVs]
    ld [wOTPartyMon4DVs], a
    ld a, [wPartyMon4DVs + 1]
    ld [wOTPartyMon4DVs + 1], a
; Fourth Mon EVs
    ld a, [wPartyMon4HPEV]
    ld [wOTPartyMon4HPEV], a
    ld a, [wPartyMon4HPEV + 1]
    ld [wOTPartyMon4HPEV + 1], a
    ld a, [wPartyMon4AtkEV]
    ld [wOTPartyMon4AtkEV], a
    ld a, [wPartyMon4AtkEV + 1]
    ld [wOTPartyMon4AtkEV + 1], a
    ld a, [wPartyMon4DefEV]
    ld [wOTPartyMon4DefEV], a
    ld a, [wPartyMon4DefEV + 1]
    ld [wOTPartyMon4DefEV + 1], a
    ld a, [wPartyMon4SpdEV]
    ld [wOTPartyMon4SpdEV], a
    ld a, [wPartyMon4SpdEV + 1]
    ld [wOTPartyMon4SpdEV + 1], a
    ld a, [wPartyMon4SpclAtkEV]
    ld [wOTPartyMon4SpclAtkEV], a
    ld a, [wPartyMon4SpclAtkEV + 1]
    ld [wOTPartyMon4SpclAtkEV + 1], a
    ld a, [wPartyMon4SpclDefEV]
    ld [wOTPartyMon4SpclDefEV], a
    ld a, [wPartyMon4SpclDefEV + 1]
    ld [wOTPartyMon4SpclDefEV + 1], a
    jp .recalc

.fifthMon
; Fifth Mon DVs
    ld a, [wPartyMon5DVs]
    ld [wOTPartyMon5DVs], a
    ld a, [wPartyMon5DVs + 1]
    ld [wOTPartyMon5DVs + 1], a
; Fifth Mon EVs
    ld a, [wPartyMon5HPEV]
    ld [wOTPartyMon5HPEV], a
    ld a, [wPartyMon5HPEV + 1]
    ld [wOTPartyMon5HPEV + 1], a
    ld a, [wPartyMon5AtkEV]
    ld [wOTPartyMon5AtkEV], a
    ld a, [wPartyMon5AtkEV + 1]
    ld [wOTPartyMon5AtkEV + 1], a
    ld a, [wPartyMon5DefEV]
    ld [wOTPartyMon5DefEV], a
    ld a, [wPartyMon5DefEV + 1]
    ld [wOTPartyMon5DefEV + 1], a
    ld a, [wPartyMon5SpdEV]
    ld [wOTPartyMon5SpdEV], a
    ld a, [wPartyMon5SpdEV + 1]
    ld [wOTPartyMon5SpdEV + 1], a
    ld a, [wPartyMon5SpclAtkEV]
    ld [wOTPartyMon5SpclAtkEV], a
    ld a, [wPartyMon5SpclAtkEV + 1]
    ld [wOTPartyMon5SpclAtkEV + 1], a
    ld a, [wPartyMon5SpclDefEV]
    ld [wOTPartyMon5SpclDefEV], a
    ld a, [wPartyMon5SpclDefEV + 1]
    ld [wOTPartyMon5SpclDefEV + 1], a
    jp .recalc

.sixthMon
; Sixth Mon DVs
    ld a, [wPartyMon6DVs]
    ld [wOTPartyMon6DVs], a
    ld a, [wPartyMon6DVs + 1]
    ld [wOTPartyMon6DVs + 1], a
; Sixth Mon EVs
    ld a, [wPartyMon6HPEV]
    ld [wOTPartyMon6HPEV], a
    ld a, [wPartyMon6HPEV + 1]
    ld [wOTPartyMon6HPEV + 1], a
    ld a, [wPartyMon6AtkEV]
    ld [wOTPartyMon6AtkEV], a
    ld a, [wPartyMon6AtkEV + 1]
    ld [wOTPartyMon6AtkEV + 1], a
    ld a, [wPartyMon6DefEV]
    ld [wOTPartyMon6DefEV], a
    ld a, [wPartyMon6DefEV + 1]
    ld [wOTPartyMon6DefEV + 1], a
    ld a, [wPartyMon6SpdEV]
    ld [wOTPartyMon6SpdEV], a
    ld a, [wPartyMon6SpdEV + 1]
	ld [wOTPartyMon6SpdEV + 1], a
    ld a, [wPartyMon6SpclAtkEV]
    ld [wOTPartyMon6SpclAtkEV], a
    ld a, [wPartyMon6SpclAtkEV + 1]
    ld [wOTPartyMon6SpclAtkEV + 1], a
    ld a, [wPartyMon6SpclDefEV]
    ld [wOTPartyMon6SpclDefEV], a
    ld a, [wPartyMon6SpclDefEV + 1]
    ld [wOTPartyMon6SpclDefEV + 1], a

.recalc
; Custom DVs and Effort Values affect stats,
; so recalculate them after TryAddMonToParty
	push hl

	ld a, [wOTPartyCount]
	dec a
	ld hl, wOTPartyMon1MaxHP
	call GetPartyLocation
	ld d, h
	ld e, l

	ld a, [wOTPartyCount]
	dec a
	ld hl, wOTPartyMon1EVs - 1
	call GetPartyLocation

; recalculate stats
	ld b, TRUE
	push de
	predef CalcMonStats
	pop hl

; copy max HP to current HP
	inc hl
	ld c, [hl]
	dec hl
	ld b, [hl]
	dec hl
	ld [hl], c
	dec hl
	ld [hl], b
	pop hl

    pop bc
    inc b
	dec c
    jp nz, .loop

    ; items
    ld a, [wPartyMon1Item]
    ld [wOTPartyMon1Item], a
    ld a, [wPartyMon2Item]
    ld [wOTPartyMon2Item], a
    ld a, [wPartyMon3Item]
    ld [wOTPartyMon3Item], a
    ld a, [wPartyMon4Item]
    ld [wOTPartyMon4Item], a
    ld a, [wPartyMon5Item]
    ld [wOTPartyMon5Item], a
    ld a, [wPartyMon6Item]
    ld [wOTPartyMon6Item], a

    ; moves
    ld a, [wPartyMon1Moves]
    ld [wOTPartyMon1Moves], a
    ld a, [wPartyMon1Moves + 1]
    ld [wOTPartyMon1Moves + 1], a
    ld a, [wPartyMon1Moves + 2]
    ld [wOTPartyMon1Moves + 2], a
    ld a, [wPartyMon1Moves + 3]
    ld [wOTPartyMon1Moves + 3], a

    ld a, [wPartyMon2Moves]
    ld [wOTPartyMon2Moves], a
    ld a, [wPartyMon2Moves + 1]
    ld [wOTPartyMon2Moves + 1], a
    ld a, [wPartyMon2Moves + 2]
    ld [wOTPartyMon2Moves + 2], a
    ld a, [wPartyMon2Moves + 3]
    ld [wOTPartyMon2Moves + 3], a

    ld a, [wPartyMon3Moves]
    ld [wOTPartyMon3Moves], a
    ld a, [wPartyMon3Moves + 1]
    ld [wOTPartyMon3Moves + 1], a
    ld a, [wPartyMon3Moves + 2]
    ld [wOTPartyMon3Moves + 2], a
    ld a, [wPartyMon3Moves + 3]
    ld [wOTPartyMon3Moves + 3], a

    ld a, [wPartyMon4Moves]
    ld [wOTPartyMon4Moves], a
    ld a, [wPartyMon4Moves + 1]
    ld [wOTPartyMon4Moves + 1], a
    ld a, [wPartyMon4Moves + 2]
    ld [wOTPartyMon4Moves + 2], a
    ld a, [wPartyMon4Moves + 3]
    ld [wOTPartyMon4Moves + 3], a

    ld a, [wPartyMon5Moves]
    ld [wOTPartyMon5Moves], a
    ld a, [wPartyMon5Moves + 1]
    ld [wOTPartyMon5Moves + 1], a
    ld a, [wPartyMon5Moves + 2]
    ld [wOTPartyMon5Moves + 2], a
    ld a, [wPartyMon5Moves + 3]
    ld [wOTPartyMon5Moves + 3], a

    ld a, [wPartyMon6Moves]
    ld [wOTPartyMon6Moves], a
    ld a, [wPartyMon6Moves + 1]
    ld [wOTPartyMon6Moves + 1], a
    ld a, [wPartyMon6Moves + 2]
    ld [wOTPartyMon6Moves + 2], a
    ld a, [wPartyMon6Moves + 3]
    ld [wOTPartyMon6Moves + 3], a

    ; PP
    ld a, [wPartyMon1PP]
    ld [wOTPartyMon1PP], a
    ld a, [wPartyMon1PP + 1]
    ld [wOTPartyMon1PP + 1], a
    ld a, [wPartyMon1PP + 2]
    ld [wOTPartyMon1PP + 2], a
    ld a, [wPartyMon1PP + 3]
    ld [wOTPartyMon1PP + 3], a

    ld a, [wPartyMon2PP]
    ld [wOTPartyMon2PP], a
    ld a, [wPartyMon2PP + 1]
    ld [wOTPartyMon2PP + 1], a
    ld a, [wPartyMon2PP + 2]
    ld [wOTPartyMon2PP + 2], a
    ld a, [wPartyMon2PP + 3]
    ld [wOTPartyMon2PP + 3], a

    ld a, [wPartyMon3PP]
    ld [wOTPartyMon3PP], a
    ld a, [wPartyMon3PP + 1]
    ld [wOTPartyMon3PP + 1], a
    ld a, [wPartyMon3PP + 2]
    ld [wOTPartyMon3PP + 2], a
    ld a, [wPartyMon3PP + 3]
    ld [wOTPartyMon3PP + 3], a

    ld a, [wPartyMon4PP]
    ld [wOTPartyMon4PP], a
    ld a, [wPartyMon4PP + 1]
    ld [wOTPartyMon4PP + 1], a
    ld a, [wPartyMon4PP + 2]
    ld [wOTPartyMon4PP + 2], a
    ld a, [wPartyMon4PP + 3]
    ld [wOTPartyMon4PP + 3], a

    ld a, [wPartyMon5PP]
    ld [wOTPartyMon5PP], a
    ld a, [wPartyMon5PP + 1]
    ld [wOTPartyMon5PP + 1], a
    ld a, [wPartyMon5PP + 2]
    ld [wOTPartyMon5PP + 2], a
    ld a, [wPartyMon5PP + 3]
    ld [wOTPartyMon5PP + 3], a

    ld a, [wPartyMon6PP]
    ld [wOTPartyMon6PP], a
    ld a, [wPartyMon6PP + 1]
    ld [wOTPartyMon6PP + 1], a
    ld a, [wPartyMon6PP + 2]
    ld [wOTPartyMon6PP + 2], a
    ld a, [wPartyMon6PP + 3]
    ld [wOTPartyMon6PP + 3], a

    ret

IncrementToCurrentMon:
    ld a, b
.incrementLoop
    dec a
    jr z, .incrementDone
rept 48
    inc hl
endr
    jr .incrementLoop
.incrementDone
    ret

IncrementMovesToCurrentMon:
    ld a, b
.incrementLoop
    dec a
    jr z, .incrementDone
    inc hl
    inc hl
    inc hl
    inc hl
    jr .incrementLoop
.incrementDone
    ret

ComputeTrainerReward:
	ld hl, hProduct
	xor a
	ld [hli], a
	ld [hli], a ; hMultiplicand + 0
	ld [hli], a ; hMultiplicand + 1
	ld a, [wEnemyTrainerBaseReward]
	ld [hli], a ; hMultiplicand + 2
	ld a, [wCurPartyLevel]
	ld [hl], a ; hMultiplier
	call Multiply
	ld hl, wBattleReward
	xor a
	ld [hli], a
	ldh a, [hProduct + 2]
	ld [hli], a
	ldh a, [hProduct + 3]
	ld [hl], a
	ret

Battle_GetTrainerName::
	ld a, [wInBattleTowerBattle]
	bit 0, a
	ld hl, wOTPlayerName
	ld a, BANK(Battle_GetTrainerName)
	ld [wTrainerGroupBank], a
	jr nz, CopyTrainerName

	ld a, [wOtherTrainerID]
	ld b, a
	ld a, [wOtherTrainerClass]
	ld c, a

GetTrainerName::
	ld a, c
	ld hl, wRivalName
	cp RIVAL1
	jr z, CopyTrainerName
	cp RIVAL2
	jr z, CopyTrainerName

	dec c
	push bc
	ld b, 0
	ld hl, TrainerGroups
	add hl, bc
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld [wTrainerGroupBank], a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	pop bc

.loop
	dec b
	jr z, CopyTrainerName

.skip
	call GetNextTrainerDataByte
	cp -1
	jr nz, .skip
	jr .loop

CopyTrainerName:
	ld de, wStringBuffer1
	push de
	ld bc, NAME_LENGTH
	ld a, [wTrainerGroupBank]
	call FarCopyBytes
	pop de
	ret

INCLUDE "data/trainers/party_pointers.asm"

SetTrainerBattleLevel:
 	ld a, 255
 	ld [wCurPartyLevel], a
 
 	ld a, [wInBattleTowerBattle]
 	bit 0, a
 	ret nz
 
 	ld a, [wLinkMode]
 	and a
 	ret nz
 
 	ld a, [wOtherTrainerClass]
 	dec a
 	ld c, a
 	ld b, 0
 	ld hl, TrainerGroups
 	add hl, bc
 	add hl, bc
 	ld a, [hli]
 	ld h, [hl]
 	ld l, a
 
 	ld a, [wOtherTrainerID]
 	ld b, a
 .skip_trainer
 	dec b
 	jr z, .got_trainer
 .skip_party
 	ld a, [hli]
 	cp $ff
 	jr nz, .skip_party
 	jr .skip_trainer
 .got_trainer
 
 .skip_name
 	ld a, [hli]
 	cp "@"
 	jr nz, .skip_name
 
 	inc hl
 	ld a, [hl]
 	ld [wCurPartyLevel], a
 	ret
