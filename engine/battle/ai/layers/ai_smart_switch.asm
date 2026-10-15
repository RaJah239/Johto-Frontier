AI_Smart_Switch:
; don't switch if enemy is weakened, just let it die
; switch if enemy is choice locked into a NVE move
; switch if enemy accuracy at -2 or lower
; switch if enemy attack at -2 or lower and has unboosted special attack
; switch if enemy is cursed
; 50% chance to switch if enemy afflicted with toxic
; 50% chance to switch if enemy afflicted with leech seed

; switch if choice locked into a NVE move
	ld hl, wEnemySubStatus5
	bit SUBSTATUS_ENCORED, [hl]
	jr z, .not_encored
	push hl
	ld a, 1
	ldh [hBattleTurn], a
	ld a, [wCurEnemyMove]
	call AIGetEnemyMove
	callfar BattleCheckTypeMatchup
	pop hl
	ld a, [wTypeMatchup]
	cp EFFECTIVE
	jmp c, .switch
	and a
	jmp z, .switch

; switch if locked into a move with 0 pp
	ld hl, wEnemyMonPP
	ld a, [wCurEnemyMoveNum]
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl]
	and PP_MASK
	jmp z, .switch

.not_encored
; don't switch if enemy is weakened, just let it die
	call AICheckEnemyQuarterHP
	ret nc

; switch if enemy accuracy at -2 or lower
	ld a, [wEnemyAccLevel]
	cp BASE_STAT_LEVEL - 1
	jmp c, .switch

; switch if the enemy's role-appropriate offense is at -2 or lower
; don't do this if either offense is currently boosted or the mon is mixed
    ld a, [wEnemyAtkLevel]
    cp BASE_STAT_LEVEL + 1
    jr nc, .magic_guard
    ld a, [wEnemySAtkLevel]
    cp BASE_STAT_LEVEL + 1
    jr nc, .magic_guard
	call IsEnemyPhysicalOrSpecial
	jr z, .magic_guard
	jr c, .checkLoweredAttack
    ld a, [wEnemySAtkLevel]
	cp BASE_STAT_LEVEL - 1
	jr c, .switchForLoweredOffense
	jr .magic_guard

.checkLoweredAttack
    ld a, [wEnemyAtkLevel]
	cp BASE_STAT_LEVEL - 1
	jr c, .switchForLoweredOffense
	jr .magic_guard

.switchForLoweredOffense
	call AI_80_20
	ret c
	jr .check_setup_and_switch_if_we_cant_KO

.magic_guard
; Pokemon who are immune to residual damage (magic guard) should not be considered
	ld a, [wEnemyMonSpecies]
	call DoesPokemonHaveMagicGuard
	ret c

; switch if enemy is cursed
	ld a, [wEnemySubStatus1]
	bit SUBSTATUS_CURSE, a
	jr nz, .check_setup_and_switch_if_we_cant_KO

; if enemy afflicted with toxic
; 50% chance to switch when above 50% hp if not set up
; switch when below 50% hp
	ld a, [wEnemySubStatus5]
	bit SUBSTATUS_TOXIC, a
	jr z, .check_leech_seed
	call AICheckEnemyHalfHP
	jr nc, .check_setup_and_switch_if_we_cant_KO
	call AI_50_50
	jr c, .check_leech_seed
	jr .check_setup_and_switch_if_we_cant_KO

.check_leech_seed
; 30% chance to switch per turn if enemy afflicted with leech seed
	ld a, [wEnemySubStatus4]
	bit SUBSTATUS_LEECH_SEED, a
	ret z
	call Random
	cp 70 percent + 1
	ret c
	jr .check_setup_and_switch_if_we_cant_KO

; don't switch if enemy mon is already set up
	call IsAISetup
	ret c

; switch if player attempts to set up
	ld a, [wPlayerMoveStruct + MOVE_EFFECT]
	push hl
	push de
	push bc
	ld hl, BoostingMoveEffects
	call IsInByteArray
	pop bc
	pop de
	pop hl
	jr c, .switch
	ret
	
.check_setup_and_switch_if_we_cant_KO
	ld a, [wCurPlayerMove]
	cp SUBSTITUTE
	jr z, .skipKOCheck
	cp PROTECT
	jr z, .skipKOCheck

    call DoesPlayerHaveIntactFocusSashOrSturdy
    jr c, .skipKOCheck

	call CanAIKO
	ret c
	call IsAISetup
	ret c
.skipKOCheck
    call IsAISetup
    ret c
.switch
; can't switch if trapped
	ld a, [wBattleMonSpecies]
	cp GENGAR
	ret z
	cp CHANDELURE
	ret z

	ld a, $1
	ld [wEnemyIsSwitching], a
	ret
