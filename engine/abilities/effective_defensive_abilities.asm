EffectiveDefensiveAbilities:
	call HandleTintedLens
	call HandleSolidRock
	ret

HandleTintedLens:
	call GetCurrentMon
	ld hl, TintedLensPokemon
	call IsInByteArray
	ret nc

	ld a, [wTypeModifier]
	and EFFECTIVENESS_MASK
	cp NOT_VERY_EFFECTIVE
	ret nz
	jr Hundred_PercentBoost

INCLUDE "data/abilities/tinted_lens_mons.asm"

HandleSolidRock:
	call GetOpposingMon
	ld hl, SolidRockPokemon
	call IsInByteArray
	ret nc

	ld a, [wTypeModifier]
	and EFFECTIVENESS_MASK
	cp EXTREMELY_EFFECTIVE
	jr z, .nerf_damage
	cp SUPER_EFFECTIVE
	ret nz
.nerf_damage
	jr TwentyFive_PercentNerf

INCLUDE "data/abilities/solid_rock_mons.asm"

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

TwentyFive_PercentNerf:
	ld a, 75
	ldh [hMultiplier], a
	call Multiply

	ld a, 100
	ldh [hDivisor], a
	ld b, 4
	jmp Divide
