AI_MinRollKOsPlayer:
; Return carry if wCurDamage at its lowest damage roll still KOs the
; player's mon (damage >= current HP). BattleCommand_DamageVariation
; multiplies damage by (85 percent + 1) to 100 percent, divided by 100 percent,
; so the lowest roll is wCurDamage * (85 percent + 1) / (100 percent).
; Used by CanAIKO, so the AI only counts on KOs that are guaranteed.
	xor a
	ldh [hMultiplicand + 0], a
	ld a, [wCurDamage]
	ldh [hMultiplicand + 1], a
	ld a, [wCurDamage + 1]
	ldh [hMultiplicand + 2], a
	ld a, 85 percent + 1
	ldh [hMultiplier], a
	call Multiply
	ld a, 100 percent
	ldh [hDivisor], a
	ld b, 4
	call Divide

	; lowest roll - HP: no borrow means it KOs
	ld a, [wBattleMonHP + 1]
	ld c, a
	ld a, [wBattleMonHP]
	ld b, a
	ldh a, [hQuotient + 3]
	sub c
	ldh a, [hQuotient + 2]
	sbc b
	ccf
	ret
