ResetGameTime::
	xor a
	ld [wGameTimeCap], a
	ld [wGameTimeHours], a
	ld [wGameTimeHours + 1], a
	ld [wGameTimeMinutes], a
	ld [wGameTimeSeconds], a
	ld [wGameTimeFrames], a
	ret

GameTimer::
	ldh a, [rSVBK]
	push af
	ld a, BANK(wGameTime)
	ldh [rSVBK], a

	call .Function

	pop af
	ldh [rSVBK], a
	ret

.Function:
; Increment the game timer by one frame.
; The game timer is capped at 9999:59:59.00.

; Don't update if game logic is paused.
	ld a, [wGameLogicPaused]
	and a
	ret nz

; Is the timer paused?
	ld hl, wGameTimerPaused
	bit GAME_TIMER_COUNTING_F, [hl]
	ret z

; Is the timer already capped?
	ld hl, wGameTimeCap
	bit 0, [hl]
	ret nz

; +1 frame
	ld hl, wGameTimeFrames
	ld a, [hl]
	inc a

	cp 60 ; frames/second
	jr nc, .second

	ld [hl], a
	ret

.second
	xor a
	ld [hl], a
; Count real play seconds before NO_RTC_SPEEDUP advances the game clock.
	ld hl, wWeatherRerollSeconds
	ld a, [hli]
	or [hl]
	jr z, .weather_done
	dec hl
	ld a, [hl]
	sub 1
	ld [hli], a
	ld a, [hl]
	sbc 0
	ld [hl], a
.weather_done

; "Real Time Clock" Off: the game's own clock gains NO_RTC_SPEEDUP seconds
; for every second played (a day lasts 24 / NO_RTC_SPEEDUP real hours)
	ld a, [wOptions5]
	bit NO_RTC, a
	jr z, .real_time_clock
rept NO_RTC_SPEEDUP
	call UpdateNoRTC
endr

.real_time_clock
; +1 second
	ld hl, wGameTimeSeconds
	ld a, [hl]
	inc a

	cp 60 ; seconds/minute
	jr nc, .minute

	ld [hl], a
	ret

.minute
	xor a
	ld [hl], a

; +1 minute
	ld hl, wGameTimeMinutes
	ld a, [hl]
	inc a

	cp 60 ; minutes/hour
	jr nc, .hour

	ld [hl], a
	ret

.hour
	xor a
	ld [hl], a

; +1 hour
	ld a, [wGameTimeHours]
	ld h, a
	ld a, [wGameTimeHours + 1]
	ld l, a
	inc hl

; Cap the timer after 10000 hours.
	ld a, h
	cp HIGH(10000)
	jr c, .ok

	ld a, l
	cp LOW(10000)
	jr c, .ok

	ld hl, wGameTimeCap
	set 0, [hl]

	ld a, 59 ; 9999:59:59.00
	ld [wGameTimeMinutes], a
	ld [wGameTimeSeconds], a
	ret

.ok
	ld a, h
	ld [wGameTimeHours], a
	ld a, l
	ld [wGameTimeHours + 1], a
	ret

UpdateNoRTC::
; add a second to the game's own clock (hRTC*)
	ld hl, hRTCSeconds
	inc [hl]
	ld a, 60
	sub [hl]
	ret nz
	ld [hld], a

; +1 minute
	inc [hl]
	ld a, 60
	sub [hl]
	ret nz
	ld [hld], a

; +1 hour
	inc [hl]
	ld a, 24
	sub [hl]
	ret nz
	ld [hld], a

; +1 day (FixDays keeps the day count inside its 140 day loop)
	inc [hl]
	ret
