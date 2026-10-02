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

	ld a, [wOptions4]
	bit ABILITY_BANNERS, a
	jr nz, .skip_ability_banner

; ===========================================================================+
    ; ability popup box                                                      |
	; slide the ability popup over the TARGET's HUD (the one with Levitate)  |
	; hBattleTurn = 0 means player is attacking, so target is enemy          |
	; hBattleTurn = 1 means enemy is attacking, so target is player          |
	ldh a, [hBattleTurn] ;                                                   |
	xor 1 ;                                                                  |
	ld c, a ; ABILITY_POPUP_PLAYER / ABILITY_POPUP_ENEMY (target's side)     |
	ld b, BANK(AbilityPopup_LevitateText) ;                                  |
	ld de, AbilityPopup_LevitateText ;                                       |
	farcall ShowAbilityPopup ;                                               |
	jr .finish_ability
; ===========================================================================+

.skip_ability_banner
	; add some delay so the text isn't instantly skipped
	ld c, 30
	call DelayFrames

.finish_ability
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

	ld a, [wOptions4]
	bit ABILITY_BANNERS, a
	jr nz, .skip_ability_banner

; ===========================================================================+
    ; ability popup box                                                      |
	; slide the ability popup over the TARGET's HUD (the one with Levitate)  |
	; hBattleTurn = 0 means player is attacking, so target is enemy          |
	; hBattleTurn = 1 means enemy is attacking, so target is player          |
	ldh a, [hBattleTurn] ;                                                   |
	xor 1 ;                                                                  |
	ld c, a ; ABILITY_POPUP_PLAYER / ABILITY_POPUP_ENEMY (target's side)     |
	ld b, BANK(AbilityPopup_Waterproof) ;                                  |
	ld de, AbilityPopup_Waterproof ;                                       |
	farcall ShowAbilityPopup ;                                               |
	jr .finish_ability
; ===========================================================================+

.skip_ability_banner
    ; add some delay so the text isn't instantly skipped
	ld c, 30
	call DelayFrames

.finish_ability
	ld hl, WaterAbsorbText
	call StdBattleTextbox
	jr AttackedMissed

AbilityPopup_Waterproof:
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

    ; add some delay so the text 
    ; isn't instantly skipped
	ld c, 30
	call DelayFrames

	ld hl, FireAbsorbText
	call StdBattleTextbox
	jr AttackedMissed

INCLUDE "data/abilities/fire_absorb_mons.asm"

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
	jr AttackedMissed

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

    ; add some delay so the text 
    ; isn't instantly skipped
	ld c, 30
	call DelayFrames

	ld hl, ImmunityText
	call StdBattleTextbox
	jr AttackedMissed

INCLUDE "data/abilities/immunity_mons.asm"
