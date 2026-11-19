EvolveDuringBattle::
; Experience has raised wCurPartyMon's level. Between trainer opponents,
; evolve now; the last opponent and wild battles use the normal ending.
	ld a, [wBattleMode]
	cp TRAINER_BATTLE
	jr nz, .defer
	farcall CheckEnemyTrainerDefeated
	jr z, .defer
	xor a
	ld [wForceEvolution], a
	ld a, MON_SPECIES
	call GetPartyParamLocation
	ld a, [hl]
	ld [wEvolutionOldSpecies], a
	ld [wCurSpecies], a
	call GetBaseData
	newfarcall CheckHowToEvolve
	ret z

	ldh a, [hBattleTurn]
	push af
	ld a, [wCurPartyLevel]
	push af
	ld a, [wMapMusic]
	push af
	ld a, [wCurPartyMon]
	push af
	call .SaveScene
	newfarcall TryToEvolve
	pop bc
	ld a, b
	ld [wCurPartyMon], a
	jr nc, .evolved
	farcall CancelEvolution
	jr .restore

.evolved
	call .UpdateActiveMon
.restore
	call .RestoreScene
	pop af
	ld [wMapMusic], a
	farcall RunPendingEntryAbilities
	pop af
	ld [wCurPartyLevel], a
	pop af
	ldh [hBattleTurn], a
	ret

.defer
	ld hl, wEvolvableFlags
	ld a, [wCurPartyMon]
	ld c, a
	ld b, SET_FLAG
	predef_jump SmallFarFlagAction

.SaveScene
; Keep hl (the evolution target). Move learning reuses wTempTilemap, and
; the ordinary sound backup must keep the overworld music until battle ends.
	push hl
	call WaitSFX
	ldh a, [rSVBK]
	push af
	ld a, BANK(wBattleEvolutionTilemap)
	ldh [rSVBK], a
	ld hl, wTilemap
	ld de, wBattleEvolutionTilemap
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	call CopyBytes
	di
	ld hl, wMusicPlaying
	ld de, wBattleEvolutionMusic
	ld bc, wMapMusic - wMusicPlaying
	call CopyBytes
	ei
	pop af
	ldh [rSVBK], a
	pop hl
	ret

.UpdateActiveMon
	ld a, [wCurPartyMon]
	ld b, a
	ld a, [wCurBattleMon]
	cp b
	ret nz

	ld a, MON_LEVEL
	call GetPartyParamLocation
	ld de, wBattleMonLevel
	ld bc, MON_ATK - MON_LEVEL
	call CopyBytes
	; A transformed battler keeps its copied species, moves, types and stats.
	ld a, [wPlayerSubStatus5]
	bit SUBSTATUS_TRANSFORMED, a
	ret nz

	ld a, MON_SPECIES
	call GetPartyParamLocation
	ld a, [hl]
	ld [wBattleMonSpecies], a
	ld [wTempBattleMonSpecies], a
	ld [wCurPartySpecies], a
	ld [wCurSpecies], a
	call GetBaseData
	ld hl, wBaseType1
	ld de, wBattleMonType1
	ld bc, 2
	call CopyBytes

	ld a, MON_MOVES
	call GetPartyParamLocation
	ld de, wBattleMonMoves
	ld bc, NUM_MOVES
	call CopyBytes
	ld a, MON_PP
	call GetPartyParamLocation
	ld de, wBattleMonPP
	ld bc, NUM_MOVES
	call CopyBytes
	ld a, MON_ATK
	call GetPartyParamLocation
	ld de, wPlayerStats
	ld bc, NUM_BATTLE_STATS * 2
	call CopyBytes
	xor a
	ldh [hBattleTurn], a
	farcall CalcPlayerStats
	ld hl, wPartyMonNicknames
	ld a, [wCurPartyMon]
	call SkipNames
	ld de, wBattleMonNickname
	ld bc, MON_NAME_LENGTH
	call CopyBytes

	; New abilities take effect against the next opponent. Evolution does
	; not count as switching in: keep hazards, item history and stat stages.
	xor a
	ld hl, wSendOutPopupsShown
	ld bc, SEND_OUT_POPUP_BYTES
	call ByteFill
	ld hl, wEntryAbilitiesPending
	set ENTRY_ABILITIES_PLAYER_F, [hl]
	ret

.RestoreScene
	call ClearPalettes
	farcall _LoadBattleFontsHPBar
	farcall GetBattleMonBackpic
	farcall GetEnemyMonFrontpic
	xor a
	ldh [hBGMapMode], a
	ldh a, [rSVBK]
	push af
	ld a, BANK(wBattleEvolutionTilemap)
	ldh [rSVBK], a
	ld hl, wBattleEvolutionTilemap
	ld de, wTilemap
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	call CopyBytes
	di
	ld hl, wBattleEvolutionMusic
	ld de, wMusicPlaying
	ld bc, wMapMusic - wMusicPlaying
	call CopyBytes
	ei
	pop af
	ldh [rSVBK], a
	farcall UpdatePlayerHUD
	farcall EmptyBattleTextbox
	farcall FinishBattleAnim
	call WaitBGMap
	jmp LoadTilemapToTempTilemap
