; =============================
; === Ability: No Guard     ===
; =============================
; Every move used by or against a Pokemon with No Guard hits: accuracy,
; evasion and the target being in the air (Fly) or underground (Dig) don't
; matter. Protect, immunities and moves that fail for other reasons (Dream
; Eater on an awake target...) still fail.

NoGuardCheck::
; Return carry if the player's or the enemy's active mon has No Guard.
; Call it with farcall; bc, de and hl are preserved.
	push hl
	push de
	push bc
	ld a, [wBattleMonSpecies]
	ld hl, NoGuardPokemon
	call IsInByteArray
	jr c, .done
	ld a, [wEnemyMonSpecies]
	ld hl, NoGuardPokemon
	call IsInByteArray
.done
	pop bc
	pop de
	pop hl
	ret

NoGuardPopup:
; The first damaging move a No Guard mon uses after it comes out (each time
; it's sent out) shows the ability popup. hBattleTurn = the user.
	ld a, BATTLE_VARS_MOVE_POWER
	call GetBattleVar
	and a
	ret z ; not a damaging move
	ldh a, [hBattleTurn]
	and a
	ld b, 1 << 0
	jr z, .got_bit
	ld b, 1 << 1
.got_bit
	ld a, [wNoGuardShown]
	and b
	ret nz ; already shown since it came in
	push bc
	call GetCurrentMon ; a = species
	ld hl, NoGuardPokemon
	call IsInByteArray
	pop bc
	ret nc
	ld a, [wNoGuardShown]
	or b
	ld [wNoGuardShown], a
	ShowActivationOrEntryOrKOAbilityPopup NoGuardText
	ret

NoGuardText: db "No Guard@"

INCLUDE "data/abilities/no_guard_mons.asm"
