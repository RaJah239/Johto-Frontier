DefensiveAbilities:
	call HandleFlameWard
	call HandleGrounded
	call HandleImmunity
	call HandleLevitate
	; fallthrough

; ===========================
; === Ability: Waterproof === 
; ===========================
HandleWaterproof:
	call GetDefensiveMoveType
	cp WATER
	ret nz

	call GetDefensiveSpecies
	ld hl, WaterproofPokemon
	call IsInByteArray
	ret nc

	showdefensiveability AbilityPopup_WaterproofText
	ld hl, WaterAbsorbText
	call StdBattleTextbox
	jmp AttackedMissed

AbilityPopup_WaterproofText:
	db "Waterproof@"

INCLUDE "data/abilities/defensive_abilities/waterproof_mons.asm"


; ============================
; === Ability: Flame Guard === 
; ============================
HandleFlameWard:
	call GetDefensiveMoveType
	cp FIRE
	ret nz

	call GetDefensiveSpecies
	ld hl, FlameWardPokemon
	call IsInByteArray
	ret nc

	showdefensiveability AbilityPopup_FlameWardText
	ld hl, FlameWardText
	call StdBattleTextbox
	jmp AttackedMissed

AbilityPopup_FlameWardText:
	db "Flame Ward@"

INCLUDE "data/abilities/defensive_abilities/flame_ward_mons.asm"


; =========================
; === Ability: Grounded === 
; =========================
HandleGrounded:
	call GetDefensiveMoveType
	cp ELECTRIC
	ret nz

	call GetDefensiveSpecies
	ld hl, GroundedPokemon
	call IsInByteArray
	ret nc

	showdefensiveability AbilityPopup_GroundedText
	ld hl, GroundedText
	call StdBattleTextbox
	jr AttackedMissed

AbilityPopup_GroundedText:
	db "Grounded@"

INCLUDE "data/abilities/defensive_abilities/grounded_mons.asm"


; =========================
; === Ability: Immunity === 
; =========================
HandleImmunity:
	call GetDefensiveMoveType
	cp POISON
	ret nz

	call GetDefensiveSpecies
	ld hl, ImmunityPokemon
	call IsInByteArray
	ret nc

	showdefensiveability AbilityPopup_ImmunityText
	ld hl, ImmunityText
	call StdBattleTextbox
	jr AttackedMissed

AbilityPopup_ImmunityText:
	db "Immunity@"

INCLUDE "data/abilities/defensive_abilities/immunity_mons.asm"


; =========================
; === Ability: Levitate === 
; =========================
HandleLevitate:
	call GetDefensiveMoveType
	cp GROUND
	ret nz

	call GetDefensiveSpecies
	ld hl, LevitatePokemon
	call IsInByteArray
	ret nc

	showdefensiveability AbilityPopup_LevitateText
	ld hl, LevitateText
	call StdBattleTextbox
	jr AttackedMissed

AbilityPopup_LevitateText:
	db "Levitate@"


; ===========================================================================
; Get the type of the move currently attacking.
; Returns: a = move type
; ===========================================================================
GetDefensiveMoveType:
	ldh a, [hBattleTurn]
	and a
	ld a, [wEnemyMoveStruct + MOVE_TYPE]
	jr nz, .got_type
	ld a, [wPlayerMoveStruct + MOVE_TYPE]

.got_type
	and TYPE_MASK
	ret

; ===========================================================================
; Get the species being attacked.
; Returns: a = defending Pokémon species
; ===========================================================================
GetDefensiveSpecies:
	ldh a, [hBattleTurn]
	and a
	ld a, [wEnemyMonSpecies]
	ret z
	ld a, [wBattleMonSpecies]
	ret

AttackedMissed:
	ld a, 1
	ld [wAttackMissed], a
	ret
