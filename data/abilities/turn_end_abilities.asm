TurnEndAbilities:
	call HandleRegenerator
	call HandleSpeedBoost
	call HandleHydration
	; fallthrough

HandleMolting:
	ldh a, [hSerialConnectionStatus]
	cp USING_EXTERNAL_CLOCK
	jr z, .DoEnemyFirst
	call SetPlayerTurn
    ld a, [wBattleMonSpecies]
	call .do_it
	call SetEnemyTurn
	ld a, [wEnemyMonSpecies]
	jr .do_it

.DoEnemyFirst:
	call SetEnemyTurn
	ld a, [wEnemyMonSpecies]
	call .do_it
	call SetPlayerTurn
	ld a, [wBattleMonSpecies]
.do_it
	ld hl, MoltingPokemon
	call IsInByteArray
	ret nc

	call Random
	cp 33 percent + 1
	ret nc ; 1/3 chance

	call DoMolting
	farjp CalcPokemonStats

DoMolting:
	ld a, BATTLE_VARS_STATUS
	call GetBattleVarAddr
	and a
	ret z
	xor a
	ld [hl], a
	farcall SwitchTurnCore
	farcall ItemRecoveryAnim
	farcall SwitchTurnCore
	ld hl, MoltingText
	jmp StdBattleTextbox

INCLUDE "data/abilities/ability_mons/molting_mons.asm"

HandleRegenerator:
	ldh a, [hSerialConnectionStatus]
	cp USING_EXTERNAL_CLOCK
	jr z, .DoEnemyFirst
	call SetPlayerTurn
    ld a, [wBattleMonSpecies]
	call .do_it
	call SetEnemyTurn
	ld a, [wEnemyMonSpecies]
	jr .do_it

.DoEnemyFirst:
	call SetEnemyTurn
	ld a, [wEnemyMonSpecies]
	call .do_it
	call SetPlayerTurn
	ld a, [wBattleMonSpecies]
.do_it
	ld hl, RegeneratorPokemon
	call IsInByteArray
	ret nc

    ld hl, wBattleMonHP
	ldh a, [hBattleTurn]
	and a
	jr z, .got_hp
	ld hl, wEnemyMonHP

.got_hp
; Don't restore if we're already at max HP
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld c, a
	ld a, [hli]
	cp b
	jr nz, .restore
	ld a, [hl]
	cp c
	ret z

.restore
	farcall GetSixteenthMaxHP
	farcall SwitchTurnCore
	farcall RestoreHP

	call CheckIfFastBattlesIsOn
	ret nz
	ld hl, BattleText_TargetRegenerates
	jmp StdBattleTextbox

INCLUDE "data/abilities/ability_mons/regenerator_mons.asm"

HandleSpeedBoost:
	ldh a, [hSerialConnectionStatus]
	cp USING_EXTERNAL_CLOCK
	jr z, .DoEnemyFirst
	call SetPlayerTurn
    ld a, [wBattleMonSpecies]
	call .do_it
	call SetEnemyTurn
	ld a, [wEnemyMonSpecies]
	jr .do_it

.DoEnemyFirst:
	call SetEnemyTurn
	ld a, [wEnemyMonSpecies]
	call .do_it
	call SetPlayerTurn
	ld a, [wBattleMonSpecies]
.do_it
	ld hl, SpeedBoostPokemon
	call IsInByteArray
	ret nc
	ld b, SPEED
	farcall BattleCommand_StatUp
	farjp BattleCommand_StatUpMessage

INCLUDE "data/abilities/ability_mons/speed_boost_mons.asm"

HandleHydration:
	ldh a, [hSerialConnectionStatus]
	cp USING_EXTERNAL_CLOCK
	jr z, .DoEnemyFirst
	call SetPlayerTurn
    ld a, [wBattleMonSpecies]
	call .do_it
	call SetEnemyTurn
	ld a, [wEnemyMonSpecies]
	jr .do_it

.DoEnemyFirst:
	call SetEnemyTurn
	ld a, [wEnemyMonSpecies]
	call .do_it
	call SetPlayerTurn
	ld a, [wBattleMonSpecies]
.do_it

	ld hl, HydrationPokemon
	call IsInByteArray
	ret nc

	; if it is raining, activate
	ld a, [wBattleWeather]
	cp WEATHER_RAIN
	ret nz

	call DoHydration
	farjp CalcPokemonStats

DoHydration:
	ld a, BATTLE_VARS_STATUS
	call GetBattleVarAddr
	and a
	ret z
	xor a
	ld [hl], a
	farcall SwitchTurnCore
	farcall ItemRecoveryAnim
	farcall SwitchTurnCore
	ld hl, HydrationText
	jmp StdBattleTextbox

INCLUDE "data/abilities/ability_mons/hydration_mons.asm"
