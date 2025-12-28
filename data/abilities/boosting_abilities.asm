CheckBoostingAbilities:
	call HandleGuts
	call HandleRivalry
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
	jr FiftyPercentBoost

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
