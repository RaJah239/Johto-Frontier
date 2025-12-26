EntryAbilities:
	call HandleDrought
	call HandleSandStream
	call HandleSnowWarning
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
