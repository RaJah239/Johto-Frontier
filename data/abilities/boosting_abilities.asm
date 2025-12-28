CheckBoostingAbilities:
	call HandleGuts
	call HandleRivalry
	call HandleSandForce
	call HandleTechnician
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
	jr z, TwentyFivePercentBoost
	jr TwentyFivePercentNerf

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
	jr ThirtyPercentBoost

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
	jr FiftyPercentBoost

INCLUDE "data/abilities/ability_mons/technician_mons.asm"

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
