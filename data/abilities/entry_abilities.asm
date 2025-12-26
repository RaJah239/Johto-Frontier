EntryAbilities:
	call HandleDrought
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
