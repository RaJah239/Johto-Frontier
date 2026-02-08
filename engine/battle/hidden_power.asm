HiddenPowerDamage:
; Override Hidden Power's type based on the user's DVs.

	ld hl, wBattleMonDVs
	ldh a, [hBattleTurn]
	and a
	jr z, .got_dvs
	ld hl, wEnemyMonDVs

.got_dvs
    ; Use DV bits 1-2 instead of 0-1
    ; type = ((AtkDV >> 1) & 3) << 2 | ((DefDV >> 1) & 3)

    ; ---- defense contribution ----
    ld a, [hl]
    srl a        ; >>1
    and %0011
    ld b, a

    ; ---- attack contribution ----
    ld a, [hl]
    swap a       ; move atk nibble down
    srl a        ; >>1
    and %0011
    add a
    add a        ; <<2
    or b

; Skip Normal
	inc a

; Skip Bird
	cp BIRD
	jr c, .done
	inc a

; Skip unused types
	cp UNUSED_TYPES
	jr c, .done
	add UNUSED_TYPES_END - UNUSED_TYPES

.done

; Overwrite the current move type.
    push af
    ld a, BATTLE_VARS_MOVE_TYPE
    call GetBattleVarAddr
    pop af
    or SPECIAL
    ld [hl], a

; Get the rest of the damage formula variables
; based on the new type.
	farcall BattleCommand_DamageStats ; damagestats
	ret
