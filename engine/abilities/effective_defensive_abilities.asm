EffectiveDefensiveAbilities:
	call HandleTintedLens
	call HandleSolidRock
	jr HandleFurCoat

HandleTintedLens:
	call GetCurrentMon
	ld hl, TintedLensPokemon
	call IsInByteArray
	ret nc

	ld a, [wTypeModifier]
	and EFFECTIVENESS_MASK
	cp NOT_VERY_EFFECTIVE
	ret nz
	ldh a, [hBattleTurn]
	call IsSideSuppressed
	ret c
	jr Hundred_PercentBoost

INCLUDE "data/abilities/tinted_lens_mons.asm"

HandleSolidRock:
	call GetOpposingMon
	ld hl, SolidRockPokemon
	call IsInAbilityList
	ret nc

	ld a, [wTypeModifier]
	and EFFECTIVENESS_MASK
	cp EXTREMELY_EFFECTIVE
	jr z, .nerf_damage
	cp SUPER_EFFECTIVE
	ret nz
	jr Half_Damage
.nerf_damage
	call Half_Damage
	jr Half_Damage

INCLUDE "data/abilities/solid_rock_mons.asm"

HandleFurCoat:
	call GetOpposingMon
	ld hl, FurCoatPokemon
	call IsInAbilityList
	ret nc

	ld a, BATTLE_VARS_MOVE_TYPE
	call GetBattleVar
	cp SPECIAL
	ret nc
	jr Fifty_PercentNerf

INCLUDE "data/abilities/fur_coat_mons.asm"

Hundred_PercentBoost:
	ld a, 100
	; fallthrough

Finish_Boost:
	add 100
	ldh [hMultiplier], a
	call Multiply

	ld a, 100
	ldh [hDivisor], a
	ld b, 4
	jmp Divide

Fifty_PercentNerf:
	ld a, 50
	ldh [hMultiplier], a
	call Multiply

	ld a, 100
	ldh [hDivisor], a
	ld b, 4
	jmp Divide

Half_Damage:
	ld a, 2
	ldh [hDivisor], a
	ld b, 4
	jmp Divide
