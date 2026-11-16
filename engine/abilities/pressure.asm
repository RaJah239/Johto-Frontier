; =========================
; === Ability: Pressure ===
; =========================
; A move used on a Pressure mon loses one more PP. "On it" means the move
; targets it: it goes through checkhit (moves that only affect the user
; don't), so _BattleCommand_CheckHit calls PressureDeductPP. Its popup
; shows over the Pressure mon's HUD the first time that happens after
; it's sent out.

PressureDeductPP::
	call GetOpposingMon
	ld hl, PressurePokemon
	call IsInByteArray
	ret nc

	; not for Struggle, or the later turns of a rampage / looping move
	; (their PP was only taken on the first turn)
	ld a, BATTLE_VARS_MOVE
	call GetBattleVar
	cp STRUGGLE
	ret z
	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVar
	and 1 << SUBSTATUS_IN_LOOP | 1 << SUBSTATUS_RAMPAGE
	ret nz

	; one more PP from the move in battle...
	ldh a, [hBattleTurn]
	and a
	ld hl, wBattleMonPP
	ld a, [wCurMoveNum]
	jr z, .got_battle_pp
	ld hl, wEnemyMonPP
	ld a, [wCurEnemyMoveNum]
.got_battle_pp
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl]
	and PP_MASK
	ret z
	push hl
	push bc
	ldh a, [hBattleTurn]
	xor 1 ; the Pressure mon's side
	ShowOncePerSendOutPopupOnSide SEND_OUT_POPUP_PRESSURE, PressureText, KEEP
	pop bc
	pop hl
	ret c ; suppressed by Neutralizing Gas
	dec [hl]

	; ...and in the party, like the PP the move used (not when transformed,
	; for a wild mon, or for a move learned by Mimic)
	ld a, BATTLE_VARS_SUBSTATUS5
	call GetBattleVar
	bit SUBSTATUS_TRANSFORMED, a
	ret nz
	ldh a, [hBattleTurn]
	and a
	ld hl, wPartyMon1Moves
	ld a, [wCurBattleMon]
	jr z, .got_party
	ld a, [wBattleMode]
	dec a
	ret z ; wild
	ld hl, wOTPartyMon1Moves
	ld a, [wCurOTMon]
.got_party
	push bc
	call GetPartyLocation
	pop bc
	add hl, bc
	ld a, BATTLE_VARS_MOVE
	call GetBattleVar
	cp [hl]
	ret nz ; Mimic
	ld bc, MON_PP - MON_MOVES
	add hl, bc
	ld a, [hl]
	and PP_MASK
	ret z
	dec [hl]
	ret

PressureText: db "Pressure@"

INCLUDE "data/abilities/pressure_mons.asm"
