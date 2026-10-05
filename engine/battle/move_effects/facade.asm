BattleCommand_Facade:
; Double damage if the user is poisoned, paralyzed, or burned.
	ld hl, wBattleMonStatus
	ldh a, [hBattleTurn]
	and a
	jr z, .got_status
	ld hl, wEnemyMonStatus
.got_status
	bit PAR, [hl]
	jr nz, DoubleDamageEffCmds2

	bit BRN, [hl]
	jr nz, QuadrupleDamage

	bit PSN, [hl]
	jr nz, DoubleDamageEffCmds2
	ret

QuadrupleDamage:
	ld hl, wCurDamage + 1

	; first doubling
	sla [hl]
	dec hl
	rl [hl]
	jr c, Overflow
	; fallthrough to second doubling

DoubleDamageEffCmds2:
	ld hl, wCurDamage + 1
	sla [hl]
	dec hl
	rl [hl]
	ret nc

Overflow:
	ld a, $ff
	ld [hli], a
	ld [hl], a
	ret
