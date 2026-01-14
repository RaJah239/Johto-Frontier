AIScoring: ; used only for BANK(AIScoring)

INCLUDE "engine/battle/ai/layers/ai_basic.asm"
INCLUDE "engine/battle/ai/layers/ai_smart.asm"
INCLUDE "engine/battle/ai/layers/ai_aggressive.asm"
INCLUDE "engine/battle/ai/layers/ai_final_attack.asm"
INCLUDE "engine/battle/ai/layers/ai_smart_switch.asm"

INCLUDE "engine/battle/ai/layers/ai_none.asm"

; unused layers
INCLUDE "engine/battle/ai/layers/ai_types.asm"
INCLUDE "engine/battle/ai/layers/ai_cautious.asm"
INCLUDE "engine/battle/ai/layers/ai_status.asm"
INCLUDE "engine/battle/ai/layers/ai_risky.asm"
INCLUDE "engine/battle/ai/layers/ai_offensive.asm"

INCLUDE "engine/battle/ai/ability_lists.asm"

INCLUDE "data/battle/ai/status_only_effects.asm"

BoostingMoveEffects:
	db EFFECT_ATTACK_UP_2
	db EFFECT_SP_ATK_UP
	db EFFECT_SP_ATK_UP_2
	db EFFECT_SUBSTITUTE
	db EFFECT_CURSE
	db EFFECT_CALM_MIND
	db EFFECT_BULK_UP
	db EFFECT_DRAGON_DANCE
	db EFFECT_QUIVER_DANCE
	db EFFECT_FURY_DRIVE
	db -1 ; end

AIDiscourageMove:
	ld a, [hl]
	add 20
	ld [hl], a
	ret

AIGetEnemyMove:
; Load attributes of move a into ram

	push hl
	push de
	push bc
	dec a
	ld hl, Moves
	ld bc, MOVE_LENGTH
	call AddNTimes

	ld de, wEnemyMoveStruct
	ld a, BANK(Moves)
	call FarCopyBytes
	jmp PopBCDEHL

AIGetPlayerMove:
; Load attributes of move a into ram

	push hl
	push de
	push bc
	dec a
	ld hl, Moves
	ld bc, MOVE_LENGTH
	call AddNTimes

	ld de, wPlayerMoveStruct
	ld a, BANK(Moves)
	call FarCopyBytes

	pop bc
	pop de
	pop hl
	ret

AI_80_20:
	call Random
	cp 20 percent - 1
	ret

AI_50_50:
	call Random
	cp 50 percent + 1
	ret

AIDamageCalc:
	ld a, 1
	ldh [hBattleTurn], a
	ld a, [wEnemyMoveStruct + MOVE_EFFECT]
	ld de, 1
	ld hl, ConstantDamageEffects
	call IsInArray
	jr nc, .notconstant
	callfar BattleCommand_ConstantDamage
	ret

.notconstant
	callfar EnemyAttackDamage
	callfar BattleCommand_DamageCalc
	callfar BattleCommand_Stab
	ret

INCLUDE "data/battle/ai/constant_damage_effects.asm"

AICompareSpeed:
; Return carry if enemy is faster than player.

	push bc
	ld a, [wEnemyMonSpeed + 1]
	ld b, a
	ld a, [wBattleMonSpeed + 1]
	cp b
	ld a, [wEnemyMonSpeed]
	ld b, a
	ld a, [wBattleMonSpeed]
	sbc b
	pop bc
	ret

AICheckPlayerMaxHP:
	push hl
	push de
	push bc
	ld de, wBattleMonHP
	ld hl, wBattleMonMaxHP
	jr AICheckMaxHP

AICheckEnemyMaxHP:
	push hl
	push de
	push bc
	ld de, wEnemyMonHP
	ld hl, wEnemyMonMaxHP
	; fallthrough

AICheckMaxHP:
; Return carry if hp at de matches max hp at hl.

	ld a, [de]
	inc de
	cp [hl]
	jr nz, .not_max

	inc hl
	ld a, [de]
	cp [hl]
	jr nz, .not_max

	pop bc
	pop de
	pop hl
	scf
	ret

.not_max
	pop bc
	pop de
	pop hl
	and a
	ret

AICheckPlayerHalfHP:
	push hl
	ld hl, wBattleMonHP
	ld b, [hl]
	inc hl
	ld c, [hl]
	sla c
	rl b
	inc hl
	inc hl
	ld a, [hld]
	cp c
	ld a, [hl]
	sbc b
	pop hl
	ret

AICheckEnemyHalfHP:
	push hl
	push de
	push bc
	ld hl, wEnemyMonHP
	ld b, [hl]
	inc hl
	ld c, [hl]
	sla c
	rl b
	inc hl
	inc hl
	ld a, [hld]
	cp c
	ld a, [hl]
	sbc b
	jmp PopBCDEHL

AICheckEnemyQuarterHP:
	push hl
	push de
	push bc
	ld hl, wEnemyMonHP
	ld b, [hl]
	inc hl
	ld c, [hl]
	sla c
	rl b
	sla c
	rl b
	inc hl
	inc hl
	ld a, [hld]
	cp c
	ld a, [hl]
	sbc b
	jmp PopBCDEHL

AICheckPlayerQuarterHP:
	push hl
	ld hl, wBattleMonHP
	ld b, [hl]
	inc hl
	ld c, [hl]
	sla c
	rl b
	sla c
	rl b
	inc hl
	inc hl
	ld a, [hld]
	cp c
	ld a, [hl]
	sbc b
	pop hl
	ret

AIHasMoveEffect:
; Return carry if the enemy has move b.

	push hl
	ld hl, wEnemyMonMoves
	ld c, NUM_MOVES

.checkmove
	ld a, [hli]
	and a
	jr z, .no

	call AIGetEnemyMove

	ld a, [wEnemyMoveStruct + MOVE_EFFECT]
	cp b
	jr z, .yes

	dec c
	jr nz, .checkmove

.no
	pop hl
	and a
	ret

.yes
	pop hl
	scf
	ret

PlayerHasMoveEffect:
; Return carry if the player has move b.

	push hl
	ld hl, wBattleMonMoves
	ld c, NUM_MOVES

.checkmove
	ld a, [hli]
	and a
	jr z, .no

	call AIGetPlayerMove

	ld a, [wPlayerMoveStruct + MOVE_EFFECT]
	cp b
	jr z, .yes

	dec c
	jr nz, .checkmove

.no
	pop hl
	and a
	ret

.yes
	pop hl
	scf
	ret

AIHasMoveInArray:
; Return carry if the enemy has a move in array hl.

	push hl
	push de
	push bc

.next
	ld a, [hli]
	cp -1
	jr z, .done

	ld b, a
	ld c, NUM_MOVES + 1
	ld de, wEnemyMonMoves

.check
	dec c
	jr z, .next

	ld a, [de]
	inc de
	cp b
	jr nz, .check

	scf

.done
	jmp PopBCDEHL

INCLUDE "data/battle/ai/useful_moves.asm"

DoIt:
rept 7
	dec [hl]
endr
StrongEncourage:
	dec [hl]
StandardEncourage:
	dec [hl]
	dec [hl]
	ret

StandardDiscourage:
	inc [hl]
	inc [hl]
	inc [hl]
	inc [hl]
	inc [hl]
	inc [hl]
	ret

; ================================
; === Speed Checks - Simulated ===
; ================================
DoesAIOutSpeedPlayer:
; logic for the weather speed boosting abilities
; since they don't actually increase speed
	ld a, [wEnemyMonStatus]
	and 1 << PAR
	jr nz, .check_player
	ld a, [wPlayerSpdLevel]
	cp BASE_STAT_LEVEL + 2
	jr nc, .check_player

; check_rain
	ld a, [wBattleWeather]
	cp WEATHER_RAIN
	jr nz, .check_sun
	ld a, [wEnemyMonSpecies]
	push hl
	push de
	push bc
	ld hl, SwiftSwimPokemon_AI
	call IsInByteArray
	pop bc
	pop de
	pop hl
	jmp c, .yes

.check_sun
	ld a, [wBattleWeather]
	cp WEATHER_SUN
	jr nz, .check_sand
	ld a, [wEnemyMonSpecies]
	push hl
	push de
	push bc
	ld hl, ChlorophyllPokemon_AI
	call IsInByteArray
	pop bc
	pop de
	pop hl
	jmp c, .yes

.check_sand
	ld a, [wBattleWeather]
	cp WEATHER_SANDSTORM
	jr nz, .check_hail
	ld a, [wEnemyMonSpecies]
	push hl
	push de
	push bc
	ld hl, SandRushPokemon_AI
	call IsInByteArray
	pop bc
	pop de
	pop hl
	jmp c, .yes

.check_hail
	ld a, [wBattleWeather]
	cp WEATHER_HAIL
	jr nz, .check_player
	ld a, [wEnemyMonSpecies]
	push hl
	push de
	push bc
	ld hl, SlushRushPokemon_AI
	call IsInByteArray
	pop bc
	pop de
	pop hl
	jmp c, .yes

.check_player
	ld a, [wBattleMonStatus]
	and 1 << PAR
	jr nz, .speed_check
	ld a, [wEnemySpdLevel]
	cp BASE_STAT_LEVEL + 2
	jr nc, .speed_check

;.check_rain_player
	ld a, [wBattleWeather]
	cp WEATHER_RAIN
	jr nz, .check_sun_player
	ld a, [wBattleMonSpecies]
	push hl
	push de
	push bc
	ld hl, SwiftSwimPokemon_AI
	call IsInByteArray
	pop bc
	pop de
	pop hl
	jr c, .no

.check_sun_player
	ld a, [wBattleWeather]
	cp WEATHER_SUN
	jr nz, .check_sand_player
	ld a, [wBattleMonSpecies]
	push hl
	push de
	push bc
	ld hl, ChlorophyllPokemon_AI
	call IsInByteArray
	pop bc
	pop de
	pop hl
	jr c, .no

.check_sand_player
	ld a, [wBattleWeather]
	cp WEATHER_SANDSTORM
	jr nz, .check_hail_player
	ld a, [wBattleMonSpecies]
	push hl
	push de
	push bc
	ld hl, SandRushPokemon_AI
	call IsInByteArray
	pop bc
	pop de
	pop hl
	jr c, .no

.check_hail_player
	ld a, [wBattleWeather]
	cp WEATHER_HAIL
	jr nz, .speed_check
	ld a, [wBattleMonSpecies]
	push hl
	push de
	push bc
	ld hl, SlushRushPokemon_AI
	call IsInByteArray
	pop bc
	pop de
	pop hl
	jr c, .no

.speed_check
; Return carry if enemy is faster than player.
	push bc
	ld a, [wEnemyMonSpeed + 1]
	ld b, a
	ld a, [wBattleMonSpeed + 1]
	cp b
	ld a, [wEnemyMonSpeed]
	ld b, a
	ld a, [wBattleMonSpeed]
	sbc b
	pop bc
	jr nc, .no

.yes
	ld a, [wTrickRoomCount]
	and a
	jr z, .doYes
	xor a
	ret

.doYes
	scf
	ret

.no
	ld a, [wTrickRoomCount]
	and a
	jr z, .doNo
	scf
	ret

.doNo
	xor a
	ret

; =============================
; === AI Boosting Functions ===
; =============================

; functions to check if the player can KO the AI
; and decide to use boosting moves

; decide if AI should use boosting moves
; generally don't boost if player will just KO anyway
; returns carry if the AI can boost
ShouldAIBoost:
	call IsAttackMaxed
	jmp c, .dont_boost
	call IsSpecialAttackMaxed
	jmp c, .dont_boost

; don't boost if choice locked
	call DoesEnemyHaveChoiceItem
	jmp c, .dont_boost

; if players last move was sucker punch - 50% chance to boost
	ld a, [wCurPlayerMove]
	call AIGetPlayerMove
	ld a, [wPlayerMoveStruct + MOVE_EFFECT]
	cp EFFECT_SUCKER_PUNCH
	jr nz, .not_using_sucker_punch
	call AI_50_50
	ret c

.not_using_sucker_punch
; if we are faster and player is flying or underground just boost
	call DoesAIOutSpeedPlayer
	jr nc, .check_uber_immune
	ld a, [wPlayerSubStatus3]
	and 1 << SUBSTATUS_FLYING | 1 << SUBSTATUS_UNDERGROUND
	jmp nz, .boost

.check_uber_immune
; if the player has roar/whirlwind/haze
; and we aren't immune to it then 50% to not boost
	ld a, [wEnemyMonSpecies]
	call DoesPokemonHaveUberImmunity
	jr c, .no_force_switch

	ld a, [wCurPlayerMove]
	call AIGetPlayerMove
	ld a, [wPlayerMoveStruct + MOVE_EFFECT]
	cp EFFECT_FORCE_SWITCH
	jmp z, .dont_boost

	ld b, EFFECT_FORCE_SWITCH
	call PlayerHasMoveEffect
	jr c, .maybe_dont_boost
	ld b, EFFECT_RESET_STATS
	call PlayerHasMoveEffect
	jr c, .maybe_dont_boost
	jr .no_force_switch

.maybe_dont_boost
	call Random
	cp 50 percent
	jr c, .decide_not_to_boost

.no_force_switch
; if our offence is already at or over +1
; and either side can 2HKO, just attack
; this is to prevent the AI from boosting
; until it only gets one attack off,
; should attack earlier for more damage
	ld a, [wEnemyAtkLevel]
	cp BASE_STAT_LEVEL + 1
	jr c, .check_special_attack
	jr .check_mutual_2HKO

.check_special_attack
	ld a, [wEnemySAtkLevel]
	cp BASE_STAT_LEVEL + 1
	jr c, .check_speed

.check_mutual_2HKO
; if  player is physical then skip mutual 2HKO check
	call IsPlayerPhysicalOrSpecial
	jr c, .check_speed

	call CanAI2HKO
	jr c, .decide_not_to_boost
	call CanPlayer2HKO
	jr c, .decide_not_to_boost

.check_speed
; who moves first
	call DoesAIOutSpeedPlayer
	jr nc, .player_moves_first

.enemy_moves_first
; if AI moves first consider if player can 1HKO
; first if the AI has an intact focus sash
; or sturdy it can boost, unless player has priority move

; does player have priority move
	ld b, EFFECT_PRIORITY_HIT
	call PlayerHasMoveEffect
	jr c, .skip_sturdy_sash_check

	call DoesEnemyHaveIntactFocusSashOrSturdy
	jmp c, .boost

.skip_sturdy_sash_check
	call CanPlayerKO
	jr c, .decide_not_to_boost
	jmp .boost

.player_moves_first
; does the boost increase speed,
; these moves are treated differently
	ld a, [wEnemyMoveStruct + MOVE_ANIM]
	cp DRAGON_DANCE
	jr z, .enemy_moves_first
	cp QUIVER_DANCE
	jr z, .enemy_moves_first

; if player moves first consider if they can 2HKO
	call CanPlayer2HKO
	jr c, .decide_not_to_boost
	jr .boost

.decide_not_to_boost
; if player is asleep and we get more than one turn before they wake up,
; then boost
	ld a, [wBattleMonStatus]
	and SLP_MASK
	jr z, .keep_going

	call DoesAIOutSpeedPlayer
	jr nc, .playerFaster
	ld b, 1
	jr .check_sleep
.playerFaster
	ld b, 2

.check_sleep
	ld a, [wBattleMonStatus]
	and SLP_MASK
	cp b
	jr z, .keep_going
	jr .boost

.keep_going
; is the player behind a sub, if so don't boost, just attack
; unless we have baton pass, in which case boost up
	ld b, EFFECT_BATON_PASS
	call AIHasMoveEffect
	jr c, .skipSubCheck
	ld a, [wPlayerSubStatus4]
	bit SUBSTATUS_SUBSTITUTE, a	;check for substitute bit
	jr nz, .dont_boost

.skipSubCheck
; is the player setting up - if so we may want to boost to force them to stop and attack
; if the player already has +4 attack or special attack then they have already set up, just attack
; if the AI already has +2 attack or special attack then just attack
; if the players last move was a healing move 50% chance to set up if we can't already 2HKO from max HP
; otherwise if the players last move was non-damaging 50% chance to set up if we can't already 3HKO from current HP
	ld a, [wPlayerAtkLevel]
	cp BASE_STAT_LEVEL + 4
	jr nc, .dont_boost
	ld a, [wPlayerSAtkLevel]
	cp BASE_STAT_LEVEL + 4
	jr nc, .dont_boost

	ld a, [wEnemyAtkLevel]
	cp BASE_STAT_LEVEL + 2
	jr nc, .dont_boost
	ld a, [wEnemySAtkLevel]
	cp BASE_STAT_LEVEL + 2
	jr nc, .dont_boost

	ld a, [wCurPlayerMove]
	call AIGetPlayerMove
	ld a, [wPlayerMoveStruct + MOVE_EFFECT]
	cp EFFECT_HEAL
	jr z, .check_2HKO_at_max_HP
	cp EFFECT_WEATHER_HEAL

	push hl
	push de
	push bc
	ld hl, BoostingMoveEffects
	call IsInByteArray
	pop bc
	pop de
	pop hl
	jr c, .check_2HKO
	jr .dont_boost

.check_2HKO
	call CanAI2HKO
	jr c, .dont_boost
	call Random
	cp 25 percent + 1
	jr c, .dont_boost
	jr .boost

.check_2HKO_at_max_HP
	call CanAI2HKOMaxHP
	jr c, .dont_boost
	call Random
	cp 25 percent + 1
	jr c, .dont_boost

.boost
	scf ; set carry flag
	ret

.dont_boost
	xor a ; clear carry flag
	ret

DoesEnemyHaveChoiceItem:
	push hl
	push de
	ld a, [wEnemyMonItem]
	ld [wNamedObjectIndex], a
	ld b, a
	callfar GetItemHeldEffect
	ld a, b
	cp HELD_CHOICE_BAND
	jr z, .yes
	cp HELD_CHOICE_SPECS
	jr z, .yes
	pop de
	pop hl
	xor a
	ret

.yes
	pop de
	pop hl
	scf
	ret

DoesEnemyHaveIntactFocusSashOrSturdy:
; Is the AI at full HP
	call AICheckEnemyMaxHP
	jr nc, .no

; focus sash
	push hl
	push de
	ld a, [wEnemyMonItem]
	ld [wNamedObjectIndex], a
	ld b, a
	callfar GetItemHeldEffect
	ld a, b
	cp HELD_FOCUS_SASH
	pop de
	pop hl
	jr z, .yes

; sturdy
	ld a, [wEnemyMonSpecies]
	push bc
	push hl
	push de
	ld hl, SturdyPokemon_AI
	call IsInByteArray
	pop de
	pop hl
	pop bc
	jr c, .yes

.no
	xor a ; clear carry flag
	ret

.yes
	scf
	ret

IsAIToxified:
	ld a, [wEnemyMonSpecies]
	call DoesPokemonHaveMagicGuard
	jr c, .no

	ld a, [wEnemySubStatus5]
	bit SUBSTATUS_TOXIC, a
	jr nz, .yes

.no
	xor a ; clear carry flag
	ret

.yes
	scf
	ret

; return carry if the player has a move that can 1HKO the AI Pokemon from current HP
; used to decide if the AI should use setup moves
CanPlayerKO:
	ld de, wBattleMonMoves ; load player moves
	ld b, NUM_MOVES + 1
.loop_player_KO_moves
	dec b ; b is num moves on 1st pass
	jr z, .done ; if b is 0 return we are done
	ld a, [de] ; load the move
	and a
	jr z, .done ; return if no move
	inc de ; increment to next move
	call AIGetPlayerMove
	ld a, [wPlayerMoveStruct + MOVE_POWER]
	and a
	jr z, .loop_player_KO_moves ; skip moves with 0 power
	ld a, 0
	ldh [hBattleTurn], a
	push hl
	push de
	push bc
	callfar PlayerAttackDamage
	callfar BattleCommand_DamageCalc
	callfar BattleCommand_Stab
	ld a, [wCurDamage + 1]
	ld c, a ; c is curDamage upper
	ld a, [wCurDamage]
	ld b, a ; b is curDamage lower
	ld a, [wEnemyMonHP + 1]
	cp c ; compare upper
	ld a, [wEnemyMonHP]
	sbc b ; compare lower and set flag
	pop bc
	pop de
	pop hl
	jr nc, .loop_player_KO_moves

; skip moves that can't be used on consecutive turns, except hyper beam
	ld a, [wPlayerMoveStruct + MOVE_EFFECT]
	cp EFFECT_SELFDESTRUCT
	jr z, .loop_player_KO_moves
	cp EFFECT_SOLARBEAM
	jr z, .loop_player_KO_moves
	scf
	ret

.done
	xor a ; clear carry flag
	ret

; return carry if the player has a move that can 2HKO the AI Pokemon from current HP
; used to decide if the AI should use setup moves
CanPlayer2HKO:
    ld de, wBattleMonMoves ; load player moves
	ld b, NUM_MOVES + 1
.loop_player_2HKO_moves
	dec b ; b is num moves on 1st pass
	jr z, .done ; if b is 0 return we are done
	ld a, [de] ; load the move
	and a
	jr z, .done ; return if no move
	inc de ; increment to next move
	call AIGetPlayerMove
	ld a, [wPlayerMoveStruct + MOVE_POWER]
	and a
	jr z, .loop_player_2HKO_moves ; skip moves with 0 power
	ld a, 0
	ldh [hBattleTurn], a
	push hl
	push de
	push bc
	callfar PlayerAttackDamage
	callfar BattleCommand_DamageCalc
	callfar BattleCommand_Stab
; double current damage
	ld hl, wCurDamage + 1
	ld a, [hld]
	ld h, [hl]
	ld l, a
	add hl, hl
	ld a, h
	ld [wCurDamage], a
	ld a, l
	ld [wCurDamage + 1], a
; continue
	ld a, [wCurDamage + 1]
	ld c, a ; c is curDamage upper
	ld a, [wCurDamage]
	ld b, a ; b is curDamage lower
	ld a, [wEnemyMonHP + 1]
	cp c ; compare upper
	ld a, [wEnemyMonHP]
	sbc b ; compare lower and set flag
	pop bc
	pop de
	pop hl
	jr nc, .loop_player_2HKO_moves

; skip moves that can't be used on consecutive turns
; exception for porygon-z which can use Hyper Beam consecutively
; and ursaluna that uses giga impact consecutively
	ld a, [wBattleMonSpecies]
	ld hl, OverdrivePokemon_AI
	call IsInByteArray
	jr c, .set_flag

	ld a, [wPlayerMoveStruct + MOVE_EFFECT]
	cp EFFECT_SELFDESTRUCT
	jr z, .loop_player_2HKO_moves
	cp EFFECT_HYPER_BEAM
	jr z, .loop_player_2HKO_moves
	cp EFFECT_SOLARBEAM
	jr z, .loop_player_2HKO_moves

.set_flag
	scf
	ret

.done
	xor a ; clear carry flag
	ret

; return carry if the player has a move that can 2HKO the AI Pokemon from Max HP
; used to decide if the AI should use recovery moves
CanPlayer2HKOMaxHP:
    ld de, wBattleMonMoves ; load player moves
	ld b, NUM_MOVES + 1
.loop_player_2HKO_max_HP_moves
	dec b ; b is num moves on 1st pass
	jr z, .done ; if b is 0 return we are done
	ld a, [de] ; load the move
	and a
	jr z, .done ; return if no move
	inc de ; increment to next move
	call AIGetPlayerMove
	ld a, [wPlayerMoveStruct + MOVE_POWER]
	and a
	jr z, .loop_player_2HKO_max_HP_moves ; skip moves with 0 power
	ld a, 0
	ldh [hBattleTurn], a
	push hl
	push de
	push bc
	callfar PlayerAttackDamage
	callfar BattleCommand_DamageCalc
	callfar BattleCommand_Stab
; double current damage
	ld hl, wCurDamage + 1
	ld a, [hld]
	ld h, [hl]
	ld l, a
	add hl, hl
	ld a, h
	ld [wCurDamage], a
	ld a, l
	ld [wCurDamage + 1], a
; continue
	ld a, [wCurDamage + 1]
	ld c, a ; c is curDamage upper
	ld a, [wCurDamage]
	ld b, a ; b is curDamage lower
	ld a, [wEnemyMonMaxHP + 1]
	cp c ; compare upper
	ld a, [wEnemyMonMaxHP]
	sbc b ; compare lower and set flag
	pop bc
	pop de
	pop hl
	jr nc, .loop_player_2HKO_max_HP_moves

; skip moves that can't be used on consecutive turns - exception for Porygonz which can use Hyper Beam consecutively
	ld a, [wBattleMonSpecies]
	ld hl, OverdrivePokemon_AI
	call IsInByteArray
	jr c, .set_flag

	ld a, [wPlayerMoveStruct + MOVE_EFFECT]
	cp EFFECT_SELFDESTRUCT
	jr z, .loop_player_2HKO_max_HP_moves
	cp EFFECT_HYPER_BEAM
	jr z, .loop_player_2HKO_max_HP_moves
	cp EFFECT_SOLARBEAM
	jr z, .loop_player_2HKO_max_HP_moves

.set_flag
	scf
	ret

.done
	xor a ; clear carry flag
	ret

; return carry if the player has a move that can 3HKO the AI Pokemon from Max HP
; used to decide if the AI should use rest
CanPlayer3HKOMaxHP:
	ld de, wBattleMonMoves ; load player moves
	ld b, NUM_MOVES + 1
.loop_player_3HKO_max_HP_moves
	dec b ; b is num moves on 1st pass
	jr z, .done ; if b is 0 return we are done
	ld a, [de] ; load the move
	and a
	jr z, .done ; return if no move
	inc de ; increment to next move
	call AIGetPlayerMove
	ld a, [wPlayerMoveStruct + MOVE_POWER]
	and a
	jr z, .loop_player_3HKO_max_HP_moves ; skip moves with 0 power
	ld a, 0
	ldh [hBattleTurn], a
	push hl
	push de
	push bc
	callfar PlayerAttackDamage
	callfar BattleCommand_DamageCalc
	callfar BattleCommand_Stab
; triple current damage
	ld hl, wCurDamage + 1
	ld a, [hld]
	ld h, [hl]
	ld l, a
	ld b, h
	ld c, l
	add hl, hl
	add hl, bc
	ld a, h
	ld [wCurDamage], a
	ld a, l
	ld [wCurDamage + 1], a
; continue
	ld a, [wCurDamage + 1]
	ld c, a ; c is curDamage upper
	ld a, [wCurDamage]
	ld b, a ; b is curDamage lower
	ld a, [wEnemyMonMaxHP + 1]
	cp c ; compare upper
	ld a, [wEnemyMonMaxHP]
	sbc b ; compare lower and set flag
	pop bc
	pop de
	pop hl
	jr nc, .loop_player_3HKO_max_HP_moves

; skip moves that can't be used on consecutive turns - exception for Porygonz which can use Hyper Beam consecutively
	ld a, [wBattleMonSpecies]
	ld hl, OverdrivePokemon_AI
	call IsInByteArray
	jr c, .set_flag

	ld a, [wPlayerMoveStruct + MOVE_EFFECT]
	cp EFFECT_SELFDESTRUCT
	jr z, .loop_player_3HKO_max_HP_moves
	cp EFFECT_HYPER_BEAM
	jr z, .loop_player_3HKO_max_HP_moves
	cp EFFECT_SOLARBEAM
	jr z, .loop_player_3HKO_max_HP_moves

.set_flag
	scf
	ret

.done
	xor a ; clear carry flag
	ret

; return carry if the AI has a move that can 1HKO the player Pokemon from current HP
CanAIKO:
	ld de, wEnemyMonMoves ; load player moves
	ld b, NUM_MOVES + 1
.loop_AI_KO_moves
	dec b ; b is num moves on 1st pass
	jr z, .done ; if b is 0 return we are done
	ld a, [de] ; load the move
	and a
	jr z, .done ; return if no move
	inc de ; increment to next move
	call AIGetEnemyMove
	ld a, [wEnemyMoveStruct + MOVE_POWER]
	and a
	jr z, .loop_AI_KO_moves ; skip moves with 0 power

	ld a, 1
	ldh [hBattleTurn], a
	push hl
	push de
	push bc
	callfar EnemyAttackDamage
	callfar BattleCommand_DamageCalc
	callfar BattleCommand_Stab
	ld a, [wCurDamage + 1]
	ld c, a ; c is curDamage upper
	ld a, [wCurDamage]
	ld b, a ; b is curDamage lower
	ld a, [wBattleMonHP + 1]
	cp c ; compare upper
	ld a, [wBattleMonHP]
	sbc b ; compare lower and set flag
	pop bc
	pop de
	pop hl
	jr nc, .loop_AI_KO_moves

; skip moves that can't be used on consecutive turns, except hyper beam
	ld a, [wPlayerMoveStruct + MOVE_EFFECT]
	cp EFFECT_SELFDESTRUCT
	jr z, .loop_AI_KO_moves
	cp EFFECT_SOLARBEAM
	jr z, .loop_AI_KO_moves
	scf
	ret

.done
	xor a ; clear carry flag
	ret

; return carry if the AI has a move that can 2HKO the player Pokemon from current HP
CanAI2HKO:
	ld de, wEnemyMonMoves ; load AI moves
	ld b, NUM_MOVES + 1
.loop_moves
	dec b ; b is num moves on 1st pass
	jr z, .done ; if b is 0 return we are done
	ld a, [de] ; load the move
	and a
	jr z, .done ; return if no move
	inc de ; increment to next move
	call AIGetEnemyMove
	ld a, [wEnemyMoveStruct + MOVE_POWER]
	and a
	jr z, .loop_moves ; skip moves with 0 power

	ld a, 1
	ldh [hBattleTurn], a
	push hl
	push de
	push bc
	callfar EnemyAttackDamage
	callfar BattleCommand_DamageCalc
	callfar BattleCommand_Stab
; double current damage
	ld hl, wCurDamage + 1
	ld a, [hld]
	ld h, [hl]
	ld l, a
	add hl, hl
	ld a, h
	ld [wCurDamage], a
	ld a, l
	ld [wCurDamage + 1], a
; continue
	ld a, [wCurDamage + 1]
	ld c, a ; c is curDamage upper
	ld a, [wCurDamage]
	ld b, a ; b is curDamage lower
	ld a, [wBattleMonHP + 1]
	cp c ; compare upper
	ld a, [wBattleMonHP]
	sbc b ; compare lower and set flag
	pop bc
	pop de
	pop hl
	jr nc, .loop_moves

; skip moves that can't be used on consecutive turns, except hyper beam
	ld a, [wEnemyMonSpecies]
	ld hl, OverdrivePokemon_AI
	call IsInByteArray
	jr c, .set_flag

	ld a, [wPlayerMoveStruct + MOVE_EFFECT]
	cp EFFECT_SELFDESTRUCT
	jr z, .loop_moves
	cp EFFECT_HYPER_BEAM
	jr z, .loop_moves
	cp EFFECT_SOLARBEAM
	jr z, .loop_moves

.set_flag
	scf
	ret

.done
	xor a ; clear carry flag
	ret

; return carry if the AI has a move that can 2HKO the player Pokemon from current HP
CanAI2HKOMaxHP:
	ld de, wEnemyMonMoves ; load AI moves
	ld b, NUM_MOVES + 1
.loop_moves
	dec b ; b is num moves on 1st pass
	jr z, .done ; if b is 0 return we are done
	ld a, [de] ; load the move
	and a
	jr z, .done ; return if no move
	inc de ; increment to next move
	call AIGetEnemyMove
	ld a, [wEnemyMoveStruct + MOVE_POWER]
	and a
	jr z, .loop_moves ; skip moves with 0 power

	ld a, 1
	ldh [hBattleTurn], a
	push hl
	push de
	push bc
	callfar EnemyAttackDamage
	callfar BattleCommand_DamageCalc
	callfar BattleCommand_Stab
; double current damage
	ld hl, wCurDamage + 1
	ld a, [hld]
	ld h, [hl]
	ld l, a
	add hl, hl
	ld a, h
	ld [wCurDamage], a
	ld a, l
	ld [wCurDamage + 1], a
; continue
	ld a, [wCurDamage + 1]
	ld c, a ; c is curDamage upper
	ld a, [wCurDamage]
	ld b, a ; b is curDamage lower
	ld a, [wBattleMonMaxHP + 1]
	cp c ; compare upper
	ld a, [wBattleMonMaxHP]
	sbc b ; compare lower and set flag
	pop bc
	pop de
	pop hl
	jr nc, .loop_moves

; skip moves that can't be used on consecutive turns, except hyper beam
	ld a, [wEnemyMonSpecies]
	ld hl, OverdrivePokemon_AI
	call IsInByteArray
	jr c, .set_flag

	ld a, [wPlayerMoveStruct + MOVE_EFFECT]
	cp EFFECT_SELFDESTRUCT
	jr z, .loop_moves
	cp EFFECT_HYPER_BEAM
	jr z, .loop_moves
	cp EFFECT_SOLARBEAM
	jr z, .loop_moves

.set_flag
	scf
	ret

.done
	xor a ; clear carry flag
	ret

; return carry if the AI has a move that can 3HKO the player Pokemon from current HP
CanAI3HKO:
	ld de, wEnemyMonMoves ; load AI moves
	ld b, NUM_MOVES + 1
.loop_AI_3HKO_moves
	dec b ; b is num moves on 1st pass
	jr z, .done ; if b is 0 return we are done
	ld a, [de] ; load the move
	and a
	jr z, .done ; return if no move
	inc de ; increment to next move
	call AIGetEnemyMove
	ld a, [wEnemyMoveStruct + MOVE_POWER]
	and a
	jr z, .loop_AI_3HKO_moves ; skip moves with 0 power

	ld a, 1
	ldh [hBattleTurn], a
	push hl
	push de
	push bc
	callfar EnemyAttackDamage
	callfar BattleCommand_DamageCalc
	callfar BattleCommand_Stab
; triple current damage
	ld hl, wCurDamage + 1
	ld a, [hld]
	ld h, [hl]
	ld l, a
	ld b, h
	ld c, l
	add hl, hl
	add hl, bc
	ld a, h
	ld [wCurDamage], a
	ld a, l
	ld [wCurDamage + 1], a
; continue
	ld a, [wCurDamage + 1]
	ld c, a ; c is curDamage upper
	ld a, [wCurDamage]
	ld b, a ; b is curDamage lower
	ld a, [wBattleMonHP + 1]
	cp c ; compare upper
	ld a, [wBattleMonHP]
	sbc b ; compare lower and set flag
	pop bc
	pop de
	pop hl
	jr nc, .loop_AI_3HKO_moves

; skip moves that can't be used on consecutive turns, except hyper beam
; skip moves that can't be used on consecutive turns, except hyper beam
	ld a, [wEnemyMonSpecies]
	ld hl, OverdrivePokemon_AI
	call IsInByteArray
	jr c, .set_flag

	ld a, [wPlayerMoveStruct + MOVE_EFFECT]
	cp EFFECT_SELFDESTRUCT
	jr z, .loop_AI_3HKO_moves
	cp EFFECT_HYPER_BEAM
	jr z, .loop_AI_3HKO_moves
	cp EFFECT_SOLARBEAM
	jr z, .loop_AI_3HKO_moves

.set_flag
	scf
	ret

.done
	xor a ; clear carry flag
	ret

; return carry if players Attack is higher than Special Attack
IsPlayerPhysicalOrSpecial:
	; compare high bytes
	push bc
	ld a, [wBattleMonAttack]
	ld b, a
	ld a, [wBattleMonSpclAtk]
	cp b
	pop bc
	jr c, .yes ; attack high byte is bigger
	jr nz, .no ; spclAtk high byte is bigger

	; here both high bytes are the same so check low byte
	push bc
	ld a, [wBattleMonAttack + 1]
	ld b, a
	ld a, [wBattleMonSpclAtk + 1]
	cp b
	pop bc
	jr c, .yes ; attack bigger than special attack

.no
	xor a
	ret

.yes
	scf
	ret

IsAttackMaxed:
	ld a, [wEnemyAtkLevel]
	cp BASE_STAT_LEVEL + 6
	jr z, .yes

	ld a, [wEnemyMonAttack + 1]
	sub LOW(MAX_STAT_VALUE)
	jr nz, .no
	ld a, [wEnemyMonAttack]
	sbc HIGH(MAX_STAT_VALUE)
	jr z, .yes

.no
	xor a
	ret

.yes
	scf
	ret

IsDefenseMaxed:
	ld a, [wEnemyDefLevel]
	cp BASE_STAT_LEVEL + 6
	jr z, .yes

	ld a, [wEnemyMonDefense + 1]
	sub LOW(MAX_STAT_VALUE)
	jr nz, .no
	ld a, [wEnemyMonDefense]
	sbc HIGH(MAX_STAT_VALUE)
	jr z, .yes

.no
	xor a
	ret

.yes
	scf
	ret

IsSpecialAttackMaxed:
	ld a, [wEnemySAtkLevel]
	cp BASE_STAT_LEVEL + 6
	jr z, .yes

	ld a, [wEnemyMonSpclAtk + 1]
	sub LOW(MAX_STAT_VALUE)
	jr nz, .no
	ld a, [wEnemyMonSpclAtk]
	sbc HIGH(MAX_STAT_VALUE)
	jr z, .yes

.no
	xor a
	ret

.yes
	scf
	ret

IsSpecialDefenseMaxed:
	ld a, [wEnemySDefLevel]
	cp BASE_STAT_LEVEL + 6
	jr z, .yes

	ld a, [wEnemyMonSpclDef + 1]
	sub LOW(MAX_STAT_VALUE)
	jr nz, .no
	ld a, [wEnemyMonSpclDef]
	sbc HIGH(MAX_STAT_VALUE)
	jr z, .yes

.no
	xor a
	ret

.yes
	scf
	ret

DoesPokemonHaveUberImmunity:
	push hl
	push de
	push bc
	ld hl, UberImmunePokemon_AI
	call IsInByteArray
	pop bc
	pop de
	pop hl
	jr c, .yes
	xor a
	ret

.yes
	scf
	ret

DoesPokemonHaveMagicGuard:
	push hl
	push de
	push bc
	ld hl, MagicGuardPokemon_AI
	call IsInByteArray
	pop bc
	pop de
	pop hl
	jr c, .yes
	xor a
	ret

.yes
	scf
	ret

DoesPokemonHaveClearBody:
	push hl
	push de
	push bc
	ld hl, ClearBodyPokemon_AI
	call IsInByteArray
	pop bc
	pop de
	pop hl
	jr c, .yes
	xor a
	ret

.yes
	scf
	ret

IsAISetup:
; don't switch if enemy mon is already set up
	ld a, [wEnemyAtkLevel]
	cp BASE_STAT_LEVEL + 2
	jr nc, .yes
	ld a, [wEnemySAtkLevel]
	cp BASE_STAT_LEVEL + 2
	jr nc, .yes
	xor a
	ret

.yes
	scf
	ret

AI_90_10:
	call Random
	cp 10 percent
	ret
