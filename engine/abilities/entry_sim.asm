; ==============================================
; === AI: entry abilities in the matchup sim ===
; ==============================================
; The AI's 1-on-1 simulation (engine/battle/ai/matchup.asm) loads a benched
; mon into wEnemyMon to play out "what if it came in now". MSim_EntryEffects
; then does to the field what that mon's entry ability would do as it comes
; in, so the AI values its switch-ins (and the mon it sends in after a KO)
; with them: Intimidate against a physical sweeper, Fog of War against a
; boosted one, Drizzle against a Fire type, Neutralizing Gas against an
; ability that walls it, and so on. MSim_LoadCandidate first puts back the
; real field (MSim_RestoreField), and MSim_End does too.
;
; Simulated (in the order the abilities go off):
; - Neutralizing Gas: worked out for the pair (it can also switch off the
;   candidate's own ability, or the player's);
; - weather (Drizzle, Drought, Sand Stream, Snow Warning) for good;
; - Natural Cure: no status;
; - Seedfall: Leech Seed on the player's mon;
; - stat stages: Defense Mode, Fortify, Battle Stance, Battle Drive,
;   Download (its own); Intimidate, Stifling Aura, Infernal Howl (the
;   player's: not through a Substitute, Resilience, and not Intimidate on
;   Scrappy / Oblivious; Contrary turns them around); Fog of War (resets
;   the player's raised stats);
; - Clean Sweep (weather and screens gone), Light / Reflect Barrier,
;   Siegebreaker (the player's screens gone), Chrono Shift (Trick Room);
; - True Sight (Foresight), Disarm (the player's item knocked off: +1 Speed
;   for an Unburden mon).
; - Provocateur (Taunt: the player's heal moves don't count), Allure
;   (infatuated: the player's hits count half), Imposter (a copy of the
;   player's mon: species, moves, types, stats and stat stages).
; Chaotic Boost's stat is random: MSim_TryCandidate counts it as a small
; bonus instead (IsChaoticBoostActive_Far).
; Not simulated: hazard layers (they don't matter in a 1-on-1), Sanctuary.

DEF MSIM_ATK EQU 0 ; (wPlayerStatLevels / wEnemyStatLevels offsets)
DEF MSIM_DEF EQU 1
DEF MSIM_SPD EQU 2
DEF MSIM_SAT EQU 3
DEF MSIM_SDF EQU 4

MSim_EntryEffects::
; (before MSim_LoadCandidate works out the candidate's stats)
	; Neutralizing Gas for this pair (as UpdateNeutralizingGas)
	ld a, [wBattleMonSpecies]
	newfarcall IsNeutralizingGasSpecies
	sbc a
	and %10 ; the player's gas suppresses the enemy
	ld b, a
	ld a, [wEnemyMonSpecies]
	newfarcall IsNeutralizingGasSpecies
	sbc a
	and %01 ; the enemy's suppresses the player
	or b
	cp %11
	jr nz, .got_gas
	xor a ; both: they cancel out
.got_gas
	ld [wNeutralizingGas], a
	and %10
	ret nz ; the candidate's ability is suppressed: nothing happens

	xor a
	ld [wMSimEntryPlayerStats], a

	; weather
	ld hl, DrizzlePokemon
	ld b, WEATHER_RAIN
	call .weather
	ld hl, DroughtPokemon
	ld b, WEATHER_SUN
	call .weather
	ld hl, SandStreamPokemon
	ld b, WEATHER_SANDSTORM
	call .weather
	ld hl, SnowWarningPokemon
	ld b, WEATHER_HAIL
	call .weather

	; Natural Cure
	ld hl, NaturalCurePokemon
	call .has
	jr nc, .no_cure
	xor a
	ld [wEnemyMonStatus], a
.no_cure

	; Seedfall
	ld hl, SeedfallPokemon
	call .has
	jr nc, .no_seed
	ld a, [wBattleMonType1]
	cp GRASS
	jr z, .no_seed
	ld a, [wBattleMonType2]
	cp GRASS
	jr z, .no_seed
	ld hl, wPlayerSubStatus4
	set SUBSTATUS_LEECH_SEED, [hl]
.no_seed

	; its own stats
	ld hl, DefenseModePokemon
	call .has
	jr nc, .no_defense_mode
	lb bc, MSIM_DEF, 2
	call .raise_own
	lb bc, MSIM_SDF, 2
	call .raise_own
.no_defense_mode
	ld hl, FortifyPokemon
	call .has
	jr nc, .no_fortify
	lb bc, MSIM_DEF, 1
	call .raise_own
	lb bc, MSIM_SDF, 1
	call .raise_own
.no_fortify
	ld hl, BattleStancePokemon
	call .has
	lb bc, MSIM_DEF, 1
	call c, .raise_own
	ld hl, BattleDrivePokemon
	call .has
	lb bc, MSIM_ATK, 1
	call c, .raise_own
	ld hl, DownloadPokemon
	call .has
	jr nc, .no_download
	; Attack if the foe's Defense is lower than its Sp. Def, else Sp. Atk
	ld hl, wBattleMonDefense + 1
	ld a, [wBattleMonSpclDef + 1]
	ld c, a
	ld a, [hld]
	sub c
	ld a, [wBattleMonSpclDef]
	ld c, a
	ld a, [hl]
	sbc c
	lb bc, MSIM_ATK, 1
	jr c, .download
	ld b, MSIM_SAT
.download
	call .raise_own
.no_download

	; the player's stats
	ld hl, IntimidatePokemon
	call .has
	jr nc, .no_intimidate
	ld a, [wBattleMonSpecies]
	push af
	call IsSpeciesSuppressed
	jr c, .intimidate_works
	newfarcall IsScrappySpecies
	jr c, .intimidate_blocked
.intimidate_works
	pop af
	newfarcall IsObliviousSpecies
	lb bc, MSIM_ATK, 1
	call nc, .lower_player
	jr .no_intimidate
.intimidate_blocked
	pop af
.no_intimidate
	ld hl, StiflingAuraPokemon
	call .has
	lb bc, MSIM_SPD, 1
	call c, .lower_player
	ld hl, InfernalHowlPokemon
	call .has
	lb bc, MSIM_SAT, 1
	call c, .lower_player

	; the field
	ld hl, CleanSweepPokemon
	call .has
	jr nc, .no_clean_sweep
	xor a ; WEATHER_NONE
	ld [wBattleWeather], a
	ld [wWeatherCount], a
	ld hl, wPlayerScreens
	res SCREENS_REFLECT, [hl]
	res SCREENS_LIGHT_SCREEN, [hl]
	ld hl, wEnemyScreens
	res SCREENS_REFLECT, [hl]
	res SCREENS_LIGHT_SCREEN, [hl]
.no_clean_sweep
	ld hl, LightBarrierPokemon
	call .has
	jr nc, .no_light_barrier
	ld hl, wEnemyScreens
	bit SCREENS_LIGHT_SCREEN, [hl]
	jr nz, .no_light_barrier
	set SCREENS_LIGHT_SCREEN, [hl]
	ld a, 5
	ld [wEnemyLightScreenCount], a
.no_light_barrier
	ld hl, ChronoShiftPokemon
	call .has
	jr nc, .no_chrono_shift
	ld a, [wTrickRoomCount]
	and a
	jr nz, .no_chrono_shift
	ld a, 5
	ld [wTrickRoomCount], a
.no_chrono_shift
	ld hl, ReflectBarrierPokemon
	call .has
	jr nc, .no_reflect_barrier
	ld hl, wEnemyScreens
	bit SCREENS_REFLECT, [hl]
	jr nz, .no_reflect_barrier
	set SCREENS_REFLECT, [hl]
	ld a, 5
	ld [wEnemyReflectCount], a
.no_reflect_barrier
	ld hl, TrueSightPokemon
	call .has
	jr nc, .no_true_sight
	ld hl, wPlayerSubStatus1
	set SUBSTATUS_IDENTIFIED, [hl]
.no_true_sight
	ld hl, FogOfWarPokemon
	call .has
	jr nc, .no_fog
	ld hl, wPlayerStatLevels
	ld b, wPlayerEvaLevel - wPlayerAtkLevel + 1
.fog_check
	ld a, [hli]
	cp BASE_STAT_LEVEL + 1
	jr nc, .fog
	dec b
	jr nz, .fog_check
	jr .no_fog
.fog
	; Haze: the player's stats back to normal (the candidate's are, as it
	; only just came in)
	ld hl, wPlayerStatLevels
	ld a, BASE_STAT_LEVEL
	ld bc, wPlayerEvaLevel - wPlayerAtkLevel + 1
	call ByteFill
	ld a, 1
	ld [wMSimEntryPlayerStats], a
.no_fog
	ld hl, SiegebreakerPokemon
	call .has
	jr nc, .no_siegebreaker
	ld hl, wPlayerScreens
	res SCREENS_REFLECT, [hl]
	res SCREENS_LIGHT_SCREEN, [hl]
.no_siegebreaker
	ld hl, DisarmPokemon
	call .has
	jr nc, .no_disarm
	ld a, [wBattleMonItem]
	and a
	jr z, .no_disarm
	xor a
	ld [wBattleMonItem], a
	; Unburden: losing it makes the player's mon faster
	ld a, [wBattleMonSpecies]
	newfarcall IsUnburdenSpecies
	jr nc, .no_disarm
	ld hl, wPlayerStatLevels
	lb bc, MSIM_SPD, 1
	call MSim_RaiseLevel
	ld a, 1
	ld [wMSimEntryPlayerStats], a
.no_disarm

	; Provocateur: Taunt (the player's mon can't use its heal moves)
	ld hl, ProvocateurPokemon
	call .has
	jr nc, .no_provocateur
	ld a, [wPlayerTauntCount]
	and a
	jr nz, .no_provocateur
	ld a, 3
	ld [wPlayerTauntCount], a
.no_provocateur
	; Allure: infatuates a mon of the opposite gender (not Oblivious)
	ld hl, AllurePokemon
	call .has
	call c, .allure
	; Imposter: it becomes a copy of the player's mon (last: from here on
	; its species is the player's)
	ld hl, ImposterPokemon
	call .has
	call c, .imposter

	; the player's stats with their new stages
	ld a, [wMSimEntryPlayerStats]
	and a
	ret z
	xor a
	ldh [hBattleTurn], a
	farjp CalcPlayerStats

.allure
	ld a, [wBattleMonSpecies]
	newfarcall IsObliviousSpecies
	ret c
	; CheckOppositeGender compares the player's mon with wTempEnemyMonSpecies
	; and wEnemyMonDVs: the candidate's for a moment
	ld a, [wTempEnemyMonSpecies]
	push af
	ld a, [wEnemyMonSpecies]
	ld [wTempEnemyMonSpecies], a
	xor a
	ldh [hBattleTurn], a
	farcall CheckOppositeGender
	pop bc
	ld a, b
	ld [wTempEnemyMonSpecies], a
	ret c
	ld hl, wPlayerSubStatus1
	set SUBSTATUS_IN_LOVE, [hl]
	ret

.imposter
	; species, moves (with PP), DVs, types, stats and stat stages
	ld a, [wBattleMonSpecies]
	ld [wEnemyMonSpecies], a
	ld hl, wBattleMonMoves
	ld de, wEnemyMonMoves
	ld bc, NUM_MOVES
	call CopyBytes
	ld hl, wEnemyMonPP
	ld a, 5
	ld bc, NUM_MOVES
	call ByteFill
	ld a, [wBattleMonDVs]
	ld [wEnemyMonDVs], a
	ld a, [wBattleMonDVs + 1]
	ld [wEnemyMonDVs + 1], a
	ld a, [wBattleMonType1]
	ld [wEnemyMonType1], a
	ld a, [wBattleMonType2]
	ld [wEnemyMonType2], a
	ld hl, wPlayerStats
	ld de, wEnemyStats
	ld bc, NUM_BATTLE_STATS * 2
	call CopyBytes
	ld hl, wPlayerStatLevels
	ld de, wEnemyStatLevels
	ld bc, wPlayerEvaLevel - wPlayerAtkLevel + 1
	call CopyBytes
	ld hl, wEnemySubStatus5
	set SUBSTATUS_TRANSFORMED, [hl]
	ret


.has
; Carry if the candidate is in ability list hl.
	ld a, [wEnemyMonSpecies]
	jmp IsInAbilityList

.weather
; Weather b if the candidate is in list hl (for good, as SetEntryWeather).
	push bc
	call .has
	pop bc
	ret nc
	ld a, b
	ld [wBattleWeather], a
	ld a, 255
	ld [wWeatherCount], a
	ret

.raise_own
; Raise the candidate's stat b by c stages (lowered if it has Contrary).
	ld a, [wEnemyMonSpecies]
	newfarcall IsContrarySpecies
	ld hl, wEnemyStatLevels
	jr nc, MSim_RaiseLevel
	jr MSim_LowerLevel

.lower_player
; Lower the player's stat b by c stages (raised if it has Contrary), unless
; it's behind a Substitute or has Resilience.
	ld a, [wPlayerSubStatus4]
	bit SUBSTATUS_SUBSTITUTE, a
	ret nz
	ld a, [wBattleMonSpecies]
	push bc
	ld hl, ResiliencePokemon
	ld d, BANK(ResiliencePokemon)
	call MSim_FarAbilityList
	pop bc
	ret c
	ld a, 1
	ld [wMSimEntryPlayerStats], a
	ld a, [wBattleMonSpecies]
	newfarcall IsContrarySpecies
	ld hl, wPlayerStatLevels
	jr c, MSim_RaiseLevel
	; fallthrough

MSim_LowerLevel:
; Stat level b at hl -= c (not below 1).
	ld a, l
	add b
	ld l, a
	adc h
	sub l
	ld h, a
	ld a, [hl]
	sub c
	jr c, .min
	jr nz, .ok
.min
	ld a, 1
.ok
	ld [hl], a
	ret

MSim_RaiseLevel:
; Stat level b at hl += c (not above MAX_STAT_LEVEL).
	ld a, l
	add b
	ld l, a
	adc h
	sub l
	ld h, a
	ld a, [hl]
	add c
	cp MAX_STAT_LEVEL + 1
	jr c, .ok
	ld a, MAX_STAT_LEVEL
.ok
	ld [hl], a
	ret

MSim_FarAbilityList:
; Carry if species a is in the $ff-terminated ability list d:hl (and its
; ability isn't suppressed by Neutralizing Gas). Preserves d.
	call IsSpeciesSuppressed
	ccf
	ret nc
	ld c, a
.loop
	ld a, d
	call GetFarByte
	inc hl
	cp -1
	ret z ; (no carry)
	cp c
	jr nz, .loop
	scf
	ret

IsChaoticBoostActive_Far::
; Carry if species a has Chaotic Boost and Neutralizing Gas doesn't suppress
; it (for the AI: a random +1 as it comes in). Preserves bc, de, hl.
	push hl
	push de
	push bc
	ld hl, ChaoticBoostPokemon
	call IsInAbilityList
	jmp PopBCDEHL
