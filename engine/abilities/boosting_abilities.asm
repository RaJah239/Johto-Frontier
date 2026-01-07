CheckBoostingAbilities:
	call HandleGuts
	call HandleRivalry
	call HandleSandForce
	call HandleTechnician
	call HandleHugePower
	call HandleMultiscale
	call HandleThickFat
	call HandleSolarPowerBoost
	call HandleSteelWorker
	call HandleIronFist
	call HandleMentalFocus
	call HandleRainSurge
	call HandleShieldDust
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

INCLUDE "data/abilities/guts_mons.asm"

HandleRivalry:
	call GetCurrentMon
	ld hl, RivalryPokemon
	call IsInByteArray
	ret nc

	farcall CheckOppositeGender
	ret c
	jmp z, TwentyFivePercentBoost
	jmp TwentyFivePercentNerf

INCLUDE "data/abilities/rivalry_mons.asm"

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

INCLUDE "data/abilities/sand_force_mons.asm"

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

INCLUDE "data/abilities/technician_mons.asm"

HandleHugePower:
	call GetCurrentMon
	ld hl, HugePowerPokemon
	call IsInByteArray
	ret nc

	jmp HundredPercentBoost

INCLUDE "data/abilities/huge_power_mons.asm"

HandleMultiscale:
	call GetOpposingMon
	ld hl, MultiscalePokemon
	call IsInByteArray
	ret nc

	farcall CheckOpponentFullHP
	ret nz
	jmp FiftyPercentNerf

INCLUDE "data/abilities/multiscale_mons.asm"

HandleThickFat:
	call GetOpposingMon
	ld hl, ThickFatPokemon
	call IsInByteArray
	ret nc

	ld a, BATTLE_VARS_MOVE_TYPE
	call GetBattleVar
	and TYPE_MASK
	cp FIRE
	jmp z, FiftyPercentNerf
	cp ICE
	ret nz
	jmp FiftyPercentNerf

INCLUDE "data/abilities/thick_fat_mons.asm"

; handle the HP loss in engine/abilities/turn_end_abilities.asm 
HandleSolarPowerBoost:
	call GetCurrentMon
	ld hl, SolarPowerPokemon
	call IsInByteArray
	ret nc

	; check if it is sunny
	ld a, [wBattleWeather]
	cp WEATHER_SUN
	ret nz

	; boost special type attacks by 50 percent
	ld a, BATTLE_VARS_MOVE_TYPE
	call GetBattleVar
	cp SPECIAL
	ret c
	jmp FiftyPercentBoost

INCLUDE "data/abilities/solar_power_mons.asm"

HandleSteelWorker:
	call GetCurrentMon
	ld hl, SteelWorkerPokemon
	call IsInByteArray
	ret nc

	ld a, BATTLE_VARS_MOVE_TYPE
	call GetBattleVar
	and TYPE_MASK
	cp STEEL
	ret nz
	jmp FiftyPercentBoost

INCLUDE "data/abilities/steel_worker_mons.asm"

HandleIronFist:
	call GetCurrentMon
	ld hl, IronFistPokemon
	call IsInByteArray
	ret nc

	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	ld hl, PunchingMoves
	call IsInByteArray
	ret nc

	jr ThirtyPercentBoost

INCLUDE "data/abilities/iron_fist_mons.asm"

HandleMentalFocus:
	call GetCurrentMon
	ld hl, MentalFocusPokemon
	call IsInByteArray
	ret nc

	ld a, BATTLE_VARS_MOVE_TYPE
	call GetBattleVar
	and TYPE_MASK
	cp PSYCHIC_TYPE
	ret nz
	jr FiftyPercentBoost

INCLUDE "data/abilities/mental_focus_mons.asm"

HandleRainSurge:
	call GetCurrentMon
	ld hl, RainSurgePokemon
	call IsInByteArray
	ret nc

	; check if it is raining
	ld a, [wBattleWeather]
	cp WEATHER_RAIN
	ret nz

	; boost special type attacks by 50 percent
	ld a, BATTLE_VARS_MOVE_TYPE
	call GetBattleVar
	cp SPECIAL
	ret c
	jr FiftyPercentBoost

INCLUDE "data/abilities/rain_surge_mons.asm"

HandleShieldDust:
	call GetOpposingMon
	ld hl, ShieldDustPokemon
	call IsInByteArray
	ret c

	ld a, BATTLE_VARS_MOVE_TYPE
	call GetBattleVar
	cp SPECIAL
	ret nc
	jr FiftyPercentBoost

INCLUDE "data/abilities/shield_dust_mons.asm"

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
	; fallthrough

FinishBoost:
	add 100
	ldh [hMultiplier], a
	call Multiply

	ld a, 100
	ldh [hDivisor], a
	ld b, 4
	jmp Divide

PunchingMoves:
	db FIRE_PUNCH
	db ICE_PUNCH
	db THUNDERPUNCH
	db DRAIN_PUNCH
	db BULLET_PUNCH
	db MACH_PUNCH
	db SHADOW_PUNCH
	db METEOR_MASH
	db -1 ; end
