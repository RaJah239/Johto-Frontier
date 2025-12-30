CheckBoostingAbilities:
	call HandleGuts
	call HandleRivalry
	call HandleSandForce
	call HandleTechnician
	call HandleHugePower
	call HandleMultiscale
	call HandleThickFat
	call HandleSolarPowerBoost
	ret

HandleGuts:
	call GetCurrentMon
	ld hl, GutsPokemon
	call IsInByteArray
	ret nc

	ld a, BATTLE_VARS_STATUS
	call GetBattleVar
	and 1 << PSN | 1 << BRN | 1 << PAR | 1 << FRZ
	ret z
	ld a, BATTLE_VARS_MOVE_TYPE
	call GetBattleVar
	cp SPECIAL
	ret nc
	jmp FiftyPercentBoost

INCLUDE "data/abilities/ability_mons/guts_mons.asm"

HandleRivalry:
	call GetCurrentMon
	ld hl, RivalryPokemon
	call IsInByteArray
	ret nc

	farcall CheckOppositeGender
	ret c
	jmp z, TwentyFivePercentBoost
	jmp TwentyFivePercentNerf

INCLUDE "data/abilities/ability_mons/rivalry_mons.asm"

HandleSandForce:
	call GetCurrentMon
	ld hl, SandForcePokemon
	call IsInByteArray
	ret nc

	ld a, [wBattleWeather]
	cp WEATHER_SANDSTORM
	ret nz

	ld a, BATTLE_VARS_MOVE_TYPE
	call GetBattleVar
	and TYPE_MASK
	cp ROCK
	jr z, .SandForceBoost
	cp GROUND
	jr z, .SandForceBoost
	cp STEEL
	ret nz

.SandForceBoost:
	jmp ThirtyPercentBoost

INCLUDE "data/abilities/ability_mons/sand_force_mons.asm"

HandleTechnician:
	call GetCurrentMon
	ld hl, TechnicianPokemon
	call IsInByteArray
	ret nc

	ld a, BATTLE_VARS_MOVE_POWER
	call GetBattleVar
	cp 61            ; power < 61 → boost
	ret nc           ; power >= 61, no boost
	jmp FiftyPercentBoost

INCLUDE "data/abilities/ability_mons/technician_mons.asm"

HandleHugePower:
	call GetCurrentMon
	ld hl, HugePowerPokemon
	call IsInByteArray
	ret nc

	jmp HundredPercentBoost

INCLUDE "data/abilities/ability_mons/huge_power_mons.asm"

HandleMultiscale:
	call GetOpposingMon
	ld hl, MultiscalePokemon
	call IsInByteArray
	ret nc

	farcall CheckOpponentFullHP
	ret nz
	jr FiftyPercentNerf

INCLUDE "data/abilities/ability_mons/multiscale_mons.asm"

HandleThickFat:
	call GetOpposingMon
	ld hl, ThickFatPokemon
	call IsInByteArray
	ret nc

	ld a, BATTLE_VARS_MOVE_TYPE
	call GetBattleVar
	and TYPE_MASK
	cp FIRE
	jr z, FiftyPercentNerf
	cp ICE
	ret nz
	jr FiftyPercentNerf

INCLUDE "data/abilities/ability_mons/thick_fat_mons.asm"

HandleSolarPowerBoost:
	call GetCurrentMon
	ld hl, SolarPowerPokemon
	call IsInByteArray
	ret nc

	; check if it is sunny
	ld a, [wBattleWeather]
	cp WEATHER_SUN
	ret nz

	; boost physical type attacks by 50 percent
	ld a, BATTLE_VARS_MOVE_TYPE
	call GetBattleVar
	cp SPECIAL
	ret c
	jr FiftyPercentBoost

INCLUDE "data/abilities/ability_mons/solar_power_mons.asm"

FiftyPercentNerf:
	ld a, 50
	ldh [hMultiplier], a
	call Multiply

	ld a, 100
	ldh [hDivisor], a
	ld b, 4
	jmp Divide

TwentyFivePercentNerf:
	ld a, 75
	ldh [hMultiplier], a
	call Multiply

	ld a, 100
	ldh [hDivisor], a
	ld b, 4
	jmp Divide

HundredPercentBoost:
	ld a, 100
	jr FinishBoost

FiftyPercentBoost:
	ld a, 50
	jr FinishBoost

ThirtyPercentBoost:
	ld a, 30
	jr FinishBoost

TwentyFivePercentBoost:
	ld a, 25
	jr FinishBoost

TwentyPercentBoost:
	ld a, 20
	; fallthrough

FinishBoost:
	add 100
	ldh [hMultiplier], a
	call Multiply

	ld a, 100
	ldh [hDivisor], a
	ld b, 4
	jmp Divide
