; Six-Pokemon Battle Factory: persistent rentals and up to two exchanges.
; the player's save holds their own party,
; and exchanges offer the previous trainer's original sets, not fainted mons.

BattleFactory_Start::
	call ReanchorMap
	call FadeToMenu
	farcall BattleTower_GenerateRandomPlayerParty
	call BattleFactory_SetRentalOTs
	call BattleFactory_SaveTeam
	; Generate exactly one fresh set of six. Revisiting Exchange never rerolls it.
	farcall BattleTower_GenerateRandomPlayerParty
	call BattleFactory_SetRentalOTs
	call BattleFactory_SaveOffers
	xor a
	ld hl, sFactoryOfferKind
	call BattleFactory_WriteByte
	jr BattleFactory_RunExchange

BattleFactory_ExchangeDefeatedTeam::
	call ReanchorMap
	call FadeToMenu
	call BattleFactory_CopyOpponentParty
	call BattleFactory_SaveOffers
	ld a, 1
	ld hl, sFactoryOfferKind
	call BattleFactory_WriteByte
BattleFactory_RunExchange:
	call BattleFactory_LoadTeam
	farcall BattleFactory_Menu
	; Rentals are only live during battles and this menu, never on the map/save.
	farcall LoadPokemonData
	call CloseSubmenu
	jmp CloseText

BattleFactory_LoadBattleParty::
	; An older Random Battle save has no rental template yet.
	ld hl, sBattleFactoryCheck
	call BattleFactory_ReadByte
	cp BATTLE_FACTORY_CHECK
	jr nz, .initialize
	ld hl, sBattleFactoryTeam
	call BattleFactory_ReadByte
	cp PARTY_LENGTH
	jr z, .load
.initialize
	farcall BattleTower_GenerateRandomPlayerParty
	call BattleFactory_SetRentalOTs
	call BattleFactory_SaveTeam
.load
	call BattleFactory_LoadTeam
	farcall HealParty
	farjp MaximizePlayerPartyPP

BattleFactory_SaveTeam::
	ld de, sBattleFactoryTeam
	call BattleFactory_SaveParty
	ld a, BATTLE_FACTORY_CHECK
	ld hl, sBattleFactoryCheck
	jr BattleFactory_WriteByte

BattleFactory_SaveOffers::
	ld de, sBattleFactoryOffers
BattleFactory_SaveParty:
	ld a, BANK(sBattleFactoryTeam)
	call OpenSRAM
	ld hl, wPartyCount
	ld bc, BATTLE_FACTORY_PARTY_DATA_LENGTH
	ld a, BANK(wPartyCount)
	call FarCopyWRAM
	jmp CloseSRAM

BattleFactory_LoadTeam::
	ld hl, sBattleFactoryTeam
	jr BattleFactory_LoadParty

BattleFactory_LoadOffers::
	ld hl, sBattleFactoryOffers
BattleFactory_LoadParty:
	ld a, BANK(sBattleFactoryTeam)
	call OpenSRAM
	ld de, wPartyCount
	ld bc, BATTLE_FACTORY_PARTY_DATA_LENGTH
	ld a, BANK(wPartyCount)
	call FarCopyWRAM
	jmp CloseSRAM

BattleFactory_ReadByte::
; Read SRAM byte hl; preserve the other registers and WRAM bank.
	ld a, BANK(sBattleFactoryTeam)
	call OpenSRAM
	ld a, [hl]
	jmp CloseSRAM

BattleFactory_WriteByte::
; Write a to SRAM byte hl.
	push af
	ld a, BANK(sBattleFactoryTeam)
	call OpenSRAM
	pop af
	ld [hl], a
	jmp CloseSRAM

BattleFactory_SwapRentals::
; Reorder complete rental records without touching the player's saved mail.
	ld hl, sFactoryMoveSlot
	call BattleFactory_ReadByte
	ld [wSwitchMonFrom], a
	ld hl, sFactoryCursor
	call BattleFactory_ReadByte
	ld [wSwitchMonTo], a
	ld hl, wPartySpecies
	ld bc, 1
	call .Swap
	ld hl, wPartyMons
	ld bc, PARTYMON_STRUCT_LENGTH
	call .Swap
	ld hl, wPartyMonOTs
	ld bc, NAME_LENGTH
	call .Swap
	ld hl, wPartyMonNicknames
	ld bc, MON_NAME_LENGTH
	call .Swap
	jmp BattleFactory_SaveTeam

.Swap:
; Swap the two bc-byte records in the array at hl.
	push bc
	push hl
	ld a, [wSwitchMonTo]
	call AddNTimes
	ld d, h
	ld e, l
	pop hl
	push de
	ld a, [wSwitchMonFrom]
	call AddNTimes
	pop de
	pop bc
.loop
	ld a, [de]
	push af
	ld a, [hl]
	ld [de], a
	pop af
	ld [hli], a
	inc de
	dec bc
	ld a, b
	or c
	jr nz, .loop
	ret

BattleFactory_CopyOpponentParty::
; The six original full records in wBT_OTTrainer survive battle. Copy through
; WRAM0 so the source in bank 3 and the party in bank 1 never alias.
	ld a, PARTY_LENGTH
	ld [wPartyCount], a
	ld a, -1
	ld [wPartyEnd], a
	xor a
	ld [wCurPartyMon], a
.loop
	ld a, [wCurPartyMon]
	ld hl, wBT_OTMon1
	ld bc, NICKNAMED_MON_STRUCT_LENGTH
	call AddNTimes
	ld de, wBT_OTTempMon1
	ld bc, NICKNAMED_MON_STRUCT_LENGTH
	ld a, BANK(wBT_OTTrainer)
	call FarCopyWRAM
	call BattleFactory_CopyTempToParty
	ld hl, wCurPartyMon
	inc [hl]
	ld a, [hl]
	cp PARTY_LENGTH
	jr c, .loop
	farcall HealParty
	farcall MaximizePlayerPartyPP
	; fallthrough

BattleFactory_SetRentalOTs::
	ld de, wPartyMonOTs
	ld b, PARTY_LENGTH
.loop
	push bc
	ld hl, .RentalOT
	ld bc, NAME_LENGTH
	call CopyBytes
	pop bc
	dec b
	jr nz, .loop
	ret
.RentalOT
	db "Factory@@@@"
	assert @ - .RentalOT == NAME_LENGTH

BattleFactory_CopyTempToParty:
	ld a, [wCurPartyMon]
	ld hl, wPartySpecies
	ld e, a
	ld d, 0
	add hl, de
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
	jmp CopyBytes

BattleFactory_CommitExchange::
; Apply tentative selections to the live party. On failure restore the offer
; screen; the SRAM rental template is not changed until the whole team is legal.
	ld hl, sFactoryOutCount
	call BattleFactory_ReadByte
	and a
	jr z, .invalid
	cp BATTLE_FACTORY_MAX_EXCHANGES + 1
	jr nc, .invalid
	ld b, a
	ld hl, sFactoryInCount
	call BattleFactory_ReadByte
	cp b
	jr nz, .invalid
	call BattleFactory_LoadTeam
	ld hl, sFactoryOutCount
	call BattleFactory_ReadByte
	ld b, a
	ld c, 0
.loop
	push bc
	ld b, 0
	ld hl, sFactoryOutSlots
	add hl, bc
	call BattleFactory_ReadByte
	ld [wCurPartyMon], a
	ld hl, sFactoryInSlots
	add hl, bc
	call BattleFactory_ReadByte
	ld c, a
	call BattleFactory_CopyOfferToParty
	pop bc
	inc c
	dec b
	jr nz, .loop
	call BattleFactory_CheckUniqueSpecies
	jr c, .invalid
	call BattleFactory_SetRentalOTs
	farcall HealParty
	farcall MaximizePlayerPartyPP
	call BattleFactory_SaveTeam
	and a
	ret
.invalid
	call BattleFactory_LoadOffers
	scf
	ret

BattleFactory_CopyOfferToParty:
; c = offer slot; wCurPartyMon = outgoing rental slot. Copy only that mon.
	ld a, BANK(sBattleFactoryOffers)
	call OpenSRAM
	push bc
	ld a, c
	ld hl, sBattleFactoryOffers + (wPartyMons - wPartyCount)
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld de, wBT_OTTempMon1
	ld bc, PARTYMON_STRUCT_LENGTH
	call CopyBytes
	pop bc
	ld a, c
	ld hl, sBattleFactoryOffers + (wPartyMonNicknames - wPartyCount)
	call SkipNames
	ld de, wBT_OTTempMon1Name
	ld bc, MON_NAME_LENGTH
	call CopyBytes
	call CloseSRAM
	jmp BattleFactory_CopyTempToParty

BattleFactory_CheckUniqueSpecies::
; Preserve the Factory's six-distinct-species rule after simultaneous trades.
	ld hl, wPartySpecies
	ld b, PARTY_LENGTH - 1
.outer
	ld a, [hli]
	ld c, b
	push hl
.inner
	cp [hl]
	jr z, .duplicate
	inc hl
	dec c
	jr nz, .inner
	pop hl
	dec b
	jr nz, .outer
	and a
	ret
.duplicate
	pop hl
	scf
	ret
