DEF DAMAGE_RACE_PLAYER EQU 0
DEF DAMAGE_RACE_ENEMY  EQU 1

DEF DAMAGE_RACE_CAN_HEAL_F      EQU 0
DEF DAMAGE_RACE_HEAL_PRIORITY_F EQU 1

; scratch RAM, borrowed from the switch-in selection (never running at the same time)
DEF wDamageRaceDamage    EQUS "wEnemySwitchMaxDamage"  ; dw, big-endian: attacker's best hit
DEF wDamageRaceHealHP    EQUS "wEnemySwitchBestDamage" ; dw, big-endian: biggest heal that outpaces it
DEF wDamageRaceHealFlags EQUS "wEnemySwitchCandidate"  ; DAMAGE_RACE_*_F
DEF wDamageRaceHits      EQUS "wEnemySwitchBestIndex"  ; hits from damage alone
DEF wDamageRaceSide      EQUS "wEnemySwitchSavedTurn"  ; DAMAGE_RACE_PLAYER / DAMAGE_RACE_ENEMY

GetDamageRaceHits:
; Simulate a straight 1-on-1 between the two active mons, using current HP,
; stat stages and screens (max-roll damage, no crits).
; Returns b = hits the enemy needs to KO the player's mon
;         c = hits the player's mon needs to KO the enemy
; (255 = can't KO). If a mon is locked into one move (choice item or
; Encore), only that move counts for it.
; Healing moves (see DamageRace_HealCheck) can make a mon impossible to wear
; down. Preserves hBattleTurn and wCurDamage, and reloads both move structs
; from wCurPlayerMove and wCurEnemyMove afterwards.
	ldh a, [hBattleTurn]
	push af
	ld a, [wCurDamage]
	push af
	ld a, [wCurDamage + 1]
	push af
	xor a
	ld [wCriticalHit], a

	call DamageRace_EnemyMaxDamage
	ld hl, wBattleMonHP
	call DamageRace_HitsToKO
	ld c, DAMAGE_RACE_PLAYER
	call DamageRace_HealCheck
	push af
	call DamageRace_PlayerMaxDamage
	ld hl, wEnemyMonHP
	call DamageRace_HitsToKO
	ld c, DAMAGE_RACE_ENEMY
	call DamageRace_HealCheck
	ld c, a
	pop af
	ld b, a

	push bc
	call DamageRace_ReloadMoveStructs
	pop bc
	pop af
	ld [wCurDamage + 1], a
	pop af
	ld [wCurDamage], a
	pop af
	ldh [hBattleTurn], a
	ret

DamageRace_EnemyMaxDamage:
; Return in bc (and wDamageRaceDamage) the most damage the enemy can do in
; one hit with a usable move.
	ld c, DAMAGE_RACE_ENEMY
	call DamageRace_GetUsableMoves
	call DamageRace_ResetMax
.loop
	dec b
	jmp z, DamageRace_GetMax
	ld a, [de]
	and a
	jmp z, DamageRace_GetMax
	inc de
	push de
	push bc
	ld de, wEnemyMoveStruct
	call DamageRace_LoadMove
	jr z, .next
	ld a, 1
	ldh [hBattleTurn], a
	callfar EnemyAttackDamage
	callfar BattleCommand_DamageCalc
	callfar BattleCommand_Stab
	call DamageRace_KeepMax
.next
	pop bc
	pop de
	jr .loop

DamageRace_PlayerMaxDamage:
; Return in bc (and wDamageRaceDamage) the most damage the player's mon can
; do in one hit with a usable move.
	ld c, DAMAGE_RACE_PLAYER
	call DamageRace_GetUsableMoves
	call DamageRace_ResetMax
.loop
	dec b
	jmp z, DamageRace_GetMax
	ld a, [de]
	and a
	jmp z, DamageRace_GetMax
	inc de
	push de
	push bc
	ld de, wPlayerMoveStruct
	call DamageRace_LoadMove
	jr z, .next
	xor a
	ldh [hBattleTurn], a
	callfar PlayerAttackDamage
	callfar BattleCommand_DamageCalc
	callfar BattleCommand_Stab
	call DamageRace_KeepMax
.next
	pop bc
	pop de
	jr .loop

DamageRace_GetUsableMoves:
; c = DAMAGE_RACE_PLAYER / DAMAGE_RACE_ENEMY
; Return de = that mon's move list and b = number of moves to check + 1.
; If it's locked into one move (choice item or Encore), only that move.
	ld a, c
	and a
	jr nz, .enemy
	ld de, wBattleMonMoves
	ld hl, wPlayerSubStatus5
	ld a, [wCurMoveNum]
	jr .got_mon
.enemy
	ld de, wEnemyMonMoves
	ld hl, wEnemySubStatus5
	ld a, [wCurEnemyMoveNum]
.got_mon
	ld b, NUM_MOVES + 1
	bit SUBSTATUS_ENCORED, [hl]
	ret z
	; locked into one move: only that move counts
	add e
	ld e, a
	adc d
	sub e
	ld d, a
	ld b, 1 + 1
	ret

DamageRace_LoadMove:
; Copy move a into the move struct at de.
; Returns z to skip it: no power, Explosion, or a two-turn (Solar Beam) move.
	push de
	dec a
	ld hl, Moves
	ld bc, MOVE_LENGTH
	call AddNTimes
	pop de
	push de
	ld a, BANK(Moves)
	call FarCopyBytes
	pop hl
	inc hl ; MOVE_EFFECT
	ld b, [hl]
	inc hl ; MOVE_POWER
	ld a, [hl]
	and a
	ret z
	ld a, b
	cp EFFECT_EXPLOSION
	ret z
	cp EFFECT_SOLARBEAM
	ret z
	or 1 ; nz
	ret

DamageRace_ResetMax:
	xor a
	ld [wDamageRaceDamage], a
	ld [wDamageRaceDamage + 1], a
	ret

DamageRace_KeepMax:
; wDamageRaceDamage = max(itself, wCurDamage)
	ld a, [wDamageRaceDamage + 1]
	ld c, a
	ld a, [wCurDamage + 1]
	sub c
	ld a, [wDamageRaceDamage]
	ld b, a
	ld a, [wCurDamage]
	sbc b
	ret c
	ld a, [wCurDamage]
	ld [wDamageRaceDamage], a
	ld a, [wCurDamage + 1]
	ld [wDamageRaceDamage + 1], a
	ret

DamageRace_GetMax:
	ld a, [wDamageRaceDamage]
	ld b, a
	ld a, [wDamageRaceDamage + 1]
	ld c, a
	ret

DamageRace_HitsToKO:
; bc = damage per hit, hl = pointer to big-endian HP.
; Return in a the number of hits to bring HP to 0 (255 if bc is 0).
	ld a, b
	or c
	jr nz, .can_damage
	ld a, 255
	ret

.can_damage
	ld a, [hli]
	ld d, a
	ld e, [hl]
	ld h, 0
.loop
	inc h
	ld a, h
	cp 255
	jr z, .done
	ld a, e
	sub c
	ld e, a
	ld a, d
	sbc b
	ld d, a
	jr c, .done ; HP went below 0
	or e
	jr nz, .loop ; HP still above 0
.done
	ld a, h
	ret

DamageRace_HealCheck:
; a = hits the attacker needs to KO the defender from damage alone,
; c = defender (DAMAGE_RACE_PLAYER / DAMAGE_RACE_ENEMY),
; wDamageRaceDamage = attacker's best hit.
; If the defender has a usable healing move that heals more per use than the
; attacker deals per hit, it can't be worn down: the attacker only wins by
; KOing it in one hit (from its current HP, or from its HP after healing if
; the defender moves first: priority heal like Slack Off, or faster).
; Rest counts if the attacker can't KO it from full HP within the turns it
; spends asleep. A heal smaller than the attacker's hit doesn't change the
; race (the healer loses a turn for less HP than the attacker takes).
; Returns the adjusted number of hits in a.
	ld [wDamageRaceHits], a
	ld a, c
	ld [wDamageRaceSide], a
	xor a
	ld [wDamageRaceHealFlags], a
	ld [wDamageRaceHealHP], a
	ld [wDamageRaceHealHP + 1], a

	call DamageRace_GetUsableMoves
.loop
	dec b
	jr z, .checked_moves
	ld a, [de]
	and a
	jr z, .checked_moves
	inc de
	push de
	push bc
	call DamageRace_CheckHealMove
	pop bc
	pop de
	jr .loop

.checked_moves
	ld a, [wDamageRaceHealFlags]
	bit DAMAGE_RACE_CAN_HEAL_F, a
	jr nz, .can_heal
	ld a, [wDamageRaceHits]
	ret

.can_heal
	; the defender heals before the attacker's hit if its heal has priority
	; or it's faster
	bit DAMAGE_RACE_HEAL_PRIORITY_F, a
	jr nz, .heals_first
	farcall DoesAIOutSpeedPlayer ; carry: the enemy is faster
	ld a, 0
	rla
	ld b, a
	ld a, [wDamageRaceSide]
	xor b
	jr z, .heals_first
	call DamageRace_GetDefenderHP
	jr .check_one_hit

.heals_first
	call DamageRace_GetDefenderHP
	; de = min(current HP + heal, max HP)
	ld a, [wDamageRaceHealHP + 1]
	add e
	ld e, a
	ld a, [wDamageRaceHealHP]
	adc d
	ld d, a
	ld a, c
	sub e
	ld a, b
	sbc d
	jr nc, .check_one_hit
	ld d, b
	ld e, c

.check_one_hit
	; attacker's best hit >= de: one hit, otherwise it can't win
	ld a, [wDamageRaceDamage + 1]
	sub e
	ld a, [wDamageRaceDamage]
	sbc d
	ld a, 1
	ret nc
	ld a, 255
	ret

DamageRace_CheckHealMove:
; a = a move of the defender. If it's a healing move that outpaces the
; attacker, set DAMAGE_RACE_CAN_HEAL_F and keep the biggest heal amount.
	push af
	dec a
	ld hl, Moves + MOVE_EFFECT
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld a, BANK(Moves)
	call GetFarByte
	ld l, a ; effect
	pop af
	ld h, a ; move
	call DamageRace_GetDefenderHP ; bc = max HP
	ld a, l
	cp EFFECT_SLACK_OFF
	jr z, .slack_off
	cp EFFECT_WEATHER_HEAL
	jr z, .weather_heal
	cp EFFECT_HEAL
	ret nz
	ld a, h
	cp REST
	jr z, .rest
	; Recover, Roost, Softboiled, Milk Drink: 1/2 max HP
	srl b
	rr c
	jr .compare_heal

.slack_off
	; 1/3 max HP, with priority
	call DamageRace_DivideBCBy3
	call .compare_heal
	ret nc
	ld hl, wDamageRaceHealFlags
	set DAMAGE_RACE_HEAL_PRIORITY_F, [hl]
	ret

.weather_heal
	; Healing Light: 1/2 max HP, all of it in sun, 1/4 in other weather
	ld a, [wBattleWeather]
	cp WEATHER_SUN
	jr z, .compare_heal
	and a
	jr z, .half
	srl b
	rr c
.half
	srl b
	rr c
	jr .compare_heal

.rest
	; full HP, then asleep for REST_SLEEP_TURNS turns: it only outpaces the
	; attacker if the attacker can't KO it from full HP in that time
	push bc
	ld a, [wDamageRaceSide]
	and a
	ld hl, wBattleMonMaxHP
	jr z, .got_max_hp
	ld hl, wEnemyMonMaxHP
.got_max_hp
	ld a, [wDamageRaceDamage]
	ld b, a
	ld a, [wDamageRaceDamage + 1]
	ld c, a
	call DamageRace_HitsToKO
	pop bc
	cp REST_SLEEP_TURNS + 2
	ret c
	jr .keep_heal

.compare_heal
; bc = heal amount. If it's more than the attacker's best hit, mark the
; defender as able to heal and keep the biggest heal amount.
; Returns carry if it was more.
	ld a, [wDamageRaceDamage + 1]
	sub c
	ld a, [wDamageRaceDamage]
	sbc b
	ret nc ; hit >= heal
.keep_heal
	ld hl, wDamageRaceHealFlags
	set DAMAGE_RACE_CAN_HEAL_F, [hl]
	ld a, [wDamageRaceHealHP + 1]
	sub c
	ld a, [wDamageRaceHealHP]
	sbc b
	jr nc, .done
	ld a, b
	ld [wDamageRaceHealHP], a
	ld a, c
	ld [wDamageRaceHealHP + 1], a
.done
	scf
	ret

DamageRace_GetDefenderHP:
; Return de = the defender's current HP and bc = its max HP.
	ld a, [wDamageRaceSide]
	and a
	jr nz, .enemy
	ld a, [wBattleMonHP]
	ld d, a
	ld a, [wBattleMonHP + 1]
	ld e, a
	ld a, [wBattleMonMaxHP]
	ld b, a
	ld a, [wBattleMonMaxHP + 1]
	ld c, a
	ret
.enemy
	ld a, [wEnemyMonHP]
	ld d, a
	ld a, [wEnemyMonHP + 1]
	ld e, a
	ld a, [wEnemyMonMaxHP]
	ld b, a
	ld a, [wEnemyMonMaxHP + 1]
	ld c, a
	ret

DamageRace_DivideBCBy3:
; bc = bc / 3
	push de
	ld d, b
	ld e, c
	ld bc, 0
.loop
	ld a, e
	sub 3
	ld e, a
	ld a, d
	sbc 0
	ld d, a
	jr c, .done
	inc bc
	jr .loop
.done
	pop de
	ret

DamageRace_ReloadMoveStructs:
	ld a, [wCurPlayerMove]
	and a
	jr z, .enemy
	ld de, wPlayerMoveStruct
	call .copy
.enemy
	ld a, [wCurEnemyMove]
	and a
	ret z
	ld de, wEnemyMoveStruct
.copy
	dec a
	ld hl, Moves
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld a, BANK(Moves)
	jmp FarCopyBytes
