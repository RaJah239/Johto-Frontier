DefensiveAbilities:
	call HandleWaterAbsorb
	call HandleFireAbsorb
	call HandleVoltAbsorb
	call HandleImmunity
	; fallthrough

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
	jmp AttackedMissed

AbilityPopup_LevitateText:
	db "Levitate@"


HandleWaterAbsorb:
	call GetDefensiveMoveType
	cp WATER
	ret nz

	call GetDefensiveSpecies
	ld hl, WaterAbsorbPokemon
	call IsInByteArray
	ret nc

	showdefensiveability AbilityPopup_WaterproofText
	ld hl, WaterAbsorbText
	call StdBattleTextbox
	jmp AttackedMissed

AbilityPopup_WaterproofText:
	db "Waterproof@"

INCLUDE "data/abilities/water_absorb_mons.asm"


HandleFireAbsorb:
	call GetDefensiveMoveType
	cp FIRE
	ret nz

	call GetDefensiveSpecies
	ld hl, FireAbsorbPokemon
	call IsInByteArray
	ret nc

	showdefensiveability AbilityPopup_FlameWardText
	ld hl, FireAbsorbText
	call StdBattleTextbox
	jr AttackedMissed

AbilityPopup_FlameWardText:
	db "Flame Ward@"

INCLUDE "data/abilities/fire_absorb_mons.asm"


HandleVoltAbsorb:
	call GetDefensiveMoveType
	cp ELECTRIC
	ret nz

	call GetDefensiveSpecies
	ld hl, VoltAbsorbPokemon
	call IsInByteArray
	ret nc

	showdefensiveability AbilityPopup_GroundedText
	ld hl, VoltAbsorbText
	call StdBattleTextbox
	jr AttackedMissed

AbilityPopup_GroundedText:
	db "Grounded@"

INCLUDE "data/abilities/volt_absorb_mons.asm"


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

INCLUDE "data/abilities/immunity_mons.asm"


; ===========================================================================
; Get the type of the move currently attacking.
; Returns: A = move type
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
; Returns: A = defending Pokémon species
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
