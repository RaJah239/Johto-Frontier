LoadPlayerEffectiveDefense:
	push bc
	ld hl, wBattleMonDefense
	ld de, hMultiplicand + 1
	ld bc, wBattleMonType1
	ld a, DEFENSE
	call LoadEffectiveWeatherDefenseStat
	pop bc
	ret

LoadEnemyEffectiveDefense:
	push bc
	ld hl, wEnemyMonDefense
	ld de, hEnemyMonSpeed
	ld bc, wEnemyMonType1
	ld a, DEFENSE
	call LoadEffectiveWeatherDefenseStat
	pop bc
	ret

LoadPlayerEffectiveSpDef:
	push bc
	ld hl, wBattleMonSpclDef
	ld de, hMultiplicand + 1
	ld bc, wBattleMonType1
	ld a, SP_DEFENSE
	call LoadEffectiveWeatherDefenseStat
	pop bc
	ret

LoadEnemyEffectiveSpDef:
	push bc
	ld hl, wEnemyMonSpclDef
	ld de, hEnemyMonSpeed
	ld bc, wEnemyMonType1
	ld a, SP_DEFENSE
	call LoadEffectiveWeatherDefenseStat
	pop bc
	ret

LoadEffectiveWeatherDefenseStat:
	push af
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	pop af
	call DoesMonGetWeatherDefenseBoost
	ret nc
	; fallthrough

ApplyFiftyPercentStatBoost:
	ld a, [de]
	ld c, a
	dec de
	ld a, [de]
	ld b, a
	ld h, b
	ld l, c
	srl b
	rr c
	add hl, bc
	ld a, h
	cp HIGH(MAX_STAT_VALUE)
	jr c, .store
	jr nz, .cap
	ld a, l
	cp LOW(MAX_STAT_VALUE)
	jr c, .store
.cap
	ld h, HIGH(MAX_STAT_VALUE)
	ld l, LOW(MAX_STAT_VALUE)
.store
	ld a, h
	ld [de], a
	inc de
	ld a, l
	ld [de], a
	ret

DoesMonGetWeatherDefenseBoost:
	push hl
	push de
	push bc
	cp DEFENSE
	jr z, .defense
	cp SP_DEFENSE
	jr z, .sp_defense
	jr .no

.defense
	ld a, [wBattleWeather]
	cp WEATHER_HAIL
	jr nz, .no
	ld a, [bc]
	cp ICE
	jr z, .yes
	inc bc
	ld a, [bc]
	cp ICE
	jr z, .yes
	jr .no

.sp_defense
	ld a, [wBattleWeather]
	cp WEATHER_SANDSTORM
	jr nz, .no
	ld a, [bc]
	cp ROCK
	jr z, .yes
	inc bc
	ld a, [bc]
	cp ROCK
	jr z, .yes

.no
	pop bc
	pop de
	pop hl
	and a
	ret

.yes
	pop bc
	pop de
	pop hl
	scf
	ret

HandlePerishSong:
	ldh a, [hSerialConnectionStatus]
	cp USING_EXTERNAL_CLOCK
	jr z, .EnemyFirst
	call SetPlayerTurn
	call .do_it
	call SetEnemyTurn
	jr .do_it

.EnemyFirst:
	call SetEnemyTurn
	call .do_it
	call SetPlayerTurn

.do_it
	ld hl, wPlayerPerishCount
	ldh a, [hBattleTurn]
	and a
	jr z, .got_count
	ld hl, wEnemyPerishCount

.got_count
	ld a, BATTLE_VARS_SUBSTATUS1
	call GetBattleVar
	bit SUBSTATUS_PERISH, a
	ret z
	dec [hl]
	ld a, [hl]
	ld [wTextDecimalByte], a
	push af
	ld hl, PerishCountText
	call StdBattleTextbox
	pop af
	ret nz
	ld a, BATTLE_VARS_SUBSTATUS1
	call GetBattleVarAddr
	res SUBSTATUS_PERISH, [hl]
	ldh a, [hBattleTurn]
	and a
	jr nz, .kill_enemy
	ld hl, wBattleMonHP
	xor a
	ld [hli], a
	ld [hl], a
	ld hl, wPartyMon1HP
	ld a, [wCurBattleMon]
	call GetPartyLocation
	xor a
	ld [hli], a
	ld [hl], a
	ret

.kill_enemy
	ld hl, wEnemyMonHP
	xor a
	ld [hli], a
	ld [hl], a
	ld a, [wBattleMode]
	dec a
	ret z
	ld hl, wOTPartyMon1HP
	ld a, [wCurOTMon]
	call GetPartyLocation
	xor a
	ld [hli], a
	ld [hl], a
	ret

HandleWrap:
	ldh a, [hSerialConnectionStatus]
	cp USING_EXTERNAL_CLOCK
	jr z, .EnemyFirst
	call SetPlayerTurn
	call .do_it
	call SetEnemyTurn
	jr .do_it

.EnemyFirst:
	call SetEnemyTurn
	call .do_it
	call SetPlayerTurn

.do_it
	ld hl, wPlayerWrapCount
	ld de, wPlayerTrappingMove
	ldh a, [hBattleTurn]
	and a
	jr z, .got_addrs
	ld hl, wEnemyWrapCount
	ld de, wEnemyTrappingMove

.got_addrs
	ld a, [hl]
	and a
	ret z

	ld a, BATTLE_VARS_SUBSTATUS4
	call GetBattleVar
	bit SUBSTATUS_SUBSTITUTE, a
	ret nz

	ld a, [de]
	ld [wNamedObjectIndex], a
	ld [wFXAnimID], a
	call GetMoveName
	dec [hl]
	jr z, .release_from_bounds

	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVar
	and 1 << SUBSTATUS_FLYING | 1 << SUBSTATUS_UNDERGROUND
	jr nz, .skip_anim

	farcall SwitchTurnCore
	xor a
	ld [wNumHits], a
	ld [wFXAnimID + 1], a
	predef PlayBattleAnim
	farcall SwitchTurnCore

.skip_anim
	farcall GetEighthMaxHP
	farcall SubtractHPFromUser
	ld hl, BattleText_UsersHurtByStringBuffer1
	jr .print_text

.release_from_bounds
	ld hl, BattleText_UserWasReleasedFromStringBuffer1
.print_text
	jmp StdBattleTextbox

HandleWeather:
	ld a, [wBattleWeather]
	cp WEATHER_NONE
	ret z

	ld hl, wWeatherCount
	dec [hl]
	jr nz, .continues

; ended
	call CheckIfFastBattlesIsOn
	jr nz, .skip_weather_end_text

	ld hl, .WeatherEndedMessages
	call .PrintWeatherMessage

.skip_weather_end_text
	xor a
	ld [wBattleWeather], a
	ret

.continues
	call CheckIfFastBattlesIsOn
	jr nz, .skip_weather_text

	ld hl, .WeatherMessages
	call .PrintWeatherMessage

.skip_weather_text
	ld a, [wBattleWeather]
	cp WEATHER_SANDSTORM
	jr nz, .check_hail

	ldh a, [hSerialConnectionStatus]
	cp USING_EXTERNAL_CLOCK
	jr z, .enemy_first

; player first
	call SetPlayerTurn
	call .SandstormDamage
	call SetEnemyTurn
	jr .SandstormDamage

.enemy_first
	call SetEnemyTurn
	call .SandstormDamage
	call SetPlayerTurn

.SandstormDamage:
; magic guard pokemon take no residual damage
	call GetCurrentMon
	ld hl, MagicGuardPokemon
	call IsInByteArray
	ret c

	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVar
	bit SUBSTATUS_UNDERGROUND, a
	ret nz

	ld hl, wBattleMonType1
	ldh a, [hBattleTurn]
	and a
	jr z, .ok
	ld hl, wEnemyMonType1
.ok
	ld a, [hli]
	cp ROCK
	ret z
	cp GROUND
	ret z
	cp STEEL
	ret z

	ld a, [hl]
	cp ROCK
	ret z
	cp GROUND
	ret z
	cp STEEL
	ret z

	farcall GetSixteenthMaxHP
	farcall SubtractHPFromUser

	ld hl, SandstormHitsText
	jmp StdBattleTextbox

.check_hail
	ld a, [wBattleWeather]
	cp WEATHER_HAIL
	ret nz
	
	ldh a, [hSerialConnectionStatus]
	cp USING_EXTERNAL_CLOCK
	jr z, .enemy_first_hail
	
; player first
	call SetPlayerTurn
	call .HailDamage
	call SetEnemyTurn
	jr .HailDamage
	
.enemy_first_hail
	call SetEnemyTurn
	call .HailDamage
	call SetPlayerTurn
	
.HailDamage:
	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVar
	bit SUBSTATUS_UNDERGROUND, a
	ret nz
	
	ld hl, wBattleMonType1
	ldh a, [hBattleTurn]
	and a
	jr z, .ok1
	ld hl, wEnemyMonType1
.ok1
	ld a, [hli]
	cp ICE
	ret z
	
	ld a, [hl]
	cp ICE
	ret z

	farcall GetSixteenthMaxHP
	farcall SubtractHPFromUser
	
	ld hl, PeltedByHailText
	jmp StdBattleTextbox

.PrintWeatherMessage:
	ld a, [wBattleWeather]
	dec a
	ld c, a
	ld b, 0
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jmp StdBattleTextbox

.WeatherMessages:
; entries correspond to WEATHER_* constants
	dw BattleText_RainContinuesToFall
	dw BattleText_TheSunlightContinuesToShine
	dw BattleText_TheSandstormRages
	dw BattleText_HailContinuesToFall

.WeatherEndedMessages:
; entries correspond to WEATHER_* constants
	dw BattleText_TheRainStopped
	dw BattleText_TheSunlightFaded
	dw BattleText_TheSandstormSubsided
	dw BattleText_TheHailStopped
