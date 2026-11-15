BattleCommand_Defog:
; clear weather
    ld a, 1
	ld [wWeatherCount], a

; clear all screens
    xor a
    ld hl, wPlayerSafeguardCount
    ld [hli], a
    ld [hli], a
    ld [hl], a
    ld hl, wEnemySafeguardCount
    ld [hli], a
    ld [hli], a
    ld [hl], a

    xor a
    ld hl, wPlayerMistCount
    ld [hli], a
    ld [hli], a
    ld [hl], a
    ld hl, wEnemyMistCount
    ld [hli], a
    ld [hli], a
    ld [hl], a

; clear all hazards
    ld hl, wPlayerScreens
    res SCREENS_SPIKES, [hl]
	res SCREENS_STEALTH_ROCK, [hl]
	res SCREENS_TOXIC_SPIKES, [hl]
	res SCREENS_STICKY_WEB, [hl]
    ld hl, wEnemyScreens
    res SCREENS_SPIKES, [hl]
	res SCREENS_STEALTH_ROCK, [hl]
	res SCREENS_TOXIC_SPIKES, [hl]
	res SCREENS_STICKY_WEB, [hl]

; finish move
    farcall AnimateCurrentMove
	ld hl, ClearFieldText
	jmp StdBattleTextbox
