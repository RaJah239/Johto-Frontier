DefensiveAbilities:
	call HandleLevitate
	call HandleWaterAbsorb
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
