BattleCommand_StartSun:
; start sun

	ld a, [wBattleWeather]
	cp WEATHER_SUN
	jr z, .failed

	ld a, WEATHER_SUN
	ld [wBattleWeather], a
	call GetWeatherMoveDuration
	ld [wWeatherCount], a
	farcall AnimateCurrentMove
	ld hl, SunsRaysIntensifiedText
	jmp StdBattleTextbox

.failed
	farcall AnimateFailedMove
	farjp PrintButItFailed
