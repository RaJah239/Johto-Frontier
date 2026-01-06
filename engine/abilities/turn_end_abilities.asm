TurnEndAbilities:
	call HandleRegenerator
	call HandleSpeedBoost
	call HandleHydration
	call HandleIceBody
	call HandleRainDish
	call HandleSolarPowerHPLoss
	call HandleSandBody
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

INCLUDE "data/abilities/molting_mons.asm"

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

INCLUDE "data/abilities/regenerator_mons.asm"

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

INCLUDE "data/abilities/speed_boost_mons.asm"

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

	; if it is raining, if so, activate
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

INCLUDE "data/abilities/hydration_mons.asm"

HandleIceBody:
	call SetEnemyTurn
	ld a, [wEnemyMonSpecies]
	call .do_it
	call SetPlayerTurn
	ld a, [wBattleMonSpecies]
.do_it

	ld hl, IceBodyPokemon
	call IsInByteArray
	ret nc

	; if it is hailing, if so, activate
	ld a, [wBattleWeather]
	cp WEATHER_HAIL
	ret nz

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
	ld hl, IceBodyText
	jmp StdBattleTextbox

INCLUDE "data/abilities/ice_body_mons.asm"

HandleRainDish:
	call SetEnemyTurn
	ld a, [wEnemyMonSpecies]
	call .do_it
	call SetPlayerTurn
	ld a, [wBattleMonSpecies]
.do_it

	ld hl, RainDishPokemon
	call IsInByteArray
	ret nc

	; if it is raining, if so, activate
	ld a, [wBattleWeather]
	cp WEATHER_RAIN
	ret nz

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
	ld hl, RainDishText
	jmp StdBattleTextbox

INCLUDE "data/abilities/rain_dish_mons.asm"

; handle boosted attack in engine/abilities/boosting_abilities.asm
HandleSolarPowerHPLoss:
	call GetCurrentMon
	push hl
	push de
	push bc
	ld hl, SolarPowerPokemon
	call IsInByteArray
	pop bc
	pop de
	pop hl
	ret nc

	; check if it is sunny
	ld a, [wBattleWeather]
	cp WEATHER_SUN
	ret nz

	; subtract 1/8 max hp end of each turn
	farcall GetEighthMaxHP
	farcall SubtractHPFromUser
	ld hl, SolarPowerText
	jmp StdBattleTextbox

HandleSandBody:
	call SetEnemyTurn
	ld a, [wEnemyMonSpecies]
	call .do_it
	call SetPlayerTurn
	ld a, [wBattleMonSpecies]
.do_it

	ld hl, SandBodyPokemon
	call IsInByteArray
	ret nc

	; if in a sandstorm, if so, activate
	ld a, [wBattleWeather]
	cp WEATHER_SANDSTORM
	ret nz

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
	ld hl, SandBodyText
	jmp StdBattleTextbox

INCLUDE "data/abilities/sand_body_mons.asm"
