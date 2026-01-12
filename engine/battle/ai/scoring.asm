AIScoring: ; used only for BANK(AIScoring)

INCLUDE "engine/battle/ai/layers/ai_basic.asm"
INCLUDE "engine/battle/ai/ability_lists.asm"
INCLUDE "engine/battle/ai/layers/ai_types.asm"
INCLUDE "engine/battle/ai/layers/ai_none.asm"
INCLUDE "engine/battle/ai/layers/ai_smart.asm"

INCLUDE "data/battle/ai/status_only_effects.asm"

AI_Setup:
; Use stat-modifying moves on turn 1.

; 50% chance to greatly encourage stat-up moves during the first turn of enemy's Pokemon.
; 50% chance to greatly encourage stat-down moves during the first turn of player's Pokemon.
; 100% chance to greatly encourage stat-up moves if the player is flying or underground, and the enemy is faster.
; 100% chance to greatly discourage stat-down moves if the player has Mist or a Substitute up.
; Almost 90% chance to greatly discourage stat-modifying moves otherwise.

	ld hl, wEnemyAIMoveScores - 1
	ld de, wEnemyMonMoves
	ld b, NUM_MOVES + 1
.checkmove
	dec b
	ret z

	inc hl
	ld a, [de]
	and a
	ret z

	inc de
	call AIGetEnemyMove

	ld a, [wEnemyMoveStruct + MOVE_EFFECT]

	cp EFFECT_ATTACK_UP
	jr c, .checkmove
	cp EFFECT_EVASION_UP + 1
	jr c, .statup

;	cp EFFECT_ATTACK_DOWN - 1
	jr z, .checkmove
	cp EFFECT_EVASION_DOWN + 1
	jr c, .statdown

	cp EFFECT_ATTACK_UP_2
	jr c, .checkmove
	cp EFFECT_EVASION_UP_2 + 1
	jr c, .statup

;	cp EFFECT_ATTACK_DOWN_2 - 1
	jr z, .checkmove
	cp EFFECT_EVASION_DOWN_2 + 1
	jr c, .statdown

	jr .checkmove

.statup
	ld a, [wPlayerSubStatus3]
	and 1 << SUBSTATUS_FLYING | 1 << SUBSTATUS_UNDERGROUND
	jr z, .statup_continue

	call AICompareSpeed
	jr c, .do_encourage

.statup_continue
	ld a, [wEnemyTurnsTaken]
	and a
	jr nz, .discourage

	jr .encourage

.statdown
	ld a, [wPlayerSubStatus4]
	bit SUBSTATUS_MIST, a
	jr nz, .do_discourage

	ld a, [wPlayerSubStatus4]
	bit SUBSTATUS_SUBSTITUTE, a
	jr nz, .do_discourage

	ld a, [wPlayerTurnsTaken]
	and a
	jr nz, .discourage

.encourage
	call AI_50_50
	jr c, .checkmove

.do_encourage
	dec [hl]
	dec [hl]
	jr .checkmove

.discourage
	call Random
	cp 12 percent
	jr c, .checkmove

.do_discourage
	inc [hl]
	inc [hl]
	jr .checkmove

AI_Offensive:
; Greatly discourage non-damaging moves.

	ld hl, wEnemyAIMoveScores - 1
	ld de, wEnemyMonMoves
	ld b, NUM_MOVES + 1
.checkmove
	dec b
	ret z

	inc hl
	ld a, [de]
	and a
	ret z

	inc de
	call AIGetEnemyMove

	ld a, [wEnemyMoveStruct + MOVE_POWER]
	and a
	jr nz, .checkmove

	inc [hl]
	inc [hl]
	jr .checkmove

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
