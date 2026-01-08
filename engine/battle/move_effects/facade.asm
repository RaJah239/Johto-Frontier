BattleCommand_Facade:
; Double damage if the user is poisoned, paralyzed, or burned.
	ld hl, wBattleMonStatus
	ldh a, [hBattleTurn]
	and a
	jr z, .got_status
	ld hl, wEnemyMonStatus
.got_status
	bit PAR, [hl]
	jmp nz, DoubleDamage

	bit BRN, [hl]
	jr nz, QuadrupleDamage

	bit PSN, [hl]
	jmp nz, DoubleDamage
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
