LoadOpponentTrainerAndPokemon:
	ldh a, [rSVBK]
	push af
	ld a, BANK(wBT_OTTrainer)
	ldh [rSVBK], a

	; Fill wBT_OTTrainer with zeros
	xor a
	ld hl, wBT_OTTrainer
	ld bc, BATTLE_TOWER_STRUCT_LENGTH
	call ByteFill

	; Write $ff into the Item-Slots
	ld a, $ff
	ld [wBT_OTMon1Item], a
	ld [wBT_OTMon2Item], a
	ld [wBT_OTMon3Item], a

	; Set wBT_OTTrainer as start address to write the following data to
	ld de, wBT_OTTrainer

	ldh a, [hRandomAdd]
	ld b, a
.resample ; loop to find a random trainer
	call Random
	ldh a, [hRandomAdd]
	add b
	ld b, a ; b contains the nr of the trainer
	maskbits BATTLETOWER_NUM_UNIQUE_TRAINERS
	cp BATTLETOWER_NUM_UNIQUE_TRAINERS
	jr nc, .resample

	ld b, a
	ld a, BANK(sBTTrainers)
	call OpenSRAM

	ld c, BATTLETOWER_STREAK_LENGTH
	ld hl, sBTTrainers
.next_trainer
	ld a, [hli]
	cp b
	jr z, .resample
	dec c
	jr nz, .next_trainer ; c <= 7  initialise all 7 trainers?

	ld hl, sBTTrainers
	ld a, [sNrOfBeatenBattleTowerTrainers]
	ld c, a
	ld a, b
	ld b, 0
	add hl, bc
	ld [hl], a

	call CloseSRAM

	push af
; Copy name (10 bytes) and class (1 byte) of trainer
	ld hl, BattleTowerTrainers
	ld bc, NAME_LENGTH
	call AddNTimes
	ld bc, NAME_LENGTH
	call CopyBytes

	call LoadRandomBattleTowerMon
	pop af

	ld hl, BattleTowerTrainerData
	ld bc, BATTLETOWER_TRAINERDATALENGTH
	call AddNTimes
	ld bc, BATTLETOWER_TRAINERDATALENGTH
.copy_bt_trainer_data_loop
	ld a, BANK(BattleTowerTrainerData)
	call GetFarByte
	ld [de], a
	inc hl
	inc de
	dec bc
	ld a, b
	or c
	jr nz, .copy_bt_trainer_data_loop

	pop af
	ldh [rSVBK], a

	ret

LoadRandomBattleTowerMon:
	ld a, BATTLETOWER_ENEMY_PARTY_LENGTH
	ld c, a
.loop
	push bc
	ld a, BANK(sBTMonOfTrainers)
	call OpenSRAM

.FindARandomBattleTowerMon:
	; Pick a compact mon from the pools of the selected challenge.
	call PickRandomBattleTowerCompactMon
	ld c, a ; selected species

	; Ensure species uniqueness across the current generated team.
	push hl
	push de
	ld hl, wBT_OTMon1
.current_team_loop
	ld a, h
	cp d
	jr nz, .check_current_team_species
	ld a, l
	cp e
	jr z, .current_team_done

.check_current_team_species
	ld a, [hl]
	cp c
	jr z, .current_team_duplicate
	push bc
	ld bc, NICKNAMED_MON_STRUCT_LENGTH
	add hl, bc
	pop bc
	jr .current_team_loop

.current_team_duplicate
	pop de
	pop hl
	jr .FindARandomBattleTowerMon

.current_team_done
	pop de
	pop hl

	; Also avoid species from the two previous trainer teams
	; (three tracked species each).
	ld a, [sBTMonPrevTrainer1]
	cp c
	jr z, .FindARandomBattleTowerMon

	ld a, [sBTMonPrevTrainer2]
	cp c
	jr z, .FindARandomBattleTowerMon

	ld a, [sBTMonPrevTrainer3]
	cp c
	jr z, .FindARandomBattleTowerMon

	ld a, [sBTMonPrevPrevTrainer1]
	cp c
	jr z, .FindARandomBattleTowerMon

	ld a, [sBTMonPrevPrevTrainer2]
	cp c
	jr z, .FindARandomBattleTowerMon

	ld a, [sBTMonPrevPrevTrainer3]
	cp c
	jr z, .FindARandomBattleTowerMon

	call ExpandBattleTowerCompactMon
	pop bc
	dec c
	jr nz, .loop

	; Champ's final battle must feature a Mewtwo somewhere in the team.
	call MaybeForceChampFinalMewtwo

	ld a, [sBTMonPrevTrainer1]
	ld [sBTMonPrevPrevTrainer1], a
	ld a, [sBTMonPrevTrainer2]
	ld [sBTMonPrevPrevTrainer2], a
	ld a, [sBTMonPrevTrainer3]
	ld [sBTMonPrevPrevTrainer3], a
	ld a, [wBT_OTMon1]
	ld [sBTMonPrevTrainer1], a
	ld a, [wBT_OTMon2]
	ld [sBTMonPrevTrainer2], a
	ld a, [wBT_OTMon3]
	ld [sBTMonPrevTrainer3], a
	jmp CloseSRAM

MaybeForceChampFinalMewtwo:
; The final battle of a Champ challenge always includes a Mewtwo,
; placed at a random slot of the already generated team (unless a
; Mewtwo was rolled naturally). The forced record itself is picked
; at random among the variant records grouped under
; BattleTowerMon_Mewtwo. Called with SRAM open on
; BANK(sBTMonOfTrainers) -- same section as sNrOfBeatenBattleTowerTrainers --
; and SVBK = BANK(wBT_OTTrainer). Preserves de, the caller's write cursor.
	push de
	call GetBattleTowerChallengeIndex
	cp BATTLETOWER_CHALLENGE_CHAMP ; 0 and 1 read as Elite, 2+ as Champ
	jr c, .done
	ld a, [sNrOfBeatenBattleTowerTrainers]
	cp BATTLETOWER_STREAK_LENGTH - 1 ; two wins in = pending final battle
	jr nz, .done

	; If the team already contains a Mewtwo, the requirement is met.
	ld hl, wBT_OTMon1
	ld c, BATTLETOWER_ENEMY_PARTY_LENGTH
.check_team
	ld a, [hl]
	cp MEWTWO
	jr z, .done
	ld de, NICKNAMED_MON_STRUCT_LENGTH
	add hl, de
	dec c
	jr nz, .check_team

	; Pick one of the Mewtwo variant records under the label at random,
	; then expand it over a random team slot (0 to 5), so every variant
	; has an equal chance at the guaranteed spot.
	ld a, (BattleTowerPool_ChampEnd - BattleTowerMon_Mewtwo) / BATTLETOWER_MON_STRUCT_LENGTH
	call RandomRange
	ld hl, BattleTowerMon_Mewtwo
	ld bc, BATTLETOWER_MON_STRUCT_LENGTH
	call AddNTimes
	push hl
	ld a, BATTLETOWER_ENEMY_PARTY_LENGTH
	call RandomRange
	ld hl, wBT_OTMon1
	ld bc, NICKNAMED_MON_STRUCT_LENGTH
	call AddNTimes
	ld d, h
	ld e, l
	pop hl
	ld b, BANK(BattleTowerMon_Mewtwo)
	call ExpandBattleTowerCompactMon
.done
	pop de
	ret

PickRandomBattleTowerCompactMon:
; Return a: species, b: bank, hl: compact bt_mon entry. Preserve de, since
; the caller keeps the wBT_OTTrainer write cursor there.
	push de
	call GetBattleTowerChallengePools
	ld a, [hli] ; pool count for this challenge
	call RandomRange
	ld bc, BATTLETOWER_CHALLENGE_POOL_ENTRY_LENGTH
	call AddNTimes

	ld a, [hli]
	ld b, a ; compact pool bank
	ld a, [hli]
	ld e, a ; compact pool address low
	ld a, [hli]
	ld d, a ; compact pool address high
	ld a, [hl] ; compact pool entry count
	ld c, a

	ld a, b
	ldh [hTempBank], a
	ld a, c
	call RandomRange
	ld h, d
	ld l, e
	ld bc, BATTLETOWER_MON_STRUCT_LENGTH
	call AddNTimes

	ldh a, [hTempBank]
	ld b, a
	call GetFarByte
	pop de
	ret

GetBattleTowerChallengePools:
; Return hl at the BattleTowerChallengePools record for wBTChoiceOfLvlGroup.
	ld hl, BattleTowerChallengePools
	call GetBattleTowerChallengeIndex
	and a
	jr nz, .got_challenge
	ld a, BATTLETOWER_CHALLENGE_ELITE

.got_challenge
	cp NUM_BATTLETOWER_CHALLENGES + 1
	jr c, .challenge_ok
	ld a, BATTLETOWER_CHALLENGE_CHAMP

.challenge_ok
	dec a
	ld d, a
.skip_challenge
	ld a, d
	and a
	ret z
	ld a, [hli] ; pool count
	ld c, a
	ld b, 0
	add hl, bc
	add hl, bc
	add hl, bc
	add hl, bc
	dec d
	jr .skip_challenge

GetBattleTowerChallengeLevel:
; Battle Tower mons always fight at BATTLETOWER_LEVEL.
	ld a, BATTLETOWER_LEVEL
	ret

GetBattleTowerChallengeIndex:
; wBTChoiceOfLvlGroup lives in Battle Tower WRAMX, but these helpers also
; run with the party WRAMX bank selected, so bank-switch around the read.
	ldh a, [rSVBK]
	push af
	ld a, BANK(wBTChoiceOfLvlGroup)
	ldh [rSVBK], a
	ld a, [wBTChoiceOfLvlGroup]
	ld c, a
	pop af
	ldh [rSVBK], a
	ld a, c
	ret

ExpandBattleTowerCompactMon:
; Expand compact species/item/moves from b:hl into the full mon at de.
	push de
	call ExpandBattleTowerCompactMonToTemp
	pop de
	ld hl, wBT_OTTempMon1
	ld bc, NICKNAMED_MON_STRUCT_LENGTH
	jmp CopyBytes

ExpandBattleTowerCompactMonToTemp:
; Materialize compact species/item/moves from b:hl in wBT_OTTempMon1.
; Stats are generated in WRAM0 scratch so CalcMonStats can read the
; bank-1 base data while writing the Battle Tower mon.
	ld de, wBT_OTTempMon1
	ld c, BATTLETOWER_MON_STRUCT_LENGTH
.copy_compact_mon_loop
	ld a, b
	call GetFarByte
	ld [de], a
	inc hl
	inc de
	dec c
	jr nz, .copy_compact_mon_loop

	ld h, d
	ld l, e
	xor a
	ld bc, PARTYMON_STRUCT_LENGTH - BATTLETOWER_MON_STRUCT_LENGTH
	call ByteFill

	call GetBattleTowerChallengeLevel
	ld [wBT_OTTempMon1Level], a

	ldh a, [rSVBK]
	push af
	ld a, BANK(wCurPartyLevel)
	ldh [rSVBK], a

	ld a, [wBT_OTTempMon1]
	ld [wCurSpecies], a
	ld [wCurPartySpecies], a
	call GetBaseData

	ld a, [wBT_OTTempMon1Level]
	ld [wCurPartyLevel], a
	ld d, a
	callfar CalcExpAtLevel
	ldh a, [hMultiplicand]
	ld [wBT_OTTempMon1Exp], a
	ldh a, [hMultiplicand + 1]
	ld [wBT_OTTempMon1Exp + 1], a
	ldh a, [hMultiplicand + 2]
	ld [wBT_OTTempMon1Exp + 2], a

	; All Battle Tower mons fight with maxed effort values (252 per stat).
	; DVs stay zero (see the notes in data/battle_tower/parties.asm);
	; they were cleared by the ByteFill above.
	ld a, 252
	ld hl, wBT_OTTempMon1EVs
	ld c, NUM_STATS
.ev_loop
	ld [hli], a
	dec c
	jr nz, .ev_loop

	ld hl, wBT_OTTempMon1Moves
	ld de, wBT_OTTempMon1PP
	predef FillPP
	ld a, 100
	ld [wBT_OTTempMon1Happiness], a

	ld de, wBT_OTTempMon1MaxHP
	ld hl, wBT_OTTempMon1EVs - 1
	ld b, TRUE
	predef CalcMonStats

	ld hl, wBT_OTTempMon1MaxHP
	ld de, wBT_OTTempMon1HP
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a

	ld a, [wNamedObjectIndex]
	push af
	ld a, [wBT_OTTempMon1]
	ld [wNamedObjectIndex], a
	call GetPokemonName
	ld h, d
	ld l, e
	ld de, wBT_OTTempMon1Name
	ld bc, MON_NAME_LENGTH
	call CopyBytes
	pop af
	ld [wNamedObjectIndex], a

	pop af
	ldh [rSVBK], a
	ret

BattleTower_GenerateRandomPlayerParty:
; Random Battle replaces the live WRAM party only; the saved party is
; restored by LoadPokemonData after the battle, before script control
; resumes. Uses the same challenge pools as the enemy team.
	ldh a, [rSVBK]
	push af
	ld a, BANK(wPartyCount)
	ldh [rSVBK], a

	ld a, BATTLETOWER_ENEMY_PARTY_LENGTH
	ld [wPartyCount], a
	push af
	ld a, $ff
	ld hl, wPartySpecies
	ld bc, PARTY_LENGTH + 1
	call ByteFill

	xor a
	ld [wCurPartyMon], a
	pop af
	ld b, a

.party_loop
	push bc
.find_unique_mon
	call PickRandomBattleTowerCompactMon
	ld c, a ; selected species
	call .SelectedSpeciesAlreadyInPlayerTeam
	jr c, .find_unique_mon

	call ExpandBattleTowerCompactMonToTemp

	ld hl, wPartySpecies
	ld a, [wCurPartyMon]
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [wBT_OTTempMon1]
	ld [hl], a

	ld a, MON_SPECIES
	call GetPartyParamLocation
	ld d, h
	ld e, l
	ld hl, wBT_OTTempMon1
	ld bc, PARTYMON_STRUCT_LENGTH
	call CopyBytes

	ld hl, wPartyMonNicknames
	ld a, [wCurPartyMon]
	call SkipNames
	ld d, h
	ld e, l
	ld hl, wBT_OTTempMon1Name
	ld bc, MON_NAME_LENGTH
	call CopyBytes

	ld hl, wPartyMonOTs
	ld a, [wCurPartyMon]
	call SkipNames
	ld d, h
	ld e, l
	ld hl, wPlayerName
	ld bc, NAME_LENGTH
	call CopyBytes

	ld a, [wCurPartyMon]
	inc a
	ld [wCurPartyMon], a
	pop bc
	dec b
	jr nz, .party_loop

	pop af
	ldh [rSVBK], a
	ret

.SelectedSpeciesAlreadyInPlayerTeam:
; Input c: selected species. Preserve b:hl so the compact pointer survives.
	push hl
	push bc
	ld a, [wCurPartyMon]
	and a
	jr z, .not_found
	ld b, a
	ld hl, wPartySpecies

.current_team_loop
	ld a, [hli]
	cp c
	jr z, .found
	dec b
	jr nz, .current_team_loop

.not_found
	and a
	pop bc
	pop hl
	ret

.found
	scf
	pop bc
	pop hl
	ret

INCLUDE "data/battle_tower/classes.asm"
INCLUDE "data/battle_tower/parties.asm"
