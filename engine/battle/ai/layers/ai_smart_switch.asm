AI_Smart_Switch:
; From repo A. Sets wEnemyIsSwitching to ask for a switch at the start of the
; turn (Battle_EnemyFirst / Battle_PlayerFirst then call AI_TrySwitch).
; Enemies can switch intelligently under certain conditions
; switch if unboosted enemy is FRZ and player sets up
; 50% chance to switch if unboosted enemy is SLP and player sets up
; don't switch if enemy is weakened, just let it die
; switch if enemy is choice locked into a resisted or immune move
; switch if enemy accuracy at -2 or lower
; switch if enemy attack at -2 or lower and has unboosted special attack
; switch if enemy is cursed
; toxic only influences switching once the counter has ramped past 3 turns
; 50% chance to switch if enemy afflicted with leech seed

; possibly switch if enemy is setup bait
;	ld a, [wEnemyMonStatus]
;	and 1 << FRZ
;	jp nz, .checkSetupAndSwitchIfPlayerSetsUp

; switch if choice locked into a resisted or immune move
	ld hl, wEnemySubStatus5
	bit SUBSTATUS_ENCORED, [hl]
	jr z, .not_encored
	ld a, 1
	ldh [hBattleTurn], a
	ld a, [wCurEnemyMove]
	call AIGetEnemyMove
	; the move doesn't affect the player's mon because of its ability
	; (repo A: DoesEnemyMoveTypeTriggerPlayerAbilityImmunity)
	ld a, [wEnemyMoveStruct + MOVE_TYPE]
	and TYPE_MASK
	ld b, a
	farcall AI_IsPlayerImmuneByAbility
	jp c, .switch
	push hl
	callfar BattleCheckTypeMatchup
	pop hl
	ld a, [wTypeMatchup]
	cp EFFECTIVE
	jp c, .switch
	and a
	jp z, .switch

; switch if locked into a move with 0 pp
	ld hl, wEnemyMonPP
	ld a, [wCurEnemyMoveNum]
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl]
	and PP_MASK
	jp z, .switch
.not_encored

; don't switch if enemy is weakened, just let it die
	call AICheckEnemyQuarterHP
	ret nc

; switch if enemy accuracy at -2 or lower
    ld a, [wEnemyAccLevel]
	cp BASE_STAT_LEVEL - 1
	jp c, .switch

; switch if the enemy's role-appropriate offense is at -2 or lower
; don't do this if either offense is currently boosted or the mon is mixed
    ld a, [wEnemyAtkLevel]
    cp BASE_STAT_LEVEL + 1
    jr nc, .magicGuard
    ld a, [wEnemySAtkLevel]
    cp BASE_STAT_LEVEL + 1
    jr nc, .magicGuard
	call IsEnemyPhysicalOrSpecial
	jr z, .magicGuard
	jr c, .checkLoweredAttack
    ld a, [wEnemySAtkLevel]
	cp BASE_STAT_LEVEL - 1
	jr c, .switchForLoweredOffense
	jr .magicGuard

.checkLoweredAttack
    ld a, [wEnemyAtkLevel]
	cp BASE_STAT_LEVEL - 1
	jr c, .switchForLoweredOffense
	jr .magicGuard

.switchForLoweredOffense
	call AI_80_20
	ret c
	jr .checkSetupAndSwitchIfWeCantKO

.magicGuard
; Pokemon who are immune to residual damage (magic guard) should not be considered
    ld a, [wEnemyMonSpecies]
    call DoesPokemonHaveMagicGuard
	ret c

; switch if enemy is cursed
    ld a, [wEnemySubStatus1]
	bit SUBSTATUS_CURSE, a
	jr nz, .checkSetupAndSwitchIfWeCantKO

; if enemy afflicted with toxic
; 50% chance to switch when above 50% hp if not set up
; switch when below 50% hp
    ld a, [wEnemySubStatus5]
	bit SUBSTATUS_TOXIC, a
    jr z, .checkLeechSeed
	ld a, [wEnemyToxicCount]
	cp 4
	jr c, .checkLeechSeed
	call AICheckEnemyHalfHP
	jr nc, .checkSetupAndSwitchIfWeCantKO
	call AI_50_50
	jr c, .checkLeechSeed
	jr .checkSetupAndSwitchIfWeCantKO

.checkLeechSeed
; 30% chance to switch per turn if enemy afflicted with leech seed
    ld a, [wEnemySubStatus4]
	bit SUBSTATUS_LEECH_SEED, a
	ret z
	call Random
	cp 70 percent + 1
	ret c
	jr .checkSetupAndSwitchIfWeCantKO

.checkSetupAndSwitchIfPlayerSetsUp
; don't switch if enemy mon is already set up
    call IsAISetup
    ret c
; switch if player attempts to set up
	ld a, [wPlayerMoveStruct + MOVE_EFFECT]
    push hl
    push de
	push bc
	ld hl, BoostingMoveEffects
	ld de, 1
	call IsInArray
	pop bc
	pop de
	pop hl
	jr c, .switch
	ret

.checkSetupAndSwitchIfWeCantKO
    ld a, [wCurPlayerMove]
    cp SUBSTITUTE
    jr z, .skipKOCheck
    cp PROTECT
    jr z, .skipKOCheck

    call DoesPlayerHaveIntactFocusSashOrSturdy
    jr c, .skipKOCheck

    call CanAIKO
    ret c
.skipKOCheck
    call IsAISetup
    ret c
    ; fallthrough
.switch
; can't switch if trapped (repo A checks its own trapping species)
	call IsEnemyTrappedByPlayerAbility
	ret c

    ld a, $1
    ld [wEnemyIsSwitching], a
	ret

