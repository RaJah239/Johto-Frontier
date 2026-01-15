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
	dbw EFFECT_DREAM_EATER,      AI_Smart_DreamEater ; good as is
	dbw EFFECT_EVASION_UP,       AI_Smart_EvasionUp ; good as is
	dbw EFFECT_ALWAYS_HIT,       AI_Smart_AlwaysHit ; updated
	dbw EFFECT_ACCURACY_DOWN,    AI_Smart_AccuracyDown ; updated
	dbw EFFECT_ATTACK_DOWN,      AI_Smart_AttackDown ; updated
	dbw EFFECT_ATTACK_DOWN_2,    AI_Smart_AttackDown ; updated
	dbw EFFECT_DEFENSE_DOWN,     AI_Smart_DefenseDown ; newly added
	dbw EFFECT_DEFENSE_DOWN_2,   AI_Smart_DefenseDown ; newly added
	dbw EFFECT_SPEED_DOWN_2,     AI_Smart_SpeedDown ; newly added
	dbw EFFECT_RESET_STATS,      AI_Smart_ResetStats ; good as is
	dbw EFFECT_FORCE_SWITCH,     AI_Smart_ForceSwitch ; updated
	dbw EFFECT_HEAL,             AI_Smart_Heal ; updated
	dbw EFFECT_TOXIC,            AI_Smart_Toxic ; updated
	dbw EFFECT_LIGHT_SCREEN,     AI_Smart_LightScreen ; updated
	dbw EFFECT_OHKO,             AI_Smart_Ohko ; good as is
	dbw EFFECT_SUPER_FANG,       AI_Smart_SuperFang ; good as is
	dbw EFFECT_TRAP_TARGET,      AI_Smart_TrapTarget ; good as is
	dbw EFFECT_CONFUSE,          AI_Smart_Confuse ; updated
	dbw EFFECT_SP_DEF_UP_2,      AI_Smart_SpDefenseUp2 ; updated
	dbw EFFECT_REFLECT,          AI_Smart_Reflect ; updated
	dbw EFFECT_PARALYZE,         AI_Smart_Paralyze ; updated
	dbw EFFECT_SPEED_DOWN_HIT,   AI_Smart_SpeedDownHit ; updated
	dbw EFFECT_SUBSTITUTE,       AI_Smart_Substitute ; updated
	dbw EFFECT_HYPER_BEAM,       AI_Smart_HyperBeam ; updated
	dbw EFFECT_LEECH_SEED,       AI_Smart_LeechSeed ; updated
	dbw EFFECT_DISABLE,          AI_Smart_Disable ; updated
	dbw EFFECT_COUNTER,          AI_Smart_Counter ; updated
	dbw EFFECT_ENCORE,           AI_Smart_Encore ; updated
	dbw EFFECT_PAIN_SPLIT,       AI_Smart_PainSplit ; good as is
	dbw EFFECT_SNORE,            AI_Smart_Snore ; updated
	dbw EFFECT_SLEEP_TALK,       AI_Smart_SleepTalk ; updated
	dbw EFFECT_DESTINY_BOND,     AI_Smart_DestinyBond ; updated
	dbw EFFECT_REVERSAL,         AI_Smart_Reversal ; good as is
	dbw EFFECT_SPITE,            AI_Smart_Spite ; good as is
	dbw EFFECT_HEAL_BELL,        AI_Smart_HealBell ; updated
	dbw EFFECT_PRIORITY_HIT,     AI_Smart_PriorityHit ; updated
	dbw EFFECT_THIEF,            AI_Smart_Thief ; updated
	dbw EFFECT_MEAN_LOOK,        AI_Smart_MeanLook ; updated
	dbw EFFECT_CURSE,            AI_Smart_Curse ; updated
	dbw EFFECT_PROTECT,          AI_Smart_Protect ; updated
	dbw EFFECT_FORESIGHT,        AI_Smart_Foresight ; good as is
	dbw EFFECT_PERISH_SONG,      AI_Smart_PerishSong ; updated
	dbw EFFECT_SANDSTORM,        AI_Smart_Sandstorm ; updated
	dbw EFFECT_ROLLOUT,          AI_Smart_Rollout ; good as is
	dbw EFFECT_SWAGGER,          AI_Smart_Swagger ; updated
	dbw EFFECT_ATTRACT,          AI_Smart_Attract ; good as is
	dbw EFFECT_SAFEGUARD,        AI_Smart_Safeguard ; good as is
	dbw EFFECT_BATON_PASS,       AI_Smart_BatonPass ; updated
	dbw EFFECT_PURSUIT,          AI_Smart_Pursuit ; updated
	dbw EFFECT_RAPID_SPIN,       AI_Smart_RapidSpin ; updated
	dbw EFFECT_WEATHER_HEAL,     AI_Smart_Heal ; updated
	dbw EFFECT_HIDDEN_POWER,     AI_Smart_HiddenPower ; good as is
	dbw EFFECT_RAIN_DANCE,       AI_Smart_RainDance ; updated
	dbw EFFECT_SUNNY_DAY,        AI_Smart_SunnyDay ; updated
	dbw EFFECT_BELLY_DRUM,       AI_Smart_BellyDrum ; updated
	dbw EFFECT_MIRROR_COAT,      AI_Smart_MirrorCoat ; updated
	dbw EFFECT_EARTHQUAKE,       AI_Smart_Earthquake ; good as is
	dbw EFFECT_GUST,             AI_Smart_Gust ; good as is
	dbw EFFECT_STOMP,            AI_Smart_Stomp ; good as is
	dbw EFFECT_SOLARBEAM,        AI_Smart_Solarbeam ; good as is
	dbw EFFECT_THUNDER,          AI_Smart_Thunder ; updated
	dbw EFFECT_FLY,              AI_Smart_Fly ; updated
	dbw EFFECT_HAIL,             AI_Smart_Hail ; updated
	dbw EFFECT_FACADE,           AI_Smart_Facade ; good as is
	dbw EFFECT_HEX,              AI_Smart_Hex ; good as is
	dbw EFFECT_HURRICANE,        AI_Smart_Hurricane ; updated
	dbw EFFECT_FAKE_OUT,         AI_Smart_Fake_Out ; good as is
	dbw EFFECT_FREEZE_DRY,       AI_Smart_FreezeDry ; good as is
	dbw EFFECT_BODY_PRESS,       AI_Smart_BodyPress ; good as is
	dbw EFFECT_AVALANCHE,        AI_Smart_Avalanche ; good as is
	dbw EFFECT_BRICK_BREAK,      AI_Smart_BrickBreak ; updated
	dbw EFFECT_PARALYZE_HIT,     AI_Smart_ParalyzeTarget ; updated
	dbw EFFECT_ACROBATICS,       AI_Smart_Acrobatics ; good as is
	dbw EFFECT_TRICK,            AI_Smart_Trick ; good as is
	dbw EFFECT_VENOSHOCK,        AI_Smart_Venoshock ; good as is
	dbw EFFECT_DRAGON_DANCE,     AI_Smart_DragonDance ; updated
	dbw EFFECT_CALM_MIND,        AI_Smart_CalmMind ; updated
	dbw EFFECT_QUIVER_DANCE,     AI_Smart_QuiverDance ; updated
	dbw EFFECT_ATTACK_UP_2,      AI_Smart_SwordsDance ; updated
	dbw EFFECT_SP_ATK_UP_2,      AI_Smart_NastyPlot ; updated
	dbw EFFECT_BULK_UP,          AI_Smart_BulkUp ; updated
	dbw EFFECT_BARRIER,          AI_Smart_Barrier ; added
	dbw EFFECT_SPEED_UP_2,       AI_Smart_Agility ; added
	dbw EFFECT_SPIKES,           AI_Smart_Spikes ; added
	dbw EFFECT_STEALTH_ROCK,     AI_Smart_StealthRock ; added
    dbw EFFECT_TOXIC_SPIKES,     AI_Smart_ToxicSpikes ; added
    dbw EFFECT_STICKY_WEB,       AI_Smart_StickyWeb ; added
    dbw EFFECT_FLINCH_HIT,       AI_Smart_Flinch ; added
    dbw EFFECT_DEFENSE_UP,       AI_Smart_LesserStatChange ; added
    dbw EFFECT_FOCUS_ENERGY,     AI_Smart_LesserStatChange ; added
    dbw EFFECT_SAFEGUARD,        AI_Smart_LesserStatChange ; added
    dbw EFFECT_DEFENSE_CURL,     AI_Smart_LesserStatChange ; added
    dbw EFFECT_DEFOG,            AI_Smart_Defog ; added
    dbw EFFECT_TRICK_ROOM,       AI_Smart_TrickRoom ; added
    dbw EFFECT_BURN,             AI_Smart_Burn ; added
    dbw EFFECT_TAUNT,            AI_Smart_Taunt ; added
	dbw EFFECT_SUCKER_PUNCH,     AI_Smart_SuckerPunch ; added
	db -1 ; end

AI_Smart_SuckerPunch:
; if the players last move had no power - 50% chance to discourage.
	ld a, [wCurPlayerMove]
	call AIGetPlayerMove
	ld a, [wPlayerMoveStruct + MOVE_POWER]
	and a
	jmp nz, AI_Smart_PriorityHit
	call AI_50_50
	jmp c, AI_Smart_PriorityHit

rept 12
	inc [hl]
endr
	ret

AI_Smart_Taunt:
; if player is already taunted - discourage
	ld a, [wPlayerTauntCount]
	and a
	jmp nz, .discourage

; never use if player has safeguard
	ld a, [wPlayerScreens]
	bit SCREENS_SAFEGUARD, a
	jmp nz, .discourage

; if player can KO - discourage
	call ShouldAIBoost
	jmp nc, .discourage

; if player is already set up - discourage
	ld a, [wPlayerAtkLevel]
	cp BASE_STAT_LEVEL + 2
	jmp nc, .discourage
	ld a, [wPlayerSAtkLevel]
	cp BASE_STAT_LEVEL + 2
	jr nc, .discourage

; if we can KO - discourage
	call CanAIKO
	jr c, .discourage

; if player has a setup move, status move, or healing move - encourage
    ld b, EFFECT_TAUNT
	call PlayerHasMoveEffect
	jr c, .encourage
    ld b, EFFECT_BULK_UP
	call PlayerHasMoveEffect
	jr c, .encourage
    ld b, EFFECT_CALM_MIND
	call PlayerHasMoveEffect
	jr c, .encourage
    ld b, EFFECT_CURSE
	call PlayerHasMoveEffect
	jr c, .encourage
    ld b, EFFECT_ATTACK_UP_2
	call PlayerHasMoveEffect
	jr c, .encourage
    ld b, EFFECT_SP_ATK_UP_2
	call PlayerHasMoveEffect
	jr c, .encourage
    ld b, EFFECT_DRAGON_DANCE
	call PlayerHasMoveEffect
	jr c, .encourage
    ld b, EFFECT_FURY_DRIVE
	call PlayerHasMoveEffect
	jr c, .encourage
    ld b, EFFECT_QUIVER_DANCE
	call PlayerHasMoveEffect
	jr c, .encourage
    ld b, EFFECT_PARALYZE
	call PlayerHasMoveEffect
	jr c, .encourage
    ld b, EFFECT_BURN
	call PlayerHasMoveEffect
	jr c, .encourage
    ld b, EFFECT_TOXIC
	call PlayerHasMoveEffect
	jr c, .encourage
    ld b, EFFECT_HEAL
	call PlayerHasMoveEffect
	jr c, .encourage
    ld b, EFFECT_LEECH_SEED
	call PlayerHasMoveEffect
	jr c, .encourage
    ld b, EFFECT_STEALTH_ROCK
	call PlayerHasMoveEffect
	jr c, .encourage

; if players last move had 0 power - 50% chance to encourage
	ld a, [wLastPlayerMove]
	call AIGetPlayerMove
	ld a, [wPlayerMoveStruct + MOVE_POWER]
	and a
	jr nz, .discourage
	call AI_50_50
	jr c, .encourage

; otherwise discourage
.discourage
	inc [hl]
	inc [hl]
	ret

.encourage
rept 12
	dec [hl]
endr
	ret

AI_Smart_Burn:
; if enemy is already statused - discourage
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

; if enemy is fire type - discourage
	ld a, [wBattleMonType1]
	cp FIRE
	jr z, .discourage
	ld a, [wBattleMonType2]
	cp FIRE
	jr z, .discourage

; don't use against serenity pokemon as they are immune to status
	ld a, [wBattleMonSpecies]
	push hl
	ld hl, SerenityPokemon_AI
	call IsInByteArray
	pop hl
	jr c, .discourage

; strongly encourage if enemy is physical
	call IsPlayerPhysicalOrSpecial
	ret nc

	dec [hl]
	dec [hl]
	dec [hl]
	ret

.discourage
	inc [hl]
	inc [hl]
	ret

AI_Smart_Defog:
; don't use if player has only one pokemon left
	push hl
	call AICheckLastPlayerMon
	pop hl
	jmp z, StandardDiscourage

; use if player has any screens up
	ld a, [wPlayerScreens]
	bit SCREENS_STEALTH_ROCK, a
	jmp nz, StandardEncourage
	bit SCREENS_SPIKES, a
	jmp nz, StandardEncourage
	bit SCREENS_TOXIC_SPIKES, a
	jmp nz, StandardEncourage
	bit SCREENS_STICKY_WEB, a
	jmp nz, StandardEncourage

; otherwise discourage
	jmp StandardDiscourage

AI_Smart_LesserStatChange:
	call AICheckEnemyMaxHP
	jr nc, .discourage
	call ShouldAIBoost
	jr nc, .discourage
	ret

.discourage
	inc [hl]
	inc [hl]
	inc [hl]
    ret

AI_Smart_Flinch:
; do nothing if slower than player
	call DoesAIOutSpeedPlayer
	ret nc

; encourage if enemy is paralyzed
	ld a, [wBattleMonStatus]
	and 1 << PAR
	jr nz, .small_encourage

; encourage if enemy has serene grace ability pokemon
	ld a, [wEnemyMonSpecies]
	push hl
	ld hl, SereneGracePokemon_AI
	call IsInByteArray
	pop hl
	ret c
.encourage
    dec [hl]
.small_encourage
    dec [hl]
    ret

AI_Smart_StealthRock:
; don't use if already up
	ld a, [wPlayerScreens]
	bit SCREENS_STEALTH_ROCK, a
	jmp nz, StandardDiscourage
	jr AI_Smart_Hazards

AI_Smart_ToxicSpikes:
; don't use if already up
	ld a, [wPlayerScreens]
	bit SCREENS_TOXIC_SPIKES, a
	jmp nz, StandardDiscourage
	jr AI_Smart_Hazards

AI_Smart_StickyWeb:
; don't use if already up
	ld a, [wPlayerScreens]
	bit SCREENS_STICKY_WEB, a
	jmp nz, StandardDiscourage
	jr AI_Smart_Hazards

AI_Smart_Spikes:
; don't use if already up
	ld a, [wPlayerScreens]
	bit SCREENS_SPIKES, a
	jmp nz, StandardDiscourage
	; fallthrough

AI_Smart_Hazards:
; Don't use if enemy has rapid spin or defog
	ld a, [wLastPlayerMove]
	cp RAPID_SPIN
	jmp z, StandardDiscourage
	cp DEFOG
	jmp z, StandardDiscourage

; don't use if player has only one pokemon left
	push hl
	call AICheckLastPlayerMon
	pop hl
	jmp z, StandardDiscourage

; use otherwise
	jmp DoIt

AI_Smart_TrickRoom:
	ld a, [wTrickRoomCount]
	and a
	jmp nz, StandardDiscourage
	; fallthrough

AI_Smart_Agility:
; discourage if we are faster
	call DoesAIOutSpeedPlayer
	jmp c, StandardDiscourage

; discourage if enemy is paralyzed
	ld a, [wEnemyMonStatus]
	and 1 << PAR
	jmp nz, StandardDiscourage

; discourage if we will be KOd
	call CanPlayerKO
	jmp c, StandardDiscourage

; otherwise use
	jmp StrongEncourage

AI_Smart_Barrier:
	call IsDefenseMaxed
	jr nc, .continue
	call IsSpecialDefenseMaxed
	jr c, .discourage

; don't boost if choice locked
    call DoesEnemyHaveChoiceItem
    jr c, .discourage

.continue
; if player outspeeds us and can ohko then don't use
	call DoesAIOutSpeedPlayer
	jr c, .encourage
    call CanPlayerKO
    jr c, .discourage

; encourage enough to overcome encouragement to score a ko
.encourage
rept 12
    dec [hl]
endr
	ret

.discourage
	inc [hl]
	inc [hl]
	inc [hl]
	inc [hl]
	ret

AI_Smart_SpeedDown:
; discourage if enemy is immune to stat drops
	ld a, [wBattleMonSpecies]
	call DoesPokemonHaveClearBody
	jr c, .discourage

	call ShouldAIBoost
	jr nc, .discourage

	call DoesAIOutSpeedPlayer
	jr c, .discourage

	dec [hl]
	dec [hl]
	ret

.discourage
	inc [hl]
	inc [hl]
	inc [hl]
	inc [hl]
	ret

AI_Smart_DefenseDown:
; discourage if enemy is immune to stat drops
	ld a, [wBattleMonSpecies]
	call DoesPokemonHaveClearBody
	jr c, .discourage

	call ShouldAIBoost
	jr nc, .discourage

	dec [hl]
	ret

.discourage
	inc [hl]
	inc [hl]
	inc [hl]
	inc [hl]
	ret

AI_Smart_AttackDown:
; discourage if enemy is immune to stat drops
	ld a, [wBattleMonSpecies]
	call DoesPokemonHaveClearBody
	jr c, .discourage

	call ShouldAIBoost
	jr nc, .discourage

; discourage after player is at -3
	ld a, [wPlayerAtkLevel]
	cp BASE_STAT_LEVEL - 1
	jr c, .discourage

	call IsPlayerPhysicalOrSpecial
	jr nc, .discourage

	dec [hl]
	ret

.discourage
	inc [hl]
	inc [hl]
	inc [hl]
	inc [hl]
	ret

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

AI_Smart_Thief:
AI_Smart_Acrobatics:
; Greatly encourage this move if the user does not have an item.
	ld a, [wEnemyMonItem]
	and a
	ret nz
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
; brick break
; 90% chance to greatly encourage this move if the player used LIGHT_SCREEN or REFLECT.

	; Load the player's field conditions
	ld a, [wPlayerMoveStruct + MOVE_ANIM]
	cp LIGHT_SCREEN
	call z, .encourage
	cp REFLECT
	call z, .encourage
	ret ; If neither LIGHT_SCREEN nor REFLECT is active, skip the encouragement

.encourage
	call AI_90_10
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
; 80% chance to encourage this move if the player is a water type
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

; ...or player's evasion level has been raised two or more stages.
	ld a, [wPlayerEvaLevel]
	cp BASE_STAT_LEVEL + 2
	ret c

.encourage
	call AI_80_20
	ret c

	dec [hl]
	dec [hl]
	ret

AI_Smart_AccuracyDown:
; discourage if enemy is immune to stat drops
	ld a, [wBattleMonSpecies]
	call DoesPokemonHaveClearBody
	jr c, .discourage

; discourage after player is at -3
	ld a, [wPlayerAccLevel]
	cp BASE_STAT_LEVEL - 2
	jr c, .discourage

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
	inc [hl]
	inc [hl]
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

; don't use if player has only one pokemon left
	push hl
	call AICheckLastPlayerMon
	pop hl
	jr z, .discourage

; encourage this move if the player's attack levels are boosted.
	ld a, [wPlayerAtkLevel]
	cp BASE_STAT_LEVEL + 2
	jr nc, .encourage
	ld a, [wPlayerSAtkLevel]
	cp BASE_STAT_LEVEL + 2
	jr nc, .encourage

; discourage if non-boosted player can 2HKO from current HP
	call CanPlayer2HKO
	jr c, .discourage

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
	inc [hl]
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
; never use if player has substitute
	ld a, [wPlayerSubStatus4]
	bit SUBSTATUS_SUBSTITUTE, a
	jr nz, .discourage

; never use if player has safeguard
	ld a, [wPlayerScreens]
	bit SCREENS_SAFEGUARD, a
	jr nz, .discourage

; never use against steel types
	ld a, [wBattleMonType1]
	cp STEEL
	jr z, .discourage
	ld a, [wBattleMonType2]
	cp STEEL
	jr z, .discourage

; never use against poison types
	ld a, [wBattleMonType1]
	cp POISON
	jr z, .discourage
	ld a, [wBattleMonType2]
	cp POISON
	jr z, .discourage

; never use against Pokemon immune to status
	ld a, [wBattleMonSpecies]
	push hl
	ld hl, SerenityPokemon_AI
	call IsInByteArray
	pop hl
	jr c, .discourage

; never use against Pokemon with magic guard
	ld a, [wBattleMonSpecies]
	call DoesPokemonHaveMagicGuard
	jr c, .discourage

; don't use if player below 50% HP
	call AICheckPlayerHalfHP
	jr nc, .discourage

; encourage slightly if we get here
	dec [hl]
	ret

.discourage
	inc [hl]
	inc [hl]
	inc [hl]
	ret

AI_Smart_LeechSeed:
; leech seed
; never use against grass types
	ld a, [wBattleMonType1]
	cp GRASS
	jr z, .discourage
	ld a, [wBattleMonType2]
	cp GRASS
	jr z, .discourage

; don't use on foes twice our level
	ld a, [wBattleMonLevel]
	srl a
	ld b, a
	ld a, [wEnemyMonLevel]
	sub b
	jr c, .discourage

; never use against Pokemon with magic guard
	ld a, [wBattleMonSpecies]
	call DoesPokemonHaveMagicGuard
	jr c, .discourage

; don't use on already seeded player
	ld a, [wPlayerSubStatus4]
	bit SUBSTATUS_LEECH_SEED, a
	jr nz, .discourage

; don't use if we will be ko'd
	call ShouldAIBoost
	jr nc, .discourage

; don't use if we can just 2hko the player
	call CanAI2HKO
	jr c, .discourage

; otherwise use
rept 5
	dec [hl]
endr
	ret

.discourage
	inc [hl]
	inc [hl]
	ret

AI_Smart_LightScreen:
AI_Smart_Reflect:
	call ShouldAIBoost
	jmp nc, StandardDiscourage

	call IsPlayerPhysicalOrSpecial
	jmp nc, StandardEncourage

	jmp StandardDiscourage

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
; wrap, fire spin, sand tomb, whirlpool

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
; never use against Pokemon immune to status
	ld a, [wBattleMonSpecies]
	push hl
	ld hl, SerenityPokemon_AI
	call IsInByteArray
	pop hl
	jr c, .discourage

; never use if player has substitute
	ld a, [wPlayerSubStatus4]
	bit SUBSTATUS_SUBSTITUTE, a
	jr nz, .discourage

; never use if player has safeguard
	ld a, [wPlayerScreens]
	bit SCREENS_SAFEGUARD, a
	jr nz, .discourage

; discourage if already confused
	ld a, [wPlayerSubStatus3]
	bit SUBSTATUS_CONFUSED, a
	jr nz, .discourage

; encourage if enemy is paralyzed
	ld a, [wBattleMonStatus]
	and 1 << PAR
	jr z, .encourage

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

.encourage
	dec [hl]
	dec [hl]
	ret

.discourage
	inc [hl]
	inc [hl]
	ret

AI_Smart_SpDefenseUp2:
; amnesia

	call ShouldAIBoost
	jr nc, .discourage

; Discourage this move if enemy's special defense level is higher than +3.
	ld a, [wEnemySDefLevel]
	cp BASE_STAT_LEVEL + 4
	jr nc, .discourage

; greatly encourage this move if
; enemy's Special Defense level is lower than +3,
; and the player's Pokémon is Special-oriented.
	cp BASE_STAT_LEVEL + 3
	ret nc

	call IsPlayerPhysicalOrSpecial
	jr nc, .encourage
	ret

.discourage
	inc [hl]
	ret

.encourage
rept 8
	dec [hl]
endr
	ret

AI_Smart_Fly:
; Fly, Dig

; discourage if player knows protect
	ld b, EFFECT_PROTECT
	call PlayerHasMoveEffect
	jr c, .discourage

; Greatly encourage this move if the player is
; flying or underground, and slower than the enemy.

	ld a, [wPlayerSubStatus3]
	and 1 << SUBSTATUS_FLYING | 1 << SUBSTATUS_UNDERGROUND
	ret z

	call DoesAIOutSpeedPlayer
	jr nc, .discourage

	dec [hl]
	dec [hl]
	dec [hl]
	ret

.discourage
	inc [hl]
	inc [hl]
	inc [hl]
	ret

AI_Smart_SuperFang:
; Discourage this move if player's HP is below 25%.

	call AICheckPlayerQuarterHP
	ret c
	inc [hl]
	ret

AI_Smart_Paralyze:
; thunder wave, stun spore

; never use if player already has a status
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

; never use while in trick room
	ld a, [wTrickRoomCount]
	and a
	jr nz, .discourage

; never use against Pokemon immune to status
	ld a, [wBattleMonSpecies]
	push hl
	ld hl, SerenityPokemon_AI
	call IsInByteArray
	pop hl
	jr c, .discourage

; encourage if enemy is slower than player.
; 50% chance to discourage otherwise
	call DoesAIOutSpeedPlayer
	jr c, .AIFaster

; 50% to discourage if player knows sub
	ld b, EFFECT_SUBSTITUTE
	call PlayerHasMoveEffect
	jr c, .discourage50
	jr .checkEvasion

; if we are faster and either the player or us can 2HKO, discourage - otherwise discourage 50%
.AIFaster
	call CanPlayer2HKOMaxHP
	jr c, .discourage
	call CanAI2HKO
	jr c, .discourage
	jr .discourage50

.checkEvasion
; if player is evasive and we know an always hit move then discourage so we just attack
	ld a, [wPlayerEvaLevel]
	cp BASE_STAT_LEVEL + 2
	jr c, .encourage

	ld b, EFFECT_ALWAYS_HIT
	call AIHasMoveEffect
	jr c, .discourage

.encourage
; needs to overcome encouragement to attack
; no good reason not to paralyze
rept 12
	dec [hl]
endr
	ret

.discourage50
	call AI_50_50
	ret c
.discourage
	inc [hl]
	inc [hl]
	inc [hl]
	inc [hl]
	inc [hl]
	inc [hl]
	ret

AI_Smart_SpeedDownHit:
; icy wind, bulldoze, pounce, rock tomb

	call DoesAIOutSpeedPlayer
	ret c

    ld a, [wBattleMonSpecies]
    call DoesPokemonHaveClearBody
	jmp c, StandardDiscourage

	jmp StandardEncourage

AI_Smart_Substitute:
; don't sub if choice locked
	call DoesEnemyHaveChoiceItem
	jr c, .discourage

; discourage if player will move first
	call DoesAIOutSpeedPlayer
	jr nc, .discourage

; if player has status moves then don't consider player damage
	ld b, EFFECT_PARALYZE
	call PlayerHasMoveEffect
	jr c, .hasStatus
	ld b, EFFECT_SLEEP
	call PlayerHasMoveEffect
	jr c, .hasStatus
	ld b, EFFECT_TOXIC
	call PlayerHasMoveEffect
	jr c, .hasStatus

; if player can 3HKO from max hp the discourage sub
	call CanPlayer3HKOMaxHP
	jr c, .discourage
	jr .pastStatus

.hasStatus
; extra encourage at full hp
	call AICheckEnemyMaxHP
	jr nc, .pastStatus
	dec [hl]
	dec [hl]
	dec [hl]
	dec [hl]

.pastStatus
; encourage at full hp
	call AICheckEnemyMaxHP
	jr c, .encourage

; if above 1/4 hp encourage if player is asleep or user has boosted evasion
	call AICheckEnemyQuarterHP
	jr nc, .discourage
	ld a, [wBattleMonStatus]
	and SLP_MASK
	jr nz, .encourage
	ld a, [wEnemyEvaLevel]
	cp BASE_STAT_LEVEL + 2
	jr nc, .encourage

; otherwise 50% to encourage if above half hp, discourage otherwise
	call AICheckEnemyHalfHP
	jr nc, .discourage
	call AI_50_50
	jr c, .discourage

.encourage
	dec [hl]
	dec [hl]
	dec [hl]
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

AI_Smart_HyperBeam:
	ld a, [wEnemyMonSpecies]
	ld hl, OverdrivePokemon_AI
	call IsInByteArray
	ret c

	call CanAIKO
	jmp c, DoIt

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

AI_Smart_Counter:
	call BattleRandom
	cp 10 percent + 1
	ret c

	ld a, [wLastPlayerCounterMove]
	call AIGetEnemyMove
	ld a, [wEnemyMoveStruct + MOVE_TYPE]
	cp SPECIAL
	ret nc

rept 10
	dec [hl]
endr
	ret

AI_Smart_Encore:
; don't use if we are slower
	call DoesAIOutSpeedPlayer
	jr nc, .discourage

; don't use if we can be koed
	call ShouldAIBoost
	jr nc, .discourage

; don't use if player already encored
	ld a, [wPlayerSubStatus5]
	bit SUBSTATUS_ENCORED, a
	jr nz, .discourage

; don't use if no last move recorded
	ld a, [wLastPlayerMove]
	and a
	jmp z, AIDiscourageMove

; never encore a super effective move
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
; encore if it is an encore move, discourage otherwise
	push hl
	ld a, [wLastPlayerCounterMove]
	ld hl, EncoreMoves
	call IsInByteArray
	pop hl
	jr nc, .discourage

.encourage
	dec [hl]
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

rept 12
	dec [hl]
endr
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

; if the player can ko and is using damaging moves then encourage
; 50% chance to encourage if player can ko but isn't using damaging moves
AI_Smart_DestinyBond:
	call CanPlayerKO
	jr nc, .discourage

	call DoesEnemyHaveIntactFocusSashOrSturdy
	jr c, .discourage

	call DoesAIOutSpeedPlayer
	jr nc, .discourage

	ld a, [wCurPlayerMove]
	call AIGetPlayerMove
	ld a, [wPlayerMoveStruct + MOVE_POWER]
	and a
	jr nz, .encourage
	call AI_50_50
	jr c, .encourage

.discourage
	inc [hl]
	inc [hl]
	ret

.encourage
	dec [hl]
	dec [hl]
	ret

AI_Smart_Reversal:
; Discourage this move if enemy's HP is above 25%.

	call AICheckEnemyQuarterHP
	ret nc
	inc [hl]
	ret

AI_Smart_HealBell:
; dismiss this move if none of the enemy's pokemon are statused
; encourage this move if any of the enemy's pokemon are statused

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
	jr nz, .encourage

	ld a, [wEnemyMonStatus]
	and a
	jmp z, AIDismissMove

.encourage
	dec [hl]
	ret

AI_Smart_PriorityHit:

; commented out if needed later,
; say if foresight + mach puch/ extremespeed smart pokemon don't use it right

; never use extremespeed and mach punch against a ghost type
;	ld a, [wEnemyMoveStruct + MOVE_ANIM]
;	cp EXTREMESPEED
;	jr z, .ghostImmune
;	cp MACH_PUNCH
;	jr nz, .notGhostImmune
;.ghostImmune
;	ld a, [wBattleMonType1]
;	cp GHOST
;	jmp z, AIDiscourageMove
;	ld a, [wBattleMonType2]
;	cp GHOST
;	jmp z, AIDiscourageMove
;
;.notGhostImmune

; dismiss this move if the player is flying or underground
	ld a, [wPlayerSubStatus3]
	and 1 << SUBSTATUS_FLYING | 1 << SUBSTATUS_UNDERGROUND
	jmp nz, AIDiscourageMove

; greatly encourage this move if it will ko the player
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
	jr nc, .noKO
	dec [hl]
	dec [hl]
	dec [hl]
	dec [hl]
	dec [hl]
	ret

.noKO
; does player have priority move and are we low on hp
; if so skip speed check so we might use priority even if we are faster
	ld b, EFFECT_PRIORITY_HIT
	call PlayerHasMoveEffect
	jr nc, .speedCheck

	call AICheckEnemyQuarterHP
	jr nc, .skipSpeedCheck

.speedCheck
; if faster than the player then do nothing
	call DoesAIOutSpeedPlayer
	ret c

.skipSpeedCheck
; massive encourage if player can KO and player is attacking, unless we have sash
; this needs to overcome encouragement from other moves which do more damage and can KO
	call CanPlayerKO
	ret nc

	call DoesEnemyHaveIntactFocusSashOrSturdy
	ret c

; has player picked a damaging move, if not then don't encourage.
	ld a, [wCurPlayerMove]
	call AIGetPlayerMove
	ld a, [wPlayerMoveStruct + MOVE_POWER]
	and a
	ret z

rept 12
	dec [hl]
endr
	ret

AI_Smart_Disable:
; 90% chance to discourage this move if player is faster than enemy
; (no chance to encourage.)
	call AICompareSpeed
	jr nc, .discourage

; encourage this move if the player's last used move is in the list of useful moves
	push hl
	ld a, [wLastPlayerCounterMove]
	ld hl, UsefulMoves
	call IsInByteArray
	pop hl
	jr nc, .notencourage
	dec [hl]
	ret

; if the player's last used move was not in the useful list,
; do nothing if it was a damaging move.
.notencourage
	ld a, [wLastPlayerCounterMove]
	call AIGetMoveAttributes
	ld a, [wEnemyMoveStruct + MOVE_POWER]
	and a
	ret nz

; else, 90% chance to discourage this move
.discourage
	call AI_90_10
	ret c
	inc [hl]
	ret

AI_Smart_MeanLook:
; discourage if player is already trapped
	ld a, [wEnemySubStatus5]
	bit SUBSTATUS_CANT_RUN, a
	jr nz, .discourage

; discourage if this is the players last mon
	push hl
	call AICheckLastPlayerMon
	pop hl
	jmp z, AIDiscourageMove

; discourage if we will be koed
	call ShouldAIBoost
	jmp nz, AIDiscourageMove

; discourage if below half health
	call AICheckEnemyHalfHP
	jr nc, .discourage

; 80% chance to greatly encourage this move if the enemy is badly poisoned
; should check wplayersubstatus5 instead
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

	call IsAttackMaxed
	jr nc, .continue
	call IsDefenseMaxed
	jr c, .discourage

.continue
; if player is asleep and is physical we should boost
	ld a, [wBattleMonStatus]
	and SLP_MASK
	jr z, .noStatus
	call IsPlayerPhysicalOrSpecial
	jr c, .encourage

.noStatus
; don't use curse if player can 2HKO as we will likely take 2 hits due to the speed drop
	call CanPlayer2HKO
	jr c, .discourage

; encourage to +2 - strong encourage if player is physical
	ld a, [wEnemyAtkLevel]
	cp BASE_STAT_LEVEL + 2
    jr nc, .atPlus2
	call IsPlayerPhysicalOrSpecial
	jr nc, .special
	jr .strongEncourage
.special
	jr .encourage

.atPlus2
; discourage after boost if afflicted with toxic
	call IsAIToxified
	jr c, .discourage
	ret

.strongEncourage
    dec [hl]
.encourage
	dec [hl]
	dec [hl]
	ret

.discourage
	inc [hl]
	inc [hl]
	inc [hl]
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
	jr nz, .encourage

	jr .ghost_continue

.notlastmon
	push hl
	call AICheckLastPlayerMon
	pop hl
	jr z, .maybe_greatly_encourage

.ghost_continue
	call AICheckEnemyQuarterHP
	jr nc, .encourage

	call AICheckEnemyHalfHP
	jr nc, .encourage

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
; greatly discourage this move if the enemy already used protect
	ld a, [wCurEnemyMove]
	cp PROTECT
	jr z, .greatly_discourage

; encourage this move if the player has charged a two-turn move
	ld a, [wPlayerSubStatus3]
	bit SUBSTATUS_CHARGED, a
	jr nz, .encourage

; encourage this move if the player is affected by toxic, leech seed, or curse
	ld a, [wPlayerSubStatus5]
	bit SUBSTATUS_TOXIC, a
	jr nz, .encourage
	ld a, [wPlayerSubStatus4]
	bit SUBSTATUS_LEECH_SEED, a
	jr nz, .encourage
	ld a, [wPlayerSubStatus1]
	bit SUBSTATUS_CURSE, a
	jr nz, .encourage

; discourage if at full HP
	call AICheckEnemyMaxHP
	jr c, .discourage

; use for sure if below half HP
	call AICheckEnemyHalfHP
	jr nc, .use

; 80% chance to encourage this move otherwise.
.encourage
	call AI_80_20
	ret c
.use
	dec [hl]
	dec [hl]
	dec [hl]
	ret

.greatly_discourage
	inc [hl]
	inc [hl]
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

; 90% chance to discourage this move otherwise.
	call AI_90_10
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
	jr c, .discourage ; if this is the last enemy mon don't use

	ld a, [wPlayerSubStatus5]
	bit SUBSTATUS_CANT_RUN, a
	jr nz, .encourage ; if player is trapped then encourage

; encourage if player has only one pokemon left
	push hl
	call AICheckLastPlayerMon
	pop hl
	jr z, .encourage

; encourage this move if the player's attack levels are boosted.
	ld a, [wPlayerAtkLevel]
	cp BASE_STAT_LEVEL + 2
	jr nc, .encourage
	ld a, [wPlayerSAtkLevel]
	cp BASE_STAT_LEVEL + 2
	jr nc, .encourage

.discourage
	inc [hl]
	inc [hl]
	inc [hl]
	ret

.encourage
	dec [hl]
	ret

AI_Smart_Sandstorm:
; don't use if already sandy
	ld a, [wBattleWeather]
	cp WEATHER_SANDSTORM
	jr z, .discourage

; don't use if choice locked
	call DoesEnemyHaveChoiceItem
	jr c, .discourage

; even if we benefit from weather, don't use if we will be koed
	call DoesEnemyHaveIntactFocusSashOrSturdy
	jr c, .skipKOCheck
	call CanPlayerKO
	jr c, .discourage

; discourage if we will be koed
	call ShouldAIBoost
	jr nc, .discourage

.skipKOCheck
; encourage if enemy has sand rush ability pokemon
	ld a, [wEnemyMonSpecies]
	push hl
	ld hl, SandRushPokemon_AI
	call IsInByteArray
	pop hl
	jr c, .encourage

; encourage if enemy has sand body ability pokemon
	ld a, [wEnemyMonSpecies]
	push hl
	ld hl, SandBodyPokemon_AI
	call IsInByteArray
	pop hl
	jr c, .encourage

; encourage using the move when the weather rock is held
	ld a, [wEnemyMonItem]
	cp WEATHER_ROCK
	jr z, .encourage

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

.encourage
	dec [hl]
	dec [hl]
	dec [hl]
	ret

.SandstormImmuneTypes:
	db ROCK
	db GROUND
	db STEEL
	db -1 ; end

AI_Smart_Hail:
; don't use if already hailing
	ld a, [wBattleWeather]
	cp WEATHER_HAIL
	jr z, .discourage

; don't use if choice locked
	call DoesEnemyHaveChoiceItem
	jr c, .discourage

; even if we benefit from weather, don't use if we will be koed
	call DoesEnemyHaveIntactFocusSashOrSturdy
	jr c, .skipKOCheck
	call CanPlayerKO
	jr c, .discourage

; discourage if we will be koed
	call ShouldAIBoost
	jr nc, .discourage

.skipKOCheck
; encourage if enemy has slush rush ability pokemon
	ld a, [wEnemyMonSpecies]
	push hl
	ld hl, SlushRushPokemon_AI
	call IsInByteArray
	pop hl
	jr c, .encourage

; encourage if enemy has ice body ability pokemon
	ld a, [wEnemyMonSpecies]
	push hl
	ld hl, IceBodyPokemon_AI
	call IsInByteArray
	pop hl
	jr c, .encourage

; encourage using the move when the weather rock is held
	ld a, [wEnemyMonItem]
	cp WEATHER_ROCK
	jr z, .encourage

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
	dec [hl]
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

AI_Smart_Rollout:
; Rollout

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

AI_Smart_Swagger:
	call AI_Smart_Confuse
	; fallthrough

AI_Smart_Trick:
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
; discourage if we don't have any other mons to pass to
	push hl
	farcall FindAliveEnemyMons
	pop hl
	jr c, .discourage

; even if we benefit from passing, don't use if we will be koed
	call DoesEnemyHaveIntactFocusSashOrSturdy
	jr c, .skipKOCheck
	call CanPlayerKO
	jr c, .discourage

; discourage if we will be koed
	call ShouldAIBoost
	jr nc, .discourage

.skipKOCheck
; encourage if we have good stat boosts to pass
	ld a, [wEnemyAtkLevel]
	cp BASE_STAT_LEVEL + 2
	jr nc, .encourage
	ld a, [wEnemySAtkLevel]
	cp BASE_STAT_LEVEL + 2
	jr nc, .encourage
	ld a, [wEnemySpdLevel]
	cp BASE_STAT_LEVEL + 2
	jr nc, .encourage
	jr .discourage

.encourage
	dec [hl]
	dec [hl]
	dec [hl]
	ret

.discourage
	inc [hl]
	inc [hl]
	ret

AI_Smart_Pursuit:
; 80% chance to discourage this move if the player has only one pokemon remaining
	call AICheckLastPlayerMon
	jr z, .discourage

; 80% chance to greatly encourage this move if player's hp is below 25%
; 50% chance to discourage this move otherwise

	call AICheckPlayerQuarterHP
	jr nc, .encourage
	call AI_50_50
	ret c
	inc [hl]
	ret

.discourage
	call AI_80_20
	ret c
	inc [hl]
	ret

.encourage
	call AI_80_20
	ret c
	dec [hl]
	dec [hl]
	ret

AI_Smart_RapidSpin:
; 80% chance to greatly encourage this move if the enemy is
; trapped (Bind effect), seeded, or surrounded by field hazards

	ld a, [wEnemyWrapCount]
	and a
	jr nz, .encourage

	ld a, [wEnemySubStatus4]
	bit SUBSTATUS_LEECH_SEED, a
	jr nz, .encourage

	ld a, [wEnemyScreens]
	bit SCREENS_SPIKES, a
	jr nz, .encourage
	bit SCREENS_STEALTH_ROCK, a
	jr nz, .encourage
	bit SCREENS_TOXIC_SPIKES, a
	jr nz, .encourage
	bit SCREENS_STICKY_WEB, a
	ret z
.encourage
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
; don't use if already raining
	ld a, [wBattleWeather]
	cp WEATHER_RAIN
	jr z, .discourage

; don't use if choice locked
	call DoesEnemyHaveChoiceItem
	jr c, .discourage

; even if we benefit from weather, don't use if we will be koed
	call DoesEnemyHaveIntactFocusSashOrSturdy
	jr c, .skipKOCheck
	call CanPlayerKO
	jr c, .discourage

; discourage if we will be koed
	call ShouldAIBoost
	jr nc, .discourage

.skipKOCheck
; encourage if enemy has swift swim ability pokemon
	ld a, [wEnemyMonSpecies]
	push hl
	ld hl, SwiftSwimPokemon_AI
	call IsInByteArray
	pop hl
	jr c, .encourage

; encourage if enemy has rain dish ability pokemon
	ld a, [wEnemyMonSpecies]
	push hl
	ld hl, RainDishPokemon_AI
	call IsInByteArray
	pop hl
	jr c, .encourage

; encourage if enemy has hydration ability pokemon
	ld a, [wEnemyMonSpecies]
	push hl
	ld hl, HydrationPokemon_AI
	call IsInByteArray
	pop hl
	jr c, .encourage

; encourage using the move when the weather rock is held
	ld a, [wEnemyMonItem]
	cp WEATHER_ROCK
	jr z, .encourage

; Greatly discourage this move if it would favour the player type-wise.
; Particularly, if the player is a Water-type.
	ld a, [wBattleMonType1]
	cp WATER
	jmp z, AIBadWeatherType
	cp FIRE
	jmp z, AIGoodWeatherType

	ld a, [wBattleMonType2]
	cp WATER
	jmp z, AIBadWeatherType
	cp FIRE
	jmp z, AIGoodWeatherType

	push hl
	ld hl, RainDanceMoves
	jr AI_Smart_WeatherMove

.encourage
	dec [hl]
	dec [hl]
	dec [hl]
	ret

.discourage
	inc [hl]
	inc [hl]
	inc [hl]
	ret

INCLUDE "data/battle/ai/rain_dance_moves.asm"

AI_Smart_SunnyDay:
; don't use if already sunny
	ld a, [wBattleWeather]
	cp WEATHER_SUN
	jr z, .discourage

; don't use if choice locked
	call DoesEnemyHaveChoiceItem
	jr c, .discourage

; even if we benefit from weather, don't use if we will be koed
	call DoesEnemyHaveIntactFocusSashOrSturdy
	jr c, .skipKOCheck
	call CanPlayerKO
	jr c, .discourage

; discourage if we will be koed
	call ShouldAIBoost
	jr nc, .discourage

.skipKOCheck
; encourage if enemy has chlorophyll ability pokemon
	ld a, [wEnemyMonSpecies]
	push hl
	ld hl, ChlorophyllPokemon_AI
	call IsInByteArray
	pop hl
	jr c, .encourage

; encourage if enemy has solar power ability pokemon
	ld a, [wEnemyMonSpecies]
	push hl
	ld hl, SolarPowerPokemon_AI
	call IsInByteArray
	pop hl
	jr c, .encourage

; encourage using the move when the weather rock is held
	ld a, [wEnemyMonItem]
	cp WEATHER_ROCK
	jr z, .encourage

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
	jr AI_Smart_WeatherMove

.encourage
	dec [hl]
	dec [hl]
	dec [hl]
	ret

.discourage
	inc [hl]
	inc [hl]
	inc [hl]
	ret

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
; don't use if already at +2
	ld a, [wEnemyAtkLevel]
	cp BASE_STAT_LEVEL + 2
	jr nc, .discourage

; don't use if enemy behind a sub
	ld a, [wPlayerSubStatus4]
	bit SUBSTATUS_SUBSTITUTE, a	;check for substitute bit
	jr nz, .discourage

; are we faster
	call DoesAIOutSpeedPlayer
	jr nc, .slower

; we are faster
; if we are full HP and player can't 2HKO then encourage
	call AICheckEnemyMaxHP
	jr nc, .slower
	call CanPlayer2HKO
	jmp nc, StandardEncourage

.slower
; if we are above half HP and player can't 3HKO then encourage
	call AICheckEnemyHalfHP
	jr nc, .discourage
	call CanPlayer3HKOMaxHP
	jmp nc, StandardEncourage

.discourage
	jmp StandardDiscourage

AI_Smart_MirrorCoat:
	call BattleRandom
	cp 10 percent + 1
	ret c

	ld a, [wLastPlayerCounterMove]
	call AIGetEnemyMove
	ld a, [wEnemyMoveStruct + MOVE_TYPE]
	cp SPECIAL
	ret c

rept 10
	dec [hl]
endr
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
; 80% chance to encourage this move when it's raining
; 90% chance to discourage this move when it's sunny

	ld a, [wBattleWeather]
	cp WEATHER_RAIN
	jr z, .encourage

	cp WEATHER_SUN
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
