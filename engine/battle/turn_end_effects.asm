FarTurnEndEffects:
	call HandleMysteryberry
	call HandleStatBoostingHeldItems
	call HandleWeatherItem
	call HandleSafeguard
	call HandleMist
	call HandleScreens
	call HandleFlameOrb
	call HandleToxicOrb
	call HandleTrickRoom
	; fallthrough

HandleEncore:
	ldh a, [hSerialConnectionStatus]
	cp USING_EXTERNAL_CLOCK
	jr z, .player_1
	call .do_player
	jr .do_enemy

.player_1
	call .do_enemy
.do_player
	ld hl, wPlayerSubStatus5
	bit SUBSTATUS_ENCORED, [hl]
	ret z
	ld a, [wPlayerEncoreCount]
	dec a
	ld [wPlayerEncoreCount], a
	jr z, .end_player_encore
	ld hl, wBattleMonPP
	ld a, [wCurMoveNum]
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl]
	and PP_MASK
	ret nz

.end_player_encore
	ld hl, wPlayerSubStatus5
	res SUBSTATUS_ENCORED, [hl]
	call SetEnemyTurn
	ld hl, BattleText_TargetsEncoreEnded
	jmp StdBattleTextbox

.do_enemy
	ld hl, wEnemySubStatus5
	bit SUBSTATUS_ENCORED, [hl]
	ret z
	ld a, [wEnemyEncoreCount]
	dec a
	ld [wEnemyEncoreCount], a
	jr z, .end_enemy_encore
	ld hl, wEnemyMonPP
	ld a, [wCurEnemyMoveNum]
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl]
	and PP_MASK
	ret nz

.end_enemy_encore
	ld hl, wEnemySubStatus5
	res SUBSTATUS_ENCORED, [hl]
	call SetPlayerTurn
	ld hl, BattleText_TargetsEncoreEnded
	jmp StdBattleTextbox

HandleTrickRoom:
	ld hl, wTrickRoomCount
	ld a, [hl]
	and a
	ret z
	dec [hl]
	ret nz
	ld hl, TrickRoomEndedText
	jmp StdBattleTextbox

TurnEndForBothSides:
; Call hl once for each side, with hBattleTurn set to it: the player's side
; first, unless this is the external-clock side of a link battle.
	ldh a, [hSerialConnectionStatus]
	cp USING_EXTERNAL_CLOCK
	ld a, 0 ; player first
	jr nz, .got_first
	inc a ; enemy first
.got_first
	push hl
	push af
	call .side
	pop af
	pop hl
	xor 1
.side
	ldh [hBattleTurn], a
	jp hl

SentOutThisTurn:
; Return nz if the current side's (hBattleTurn) mon was sent out this turn
; (switched in, replaced a fainted mon, U-turn, Baton Pass...): its held
; items don't activate until the end of its next turn.
	ldh a, [hBattleTurn]
	and a
	ld a, [wCurBattleMon]
	ld hl, wPlayerTurnStartMon
	jr z, .got_side
	ld a, [wCurOTMon]
	ld hl, wEnemyTurnStartMon
.got_side
	cp [hl]
	ret

GetSideHeldItem:
; Return the current side's (hBattleTurn) held item at bc and its party
; struct's copy at hl, unless its mon was sent out this turn (then nz).
	call SentOutThisTurn
	ret nz
	ldh a, [hBattleTurn]
	and a
	jr nz, .enemy
	farcall GetPartymonItem
	xor a
	ret
.enemy
	farcall GetOTPartymonItem
	xor a
	ret

HandleStatBoostingHeldItems:
; The effects handled here are not used in-game.
	ld hl, .Side
	jr TurnEndForBothSides

.Side:
	call GetSideHeldItem
	ret nz
.HandleItem:
	ld d, h
	ld e, l
	push de
	push bc
	ld a, [bc]
	ld b, a
	callfar GetItemHeldEffect
	ld hl, HeldStatUpItems
.loop
	ld a, [hli]
	cp -1
	jr z, .finish
	inc hl
	inc hl
	cp b
	jr nz, .loop
	pop bc
	ld a, [bc]
	ld [wNamedObjectIndex], a
	push bc
	dec hl
	dec hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, BANK(BattleCommand_AttackUp)
	rst FarCall
	pop bc
	pop de
	ld a, [wFailedMessage]
	and a
	ret nz
	xor a
	ld [bc], a
	ld [de], a
	call GetItemName
	farcall SwitchTurnCore
	farcall ItemRecoveryAnim
	farcall SwitchTurnCore
	ld hl, BattleText_UsersStringBuffer1Activated
	call StdBattleTextbox
	farjp BattleCommand_StatUpMessage

.finish
	pop bc
	pop de
	ret

INCLUDE "data/battle/held_stat_up.asm"

HandleWeatherItem:
	ld hl, .Side
	jmp TurnEndForBothSides

.Side:
	call GetSideHeldItem
	ret nz
.HandleItem:
	ld d, h
	ld e, l
	push de
	push bc
	ld a, [bc]
	ld b, a
	callfar GetItemHeldEffect
	ld hl, HeldWeatherItems
.loop
	ld a, [hli]
	cp -1
	jmp z, .finish
	inc hl
	inc hl
	cp b
	jr nz, .loop
	; that weather is already up: keep the shard (using it would only reset
	; the weather to 8 turns, cutting a longer or permanent weather short)
	call .GetShardWeather
	ld a, [wBattleWeather]
	cp c
	jr z, .finish
	pop bc
	ld a, [bc]
	ld [wNamedObjectIndex], a
	push bc
	dec hl
	dec hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	xor a
	ld [wAttackMissed], a
	ld a, BANK(StartWeatherItem)
	rst FarCall
	pop bc
	pop de
	xor a
	ld [bc], a
	ld [de], a
	call GetItemName
	farcall SwitchTurnCore
	farcall ItemRecoveryAnim
	farcall SwitchTurnCore
	ld hl, BattleText_UsersStringBuffer1Activated
	call StdBattleTextbox

	push hl
	push de
	push bc

	ld a, [wBattleWeather]
	cp WEATHER_SUN
	jr z, .SunAnim
	cp WEATHER_SANDSTORM
	jr z, .SandstormAnim
	cp WEATHER_HAIL
	jr z, .HailAnim

;.RainAnim
	ld a, RAIN_DANCE
	call BattleItemAnimCommon
	ld hl, DownpourText
	call StdBattleTextbox
	jr .FinishAnim

.SunAnim
	ld a, SUNNY_DAY
	call BattleItemAnimCommon
	ld hl, SunsRaysIntensifiedText
	call StdBattleTextbox
	jr .FinishAnim

.HailAnim
	ld a, HAIL
	call BattleItemAnimCommon
	ld hl, ItStartedToHailText
	call StdBattleTextbox
	jr .FinishAnim

.SandstormAnim
	ld a, SANDSTORM
	call BattleItemAnimCommon
	ld hl, SandstormBrewedText
	call StdBattleTextbox
	; fallthrough

.FinishAnim
	pop hl
.finish
	pop bc
	pop de
	ret

.GetShardWeather:
; b = held effect of a weather shard. Return the weather it sets in c.
	ld c, WEATHER_RAIN
	ld a, b
	cp HELD_SET_RAIN
	ret z
	ld c, WEATHER_SUN
	cp HELD_SET_SUN
	ret z
	ld c, WEATHER_SANDSTORM
	cp HELD_SET_SAND
	ret z
	ld c, WEATHER_HAIL
	ret

	assert BANK(StartWeatherItem) == BANK(BattleCommand_ItemRain) && \
		BANK(StartWeatherItem) == BANK(BattleCommand_ItemSun) && \
		BANK(StartWeatherItem) == BANK(BattleCommand_ItemSandstorm) && \
		BANK(StartWeatherItem) == BANK(BattleCommand_ItemHail), \
		"weather shard routines must share a bank"

BattleItemAnimCommon:
	ld [wFXAnimID], a
	xor a
	ld [wNumHits], a
	ld [wFXAnimID + 1], a
	predef_jump PlayBattleAnim

HandleMysteryberry:
	ld hl, .do_it
	jmp TurnEndForBothSides

.do_it
	call SentOutThisTurn
	ret nz
	callfar GetUserItem
	ld a, b
	cp HELD_RESTORE_PP
	jr nz, .quit
	ld hl, wPartyMon1PP
	ld a, [wCurBattleMon]
	call GetPartyLocation
	ld d, h
	ld e, l
	ld hl, wPartyMon1Moves
	ld a, [wCurBattleMon]
	call GetPartyLocation
	ldh a, [hBattleTurn]
	and a
	jr z, .wild
	ld de, wWildMonPP
	ld hl, wWildMonMoves
	ld a, [wBattleMode]
	dec a
	jr z, .wild
	ld hl, wOTPartyMon1PP
	ld a, [wCurOTMon]
	call GetPartyLocation
	ld d, h
	ld e, l
	ld hl, wOTPartyMon1Moves
	ld a, [wCurOTMon]
	call GetPartyLocation

.wild
	ld c, $0
.loop
	ld a, [hl]
	and a
	jr z, .quit
	ld a, [de]
	and PP_MASK
	jr z, .restore
	inc hl
	inc de
	inc c
	ld a, c
	cp NUM_MOVES
	jr nz, .loop

.quit
	ret

.restore
	; lousy hack
	ld a, [hl]
	cp SKETCH
	ld b, 1
	jr z, .sketch
	ld b, 5
.sketch
	ld a, [de]
	add b
	ld [de], a
	push bc
	push bc
	ld a, [hl]
	ld [wTempByteValue], a
	ld de, wBattleMonMoves - 1
	ld hl, wBattleMonPP
	ldh a, [hBattleTurn]
	and a
	jr z, .player_pp
	ld de, wEnemyMonMoves - 1
	ld hl, wEnemyMonPP
.player_pp
	inc de
	pop bc
	ld b, 0
	add hl, bc
	push hl
	ld h, d
	ld l, e
	add hl, bc
	pop de
	pop bc

	ld a, [wTempByteValue]
	cp [hl]
	jr nz, .skip_checks
	ldh a, [hBattleTurn]
	and a
	ld a, [wPlayerSubStatus5]
	jr z, .check_transform
	ld a, [wEnemySubStatus5]
.check_transform
	bit SUBSTATUS_TRANSFORMED, a
	jr nz, .skip_checks
	ld a, [de]
	add b
	ld [de], a
.skip_checks
	callfar GetUserItem
	ld a, [hl]
	ld [wNamedObjectIndex], a
	xor a
	ld [hl], a
	farcall GetPartymonItem
	ldh a, [hBattleTurn]
	and a
	jr z, .consume_item
	ld a, [wBattleMode]
	dec a
	jr z, .skip_consumption
	farcall GetOTPartymonItem

.consume_item
	xor a
	ld [hl], a

.skip_consumption
	call GetItemName
	farcall SwitchTurnCore
	farcall ItemRecoveryAnim
	farcall SwitchTurnCore
	ld hl, BattleText_UserRecoveredPPUsing
	jmp StdBattleTextbox

HandleSafeguard:
	ld hl, .Side
	jmp TurnEndForBothSides

.Side:
	ld a, 1 << SCREENS_SAFEGUARD
	ld de, wPlayerSafeguardCount
	ld hl, BattleText_SafeguardFaded
	jr TickSideTimer

HandleMist:
	ld hl, .Side
	jmp TurnEndForBothSides

.Side:
	ld a, 1 << SCREENS_MIST
	ld de, wPlayerMistCount
	ld hl, BattleText_MistFaded
	; fallthrough

TickSideTimer:
; Count down the current side's (hBattleTurn) timer for the SCREENS_* mask a;
; de = the player's counter (the enemy's is the same distance further as
; wEnemySafeguardCount is from wPlayerSafeguardCount). When it runs out,
; clear the mask and print text hl.
	assert wEnemyMistCount - wPlayerMistCount == wEnemySafeguardCount - wPlayerSafeguardCount
	push hl
	ld c, a
	ld hl, wPlayerScreens
	ldh a, [hBattleTurn]
	and a
	jr z, .got_side
	ld a, wEnemySafeguardCount - wPlayerSafeguardCount
	add e
	ld e, a
	adc d
	sub e
	ld d, a
	ld hl, wEnemyScreens
.got_side
	ld a, [hl]
	and c
	jr z, .done
	ld a, [de]
	dec a
	ld [de], a
	jr nz, .done
	ld a, c
	cpl
	and [hl]
	ld [hl], a
	pop hl
	jmp StdBattleTextbox

.done
	pop hl
	ret

HandleScreens:
	ld hl, .Side
	jmp TurnEndForBothSides

.Side:
	ldh a, [hBattleTurn]
	and a
	ld de, .Your
	ld hl, wPlayerScreens
	ld bc, wPlayerLightScreenCount
	jr z, .got_side
	ld de, .Enemy
	ld hl, wEnemyScreens
	ld bc, wEnemyLightScreenCount
.got_side
	push hl
	push bc
	call .Copy
	pop de
	pop hl
	bit SCREENS_LIGHT_SCREEN, [hl]
	call nz, .LightScreenTick
	bit SCREENS_REFLECT, [hl]
	call nz, .ReflectTick
	ret

.Copy:
	ld hl, wStringBuffer1
	jmp CopyName2

.Your:
	db "Your@"
.Enemy:
	db "Foe@"

.LightScreenTick:
	ld a, [de]
	dec a
	ld [de], a
	ret nz
	res SCREENS_LIGHT_SCREEN, [hl]
	push hl
	push de
	farcall SwitchTurnCore
	ld hl, BattleText_MonsLightScreenFell
	call StdBattleTextbox
	pop de
	pop hl
	ret

.ReflectTick:
	inc de
	ld a, [de]
	dec a
	ld [de], a
	ret nz
	res SCREENS_REFLECT, [hl]
	farcall SwitchTurnCore
	ld hl, BattleText_MonsReflectFaded
	jmp StdBattleTextbox

HandleFlameOrb:
	call TurnEnd_ClearFailures
	ld hl, .Side
	jmp TurnEndForBothSides

.Side:
	callfar GetUserItem
	ld a, b
	cp HELD_FLAME_ORB
	ret nz
	call GetOrbTarget
	ret nc
	cp MEGANIUM
	ret z
	cp SYLVEON
	ret z
	cp MEW
	ret z
	ld a, FIRE
	cp b
	ret z
	cp c
	ret z
	ld hl, FlameOrbText
	call OrbStatusText
	set BRN, [hl]
	call UpdateUserInParty
	farcall BattleCommand_SwitchTurn
	ld hl, ApplyBrnEffectOnAttack
	ld a, BANK("Battle Core")
	rst FarCall
	ld de, ANIM_BRN
	jr OrbAnim

HandleToxicOrb:
	call TurnEnd_ClearFailures
	ld hl, .Side
	jmp TurnEndForBothSides

.Side:
	callfar GetUserItem
	ld a, b
	cp HELD_TOXIC_ORB
	ret nz
	call GetOrbTarget
	ret nc
	cp CHIKORITA ; to prevent poisoning
	ret z
	cp BAYLEEF ; to prevent poisoning
	ret z
	cp MEGANIUM
	ret z
	cp SYLVEON
	ret z
	cp MEW
	ret z
	ld a, POISON
	cp b
	ret z
	cp c
	ret z
	ld a, STEEL
	cp b
	ret z
	cp c
	ret z
	ld hl, ToxicOrbText
	call OrbStatusText
	set PSN, [hl]
	ld a, BATTLE_VARS_SUBSTATUS5
	call GetBattleVarAddr
	set SUBSTATUS_TOXIC, [hl]
	ldh a, [hBattleTurn]
	and a
	ld hl, wPlayerToxicCount
	jr z, .got_toxic_count
	ld hl, wEnemyToxicCount
.got_toxic_count
	ld [hl], 0
	call UpdateUserInParty
	farcall BattleCommand_SwitchTurn
	ld de, ANIM_PSN
	; fallthrough

OrbAnim:
	farcall PlayOpponentBattleAnim
	farjp BattleCommand_SwitchTurn

TurnEnd_ClearFailures:
	xor a
	ld [wFailedMessage], a
	ld [wEffectFailed], a
	ld [wAttackMissed], a
	ret

GetOrbTarget:
; Carry if the current side's (hBattleTurn) mon has no status and wasn't
; sent out this turn, with its types in b and c and its species in a.
	ld a, BATTLE_VARS_STATUS
	call GetBattleVar
	and a
	jr nz, .no
	call SentOutThisTurn
	jr nz, .no
	ldh a, [hBattleTurn]
	and a
	ld hl, wBattleMonType1
	ld a, [wBattleMonSpecies]
	jr z, .got_side
	ld hl, wEnemyMonType1
	ld a, [wEnemyMonSpecies]
.got_side
	ld b, [hl]
	inc hl
	ld c, [hl]
	scf
	ret

.no
	and a
	ret

OrbStatusText:
; Print text hl (unless status texts are off) and return the current side's
; status at hl.
	push hl
	call ClearSprites
	pop hl
	call CheckStatusText
	call z, StdBattleTextbox
	ld a, BATTLE_VARS_STATUS
	jmp GetBattleVarAddr
