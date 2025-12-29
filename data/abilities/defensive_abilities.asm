DefensiveAbilities:
	call HandleLevitate
	call HandleWaterAbsorb
	call HandleFireAbsorb
	call HandleVoltAbsorb
	ret

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

    ; add some delay so the text 
    ; isn't instantly skipped
	ld c, 30
	call DelayFrames

	ld hl, LevitateText
	call StdBattleTextbox
	ld a, 1
	ld [wAttackMissed], a
	ret

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

    ; add some delay so the text 
    ; isn't instantly skipped
	ld c, 30
	call DelayFrames

	ld hl, WaterAbsorbText
	call StdBattleTextbox
	ld a, 1
	ld [wAttackMissed], a
	ret

INCLUDE "data/abilities/ability_mons/water_absorb_mons.asm"

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

    ; add some delay so the text 
    ; isn't instantly skipped
	ld c, 30
	call DelayFrames

	ld hl, FireAbsorbText
	call StdBattleTextbox
	ld a, 1
	ld [wAttackMissed], a
	ret

INCLUDE "data/abilities/ability_mons/fire_absorb_mons.asm"

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

    ; add some delay so the text 
    ; isn't instantly skipped
	ld c, 30
	call DelayFrames

	ld hl, VoltAbsorbText
	call StdBattleTextbox
	ld a, 1
	ld [wAttackMissed], a
	ret

INCLUDE "data/abilities/ability_mons/volt_absorb_mons.asm"
