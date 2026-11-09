DetermineMoveOrder:
	ld a, [wLinkMode]
	and a
	jr z, .use_move
	ld a, [wBattleAction]
	cp BATTLEACTION_STRUGGLE
	jr z, .use_move
	cp BATTLEACTION_SKIPTURN
	jr z, .use_move
	sub BATTLEACTION_SWITCH1
	jr c, .use_move
	ld a, [wBattlePlayerAction]
	cp BATTLEPLAYERACTION_SWITCH
	jr nz, .switch
	ldh a, [hSerialConnectionStatus]
	cp USING_INTERNAL_CLOCK
	jr z, .player_2

	farcall Core_50_Percent
	jmp c, .player_first
	jmp .enemy_first

.player_2
	farcall Core_50_Percent
	jmp c, .enemy_first
	jmp .player_first

.switch
	callfar AI_Switch
	call SetEnemyTurn
	farcall SpikesDamage
	jmp .enemy_first

.use_move
	ld a, [wBattlePlayerAction]
	and a ; BATTLEPLAYERACTION_USEMOVE?
	jmp nz, .player_first
	farcall CompareMovePriority
	jr z, .equal_priority
	jmp c, .player_first ; player goes first
	jmp .enemy_first

.equal_priority
	call SetPlayerTurn
	farcall _GetUserItem
	push bc
	farcall _GetOpponentItem
	pop de
	ld a, d
	cp HELD_QUICK_CLAW
	jr nz, .player_no_quick_claw
	ld a, b
	cp HELD_QUICK_CLAW
	jr z, .both_have_quick_claw
	call BattleRandom
	cp e
	jr nc, .trick_room_check
	jmp .player_first_due_to_quick_claw

.player_no_quick_claw
	ld a, b
	cp HELD_QUICK_CLAW
	jr nz, .trick_room_check
	call BattleRandom
	cp c
	jr nc, .trick_room_check
	jmp .enemy_first_due_to_quick_claw

.both_have_quick_claw
	ldh a, [hSerialConnectionStatus]
	cp USING_INTERNAL_CLOCK
	jr z, .player_2b
	call BattleRandom
	cp c
	jmp c, .enemy_first_due_to_quick_claw
	call BattleRandom
	cp e
	jmp c, .player_first_due_to_quick_claw
	jr .trick_room_check

.player_2b
	call BattleRandom
	cp e
	jmp c, .player_first_due_to_quick_claw
	call BattleRandom
	cp c
	jmp c, .enemy_first_due_to_quick_claw

	; Trick Room
	; The slower Pokemon attacks first
.trick_room_check
	ld a, [wBattleType]
	cp BATTLETYPE_TRICK_ROOM
	jr z, .trick_room_active
	ld a, [wTrickRoomCount]
	and a
	jr z, .speed_check

.trick_room_active

	; if Trick Room is active (from move or battle type)
	; reverse the turn order
	ld de, wBattleMonSpeed
	ld hl, wEnemyMonSpeed
	ld c, 2
	call CompareBytes
	jmp z, .speed_tie
	jmp nc, .enemy_first
	jmp .player_first

.speed_check
	; check player Pokémon
	ld a, [wBattleMonSpecies]
	ld hl, QuickDrawPokemon
	call IsSpeciesInList
	jr nc, .quick_draw_mon_not_in_list

	; check enemy Pokémon
	ld a, [wEnemyMonSpecies]
	ld hl, QuickDrawPokemon
	call IsSpeciesInList
	jr nc, .quick_draw_mon_not_in_list

	; if we reach here
	; both player and foe are Quick Draw Pokemon
	jmp .continue

.quick_draw_mon_not_in_list
	; check if player is using a Quick Draw Pokemon
	ld a, [wBattleMonSpecies]
	ld hl, QuickDrawPokemon
	call IsSpeciesInList
	jmp c, .SimulatePlayerQuickDrawDoubleSpeed

	; check if foe is using a Quick Draw Pokemon
	ld a, [wEnemyMonSpecies]
	ld hl, QuickDrawPokemon
	call IsSpeciesInList
	jmp c, .SimulateEnemyQuickDrawDoubleSpeed

; Weather speed boosting abilities
; ===========================
; === Ability: Swift Swim ===
; ===========================
    ld a, [wBattleWeather]
    cp WEATHER_RAIN
    jr nz, .check_sun

    ld a, [wEnemyMonSpecies]
	ld hl, SwiftSwimPokemon
	call IsSpeciesInList
	jr c, .check_other_player_rain

    ld a, [wBattleMonSpecies]
	ld hl, SwiftSwimPokemon
	call IsSpeciesInList
	jmp c, .SimulatePlayerDoubleSpeed

.check_sun
; ============================
; === Ability: Chlorophyll ===
; ============================
    ld a, [wBattleWeather]
    cp WEATHER_SUN
    jr nz, .check_sand

    ld a, [wEnemyMonSpecies]
	ld hl, ChlorophyllPokemon
	call IsSpeciesInList
	jr c, .check_other_player_sun

    ld a, [wBattleMonSpecies]
	ld hl, ChlorophyllPokemon
	call IsSpeciesInList
	jmp c, .SimulatePlayerDoubleSpeed

.check_sand
; ==========================
; === Ability: Sand Rush ===
; ==========================
	ld a, [wBattleWeather]
	cp WEATHER_SANDSTORM
	jr nz, .check_hail

	ld a, [wEnemyMonSpecies]
	ld hl, SandRushPokemon
	call IsSpeciesInList
	jr c, .check_other_player_sand

	ld a, [wBattleMonSpecies]
	ld hl, SandRushPokemon
	call IsSpeciesInList
	jmp c, .SimulatePlayerDoubleSpeed

.check_hail
; ===========================
; === Ability: Slush Rush ===
; ===========================
	ld a, [wBattleWeather]
	cp WEATHER_HAIL
	jmp nz, .continue

	ld a, [wEnemyMonSpecies]
	ld hl, SlushRushPokemon
	call IsSpeciesInList
	jr c, .check_other_player_hail

	ld a, [wBattleMonSpecies]
	ld hl, SlushRushPokemon
	call IsSpeciesInList
	jmp c, .SimulatePlayerDoubleSpeed
	jmp .continue

; --------------------------------------------------------
; continuing weather speed boosting abilities 

.check_other_player_rain
    ld a, [wBattleMonSpecies]
	ld hl, SwiftSwimPokemon
	call IsSpeciesInList
	jmp c, .continue
    jr .SimulateEnemyDoubleSpeed

.check_other_player_sun
    ld a, [wBattleMonSpecies]
	ld hl, ChlorophyllPokemon
	call IsSpeciesInList
	jr c, .continue
    jr .SimulateEnemyDoubleSpeed

.check_other_player_sand
	ld a, [wBattleMonSpecies]
	ld hl, SandRushPokemon
	call IsSpeciesInList
	jr c, .continue
	jr .SimulateEnemyDoubleSpeed

.check_other_player_hail
	ld a, [wBattleMonSpecies]
	ld hl, SlushRushPokemon
	call IsSpeciesInList
	jr c, .continue
	jr .SimulateEnemyDoubleSpeed

; --------------------------------------------------------

; enemy moves first unless enemy is paralysed
; or enemy is >+2 speed
; in which case compare speed as normal

.SimulateEnemyQuickDrawDoubleSpeed
	call Random
	cp 33 percent + 1
	jr c, .continue ; 1/3 chance

	ld hl, BattleText_QuickDraw
	call StdBattleTextbox

	ld b, BANK(QuickDrawAbilityText)
	ld c, ABILITY_POPUP_ENEMY
	ld de, QuickDrawAbilityText
	farcall ShowAbilityPopup

.SimulateEnemyDoubleSpeed
	ld a, [wEnemyMonStatus]
	and 1 << PAR
	jr nz, .continue
	ld a, [wPlayerSpdLevel]
	cp BASE_STAT_LEVEL + 2
	jr nc, .continue
	ld a, [wEnemySpdLevel]
	cp BASE_STAT_LEVEL - 1
	jr c, .continue
	jr .enemy_first

; player moves first unless player is paralysed
; or enemy is >+2 speed
; in which case compare speed as normal

.SimulatePlayerQuickDrawDoubleSpeed
	call Random
	cp 33 percent + 1
	jr c, .continue ; 1/3 chance

	ld hl, BattleText_QuickDraw
	call StdBattleTextbox

	ld b, BANK(QuickDrawAbilityText)
	ld c, ABILITY_POPUP_PLAYER
	ld de, QuickDrawAbilityText
	farcall ShowAbilityPopup

.SimulatePlayerDoubleSpeed
	ld a, [wBattleMonStatus]
	and 1 << PAR
	jr nz, .continue
	ld a, [wEnemySpdLevel]
	cp BASE_STAT_LEVEL + 2
	jr nc, .continue
	ld a, [wPlayerSpdLevel]
	cp BASE_STAT_LEVEL - 1
	jr c, .continue
	jr .player_first

.continue
	ld de, wBattleMonSpeed
	ld hl, wEnemyMonSpeed
	ld c, 2
	call CompareBytes
	jr z, .speed_tie
	jr nc, .player_first
	jr .enemy_first

.speed_tie
	ldh a, [hSerialConnectionStatus]
	cp USING_INTERNAL_CLOCK
	jr z, .player_2c
	farcall Core_50_Percent
	jr c, .player_first
	jr .enemy_first

.player_2c
	farcall Core_50_Percent
	jr c, .enemy_first
.player_first
	scf
	ret

.enemy_first
	and a
	ret

.player_first_due_to_quick_claw
	farcall SwitchCoreItemRecoveryAnim
	ld hl, BattleText_QuickClaw
	call StdBattleTextbox
	scf
	ret

.enemy_first_due_to_quick_claw
	call SetEnemyTurn
	farcall SwitchCoreItemRecoveryAnim
	ld hl, BattleText_QuickClaw
	call StdBattleTextbox
	and a
	ret

INCLUDE "data/abilities/quick_draw_mons.asm"

QuickDrawAbilityText: db "Quick Draw@"

INCLUDE "data/abilities/swift_swim_mons.asm"
INCLUDE "data/abilities/chlorophyll_mons.asm"
INCLUDE "data/abilities/sand_rush_mons.asm"
INCLUDE "data/abilities/slush_rush_mons.asm"
