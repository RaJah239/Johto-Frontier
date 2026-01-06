EffectiveDefensiveAbilities:
	call HandleTintedLens
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
