DefensiveAbilities:
	call HandleWaterAbsorb
	call HandleFireAbsorb
	call HandleVoltAbsorb
	call HandleImmunity
	; fallthrough

HandleLevitate:
    ldh a, [hBattleTurn]
	and a
	ld a, [wEnemyMoveStruct + MOVE_TYPE]
	jr nz, .checkType
	ld a, [wPlayerMoveStruct + MOVE_TYPE]
.checkType
	and TYPE_MASK
	cp GROUND
    ret nz

	ldh a, [hBattleTurn]
	and a
	ld a, [wEnemyMonSpecies]
	jr z, .check_levitate
	ld a, [wBattleMonSpecies]

.check_levitate
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
    ldh a, [hBattleTurn]
	and a
	ld a, [wEnemyMoveStruct + MOVE_TYPE]
	jr nz, .checkType
	ld a, [wPlayerMoveStruct + MOVE_TYPE]
.checkType
	and TYPE_MASK
	cp WATER
    ret nz

	ldh a, [hBattleTurn]
	and a
	ld a, [wEnemyMonSpecies]
	jr z, .check_water_absorb
	ld a, [wBattleMonSpecies]

.check_water_absorb
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
    ldh a, [hBattleTurn]
	and a
	ld a, [wEnemyMoveStruct + MOVE_TYPE]
	jr nz, .checkType
	ld a, [wPlayerMoveStruct + MOVE_TYPE]
.checkType
	and TYPE_MASK
	cp FIRE
    ret nz

	ldh a, [hBattleTurn]
	and a
	ld a, [wEnemyMonSpecies]
	jr z, .check_fire_absorb
	ld a, [wBattleMonSpecies]

.check_fire_absorb
	ld hl, FireAbsorbPokemon
	call IsInByteArray
    ret nc
	showdefensiveability AbilityPopup_FlameWardText
	ld hl, FireAbsorbText
	call StdBattleTextbox
	jr AttackedMissed

INCLUDE "data/abilities/fire_absorb_mons.asm"

AbilityPopup_FlameWardText:
	db "Flame Ward@"

HandleVoltAbsorb:
    ldh a, [hBattleTurn]
	and a
	ld a, [wEnemyMoveStruct + MOVE_TYPE]
	jr nz, .checkType
	ld a, [wPlayerMoveStruct + MOVE_TYPE]
.checkType
	and TYPE_MASK
	cp ELECTRIC
    ret nz

	ldh a, [hBattleTurn]
	and a
	ld a, [wEnemyMonSpecies]
	jr z, .check_volt_absorb
	ld a, [wBattleMonSpecies]

.check_volt_absorb
	ld hl, VoltAbsorbPokemon
	call IsInByteArray
    ret nc
    showdefensiveability AbilityPopup_GroundedText
.finish_ability
	ld hl, VoltAbsorbText
	call StdBattleTextbox
	jr AttackedMissed

AbilityPopup_GroundedText:
	db "Grounded@"

INCLUDE "data/abilities/volt_absorb_mons.asm"

AttackedMissed:
	ld a, 1
	ld [wAttackMissed], a
	ret

HandleImmunity:
    ldh a, [hBattleTurn]
	and a
	ld a, [wEnemyMoveStruct + MOVE_TYPE]
	jr nz, .checkType
	ld a, [wPlayerMoveStruct + MOVE_TYPE]
.checkType
	and TYPE_MASK
	cp POISON
    ret nz

	ldh a, [hBattleTurn]
	and a
	ld a, [wEnemyMonSpecies]
	jr z, .check_immunity
	ld a, [wBattleMonSpecies]

.check_immunity
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
