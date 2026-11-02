; Draining moves (Absorb, Mega Drain, Giga Drain, Drain Punch, Drain Kiss,
; Leech Life, Aeroblast, Sacred Fire; Dream Eater while the player's mon is
; asleep) give back half the damage they deal. AI_PreferDrainMoves makes
; the AI use them when that helps it:
; 1. Finish with a drain move: the enemy is at half HP or less, moves first
;    (faster, or the drain move has priority) and the drain move KOs the
;    player's mon even at its lowest roll -> that move becomes the clear pick
;    (it gets HP back on the way out).
; 2. Drain to win: the enemy would lose the normal 1-on-1 (GetDamageRaceHits),
;    but wins it by using the drain move every turn and healing half the
;    damage each time -> the drain move is strongly encouraged.
;    Not used for Dream Eater (the player's mon can wake up).

DEF AI_DRAIN_FASTER_F    EQU 0
DEF AI_DRAIN_LOW_HP_F    EQU 1
DEF AI_DRAIN_RACE_LOST_F EQU 2

DEF AI_DRAIN_RACE_MAX_TURNS EQU 32
DEF AI_DRAIN_ENCOURAGE      EQU 10 ; as much as DoIt
DEF AI_DRAIN_SCORE_BIAS     EQU 32 ; NormalizeAIMoveScores reads $e0-$ff as -32..-1

; scratch RAM, borrowed from the switch-in selection like the damage race
; (only written after GetDamageRaceHits, which uses them too, has returned)
DEF wAIDrainHit       EQUS "wEnemySwitchBestDamage" ; dw, big-endian: drain move's lowest roll
DEF wAIDrainPlayerHit EQUS "wEnemySwitchMaxDamage"  ; dw, big-endian: player's best hit (DamageRace_PlayerMaxDamage)

AI_PreferDrainMoves:
; Called from NormalizeAIMoveScores after the scoring layers.
	; locked into one move (choice item or Encore): nothing to choose
	ld a, [wEnemySubStatus5]
	bit SUBSTATUS_ENCORED, a
	ret nz

	; another rule (e.g. speed first, then KO) already picked a move
	ld hl, wEnemyAIMoveScores
	ld b, NUM_MOVES
.check_picked
	ld a, [hli]
	cp $e0
	ret z
	dec b
	jr nz, .check_picked

	call AIDrain_HasDrainMove
	ret nc

	ldh a, [hBattleTurn]
	push af
	ld a, [wCurDamage]
	push af
	ld a, [wCurDamage + 1]
	push af

	call AIDrain_GetFlags
	farcall DamageRace_PlayerMaxDamage ; wAIDrainPlayerHit
	xor a
	ld [wCriticalHit], a

	ld c, 0 ; move slot
.loop
	ld a, c
	cp NUM_MOVES
	jr z, .done
	push bc
	call AIDrain_CheckSlot
	pop bc
	jr c, .done ; picked
	inc c
	jr .loop

.done
	farcall DamageRace_ReloadMoveStructs
	pop af
	ld [wCurDamage + 1], a
	pop af
	ld [wCurDamage], a
	pop af
	ldh [hBattleTurn], a
	ret

AIDrain_HasDrainMove:
; Return carry if any of the enemy's moves is a draining move.
	ld hl, wEnemyMonMoves
	ld b, NUM_MOVES
.loop
	ld a, [hli]
	and a
	ret z ; no more moves (carry clear)
	push hl
	push bc
	dec a
	ld hl, Moves + MOVE_EFFECT
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld a, BANK(Moves)
	call GetFarByte
	pop bc
	pop hl
	cp EFFECT_LEECH_HIT
	jr z, .yes
	cp EFFECT_SACRED_FIRE
	jr z, .yes
	cp EFFECT_DREAM_EATER
	jr z, .yes
	dec b
	jr nz, .loop
	and a
	ret

.yes
	scf
	ret

AIDrain_GetFlags:
; Set wAIDrainFlags: faster, at half HP or less, losing the normal 1-on-1.
	xor a
	ld [wAIDrainFlags], a
	farcall DoesAIOutSpeedPlayer
	jr nc, .check_hp
	ld hl, wAIDrainFlags
	set AI_DRAIN_FASTER_F, [hl]

.check_hp
	; HP * 2 <= max HP
	ld a, [wEnemyMonHP + 1]
	ld c, a
	ld a, [wEnemyMonHP]
	ld b, a
	sla c
	rl b
	ld a, [wEnemyMonMaxHP + 1]
	sub c
	ld a, [wEnemyMonMaxHP]
	sbc b
	jr c, .race
	ld hl, wAIDrainFlags
	set AI_DRAIN_LOW_HP_F, [hl]

.race
	farcall GetDamageRaceHits ; b = enemy's hits to KO, c = player's hits to KO
	ld a, b
	cp 255
	ret z ; can't wear the player's mon down at all (e.g. it out-heals us)
	cp c
	ret c ; already wins
	jr nz, .lost
	ld a, [wAIDrainFlags]
	bit AI_DRAIN_FASTER_F, a
	ret nz ; same number of hits and faster: already wins
.lost
	ld hl, wAIDrainFlags
	set AI_DRAIN_RACE_LOST_F, [hl]
	ret

AIDrain_CheckSlot:
; c = move slot. Apply the drain move rules to it.
; Return carry if it was made the clear pick.
	ld hl, wEnemyMonMoves
	ld b, 0
	add hl, bc
	ld a, [hl]
	and a
	ret z
	ld b, a ; move

	; skip disabled moves and moves with no PP
	ld a, [wEnemyDisabledMove]
	cp b
	jmp z, .no
	ld hl, wEnemyMonPP
	ld a, l
	add c
	ld l, a
	adc h
	sub l
	ld h, a
	ld a, [hl]
	and PP_MASK
	jmp z, .no

	push bc
	ld a, b
	dec a
	ld hl, Moves
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld de, wEnemyMoveStruct
	ld a, BANK(Moves)
	call FarCopyBytes
	pop bc
	ld a, [wEnemyMoveStruct + MOVE_POWER]
	and a
	jmp z, .no

	ld e, 0 ; 1: Dream Eater
	ld a, [wEnemyMoveStruct + MOVE_EFFECT]
	cp EFFECT_LEECH_HIT
	jr z, .drain
	cp EFFECT_SACRED_FIRE
	jr z, .drain
	cp EFFECT_DREAM_EATER
	jmp nz, .no
	ld a, [wBattleMonStatus]
	and SLP_MASK
	jmp z, .no
	inc e

.drain
	; no effect because of an ability (Levitate etc.)
	push bc
	push de
	ld a, [wEnemyMoveStruct + MOVE_TYPE]
	and TYPE_MASK
	ld b, a
	farcall AI_IsPlayerImmuneByAbility
	pop de
	pop bc
	jr c, .no

	; lowest damage roll
	push bc
	push de
	ld a, 1
	ldh [hBattleTurn], a
	callfar EnemyAttackDamage
	callfar BattleCommand_DamageCalc
	callfar BattleCommand_Stab
	call AIDrain_MinRoll
	ld a, b
	ld [wAIDrainHit], a
	ld a, c
	ld [wAIDrainHit + 1], a
	pop de
	pop bc
	ld a, [wAIDrainHit]
	ld h, a
	ld a, [wAIDrainHit + 1]
	or h
	jr z, .no ; no damage (type immunity)

	; 1. low HP, moves first and KOs: finish with it
	ld a, [wAIDrainFlags]
	bit AI_DRAIN_LOW_HP_F, a
	jr z, .race
	call AIDrain_KOs
	jr nc, .race
	ld a, [wAIDrainFlags]
	bit AI_DRAIN_FASTER_F, a
	jr nz, .pick
	; slower, but a priority drain move still moves first
	push bc
	ld a, [wEnemyMonItem]
	ld c, a
	farcall GetMovePriority_Far
	ld a, b
	pop bc
	cp BASE_PRIORITY + 1
	jr nc, .pick

.race
	; 2. drain to win the 1-on-1 it would otherwise lose
	ld a, e
	and a
	jr nz, .no ; Dream Eater: the player's mon can wake up
	ld a, [wAIDrainFlags]
	bit AI_DRAIN_RACE_LOST_F, a
	jr z, .no
	push bc
	call AIDrain_WinsRace
	pop bc
	jr nc, .no

	; strongly encourage it (without wrapping past -32)
	ld hl, wEnemyAIMoveScores
	ld b, 0
	add hl, bc
	ld a, [hl]
	add AI_DRAIN_SCORE_BIAS
	sub AI_DRAIN_ENCOURAGE
	jr nc, .store
	xor a
.store
	sub AI_DRAIN_SCORE_BIAS
	ld [hl], a
.no
	and a
	ret

.pick
	; the lowest score there is (NormalizeAIMoveScores reads $e0 as -32)
	ld hl, wEnemyAIMoveScores
	ld b, 0
	add hl, bc
	ld [hl], $e0
	scf
	ret

AIDrain_MinRoll:
; Return in bc wCurDamage at its lowest damage roll
; (* (85 percent + 1) / (100 percent), as in AI_MinRollKOsPlayer).
	xor a
	ldh [hMultiplicand + 0], a
	ld a, [wCurDamage]
	ldh [hMultiplicand + 1], a
	ld a, [wCurDamage + 1]
	ldh [hMultiplicand + 2], a
	ld a, 85 percent + 1
	ldh [hMultiplier], a
	call Multiply
	ld a, 100 percent
	ldh [hDivisor], a
	ld b, 4
	call Divide
	ldh a, [hQuotient + 2]
	ld b, a
	ldh a, [hQuotient + 3]
	ld c, a
	ret

AIDrain_KOs:
; Return carry if wAIDrainHit >= the player's current HP. Preserves bc, de.
	ld a, [wBattleMonHP + 1]
	ld l, a
	ld a, [wBattleMonHP]
	ld h, a
	ld a, [wAIDrainHit + 1]
	sub l
	ld a, [wAIDrainHit]
	sbc h
	ccf
	ret

AIDrain_WinsRace:
; Play out the 1-on-1 with the enemy using its drain move (wAIDrainHit,
; lowest roll) every turn and healing half the damage dealt, against the
; player's best hit (wAIDrainPlayerHit, highest roll). Turn order from
; AI_DRAIN_FASTER_F. Return carry if the enemy wins.
	ld a, [wEnemyMonHP]
	ld [wAIDrainSimEnemyHP], a
	ld a, [wEnemyMonHP + 1]
	ld [wAIDrainSimEnemyHP + 1], a
	ld a, [wBattleMonHP]
	ld [wAIDrainSimPlayerHP], a
	ld a, [wBattleMonHP + 1]
	ld [wAIDrainSimPlayerHP + 1], a

	ld b, AI_DRAIN_RACE_MAX_TURNS
.turn
	push bc
	ld a, [wAIDrainFlags]
	bit AI_DRAIN_FASTER_F, a
	jr nz, .enemy_first
	call .player_hits
	jr c, .lose
	call .enemy_hits
	jr c, .win
	jr .next

.enemy_first
	call .enemy_hits
	jr c, .win
	call .player_hits
	jr c, .lose

.next
	pop bc
	dec b
	jr nz, .turn
	and a ; still going: don't count on it
	ret

.win
	pop bc
	scf
	ret

.lose
	pop bc
	and a
	ret

.player_hits
; Return carry if the enemy faints.
	ld a, [wAIDrainPlayerHit]
	ld b, a
	ld a, [wAIDrainPlayerHit + 1]
	ld c, a
	ld hl, wAIDrainSimEnemyHP
	jr .subtract

.enemy_hits
; Return carry if the player's mon faints; otherwise heal the enemy by half
; the damage (at least 1, up to its max HP).
	ld a, [wAIDrainHit]
	ld b, a
	ld a, [wAIDrainHit + 1]
	ld c, a
	ld hl, wAIDrainSimPlayerHP
	call .subtract
	ret c
	srl b
	rr c
	ld a, b
	or c
	jr nz, .heal
	inc c
.heal
	ld hl, wAIDrainSimEnemyHP + 1
	ld a, [hld]
	add c
	ld e, a
	ld a, [hl]
	adc b
	ld d, a
	; cap at max HP
	ld a, [wEnemyMonMaxHP + 1]
	sub e
	ld a, [wEnemyMonMaxHP]
	sbc d
	jr nc, .store_heal
	ld a, [wEnemyMonMaxHP]
	ld d, a
	ld a, [wEnemyMonMaxHP + 1]
	ld e, a
.store_heal
	ld a, d
	ld [hli], a
	ld [hl], e
	and a
	ret

.subtract
; hl = big-endian HP, bc = damage. Return carry if HP drops to 0.
	inc hl
	ld a, [hl]
	sub c
	ld [hld], a
	ld a, [hl]
	sbc b
	ld [hli], a
	jr c, .fainted
	or [hl]
	ret nz ; carry is clear
.fainted
	scf
	ret
