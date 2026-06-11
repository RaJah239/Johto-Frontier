MoveInfoBox:
	xor a
	ldh [hBGMapMode], a

	hlcoord 0, 8 ; upper right corner of the textbox
	lb bc, 3, 9
	call Textbox
	call MobileTextBorder

	ld a, [wPlayerDisableCount]
	and a
	jr z, .not_disabled

	swap a
	and $f
	ld b, a
	ld a, [wMenuCursorY]
	cp b
	jr nz, .not_disabled

	hlcoord 1, 10
	ld de, .Disabled
	jmp PlaceString

.not_disabled
	ld hl, wMenuCursorY
	dec [hl]
	call SetPlayerTurn
	ld hl, wBattleMonMoves
	ld a, [wMenuCursorY]
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl]
	ld [wCurPlayerMove], a

	ld a, [wCurBattleMon]
	ld [wCurPartyMon], a
	ld a, WILDMON
	ld [wMonType], a
	callfar GetMaxPPOfMove

	ld hl, wMenuCursorY
	ld c, [hl]
	inc [hl]
	ld b, 0
	ld hl, wBattleMonPP
	add hl, bc
	ld a, [hl]
	and PP_MASK
	ld [wStringBuffer1], a
	call PrintPP

	farcall UpdateMoveData
	ld a, [wPlayerMoveStruct + MOVE_ANIM]
	ld b, a
	farcall BattleGetMoveCategoryName
	hlcoord 1, 9 ; Category coordinates
	ld de, wStringBuffer1
	call PlaceString

	ld a, [wPlayerMoveStruct + MOVE_ANIM]
	ld b, a
	hlcoord 2, 9
	predef PrintMoveType

; display type effectiveness in battle menu
	; check if move has no power
	; or not a special move like counter, mirror coat or seismic toss
	; and bail
	ld a, [wPlayerMoveStruct + MOVE_POWER]
	cp 2
	jr c, .skip_type_effectiveness

	call SetPlayerTurn
	farcall BattleCheckTypeMatchup
	ld a, [wTypeMatchup]
	and a
	jr z, .immune ; 0 damage

	cp EFFECTIVE / 2
	jr c, .very_ineffective ; 1/4x damage

	cp EFFECTIVE
	jr c, .not_very_effective ; 1/2x damage
	jr z, .neutral

	cp EFFECTIVE * 2 + 1
	jr nc, .quad_effective ; 4x damage
	ld de, .double_damage ; 2x damage
	jr .print_effectiveness

.not_very_effective
	ld de, .half_damage
	jr .print_effectiveness

.very_ineffective
	ld de, .quarter_damage
	jr .print_effectiveness

.neutral
	ld de, .neutral_damage
	jr .print_effectiveness

.immune
	ld de, .zero_damage
	jr .print_effectiveness

.quad_effective
	ld de, .quadruple_damage
	; fallthrough

.print_effectiveness
	hlcoord 1, 11
	call PlaceString

.skip_type_effectiveness
; print move BP (Base Power)
	ld de, .power_string ; "p/"
	hlcoord 4, 10
	call PlaceString

	hlcoord 1, 10
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_LEVEL_DAMAGE
	jr z, .has_variable_power
	cp EFFECT_MIRROR_COAT
	jr z, .has_variable_power
	cp EFFECT_COUNTER
	jr z, .has_variable_power

	ld a, [wPlayerMoveStruct + MOVE_POWER]
	cp 2
	jr c, .nopower
	; MOVE_POWER is 2 or higher

	; code for moves with power 2+
	jr .haspower

.has_variable_power:
	ld de, .place_var_string
	call PlaceString
	jr .place_accuracy

.nopower:
	ld de, .nopower_string
	call PlaceString
	jr .place_accuracy

.haspower:
	ld [wTextDecimalByte], a
	ld de, wTextDecimalByte
	lb bc, 1, 3 ; number of bytes this number is in, in 'b', number of possible digits in 'c'
	call PrintNum

; print move's accuracy
.place_accuracy
	ld a, [wCurSpecies]
	ld bc, MOVE_LENGTH

	ld hl, (Moves + MOVE_EFFECT) - MOVE_LENGTH
	call AddNTimes
	ld a, BANK(Moves)
	call GetFarByte

	ld hl, PerfectAccuracyEffects
	call IsInByteArray
	jr nc, .imperfect

	ld de, .nopower_string
	ld bc, 3
	hlcoord 6, 10
	jmp PlaceString

.imperfect
	ld a, [wCurSpecies]
	ld bc, MOVE_LENGTH

	ld hl, (Moves + MOVE_ACC) - MOVE_LENGTH
	call AddNTimes
	ld a, BANK(Moves)
	call GetFarByte

	call ConvertPercentages
	ld [wBuffer1], a
	ld de, wBuffer1
	lb bc, 1, 3
	hlcoord 6, 10
	call PrintNum
	ld [hl], "<%>" ; displays percent symbol
	hlcoord 9, 9
	ret

.nopower_string: db "---@"
.place_var_string: db " var@"
.power_string: db "p/@"
.zero_damage: db "×0@"
.half_damage: db "×<half>@"
.quarter_damage: db "×<quarter>@"
.neutral_damage: db "×1@"
.double_damage: db "×2@"
.quadruple_damage: db "×4@"
.Disabled: db "Disabled!@"

PrintPP:
	hlcoord 5, 11
	push hl
	ld de, wStringBuffer1
	lb bc, 1, 2
	call PrintNum
	pop hl
	inc hl
	inc hl
	ld [hl], "/"
	inc hl
	ld de, wNamedObjectIndex
	lb bc, 1, 2
	jmp PrintNum

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
