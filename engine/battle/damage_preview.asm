PrintMoveDamagePreview:
; Called by MoveInfoBox (after UpdateMoveData) for the highlighted move.
; Prints the damage the move would do to the opponent's active mon on the
; top row of the move info box:
;   D:min-max  normal damaging moves (lowest to highest damage roll)
;   D:dmg      when there's no random roll (fixed-damage moves, Flail, 0 or 1)
;   D:---      status moves, Counter, Mirror Coat
; Uses the same battle routines as the real attack (no critical hits).
; Everything those routines touch is saved and restored, including
; wCurDamage (Counter reads it) and the move's power and type.
	ld a, [wCurDamage]
	push af
	ld a, [wCurDamage + 1]
	push af
	ld a, [wTypeModifier]
	push af
	ld a, [wTypeMatchup]
	push af
	ld a, [wCurType]
	push af
	ld a, [wAttackMissed]
	push af
	ld a, [wCriticalHit]
	push af
	ld a, [wHalfDamage]
	push af
	ld a, [wPlayerMoveStruct + MOVE_POWER]
	push af
	ld a, [wPlayerMoveStruct + MOVE_TYPE]
	push af

	xor a
	ld [wTypeModifier], a
	ld [wAttackMissed], a
	ld [wCriticalHit], a
	ld [wHalfDamage], a
	call SetPlayerTurn

	hlcoord 1, 8
	ld [hl], "D"
	inc hl
	ld [hl], ":"

	call DamagePreview_Compute
	jr c, .unavailable
	call DamagePreview_Print
	jr .restore

.unavailable
	hlcoord 5, 8
	ld de, DamagePreview_NoDamageString
	call PlaceString

.restore
	pop af
	ld [wPlayerMoveStruct + MOVE_TYPE], a
	pop af
	ld [wPlayerMoveStruct + MOVE_POWER], a
	pop af
	ld [wHalfDamage], a
	pop af
	ld [wCriticalHit], a
	pop af
	ld [wAttackMissed], a
	pop af
	ld [wCurType], a
	pop af
	ld [wTypeMatchup], a
	pop af
	ld [wTypeModifier], a
	pop af
	ld [wCurDamage + 1], a
	pop af
	ld [wCurDamage], a
	ret

DamagePreview_Compute:
; Return carry if there's no number to show. Otherwise return the highest
; damage in wCurDamage and the lowest in de (both capped at 999).
	ld a, [wPlayerMoveStruct + MOVE_EFFECT]
	cp EFFECT_COUNTER
	jr z, .unavailable
	cp EFFECT_MIRROR_COAT
	jr z, .unavailable

	; exact damage: Super Fang, fixed-damage and level-damage moves
	cp EFFECT_SUPER_FANG
	jr z, .constant
	cp EFFECT_STATIC_DAMAGE
	jr z, .constant
	cp EFFECT_LEVEL_DAMAGE
	jr z, .constant

	; Flail: power from HP, no random roll (constantdamage + stab)
	cp EFFECT_FLAIL
	jr z, .flail

	cp EFFECT_RETURN
	jr z, .return
	cp EFFECT_HIDDEN_POWER
	jr z, .hidden_power

	ld a, [wPlayerMoveStruct + MOVE_POWER]
	cp 2
	jr c, .unavailable ; status move (or 1-power placeholder)

	callfar PlayerAttackDamage
	jr .damage_calc

.return
	; damagestats, then power from happiness (in d), then damagecalc
	callfar PlayerAttackDamage
	callfar BattleCommand_HappinessPower
	jr .damage_calc

.hidden_power
	; sets Hidden Power's real type, then runs damagestats
	callfar HiddenPowerDamage

.damage_calc
	callfar BattleCommand_DamageCalc
	callfar BattleCommand_Stab
	call DamagePreview_Levitate
	call DamagePreview_CapCurDamage
	jr DamagePreview_LowestRoll

.flail
	callfar BattleCommand_ConstantDamage
	callfar BattleCommand_Stab
	call DamagePreview_Levitate
	jr .exact

.constant
	callfar BattleCommand_ConstantDamage
.exact
	call DamagePreview_CapCurDamage
	ld a, [wCurDamage]
	ld d, a
	ld a, [wCurDamage + 1]
	ld e, a
	and a ; no carry
	ret

.unavailable
	scf
	ret

DamagePreview_Levitate:
; Levitate: Ground moves do nothing to the opponent's mon.
	ld a, [wPlayerMoveStruct + MOVE_TYPE]
	and TYPE_MASK
	cp GROUND
	ret nz
	ld a, [wEnemyMonSpecies]
	ld hl, LevitatePokemon
	call IsInByteArray
	ret nc
	xor a
	ld [wCurDamage], a
	ld [wCurDamage + 1], a
	ret

DamagePreview_LowestRoll:
; de = wCurDamage at the lowest damage roll, the same way
; BattleCommand_DamageVariation scales it: * (85 percent + 1) / (100 percent).
; 0 or 1 damage isn't scaled. Returns no carry.
	ld a, [wCurDamage]
	ld d, a
	ld a, [wCurDamage + 1]
	ld e, a
	ld a, d
	and a
	jr nz, .scale
	ld a, e
	cp 2
	jr nc, .scale
	and a
	ret

.scale
	xor a
	ldh [hMultiplicand + 0], a
	ld a, d
	ldh [hMultiplicand + 1], a
	ld a, e
	ldh [hMultiplicand + 2], a
	ld a, 85 percent + 1
	ldh [hMultiplier], a
	call Multiply
	ld a, 100 percent
	ldh [hDivisor], a
	ld b, 4
	call Divide
	ldh a, [hQuotient + 2]
	ld d, a
	ldh a, [hQuotient + 3]
	ld e, a
	and a
	ret

DamagePreview_CapCurDamage:
; Cap wCurDamage at 999 so it fits the box.
	ld a, [wCurDamage]
	cp HIGH(999)
	ret c
	jr nz, .cap
	ld a, [wCurDamage + 1]
	cp LOW(999) + 1
	ret c
.cap
	ld a, HIGH(999)
	ld [wCurDamage], a
	ld a, LOW(999)
	ld [wCurDamage + 1], a
	ret

DamagePreview_Print:
; wCurDamage = highest, de = lowest. Prints "min-max", or one number if they
; match, starting at row 8, column 3.
	ld a, [wCurDamage]
	ld b, a
	ld a, [wCurDamage + 1]
	ld c, a
	ld a, b
	cp d
	jr nz, .range
	ld a, c
	cp e
	jr nz, .range

	hlcoord 3, 8
	ld de, wCurDamage
	lb bc, PRINTNUM_LEFTALIGN | 2, 3
	jp PrintNum

.range
	push bc ; highest
	ld a, d
	ld [wCurDamage], a
	ld a, e
	ld [wCurDamage + 1], a
	hlcoord 3, 8
	ld de, wCurDamage
	lb bc, PRINTNUM_LEFTALIGN | 2, 3
	call PrintNum
	ld [hl], "-"
	inc hl
	pop bc
	ld a, b
	ld [wCurDamage], a
	ld a, c
	ld [wCurDamage + 1], a
	ld de, wCurDamage
	lb bc, PRINTNUM_LEFTALIGN | 2, 3
	jp PrintNum

DamagePreview_NoDamageString:
	db "---@"
