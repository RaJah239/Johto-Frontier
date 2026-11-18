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
	call IsInAbilityList
	jr c, .done
	ld a, [wEnemyMonSpecies]
	ld hl, NoGuardPokemon
	call IsInAbilityList
.done
	pop bc
	pop de
	pop hl
	ret

INCLUDE "data/abilities/no_guard_mons.asm"
