SubstituteImmuneEffects:
	db EFFECT_SLEEP
	db EFFECT_POISON
	db EFFECT_PARALYZE
	db EFFECT_CONFUSE
	db EFFECT_LEECH_SEED
	db EFFECT_SPEED_DOWN
	db EFFECT_SP_ATK_DOWN
	db EFFECT_SP_DEF_DOWN
	db EFFECT_EVASION_DOWN
	db EFFECT_ACCURACY_DOWN
	db EFFECT_DEFENSE_DOWN
	db EFFECT_ATTACK_DOWN
	db EFFECT_ATTACK_DOWN_2
	db EFFECT_DEFENSE_DOWN_2
	db EFFECT_SPEED_DOWN_2
	db EFFECT_SP_ATK_DOWN_2
	db EFFECT_SP_DEF_DOWN_2
	db EFFECT_ACCURACY_DOWN_2
	db EFFECT_EVASION_DOWN_2
	db EFFECT_TRANSFORM
	db EFFECT_TOXIC
	db EFFECT_BURN
	db -1 ; end

AI_Basic:
; Don't do anything redundant:
;  -Using status-only moves if the player can't be statused
;  -Using moves that fail if they've already been used

	ld hl, wEnemyAIMoveScores - 1
	ld de, wEnemyMonMoves
	ld b, NUM_MOVES + 1
.checkmove
	dec b ; b is the number moves on 1st pass
	ret z ; if b is 0 return we are done

	inc hl ; increment score to next move score
	ld a, [de] ; load the move struct
	and a
	ret z ; return if no move

	inc de ; increment to next move
	call AIGetEnemyMove

	ld a, [wEnemyMoveStruct + MOVE_EFFECT]
	ld c, a ; load move effect into c

; Dismiss moves with special effects if they are
; useless or not a good choice right now.
; For example, healing moves, weather moves, Dream Eater...

; if move locked dismiss all moves except the last one used
; this shouldn't be needed but for some reason AI enemies can switch moves when locked
	push hl
	ld hl, wEnemySubStatus5
	bit SUBSTATUS_ENCORED, [hl]
	pop hl
	jr z, .check_redundant
	ld a, [wLastEnemyMove]
	and a
	jr z, .check_redundant
	push bc
	ld b, a
	ld a, [wEnemyMoveStruct + MOVE_ANIM]
	cp b
	pop bc
	jr nz, .check_redundant
	xor a
	ld [hl], a ; set priority for last used move to max - which is 0
	jr .checkmove

.check_redundant
	push hl
	push de
	push bc
	farcall AI_Redundant
	pop bc
	pop de
	pop hl
	jmp nz, .discourage ; discourage if AI_Redundant - loop back to check move

; Taunt
; Check enemy is taunted or holding assault vest
; and discourage 0 power moves
	ld a, [wEnemyTauntCount]
	and a
	jr nz, .discourageNonDamagingMoves
	ld a, [wEnemyMonItem]
	cp ASSAULT_VEST
	jr nz, .check_status_immunity
.discourageNonDamagingMoves
	ld a, [wEnemyMoveStruct + MOVE_POWER]
	and a
	jmp z, .discourage

.check_status_immunity
; Dismiss status-only moves if the player can't be statused.
	ld a, [wEnemyMoveStruct + MOVE_EFFECT]
	push hl
	push de
	push bc
	ld hl, StatusOnlyEffects ; is the move status only
	call IsInByteArray
	pop bc
	pop de
	pop hl
	jr nc, .check_sub ; if not skip following

	ld a, [wBattleMonStatus]
	and a
	jmp nz, .discourage ; discourage if the player is already statused - loop back to check move

; don't use if enemy is immune to status
; =========================
; === Ability: Serenity ===
; =========================
	ld a, [wBattleMonSpecies]
	push hl
	push de
	push bc
	ld hl, SerenityPokemon_AI
	call IsInByteArray
	pop bc
	pop de
	pop hl
	jmp c, .discourage ; discourage if serenity pokemon - loop back to check move

.check_sub
; Dismiss status moves if the player has a Substitute.
	ld a, [wPlayerSubStatus4]
	bit SUBSTATUS_SUBSTITUTE, a ; check for substitute bit
	jr z, .check_levitate ; if the substitute bit is not set, then skip out of this block
	ld a, [wEnemyMoveStruct + MOVE_EFFECT]
	push hl
	push de
	push bc
	ld hl, SubstituteImmuneEffects
	call IsInByteArray
	pop bc
	pop de
	pop hl
	jmp c, .discourage ; discourage if sub is up and blocks move - loop back to check move

.check_levitate
; Dismiss ground move if the player has levitate
; =========================
; === Ability: Levitate ===
; =========================
	ld a, [wEnemyMoveStruct + MOVE_TYPE]
	and TYPE_MASK
	cp GROUND
	jr nz, .check_poison_immune
	ld a, [wBattleMonSpecies]
	push hl
	push de
	push bc
	ld hl, LevitatePokemon
	call IsInByteArray
	pop bc
	pop de
	pop hl
	jmp c, .discourage ; discourage if levitating pokemon - loop back to check move

.check_poison_immune
; Dismiss poison move if the player has immunity
; =========================
; === Ability: Immunity ===
; =========================
	cp POISON
	jr nz, .check_safeguard
	ld a, [wBattleMonSpecies]
	push hl
	push de
	push bc
	ld hl, ImmunityPokemon_AI
	call IsInByteArray
	pop bc
	pop de
	pop hl
	jmp c, .discourage ; discourage if poison immune pokemon - loop back to check move

.check_safeguard
; Dismiss Safeguard if it's already active.
	ld a, [wPlayerScreens]
	bit SCREENS_SAFEGUARD, a
	jmp z, .checkmove

; Dismiss Mist if it's already active.
	ld a, [wPlayerScreens]
	bit SCREENS_MIST, a
	jmp z, .checkmove

	ld a, [wEnemyMoveStruct + MOVE_POWER]
	and a
	jmp z, .checkmove

; if we are faster and player is flying or underground
; then don't encourage attacks
	call DoesAIOutSpeedPlayer
	jr nc, .calc_damage
	ld a, [wPlayerSubStatus3]
	and 1 << SUBSTATUS_FLYING | 1 << SUBSTATUS_UNDERGROUND
	jmp nz, .checkmove

.calc_damage
	ld a, 1
	ldh [hBattleTurn], a
	push hl
	push de
	push bc
	callfar EnemyAttackDamage
	callfar BattleCommand_DamageCalc
	callfar BattleCommand_Stab
	ld a, [wCurDamage + 1]
	ld c, a ; c is curDamage upper
	ld a, [wCurDamage]
	ld b, a ; b is curDamage lower
	ld a, [wBattleMonHP + 1]
	cp c ; compare upper
	ld a, [wBattleMonHP]
	sbc b ; compare lower and set flag
	pop bc
	pop de
	pop hl
	jmp nc, .checkmove

; don't encourage explosion as much
	ld a, [wEnemyMoveStruct + MOVE_EFFECT]
	cp EFFECT_EXPLOSION
	jr z, .explode_or_heal

; don't encourage recoil moves as much
; except for rock head pokemon
	push hl
	push de
	push bc
	ld hl, RockHeadPokemon_AI
	call IsInByteArray
	pop bc
	pop de
	pop hl
	jr c, .skip_recoil_check

	ld a, [wEnemyMoveStruct + MOVE_EFFECT]
	cp EFFECT_RECOIL_HIT
	jr z, .recoil

.skip_recoil_check
; if we are below 1/4 hp and have a healing move
; then lesser encourage so we can use it
	call AICheckEnemyQuarterHP
	jr c, .check_accuracy
	ld b, EFFECT_HEAL
	call AIHasMoveEffect
	jr c, .explode_or_heal

; don't encourage explosion as much
	ld a, [wEnemyMoveStruct + MOVE_EFFECT]
	cp EFFECT_EXPLOSION
	jr z, .explode_or_heal

.check_accuracy
; encourage more accurate moves if they can kill
	ld a, [wEnemyMoveStruct + MOVE_ACC]
	cp 100 percent
	jr c, .not_accurate

; encouragements to KO enemy
; standard attack = 9
; recoil attack = 7
; inaccurate attack = 5
; explode attack = 3
	dec [hl]
	dec [hl]
.recoil
	dec [hl]
	dec [hl]
.not_accurate
	dec [hl]
	dec [hl]
.explode_or_heal
	dec [hl]
	dec [hl]
	dec [hl]
	jmp .checkmove

.discourage
	call AIDiscourageMove
	jmp .checkmove
