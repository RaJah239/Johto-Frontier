AI_UseSpeedBoostBeforeKO:
; Called from NormalizeAIMoveScores after the scoring layers.
; If the enemy can KO the player's mon this turn but is slower, survives the
; player's hit this turn, and has a usable move that raises its Speed enough
; to outspeed the player's mon, make that move the clear pick. It boosts now
; and KOs next turn, and stays faster than whatever the player sends in next.
; Speed boosters: Agility (+2), Dragon Dance, Quiver Dance, Flame Charge (+1).
; Weather moves count too: Rain Dance / Sunny Day / Sandstorm / Hail when the
; enemy has Swift Swim / Chlorophyll / Sand Rush / Slush Rush, since those
; abilities make it move first in their weather (see AI_WeatherMoveHelps).
; Exception: if a priority move (e.g. ExtremeSpeed) KOs right now even at its
; lowest roll, that move is picked instead.

	; locked into one move (choice item or Encore): nothing to choose
	ld a, [wEnemySubStatus5]
	bit SUBSTATUS_ENCORED, a
	ret nz

	; must be able to KO the player's mon now...
	farcall CanAIKO
	ret nc
	; ...while being slower...
	farcall DoesAIOutSpeedPlayer
	ret c
	; a priority move that KOs right now beats boosting (and beats being hit
	; first): use it
	call AI_HasPriorityKO
	jr nc, .no_priority_ko
	ld hl, wEnemyAIMoveScores
	ld b, 0
	add hl, bc
	ld [hl], $e0
	ret

.no_priority_ko
	; ...and survive the player's hit while boosting
	farcall CanPlayerKO
	ret c

	ld c, 0 ; move slot
.loop
	ld a, c
	cp NUM_MOVES
	ret z
	ld hl, wEnemyMonMoves
	ld b, 0
	add hl, bc
	ld a, [hl]
	and a
	ret z ; no more moves

	; skip disabled moves and moves with no PP
	ld b, a
	ld a, [wEnemyDisabledMove]
	cp b
	jr z, .next
	ld hl, wEnemyMonPP
	ld a, l
	add c
	ld l, a
	adc h
	sub l
	ld h, a
	ld a, [hl]
	and PP_MASK
	jr z, .next

	; how many Speed stages does it add?
	push bc
	ld a, b
	dec a
	ld hl, Moves + MOVE_EFFECT
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld a, BANK(Moves)
	call GetFarByte
	pop bc
	; a weather move that turns on the enemy's weather speed ability?
	call AI_WeatherMoveHelps
	jr c, .pick
	ld b, 2
	cp EFFECT_SPEED_UP_2
	jr z, .speed_move
	ld b, 1
	cp EFFECT_SPEED_UP
	jr z, .speed_move
	cp EFFECT_SPEED_UP_HIT
	jr z, .speed_move
	cp EFFECT_DRAGON_DANCE
	jr z, .speed_move
	cp EFFECT_QUIVER_DANCE
	jr nz, .next

.speed_move
	push bc
	call AI_FasterAfterSpeedBoost
	pop bc
	jr nc, .next

.pick
	; boost first: the lowest score there is (NormalizeAIMoveScores reads
	; $e0 as -32)
	ld hl, wEnemyAIMoveScores
	ld b, 0
	add hl, bc
	ld [hl], $e0
	ret

.next
	inc c
	jr .loop

AI_HasPriorityKO:
; Return carry and the move slot in c if the enemy has a usable damaging move
; with above-normal priority (GetMovePriority, e.g. ExtremeSpeed) that KOs
; the player's mon even at its lowest damage roll (AI_MinRollKOsPlayer).
	ld c, 0 ; move slot
.loop
	ld a, c
	cp NUM_MOVES
	jr z, .no
	ld hl, wEnemyMonMoves
	ld b, 0
	add hl, bc
	ld a, [hl]
	and a
	jr z, .no

	; skip disabled moves and moves with no PP
	ld b, a
	ld a, [wEnemyDisabledMove]
	cp b
	jr z, .next
	ld hl, wEnemyMonPP
	ld a, l
	add c
	ld l, a
	adc h
	sub l
	ld h, a
	ld a, [hl]
	and PP_MASK
	jr z, .next

	; priority above normal?
	push bc
	ld a, [wEnemyMonItem]
	ld c, a
	farcall GetMovePriority_Far
	ld a, b
	pop bc
	cp BASE_PRIORITY + 1
	jr c, .next

	; does it KO at its lowest roll?
	push bc
	ld a, b
	dec a
	ld hl, Moves
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld de, wEnemyMoveStruct
	ld a, BANK(Moves)
	call FarCopyBytes
	ld a, [wEnemyMoveStruct + MOVE_POWER]
	and a
	jr z, .pop_next
	ld a, 1
	ldh [hBattleTurn], a
	callfar EnemyAttackDamage
	callfar BattleCommand_DamageCalc
	callfar BattleCommand_Stab
	farcall AI_MinRollKOsPlayer
	jr c, .pop_yes
.pop_next
	pop bc
.next
	inc c
	jr .loop

.pop_yes
	pop bc
	scf
	ret

.no
	and a
	ret

AI_FasterAfterSpeedBoost:
; b = Speed stages the move adds. Return carry if, with those stages, the
; enemy would outspeed the player's mon (DoesAIOutSpeedPlayer). Uses the
; engine's own stat calculation and restores everything afterwards.
	ld a, [wEnemySpdLevel]
	cp MAX_STAT_LEVEL
	ret nc ; already maxed (carry is clear)
	push af
	add b
	cp MAX_STAT_LEVEL + 1
	jr c, .got_level
	ld a, MAX_STAT_LEVEL
.got_level
	ld [wEnemySpdLevel], a

	; save the enemy's current battle stats
	ld hl, wEnemyMonAttack
	ld b, NUM_BATTLE_STATS
.save
	ld a, [hli]
	ld d, a
	ld a, [hli]
	ld e, a
	push de
	dec b
	jr nz, .save

	ldh a, [hBattleTurn]
	push af
	ld a, 1
	ldh [hBattleTurn], a
	farcall CalcEnemyStats
	farcall DoesAIOutSpeedPlayer
	ld a, 0
	rla
	ld c, a ; 1 if faster
	pop af
	ldh [hBattleTurn], a

	; restore them
	ld hl, wEnemyMonAttack + NUM_BATTLE_STATS * 2 - 1
	ld b, NUM_BATTLE_STATS
.restore
	pop de
	ld a, e
	ld [hld], a
	ld a, d
	ld [hld], a
	dec b
	jr nz, .restore

	pop af
	ld [wEnemySpdLevel], a
	ld a, c
	rra
	ret

AI_WeatherMoveHelps:
; a = move effect. Return carry if it's a weather move whose weather turns on
; the enemy's weather speed ability (Rain Dance + Swift Swim, Sunny Day +
; Chlorophyll, Sandstorm + Sand Rush, Hail + Slush Rush), so the enemy moves
; first from next turn, and it can still KO the player's mon in that weather.
; Follows the engine's rules for these abilities (DetermineMoveOrder): the
; weather isn't already up, the player's mon doesn't have the same ability,
; the enemy isn't paralyzed or at -2 Speed or lower, the player's mon isn't at
; +2 Speed or higher, and Trick Room isn't active.
; Uses the real ability lists (data/abilities/*_mons.asm).
; Preserves a and bc.
	push bc
	push af
	call .check
	jr c, .yes
	pop af
	pop bc
	and a
	ret

.yes
	pop af
	pop bc
	scf
	ret

.check
	ld b, WEATHER_RAIN
	ld hl, SwiftSwimPokemon
	cp EFFECT_RAIN_DANCE
	jr z, .got_weather
	ld b, WEATHER_SUN
	ld hl, ChlorophyllPokemon
	cp EFFECT_SUNNY_DAY
	jr z, .got_weather
	ld b, WEATHER_SANDSTORM
	ld hl, SandRushPokemon
	cp EFFECT_SANDSTORM
	jr z, .got_weather
	ld b, WEATHER_HAIL
	ld hl, SlushRushPokemon
	cp EFFECT_HAIL
	jr z, .got_weather
	and a
	ret

.got_weather
	ld a, [wBattleWeather]
	cp b
	jr z, .no ; already up

	; the enemy has the ability and the player's mon doesn't
	ld a, [wEnemyMonSpecies]
	call .InAbilityList
	jr nc, .no
	ld a, [wBattleMonSpecies]
	call .InAbilityList
	jr c, .no

	ld a, [wEnemyMonStatus]
	and 1 << PAR
	jr nz, .no
	ld a, [wPlayerSpdLevel]
	cp BASE_STAT_LEVEL + 2
	jr nc, .no
	ld a, [wEnemySpdLevel]
	cp BASE_STAT_LEVEL - 1
	jr c, .no
	ld a, [wBattleType]
	cp BATTLETYPE_TRICK_ROOM
	jr z, .no
	ld a, [wTrickRoomCount]
	and a
	jr nz, .no

	; still a KO once the weather changes? (rain / sun change damage)
	ld a, [wBattleWeather]
	ld c, a
	ld a, b
	ld [wBattleWeather], a
	push bc
	farcall CanAIKO
	pop bc ; flags untouched
	ld a, c
	ld [wBattleWeather], a
	ret

.no
	and a
	ret

.InAbilityList:
; a = species, hl = ability list. Return carry if listed. Preserves bc, hl.
	push hl
	ld e, a
.list_loop
	ld a, BANK(SwiftSwimPokemon)
	call GetFarByte
	inc hl
	cp -1
	jr z, .not_listed
	cp e
	jr nz, .list_loop
	pop hl
	scf
	ret

.not_listed
	pop hl
	and a
	ret

	assert BANK(SwiftSwimPokemon) == BANK(ChlorophyllPokemon) && \
		BANK(SwiftSwimPokemon) == BANK(SandRushPokemon) && \
		BANK(SwiftSwimPokemon) == BANK(SlushRushPokemon), \
		"weather speed ability lists must share a bank"
