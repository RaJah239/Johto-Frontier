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
