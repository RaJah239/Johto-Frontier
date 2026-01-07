; ==============
; === Note 1 ===
; ==============

; these abilties work correctly
; switch in battle and immediately use its effect
EntryAbilities1:
	call HandleDrizzle
	call HandleDrought
	call HandleSandStream
	call HandleSnowWarning
	call HandleNaturalCure
	call HandleSpinGuard
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

	farcall BattleCommand_StatDownMessage

	farcall BattleCommand_AttackDown
	ld hl, IntimidateText
	jmp StdBattleTextbox

INCLUDE "data/abilities/intimidate_mons.asm"

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

	; play roar animation
	ld de, ROAR
	farcall Call_PlayBattleAnim

	ld hl, InfernalHowlText
	call StdBattleTextbox

	farcall BattleCommand_AttackDown
	farcall BattleCommand_StatDownMessage
	farcall BattleCommand_SpecialAttackDown
	farjp BattleCommand_StatDownMessage

INCLUDE "data/abilities/infernal_howl_mons.asm"

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
