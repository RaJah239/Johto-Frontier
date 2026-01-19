; ==============
; === Note 1 ===
; ==============

; these abilties work correctly
; switch in battle and immediately use its effect
EntryAbilities1:
	call HandleSpinGuard
	call HandleDrizzle
	call HandleDrought
	call HandleSandStream
	call HandleSnowWarning
	call HandleNaturalCure
	call HandleSeedfall
	ret

; ==============
; === Note 2 ===
; ==============

; these abilities work at the start of turn 1
; so if a mon was switched in mid-battle,
; the foe will get their move off and even ko'd
; before this ability triggers
EntryAbilities2:
	call HandleCleanSweep
	call HandleLightBarrier
	call HandleIntimidate
	call HandleRockSnare
	call HandleCaltropper
	call HandleVenomField
	call HandleSilkSnare
	call HandleChronoShift
	call HandleFortify
	call HandleImposter
	call HandleReflectBarrier
	call HandleInfernalHowl
	call HandleBattleStance
	call HandleBattleDrive
	call HandleTrueSight
	call HandleFogOfWar
	call HandleChaoticBoost
	call HandleSanctuary
	call HandleSiegebreaker
	call HandleProvocateur
	call HandleDisarm
	call HandleAllure
	ret

ResetVolatileAbilityPlayer:
	ResetEventFlag EVENT_REFLECT_BARRIER_PLAYER
	ResetEventFlag EVENT_LIGHT_BARRIER_PLAYER
	ResetEventFlag EVENT_INTIMIDATE_PLAYER
	ResetEventFlag EVENT_ROCK_SNARE_PLAYER
	ResetEventFlag EVENT_CALTROPPER_PLAYER
	ResetEventFlag EVENT_VENOM_FIELD_PLAYER
	ResetEventFlag EVENT_SILK_SNARE_PLAYER
	ResetEventFlag EVENT_CHRONO_SHIFT_PLAYER
	ResetEventFlag EVENT_FORTIFY_PLAYER
	ResetEventFlag EVENT_IMPOSTER_PLAYER
	ResetEventFlag EVENT_INFERNAL_HOWL_PLAYER
	ResetEventFlag EVENT_BATTLE_STANCE_PLAYER
	ResetEventFlag EVENT_BATTLE_DRIVE_PLAYER
	ResetEventFlag EVENT_TRUE_SIGHT_PLAYER
	ResetEventFlag EVENT_FOG_OF_WAR_PLAYER
	ResetEventFlag EVENT_DEFOG_PLAYER
	ResetEventFlag EVENT_CHAOTIC_BOOST_PLAYER
	ResetEventFlag EVENT_SANCTUARY_PLAYER
	ResetEventFlag EVENT_SIEGEBREAKER_PLAYER
	ResetEventFlag EVENT_PROVOCATEUR_PLAYER
	ResetEventFlag EVENT_DISARM_PLAYER
	ResetEventFlag EVENT_ALLURE_PLAYER
	ret

ResetVolatileAbilityFoe:
	ResetEventFlag EVENT_REFLECT_BARRIER_FOE
	ResetEventFlag EVENT_LIGHT_BARRIER_FOE
	ResetEventFlag EVENT_INTIMIDATE_FOE
	ResetEventFlag EVENT_ROCK_SNARE_FOE
	ResetEventFlag EVENT_CALTROPPER_FOE
	ResetEventFlag EVENT_VENOM_FIELD_FOE
	ResetEventFlag EVENT_SILK_SNARE_FOE
	ResetEventFlag EVENT_CHRONO_SHIFT_FOE
	ResetEventFlag EVENT_FORTIFY_FOE
	ResetEventFlag EVENT_IMPOSTER_FOE
	ResetEventFlag EVENT_INFERNAL_HOWL_FOE
	ResetEventFlag EVENT_BATTLE_STANCE_FOE
	ResetEventFlag EVENT_BATTLE_DRIVE_FOE
	ResetEventFlag EVENT_TRUE_SIGHT_FOE
	ResetEventFlag EVENT_FOG_OF_WAR_FOE
	ResetEventFlag EVENT_DEFOG_FOE
	ResetEventFlag EVENT_CHAOTIC_BOOST_FOE
	ResetEventFlag EVENT_SANCTUARY_FOE
	ResetEventFlag EVENT_SIEGEBREAKER_FOE
	ResetEventFlag EVENT_PROVOCATEUR_FOE
	ResetEventFlag EVENT_DISARM_FOE
	ResetEventFlag EVENT_ALLURE_FOE
	ret

; ========================
; === EntryAbilities 1 ===
; ========================

HandleDrizzle:
	; check if switched in pokemon has drizzle
	call GetCurrentMon
	ld hl, DrizzlePokemon
	call IsInByteArray
	ret nc

	; if it is raining, don't activate
    ld a, [wBattleWeather]
    cp WEATHER_RAIN
    ret z

    ; Set up rain for 255 turns
	ld a, WEATHER_RAIN
	ld [wBattleWeather], a
	ld a, 255
	ld [wWeatherCount], a

	ld hl, BattleText_DrizzleText
	jmp StdBattleTextbox

INCLUDE "data/abilities/drizzle_mons.asm"

HandleDrought:
	; check if switched in pokemon has drought
	call GetCurrentMon
	ld hl, DroughtPokemon
	call IsInByteArray
	ret nc

	; if sun is up, don't activate
    ld a, [wBattleWeather]
    cp WEATHER_SUN
    ret z

    ; Set up sun for 255 turns
	ld a, WEATHER_SUN
	ld [wBattleWeather], a
	ld a, 255
	ld [wWeatherCount], a

	ld hl, BattleText_DroughtText
	jmp StdBattleTextbox

INCLUDE "data/abilities/drought_mons.asm"

HandleSandStream:
	; check if switched in pokemon has sand stream
	call GetCurrentMon
	ld hl, SandStreamPokemon
	call IsInByteArray
	ret nc

	; if sand storm is up, don't activate
    ld a, [wBattleWeather]
    cp WEATHER_SANDSTORM
    ret z

    ; Set up sand for 255 turns
	ld a, WEATHER_SANDSTORM
	ld [wBattleWeather], a
	ld a, 255
	ld [wWeatherCount], a

	ld hl, BattleText_SandStreamText
	jmp StdBattleTextbox

INCLUDE "data/abilities/sand_stream_mons.asm"

HandleSnowWarning:
	; check if switched in pokemon has snow warning
	call GetCurrentMon
	ld hl, SnowWarningPokemon
	call IsInByteArray
	ret nc

	; if hail is up, don't activate
    ld a, [wBattleWeather]
    cp WEATHER_HAIL
    ret z

    ; Set up hail for 255 turns
	ld a, WEATHER_HAIL
	ld [wBattleWeather], a
	ld a, 255
	ld [wWeatherCount], a

	ld hl, BattleText_SnowWarningText
	jmp StdBattleTextbox

INCLUDE "data/abilities/snow_warning_mons.asm"

HandleNaturalCure:
	; check if switched in pokemon has natural cure
	call GetCurrentMon
	ld hl, NaturalCurePokemon
	call IsInByteArray
	ret nc

	call DoNaturalCure
	farjp CalcPokemonStats

DoNaturalCure:
	ld a, BATTLE_VARS_STATUS
	call GetBattleVarAddr
	and a
	ret z
	xor a
	ld [hl], a
	farcall SwitchTurnCore
	farcall ItemRecoveryAnim
	farcall SwitchTurnCore
	ld hl, BecameHealthyText
	jmp StdBattleTextbox

INCLUDE "data/abilities/natural_cure_mons.asm"

; ========================
; === EntryAbilities 2 ===
; ========================

HandleReflectBarrier:
	ldh a, [hSerialConnectionStatus]
	cp USING_EXTERNAL_CLOCK
	jr z, .reverse

	call .player
	jr .enemy

.reverse
	call .enemy
	; fallthrough

.player
	CheckEventFlag EVENT_REFLECT_BARRIER_PLAYER
	ret nz
	SetEventFlag EVENT_REFLECT_BARRIER_PLAYER

	call SetPlayerTurn
	jr .do_check

.enemy
	CheckEventFlag EVENT_REFLECT_BARRIER_FOE
	ret nz
	SetEventFlag EVENT_REFLECT_BARRIER_FOE

	call SetEnemyTurn
	; fallthrough

.do_check
	; check if current pokemon has reflect barrier
	call GetCurrentMon
	ld hl, ReflectBarrierPokemon
	call IsInByteArray
	ret nc

	; select correct screen + counter
	ld hl, wPlayerScreens
	ld bc, wPlayerReflectCount
	ldh a, [hBattleTurn]
	and a
	jr z, .got_pointers
	ld hl, wEnemyScreens
	ld bc, wEnemyReflectCount

.got_pointers
	; don't reapply if Reflect already up
	bit SCREENS_REFLECT, [hl]
	ret nz

	; set Reflect for 5 turns
	set SCREENS_REFLECT, [hl]
	ld a, 5
	ld [bc], a

	; don't play damage effect when animation goes off
	xor a
	ld [wNumHits], a
	call Call_PlayBattleAnim_OnlyIfVisible

	; play reflect animation
	ld de, REFLECT
	farcall Call_PlayBattleAnim

	ld hl, ReflectBarrierText
	jmp StdBattleTextbox

INCLUDE "data/abilities/reflect_barrier_mons.asm"

HandleLightBarrier:
	ldh a, [hSerialConnectionStatus]
	cp USING_EXTERNAL_CLOCK
	jr z, .reverse

	call .player
	jr .enemy

.reverse
	call .enemy
	; fallthrough

.player
	CheckEventFlag EVENT_LIGHT_BARRIER_PLAYER
	ret nz
	SetEventFlag EVENT_LIGHT_BARRIER_PLAYER

	call SetPlayerTurn
	jr .do_check

.enemy
	CheckEventFlag EVENT_LIGHT_BARRIER_FOE
	ret nz
	SetEventFlag EVENT_LIGHT_BARRIER_FOE

	call SetEnemyTurn
	; fallthrough

.do_check
	; check if current pokemon has light barrier
	call GetCurrentMon
	ld hl, LightBarrierPokemon
	call IsInByteArray
	ret nc

	; select correct screen + counter
	ld hl, wPlayerScreens
	ld bc, wPlayerLightScreenCount
	ldh a, [hBattleTurn]
	and a
	jr z, .got_pointers
	ld hl, wEnemyScreens
	ld bc, wEnemyLightScreenCount

.got_pointers
	; don't reapply if light screen already up
	bit SCREENS_LIGHT_SCREEN, [hl]
	ret nz

	; set Light Screen for 5 turns
	set SCREENS_LIGHT_SCREEN, [hl]
	ld a, 5
	ld [bc], a

	; don't play damage effect when animation goes off
	xor a
	ld [wNumHits], a
	call Call_PlayBattleAnim_OnlyIfVisible

	; play light screen animation
	ld de, LIGHT_SCREEN
	farcall Call_PlayBattleAnim

	ld hl, LightBarrierText
	jmp StdBattleTextbox

INCLUDE "data/abilities/light_barrier_mons.asm"

HandleIntimidate:
	ldh a, [hSerialConnectionStatus]
	cp USING_EXTERNAL_CLOCK
	jr z, .reverse

	call .player
	jr .enemy

.reverse
	call .enemy
	; fallthrough

.player
	CheckEventFlag EVENT_INTIMIDATE_PLAYER
	ret nz
	SetEventFlag EVENT_INTIMIDATE_PLAYER

	call SetPlayerTurn
	jr .do_check

.enemy
	CheckEventFlag EVENT_INTIMIDATE_FOE
	ret nz
	SetEventFlag EVENT_INTIMIDATE_FOE

	call SetEnemyTurn
	; fallthrough

.do_check
	; check if current pokemon has intimidate
	call GetCurrentMon
	ld hl, IntimidatePokemon
	call IsInByteArray
	ret nc

	; play leer animation
	ld de, LEER
	farcall Call_PlayBattleAnim

	ld hl, IntimidateText
	call StdBattleTextbox

	farcall BattleCommand_AttackDown
	farjp BattleCommand_StatDownMessage

INCLUDE "data/abilities/intimidate_mons.asm"

HandleBattleStance:
	ldh a, [hSerialConnectionStatus]
	cp USING_EXTERNAL_CLOCK
	jr z, .reverse

	call .player
	jr .enemy

.reverse
	call .enemy
	; fallthrough

.player
	CheckEventFlag EVENT_BATTLE_STANCE_PLAYER
	ret nz
	SetEventFlag EVENT_BATTLE_STANCE_PLAYER

	call SetPlayerTurn
	jr .do_check

.enemy
	CheckEventFlag EVENT_BATTLE_STANCE_FOE
	ret nz
	SetEventFlag EVENT_BATTLE_STANCE_FOE

	call SetEnemyTurn
	; fallthrough

.do_check
	; check if switched in pokemon has battle stance
	call GetCurrentMon
	ld hl, BattleStancePokemon
	call IsInByteArray
	ret nc

	ld hl, BattleStanceText
	call StdBattleTextbox

	farcall BattleCommand_DefenseUp
	farjp BattleCommand_StatUpMessage

INCLUDE "data/abilities/battle_stance_mons.asm"

HandleBattleDrive:
	ldh a, [hSerialConnectionStatus]
	cp USING_EXTERNAL_CLOCK
	jr z, .reverse

	call .player
	jr .enemy

.reverse
	call .enemy
	; fallthrough

.player
	CheckEventFlag EVENT_BATTLE_DRIVE_PLAYER
	ret nz
	SetEventFlag EVENT_BATTLE_DRIVE_PLAYER

	call SetPlayerTurn
	jr .do_check

.enemy
	CheckEventFlag EVENT_BATTLE_DRIVE_FOE
	ret nz
	SetEventFlag EVENT_BATTLE_DRIVE_FOE

	call SetEnemyTurn
	; fallthrough

.do_check
	; check if switched in pokemon has battle drive
	call GetCurrentMon
	ld hl, BattleDrivePokemon
	call IsInByteArray
	ret nc

	ld hl, BattleDriveText
	call StdBattleTextbox

	farcall BattleCommand_AttackUp
	farjp BattleCommand_StatUpMessage

INCLUDE "data/abilities/battle_drive_mons.asm"

HandleChaoticBoost:
	ldh a, [hSerialConnectionStatus]
	cp USING_EXTERNAL_CLOCK
	jr z, .reverse

	call .player
	jr .enemy

.reverse
	call .enemy
	; fallthrough

.player
	CheckEventFlag EVENT_CHAOTIC_BOOST_PLAYER
	ret nz
	SetEventFlag EVENT_CHAOTIC_BOOST_PLAYER

	call SetPlayerTurn
	jr .do_check

.enemy
	CheckEventFlag EVENT_CHAOTIC_BOOST_FOE
	ret nz
	SetEventFlag EVENT_CHAOTIC_BOOST_FOE

	call SetEnemyTurn
	; fallthrough

.do_check
	; check if switched in pokemon has battle drive
	call GetCurrentMon
	ld hl, ChaoticBoostPokemon
	call IsInByteArray
	ret nc

	ld hl, ChaoticBoostText
	call StdBattleTextbox

	call BattleRandom
	cp 43
	jr c, .AtkUp
	cp 86
	jr c, .DefUp
	cp 129
	jr c, .SpAtkUp
	cp 172
	jr c, .SpDefUp
	cp 215
	jr c, .SpdUp
	cp 255
	jr c, .EvasionUp
	ret

.AtkUp
	farcall BattleCommand_AttackUp
	farjp BattleCommand_StatUpMessage

.DefUp
	farcall BattleCommand_DefenseUp
	farjp BattleCommand_StatUpMessage

.SpAtkUp
	farcall BattleCommand_SpecialAttackUp
	farjp BattleCommand_StatUpMessage

.SpDefUp
	farcall BattleCommand_SpecialDefenseUp
	farjp BattleCommand_StatUpMessage

.SpdUp
	farcall BattleCommand_SpeedUp
	farjp BattleCommand_StatUpMessage

.EvasionUp
	farcall BattleCommand_EvasionUp
	farjp BattleCommand_StatUpMessage

INCLUDE "data/abilities/chaotic_boost_mons.asm"

HandleTrueSight:
	ldh a, [hSerialConnectionStatus]
	cp USING_EXTERNAL_CLOCK
	jr z, .reverse

	call .player
	jr .enemy

.reverse
	call .enemy
	; fallthrough

.player
	CheckEventFlag EVENT_TRUE_SIGHT_PLAYER
	ret nz
	SetEventFlag EVENT_TRUE_SIGHT_PLAYER

	call SetPlayerTurn
	jr .do_check

.enemy
	CheckEventFlag EVENT_TRUE_SIGHT_FOE
	ret nz
	SetEventFlag EVENT_TRUE_SIGHT_FOE

	call SetEnemyTurn
	; fallthrough

.do_check
	; check if current pokemon has true sight
	call GetCurrentMon
	ld hl, TrueSightPokemon
	call IsInByteArray
	ret nc

	; play foresight animation
	ld de, FORESIGHT
	farcall Call_PlayBattleAnim

	ld hl, TrueSightText
	call StdBattleTextbox

	farjp BattleCommand_Foresight

INCLUDE "data/abilities/true_sight_mons.asm"

HandleFogOfWar:
	ldh a, [hSerialConnectionStatus]
	cp USING_EXTERNAL_CLOCK
	jr z, .reverse

	call .player
	jr .enemy

.reverse
	call .enemy
	; fallthrough

.player
	CheckEventFlag EVENT_FOG_OF_WAR_PLAYER
	ret nz
	SetEventFlag EVENT_FOG_OF_WAR_PLAYER

	call SetPlayerTurn
	jr .do_check

.enemy
	CheckEventFlag EVENT_FOG_OF_WAR_FOE
	ret nz
	SetEventFlag EVENT_FOG_OF_WAR_FOE

	call SetEnemyTurn
	; fallthrough

.do_check
	; check if current pokemon has fog of war
	call GetCurrentMon
	ld hl, FogOfWarPokemon
	call IsInByteArray
	ret nc

	; only use if foe's stats is buffed by at least 1 stage
	ld a, [wEnemyAtkLevel]
	cp BASE_STAT_LEVEL + 1
	jr nc, .stat_buffed_so_activate_fog_of_war
	ld a, [wEnemyDefLevel]
	cp BASE_STAT_LEVEL + 1
	jr nc, .stat_buffed_so_activate_fog_of_war
	ld a, [wEnemySAtkLevel]
	cp BASE_STAT_LEVEL + 1
	jr nc, .stat_buffed_so_activate_fog_of_war
	ld a, [wEnemySDefLevel]
	cp BASE_STAT_LEVEL + 1
	jr nc, .stat_buffed_so_activate_fog_of_war
	ld a, [wEnemySpdLevel]
	cp BASE_STAT_LEVEL + 1
	jr nc, .stat_buffed_so_activate_fog_of_war
	ld a, [wEnemyAccLevel]
	cp BASE_STAT_LEVEL + 1
	jr nc, .stat_buffed_so_activate_fog_of_war
	ld a, [wEnemyEvaLevel]
	cp BASE_STAT_LEVEL + 1
	ret c

.stat_buffed_so_activate_fog_of_war
	; play haze animation
	ld de, HAZE
	farcall Call_PlayBattleAnim

	ld hl, FogOfWarText
	call StdBattleTextbox

	farjp BattleCommand_ResetStats

INCLUDE "data/abilities/fog_of_war_mons.asm"

HandleCleanSweep:
	ldh a, [hSerialConnectionStatus]
	cp USING_EXTERNAL_CLOCK
	jr z, .reverse

	call .player
	jr .enemy

.reverse
	call .enemy
	; fallthrough

.player
	CheckEventFlag EVENT_DEFOG_PLAYER
	ret nz
	SetEventFlag EVENT_DEFOG_PLAYER

	call SetPlayerTurn
	jr .do_check

.enemy
	CheckEventFlag EVENT_DEFOG_FOE
	ret nz
	SetEventFlag EVENT_DEFOG_FOE

	call SetEnemyTurn
	; fallthrough

.do_check
	; check if current pokemon has clean sweep
	call GetCurrentMon
	ld hl, CleanSweepPokemon
	call IsInByteArray
	ret nc

    call AnyFieldEffectPresent
    ret nc

	; play defog animation
	ld de, DEFOG
	farcall Call_PlayBattleAnim

	ld hl, CleanSweepText
	call StdBattleTextbox

	farjp BattleCommand_Defog

INCLUDE "data/abilities/clean_sweep_mons.asm"

HandleRockSnare:
	ldh a, [hSerialConnectionStatus]
	cp USING_EXTERNAL_CLOCK
	jr z, .reverse

	call .player
	jr .enemy

.reverse
	call .enemy
	; fallthrough

.player
	CheckEventFlag EVENT_ROCK_SNARE_PLAYER
	ret nz
	SetEventFlag EVENT_ROCK_SNARE_PLAYER

	call SetPlayerTurn
	jr .do_check

.enemy
	CheckEventFlag EVENT_ROCK_SNARE_FOE
	ret nz
	SetEventFlag EVENT_ROCK_SNARE_FOE

	call SetEnemyTurn
	; fallthrough

.do_check
	; check if current pokemon has rock snare
	call GetCurrentMon
	ld hl, RockSnarePokemon
	call IsInByteArray
	ret nc

	ld hl, wEnemyScreens
	ldh a, [hBattleTurn]
	and a
	jr z, .got_screens
	ld hl, wPlayerScreens
.got_screens
    bit SCREENS_STEALTH_ROCK, [hl]
    ret nz
	set SCREENS_STEALTH_ROCK, [hl]

	; play stealth rock animation
	ld de, STEALTH_ROCK
	farcall Call_PlayBattleAnim

	ld hl, RockSnareText
	jmp StdBattleTextbox

INCLUDE "data/abilities/rock_snare_mons.asm"

HandleCaltropper:
	ldh a, [hSerialConnectionStatus]
	cp USING_EXTERNAL_CLOCK
	jr z, .reverse

	call .player
	jr .enemy

.reverse
	call .enemy
	; fallthrough

.player
	CheckEventFlag EVENT_CALTROPPER_PLAYER
	ret nz
	SetEventFlag EVENT_CALTROPPER_PLAYER

	call SetPlayerTurn
	jr .do_check

.enemy
	CheckEventFlag EVENT_CALTROPPER_FOE
	ret nz
	SetEventFlag EVENT_CALTROPPER_FOE

	call SetEnemyTurn
	; fallthrough

.do_check
	; check if current pokemon has caltropper
	call GetCurrentMon
	ld hl, CaltropperPokemon
	call IsInByteArray
	ret nc

	ld hl, wEnemyScreens
	ldh a, [hBattleTurn]
	and a
	jr z, .got_screens
	ld hl, wPlayerScreens
.got_screens
    bit SCREENS_SPIKES, [hl]
    ret nz
	set SCREENS_SPIKES, [hl]

	; play spikes animation
	ld de, SPIKES
	farcall Call_PlayBattleAnim

	ld hl, CaltropperText
	jmp StdBattleTextbox

INCLUDE "data/abilities/caltropper_mons.asm"

HandleVenomField:
	ldh a, [hSerialConnectionStatus]
	cp USING_EXTERNAL_CLOCK
	jr z, .reverse

	call .player
	jr .enemy

.reverse
	call .enemy
	; fallthrough

.player
	CheckEventFlag EVENT_VENOM_FIELD_PLAYER
	ret nz
	SetEventFlag EVENT_VENOM_FIELD_PLAYER

	call SetPlayerTurn
	jr .do_check

.enemy
	CheckEventFlag EVENT_VENOM_FIELD_FOE
	ret nz
	SetEventFlag EVENT_VENOM_FIELD_FOE

	call SetEnemyTurn
	; fallthrough

.do_check
	; check if current pokemon has venom field
	call GetCurrentMon
	ld hl, VenomFieldPokemon
	call IsInByteArray
	ret nc

	ld hl, wEnemyScreens
	ldh a, [hBattleTurn]
	and a
	jr z, .got_screens
	ld hl, wPlayerScreens
.got_screens
    bit SCREENS_TOXIC_SPIKES, [hl]
    ret nz
	set SCREENS_TOXIC_SPIKES, [hl]

	; play toxic spikes animation
	ld de, TOXIC_SPIKES
	farcall Call_PlayBattleAnim

	ld hl, VenomFieldText
	jmp StdBattleTextbox

INCLUDE "data/abilities/venom_field_mons.asm"

HandleSilkSnare:
	ldh a, [hSerialConnectionStatus]
	cp USING_EXTERNAL_CLOCK
	jr z, .reverse

	call .player
	jr .enemy

.reverse
	call .enemy
	; fallthrough

.player
	CheckEventFlag EVENT_SILK_SNARE_PLAYER
	ret nz
	SetEventFlag EVENT_SILK_SNARE_PLAYER

	call SetPlayerTurn
	jr .do_check

.enemy
	CheckEventFlag EVENT_SILK_SNARE_FOE
	ret nz
	SetEventFlag EVENT_SILK_SNARE_FOE

	call SetEnemyTurn
	; fallthrough

.do_check
	; check if current pokemon has silk snare
	call GetCurrentMon
	ld hl, SilkSnarePokemon
	call IsInByteArray
	ret nc

	ld hl, wEnemyScreens
	ldh a, [hBattleTurn]
	and a
	jr z, .got_screens
	ld hl, wPlayerScreens
.got_screens
    bit SCREENS_STICKY_WEB, [hl]
    ret nz
	set SCREENS_STICKY_WEB, [hl]

	; play sticky web animation
	ld de, STICKY_WEB
	farcall Call_PlayBattleAnim

	ld hl, SilkSnareText
	jmp StdBattleTextbox

INCLUDE "data/abilities/silk_snare_mons.asm"

HandleChronoShift:
	ldh a, [hSerialConnectionStatus]
	cp USING_EXTERNAL_CLOCK
	jr z, .reverse

	call .player
	jr .enemy

.reverse
	call .enemy
	; fallthrough

.player
	CheckEventFlag EVENT_CHRONO_SHIFT_PLAYER
	ret nz
	SetEventFlag EVENT_CHRONO_SHIFT_PLAYER

	call SetPlayerTurn
	jr .do_check

.enemy
	CheckEventFlag EVENT_CHRONO_SHIFT_FOE
	ret nz
	SetEventFlag EVENT_CHRONO_SHIFT_FOE

	call SetEnemyTurn
	; fallthrough

.do_check
	; check if current pokemon has chrono shift
	call GetCurrentMon
	ld hl, ChronoShiftPokemon
	call IsInByteArray
	ret nc

	ld a, [wTrickRoomCount]
	and a
	ret nz
	ld a, 5
	ld [wTrickRoomCount], a

	; play sticky web animation
	ld de, TRICK_ROOM
	farcall Call_PlayBattleAnim

	ld hl, ChronoShiftText
	jmp StdBattleTextbox

INCLUDE "data/abilities/chrono_shift_mons.asm"

HandleFortify:
	ldh a, [hSerialConnectionStatus]
	cp USING_EXTERNAL_CLOCK
	jr z, .reverse

	call .player
	jr .enemy

.reverse
	call .enemy
	; fallthrough

.player
	CheckEventFlag EVENT_FORTIFY_PLAYER
	ret nz
	SetEventFlag EVENT_FORTIFY_PLAYER

	call SetPlayerTurn
	jr .do_check

.enemy
	CheckEventFlag EVENT_FORTIFY_FOE
	ret nz
	SetEventFlag EVENT_FORTIFY_FOE

	call SetEnemyTurn
	; fallthrough

.do_check
	; check if current pokemon has fortify
	call GetCurrentMon
	ld hl, FortifyPokemon
	call IsInByteArray
	ret nc

	; play barrier animation
	ld de, BARRIER
	farcall Call_PlayBattleAnim

	ld hl, FortifyText
	call StdBattleTextbox
	farjp BattleCommand_Barrier

INCLUDE "data/abilities/fortify_mons.asm"

HandleImposter:
	ldh a, [hSerialConnectionStatus]
	cp USING_EXTERNAL_CLOCK
	jr z, .reverse

	call .player
	jr .enemy

.reverse
	call .enemy
	; fallthrough

.player
	CheckEventFlag EVENT_IMPOSTER_PLAYER
	ret nz
	SetEventFlag EVENT_IMPOSTER_PLAYER

	call SetPlayerTurn
	jr .do_check

.enemy
	CheckEventFlag EVENT_IMPOSTER_FOE
	ret nz
	SetEventFlag EVENT_IMPOSTER_FOE

	call SetEnemyTurn
	; fallthrough

.do_check
	; check if current pokemon has imposter
	call GetCurrentMon
	ld hl, ImposterPokemon
	call IsInByteArray
	ret nc

	; play transform animation
	ld de, TRANSFORM
	farcall Call_PlayBattleAnim

	ld hl, ImposterText
	call StdBattleTextbox
	farjp BattleCommand_Transform

INCLUDE "data/abilities/imposter_mons.asm"

HandleSpinGuard:
	; check if current pokemon has spin guard
	call GetCurrentMon
	ld hl, SpinGuardPokemon
	call IsInByteArray
	ret nc

    call AnyHazardsPresent
    ret nc
    callfar BattleCommand_ClearHazards

	; play spin guard animation
	ld de, ANIM_SPIN_GUARD
	farcall Call_PlayBattleAnim

	ld hl, BlewSpikesText
	jmp StdBattleTextbox

INCLUDE "data/abilities/spin_guard_mons.asm"

HandleSeedfall:
	; check if current pokemon has seedfall
	call GetCurrentMon
	ld hl, SeedfallPokemon
	call IsInByteArray
	ret nc

	; skip if foe is already seeded
	ld a, BATTLE_VARS_SUBSTATUS4_OPP
	call GetBattleVarAddr
	bit SUBSTATUS_LEECH_SEED, [hl]
	ret nz

	; play leech seed animation
	ld de, LEECH_SEED
	farcall Call_PlayBattleAnim

    farjp BattleCommand_LeechSeed

INCLUDE "data/abilities/seedfall_mons.asm"

HandleInfernalHowl:
	ldh a, [hSerialConnectionStatus]
	cp USING_EXTERNAL_CLOCK
	jr z, .reverse

	call .player
	jr .enemy

.reverse
	call .enemy
	; fallthrough

.player
	CheckEventFlag EVENT_INFERNAL_HOWL_PLAYER
	ret nz
	SetEventFlag EVENT_INFERNAL_HOWL_PLAYER

	call SetPlayerTurn
	jr .do_check

.enemy
	CheckEventFlag EVENT_INFERNAL_HOWL_FOE
	ret nz
	SetEventFlag EVENT_INFERNAL_HOWL_FOE

	call SetEnemyTurn
	; fallthrough

.do_check
	; check if current pokemon has infernal howl
	call GetCurrentMon
	ld hl, InfernalHowlPokemon
	call IsInByteArray
	ret nc

	; play snarl animation
	ld de, SNARL
	farcall Call_PlayBattleAnim

	ld hl, InfernalHowlText
	call StdBattleTextbox

	farcall BattleCommand_SpecialAttackDown
	farjp BattleCommand_StatDownMessage

INCLUDE "data/abilities/infernal_howl_mons.asm"

HandleSanctuary:
	ldh a, [hSerialConnectionStatus]
	cp USING_EXTERNAL_CLOCK
	jr z, .reverse

	call .player
	jr .enemy

.reverse
	call .enemy
	; fallthrough

.player
	CheckEventFlag EVENT_SANCTUARY_PLAYER
	ret nz
	SetEventFlag EVENT_SANCTUARY_PLAYER

	call SetPlayerTurn
	jr .do_check

.enemy
	CheckEventFlag EVENT_SANCTUARY_FOE
	ret nz
	SetEventFlag EVENT_SANCTUARY_FOE

	call SetEnemyTurn
	; fallthrough

.do_check
	; check if current pokemon has sanctuary
	call GetCurrentMon
	ld hl, SanctuaryPokemon
	call IsInByteArray
	ret nc

	ld hl, wPlayerScreens
	ld de, wPlayerSafeguardCount
	ldh a, [hBattleTurn]
	and a
	jr z, .ok
	ld hl, wEnemyScreens
	ld de, wEnemySafeguardCount
.ok
	bit SCREENS_SAFEGUARD, [hl]
	ret nz

	; play safeguard animation
	ld de, SAFEGUARD
    farcall Call_PlayBattleAnim

	farjp BattleCommand_Safeguard

INCLUDE "data/abilities/sanctuary_mons.asm"

HandleSiegebreaker:
	ldh a, [hSerialConnectionStatus]
	cp USING_EXTERNAL_CLOCK
	jr z, .reverse

	call .player
	jr .enemy

.reverse
	call .enemy
	; fallthrough

.player
	CheckEventFlag EVENT_SIEGEBREAKER_PLAYER
	ret nz
	SetEventFlag EVENT_SIEGEBREAKER_PLAYER

	call SetPlayerTurn
	jr .do_check

.enemy
	CheckEventFlag EVENT_SIEGEBREAKER_FOE
	ret nz
	SetEventFlag EVENT_SIEGEBREAKER_FOE

	call SetEnemyTurn
	; fallthrough

.do_check
	; check if current pokemon has siegebreaker
	call GetCurrentMon
	ld hl, SiegebreakerPokemon
	call IsInByteArray
	ret nc

	call ReflectOrLightScreenUp
	ret nc

	; play brick break animation
	ld de, BRICK_BREAK
    farcall Call_PlayBattleAnim

	ld hl, SiegebreakerText
	call StdBattleTextbox

	farjp BattleCommand_BreakScreens

INCLUDE "data/abilities/siegebreaker_mons.asm"

HandleProvocateur:
	ldh a, [hSerialConnectionStatus]
	cp USING_EXTERNAL_CLOCK
	jr z, .reverse

	call .player
	jr .enemy

.reverse
	call .enemy
	; fallthrough

.player
	CheckEventFlag EVENT_PROVOCATEUR_PLAYER
	ret nz
	SetEventFlag EVENT_PROVOCATEUR_PLAYER

	call SetPlayerTurn
	jr .do_check

.enemy
	CheckEventFlag EVENT_PROVOCATEUR_FOE
	ret nz
	SetEventFlag EVENT_PROVOCATEUR_FOE

	call SetEnemyTurn
	; fallthrough

.do_check
	; check if current pokemon has provocateur
	call GetCurrentMon
	ld hl, ProvocateurPokemon
	call IsInByteArray
	ret nc

; are we dealing with foe or player
; end if the respecitve is already under taunt
    ldh a, [hBattleTurn]
	and a
	jr z, .foe

	ld a, [wPlayerTauntCount]
	and a
	ret nz
	jr .taunt
.foe
	ld a, [wEnemyTauntCount]
	and a
	ret nz

.taunt
	; play taunt animation
	ld de, TAUNT
    farcall Call_PlayBattleAnim

	ld hl, ProvocateurText
	call StdBattleTextbox

	farjp BattleCommand_Taunt

INCLUDE "data/abilities/provocateur_mons.asm"

HandleDisarm:
	ldh a, [hSerialConnectionStatus]
	cp USING_EXTERNAL_CLOCK
	jr z, .reverse

	call .player
	jr .enemy

.reverse
	call .enemy
	; fallthrough

.player
	CheckEventFlag EVENT_DISARM_PLAYER
	ret nz
	SetEventFlag EVENT_DISARM_PLAYER

	call SetPlayerTurn
	jr .do_check

.enemy
	CheckEventFlag EVENT_DISARM_FOE
	ret nz
	SetEventFlag EVENT_DISARM_FOE

	call SetEnemyTurn
	; fallthrough

.do_check
	; check if current pokemon has disarm
	call GetCurrentMon
	ld hl, DisarmPokemon
	call IsInByteArray
	ret nc

; ==================
; === Check Turn ===
; ==================
	ldh a, [hBattleTurn]
	and a
	jr nz, .enemy_turn

; =====================
; === Player's Turn ===
; =====================
; enemy must have an item
	call CheckIfEnemyHasAnItem
	ld a, [hl]
	and a
	ret z
	jr .continue

.enemy_turn
; ====================
; === Enemy's Turn ===
; ====================
; player must have an item
	call CheckIfPlayerHasAnItem
	ld a, [hl]
	and a
	ret z

.continue
	; play knock off animation
	ld de, KNOCK_OFF
	farcall Call_PlayBattleAnim

	ld hl, DisarmText
	call StdBattleTextbox

	farjp BattleCommand_KnockOff

; ===============
; === HELPERS ===
; ===============
CheckIfPlayerHasAnItem:
	ld a, MON_ITEM
	call BattlePartyAttr
	ld d, h
	ld e, l
	ld hl, wBattleMonItem
	ret

CheckIfEnemyHasAnItem:
	ld a, MON_ITEM
	call OTPartyAttr
	ld d, h
	ld e, l
	ld hl, wEnemyMonItem
	ret

INCLUDE "data/abilities/disarm_mons.asm"

HandleAllure:
	ldh a, [hSerialConnectionStatus]
	cp USING_EXTERNAL_CLOCK
	jr z, .reverse

	call .player
	jr .enemy

.reverse
	call .enemy
	; fallthrough

.player
	CheckEventFlag EVENT_ALLURE_PLAYER
	ret nz
	SetEventFlag EVENT_ALLURE_PLAYER

	call SetPlayerTurn
	jr .do_check

.enemy
	CheckEventFlag EVENT_ALLURE_FOE
	ret nz
	SetEventFlag EVENT_ALLURE_FOE

	call SetEnemyTurn
	; fallthrough

.do_check
	; check if current pokemon has allure
	call GetCurrentMon
	ld hl, AllurePokemon
	call IsInByteArray
	ret nc

	; exit if same gender
	farcall CheckOppositeGender
	ret c

	; play attract animation
	ld de, ATTRACT
	farcall Call_PlayBattleAnim

	ld hl, AllureText
	call StdBattleTextbox

	farjp BattleCommand_Attract

INCLUDE "data/abilities/allure_mons.asm"

AnyHazardsPresent:
	ld a, [wPlayerScreens]
	call AnyHazardsUp
	jr c, .yes
	ld a, [wEnemyScreens]
	call AnyHazardsUp
	jr c, .yes
	xor a
	ret
.yes
	scf
	ret

AnyHazardsUp:
	bit SCREENS_SPIKES, a
	jr nz, .yes
	bit SCREENS_STEALTH_ROCK, a
	jr nz, .yes
	bit SCREENS_TOXIC_SPIKES, a
	jr nz, .yes
	bit SCREENS_STICKY_WEB, a
	xor a
	ret
.yes
    scf
    ret

AnyFieldEffectPresent:
	ld a, [wFieldWeather]
	cp WEATHER_NONE
	jr nz, .yes
	ld a, [wBattleWeather]
	cp WEATHER_NONE
	jr nz, .yes
	ld a, [wPlayerScreens]
	call AnyScreensUp
	jr c, .yes
	ld a, [wEnemyScreens]
	call AnyScreensUp
	jr c, .yes
	xor a
	ret

.yes
	scf
	ret

AnyScreensUp:
	bit SCREENS_MIST, a
	jr nz, .yes
	bit SCREENS_SAFEGUARD, a
	jr nz, .yes
	bit SCREENS_LIGHT_SCREEN, a
	jr nz, .yes
	bit SCREENS_REFLECT, a
	jr nz, .yes
	bit SCREENS_SPIKES, a
	jr nz, .yes
	bit SCREENS_STEALTH_ROCK, a
	jr nz, .yes
	bit SCREENS_TOXIC_SPIKES, a
	jr nz, .yes
	bit SCREENS_STICKY_WEB, a
	jr nz, .yes
	xor a
	ret

.yes
	scf
	ret

ReflectOrLightScreenUp:
	ld a, [wPlayerScreens]
	call EitherRelfectOrLightScreensUp
	jr c, .yes
	ld a, [wEnemyScreens]
	call EitherRelfectOrLightScreensUp
	jr c, .yes
	xor a
	ret

.yes
	scf
	ret

EitherRelfectOrLightScreensUp:
	bit SCREENS_LIGHT_SCREEN, a
	jr nz, .yes
	bit SCREENS_REFLECT, a
	jr nz, .yes
	xor a
	ret

.yes
	scf
	ret
