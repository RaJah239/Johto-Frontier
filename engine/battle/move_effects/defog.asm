BattleCommand_Defog:
    ; prevent reactivation of hazards by ability mons
    SetEventFlag EVENT_ROCK_SNARE_PLAYER
    SetEventFlag EVENT_CALTROPPER_PLAYER
    SetEventFlag EVENT_VENOM_FIELD_PLAYER
    SetEventFlag EVENT_SILK_SNARE_PLAYER
    SetEventFlag EVENT_ROCK_SNARE_FOE
    SetEventFlag EVENT_CALTROPPER_FOE
    SetEventFlag EVENT_VENOM_FIELD_FOE
    SetEventFlag EVENT_SILK_SNARE_FOE

; clear weather
    ld a, 1
	ld [wWeatherCount], a

; clear all screens
    ld a, 1
    ld hl, wPlayerSafeguardCount
    ld [hli], a
    ld [hli], a
    ld [hl], a
    ld hl, wEnemySafeguardCount
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
    call AnimateCurrentMove
	ld hl, ClearFieldText
	jmp StdBattleTextbox
