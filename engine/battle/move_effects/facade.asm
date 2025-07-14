BattleCommand_Facade:
; Double damage if the user is poisoned, paralyzed, or burned.
	ld hl, wBattleMonStatus
	ldh a, [hBattleTurn]
	and a
	jr z, .got_status
	ld hl, wEnemyMonStatus
.got_status
	bit PAR, [hl]
	jp nz, DoubleDamage

	bit BRN, [hl]
	jp nz, QuadrupleDamage

	bit PSN, [hl]
	jp nz, DoubleDamage
	ret

QuadrupleDamage:
	ld hl, wCurDamage + 1

	; First doubling
	sla [hl]
	dec hl
	rl [hl]
	jr c, .overflow

	; Second doubling
	ld hl, wCurDamage + 1
	sla [hl]
	dec hl
	rl [hl]
	jr c, .overflow

	ret

.overflow
	ld a, $ff
	ld [hli], a
	ld [hl], a
	ret
