AI_Smart:
; Context-specific scoring.

	ld hl, wEnemyAIMoveScores
	ld de, wEnemyMonMoves
	ld b, NUM_MOVES + 1
.checkmove
	dec b
	ret z

	ld a, [de]
	inc de
	and a
	ret z

	push de
	push bc
	push hl
	call AIGetEnemyMove

	ld a, [wEnemyMoveStruct + MOVE_EFFECT]
	ld hl, AI_Smart_EffectHandlers
	ld de, 3
	call IsInArray

	inc hl
	jr nc, .nextmove

	ld a, [hli]
	ld e, a
	ld d, [hl]

	pop hl
	push hl

	ld bc, .nextmove
	push bc

	push de
	ret

.nextmove
	pop hl
	pop bc
	pop de
	inc hl
	jr .checkmove

AI_Smart_EffectHandlers:
	dbw EFFECT_SLEEP,            AI_Smart_Sleep ; updated
	dbw EFFECT_SELFDESTRUCT,     AI_Smart_Selfdestruct ; updated
	dbw EFFECT_DREAM_EATER,      AI_Smart_DreamEater
	dbw EFFECT_EVASION_UP,       AI_Smart_EvasionUp
	dbw EFFECT_ALWAYS_HIT,       AI_Smart_AlwaysHit
	dbw EFFECT_ACCURACY_DOWN,    AI_Smart_AccuracyDown
	dbw EFFECT_RESET_STATS,      AI_Smart_ResetStats
	dbw EFFECT_FORCE_SWITCH,     AI_Smart_ForceSwitch
	dbw EFFECT_HEAL,             AI_Smart_Heal ; updated
	dbw EFFECT_TOXIC,            AI_Smart_Toxic
	dbw EFFECT_LIGHT_SCREEN,     AI_Smart_LightScreen
	dbw EFFECT_OHKO,             AI_Smart_Ohko
	dbw EFFECT_SUPER_FANG,       AI_Smart_SuperFang
	dbw EFFECT_TRAP_TARGET,      AI_Smart_TrapTarget
	dbw EFFECT_CONFUSE,          AI_Smart_Confuse
	dbw EFFECT_SP_DEF_UP_2,      AI_Smart_SpDefenseUp2
	dbw EFFECT_REFLECT,          AI_Smart_Reflect
	dbw EFFECT_PARALYZE,         AI_Smart_Paralyze
	dbw EFFECT_SPEED_DOWN_HIT,   AI_Smart_SpeedDownHit
	dbw EFFECT_SUBSTITUTE,       AI_Smart_Substitute
	dbw EFFECT_HYPER_BEAM,       AI_Smart_HyperBeam
	dbw EFFECT_MIMIC,            AI_Smart_Mimic
	dbw EFFECT_LEECH_SEED,       AI_Smart_LeechSeed
	dbw EFFECT_DISABLE,          AI_Smart_Disable
	dbw EFFECT_COUNTER,          AI_Smart_Counter
	dbw EFFECT_ENCORE,           AI_Smart_Encore
	dbw EFFECT_PAIN_SPLIT,       AI_Smart_PainSplit
	dbw EFFECT_SNORE,            AI_Smart_Snore
	dbw EFFECT_SLEEP_TALK,       AI_Smart_SleepTalk
	dbw EFFECT_DESTINY_BOND,     AI_Smart_DestinyBond
	dbw EFFECT_REVERSAL,         AI_Smart_Reversal
	dbw EFFECT_SPITE,            AI_Smart_Spite
	dbw EFFECT_HEAL_BELL,        AI_Smart_HealBell
	dbw EFFECT_PRIORITY_HIT,     AI_Smart_PriorityHit
	dbw EFFECT_THIEF,            AI_Smart_Thief
	dbw EFFECT_MEAN_LOOK,        AI_Smart_MeanLook
	dbw EFFECT_CURSE,            AI_Smart_Curse
	dbw EFFECT_PROTECT,          AI_Smart_Protect
	dbw EFFECT_FORESIGHT,        AI_Smart_Foresight
	dbw EFFECT_PERISH_SONG,      AI_Smart_PerishSong
	dbw EFFECT_SANDSTORM,        AI_Smart_Sandstorm
	dbw EFFECT_ENDURE,           AI_Smart_Endure
	dbw EFFECT_ROLLOUT,          AI_Smart_Rollout
	dbw EFFECT_SWAGGER,          AI_Smart_Swagger
	dbw EFFECT_ATTRACT,          AI_Smart_Attract
	dbw EFFECT_SAFEGUARD,        AI_Smart_Safeguard
	dbw EFFECT_BATON_PASS,       AI_Smart_BatonPass
	dbw EFFECT_PURSUIT,          AI_Smart_Pursuit
	dbw EFFECT_RAPID_SPIN,       AI_Smart_RapidSpin
	dbw EFFECT_WEATHER_HEAL,     AI_Smart_Heal ; updated
	dbw EFFECT_HIDDEN_POWER,     AI_Smart_HiddenPower
	dbw EFFECT_RAIN_DANCE,       AI_Smart_RainDance
	dbw EFFECT_SUNNY_DAY,        AI_Smart_SunnyDay
	dbw EFFECT_BELLY_DRUM,       AI_Smart_BellyDrum
	dbw EFFECT_MIRROR_COAT,      AI_Smart_MirrorCoat
	dbw EFFECT_EARTHQUAKE,       AI_Smart_Earthquake
	dbw EFFECT_GUST,             AI_Smart_Gust
	dbw EFFECT_STOMP,            AI_Smart_Stomp
	dbw EFFECT_SOLARBEAM,        AI_Smart_Solarbeam
	dbw EFFECT_THUNDER,          AI_Smart_Thunder
	dbw EFFECT_FLY,              AI_Smart_Fly
	dbw EFFECT_HAIL,             AI_Smart_Hail
	dbw EFFECT_FACADE,           AI_Smart_Facade
	dbw EFFECT_HEX,              AI_Smart_Hex
	dbw EFFECT_HURRICANE,        AI_Smart_Hurricane
	dbw EFFECT_FAKE_OUT,         AI_Smart_Fake_Out
	dbw EFFECT_FREEZE_DRY,       AI_Smart_FreezeDry
	dbw EFFECT_BODY_PRESS,       AI_Smart_BodyPress
	dbw EFFECT_AVALANCHE,        AI_Smart_Avalanche
	dbw EFFECT_BRICK_BREAK,      AI_Smart_BrickBreak
	dbw EFFECT_PARALYZE_HIT,     AI_Smart_ParalyzeTarget ; updated
	dbw EFFECT_ACROBATICS,       AI_Smart_Acrobatics
	dbw EFFECT_TRICK,            AI_Smart_Trick
	dbw EFFECT_VENOSHOCK,        AI_Smart_Venoshock
	dbw EFFECT_DRAGON_DANCE,     AI_Smart_DragonDance ; updated
	dbw EFFECT_CALM_MIND,        AI_Smart_CalmMind ; updated
	dbw EFFECT_QUIVER_DANCE,     AI_Smart_QuiverDance ; updated
	dbw EFFECT_ATTACK_UP_2,      AI_Smart_SwordsDance ; updated
	dbw EFFECT_SP_ATK_UP_2,      AI_Smart_NastyPlot ; updated
	dbw EFFECT_BULK_UP,          AI_Smart_BulkUp ; updated
	db -1 ; end

AI_Smart_BulkUp:
; discourage if player can ko at current HP
	call CanPlayerKO
	jmp c, StandardDiscourage

	call IsAttackMaxed
	jr nc, .continue
	call IsDefenseMaxed
	jmp c, StandardDiscourage

.continue
; if player is asleep and is physical we should boost
	ld a, [wBattleMonStatus]
	and SLP_MASK
	jr z, .not_asleep
	call IsPlayerPhysicalOrSpecial
	jmp c, StandardEncourage

.not_asleep
; don't use if we are at risk of being KO'd, just attack them
	call ShouldAIBoost
	jmp nc, StandardDiscourage

; encourage to +2 - strong encourage if player is physical
	ld a, [wEnemyAtkLevel]
	cp BASE_STAT_LEVEL + 2
	jr nc, .at_plus_2
	call IsPlayerPhysicalOrSpecial
	jr nc, .special
	jmp StrongEncourage

.special
	jmp StandardEncourage

.at_plus_2
; discourage after boost if afflicted with toxic
	call IsAIToxified
	jmp c, StandardDiscourage

; encourage if we have no reason not to
	jmp StandardEncourage

AI_Smart_NastyPlot:
; discourage if player can ko at current HP
	call CanPlayerKO
	jmp c, StandardDiscourage

	call IsSpecialAttackMaxed
	jmp c, StandardDiscourage

; Deoxys should not use Nasty Plot against dark types
;	ld a, [wEnemyMonSpecies]
;	cp DEOXYS
;	jr nz, .notDeoxys
;	ld a, [wBattleMonType1]
;	cp DARK
;	jmp z, StandardDiscourage
;	ld a, [wBattleMonType2]
;	cp DARK
;	jmp z, StandardDiscourage

;.notDeoxys
; if we are boosted >=+2 and can 2hko, just attack
	ld a, [wEnemySAtkLevel]
	cp BASE_STAT_LEVEL + 2
	jr c, .not_boosted
	call CanAI2HKO
	jmp c, StandardDiscourage

.not_boosted
; don't use if we are at risk of being KO'd, just attack them
	call ShouldAIBoost
	jmp nc, StandardDiscourage

; encourage to +2
	ld a, [wEnemySAtkLevel]
	cp BASE_STAT_LEVEL + 2
	jmp c, StandardEncourage

; discourage after boost if afflicted with toxic
	call IsAIToxified
	jmp c, StandardDiscourage

; encourage if we have no reason not to
	jmp StandardEncourage

AI_Smart_SwordsDance:
; discourage if player can ko at current HP
	call CanPlayerKO
	jmp c, StandardDiscourage

	call IsAttackMaxed
	jmp c, StandardDiscourage

; don't use if we are at risk of being KO'd, just attack them
	call ShouldAIBoost
	jmp nc, StandardDiscourage

; encourage to +2
	ld a, [wEnemyAtkLevel]
	cp BASE_STAT_LEVEL + 2
	jmp c, StandardEncourage

; discourage after boost if afflicted with toxic
	call IsAIToxified
	jmp c, StandardDiscourage

; encourage if we have no reason not to
	jmp StandardEncourage

AI_Smart_QuiverDance:
; discourage if player can ko at current HP
	call CanPlayerKO
	jmp c, StandardDiscourage

	call IsSpecialAttackMaxed
	jr nc, .should_boost
	call IsSpecialDefenseMaxed
	jmp c, StandardDiscourage

.should_boost
	call ShouldAIBoost
	jmp nc, StandardDiscourage

; discourage if enemy is paralyzed
	ld a, [wEnemyMonStatus]
	and 1 << PAR
	jmp nz, StandardDiscourage

; discourage if player speed is +2 or higher
	ld a, [wPlayerSpdLevel]
	cp BASE_STAT_LEVEL + 2
	jmp nc, StandardDiscourage

; never use while in trick room
	ld a, [wTrickRoomCount]
	and a
	jmp nz, StandardDiscourage

; encourage to +2
	ld a, [wEnemySAtkLevel]
	cp BASE_STAT_LEVEL + 2
	jmp c, StandardEncourage

; discourage after boost if afflicted with toxic
	call IsAIToxified
	jmp c, StandardDiscourage
	ret

AI_Smart_CalmMind:
; discourage if player can ko at current HP
	call CanPlayerKO
	jmp c, StandardDiscourage

	call IsSpecialAttackMaxed
	jr nc, .continue
	call IsSpecialDefenseMaxed
	jmp c, StandardDiscourage

.continue
; if player is asleep and is special, we should boost
	ld a, [wBattleMonStatus]
	and SLP_MASK
	jr z, .not_asleep
	call IsPlayerPhysicalOrSpecial
	jmp nc, StandardEncourage

.not_asleep
; don't use if we are at risk of being KOd, just attack them
	call ShouldAIBoost
	jmp nc, StandardDiscourage

; encourage to +2
	ld a, [wEnemySAtkLevel]
	cp BASE_STAT_LEVEL + 2
	jmp c, StandardEncourage

; discourage after boost if afflicted with toxic
	call IsAIToxified
	jmp c, StandardDiscourage

; encourage if we have no reason not to
	jmp StandardEncourage

AI_Smart_DragonDance:
; discourage if player can ko at current HP
	call CanPlayerKO
	jmp c, StandardDiscourage

	call IsAttackMaxed
	jmp c, StandardDiscourage

; should boost
	call ShouldAIBoost
	jmp nc, StandardDiscourage

; discourage if enemy is paralyzed
	ld a, [wEnemyMonStatus]
	and 1 << PAR
	jmp nz, StandardDiscourage

; discourage if player speed is +2 or higher
	ld a, [wPlayerSpdLevel]
	cp BASE_STAT_LEVEL + 2
	jmp nc, StandardDiscourage

; never use while in trick room
	ld a, [wTrickRoomCount]
	and a
	jmp nz, StandardDiscourage

; discourage if players level is >10 higher than AI
	ld a, [wBattleMonLevel]
	ld b, a
	ld a, [wEnemyMonLevel]
	add 10
	cp b
	jmp c, StandardDiscourage

; some pokemon have double boost sets with dragondance and bulkup/swordsdance
; in such cases we want to use dragondance first to get to +1 speed,
; then only use the other boost
	ld b, EFFECT_BULK_UP
	call AIHasMoveEffect
	jr c, .use_first_and_not_again
	ld b, EFFECT_ATTACK_UP_2
	call AIHasMoveEffect
	jr c, .use_first_and_not_again
	jr .normalEncourage

.use_first_and_not_again
	ld a, [wEnemySpdLevel]
	cp BASE_STAT_LEVEL + 1
	jmp c, StrongEncourage
	jmp StandardDiscourage

.normalEncourage
; discourage after boost if afflicted with toxic
	call IsAIToxified
	jmp c, StandardDiscourage

; encourage if we have no reason not to
	jmp StandardEncourage

AI_Smart_Venoshock:
; Greatly encourage this move if the player is poisoned.
	ld a, [wBattleMonStatus]
	bit PSN, a
	ret z
	dec [hl]
	dec [hl]
	ret

AI_Smart_Acrobatics:
; Greatly encourage this move if the user does not have an item.
	ld a, [wEnemyMonItem]
	and a
	ret nz  ; Return if the enemy has a status condition
	dec [hl]
	dec [hl]
	ret

AI_Smart_ParalyzeTarget:
	; check specie
	ld a, [wEnemyMonSpecies]
	push hl
	ld hl, SureShockPokemon_AI
	call IsInByteArray
	pop hl
	ret nz

	; check move
	ld a, [wEnemyMoveStruct + MOVE_ANIM]
	cp THUNDERBOLT
	jr nc, .go
	ret nz

.go
	; if slower
	call AICompareSpeed
	ret c

	; then use Thunderbolt first
	; since it always paralyzes
	call AI_90_10
	ret c
	dec [hl]
	dec [hl]
	ret

AI_Smart_BrickBreak:
    ; 90% chance to greatly encourage this move if the player used LIGHT_SCREEN or REFLECT.

    ; Load the player's field conditions
	ld a, [wPlayerMoveStruct + MOVE_ANIM]
	cp LIGHT_SCREEN
	call z, EncourageBrickBreak
	cp REFLECT
	call z, EncourageBrickBreak
	ret ; If neither LIGHT_SCREEN nor REFLECT is active, skip the encouragement

EncourageBrickBreak:
	; 90% chance to encourage this move
	call Random
	cp 12 percent ; 90% chance (256 * 0.9 = 230, so cp 256 - 230 = 26)
	ret c
	dec [hl]
	dec [hl]
	ret

AI_Smart_BodyPress:
; Encourage this move if enemy's defense level is at least +1.
	ld a, [wEnemyDefLevel]
	cp BASE_STAT_LEVEL + 1
	ret c
	dec [hl]
	ret

AI_Smart_Avalanche:
; Discourage this move if the enemy has less than 25% HP left.
	call AICheckEnemyQuarterHP
	jr nc, .discourage

; 80% chance to encourage this move if the player used
; a damaging move last.
	ld a, [wLastPlayerCounterMove]
	and a
	jr z, .done

	call AIGetEnemyMove

	ld a, [wEnemyMoveStruct + MOVE_POWER]
	and a
	jr z, .done

	call AI_80_20
	jr c, .done
	dec [hl]
	dec [hl]
	ret

.discourage
	inc [hl]
.done
	ret

AI_Smart_FreezeDry:
	ld a, [wBattleMonType1]
	cp WATER
	jr z, .encourage
	ld a, [wBattleMonType2]
	cp WATER
	ret nz

.encourage
	call AI_80_20
	ret c
	dec [hl]
	ret

AI_Smart_Facade:
; Greatly encourage this move if the enemy has a status condition.

	ld a, [wEnemyMonStatus]
	and a
	ret z

	dec [hl]
	dec [hl]
	dec [hl]
	ret

AI_Smart_Hex:
; Greatly encourage this move if the player has a status condition.

	ld a, [wBattleMonStatus]
	and a
	ret z
	dec [hl]
	dec [hl]
	dec [hl]
	ret

AI_Smart_Sleep:
; don't use if there already is a status
; never use if player has substitute
; never use if player has safeguard
; don't use against serenity pokemon as they are immune to status
; greatly encourage sleep inducing moves if the enemy has either dream eater
; pokemon with bad dreams ability should prioritise sleep more
; 50% chance to greatly encourage sleep inducing moves otherwise

; don't use if there already is a status
	ld a, [wBattleMonStatus]
	and a
	jr nz, .discourage

; never use if player has substitute
	ld a, [wPlayerSubStatus4]
	bit SUBSTATUS_SUBSTITUTE, a
	jr nz, .discourage

; never use if player has safeguard
	ld a, [wPlayerScreens]
	bit SCREENS_SAFEGUARD, a
	jr nz, .discourage

; don't use against serenity pokemon as they are immune to status
	ld a, [wBattleMonSpecies]
	push hl
	ld hl, SerenityPokemon_AI
	call IsInByteArray
	pop hl
	jr c, .discourage

; greatly encourage sleep inducing moves
; if the enemy has either dream eater
	ld b, EFFECT_DREAM_EATER
	call AIHasMoveEffect
	jr c, .encourage50

; pokemon with bad dreams ability should prioritise sleep more
	ld a, [wEnemyMonSpecies]
	push hl
	ld hl, BadDreamsPokemon_AI
	call IsInByteArray
	pop hl
	jr c, .encourage50

.discourage
    inc [hl]
    inc [hl]
    ret

.encourage50
	call AI_50_50
	ret c

rept 12
    dec [hl]
endr
    ret

AI_Smart_Selfdestruct:
; explosion

; never use against ghost types
	ld a, [wBattleMonType1]
	cp GHOST
	jr z, .discourage
	ld a, [wBattleMonType2]
	cp GHOST
	jr z, .discourage

; unless this is the enemy's last Pokemon...
	push hl
	farcall FindAliveEnemyMons
	pop hl
	jr nc, .notlastmon

; ...greatly discourage this move unless this is the player's last pokemon too.
	push hl
	call AICheckLastPlayerMon
	pop hl
	jr nz, .discourage

.notlastmon
; don't use if player is behind a sub
	ld a, [wPlayerSubStatus4]
	bit SUBSTATUS_SUBSTITUTE, a	;check for substitute bit
	jr nz, .discourage

; don't use if player has protect
	ld b, EFFECT_PROTECT
	call PlayerHasMoveEffect
	jr c, .discourage

; don't use if player is faster and has - substitute, fly, dig
	call DoesAIOutSpeedPlayer
	jr c, .faster
	ld b, EFFECT_SUBSTITUTE
	call PlayerHasMoveEffect
	jr c, .discourage
	ld b, EFFECT_FLY
	call PlayerHasMoveEffect
	jr c, .discourage

.faster
; if enemy's HP is below 25% just boom
	call AICheckEnemyQuarterHP
	jr nc, .encourage

; use if we are about to be KOd
	call ShouldAIBoost
	jr nc, .encourage

.continue
; greatly discourage this move if enemy's HP is above 50%.
	call AICheckEnemyHalfHP
	jr c, .discourage

; if we are here we are below 1/2 hp and player is non boosted
; if we have no other move that can ko the player just boom

.encourage
	dec [hl]
	ret

.discourage
	inc [hl]
	inc [hl]
	inc [hl]
	inc [hl]
	ret

AI_Smart_Fake_Out:
; 90% chance to greatly encourage this move.
; The AI_Basic layer will make sure that
; Fake Out is only used
; on the enemy's first turn out.
AI_Smart_DreamEater:
; 90% chance to greatly encourage this move.
; The AI_Basic layer will make sure that
; Dream Eater is only used against sleeping targets.
	call AI_90_10
	ret c
	dec [hl]
	dec [hl]
	dec [hl]
	ret

AI_Smart_EvasionUp:
; Dismiss this move if enemy's evasion can't raise anymore.
	ld a, [wEnemyEvaLevel]
	cp MAX_STAT_LEVEL
	jmp nc, AIDiscourageMove

; If enemy's HP is full...
	call AICheckEnemyMaxHP
	jr nc, .hp_mismatch_1

; ...greatly encourage this move if player is badly poisoned.
	ld a, [wPlayerSubStatus5]
	bit SUBSTATUS_TOXIC, a
	jr nz, .greatly_encourage

; ...70% chance to greatly encourage this move if player is not badly poisoned.
	call Random
	cp 70 percent
	jr nc, .not_encouraged

.greatly_encourage
	dec [hl]
	dec [hl]
	ret

.hp_mismatch_1

; Greatly discourage this move if enemy's HP is below 25%.
	call AICheckEnemyQuarterHP
	jr nc, .hp_mismatch_2

; If enemy's HP is above 25% but not full, 4% chance to greatly encourage this move.
	call Random
	cp 4 percent
	jr c, .greatly_encourage

; If enemy's HP is between 25% and 50%,...
	call AICheckEnemyHalfHP
	jr nc, .hp_mismatch_3

; If enemy's HP is above 50% but not full, 20% chance to greatly encourage this move.
	call AI_80_20
	jr c, .greatly_encourage
	jr .not_encouraged

.hp_mismatch_3
; ...50% chance to greatly discourage this move.
	call AI_50_50
	jr c, .not_encouraged

.hp_mismatch_2
	inc [hl]
	inc [hl]

; 30% chance to end up here if enemy's HP is full and player is not badly poisoned.
; 77% chance to end up here if enemy's HP is above 50% but not full.
; 96% chance to end up here if enemy's HP is between 25% and 50%.
; 100% chance to end up here if enemy's HP is below 25%.
; In other words, we only end up here if the move has not been encouraged or dismissed.
.not_encouraged
	ld a, [wPlayerSubStatus5]
	bit SUBSTATUS_TOXIC, a
	jr nz, .maybe_greatly_encourage

	ld a, [wPlayerSubStatus4]
	bit SUBSTATUS_LEECH_SEED, a
	jr nz, .maybe_encourage

; Discourage this move if enemy's evasion level is higher than player's accuracy level.
	ld a, [wEnemyEvaLevel]
	ld b, a
	ld a, [wPlayerAccLevel]
	cp b
	jr c, .discourage

; Greatly encourage this move if the player is in the middle of Rollout.

	ld a, [wPlayerSubStatus1]
	bit SUBSTATUS_ROLLOUT, a
	jr nz, .greatly_encourage

.discourage
	inc [hl]
	ret

; Player is badly poisoned.
; 70% chance to greatly encourage this move.
; This would counter any previous discouragement.
.maybe_greatly_encourage
	call Random
	cp 31 percent + 1
	ret c

	dec [hl]
	dec [hl]
	ret

; Player is seeded.
; 50% chance to encourage this move.
; This would partly counter any previous discouragement.
.maybe_encourage
	call AI_50_50
	ret c

	dec [hl]
	ret

AI_Smart_AlwaysHit:
; 80% chance to greatly encourage this move if either...

; ...enemy's accuracy level has been lowered three or more stages
	ld a, [wEnemyAccLevel]
	cp BASE_STAT_LEVEL - 2
	jr c, .encourage

; ...or player's evasion level has been raised three or more stages.
	ld a, [wPlayerEvaLevel]
	cp BASE_STAT_LEVEL + 3
	ret c

.encourage
	call AI_80_20
	ret c

	dec [hl]
	dec [hl]
	ret

AI_Smart_AccuracyDown:
; If player's HP is full...
	call AICheckPlayerMaxHP
	jr nc, .hp_mismatch_1

; ...and enemy's HP is above 50%...
	call AICheckEnemyHalfHP
	jr nc, .hp_mismatch_1

; ...greatly encourage this move if player is badly poisoned.
	ld a, [wPlayerSubStatus5]
	bit SUBSTATUS_TOXIC, a
	jr nz, .greatly_encourage

; ...70% chance to greatly encourage this move if player is not badly poisoned.
	call Random
	cp 70 percent
	jr nc, .not_encouraged

.greatly_encourage
	dec [hl]
	dec [hl]
	ret

.hp_mismatch_1

; Greatly discourage this move if player's HP is below 25%.
	call AICheckPlayerQuarterHP
	jr nc, .hp_mismatch_2

; If player's HP is above 25% but not full, 4% chance to greatly encourage this move.
	call Random
	cp 4 percent
	jr c, .greatly_encourage

; If player's HP is between 25% and 50%,...
	call AICheckPlayerHalfHP
	jr nc, .hp_mismatch_3

; If player's HP is above 50% but not full, 20% chance to greatly encourage this move.
	call AI_80_20
	jr c, .greatly_encourage
	jr .not_encouraged

; ...50% chance to greatly discourage this move.
.hp_mismatch_3
	call AI_50_50
	jr c, .not_encouraged

.hp_mismatch_2
	inc [hl]
	inc [hl]

; We only end up here if the move has not been already encouraged.
.not_encouraged
	ld a, [wPlayerSubStatus5]
	bit SUBSTATUS_TOXIC, a
	jr nz, .maybe_greatly_encourage

	ld a, [wPlayerSubStatus4]
	bit SUBSTATUS_LEECH_SEED, a
	jr nz, .encourage

; Discourage this move if enemy's evasion level is higher than player's accuracy level.
	ld a, [wEnemyEvaLevel]
	ld b, a
	ld a, [wPlayerAccLevel]
	cp b
	jr c, .discourage

; Greatly encourage this move if the player is in the middle of Rollout.

	ld a, [wPlayerSubStatus1]
	bit SUBSTATUS_ROLLOUT, a
	jr nz, .greatly_encourage

.discourage
	inc [hl]
	ret

; Player is badly poisoned.
; 70% chance to greatly encourage this move.
; This would counter any previous discouragement.
.maybe_greatly_encourage
	call Random
	cp 31 percent + 1
	ret c

	dec [hl]
	dec [hl]
	ret

; Player is seeded.
; 50% chance to encourage this move.
; This would partly counter any previous discouragement.
.encourage
	call AI_50_50
	ret c

	dec [hl]
	ret

AI_Smart_ResetStats:
; 85% chance to encourage this move if any of enemy's stat levels is lower than -2.
	push hl
	ld hl, wEnemyAtkLevel
	ld c, NUM_LEVEL_STATS
.enemystatsloop
	dec c
	jr z, .enemystatsdone
	ld a, [hli]
	cp BASE_STAT_LEVEL - 2
	jr c, .encourage
	jr .enemystatsloop

; 85% chance to encourage this move if any of player's stat levels is higher than +2.
.enemystatsdone
	ld hl, wPlayerAtkLevel
	ld c, NUM_LEVEL_STATS
.playerstatsloop
	dec c
	jr z, .discourage
	ld a, [hli]
	cp BASE_STAT_LEVEL + 3
	jr c, .playerstatsloop

.encourage
	pop hl
	call Random
	cp 16 percent
	ret c
	dec [hl]
	ret

; Discourage this move if neither:
; Any of enemy's stat levels is lower than -2.
; Any of player's stat levels is higher than +2.
.discourage
	pop hl
	inc [hl]
	ret

AI_Smart_ForceSwitch:
; Whirlwind, Roar.

; Strongly encourage this move if the player has
; a stat buff of at least 2 in any stat
	push hl
	ld hl, wPlayerAtkLevel
	ld c, $8
.check_next_stat
	dec c
	jr z, .no_stat_buff
	ld a, [hli]
	cp $9
	jr c, .check_next_stat
	pop hl
; player has a stat buffed by at least 2
	dec [hl]
	cp $a
	ret c
; encourage more if buffed by >2
	dec [hl]
	ret

; Discourage this move if the player has not shown
; a super-effective move against the enemy.
; Consider player's type(s) if its moves are unknown.

.no_stat_buff
	pop hl
	push hl
	callfar CheckPlayerMoveTypeMatchups
	ld a, [wEnemyAISwitchScore]
	cp 10 ; neutral // forely BASE_AI_SWITCH_SCORE
	pop hl
	jr nc, .discourage

; Otherwise, encourage this move if the player's HP is above 50%
; and there's an entry hazard on the player's side.
	call AICheckPlayerHalfHP
	ret nc

	ld a, [wPlayerScreens]
	bit SCREENS_SPIKES, a
	jr nz, .encourage
	bit SCREENS_TOXIC_SPIKES, a
	jr nz, .encourage
	bit SCREENS_STEALTH_ROCK, a
	jr nz, .encourage
	bit SCREENS_STICKY_WEB, a
	ret z

.encourage
	dec [hl]
	ret

.discourage
	inc [hl]
	ret

AI_Smart_Heal:
; don't use if choice locked
	call DoesEnemyHaveChoiceItem
	jmp c, .discourage

; if we have boosted evasion just heal below half
	ld a, [wEnemyEvaLevel]
	cp BASE_STAT_LEVEL + 2
	jr nc, .heal_below_half_max_HP

; if the player is using smeargle just attack, kill it!
	ld a, [wBattleMonSpecies]
	cp SMEARGLE
	jmp z, .discourage

; check if the move is rest, it must be handled differently
	ld a, [wEnemyMoveStruct + MOVE_ANIM]
	cp REST
	jr nz, .not_rest_heal

; if it is rest, check if the enemy is afflicted with toxic
; if so, cancel any switching and heal below 1/2 hp
	ld a, [wEnemySubStatus5]
	bit SUBSTATUS_TOXIC, a
	jr z, .rest_heal
	ld a, $0
	ld [wEnemyIsSwitching], a
	jr .not_rest_heal

.rest_heal
; for rest don't heal if player can 3hko from max hp,
; unless ai also knows sleep talk
; then don't use if player can 2hko from max hp
	ld b, EFFECT_SLEEP_TALK
	call AIHasMoveEffect
	jr c, .not_rest_heal
	call CanPlayer3HKOMaxHP
	jr c, .discourage

.not_rest_heal
; don't heal if afflicted with toxic
	call IsAIToxified
	jr c, .discourage

; don't heal if player can 2 shot from max hp, no point
	call CanPlayer2HKOMaxHP
	jr c, .discourage

; if we are faster and player is flying or underground,
; encourage heal if we can be 1hko
	call DoesAIOutSpeedPlayer
	jr nc, .check_quarter_max_hp
	call CanPlayerKO
	jr nc, .check_quarter_max_hp
	ld a, [wPlayerSubStatus3]
	and 1 << SUBSTATUS_FLYING | 1 << SUBSTATUS_UNDERGROUND
	jr nz, .big_encourage

.check_quarter_max_hp
; always heal when below 1/4 hp
	call AICheckEnemyQuarterHP
	jr nc, .encourage

; if faster than the player, heal if the player can 1hko
	call DoesAIOutSpeedPlayer
	jr nc, .player_moves_first
	call CanPlayerKO
	jr c, .encourage
	jr .check_mewtwo

; if slower than the player, heal if player can 2hko
.player_moves_first
    call CanPlayer2HKO
    jr c, .encourage

.check_mewtwo
; lugia, ho-oh & mewtwo always heal when below half
; also heal below half if we have increased evasion
	ld a, [wEnemyMonSpecies]
	cp LUGIA
	jr z, .heal_below_half_max_HP
	cp HO_OH
	jr z, .heal_below_half_max_HP
	cp MEWTWO
	jr z, .heal_below_half_max_HP
	jr .discourage

.heal_below_half_max_HP
	call AICheckEnemyHalfHP
	jr c, .discourage
	; fallthrough

.encourage
; lugia, ho-oh & mewtwo should play defensively and 
; prioritize healing above scoring KOs
	ld a, [wEnemyMonSpecies]
	cp LUGIA
	jr nz, .normal_encourage
	cp HO_OH
	jr nz, .normal_encourage
	cp MEWTWO
	jr nz, .normal_encourage

.big_encourage
rept 8
	dec [hl]
endr
.normal_encourage
	dec [hl]
	dec [hl]
	dec [hl]
	dec [hl]
	ret

.discourage
	inc [hl]
	inc [hl]
	inc [hl]
	inc [hl]
	ret

AI_Smart_Toxic:
AI_Smart_LeechSeed:
; Discourage this move if player's HP is below 50%.

	call AICheckPlayerHalfHP
	ret c
	inc [hl]
	ret

AI_Smart_LightScreen:
AI_Smart_Reflect:
; Over 90% chance to discourage this move unless enemy's HP is full.

	call AICheckEnemyMaxHP
	ret c
	call Random
	cp 8 percent
	ret c
	inc [hl]
	ret

AI_Smart_Ohko:
; Dismiss this move if player's level is higher than enemy's level.
; Else, discourage this move is player's HP is below 50%.

	ld a, [wBattleMonLevel]
	ld b, a
	ld a, [wEnemyMonLevel]
	cp b
	jmp c, AIDiscourageMove
	call AICheckPlayerHalfHP
	ret c
	inc [hl]
	ret

AI_Smart_TrapTarget:
; Wrap, Fire Spin

; 50% chance to discourage this move if the player is already trapped.
	ld a, [wPlayerWrapCount]
	and a
	jr nz, .discourage

; 50% chance to greatly encourage this move if player is either
; badly poisoned, in love, identified, stuck in Rollout, or has a Nightmare.
	ld a, [wPlayerSubStatus5]
	bit SUBSTATUS_TOXIC, a
	jr nz, .encourage

	ld a, [wPlayerSubStatus1]
	and 1 << SUBSTATUS_IN_LOVE | 1 << SUBSTATUS_ROLLOUT | 1 << SUBSTATUS_IDENTIFIED | 1 << SUBSTATUS_NIGHTMARE
	jr nz, .encourage

; Else, 50% chance to greatly encourage this move if it's the player's Pokemon first turn.
	ld a, [wPlayerTurnsTaken]
	and a
	jr z, .encourage

; 50% chance to discourage this move otherwise.
.discourage
	call AI_50_50
	ret c
	inc [hl]
	ret

.encourage
	call AICheckEnemyQuarterHP
	ret nc
	call AI_50_50
	ret c
	dec [hl]
	dec [hl]
	ret

AI_Smart_Confuse:
; 90% chance to discourage this move if player's HP is between 25% and 50%.
	call AICheckPlayerHalfHP
	ret c
	call AI_90_10
	jr c, .skipdiscourage
	inc [hl]

.skipdiscourage
; Discourage again if player's HP is below 25%.
	call AICheckPlayerQuarterHP
	ret c
	inc [hl]
	ret

AI_Smart_SpDefenseUp2:
; Discourage this move if enemy's HP is lower than 50%.
	call AICheckEnemyHalfHP
	jr nc, .discourage

; Discourage this move if enemy's special defense level is higher than +3.
	ld a, [wEnemySDefLevel]
	cp BASE_STAT_LEVEL + 4
	jr nc, .discourage

; 80% chance to greatly encourage this move if
; enemy's Special Defense level is lower than +2,
; and the player's Pokémon is Special-oriented.
	cp BASE_STAT_LEVEL + 2
	ret nc

	push hl
; Get the pointer for the player's Pokémon's base Attack
	ld a, [wBattleMonSpecies]
	ld hl, BaseData + BASE_ATK
	ld bc, BASE_DATA_SIZE
	call AddNTimes
; Get the Pokémon's base Attack
	ld a, BANK(BaseData)
	call GetFarByte
	ld d, a
; Get the pointer for the player's Pokémon's base Special Attack
	ld bc, BASE_SAT - BASE_ATK
	add hl, bc
; Get the Pokémon's base Special Attack
	ld a, BANK(BaseData)
	call GetFarByte
	pop hl
; If its base Attack is greater than its base Special Attack,
; don't encourage this move.
	cp d
	ret c

.encourage
	call AI_80_20
	ret c
	dec [hl]
	dec [hl]
	ret

.discourage
	inc [hl]
	ret

AI_Smart_Fly:
; Fly, Dig

; Greatly encourage this move if the player is
; flying or underground, and slower than the enemy.

	ld a, [wPlayerSubStatus3]
	and 1 << SUBSTATUS_FLYING | 1 << SUBSTATUS_UNDERGROUND
	ret z

	call AICompareSpeed
	ret nc

	dec [hl]
	dec [hl]
	dec [hl]
	ret

AI_Smart_SuperFang:
; Discourage this move if player's HP is below 25%.

	call AICheckPlayerQuarterHP
	ret c
	inc [hl]
	ret

AI_Smart_Paralyze:
; 50% chance to discourage this move if player's HP is below 25%.
	call AICheckPlayerQuarterHP
	jr nc, .discourage

; 80% chance to greatly encourage this move
; if enemy is slower than player and its HP is above 25%.
	call AICompareSpeed
	ret c
	call AICheckEnemyQuarterHP
	ret nc
	call AI_80_20
	ret c
	dec [hl]
	dec [hl]
	ret

.discourage
	call AI_50_50
	ret c
	inc [hl]
	ret

AI_Smart_SpeedDownHit:
; Icy Wind

; Almost 90% chance to greatly encourage this move if the following conditions all meet:
; Enemy's HP is higher than 25%.
; It's the first turn of player's Pokemon.
; Player is faster than enemy.

	ld a, [wEnemyMoveStruct + MOVE_ANIM]
	cp ICY_WIND
	ret nz
	call AICheckEnemyQuarterHP
	ret nc
	ld a, [wPlayerTurnsTaken]
	and a
	ret nz
	call AICompareSpeed
	ret c
	call Random
	cp 12 percent
	ret c
	dec [hl]
	dec [hl]
	ret

AI_Smart_Substitute:
; Dismiss this move if enemy's HP is below 50%.

	call AICheckEnemyHalfHP
	ret c
	jmp AIDiscourageMove

AI_Smart_HyperBeam:
	call AICheckEnemyHalfHP
	jr c, .discourage

; 50% chance to encourage this move if enemy's HP is below 25%.
	call AICheckEnemyQuarterHP
	ret c
	call AI_50_50
	ret c
	dec [hl]
	ret

.discourage
; If enemy's HP is above 50%, discourage this move at random
	call Random
	cp 16 percent
	ret c
	inc [hl]
	call AI_50_50
	ret c
	inc [hl]
	ret

AI_Smart_Mimic:
; Discourage this move if the player did not use any move last turn.
	ld a, [wLastPlayerCounterMove]
	and a
	jr z, .dismiss

	call AICheckEnemyHalfHP
	jr nc, .discourage

	push hl
	ld a, [wLastPlayerCounterMove]
	call AIGetEnemyMove

	ld a, 1
	ldh [hBattleTurn], a
	callfar BattleCheckTypeMatchup

	ld a, [wTypeMatchup]
	cp EFFECTIVE
	pop hl
	jr c, .discourage
	jr z, .skip_encourage

	call AI_50_50
	jr c, .skip_encourage

	dec [hl]

.skip_encourage
	ld a, [wLastPlayerCounterMove]
	push hl
	ld hl, UsefulMoves
	call IsInByteArray

	pop hl
	ret nc
	call AI_50_50
	ret c
	dec [hl]
	ret

.dismiss
; Dismiss this move if the enemy is faster than the player.
	call AICompareSpeed
	jmp c, AIDiscourageMove

.discourage
	inc [hl]
	ret

AI_Smart_Counter:
	push hl
	ld hl, wPlayerUsedMoves
	ld c, NUM_MOVES
	ld b, 0

.playermoveloop
	ld a, [hli]
	and a
	jr z, .skipmove

	call AIGetEnemyMove

	ld a, [wEnemyMoveStruct + MOVE_POWER]
	and a
	jr z, .skipmove

	ld a, [wEnemyMoveStruct + MOVE_TYPE]
	cp SPECIAL
	jr nc, .skipmove

	inc b

.skipmove
	dec c
	jr nz, .playermoveloop

	pop hl
	ld a, b
	and a
	jr z, .discourage

	cp 3
	jr nc, .encourage

	ld a, [wLastPlayerCounterMove]
	and a
	jr z, .done

	call AIGetEnemyMove

	ld a, [wEnemyMoveStruct + MOVE_POWER]
	and a
	jr z, .done

	ld a, [wEnemyMoveStruct + MOVE_TYPE]
	cp SPECIAL
	jr nc, .done

.encourage
	call Random
	cp 39 percent + 1
	jr c, .done

	dec [hl]

.done
	ret

.discourage
	inc [hl]
	ret

AI_Smart_Encore:
	call AICompareSpeed
	jr nc, .discourage

	ld a, [wLastPlayerMove]
	and a
	jmp z, AIDiscourageMove

	call AIGetEnemyMove

	ld a, [wEnemyMoveStruct + MOVE_POWER]
	and a
	jr z, .weakmove

	push hl
	ld a, [wEnemyMoveStruct + MOVE_TYPE]
	and TYPE_MASK
	ld hl, wEnemyMonType1
	predef CheckTypeMatchup

	pop hl
	ld a, [wTypeMatchup]
	cp EFFECTIVE
	jr nc, .weakmove

	and a
	ret nz
	jr .encourage

.weakmove
	push hl
	ld a, [wLastPlayerCounterMove]
	ld hl, EncoreMoves
	call IsInByteArray
	pop hl
	jr nc, .discourage

.encourage
	call Random
	cp 28 percent - 1
	ret c
	dec [hl]
	dec [hl]
	ret

.discourage
	inc [hl]
	inc [hl]
	inc [hl]
	ret

INCLUDE "data/battle/ai/encore_moves.asm"

AI_Smart_PainSplit:
; Discourage this move if [enemy's current HP * 2 > player's current HP].

	push hl
	ld hl, wEnemyMonHP
	ld b, [hl]
	inc hl
	ld c, [hl]
	sla c
	rl b
	ld hl, wBattleMonHP + 1
	ld a, [hld]
	cp c
	ld a, [hl]
	sbc b
	pop hl
	ret nc
	inc [hl]
	ret

AI_Smart_Snore:
AI_Smart_SleepTalk:
; Greatly encourage this move if enemy is fast asleep.
; Greatly discourage this move otherwise.

	ld a, [wEnemyMonStatus]
	and SLP_MASK
	cp 1
	jr z, .discourage

	dec [hl]
	dec [hl]
	dec [hl]
	ret

.discourage
	inc [hl]
	inc [hl]
	inc [hl]
	ret

AI_Smart_Spite:
	ld a, [wLastPlayerCounterMove]
	and a
	jr nz, .usedmove

	call AICompareSpeed
	jmp c, AIDiscourageMove

	call AI_50_50
	ret c
	inc [hl]
	ret

.usedmove
	push hl
	ld b, a
	ld c, NUM_MOVES
	ld hl, wBattleMonMoves
	ld de, wBattleMonPP

.moveloop
	ld a, [hli]
	cp b
	jr z, .foundmove

	inc de
	dec c
	jr nz, .moveloop

	pop hl
	ret

.foundmove
	pop hl
	ld a, [de]
	cp 6
	jr c, .encourage
	cp 15
	jr nc, .discourage

	call Random
	cp 39 percent + 1
	ret nc

.discourage
	inc [hl]
	ret

.encourage
	call Random
	cp 39 percent + 1
	ret c
	dec [hl]
	dec [hl]
	ret

AI_Smart_DestinyBond:
AI_Smart_Reversal:
; Discourage this move if enemy's HP is above 25%.

	call AICheckEnemyQuarterHP
	ret nc
	inc [hl]
	ret

AI_Smart_HealBell:
; Dismiss this move if none of the opponent's Pokemon is statused.
; Encourage this move if the enemy is statused.
; 50% chance to greatly encourage this move if the enemy is fast asleep.

	push hl
	ld a, [wOTPartyCount]
	ld b, a
	ld c, 0
	ld hl, wOTPartyMon1HP
	ld de, PARTYMON_STRUCT_LENGTH

.loop
	push hl
	ld a, [hli]
	or [hl]
	jr z, .next

	; status
	dec hl
	dec hl
	dec hl
	ld a, [hl]
	or c
	ld c, a

.next
	pop hl
	add hl, de
	dec b
	jr nz, .loop

	pop hl
	ld a, c
	and a
	jr z, .no_status

	ld a, [wEnemyMonStatus]
	and a
	jr z, .ok
	dec [hl]
.ok
	and SLP_MASK
	ret z
	call AI_50_50
	ret c
	dec [hl]
	dec [hl]
	ret

.no_status
	ld a, [wEnemyMonStatus]
	and a
	ret nz
	jmp AIDiscourageMove


AI_Smart_PriorityHit:
	call AICompareSpeed
	ret c

; Dismiss this move if the player is flying or underground.
	ld a, [wPlayerSubStatus3]
	and 1 << SUBSTATUS_FLYING | 1 << SUBSTATUS_UNDERGROUND
	jmp nz, AIDiscourageMove

; Greatly encourage this move if it will KO the player.
	ld a, 1
	ldh [hBattleTurn], a
	push hl
	callfar EnemyAttackDamage
	callfar BattleCommand_DamageCalc
	callfar BattleCommand_Stab
	pop hl
	ld a, [wCurDamage + 1]
	ld c, a
	ld a, [wCurDamage]
	ld b, a
	ld a, [wBattleMonHP + 1]
	cp c
	ld a, [wBattleMonHP]
	sbc b
	ret nc
	dec [hl]
	dec [hl]
	dec [hl]
	ret

AI_Smart_Thief:
; Don't use Thief unless it's the only move available.

	ld a, [hl]
	add $1e
	ld [hl], a
	ret

AI_Smart_Disable:
	call AICompareSpeed
	jr nc, .discourage

	push hl
	ld a, [wLastPlayerCounterMove]
	ld hl, UsefulMoves
	call IsInByteArray

	pop hl
	jr nc, .notencourage

	call Random
	cp 39 percent + 1
	ret c
	dec [hl]
	ret

.notencourage
	ld a, [wEnemyMoveStruct + MOVE_POWER]
	and a
	ret nz

.discourage
	call Random
	cp 8 percent
	ret c
	inc [hl]
	ret

AI_Smart_MeanLook:
	call AICheckEnemyHalfHP
	jr nc, .discourage

	push hl
	call AICheckLastPlayerMon
	pop hl
	jmp z, AIDiscourageMove

; 80% chance to greatly encourage this move if the enemy is badly poisoned.
	ld a, [wPlayerSubStatus5]
	bit SUBSTATUS_TOXIC, a
	jr nz, .encourage

; 80% chance to greatly encourage this move if the player is either
; in love, identified, stuck in Rollout, or has a Nightmare.
	ld a, [wPlayerSubStatus1]
	and 1 << SUBSTATUS_IN_LOVE | 1 << SUBSTATUS_ROLLOUT | 1 << SUBSTATUS_IDENTIFIED | 1 << SUBSTATUS_NIGHTMARE
	jr nz, .encourage

; Otherwise, discourage this move unless the player only has not very effective moves against the enemy.
	push hl
	callfar CheckPlayerMoveTypeMatchups
	ld a, [wEnemyAISwitchScore]
	cp BASE_AI_SWITCH_SCORE + 1 ; not very effective
	pop hl
	ret nc

.discourage
	inc [hl]
	ret

.encourage
	call AI_80_20
	ret c
	dec [hl]
	dec [hl]
	dec [hl]
	ret

AICheckLastPlayerMon:
	ld a, [wPartyCount]
	ld b, a
	ld c, 0
	ld hl, wPartyMon1HP
	ld de, PARTYMON_STRUCT_LENGTH

.loop
	ld a, [wCurBattleMon]
	cp c
	jr z, .skip

	ld a, [hli]
	or [hl]
	ret nz
	dec hl

.skip
	add hl, de
	inc c
	dec b
	jr nz, .loop
	ret

AI_Smart_Curse:
	ld a, [wEnemyMonType1]
	cp GHOST
	jr z, .ghost_curse
	ld a, [wEnemyMonType2]
	cp GHOST
	jr z, .ghost_curse

	call AICheckEnemyHalfHP
	jr nc, .encourage

	ld a, [wEnemyAtkLevel]
	cp BASE_STAT_LEVEL + 4
	jr nc, .encourage
	cp BASE_STAT_LEVEL + 2
	ret nc

	ld a, [wBattleMonType1]
	cp GHOST
	jr z, .greatly_encourage
	call AI_80_20
	ret c
	dec [hl]
	dec [hl]
	ret

.approve
	inc [hl]
	inc [hl]
.greatly_encourage
	inc [hl]
.encourage
	inc [hl]
	ret

.ghost_curse
	ld a, [wPlayerSubStatus1]
	bit SUBSTATUS_CURSE, a
	jmp nz, AIDiscourageMove

	push hl
	farcall FindAliveEnemyMons
	pop hl
	jr nc, .notlastmon

	push hl
	call AICheckLastPlayerMon
	pop hl
	jr nz, .approve

	jr .ghost_continue

.notlastmon
	push hl
	call AICheckLastPlayerMon
	pop hl
	jr z, .maybe_greatly_encourage

.ghost_continue
	call AICheckEnemyQuarterHP
	jr nc, .approve

	call AICheckEnemyHalfHP
	jr nc, .greatly_encourage

	call AICheckEnemyMaxHP
	ret nc

	ld a, [wPlayerTurnsTaken]
	and a
	ret nz

.maybe_greatly_encourage
	call AI_50_50
	ret c

	dec [hl]
	dec [hl]
	ret

AI_Smart_Protect:
; Greatly discourage this move if the enemy already used Protect.
	ld a, [wEnemyProtectCount]
	and a
	jr nz, .greatly_discourage

; Encourage this move if the player has charged a two-turn move.
	ld a, [wPlayerSubStatus3]
	bit SUBSTATUS_CHARGED, a
	jr nz, .encourage

; Encourage this move if the player is affected by Toxic, Leech Seed, or Curse.
	ld a, [wPlayerSubStatus5]
	bit SUBSTATUS_TOXIC, a
	jr nz, .encourage
	ld a, [wPlayerSubStatus4]
	bit SUBSTATUS_LEECH_SEED, a
	jr nz, .encourage
	ld a, [wPlayerSubStatus1]
	bit SUBSTATUS_CURSE, a
	jr nz, .encourage

; Discourage this move if the player's Rollout count is not boosted enough.
	bit SUBSTATUS_ROLLOUT, a
	jr z, .discourage
	ld a, [wPlayerRolloutCount]
	cp 3
	jr c, .discourage

; 80% chance to encourage this move otherwise.
.encourage
	call AI_80_20
	ret c

	dec [hl]
	ret

.greatly_discourage
	inc [hl]

.discourage
	call Random
	cp 8 percent
	ret c

	inc [hl]
	inc [hl]
	ret

AI_Smart_Foresight:
; 60% chance to encourage this move if the enemy's accuracy is sharply lowered.
	ld a, [wEnemyAccLevel]
	cp BASE_STAT_LEVEL - 2
	jr c, .encourage

; 60% chance to encourage this move if the player's evasion is sharply raised.
	ld a, [wPlayerEvaLevel]
	cp BASE_STAT_LEVEL + 3
	jr nc, .encourage

; 60% chance to encourage this move if the player is a Ghost type.
	ld a, [wBattleMonType1]
	cp GHOST
	jr z, .encourage
	ld a, [wBattleMonType2]
	cp GHOST
	jr z, .encourage

; 92% chance to discourage this move otherwise.
	call Random
	cp 8 percent
	ret c

	inc [hl]
	ret

.encourage
	call Random
	cp 39 percent + 1
	ret c

	dec [hl]
	dec [hl]
	ret

AI_Smart_PerishSong:
	push hl
	callfar FindAliveEnemyMons
	pop hl
	jr c, .no

	ld a, [wPlayerSubStatus5]
	bit SUBSTATUS_CANT_RUN, a
	jr nz, .yes

	push hl
	callfar CheckPlayerMoveTypeMatchups
	ld a, [wEnemyAISwitchScore]
	cp BASE_AI_SWITCH_SCORE
	pop hl
	ret c

	call AI_50_50
	ret c

	inc [hl]
	ret

.yes
	call AI_50_50
	ret c

	dec [hl]
	ret

.no
	ld a, [hl]
	add 5
	ld [hl], a
	ret

AI_Smart_Sandstorm:
; Encourage using the move when the Weather Rock is held.
	ld a, [wEnemyMonItem]
	cp WEATHER_ROCK
	jr nz, .continue

	dec [hl]

.continue
; Greatly discourage this move if the player is immune to Sandstorm damage.
	ld a, [wBattleMonType1]
	push hl
	ld hl, .SandstormImmuneTypes
	call IsInByteArray
	pop hl
	jr c, .greatly_discourage

	ld a, [wBattleMonType2]
	push hl
	ld hl, .SandstormImmuneTypes
	call IsInByteArray
	pop hl
	jr c, .greatly_discourage

; Discourage this move if player's HP is below 50%.
	call AICheckPlayerHalfHP
	jr nc, .discourage

; 50% chance to encourage this move otherwise.
	call AI_50_50
	ret c

	dec [hl]
	ret

.greatly_discourage
	inc [hl]
.discourage
	inc [hl]
	ret

.SandstormImmuneTypes:
	db ROCK
	db GROUND
	db STEEL
	db -1 ; end

AI_Smart_Hail:
; Encourage using the move when the Weather Rock is held.
	ld a, [wEnemyMonItem]
	cp WEATHER_ROCK
	jr nz, .continue

	dec [hl]

.continue
; Greatly discourage this move if the player is immune to Hail damage.
	ld a, [wBattleMonType1]
	cp ICE
	jr z, .greatly_discourage

	ld a, [wBattleMonType2]
	cp ICE
	jr z, .greatly_discourage

; Discourage this move if player's HP is below 50%.
	call AICheckPlayerHalfHP
	jr nc, .discourage

; Encourage move if AI has good Hail moves
	push hl
	ld hl, .GoodHailMoves
	call AIHasMoveInArray
	pop hl
	jr c, .encourage

; ...80% chance to greatly encourage this move.
	call AI_80_20
	ret c

.encourage
	dec [hl]
	ret

.greatly_discourage
	inc [hl]
.discourage
	inc [hl]
	ret

.GoodHailMoves
	db BLIZZARD
	db -1 ; end

AI_Smart_Endure:
; Greatly discourage this move if the enemy already used Protect.
	ld a, [wEnemyProtectCount]
	and a
	jr nz, .greatly_discourage

; Greatly discourage this move if the enemy's HP is full.
	call AICheckEnemyMaxHP
	jr c, .greatly_discourage

; Discourage this move if the enemy's HP is at least 25%.
	call AICheckEnemyQuarterHP
	jr c, .discourage

; If the enemy has Reversal...
	ld b, EFFECT_REVERSAL
	call AIHasMoveEffect
	jr nc, .no_reversal

; ...80% chance to greatly encourage this move.
	call AI_80_20
	ret c

	dec [hl]
	dec [hl]
	dec [hl]
	ret

.no_reversal
; 50% chance to greatly encourage this move.
	call AI_50_50
	ret c

	dec [hl]
	dec [hl]
	ret

.greatly_discourage
	inc [hl]
.discourage
	inc [hl]
	ret

AI_Smart_Rollout:
; Rollout, Fury Cutter

; 80% chance to discourage this move if the enemy is in love, confused, or paralyzed.
	ld a, [wEnemySubStatus1]
	bit SUBSTATUS_IN_LOVE, a
	jr nz, .maybe_discourage

	ld a, [wEnemySubStatus3]
	bit SUBSTATUS_CONFUSED, a
	jr nz, .maybe_discourage

	ld a, [wEnemyMonStatus]
	bit PAR, a
	jr nz, .maybe_discourage

; 80% chance to discourage this move if the enemy's HP is below 25%,
; or if accuracy or evasion modifiers favour the player.
	call AICheckEnemyQuarterHP
	jr nc, .maybe_discourage

	ld a, [wEnemyAccLevel]
	cp BASE_STAT_LEVEL
	jr c, .maybe_discourage
	ld a, [wPlayerEvaLevel]
	cp BASE_STAT_LEVEL + 1
	jr nc, .maybe_discourage

; If the mon has Defense Curl, and hasn't used it yet,
; don't encourage Rollout
	ld b, EFFECT_DEFENSE_CURL
	call AIHasMoveEffect
	jr nc, .no_defense_curl
	ld a, [wEnemySubStatus2]
	bit SUBSTATUS_CURLED, a
	ret z

.no_defense_curl
; 80% chance to greatly encourage this move otherwise.
	call Random
	cp 79 percent - 1
	ret nc
	dec [hl]
	dec [hl]
	ret

.maybe_discourage
	call AI_80_20
	ret c
	inc [hl]
	ret

AI_Smart_Trick:
AI_Smart_Swagger:
AI_Smart_Attract:
; 80% chance to encourage this move during the first turn of player's Pokemon.
; 80% chance to discourage this move otherwise.

	ld a, [wPlayerTurnsTaken]
	and a
	jr z, .first_turn

	call AI_80_20
	ret c
	inc [hl]
	ret

.first_turn
	call Random
	cp 79 percent - 1
	ret nc
	dec [hl]
	ret

AI_Smart_Safeguard:
; 80% chance to discourage this move if player's HP is below 50%.

	call AICheckPlayerHalfHP
	ret c
	call AI_80_20
	ret c
	inc [hl]
	ret

AI_Smart_Earthquake:
; Greatly encourage this move if the player is underground and the enemy is faster.
	ld a, [wLastPlayerCounterMove]
	cp DIG
	ret nz

	ld a, [wPlayerSubStatus3]
	bit SUBSTATUS_UNDERGROUND, a
	jr z, .could_dig

	call AICompareSpeed
	ret nc
	dec [hl]
	dec [hl]
	ret

.could_dig
	; Try to predict if the player will use Dig this turn.

	; 50% chance to encourage this move if the enemy is slower than the player.
	call AICompareSpeed
	ret c

	call AI_50_50
	ret c

	dec [hl]
	ret

AI_Smart_BatonPass:
; Discourage this move if the player hasn't shown super-effective moves against the enemy.
; Consider player's type(s) if its moves are unknown.

	push hl
	callfar CheckPlayerMoveTypeMatchups
	ld a, [wEnemyAISwitchScore]
	cp BASE_AI_SWITCH_SCORE
	pop hl
	ret c
	inc [hl]
	ret

AI_Smart_Pursuit:
; 50% chance to greatly encourage this move if player's HP is below 25%.
; 80% chance to discourage this move otherwise.

	call AICheckPlayerQuarterHP
	jr nc, .encourage
	call AI_80_20
	ret c
	inc [hl]
	ret

.encourage
	call AI_50_50
	ret c
	dec [hl]
	dec [hl]
	ret

AI_Smart_RapidSpin:
; 80% chance to greatly encourage this move if the enemy is
; trapped (Bind effect), seeded, or scattered with spikes.

	ld a, [wEnemyWrapCount]
	and a
	jr nz, .encourage

	ld a, [wEnemySubStatus4]
	bit SUBSTATUS_LEECH_SEED, a
	jr nz, .encourage

	ld a, [wEnemyScreens]
	bit SCREENS_SPIKES, a
	ret z

.encourage
	call AI_80_20
	ret c

	dec [hl]
	dec [hl]
	ret

AI_Smart_HiddenPower:
	push hl
	ld a, 1
	ldh [hBattleTurn], a

; Calculate Hidden Power's type based on enemy's DVs
	callfar HiddenPowerDamage
	callfar BattleCheckTypeMatchup
	pop hl

; Discourage Hidden Power if not very effective, encourage it if super-effective. 
; Otherwise do nothing.
	ld a, [wTypeMatchup]
	cp EFFECTIVE
	ret z
	jr c, .bad

	dec [hl]
	ret

.bad
	inc [hl]
	ret

AI_Smart_RainDance:
; Encourage using the move when the Weather Rock is held.
	ld a, [wEnemyMonItem]
	cp WEATHER_ROCK
	jr nz, .continue

	dec [hl]

.continue
; Greatly discourage this move if it would favour the player type-wise.
; Particularly, if the player is a Water-type.
	ld a, [wBattleMonType1]
	cp WATER
	jr z, AIBadWeatherType
	cp FIRE
	jr z, AIGoodWeatherType

	ld a, [wBattleMonType2]
	cp WATER
	jr z, AIBadWeatherType
	cp FIRE
	jr z, AIGoodWeatherType

	push hl
	ld hl, RainDanceMoves
	jr AI_Smart_WeatherMove

INCLUDE "data/battle/ai/rain_dance_moves.asm"

AI_Smart_SunnyDay:
; Encourage using the move when the Weather Rock is held.
	ld a, [wEnemyMonItem]
	cp WEATHER_ROCK
	jr nz, .continue

	dec [hl]

.continue
; Greatly discourage this move if it would favour the player type-wise.
; Particularly, if the player is a Fire-type.
	ld a, [wBattleMonType1]
	cp FIRE
	jr z, AIBadWeatherType
	cp WATER
	jr z, AIGoodWeatherType

	ld a, [wBattleMonType2]
	cp FIRE
	jr z, AIBadWeatherType
	cp WATER
	jr z, AIGoodWeatherType

	push hl
	ld hl, SunnyDayMoves

	; fallthrough

AI_Smart_WeatherMove:
; Rain Dance, Sunny Day

; Greatly discourage this move if the enemy doesn't have
; one of the useful Rain Dance or Sunny Day moves.
	call AIHasMoveInArray
	pop hl
	jr nc, AIBadWeatherType

; Greatly discourage this move if player's HP is below 50%.
	call AICheckPlayerHalfHP
	jr nc, AIBadWeatherType

; 50% chance to encourage this move otherwise.
	call AI_50_50
	ret c

	dec [hl]
	ret

AIBadWeatherType:
	inc [hl]
	inc [hl]
	inc [hl]
	ret

AIGoodWeatherType:
; Rain Dance, Sunny Day

; Greatly encourage this move if it would disfavour the player type-wise and player's HP is above 50%...
	call AICheckPlayerHalfHP
	ret nc

; ...as long as one of the following conditions meet:
; It's the first turn of the player's Pokemon.
	ld a, [wPlayerTurnsTaken]
	and a
	jr z, .good

; Or it's the first turn of the enemy's Pokemon.
	ld a, [wEnemyTurnsTaken]
	and a
	ret nz

.good
	dec [hl]
	dec [hl]
	ret

INCLUDE "data/battle/ai/sunny_day_moves.asm"

AI_Smart_BellyDrum:
; Dismiss this move if enemy's attack is higher than +2 or if enemy's HP is below 50%.
; Else, discourage this move if enemy's HP is not full.

	ld a, [wEnemyAtkLevel]
	cp BASE_STAT_LEVEL + 3
	jr nc, .discourage

	call AICheckEnemyMaxHP
	ret c

	inc [hl]

	call AICheckEnemyHalfHP
	ret c

.discourage
	ld a, [hl]
	add 5
	ld [hl], a
	ret

AI_Smart_MirrorCoat:
	push hl
	ld hl, wPlayerUsedMoves
	ld c, NUM_MOVES
	ld b, 0

.playermoveloop
	ld a, [hli]
	and a
	jr z, .skipmove

	call AIGetEnemyMove

	ld a, [wEnemyMoveStruct + MOVE_POWER]
	and a
	jr z, .skipmove

	ld a, [wEnemyMoveStruct + MOVE_TYPE]
	cp SPECIAL
	jr c, .skipmove

	inc b

.skipmove
	dec c
	jr nz, .playermoveloop

	pop hl
	ld a, b
	and a
	jr z, .discourage

	cp 3
	jr nc, .encourage

	ld a, [wLastPlayerCounterMove]
	and a
	jr z, .done

	call AIGetEnemyMove

	ld a, [wEnemyMoveStruct + MOVE_POWER]
	and a
	jr z, .done

	ld a, [wEnemyMoveStruct + MOVE_TYPE]
	cp SPECIAL
	jr c, .done

.encourage
	call Random
	cp 39 percent + 1
	jr c, .done
	dec [hl]

.done
	ret

.discourage
	inc [hl]
	ret

AI_Smart_Gust:
; Greatly encourage this move if the player is flying and the enemy is faster.
	ld a, [wLastPlayerCounterMove]
	cp FLY
	ret nz

	ld a, [wPlayerSubStatus3]
	bit SUBSTATUS_FLYING, a
	jr z, .couldFly

	call AICompareSpeed
	ret nc

	dec [hl]
	dec [hl]
	ret

; Try to predict if the player will use Fly this turn.
.couldFly

; 50% chance to encourage this move if the enemy is slower than the player.
	call AICompareSpeed
	ret c
	call AI_50_50
	ret c
	dec [hl]
	ret

AI_Smart_Stomp:
; 80% chance to encourage this move if the player has used Minimize.

	ld a, [wPlayerMinimized]
	and a
	ret z

	call AI_80_20
	ret c

	dec [hl]
	ret

AI_Smart_Solarbeam:
; 80% chance to encourage this move when it's sunny.
; 90% chance to discourage this move when it's raining.

	ld a, [wBattleWeather]
	cp WEATHER_SUN
	jr z, .encourage

	cp WEATHER_RAIN
	ret nz

	call AI_90_10
	ret c

	inc [hl]
	inc [hl]
	ret

.encourage
	call AI_80_20
	ret c

	dec [hl]
	dec [hl]
	ret

AI_Smart_Thunder:
AI_Smart_Hurricane:
; 90% chance to discourage this move when it's sunny.

	ld a, [wBattleWeather]
	cp WEATHER_SUN
	ret nz

	call AI_90_10
	ret c

	inc [hl]
	ret
