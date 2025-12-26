EntryAbilities1:
	call HandleDrought
	call HandleSandStream
	call HandleSnowWarning
	call HandleNaturalCure
	; fallthrough

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

ResetVolatileAbilityPlayer:
	ResetEventFlag EVENT_REFLECT_BARRIER_PLAYER
	ret

ResetVolatileAbilityFoe:
	ResetEventFlag EVENT_REFLECT_BARRIER_FOE
	ret

EntryAbilities2:
	; fallthrough

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
