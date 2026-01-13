DoPlayerTurn:
	call SetPlayerTurn
	ld a, [wBattlePlayerAction]
	and a ; BATTLEPLAYERACTION_USEMOVE?
	ret nz
	jr DoTurn

DoEnemyTurn:
	call SetEnemyTurn

	ld a, [wLinkMode]
	and a
	jr z, DoTurn

	ld a, [wBattleAction]
	cp BATTLEACTION_STRUGGLE
	jr z, DoTurn
	cp BATTLEACTION_SWITCH1
	ret nc
	; fallthrough

DoTurn:
; Read in and execute the user's move effects for this turn.

	xor a
	ld [wTurnEnded], a

	; Effect command checkturn is called for every move.
	call CheckTurn

	ld a, [wTurnEnded]
	and a
	ret nz

	call UpdateMoveData

DoMove:
; Get the user's move effect.
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	ld c, a
	ld b, 0
	ld hl, MoveEffectsPointers
	add hl, bc
	add hl, bc
	ld a, BANK(MoveEffectsPointers)
	call GetFarWord

	ld de, wBattleScriptBuffer

.GetMoveEffect:
	ld a, BANK(MoveEffects)
	call GetFarByte
	inc hl
	ld [de], a
	inc de
	cp endmove_command
	jr nz, .GetMoveEffect

; Start at the first command.
	ld hl, wBattleScriptBuffer
	ld a, l
	ld [wBattleScriptBufferAddress], a
	ld a, h
	ld [wBattleScriptBufferAddress + 1], a

.ReadMoveEffectCommand:
; ld a, [wBattleScriptBufferAddress++]
	ld a, [wBattleScriptBufferAddress]
	ld l, a
	ld a, [wBattleScriptBufferAddress + 1]
	ld h, a

	ld a, [hli]

	push af
	ld a, l
	ld [wBattleScriptBufferAddress], a
	ld a, h
	ld [wBattleScriptBufferAddress + 1], a
	pop af

; endturn_command (-2) is used to terminate branches without ending the read cycle.
	cp endturn_command
	ret nc

; The rest of the commands (01-af) are read from BattleCommandPointers.
	push bc
	dec a
	ld c, a
	ld b, 0
	ld hl, BattleCommandPointers
	add hl, bc
	add hl, bc
	pop bc

	ld a, BANK(BattleCommandPointers)
	call GetFarWord

	call .DoMoveEffectCommand

	jr .ReadMoveEffectCommand

.DoMoveEffectCommand:
	jp hl

CheckTurn:
BattleCommand_CheckTurn:
; Repurposed as hardcoded turn handling. Useless as a command.

; Move $ff immediately ends the turn.
	ld a, BATTLE_VARS_MOVE
	call GetBattleVar
	inc a
	jmp z, EndTurn

	xor a
	ld [wAttackMissed], a
	ld [wEffectFailed], a
	ld [wBattleAnimParam], a
	ld [wAlreadyFailed], a
	ld [wSomeoneIsRampaging], a

	ld a, EFFECTIVE
	ld [wTypeModifier], a

	ldh a, [hBattleTurn]
	and a
	jmp nz, CheckEnemyTurn

; check player turn
	ld hl, wPlayerSubStatus4
	bit SUBSTATUS_RECHARGE, [hl]
	jr z, .no_recharge

	res SUBSTATUS_RECHARGE, [hl]
	ld hl, MustRechargeText
	call StdBattleTextbox
	call CantMove
	jmp EndTurn

.no_recharge
	ld hl, wBattleMonStatus
	ld a, [hl]
	and SLP_MASK
	jr z, .not_asleep

	dec a
	ld [wBattleMonStatus], a
	and SLP_MASK
	jr z, .woke_up

	xor a
	ld [wNumHits], a
	ld de, ANIM_SLP
	call FarPlayBattleAnimation
	jr .fast_asleep

.woke_up
	ld hl, WokeUpText
	call StdBattleTextbox
	call CantMove
	call UpdateBattleMonInParty
	ld hl, UpdatePlayerHUD
	call CallBattleCore
	ld a, $1
	ldh [hBGMapMode], a
	ld hl, wPlayerSubStatus1
	res SUBSTATUS_NIGHTMARE, [hl]
	jr .not_asleep

.fast_asleep
	ld hl, FastAsleepText
	call StdBattleTextbox

	; Snore and Sleep Talk bypass sleep.
	ld a, [wCurPlayerMove]
	cp SNORE
	jr z, .not_asleep
	cp SLEEP_TALK
	jr z, .not_asleep

	call CantMove
	jmp EndTurn

.not_asleep
	ld hl, wPlayerSubStatus3
	bit SUBSTATUS_FLINCHED, [hl]
	jr z, .not_flinched

	res SUBSTATUS_FLINCHED, [hl]
	ld hl, FlinchedText
	call StdBattleTextbox

	call CantMove
	jmp EndTurn

.not_flinched
	ld hl, wPlayerDisableCount
	ld a, [hl]
	and a
	jr z, .not_disabled

	dec a
	ld [hl], a
	and $f
	jr nz, .not_disabled

	ld [hl], a
	ld [wDisabledMove], a
	ld hl, DisabledNoMoreText
	call StdBattleTextbox

.not_disabled
	; Taunt
	; decrement the player taunt count and
	; print a message when it ends
	ld hl, wPlayerTauntCount
	ld a, [hl]
	and a
	jr z, .not_taunted

	dec a
	ld [hl], a
	and $f
	jr nz, .not_taunted

	ld hl, TauntedNoMoreText
	call StdBattleTextbox

.not_taunted
	ld a, [wPlayerSubStatus3]
	add a
	jr nc, .not_confused
	ld hl, wPlayerConfuseCount
	dec [hl]
	jr nz, .confused

	ld hl, wPlayerSubStatus3
	res SUBSTATUS_CONFUSED, [hl]
	ld hl, ConfusedNoMoreText
	call StdBattleTextbox
	jr .not_confused

.confused
	ld hl, IsConfusedText
	call StdBattleTextbox
	xor a
	ld [wNumHits], a
	ld de, ANIM_CONFUSED
	call FarPlayBattleAnimation

	; 50% chance of hitting itself
	call BattleRandom
	cp 50 percent + 1
	jr nc, .not_confused

	; clear confusion-dependent substatus
	ld hl, wPlayerSubStatus3
	ld a, [hl]
	and 1 << SUBSTATUS_CONFUSED
	ld [hl], a

	call HitConfusion
	call CantMove
	jmp EndTurn

.not_confused
	ld a, [wPlayerSubStatus1]
	add a ; bit SUBSTATUS_ATTRACT
	jr nc, .not_infatuated

	ld hl, InLoveWithText
	call StdBattleTextbox
	xor a
	ld [wNumHits], a
	ld de, ANIM_IN_LOVE
	call FarPlayBattleAnimation

	; 50% chance of infatuation
	call BattleRandom
	cp 50 percent + 1
	jr c, .not_infatuated

	ld hl, InfatuationText
	call StdBattleTextbox
	call CantMove
	jmp EndTurn

.not_infatuated
	; We can't disable a move that doesn't exist.
	ld a, [wDisabledMove]
	and a
	jr z, .no_disabled_move

	; Are we using the disabled move?
	ld hl, wCurPlayerMove
	cp [hl]
	jr nz, .no_disabled_move

	call MoveDisabled
	call CantMove
	jmp EndTurn

.no_disabled_move
	; Assault Vest
	; Taunt player when using Assault Vest
	push hl
	push bc
	call GetUserItem
	ld a, b
	cp HELD_ASSAULT_VEST
	pop bc
	pop hl
	jr nz, .checkTaunt
	ld a, 255
	ld [wPlayerTauntCount], a

.checkTaunt
	; Taunt
	; Block player move on the turn taunt is used
	ld a, [wPlayerTauntCount]
	and a
	jr z, .no_taunt
	ld a, [wPlayerMoveStruct + MOVE_POWER]
	and a
	jr nz, .no_taunt
	call MoveDisabled
	call CantMove
	jmp EndTurn

.no_taunt
	ld hl, wBattleMonStatus
	bit PAR, [hl]
	ret z

	; 25% chance to be fully paralyzed
	call BattleRandom
	cp 25 percent
	ret nc

	ld hl, FullyParalyzedText
	call StdBattleTextbox
	call CantMove
	jmp EndTurn

CantMove:
	ld a, BATTLE_VARS_SUBSTATUS1
	call GetBattleVarAddr
	res SUBSTATUS_ROLLOUT, [hl]

	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVarAddr
	ld a, [hl]
	and ~(1 << SUBSTATUS_RAMPAGE | 1 << SUBSTATUS_CHARGED)
	ld [hl], a


	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	cp FLY
	jr z, .fly_dig

	cp DIG
	ret nz

.fly_dig
	res SUBSTATUS_UNDERGROUND, [hl]
	res SUBSTATUS_FLYING, [hl]
	jmp AppearUserRaiseSub

OpponentCantMove:
	call BattleCommand_SwitchTurn
	call CantMove
	jmp BattleCommand_SwitchTurn

CheckEnemyTurn:
	ld hl, wEnemySubStatus4
	bit SUBSTATUS_RECHARGE, [hl]
	jr z, .no_recharge

	res SUBSTATUS_RECHARGE, [hl]
	ld hl, MustRechargeText
	call StdBattleTextbox
	call CantMove
	jmp EndTurn

.no_recharge
	ld hl, wEnemyMonStatus
	ld a, [hl]
	and SLP_MASK
	jr z, .not_asleep

	dec a
	ld [wEnemyMonStatus], a
	and a
	jr z, .woke_up

	ld hl, FastAsleepText
	call StdBattleTextbox
	xor a
	ld [wNumHits], a
	ld de, ANIM_SLP
	call FarPlayBattleAnimation
	jr .fast_asleep

.woke_up
	ld hl, WokeUpText
	call StdBattleTextbox
	call CantMove
	call UpdateEnemyMonInParty
	ld hl, UpdateEnemyHUD
	call CallBattleCore
	ld a, $1
	ldh [hBGMapMode], a
	ld hl, wEnemySubStatus1
	res SUBSTATUS_NIGHTMARE, [hl]
	jr .not_asleep

.fast_asleep
	; Snore and Sleep Talk bypass sleep.
	ld a, [wCurEnemyMove]
	cp SNORE
	jr z, .not_asleep
	cp SLEEP_TALK
	jr z, .not_asleep
	call CantMove
	jmp EndTurn

.not_asleep
	ld hl, wEnemySubStatus3
	bit SUBSTATUS_FLINCHED, [hl]
	jr z, .not_flinched

	res SUBSTATUS_FLINCHED, [hl]
	ld hl, FlinchedText
	call StdBattleTextbox

	call CantMove
	jmp EndTurn

.not_flinched
	ld hl, wEnemyDisableCount
	ld a, [hl]
	and a
	jr z, .not_disabled

	dec a
	ld [hl], a
	and $f
	jr nz, .not_disabled

	ld [hl], a
	ld [wEnemyDisabledMove], a

	ld hl, DisabledNoMoreText
	call StdBattleTextbox

.not_disabled
	; Taunt
	; decrement the enemy taunt count and
	; print a message when ended
	ld hl, wEnemyTauntCount
	ld a, [hl]
	and a
	jr z, .not_taunted

	dec a
	ld [hl], a
	and $f
	jr nz, .not_taunted

	ld hl, TauntedNoMoreText
	call StdBattleTextbox

.not_taunted
	ld a, [wEnemySubStatus3]
	add a ; bit SUBSTATUS_CONFUSED
	jr nc, .not_confused

	ld hl, wEnemyConfuseCount
	dec [hl]
	jr nz, .confused

	ld hl, wEnemySubStatus3
	res SUBSTATUS_CONFUSED, [hl]
	ld hl, ConfusedNoMoreText
	call StdBattleTextbox
	jr .not_confused

.confused
	ld hl, IsConfusedText
	call StdBattleTextbox

	xor a
	ld [wNumHits], a
	ld de, ANIM_CONFUSED
	call FarPlayBattleAnimation

	; 50% chance of hitting itself
	call BattleRandom
	cp 50 percent + 1
	jr nc, .not_confused

	; clear confusion-dependent substatus
	ld hl, wEnemySubStatus3
	ld a, [hl]
	and 1 << SUBSTATUS_CONFUSED
	ld [hl], a

	ld hl, HurtItselfText
	call StdBattleTextbox

	call HitSelfInConfusion
	call ConfusionDamageCalc
	call BattleCommand_LowerSub

	xor a
	ld [wNumHits], a

	; Flicker the monster pic unless flying or underground.
	ld de, ANIM_HIT_CONFUSION
	ld a, BATTLE_VARS_SUBSTATUS3_OPP
	call GetBattleVar
	and 1 << SUBSTATUS_FLYING | 1 << SUBSTATUS_UNDERGROUND
	call z, PlayFXAnimID

	ld c, TRUE
	call DoEnemyDamage
	call BattleCommand_RaiseSub
	call CantMove
	jr EndTurn

.not_confused
	ld a, [wEnemySubStatus1]
	add a ; bit SUBSTATUS_ATTRACT
	jr nc, .not_infatuated

	ld hl, InLoveWithText
	call StdBattleTextbox
	xor a
	ld [wNumHits], a
	ld de, ANIM_IN_LOVE
	call FarPlayBattleAnimation

	; 50% chance of infatuation
	call BattleRandom
	cp 50 percent + 1
	jr c, .not_infatuated

	ld hl, InfatuationText
	call StdBattleTextbox
	call CantMove
	jr EndTurn

.not_infatuated
	; We can't disable a move that doesn't exist.
	ld a, [wEnemyDisabledMove]
	and a
	jr z, .no_disabled_move

	; Are we using the disabled move?
	ld hl, wCurEnemyMove
	cp [hl]
	jr nz, .no_disabled_move

	call MoveDisabled

	call CantMove
	jr EndTurn

.no_disabled_move
	; Taunt
	; Block enemy move on the turn taunt is used
	ld a, [wEnemyTauntCount]
	and a
	jr z, .no_taunt
	ld a, [wEnemyMoveStruct + MOVE_POWER]
	and a
	jr nz, .no_taunt
	call MoveDisabled
	call CantMove
	jr EndTurn

.no_taunt
	ld hl, wEnemyMonStatus
	bit PAR, [hl]
	ret z

	; 25% chance to be fully paralyzed
	call BattleRandom
	cp 25 percent
	ret nc

	ld hl, FullyParalyzedText
	call StdBattleTextbox
	call CantMove
	; fallthrough

EndTurn:
	ld a, $1
	ld [wTurnEnded], a
	jmp ResetDamage

MoveDisabled:
	; Make sure any charged moves fail
	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVarAddr
	res SUBSTATUS_CHARGED, [hl]

	ld a, BATTLE_VARS_MOVE
	call GetBattleVar
	ld [wNamedObjectIndex], a
	call GetMoveName

	ld hl, DisabledMoveText
	jmp StdBattleTextbox

HitConfusion:
	ld hl, HurtItselfText
	call StdBattleTextbox

	xor a
	ld [wCriticalHit], a

	call HitSelfInConfusion
	call ConfusionDamageCalc
	call BattleCommand_LowerSub

	xor a
	ld [wNumHits], a

	; Flicker the monster pic unless flying or underground.
	ld de, ANIM_HIT_CONFUSION
	ld a, BATTLE_VARS_SUBSTATUS3_OPP
	call GetBattleVar
	and 1 << SUBSTATUS_FLYING | 1 << SUBSTATUS_UNDERGROUND
	call z, PlayFXAnimID

	ld hl, UpdatePlayerHUD
	call CallBattleCore
	ld a, $1
	ldh [hBGMapMode], a
	ld c, TRUE
	call DoPlayerDamage
	jmp BattleCommand_RaiseSub

BattleCommand_UsedMoveText:
	farjp DisplayUsedMoveText

CheckUserIsCharging:
	ldh a, [hBattleTurn]
	and a
	ld a, [wPlayerCharging] ; player
	jr z, .end
	ld a, [wEnemyCharging] ; enemy
.end
	and a
	ret

BattleCommand_DoTurn:
; DevNote - lock into choice item move here
	call GetUserItem
	ld a, b
	cp HELD_CHOICE_BAND
	jr z, .lock
	cp HELD_CHOICE_SPECS
	jr z, .lock
	jr .continue
.lock
	ld a, BATTLE_VARS_SUBSTATUS5
	call GetBattleVarAddr
	set SUBSTATUS_ENCORED, [hl]
    ldh a, [hBattleTurn]
  	and a
  	jr nz, .enemy
	ld a, 255
	ld [wPlayerEncoreCount], a
	jr .continue
.enemy
	ld a, 255
	ld [wEnemyEncoreCount], a
.continue

	call CheckUserIsCharging
	ret nz

	ld hl, wBattleMonPP
	ld de, wPlayerSubStatus3
	ld bc, wPlayerTurnsTaken

	ldh a, [hBattleTurn]
	and a
	jr z, .proceed

	ld hl, wEnemyMonPP
	ld de, wEnemySubStatus3
	ld bc, wEnemyTurnsTaken

.proceed

; If we've gotten this far, this counts as a turn.
	ld a, [bc]
	inc a
	ld [bc], a

	ld a, BATTLE_VARS_MOVE
	call GetBattleVar
	cp STRUGGLE
	ret z

	ld a, [de]
	and 1 << SUBSTATUS_IN_LOOP | 1 << SUBSTATUS_RAMPAGE
	ret nz

	call .consume_pp
	ld a, b
	and a
	jmp nz, EndMoveEffect

	; SubStatus5
	inc de
	inc de

	ld a, [de]
	bit SUBSTATUS_TRANSFORMED, a
	ret nz

	ldh a, [hBattleTurn]
	and a

	ld hl, wPartyMon1PP
	ld a, [wCurBattleMon]
	jr z, .player

; mimic this part entirely if wildbattle
	ld a, [wBattleMode]
	dec a
	jr z, .wild

	ld hl, wOTPartyMon1PP
	ld a, [wCurOTMon]

.player
	call GetPartyLocation
	push hl
	call CheckMimicUsed
	pop hl
	ret c

.consume_pp
	ldh a, [hBattleTurn]
	and a
	ld a, [wCurMoveNum]
	jr z, .okay
	ld a, [wCurEnemyMoveNum]

.okay
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl]
	and PP_MASK
	jr z, .out_of_pp
	dec [hl]
	ld b, 0
	ret

.wild
	ld hl, wEnemyMonMoves
	ld a, [wCurEnemyMoveNum]
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl]
	cp MIMIC
	jr z, .mimic
	ld hl, wWildMonMoves
	add hl, bc
	ld a, [hl]
	cp MIMIC
	ret z

.mimic
	ld hl, wWildMonPP
	call .consume_pp
	ret

.out_of_pp
	call BattleCommand_MoveDelay
; get move effect
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
; continuous?
	ld hl, .continuousmoves
	call IsInByteArray

; 'has no pp left for [move]'
	ld hl, HasNoPPLeftText
	jr c, .print
; 'but no pp is left for the move'
	ld hl, NoPPLeftText
.print
	call StdBattleTextbox
	ld b, 1
	ret

.continuousmoves
	db EFFECT_SOLARBEAM
	db EFFECT_FLY
	db EFFECT_ROLLOUT
	db EFFECT_RAMPAGE
	db -1

CheckMimicUsed:
	ldh a, [hBattleTurn]
	and a
	ld a, [wCurMoveNum]
	jr z, .player
	ld a, [wCurEnemyMoveNum]

.player
	ld c, a
	ld a, MON_MOVES
	call UserPartyAttr

	ld a, BATTLE_VARS_MOVE
	call GetBattleVar
	cp MIMIC
	jr z, .mimic

	ld b, 0
	add hl, bc
	ld a, [hl]
	cp MIMIC
	jr nz, .mimic

	scf
	ret

.mimic
	and a
	ret

BattleCommand_Critical:
; Determine whether this attack's hit will be critical.

	xor a
	ld [wCriticalHit], a

; =============================
; === Ability: Battle Armor === 
; =============================
	call GetOpposingMon
	ld hl, BattleArmorPokemon
	call IsInByteArray
	ret c

	ld a, BATTLE_VARS_MOVE_POWER
	call GetBattleVar
	and a
	ret z

	ldh a, [hBattleTurn]
	and a
	ld hl, wEnemyMonItem
	ld a, [wEnemyMonSpecies]
	jr nz, .Item
	ld hl, wBattleMonItem
	ld a, [wBattleMonSpecies]

.Item:
	ld c, 0

	cp CHANSEY
	jr nz, .Farfetchd
	ld a, [hl]
	cp LUCKY_PUNCH
	jr nz, .FocusEnergy

; +2 critical level
	ld c, 2
	jmp .Tally

.Farfetchd:
	cp TROPIUS
	jr nz, .FocusEnergy
	ld a, [hl]
	cp STICK
	jr nz, .FocusEnergy

; +2 critical level
	ld c, 2
	jmp .Tally

.FocusEnergy:
	ld a, BATTLE_VARS_SUBSTATUS4
	call GetBattleVar
	bit SUBSTATUS_FOCUS_ENERGY, a
	jr z, .CheckCritical

; +2 critical level
	inc c
	inc c

.CheckCritical:
; ============================
; === Ability: Slash Crits === 
; ============================
	call GetCurrentMon
	push hl
	push de
	push bc
	ld hl, SlashCritsPokemon
	call IsInByteArray
	pop bc
	pop de
	pop hl
	jr c, .check_slash
	jr .continue1

.check_slash
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	cp SLASH
	jr nz, .continue1
	ld a, 1
	ld [wCriticalHit], a
	ret

.continue1
; =================================
; === Ability: Leaf Blade Crits === 
; =================================
	call GetCurrentMon
	push hl
	push de
	push bc
	ld hl, LeafBladeCritsPokemon
	call IsInByteArray
	pop bc
	pop de
	pop hl
	jr c, .check_leaf_blade
	jr .continue2

.check_leaf_blade
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	cp LEAF_BLADE
	jr nz, .continue2
	ld a, 1
	ld [wCriticalHit], a
	ret

.continue2
; ===========================
; === Ability: Super Luck ===
; ===========================
	call GetCurrentMon
	push hl
	push de
	push bc
	ld hl, SuperLuckPokemon
	call IsInByteArray
	pop bc
	pop de
	pop hl
	jr c, .increase_critical
	jr .continue3

; super luck mons have an innate +2 critical hit level
.increase_critical
	inc c
	inc c

.continue3
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	ld de, 1
	ld hl, CriticalHitMoves
	push bc
	call IsInArray
	pop bc
	jr nc, .ScopeLens

; +2 critical level
	inc c
	inc c

.ScopeLens:
	push bc
	call GetUserItem
	ld a, b
	cp HELD_CRITICAL_UP ; Increased critical chance. Only Scope Lens has this.
	pop bc
	jr nz, .Tally

; +1 critical level
	inc c

.Tally:
	ld hl, CriticalHitChances
	ld b, 0
	add hl, bc
	call BattleRandom
	cp [hl]
	ret nc
	ld a, 1
	ld [wCriticalHit], a
	ret

INCLUDE "data/moves/critical_hit_moves.asm"
INCLUDE "data/abilities/battle_armor_mons.asm"
INCLUDE "data/abilities/slash_crits_mons.asm"
INCLUDE "data/abilities/leaf_blade_crits_mons.asm"
INCLUDE "data/abilities/super_luck_mons.asm"

INCLUDE "data/battle/critical_hit_chances.asm"

GetNextTypeMatchupsByte:
   ld a, BANK(TypeMatchups)
   jmp GetFarByte

BattleCommand_Stab:
; STAB = Same Type Attack Bonus
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	cp STRUGGLE
	ret z

	ld hl, wBattleMonType1
	ld a, [hli]
	ld b, a
	ld c, [hl]
	ld hl, wEnemyMonType1
	ld a, [hli]
	ld d, a
	ld e, [hl]

	ldh a, [hBattleTurn]
	and a
	jr z, .go ; Who Attacks and who Defends

	ld hl, wEnemyMonType1
	ld a, [hli]
	ld b, a
	ld c, [hl]
	ld hl, wBattleMonType1
	ld a, [hli]
	ld d, a
	ld e, [hl]

.go
	ld a, BATTLE_VARS_MOVE_TYPE
	call GetBattleVarAddr
	and TYPE_MASK
	ld [wCurType], a

	push hl
	push de
	push bc
	farcall DoWeatherModifiers
	pop bc
	pop de
	pop hl

	ld a, [wCurType]
	cp b
	jr z, .stab
	cp c
	jr z, .stab

	jr .SkipStab

.stab
	ld hl, wCurDamage + 1
	ld a, [hld]
	ld h, [hl]
	ld l, a

	ld b, h
	ld c, l
	srl b
	rr c
	add hl, bc

	ld a, h
	ld [wCurDamage], a
	ld a, l
	ld [wCurDamage + 1], a

	ld hl, wTypeModifier
	set STAB_DAMAGE_F, [hl]

.SkipStab:
	ld a, BATTLE_VARS_MOVE_TYPE
	call GetBattleVar
	and TYPE_MASK
	ld b, a
	ld a, [wBattleType]
	cp BATTLETYPE_TYPELESS
	jr z, .typeless
	cp BATTLETYPE_INVERSE
	jr z, .inverse
	ld hl, TypeMatchups
	jr .TypesLoop
.inverse
 	ld hl, InverseTypeMatchups
 	jr .TypesLoop
.typeless
	ld hl, NoTypeMatchups

.TypesLoop:
	call GetNextTypeMatchupsByte
	inc hl

	cp -1
	jr z, .end

	; foresight
	cp -2
	jr nz, .SkipForesightCheck
	ld a, BATTLE_VARS_SUBSTATUS1_OPP
	call GetBattleVar
	bit SUBSTATUS_IDENTIFIED, a
	jr nz, .end

	jr .TypesLoop

.SkipForesightCheck:
	cp b
	jr nz, .SkipType
	call GetNextTypeMatchupsByte
	cp d
	jr z, .GotMatchup
	cp e
	jr z, .GotMatchup
	jr .SkipType

.GotMatchup:
	push hl
	push bc
	inc hl
	ld a, [wTypeModifier]
	and STAB_DAMAGE
	ld b, a
; If the target is immune to the move, treat it as a miss and calculate the damage as 0
	call GetNextTypeMatchupsByte
	and a
	jr nz, .NotImmune
	inc a
	ld [wAttackMissed], a
	xor a
.NotImmune:
	ldh [hMultiplier], a
	add b
	ld [wTypeModifier], a

	xor a
	ldh [hMultiplicand + 0], a

	ld hl, wCurDamage
	ld a, [hli]
	ldh [hMultiplicand + 1], a
	ld a, [hld]
	ldh [hMultiplicand + 2], a

	call Multiply

	ldh a, [hProduct + 1]
	ld b, a
	ldh a, [hProduct + 2]
	or b
	ld b, a
	ldh a, [hProduct + 3]
	or b
	jr z, .ok ; This is a very convoluted way to get back that we've essentially dealt no damage.

; Take the product and divide it by 10.
	ld a, 10
	ldh [hDivisor], a
	ld b, 4
	call Divide
	ldh a, [hQuotient + 2]
	ld b, a
	ldh a, [hQuotient + 3]
	or b
	jr nz, .ok

	ld a, 1
	ldh [hMultiplicand + 2], a

.ok
	ldh a, [hMultiplicand + 1]
	ld [hli], a
	ldh a, [hMultiplicand + 2]
	ld [hl], a
	pop bc
	pop hl

.SkipType:
	inc hl
	inc hl
	jr .TypesLoop

.end
	call BattleCheckTypeMatchup
	ld a, [wTypeMatchup]
	ld b, a
	ld a, [wTypeModifier]
	and STAB_DAMAGE
	or b
	ld [wTypeModifier], a
	ret

CheckStealthRockTypeMatchup:
	ld hl, wBattleMonType1
	ldh a, [hBattleTurn]
	and a
	jr z, .get_type
	ld hl, wEnemyMonType1
.get_type
	ld a, ROCK
	jr CheckTypeMatchup

BattleCheckTypeMatchup:
	ld hl, wEnemyMonType1
	ldh a, [hBattleTurn]
	and a
	jr z, .get_type
	ld hl, wBattleMonType1
.get_type
	ld a, BATTLE_VARS_MOVE_TYPE
	call GetBattleVar ; preserves hl, de, and bc	
	and TYPE_MASK
	; fallthrough

CheckTypeMatchup:
	push hl
	push de
	push bc
	ld d, a
	ld b, [hl]
	inc hl
	ld c, [hl]
	ld a, EFFECTIVE
	ld [wTypeMatchup], a
	ld a, [wBattleType]
	cp BATTLETYPE_TYPELESS
	jr z, .typeless
	cp BATTLETYPE_INVERSE
	jr z, .inverse
	ld hl, TypeMatchups
	jr .TypesLoop
.inverse
	ld hl, InverseTypeMatchups
	jr .TypesLoop
.typeless
	ld hl, NoTypeMatchups

.TypesLoop:
	call GetNextTypeMatchupsByte
	inc hl
	cp -1
	jr z, .End
	cp -2
	jr nz, .Next
	ld a, BATTLE_VARS_SUBSTATUS1_OPP
	call GetBattleVar
	bit SUBSTATUS_IDENTIFIED, a
	jr nz, .End
	jr .TypesLoop

.Next:
	cp d
	jr nz, .Nope
	call GetNextTypeMatchupsByte
	inc hl
	cp b
	jr z, .Yup
	cp c
	jr z, .Yup
	jr .Nope2

.Nope:
	inc hl
.Nope2:
	inc hl
	jr .TypesLoop

.Yup:
	xor a
	ldh [hDividend + 0], a
	ldh [hMultiplicand + 0], a
	ldh [hMultiplicand + 1], a
	call GetNextTypeMatchupsByte
	inc hl
	ldh [hMultiplicand + 2], a
	ld a, [wTypeMatchup]
	ldh [hMultiplier], a
	call Multiply
	ld a, 10
	ldh [hDivisor], a
	push bc
	ld b, 4
	call Divide
	pop bc
	ldh a, [hQuotient + 3]
	ld [wTypeMatchup], a
	jr .TypesLoop

.End:
	jmp PopBCDEHL

BattleCommand_ResetTypeMatchup:
; Reset the type matchup multiplier to 1.0, if the type matchup is not 0.
; If there is immunity in play, the move automatically misses.
	call BattleCheckTypeMatchup
	ld a, [wTypeMatchup]
	and a
	ld a, EFFECTIVE
	jr nz, .reset
	call ResetDamage
	xor a
	ld [wTypeModifier], a
	inc a
	ld [wAttackMissed], a
	ret

.reset
	ld [wTypeMatchup], a
	ret

INCLUDE "engine/battle/ai/switch.asm"

BattleCommand_Burn:
	ld hl, DoesntAffectText
	ld a, [wTypeModifier]
	and EFFECTIVENESS_MASK
	jr z, .failed

	ld a, FIRE
	call CheckIfTargetIsGivenType
	jr z, .failed

	call CheckForStatusIfAlreadyHasAny
	jr nz, .failed

; ================================
; === Ability: Serenity - Burn ===
; ================================
	call GetOpposingMon
	ld hl, SerenityPokemon
	call IsInByteArray
	jmp c, Serenity
	; fallthrough

	ld hl, DidntAffect1Text
	ld a, BATTLE_VARS_STATUS_OPP
	call GetBattleVar
	and a
	jr nz, .failed

	ld hl, ProtectingItselfText
	call CheckSubstituteOpp
	jr nz, .failed
	
	ld hl, EvadedText
	ld a, [wAttackMissed]
	and a
	jr nz, .failed
	
	call .apply_burn
	ld hl, WasBurnedText
	call StdBattleTextbox
	farjp UseHeldStatusHealingItem

.failed
	push hl
	call AnimateFailedMove
	pop hl
	jmp StdBattleTextbox

.apply_burn
	call AnimateCurrentMove
	call BurnOpponent
	ld b, SCGB_BATTLE_COLORS
	call GetSGBLayout
	call SetDefaultBGPAndOBP
	call DelayFrame	
	call UpdateBattleHuds
	ld c, 3
	call DelayFrames
	jmp WaitBGMap

BurnOpponent:
	ld a, BATTLE_VARS_STATUS_OPP
	call GetBattleVarAddr
	set BRN, [hl]
	call UpdateOpponentInParty
	ld hl, ApplyBrnEffectOnAttack
	call CallBattleCore
	ld de, ANIM_BRN
	call PlayOpponentBattleAnim
	call RefreshBattleHuds
	jmp UpdateOpponentInParty

BattleCommand_DamageVariation:
; Modify the damage spread between 85% and 100%.

; Because of the method of division the probability distribution
; is not consistent. This makes the highest damage multipliers
; rarer than normal.

; No point in reducing 1 or 0 damage.
	ld hl, wCurDamage
	ld a, [hli]
	and a
	jr nz, .go
	ld a, [hl]
	cp 2
	ret c

.go
; Start with the maximum damage.
	xor a
	ldh [hMultiplicand + 0], a
	dec hl
	ld a, [hli]
	ldh [hMultiplicand + 1], a
	ld a, [hl]
	ldh [hMultiplicand + 2], a

	farcall EffectiveDefensiveAbilities

; Multiply by 85-100%...
.loop
	call BattleRandom
	rrca
	cp 85 percent + 1
	jr c, .loop

	ldh [hMultiplier], a
	call Multiply

; ...divide by 100%...
	ld a, 100 percent
	ldh [hDivisor], a
	ld b, $4
	call Divide

; ...to get .85-1.00x damage.
	ldh a, [hQuotient + 2]
	ld hl, wCurDamage
	ld [hli], a
	ldh a, [hQuotient + 3]
	ld [hl], a
	ret

BattleCommand_CheckHit:
	
	farcall DefensiveAbilities

	farcall DreamEaterMiss
	jmp z, .Miss

	farcall ProtectMiss
	jmp nz, .Miss

	farcall DrainSub
	jmp z, .Miss

	farcall FlyDigMovesMiss
	jmp nz, .Miss

	farcall ThunderRain
	ret z

	farcall ToxicPoison
	ret z

	farcall BlizzardHail
	ret z

	farcall HurricaneRain
	ret z 

	farcall XAccuracy
	ret nz

	ld a, [hBattleTurn]
	and a
	jr nz, .enemy_target

	; Check if either side is asleep
	; Sleeping Pokemon can't dodge any moves
	; player attacking enemy
	ld a, [wEnemyMonStatus]
	jr .check_sleep

.enemy_target
	; enemy attacking player
	ld a, [wBattleMonStatus]

.check_sleep
	and SLP_MASK
	jr z, .not_asleep

	; target is asleep ⇒ always hit
	scf
	ret

.not_asleep

	; Perfect-accuracy moves
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_ALWAYS_HIT
	ret z
	cp EFFECT_FORCE_SWITCH
	ret z
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	cp STRUGGLE
	ret z

; ==========================
; === Ability: True Horn ===
; ==========================
	; check if megahorn was used
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	cp MEGAHORN
	jr nz, .not_megahorn_or_true_horn_mon

	; check it is was a true horn pokemon
	call GetCurrentMon
	ld hl, TrueHornPokemon
	call IsInByteArray
	ret c

.not_megahorn_or_true_horn_mon

; ===========================
; === Ability: Stormbound ===
; ===========================
	; check if thunder was used
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	cp THUNDER
	jr nz, .not_thunder_or_stormbound_mon

	; check it is was a stormbound pokemon
	call GetCurrentMon
	ld hl, StormboundPokemon
	call IsInByteArray
	ret c

.not_thunder_or_stormbound_mon

; ===========================
; === Ability: True Flame ===
; ===========================
	; check if fire blast was used
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	cp FIRE_BLAST
	jr nz, .not_fire_blast_or_true_flame_mon

	; check it is was a true flame pokemon
	call GetCurrentMon
	ld hl, TrueFlamePokemon
	call IsInByteArray
	ret c

.not_fire_blast_or_true_flame_mon

; ==============================
; === Ability: True Blizzard ===
; ==============================
	; check if blizzard was used
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	cp BLIZZARD
	jr nz, .not_blizzard_or_true_blizzard_mon

	; check it is was a true blizzard pokemon
	call GetCurrentMon
	ld hl, TrueBlizzardPokemon
	call IsInByteArray
	ret c

.not_blizzard_or_true_blizzard_mon

; ============================
; === Ability: Sure Stream ===
; ============================
	; check if blizzard was used
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	cp HYDRO_PUMP
	jr nz, .not_hydro_pump_or_sure_stream_mon

	; check it is was a sure stream pokemon
	call GetCurrentMon
	ld hl, SureStreamPokemon
	call IsInByteArray
	ret c

.not_hydro_pump_or_sure_stream_mon

; ============================
; === Ability: Stonefall =====
; ============================
	; check if rock slide was used
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	cp ROCK_SLIDE
	jr nz, .not_rock_slide_or_stonefall_mon

	; check it is was a stonefall pokemon
	call GetCurrentMon
	ld hl, StonefallPokemon
	call IsInByteArray
	ret c

.not_rock_slide_or_stonefall_mon

; ============================
; === Ability: Stonebound =====
; ============================
	; check if stone edge was used
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	cp STONE_EDGE
	jr nz, .not_stone_edge_or_stonebound_mon

	; check it is was a stonebound pokemon
	call GetCurrentMon
	ld hl, StoneboundPokemon
	call IsInByteArray
	ret c

.not_stone_edge_or_stonebound_mon

	call .StatModifiers

	ld a, [wPlayerMoveStruct + MOVE_ACC]
	ld b, a
	ldh a, [hBattleTurn]
	and a
	jr z, .BrightPowder
	ld a, [wEnemyMoveStruct + MOVE_ACC]
	ld b, a

.BrightPowder:
	push bc
	call GetOpponentItem
	ld a, b
	cp HELD_BRIGHTPOWDER
	ld a, c ; % miss
	pop bc
	jr nz, .skip_brightpowder

	ld c, a
	ld a, b
	sub c
	ld b, a
	jr nc, .skip_brightpowder
	ld b, 0

.skip_brightpowder
	ld a, b
	cp -1
	jr z, .Hit

	call BattleRandom
	cp b
	jr nc, .Miss

.Hit:
	ret

.Miss:
; Keep the damage value intact if we're using (Hi) Jump Kick.
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_JUMP_KICK
	jr z, .Missed
	call ResetDamage

.Missed:
	ld a, 1
	ld [wAttackMissed], a
	ret

.StatModifiers:
	ldh a, [hBattleTurn]
	and a

	; load the user's accuracy into b and the opponent's evasion into c.
	ld hl, wPlayerMoveStruct + MOVE_ACC
	ld a, [wPlayerAccLevel]
	ld b, a
	ld a, [wEnemyEvaLevel]
	ld c, a

	jr z, .got_acc_eva

	ld hl, wEnemyMoveStruct + MOVE_ACC
	ld a, [wEnemyAccLevel]
	ld b, a
	ld a, [wPlayerEvaLevel]
	ld c, a

.got_acc_eva
	cp b
	jr c, .skip_foresight_check

	; if the target's evasion is greater than the user's accuracy,
	; check the target's foresight status
	ld a, BATTLE_VARS_SUBSTATUS1_OPP
	call GetBattleVar
	bit SUBSTATUS_IDENTIFIED, a
	ret nz

.skip_foresight_check
	; subtract evasion from 14
	ld a, MAX_STAT_LEVEL + 1
	sub c
	ld c, a
	; store the base move accuracy for math ops
	xor a
	ldh [hMultiplicand + 0], a
	ldh [hMultiplicand + 1], a
	ld a, [hl]
	ldh [hMultiplicand + 2], a
	push hl
	ld d, 2 ; do this twice, once for the user's accuracy and once for the target's evasion

.accuracy_loop
	; look up the multiplier from the table
	push bc
	ld hl, AccuracyLevelMultipliers
	dec b
	sla b
	ld c, b
	ld b, 0
	add hl, bc
	pop bc
	; multiply by the first byte in that row...
	ld a, [hli]
	ldh [hMultiplier], a
	call Multiply
	; ... and divide by the second byte
	ld a, [hl]
	ldh [hDivisor], a
	ld b, 4
	call Divide
	; minimum accuracy is $0001
	ldh a, [hQuotient + 3]
	ld b, a
	ldh a, [hQuotient + 2]
	or b
	jr nz, .min_accuracy
	ldh [hQuotient + 2], a
	ld a, 1
	ldh [hQuotient + 3], a

.min_accuracy
	; do the same thing to the target's evasion
	ld b, c
	dec d
	jr nz, .accuracy_loop

; ==============================
; === Ability: Compound Eyes ===
; ==============================
	call GetCurrentMon
	ld hl, CompoundEyesMons
	call IsInByteArray
	jr nc, .skip_compound_eyes

	ld a, 30
	add 100
	call AccuracyCalc

.skip_compound_eyes
	; if the result is more than 2 bytes, max out at 100%
	ldh a, [hQuotient + 2]
	and a
	ldh a, [hQuotient + 3]
	jr z, .finish_accuracy
	ld a, $ff

.finish_accuracy
	pop hl
	ld [hl], a
	ret

AccuracyCalc:
	ldh [hMultiplier], a
	call Multiply

	ld a, 100
	ldh [hDivisor], a
	ld b, 4
	jmp Divide

INCLUDE "data/abilities/true_horn_mons.asm"
INCLUDE "data/abilities/stormbound_mons.asm"
INCLUDE "data/abilities/true_flame_mons.asm"
INCLUDE "data/abilities/true_blizzard_mons.asm"
INCLUDE "data/abilities/sure_stream_mons.asm"
INCLUDE "data/abilities/stonefall_mons.asm"
INCLUDE "data/abilities/stonebound_mons.asm"
INCLUDE "data/abilities/compound_eyes_mons.asm"

INCLUDE "data/battle/accuracy_multipliers.asm"

BattleCommand_EffectChance:
	xor a
	ld [wEffectFailed], a
	call CheckSubstituteOpp
	jr nz, .failed

	push hl
	ld hl, wPlayerMoveStruct + MOVE_CHANCE
	ldh a, [hBattleTurn]
	and a
	ld a, [wBattleMonSpecies]
	jr z, .got_move_chance
	ld hl, wEnemyMoveStruct + MOVE_CHANCE
	ld a, [wEnemyMonSpecies]
.got_move_chance

; ==============================
; === Ability: Serene Grace ====
; ==============================
	push bc
	push de
	push hl
	ld hl, SereneGracePokemon
	call IsInByteArray
	pop hl
	pop de
	pop bc
	jr c, .serene_grace
	jr .finish_serene_grace

	; double effect chance
.serene_grace
	sla [hl]

.finish_serene_grace
 	ld a, [hl]
 	sub 100 percent
 	; If chance was 100%, RNG won't be called (carry not set)
 	; Thus chance will be subtracted from 0, guaranteeing a carry
 	call c, BattleRandom
	cp [hl]
	pop hl
	ret c

.failed
	ld a, 1
	ld [wEffectFailed], a
	and a
	ret

INCLUDE "data/abilities/serene_grace_mons.asm"

BattleCommand_LowerSub:
	ld a, BATTLE_VARS_SUBSTATUS4
	call GetBattleVar
	bit SUBSTATUS_SUBSTITUTE, a
	ret z

	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVar
	bit SUBSTATUS_CHARGED, a
	jr nz, .already_charged

	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_SOLARBEAM
	jr z, .charge_turn
	cp EFFECT_FLY
	jr z, .charge_turn

.already_charged
	call .Rampage
	jr z, .charge_turn

	call CheckUserIsCharging
	ret nz

.charge_turn
	call _CheckBattleScene
	jr c, .mimic_anims

	xor a
	ld [wNumHits], a
	ld [wFXAnimID + 1], a
	inc a
	ld [wBattleAnimParam], a
	ld a, SUBSTITUTE
	jmp LoadAnim

.mimic_anims
	call BattleCommand_LowerSubNoAnim
	jmp BattleCommand_MoveDelay

.Rampage:
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_ROLLOUT
	jr z, .rollout_rampage
	cp EFFECT_RAMPAGE
	jr z, .rollout_rampage

	ld a, 1
	and a
	ret

.rollout_rampage
	ld a, [wSomeoneIsRampaging]
	and a
	ld a, 0
	ld [wSomeoneIsRampaging], a
	ret

BattleCommand_MoveAnim:
	call BattleCommand_LowerSub
	call BattleCommand_MoveAnimNoSub
	jmp BattleCommand_RaiseSub

BattleCommand_MoveAnimNoSub:
	ld a, [wAttackMissed]
	and a
	jmp nz, BattleCommand_MoveDelay

	ldh a, [hBattleTurn]
	and a
	ld de, wPlayerRolloutCount
	ld a, BATTLEANIM_ENEMY_DAMAGE
	jr z, .got_rollout_count
	ld de, wEnemyRolloutCount
	ld a, BATTLEANIM_PLAYER_DAMAGE

.got_rollout_count
	ld [wNumHits], a
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_MULTI_HIT
	jr z, .alternate_anim
	cp EFFECT_DOUBLE_HIT
	jr z, .alternate_anim
	cp EFFECT_POISON_MULTI_HIT
	jr z, .alternate_anim
	xor a
	ld [wBattleAnimParam], a

	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	ld e, a
	ld d, 0
	call PlayFXAnimID

	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	cp FLY
	jr z, .clear_sprite
	cp DIG
	ret nz
.clear_sprite
	jmp AppearUserLowerSub

.alternate_anim
	ld a, [wBattleAnimParam]
	and 1
	xor 1
	ld [wBattleAnimParam], a
	ld a, [de]
	cp 1
	push af
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	ld e, a
	ld d, 0
	pop af
	jmp z, PlayFXAnimID
	xor a
	ld [wNumHits], a
	jmp PlayFXAnimID

BattleCommand_StatUpAnim:
	ld a, [wAttackMissed]
	and a
	jmp nz, BattleCommand_MoveDelay

	xor a
	jr BattleCommand_StatUpDownAnim

BattleCommand_StatDownAnim:
	ld a, [wAttackMissed]
	and a
	jmp nz, BattleCommand_MoveDelay
	; fallthrough

BattleCommand_StatUpDownAnim:
	ld [wNumHits], a
	xor a
	ld [wBattleAnimParam], a
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	ld e, a
	ld d, 0
	jmp PlayFXAnimID

BattleCommand_SwitchTurn:
	ldh a, [hBattleTurn]
	xor 1
	ldh [hBattleTurn], a
	ret

BattleCommand_RaiseSub:
	ld a, BATTLE_VARS_SUBSTATUS4
	call GetBattleVar
	bit SUBSTATUS_SUBSTITUTE, a
	ret z

	call _CheckBattleScene
	jmp c, BattleCommand_RaiseSubNoAnim

	xor a
	ld [wNumHits], a
	ld [wFXAnimID + 1], a
	ld a, $2
	ld [wBattleAnimParam], a
	ld a, SUBSTITUTE
	jmp LoadAnim

BattleCommand_FailureText:
; If the move missed or failed, load the appropriate
; text, and end the effects of multi-turn or multi-
; hit moves.
	ld a, [wAttackMissed]
	and a
	ret z

	call GetFailureResultText
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVarAddr

	cp FLY
	jr z, .fly_dig
	cp DIG
	jr z, .fly_dig

; Move effect:
	inc hl
	ld a, [hl]

	cp EFFECT_MULTI_HIT
	jr z, .multihit
	cp EFFECT_DOUBLE_HIT
	jr z, .multihit
	cp EFFECT_POISON_MULTI_HIT
	jr z, .multihit
	jmp EndMoveEffect

.multihit
	call BattleCommand_RaiseSub
	jmp EndMoveEffect

.fly_dig
	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVarAddr
	res SUBSTATUS_UNDERGROUND, [hl]
	res SUBSTATUS_FLYING, [hl]
	call AppearUserRaiseSub
	jmp EndMoveEffect

BattleCommand_ApplyDamage:
	ld a, BATTLE_VARS_SUBSTATUS1_OPP
	call GetBattleVar
	bit SUBSTATUS_ENDURE, a
	jr z, .sturdy

	farcall BattleCommand_FalseSwipe
	ld b, 0
	jr nc, .damage
	ld b, 1
	jr .damage

.sturdy
; =================================
; ========== Sturdy ===============
; =================================
	call GetOpposingMon
	ld hl, SturdyPokemon
	call IsInByteArray
	jr c, .focus_sash_effect

	call GetOpponentItem
	ld a, [hl]
	ld [wNamedObjectIndex], a
	call GetItemName
	ld a, b
	cp HELD_FOCUS_BAND
	ld b, 0
	jr z, .focus_band
	cp HELD_FOCUS_SASH
	jr nz, .damage

; check if target is at full hp
.focus_sash_effect
	farcall CheckOpponentFullHP
	jr nz, .damage
	farcall BattleCommand_FalseSwipe
	ld b, 0
	jr nc, .damage
	ld b, 2
	jr .damage

.focus_band
	call BattleRandom
	cp c
	jr nc, .damage
	farcall BattleCommand_FalseSwipe
	ld b, 0
	jr nc, .damage
	ld b, 2

.damage
	push bc
	call .update_damage_taken
	ld c, FALSE
	ldh a, [hBattleTurn]
	and a
	jr nz, .damage_player
	call DoEnemyDamage
	jr .done_damage

.damage_player
	call DoPlayerDamage

.done_damage
	pop bc
	ld a, b
	and a
	ret z

	dec a
	jr nz, .focus_band_text
	ld hl, EnduredText
	jmp StdBattleTextbox

.focus_band_text
	call GetOpponentItem
    ld a, b
	cp HELD_FOCUS_BAND
	jr z, .hungontext
	cp HELD_FOCUS_SASH
	jr nz, .sturdytext

.hungontext:
	ld a, [hl]
	ld [wNamedObjectIndex], a
	call GetItemName
	ld hl, HungOnText
	jmp StdBattleTextbox

.sturdytext
	ld hl, SturdyText
	jmp StdBattleTextbox

.update_damage_taken
	ld a, BATTLE_VARS_SUBSTATUS4_OPP
	call GetBattleVar
	bit SUBSTATUS_SUBSTITUTE, a
	ret nz

	ld de, wPlayerDamageTaken + 1
	ldh a, [hBattleTurn]
	and a
	jr nz, .got_damage_taken
	ld de, wEnemyDamageTaken + 1

.got_damage_taken
	ld a, [wCurDamage + 1]
	ld b, a
	ld a, [de]
	add b
	ld [de], a
	dec de
	ld a, [wCurDamage]
	ld b, a
	ld a, [de]
	adc b
	ld [de], a
	ret nc
	ld a, $ff
	ld [de], a
	inc de
	ld [de], a
	ret

INCLUDE "data/abilities/sturdy_mons.asm"

GetFailureResultText:
	ld hl, DoesntAffectText
	ld de, DoesntAffectText
	ld a, [wTypeModifier]
	and EFFECTIVENESS_MASK
	jr z, .got_text
	farcall BattleMissAnim
	ld hl, AttackMissedText
	ld de, AttackMissed2Text
	ld a, [wCriticalHit]
	cp -1
	jr nz, .got_text
	ld hl, UnaffectedText
.got_text
	call FailText_CheckOpponentProtect
	xor a
	ld [wCriticalHit], a

	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_JUMP_KICK
	ret nz

	ld a, [wTypeModifier]
	and EFFECTIVENESS_MASK
	ret z

	ld hl, wCurDamage
	ld a, [hli]
	ld b, [hl]
rept 3
	srl a
	rr b
endr
	ld [hl], b
	dec hl
	ld [hli], a
	or b
	jr nz, .do_at_least_1_damage
	inc a
	ld [hl], a
.do_at_least_1_damage
	ld hl, CrashedText
	call StdBattleTextbox
	ld a, $1
	ld [wBattleAnimParam], a
	call LoadMoveAnim
	ld c, TRUE
	ldh a, [hBattleTurn]
	and a
	jmp nz, DoEnemyDamage
	jmp DoPlayerDamage

FailText_CheckOpponentProtect:
	ld a, BATTLE_VARS_SUBSTATUS1_OPP
	call GetBattleVar
	bit SUBSTATUS_PROTECT, a
	jr z, .not_protected
	ld h, d
	ld l, e
.not_protected
	jmp StdBattleTextbox

BattleCommand_CriticalText:
; Prints the message for critical hits or one-hit KOs.

; If there is no message to be printed, wait 20 frames.
	ld a, [wCriticalHit]
	and a
	jr z, .wait

	dec a
	add a
	ld hl, .texts
	ld b, 0
	ld c, a
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call StdBattleTextbox

	xor a
	ld [wCriticalHit], a

.wait
	ld c, 10
	jmp DelayFrames

.texts
	dw CriticalHitText
	dw OneHitKOText

BattleCommand_StartLoop:
	ld hl, wPlayerRolloutCount
	ldh a, [hBattleTurn]
	and a
	jr z, .ok
	ld hl, wEnemyRolloutCount
.ok
	xor a
	ld [hl], a
	ret

BattleCommand_SuperEffectiveLoopText:
	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVarAddr
	bit SUBSTATUS_IN_LOOP, a
	ret nz
	; fallthrough

BattleCommand_SuperEffectiveText:
	; Skip effectiveness text if fast battles is on
	call CheckIfFastBattlesIsOn
	ret nz

	ld a, [wTypeModifier]
	and EFFECTIVENESS_MASK
	cp EFFECTIVE
	ret z

	; 4x damage
	cp EXTREMELY_EFFECTIVE
	ld hl, ExtremelyEffectiveText
	jmp z, StdBattleTextbox

	; 2x damage
	cp SUPER_EFFECTIVE
	ld hl, SuperEffectiveText
	jmp z, StdBattleTextbox

	; 0.5x damage
	cp NOT_VERY_EFFECTIVE
	ld hl, NotVeryEffectiveText
	jmp z, StdBattleTextbox

	; 0.25x damage
	ld hl, MostlyIneffectiveText
	jmp StdBattleTextbox

BattleCommand_CheckFaint:
; apply life orb recoil
	push hl
	call GetUserItem
	ld a, b
	cp HELD_LIFE_ORB
	pop hl
	jr nz, .noLifeOrb
	farcall GetEighthMaxHP
	farcall SubtractHPFromUser
	ld hl, BattleText_UserLostSomeOfItsHP
	call StdBattleTextbox
.noLifeOrb
; checkfaint

; Faint the opponent if its HP reached zero
;  and faint the user along with it if it used Destiny Bond.
; Ends the move effect if the opponent faints.

	ld hl, wEnemyMonHP
	ldh a, [hBattleTurn]
	and a
	jr z, .got_hp
	ld hl, wBattleMonHP

.got_hp
	ld a, [hli]
	or [hl]
	ret nz

	ld a, BATTLE_VARS_SUBSTATUS5_OPP
	call GetBattleVar
	bit SUBSTATUS_DESTINY_BOND, a
	jr z, .no_dbond

	ld hl, TookDownWithItText
	call StdBattleTextbox

	ldh a, [hBattleTurn]
	and a
	ld hl, wEnemyMonMaxHP + 1
	bccoord 2, 2 ; hp bar
	ld a, 0
	jr nz, .got_max_hp
	ld hl, wBattleMonMaxHP + 1
	bccoord 10, 9 ; hp bar
	ld a, 1

.got_max_hp
	ld [wWhichHPBar], a
	ld a, [hld]
	ld [wHPBuffer1], a
	ld a, [hld]
	ld [wHPBuffer1 + 1], a
	ld a, [hl]
	ld [wHPBuffer2], a
	xor a
	ld [hld], a
	ld a, [hl]
	ld [wHPBuffer2 + 1], a
	xor a
	ld [hl], a
	ld [wHPBuffer3], a
	ld [wHPBuffer3 + 1], a
	ld h, b
	ld l, c
	predef AnimateHPBar
	call RefreshBattleHuds

	call BattleCommand_SwitchTurn
	xor a
	ld [wNumHits], a
	ld [wFXAnimID + 1], a
	inc a
	ld [wBattleAnimParam], a
	ld a, DESTINY_BOND
	call LoadAnim
	call BattleCommand_SwitchTurn
	jr .finish

.no_dbond
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_MULTI_HIT
	jr z, .multiple_hit_raise_sub
	cp EFFECT_DOUBLE_HIT
	jr z, .multiple_hit_raise_sub
	cp EFFECT_POISON_MULTI_HIT
	jr z, .multiple_hit_raise_sub

.multiple_hit_raise_sub
	call BattleCommand_RaiseSub

.finish
	jr EndMoveEffect

BattleCommand_CheckContact:
	ret

EndMoveEffect:
	ld a, [wBattleScriptBufferAddress]
	ld l, a
	ld a, [wBattleScriptBufferAddress + 1]
	ld h, a
	ld a, endmove_command
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ret

UnevolvedEviolite:
; get the defender's species
	ld a, MON_SPECIES
	call BattlePartyAttr
	ldh a, [hBattleTurn]
	and a
	ld a, [hl]
	jr nz, .got_species
	ld a, [wTempEnemyMonSpecies]

.got_species
; check if the defender has any evolutions
; hl := EvosAttacksPointers + (species - 1) * 2
	dec a
	push hl
	push bc
	ld c, a
	ld b, 0
	ld hl, EvosAttacksPointers
	add hl, bc
	add hl, bc
; hl := the species' entry from EvosAttacksPointers
	ld a, BANK(EvosAttacksPointers)
	call GetFarWord
; a := the first byte of the species' *EvosAttacks data
	ld a, BANK("Evolutions and Attacks")
	call GetFarByte
; if a == 0, there are no evolutions, so don't boost stats
	and a
	pop bc
	pop hl
	ret z

; check if the defender's item has the Eviolite effect
	push bc
	call GetOpponentItem
	ld a, b
	cp HELD_EVIOLITE
	pop bc
	ret nz

; boost the relevant defense stat in bc by 50%
	ld a, c
	srl a
	add c
	ld c, a
	ret nc

	srl b
	ld a, b
	and a
	jr nz, .done
	inc b
.done
	scf
	rr c
	ret

BattleCommand_DamageStats:
	ldh a, [hBattleTurn]
	and a
	jmp nz, EnemyAttackDamage
	; fallthrough

PlayerAttackDamage:
; Return move power d, player level e, enemy defense c and player attack b.

	call ResetDamage

	ld hl, wPlayerMoveStructPower
	ld a, [hli]
	and a
	ld d, a
	ret z

	ld a, [hl]
	cp SPECIAL
	jr nc, .special

; physical
	ld hl, wEnemyMonDefense
	ld a, [hli]
	ld b, a
	ld c, [hl]

	call HailDefenseBoost

	ld a, [wEnemyScreens]
	bit SCREENS_REFLECT, a
	jr z, .physicalcrit
	sla c
	rl b

; Body Press uses the user's defense stat instead of its attack.
.physicalcrit
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_BODY_PRESS
	jr z, .body_press

	ld hl, wBattleMonAttack
	call CheckDamageStatsCritical
	jr c, .thickcluborlightball

	ld hl, wEnemyDefense
	ld a, [hli]
	ld b, a
	ld c, [hl]
	ld hl, wPlayerAttack
	jr .thickcluborlightball

.body_press
; Use player's defense instead of attack for Body Press
	ld hl, wBattleMonDefense
	call CheckDamageStatsCritical
	jr c, .thickcluborlightball ; Use boosted stats

	ld hl, wEnemyDefense
	ld a, [hli]
	ld b, a
	ld c, [hl]
	ld hl, wPlayerDefense
	jr .thickcluborlightball

.special
; Psyshock is a special move, but targets the foe's defense stat.
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_PSYSHOCK
	jr nz, .get_special_defense
	ld hl, wEnemyMonDefense
	jr .psyshock_done

.get_special_defense
	ld hl, wEnemyMonSpclDef
.psyshock_done
	ld a, [hli]
	ld b, a
	ld c, [hl]

	call AssaultVestSpDefBoost
	call SandstormSpDefBoost

	ld a, [wEnemyScreens]
	bit SCREENS_LIGHT_SCREEN, a
	jr z, .specialcrit
	sla c
	rl b

.specialcrit
	ld hl, wBattleMonSpclAtk
	call CheckDamageStatsCritical
	jr c, .lightball

	ld hl, wEnemySpDef
	ld a, [hli]
	ld b, a
	ld c, [hl]
	ld hl, wPlayerSpAtk

.lightball
; Note: Returns player special attack at hl in hl.
	call LightBallBoost
	jr .done

.thickcluborlightball
; Note: Returns player attack at hl in hl.
	call ThickClubOrLightBallBoost

.done
	push hl
	call UnevolvedEviolite
	pop hl

	call TruncateHL_BC

	ld a, [wBattleMonLevel]
	ld e, a

	ld a, 1
	and a
	ret

TruncateHL_BC:
.loop
; Truncate 16-bit values hl and bc to 8-bit values b and c respectively.
; b = hl, c = bc

	ld a, h
	or b
	jr z, .finish

	srl b
	rr c
	srl b
	rr c

	ld a, c
	or b
	jr nz, .done_bc
	inc c

.done_bc
	srl h
	rr l
	srl h
	rr l

	ld a, l
	or h
	jr nz, .finish
	inc l

.finish
; If we go back to the loop point,
; it's the same as doing this exact
; same check twice.
	ld a, h
	or b
	jr nz, .loop

.done
	ld b, l
	ret

CheckDamageStatsCritical:
; Return carry if boosted stats should be used in damage calculations.
; Unboosted stats should be used if the attack is a critical hit,
;  and the stage of the opponent's defense is higher than the user's attack.

	ld a, [wCriticalHit]
	and a
	scf
	ret z

	push hl
	push bc
	ldh a, [hBattleTurn]
	and a
	jr nz, .enemy
	ld a, [wPlayerMoveStructType]
	cp SPECIAL
; special
	ld a, [wPlayerSAtkLevel]
	ld b, a
	ld a, [wEnemySDefLevel]
	jr nc, .end
; physical
	ld a, [wPlayerAtkLevel]
	ld b, a
	ld a, [wEnemyDefLevel]
	jr .end

.enemy
	ld a, [wEnemyMoveStructType]
	cp SPECIAL
; special
	ld a, [wEnemySAtkLevel]
	ld b, a
	ld a, [wPlayerSDefLevel]
	jr nc, .end
; physical
	ld a, [wEnemyAtkLevel]
	ld b, a
	ld a, [wPlayerDefLevel]
.end
	cp b
	pop bc
	pop hl
	ret

ThickClubOrLightBallBoost:
; Return in hl the stat value at hl.

; If the attacking monster is Cubone or Marowak and
; it's holding a Thick Club, or if it's Pikachu and
; it's holding a Light Ball, double it.
	push bc
	push de

	push hl
	ld a, MON_SPECIES
	call BattlePartyAttr
	ld a, [hBattleTurn]
	and a
	ld a, [hl]
	jr z, .checkpikachu
	ld a, [wTempEnemyMonSpecies]
.checkpikachu:
	pop hl
	cp PIKACHU
	jr z, .lightball
	ld b, DITTO
	ld c, DITTO
	ld d, THICK_CLUB
	call SpeciesItemBoost
	jr .done

.lightball
	ld b, PIKACHU
	ld c, PIKACHU
	ld d, LIGHT_BALL
	call SpeciesItemBoost

.done
	pop de
	pop bc
	ret

LightBallBoost:
; Return in hl the stat value at hl.

; If the attacking monster is Pikachu and it's
; holding a Light Ball, double it.
	push bc
	push de
	ld b, PIKACHU
	ld c, PIKACHU
	ld d, LIGHT_BALL
	call SpeciesItemBoost
	pop de
	pop bc
	ret

SpeciesItemBoost:
; Return in hl the stat value at hl.

; If the attacking monster is species b or c and
; it's holding item d, double it.

	ld a, [hli]
	ld l, [hl]
	ld h, a

	push hl
	ld a, MON_SPECIES
	call BattlePartyAttr

	ldh a, [hBattleTurn]
	and a
	ld a, [hl]
	jr z, .CompareSpecies
	ld a, [wTempEnemyMonSpecies]
.CompareSpecies:
	pop hl

	cp b
	jr z, .GetItemHeldEffect
	cp c
	ret nz

.GetItemHeldEffect:
	push hl
	call GetUserItem
	ld a, [hl]
	pop hl
	cp d
	ret nz

; Double the stat

	sla l
	rl h

 	ld a, HIGH(MAX_STAT_VALUE)
 	cp h
 	jr c, .cap
 	ret nz
 	ld a, LOW(MAX_STAT_VALUE)
 	cp l
 	ret nc
 
 .cap
 	ld hl, MAX_STAT_VALUE
	ret

EnemyAttackDamage:
	call ResetDamage

; No damage dealt with 0 power.
	ld hl, wEnemyMoveStructPower
	ld a, [hli] ; hl = wEnemyMoveStructType
	ld d, a
	and a
	ret z

	ld a, [hl]
	cp SPECIAL
	jr nc, .special

; physical
	ld hl, wBattleMonDefense
	ld a, [hli]
	ld b, a
	ld c, [hl]

	call HailDefenseBoost

	ld a, [wPlayerScreens]
	bit SCREENS_REFLECT, a
	jr z, .physicalcrit
	sla c
	rl b

; Body Press uses the user's defense stat instead of its attack.
.physicalcrit
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_BODY_PRESS
	jr z, .body_press

	ld hl, wEnemyMonAttack
	call CheckDamageStatsCritical
	jr c, .thickcluborlightball

	ld hl, wPlayerDefense
	ld a, [hli]
	ld b, a
	ld c, [hl]
	ld hl, wEnemyAttack
	jr c, .thickcluborlightball

.body_press
; Use enemy's defense instead of attack for Body Press
	ld hl, wEnemyMonDefense
	call CheckDamageStatsCritical
	jr c, .thickcluborlightball ; Use boosted stats

	ld hl, wPlayerDefense
	ld a, [hli]
	ld b, a
	ld c, [hl]
	ld hl, wEnemyDefense
	jr .thickcluborlightball

.special
; Psyshock is a special move, but targets the player's defense stat.
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_PSYSHOCK
	jr nz, .get_special_defense
	ld hl, wBattleMonDefense
	jr .psyshock_done

.get_special_defense
	ld hl, wBattleMonSpclDef
.psyshock_done
	ld a, [hli]
	ld b, a
	ld c, [hl]

	call AssaultVestSpDefBoost
	call SandstormSpDefBoost

	ld a, [wPlayerScreens]
	bit SCREENS_LIGHT_SCREEN, a
	jr z, .specialcrit
	sla c
	rl b

.specialcrit
	ld hl, wEnemyMonSpclAtk
	call CheckDamageStatsCritical
	jr c, .lightball
	ld hl, wPlayerSpDef
	ld a, [hli]
	ld b, a
	ld c, [hl]
	ld hl, wEnemySpAtk

.lightball
	call LightBallBoost
	jr .done

.thickcluborlightball
	call ThickClubOrLightBallBoost

.done
	push hl
	call UnevolvedEviolite
	pop hl

	call TruncateHL_BC

	ld a, [wEnemyMonLevel]
	ld e, a

	ld a, 1
	and a
	ret

BattleCommand_ClearMissDamage:
	ld a, [wAttackMissed]
	and a
	ret z

	jmp ResetDamage

HitSelfInConfusion:
	call ResetDamage
	ldh a, [hBattleTurn]
	and a
	ld hl, wBattleMonDefense
	ld de, wPlayerScreens
	ld a, [wBattleMonLevel]
	jr z, .got_it

	ld hl, wEnemyMonDefense
	ld de, wEnemyScreens
	ld a, [wEnemyMonLevel]
.got_it
	push af
	ld a, [hli]
	ld b, a
	ld c, [hl]
	ld a, [de]
	bit SCREENS_REFLECT, a
	jr z, .mimic_screen

	sla c
	rl b
.mimic_screen
	dec hl
	dec hl
	dec hl
	ld a, [hli]
	ld l, [hl]
	ld h, a
	call TruncateHL_BC
	ld d, 40
	pop af
	ld e, a
	ret

BattleCommand_DamageCalc:
; Return a damage value for move power d, player level e, enemy defense c and player attack b.

	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	and TYPE_MASK

; Variable-hit moves and Conversion can have a power of 0.
	cp EFFECT_MULTI_HIT
	jr z, .skip_zero_damage_check

; No damage if move power is 0.
	ld a, d
	and a
	ret z

.skip_zero_damage_check
	xor a ; Not confusion damage
 	ld [wIsConfusionDamage], a
 	; fallthrough
 
ConfusionDamageCalc:
; Minimum defense value is 1.
	ld a, c
	and a
	jr nz, .not_dividing_by_zero
	ld c, 1
.not_dividing_by_zero

	xor a
	ld hl, hDividend
	ld [hli], a
	ld [hli], a
	ld [hl], a

; Level * 2
	ld a, e
	add a
	jr nc, .level_not_overflowing
	ld [hl], 1
.level_not_overflowing
	inc hl
	ld [hli], a

; / 5
	ld a, 5
	ld [hld], a
	push bc
	ld b, 4
	call Divide
	pop bc

; + 2
	inc [hl]
	inc [hl]

; * bp
	inc hl
	ld [hl], d
	call Multiply

; * Attack
	ld [hl], b
	call Multiply

; / Defense
	ld [hl], c
	ld b, 4
	call Divide

; / 50
	ld [hl], 50
	ld b, $4
	call Divide

; Item boosts

 ; Item boosts don't apply to confusion damage
 	ld a, [wIsConfusionDamage]
 	and a
 	jr nz, .DoneItem

 	farcall CheckBoostingAbilities

	call GetUserItem

	ld a, b
	and a
	jr z, .DoneItem

	ld hl, TypeBoostItems

.NextItem:
	ld a, [hli]
	cp -1
	jr z, .DoneItem

; Item effect
	cp b
	ld a, [hli]
	jr nz, .NextItem

; Type
	ld b, a
	ld a, BATTLE_VARS_MOVE_TYPE
	call GetBattleVar
	cp b
	jr nz, .DoneItem

; * 100 + item effect amount
	ld a, c
	add 100
	ldh [hMultiplier], a
	call Multiply

; / 100
	ld a, 100
	ldh [hDivisor], a
	ld b, 4
	call Divide

.DoneItem:
; ===== half damage - used for Sucker Punch =====
	ld a, [wHalfDamage]
	and a
	jr z, .life_orb
	call HalfDamage
	xor a
	ld [wHalfDamage], a

.life_orb
; =====================
; ==== Life Orb =======
; =====================
; life orb - x1.3 damage but take recoil (dealt with in CheckFaint)
	push hl
	call GetUserItem
	ld a, b
	cp HELD_LIFE_ORB
	pop hl
	jr nz, .continue
	ld a, 13
	ldh [hMultiplier], a
	call Multiply
	ld a, 10
	ldh [hDivisor], a
	ld b, 4
	call Divide

; ========================
; ===== Choice Band ======
; ========================
; choice band - x1.5 damage but permanent encore
	push hl
	call GetUserItem
	ld a, b
	cp HELD_CHOICE_BAND
	pop hl
	jr nz, .choice_specs
	ld a, BATTLE_VARS_MOVE_TYPE
	call GetBattleVar
	cp SPECIAL
	jr nc, .choice_specs
	call Fifty_PercentBoost

.choice_specs
; =========================
; ===== Choice Specs ======
; =========================
; choice specs - x1.5 damage but permanent encore
	push hl
	call GetUserItem
	ld a, b
	cp HELD_CHOICE_SPECS
	pop hl
	jr nz, .muscle_band
	ld a, BATTLE_VARS_MOVE_TYPE
	call GetBattleVar
	cp SPECIAL
	jr c, .muscle_band
	call Fifty_PercentBoost

.muscle_band
; ========================
; ===== Muscle Band ======
; ========================
; muscle band - x1.1 damage
	push hl
	call GetUserItem
	ld a, b
	cp HELD_MUSCLE_BAND
	pop hl
	jr nz, .wise_glasses
	ld a, BATTLE_VARS_MOVE_TYPE
	call GetBattleVar
	cp SPECIAL
	jr nc, .wise_glasses
	call TenPercentBoost

.wise_glasses
; =========================
; ===== Wise Glasses ======
; =========================
; wise glasses - x1.1 damage
	push hl
	call GetUserItem
	ld a, b
	cp HELD_WISE_GLASSES
	pop hl
	jr nz, .continue
	ld a, BATTLE_VARS_MOVE_TYPE
	call GetBattleVar
	cp SPECIAL
	jr c, .continue
	call TenPercentBoost

.continue
; Critical hits
	call .CriticalMultiplier

; Update wCurDamage. Max 999 (capped at 997, then add 2).
DEF MAX_DAMAGE EQU 999
DEF MIN_DAMAGE EQU 2
DEF DAMAGE_CAP EQU MAX_DAMAGE - MIN_DAMAGE

	ld hl, wCurDamage
	ld b, [hl]
	ldh a, [hQuotient + 3]
	add b
	ldh [hQuotient + 3], a
	jr nc, .dont_cap_1

	ldh a, [hQuotient + 2]
	inc a
	ldh [hQuotient + 2], a
	and a
	jr z, .Cap

.dont_cap_1
	ldh a, [hQuotient]
	ld b, a
	ldh a, [hQuotient + 1]
	or a
	jr nz, .Cap

	ldh a, [hQuotient + 2]
	cp HIGH(DAMAGE_CAP + 1)
	jr c, .dont_cap_2

	cp HIGH(DAMAGE_CAP + 1) + 1
	jr nc, .Cap

	ldh a, [hQuotient + 3]
	cp LOW(DAMAGE_CAP + 1)
	jr nc, .Cap

.dont_cap_2
	inc hl

	ldh a, [hQuotient + 3]
	ld b, [hl]
	add b
	ld [hld], a

	ldh a, [hQuotient + 2]
	ld b, [hl]
	adc b
	ld [hl], a
	jr c, .Cap

	ld a, [hl]
	cp HIGH(DAMAGE_CAP + 1)
	jr c, .dont_cap_3

	cp HIGH(DAMAGE_CAP + 1) + 1
	jr nc, .Cap

	inc hl
	ld a, [hld]
	cp LOW(DAMAGE_CAP + 1)
	jr c, .dont_cap_3

.Cap:
	ld a, HIGH(DAMAGE_CAP)
	ld [hli], a
	ld a, LOW(DAMAGE_CAP)
	ld [hld], a

.dont_cap_3
; Add back MIN_DAMAGE (capping at 999).
	inc hl
	ld a, [hl]
	add MIN_DAMAGE
	ld [hld], a
	jr nc, .dont_floor
	inc [hl]
.dont_floor

; Returns nz and nc.
	ld a, 1
	and a
	ret

.CriticalMultiplier:
	ld a, [wCriticalHit]
	and a
	ret z

; =======================
; === Ability: Sniper === 
; =======================
	call GetCurrentMon
	push hl
	push de
	push bc
	ld hl, SniperPokemon
	call IsInByteArray
	pop bc
	pop de
	pop hl
	jr c, .sniper_mons_damage
	jr .regular_crit_damage

; sniper pokemon crits deal 3x base damage
.sniper_mons_damage
; x3
	xor a
	ldh [hMultiplicand + 0], a
	ldh a, [hQuotient + 2]
	ldh [hMultiplicand + 1], a
	ldh a, [hQuotient + 3]
	ldh [hMultiplicand + 2], a
	ld a, 30
	ldh [hMultiplier], a
	call Multiply
	ld a, 10
	ldh [hDivisor], a
	ld b, 4
	call Divide

	ldh a, [hQuotient + 3]
	ldh [hProduct + 3], a

	ldh a, [hQuotient + 2]
	ldh [hProduct + 2], a
	jr .CritCap

.regular_crit_damage
; critcal hits do 100% more damage
	ldh a, [hQuotient + 3]
	add a
	ldh [hQuotient + 3], a

	ldh a, [hQuotient + 2]
	rl a
	ldh [hQuotient + 2], a

; Cap at $ffff.
.CritCap
	ret nc

	ld a, $ff
	ldh [hQuotient + 2], a
	ldh [hQuotient + 3], a
	ret

INCLUDE "data/abilities/sniper_mons.asm"
INCLUDE "data/types/type_boost_items.asm"

BattleCommand_ConstantDamage:
	ld hl, wBattleMonLevel
	ldh a, [hBattleTurn]
	and a
	jr z, .got_turn
	ld hl, wEnemyMonLevel

.got_turn
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_LEVEL_DAMAGE
	ld b, [hl]
	ld a, 0
	jr z, .got_power

	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_SUPER_FANG
	jr z, .super_fang

	cp EFFECT_REVERSAL
	jr z, .reversal

	ld a, BATTLE_VARS_MOVE_POWER
	call GetBattleVar
	ld b, a
	ld a, $0
	jr .got_power

.super_fang
	ld hl, wEnemyMonHP
	ldh a, [hBattleTurn]
	and a
	jr z, .got_hp
	ld hl, wBattleMonHP
.got_hp
	ld a, [hli]
	srl a
	ld b, a
	ld a, [hl]
	rr a
	push af
	ld a, b
	pop bc
	and a
	jr nz, .got_power
	or b
	ld a, 0
	jr nz, .got_power
	ld b, 1
	;jr .got_power ; commented out to save space

.got_power
	ld hl, wCurDamage
	ld [hli], a
	ld [hl], b
	ret

.reversal
	ld hl, wBattleMonHP
	ldh a, [hBattleTurn]
	and a
	jr z, .reversal_got_hp
	ld hl, wEnemyMonHP
.reversal_got_hp
	xor a
	ldh [hDividend], a
	ldh [hMultiplicand + 0], a
	ld a, [hli]
	ldh [hMultiplicand + 1], a
	ld a, [hli]
	ldh [hMultiplicand + 2], a
	ld a, 48
	ldh [hMultiplier], a
	call Multiply
	ld a, [hli]
	ld b, a
	ld a, [hl]
	ldh [hDivisor], a
	ld a, b
	and a
	jr z, .skip_to_divide

	ldh a, [hProduct + 4]
	srl b
	rr a
	srl b
	rr a
	ldh [hDivisor], a
	ldh a, [hProduct + 2]
	ld b, a
	srl b
	ldh a, [hProduct + 3]
	rr a
	srl b
	rr a
	ldh [hDividend + 3], a
	ld a, b
	ldh [hDividend + 2], a

.skip_to_divide
	ld b, 4
	call Divide
	ldh a, [hQuotient + 3]
	ld b, a
	ld hl, FlailReversalPower

.reversal_loop
	ld a, [hli]
	cp b
	jr nc, .break_loop
	inc hl
	jr .reversal_loop

.break_loop
	ldh a, [hBattleTurn]
	and a
	ld a, [hl]
	jr nz, .notPlayersTurn

	ld hl, wPlayerMoveStructPower
	ld [hl], a
	push hl
	call PlayerAttackDamage
	jr .notEnemysTurn

.notPlayersTurn
	ld hl, wEnemyMoveStructPower
	ld [hl], a
	push hl
	call EnemyAttackDamage

.notEnemysTurn
	call BattleCommand_DamageCalc
	pop hl
	ld [hl], 1
	ret

FarPlayBattleAnimation:
; play animation de

	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVar
	and 1 << SUBSTATUS_FLYING | 1 << SUBSTATUS_UNDERGROUND
	ret nz
	; fallthrough

PlayFXAnimID:
	ld a, e
	ld [wFXAnimID], a
	ld a, d
	ld [wFXAnimID + 1], a

	ld c, 3
	call DelayFrames
	callfar PlayBattleAnim
	ret

DoEnemyDamage:
	ld hl, wCurDamage
	ld a, [hli]
	ld b, a
	ld a, [hl]
	or b
	jr z, .did_no_damage

	ld a, c
	and a
	jr nz, .ignore_substitute
	ld a, [wEnemySubStatus4]
	bit SUBSTATUS_SUBSTITUTE, a
	jmp nz, DoSubstituteDamage

.ignore_substitute
	; Subtract wCurDamage from wEnemyMonHP.
	;  store original HP in little endian wHPBuffer2
	ld a, [hld]
	ld b, a
	ld a, [wEnemyMonHP + 1]
	ld [wHPBuffer2], a
	sub b
	ld [wEnemyMonHP + 1], a
	ld a, [hl]
	ld b, a
	ld a, [wEnemyMonHP]
	ld [wHPBuffer2 + 1], a
	sbc b
	ld [wEnemyMonHP], a
if DEF(_DEBUG)
	push af
	ld a, BANK(sSkipBattle)
	call OpenSRAM
	ld a, [sSkipBattle]
	call CloseSRAM
	or a
	; If [sSkipBattle] is nonzero, skip the "jr nc, .no_underflow" check,
	; so any attack deals maximum damage to the enemy.
	jr nz, .debug_skip
	pop af
	jr nc, .no_underflow
	push af
.debug_skip
	pop af
else
	jr nc, .no_underflow
endc

	ld a, [wHPBuffer2 + 1]
	ld [hli], a
	ld a, [wHPBuffer2]
	ld [hl], a
	xor a
	ld hl, wEnemyMonHP
	ld [hli], a
	ld [hl], a

.no_underflow
	ld hl, wEnemyMonMaxHP
	ld a, [hli]
	ld [wHPBuffer1 + 1], a
	ld a, [hl]
	ld [wHPBuffer1], a
	ld hl, wEnemyMonHP
	ld a, [hli]
	ld [wHPBuffer3 + 1], a
	ld a, [hl]
	ld [wHPBuffer3], a

	hlcoord 2, 2
	xor a
	ld [wWhichHPBar], a
	predef AnimateHPBar
.did_no_damage
	jmp RefreshBattleHuds

DoPlayerDamage:
	ld hl, wCurDamage
	ld a, [hli]
	ld b, a
	ld a, [hl]
	or b
	jr z, .did_no_damage

	ld a, c
	and a
	jr nz, .ignore_substitute
	ld a, [wPlayerSubStatus4]
	bit SUBSTATUS_SUBSTITUTE, a
	jr nz, DoSubstituteDamage

.ignore_substitute
	; Subtract wCurDamage from wBattleMonHP.
	;  store original HP in little endian wHPBuffer2
	;  store new HP in little endian wHPBuffer3
	ld a, [hld]
	ld b, a
	ld a, [wBattleMonHP + 1]
	ld [wHPBuffer2], a
	sub b
	ld [wBattleMonHP + 1], a
	ld [wHPBuffer3], a
	ld b, [hl]
	ld a, [wBattleMonHP]
	ld [wHPBuffer2 + 1], a
	sbc b
	ld [wBattleMonHP], a
	ld [wHPBuffer3 + 1], a
	jr nc, .no_underflow

	ld a, [wHPBuffer2 + 1]
	ld [hli], a
	ld a, [wHPBuffer2]
	ld [hl], a
	xor a
	ld hl, wBattleMonHP
	ld [hli], a
	ld [hl], a
	ld hl, wHPBuffer3
	ld [hli], a
	ld [hl], a

.no_underflow
	ld hl, wBattleMonMaxHP
	ld a, [hli]
	ld [wHPBuffer1 + 1], a
	ld a, [hl]
	ld [wHPBuffer1], a

	hlcoord 10, 9
	ld a, 1
	ld [wWhichHPBar], a
	predef AnimateHPBar
.did_no_damage
	jmp RefreshBattleHuds

DoSubstituteDamage:
	ld hl, SubTookDamageText
	call StdBattleTextbox

	ld de, wEnemySubstituteHP
	ldh a, [hBattleTurn]
	and a
	jr z, .got_hp
	ld de, wPlayerSubstituteHP
.got_hp

	ld hl, wCurDamage
	ld a, [hli]
	and a
	jr nz, .broke

	ld a, [de]
	sub [hl]
	ld [de], a
	jr z, .broke
	jr nc, .done

.broke
	ld a, BATTLE_VARS_SUBSTATUS4_OPP
	call GetBattleVarAddr
	res SUBSTATUS_SUBSTITUTE, [hl]

	ld hl, SubFadedText
	call StdBattleTextbox

	call BattleCommand_SwitchTurn
	call BattleCommand_LowerSubNoAnim
	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVar
	and 1 << SUBSTATUS_FLYING | 1 << SUBSTATUS_UNDERGROUND
	call z, AppearUserLowerSub
	call BattleCommand_SwitchTurn

	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVarAddr
	cp EFFECT_MULTI_HIT
	jr z, .ok
	cp EFFECT_DOUBLE_HIT
	jr z, .ok
	cp EFFECT_POISON_MULTI_HIT
	jr z, .ok
	xor a
	ld [hl], a
.ok
	call RefreshBattleHuds
.done
	jmp ResetDamage

UpdateMoveData:
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVarAddr
	ld d, h
	ld e, l

	ld a, BATTLE_VARS_MOVE
	call GetBattleVar
	ld [wCurSpecies], a
	ld [wNamedObjectIndex], a

	dec a
	call GetMoveData
	call GetMoveName
	jmp CopyName1

CheckForStatusIfAlreadyHasAny:
	ld a, BATTLE_VARS_STATUS_OPP
	call GetBattleVarAddr
	ld d, h
	ld e, l
	and SLP_MASK
	ld hl, AlreadyAsleepText
	ret nz
	
	ld a, [de]
	bit FRZ, a
	ld hl, AlreadyFrozenText
	ret nz
	
	bit PAR, a
	ld hl, AlreadyParalyzedText
	ret nz
	
	bit PSN, a
	ld hl, AlreadyPoisonedText
	ret nz
	
	bit BRN, a
	ld hl, AlreadyBurnedText
	ret

BattleCommand_SleepTarget:
; ========================================
; === Ability: Serenity - Sleep Target ===
; ========================================
	call GetOpposingMon
	ld hl, SerenityPokemon
	call IsInByteArray
	jr c, Serenity
	; fallthrough

	call CheckForStatusIfAlreadyHasAny
	jr nz, .fail

	ld a, [wAttackMissed]
	and a
	jmp nz, PrintDidntAffect2

	ld hl, DidntAffect1Text

	call CheckSubstituteOpp
	jr nz, .fail

	call AnimateCurrentMove
	ld b, %011

.random_loop
	call BattleRandom
	and b
	jr z, .random_loop
	inc a
	ld [de], a
	call UpdateOpponentInParty
	call RefreshBattleHuds

	ld hl, FellAsleepText
	call StdBattleTextbox

	farcall UseHeldStatusHealingItem

	jmp z, OpponentCantMove
	ret

.fail
	push hl
	call AnimateFailedMove
	pop hl
	jmp StdBattleTextbox

Serenity:
	; add some delay so the text 
	; isn't instantly skipped
	ld c, 30
	call DelayFrames

	ld hl, SerenityText
	jmp StdBattleTextbox

BattleCommand_PoisonTarget:
	call CheckSubstituteOpp
	ret nz
	ld a, BATTLE_VARS_STATUS_OPP
	call GetBattleVarAddr
	and a
	ret nz
	ld a, [wTypeModifier]
	and EFFECTIVENESS_MASK
	ret z
	ld a, POISON ; Don't poison a Poison-type
	call CheckIfTargetIsGivenType
	ret z
	ld a, STEEL ; Don't poison a Steel-type
	call CheckIfTargetIsGivenType
	ret z

; =========================================
; === Ability: Serenity - Poison Target ===
; =========================================
	call GetOpposingMon
	ld hl, SerenityPokemon
	call IsInByteArray
	ret c
	; fallthrough

	ld a, [wEffectFailed]
	and a
	ret nz
	call SafeCheckSafeguard
	ret nz

	call PoisonOpponent
	ld de, ANIM_PSN
	call PlayOpponentBattleAnim
	call RefreshBattleHuds

	ld hl, WasPoisonedText
	call StdBattleTextbox

	farjp UseHeldStatusHealingItem

BattleCommand_Poison:
	ld hl, DoesntAffectText
	ld a, [wTypeModifier]
	and EFFECTIVENESS_MASK
	jr z, .failed

	ld a, POISON
	call CheckIfTargetIsGivenType
	jr z, .failed

	ld a, STEEL
	call CheckIfTargetIsGivenType
	jr z, .failed

	call CheckForStatusIfAlreadyHasAny
	jr nz, .failed

; ==================================
; === Ability: Serenity - Poison ===
; ==================================
	call GetOpposingMon
	ld hl, SerenityPokemon
	call IsInByteArray
	jr c, Serenity
	; fallthrough

	ld hl, DidntAffect1Text
	ld a, BATTLE_VARS_STATUS_OPP
	call GetBattleVar
	and a
	jr nz, .failed

	ld hl, ProtectingItselfText
	call CheckSubstituteOpp
	jr nz, .failed
	
	ld hl, EvadedText
	ld a, [wAttackMissed]
	and a
	jr nz, .failed
	call .check_toxic
	jr z, .toxic

	call .apply_poison
	ld hl, WasPoisonedText
	call StdBattleTextbox
	jr .finished

.toxic
	set SUBSTATUS_TOXIC, [hl]
	xor a
	ld [de], a
	call .apply_poison

	ld hl, BadlyPoisonedText
	call StdBattleTextbox

.finished
	farjp UseHeldStatusHealingItem

.failed
	push hl
	call AnimateFailedMove
	pop hl
	jmp StdBattleTextbox

.apply_poison
	call AnimateCurrentMove
	call PoisonOpponent
	jmp RefreshBattleHuds

.check_toxic
	ld a, BATTLE_VARS_SUBSTATUS5_OPP
	call GetBattleVarAddr
	ldh a, [hBattleTurn]
	and a
	ld de, wEnemyToxicCount
	jr z, .ok
	ld de, wPlayerToxicCount
.ok
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_TOXIC
	ret

CheckIfTargetIsGivenType:
	ld b, a
	ld de, wEnemyMonType1
	ldh a, [hBattleTurn]
	and a
	jr z, .ok
	ld de, wBattleMonType1
.ok
	ld a, [de]
	inc de
	cp b
	ret z
	ld a, [de]
	cp b
	ret

PoisonOpponent:
	ld a, BATTLE_VARS_STATUS_OPP
	call GetBattleVarAddr
	set PSN, [hl]
	jmp UpdateOpponentInParty

BattleCommand_DrainTarget:
	call SapHealth
	ld hl, SuckedHealthText
	jmp StdBattleTextbox

BattleCommand_EatDream:
	call SapHealth
	ld hl, DreamEatenText
	jmp StdBattleTextbox

SapHealth:
	; Divide damage by 2, store it in hDividend
	ld hl, wCurDamage
	ld a, [hli]
	srl a
	ldh [hDividend], a
	ld b, a
	ld a, [hl]
	rr a
	ldh [hDividend + 1], a
	or b
	jr nz, .at_least_one
	ld a, 1
	ldh [hDividend + 1], a
.at_least_one

	ld hl, wBattleMonHP
	ld de, wBattleMonMaxHP
	ldh a, [hBattleTurn]
	and a
	jr z, .battlemonhp
	ld hl, wEnemyMonHP
	ld de, wEnemyMonMaxHP
.battlemonhp

	; Store current HP in little endian wHPBuffer2
	ld bc, wHPBuffer2 + 1
	ld a, [hli]
	ld [bc], a
	ld a, [hl]
	dec bc
	ld [bc], a

	; Store max HP in little endian wHPBuffer1
	ld a, [de]
	dec bc
	ld [bc], a
	inc de
	ld a, [de]
	dec bc
	ld [bc], a

	; Add hDividend to current HP and copy it to little endian wHPBuffer3
	ldh a, [hDividend + 1]
	ld b, [hl]
	add b
	ld [hld], a
	ld [wHPBuffer3], a
	ldh a, [hDividend]
	ld b, [hl]
	adc b
	ld [hli], a
	ld [wHPBuffer3 + 1], a
	jr c, .max_hp

	; Subtract current HP from max HP (to see if we have more than max HP)
	ld a, [hld]
	ld b, a
	ld a, [de]
	dec de
	sub b
	ld a, [hli]
	ld b, a
	ld a, [de]
	inc de
	sbc b
	jr nc, .finish

.max_hp
	; Load max HP into current HP and copy it to little endian wHPBuffer3
	ld a, [de]
	ld [hld], a
	ld [wHPBuffer3], a
	dec de
	ld a, [de]
	ld [hli], a
	ld [wHPBuffer3 + 1], a
	inc de

.finish
	ldh a, [hBattleTurn]
	and a
	hlcoord 10, 9
	ld a, $1
	jr z, .hp_bar
	hlcoord 2, 2
	xor a
.hp_bar
	ld [wWhichHPBar], a
	predef AnimateHPBar
	call RefreshBattleHuds
	jmp UpdateBattleMonInParty

BattleCommand_BurnTarget:
	xor a
	ld [wNumHits], a
	call CheckSubstituteOpp
	ret nz
	ld a, BATTLE_VARS_STATUS_OPP
	call GetBattleVarAddr
	and a
	jr nz, Defrost
	ld a, [wTypeModifier]
	and EFFECTIVENESS_MASK
	ret z
	ld a, FIRE ; Don't burn a Fire-type
	call CheckIfTargetIsGivenType
	ret z

; =======================================
; === Ability: Serenity - Burn Target ===
; =======================================
	call GetOpposingMon
	ld hl, SerenityPokemon
	call IsInByteArray
	ret c
	; fallthrough

	ld a, [wEffectFailed]
	and a
	ret nz
	call SafeCheckSafeguard
	ret nz
	ld a, BATTLE_VARS_STATUS_OPP
	call GetBattleVarAddr
	set BRN, [hl]
	call UpdateOpponentInParty
	ld hl, ApplyBrnEffectOnAttack
	call CallBattleCore
	ld de, ANIM_BRN
	call PlayOpponentBattleAnim
	call RefreshBattleHuds

	ld hl, WasBurnedText
	call StdBattleTextbox

	farjp UseHeldStatusHealingItem

Defrost:
	ld a, [hl]
	and 1 << FRZ
	ret z

	xor a
	ld [hl], a

	ldh a, [hBattleTurn]
	and a
	ld a, [wCurOTMon]
	ld hl, wOTPartyMon1Status
	jr z, .ok
	ld hl, wPartyMon1Status
	ld a, [wCurBattleMon]
.ok

	call GetPartyLocation
	xor a
	ld [hl], a
	call UpdateOpponentInParty

	ld hl, DefrostedOpponentText
	jmp StdBattleTextbox

BattleCommand_FreezeTarget:
	xor a
	ld [wNumHits], a
	call CheckSubstituteOpp
	ret nz
	ld a, BATTLE_VARS_STATUS_OPP
	call GetBattleVarAddr
	and a
	ret nz
	ld a, [wTypeModifier]
	and EFFECTIVENESS_MASK
	ret z
	ld a, [wBattleWeather]
	cp WEATHER_SUN
	ret z
	ld a, ICE ; Don't freeze an Ice-type
	call CheckIfTargetIsGivenType
	ret z

; ===========================================
; === Ability: Serenity - Frostbite Target ==
; ===========================================
	call GetOpposingMon
	ld hl, SerenityPokemon
	call IsInByteArray
	ret c
	; fallthrough

	ld a, [wEffectFailed]
	and a
	ret nz
	call SafeCheckSafeguard
	ret nz
	ld a, BATTLE_VARS_STATUS_OPP
	call GetBattleVarAddr
	set FRZ, [hl]
	call UpdateOpponentInParty
	ld hl, ApplyFrbEffectOnSpclAttack
	call CallBattleCore
	ld de, ANIM_FRZ
	call PlayOpponentBattleAnim
	call RefreshBattleHuds

	ld hl, GotAFrostbiteText
	call StdBattleTextbox

	farjp UseHeldStatusHealingItem

BattleCommand_ParalyzeTarget:
	xor a
	ld [wNumHits], a
	call CheckSubstituteOpp
	ret nz
	ld a, BATTLE_VARS_STATUS_OPP
	call GetBattleVarAddr
	and a
	ret nz
	ld a, [wTypeModifier]
	and EFFECTIVENESS_MASK
	ret z
	; fallthrough

; ===========================================
; === Ability: Serenity - Paralyze Target ===
; ===========================================
	call GetOpposingMon
	ld hl, SerenityPokemon
	call IsInByteArray
	ret c
	; fallthrough

; ===========================
; === Ability: Sure Shock ===
; ===========================
; certain Pokemon always paralyze with T-bolt
	; check move
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	cp THUNDERBOLT
	jr nz, .done
	
	; check user species
	call GetCurrentMon
	ld hl, SureShockPokemon
	call IsInByteArray
	jr c, .paralyze
	jr .done

	; 100% paralyze foe
.paralyze
	xor a
	ld [wEffectFailed], a
	; fallthrough

.done
	ld a, [wEffectFailed]
	and a
	ret nz
	call SafeCheckSafeguard
	ret nz
	ld a, BATTLE_VARS_STATUS_OPP
	call GetBattleVarAddr
	set PAR, [hl]
	call UpdateOpponentInParty
	ld hl, ApplyPrzEffectOnSpeed
	call CallBattleCore
	ld de, ANIM_PAR
	call PlayOpponentBattleAnim
	call RefreshBattleHuds
	call PrintParalyze
	ld hl, UseHeldStatusHealingItem
	jmp CallBattleCore

INCLUDE "data/abilities/sure_shock_mons.asm"
INCLUDE "data/abilities/serenity_mons.asm"

BattleCommand_AttackUp:
	ld b, ATTACK
	jr BattleCommand_StatUp

BattleCommand_DefenseUp:
	ld b, DEFENSE
	jr BattleCommand_StatUp

BattleCommand_SpeedUp:
	ld b, SPEED
	jr BattleCommand_StatUp

BattleCommand_SpecialAttackUp:
	ld b, SP_ATTACK
	jr BattleCommand_StatUp

BattleCommand_SpecialDefenseUp:
	ld b, SP_DEFENSE
	jr BattleCommand_StatUp

BattleCommand_AccuracyUp:
	ld b, ACCURACY
	jr BattleCommand_StatUp

BattleCommand_EvasionUp:
	ld b, EVASION
	jr BattleCommand_StatUp

BattleCommand_AttackUp2:
	ld b, $10 | ATTACK
	jr BattleCommand_StatUp

BattleCommand_DefenseUp2:
	ld b, $10 | DEFENSE
	jr BattleCommand_StatUp

BattleCommand_SpeedUp2:
	ld b, $10 | SPEED
	jr BattleCommand_StatUp

BattleCommand_SpecialAttackUp2:
	ld b, $10 | SP_ATTACK
	jr BattleCommand_StatUp

BattleCommand_SpecialDefenseUp2:
	ld b, $10 | SP_DEFENSE
	jr BattleCommand_StatUp

BattleCommand_AccuracyUp2:
	ld b, $10 | ACCURACY
	jr BattleCommand_StatUp

BattleCommand_EvasionUp2:
	ld b, $10 | EVASION
	; fallthrough

BattleCommand_StatUp:
	call RaiseStat
	ld a, [wFailedMessage]
	and a
	ret nz
	; fallthrough

MinimizeDropSub:
; Lower the substitute if we're minimizing

	ld bc, wPlayerMinimized
	ld hl, DropPlayerSub
	ldh a, [hBattleTurn]
	and a
	jr z, .do_player
	ld bc, wEnemyMinimized
	ld hl, DropEnemySub
.do_player
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	cp MINIMIZE
	ret nz

	ld a, $1
	ld [bc], a
	call _CheckBattleScene
	ret nc

	xor a
	ldh [hBGMapMode], a
	call CallBattleCore
	call WaitBGMap
	jmp BattleCommand_MoveDelay

RaiseStat:
	ld a, b
	ld [wLoweredStat], a
	ld hl, wPlayerStatLevels
	ldh a, [hBattleTurn]
	and a
	jr z, .got_stat_levels
	ld hl, wEnemyStatLevels
.got_stat_levels
	ld a, [wAttackMissed]
	and a
	jr nz, .stat_raise_failed
	ld a, [wEffectFailed]
	and a
	jr nz, .stat_raise_failed
	ld a, [wLoweredStat]
	and $f
	ld c, a
	ld b, 0
	add hl, bc
	ld b, [hl]
	inc b
	ld a, MAX_STAT_LEVEL
	cp b
	jr c, .cant_raise_stat
	ld a, [wLoweredStat]
	and $f0
	jr z, .got_num_stages
	inc b
	ld a, MAX_STAT_LEVEL
	cp b
	jr nc, .got_num_stages
	ld b, a
.got_num_stages
	ld [hl], b
	push hl
	ld a, c
	cp ACCURACY
	jr nc, .done_calcing_stats
	ld hl, wBattleMonStats + 1
	ld de, wPlayerStats
	ldh a, [hBattleTurn]
	and a
	jr z, .got_stats_pointer
	ld hl, wEnemyMonStats + 1
	ld de, wEnemyStats
.got_stats_pointer
	push bc
	sla c
	ld b, 0
	add hl, bc
	ld a, c
	add e
	ld e, a
	jr nc, .no_carry
	inc d
.no_carry
	pop bc
	ld a, [hld]
	sub LOW(MAX_STAT_VALUE)
	jr nz, .not_already_max
	ld a, [hl]
	sbc HIGH(MAX_STAT_VALUE)
	jr z, .stats_already_max
.not_already_max
	ldh a, [hBattleTurn]
	and a
	jr z, .calc_player_stats
	call CalcEnemyStats
	jr .done_calcing_stats

.calc_player_stats
	call CalcPlayerStats
.done_calcing_stats
	pop hl
	xor a
	ld [wFailedMessage], a
	ret

.stats_already_max
	pop hl
	dec [hl]
	; fallthrough

.cant_raise_stat
	ld a, $2
	ld [wFailedMessage], a
	ld a, $1
	ld [wAttackMissed], a
	ret

.stat_raise_failed
	ld a, $1
	ld [wFailedMessage], a
	ret

BattleCommand_AttackDown:
	ld a, ATTACK
	jr BattleCommand_StatDown

BattleCommand_DefenseDown:
	ld a, DEFENSE
	jr BattleCommand_StatDown

BattleCommand_SpeedDown:
	ld a, SPEED
	jr BattleCommand_StatDown

BattleCommand_SpecialAttackDown:
	ld a, SP_ATTACK
	jr BattleCommand_StatDown

BattleCommand_SpecialDefenseDown:
	ld a, SP_DEFENSE
	jr BattleCommand_StatDown

BattleCommand_AccuracyDown:
	ld a, ACCURACY
	jr BattleCommand_StatDown

BattleCommand_EvasionDown:
	ld a, EVASION
	jr BattleCommand_StatDown

BattleCommand_AttackDown2:
	ld a, $10 | ATTACK
	jr BattleCommand_StatDown

BattleCommand_DefenseDown2:
	ld a, $10 | DEFENSE
	jr BattleCommand_StatDown

BattleCommand_SpeedDown2:
	ld a, $10 | SPEED
	jr BattleCommand_StatDown

BattleCommand_SpecialAttackDown2:
	ld a, $10 | SP_ATTACK
	jr BattleCommand_StatDown

BattleCommand_SpecialDefenseDown2:
	ld a, $10 | SP_DEFENSE
	jr BattleCommand_StatDown

BattleCommand_AccuracyDown2:
	ld a, $10 | ACCURACY
	jr BattleCommand_StatDown

BattleCommand_EvasionDown2:
	ld a, $10 | EVASION
	; fallthrough

BattleCommand_StatDown:
	ld [wLoweredStat], a

	call CheckMist
	jmp nz, .Mist

	ld hl, wEnemyStatLevels
	ldh a, [hBattleTurn]
	and a
	ld a, [wEnemyMonSpecies]
	jr z, .check_clear_body
	ld hl, wPlayerStatLevels
	ld a, [wBattleMonSpecies]

.check_clear_body
; ===========================
; === Ability: Clear Body ===
; ===========================
	push hl
	push de
	push bc
	ld hl, ClearBodyPokemon
	call IsInByteArray
	pop bc
	pop de
	pop hl
	jr c, .clear_body

; Attempt to lower the stat.
	ld a, [wLoweredStat]
	and $f
	ld c, a
	ld b, 0
	add hl, bc
	ld b, [hl]
	dec b
	jr z, .CantLower

; Sharply lower the stat if applicable.
	ld a, [wLoweredStat]
	and $f0
	jr z, .GotAmountToLower
	dec b
	jr nz, .GotAmountToLower
	inc b

.GotAmountToLower:
	call CheckSubstituteOpp
	jr nz, .Failed

	ld a, [wAttackMissed]
	and a
	jr nz, .Failed

	ld a, [wEffectFailed]
	and a
	jr nz, .Failed

	call CheckHiddenOpponent
	jr nz, .Failed

; Accuracy/Evasion reduction don't involve stats.
	ld [hl], b
	ld a, c
	cp ACCURACY
	jr nc, .Hit

	push hl
	ld hl, wEnemyMonAttack + 1
	ld de, wEnemyStats
	ldh a, [hBattleTurn]
	and a
	jr z, .do_enemy
	ld hl, wBattleMonAttack + 1
	ld de, wPlayerStats
.do_enemy
	call TryLowerStat
	pop hl
	jr z, .CouldntLower

.Hit:
	xor a
	ld [wFailedMessage], a
	ret

.CouldntLower:
	inc [hl]
.CantLower:
	ld a, 3
	ld [wFailedMessage], a
	ld a, 1
	ld [wAttackMissed], a
	ret

.Failed:
	ld a, 1
	ld [wFailedMessage], a
	ld [wAttackMissed], a
	ret

.Mist:
	ld a, 2
	ld [wFailedMessage], a
	ld a, 1
	ld [wAttackMissed], a
	ret

.clear_body:
	; add some delay so the text 
	; isn't instantly skipped
	ld c, 30
	call DelayFrames

	ld hl, ClearBodyText
	call StdBattleTextbox
	ld a, 2
	ld [wFailedMessage], a
	ld a, 1
	ld [wAttackMissed], a
	ret

INCLUDE "data/abilities/clear_body_mons.asm"

CheckMist:
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_ATTACK_DOWN
	jr c, .dont_check_mist
	cp EFFECT_EVASION_DOWN + 1
	jr c, .check_mist
	cp EFFECT_ATTACK_DOWN_2
	jr c, .dont_check_mist
	cp EFFECT_EVASION_DOWN_2 + 1
	jr c, .check_mist
	cp EFFECT_ATTACK_DOWN_HIT
	jr c, .dont_check_mist
	cp EFFECT_EVASION_DOWN_HIT + 1
	jr c, .check_mist
.dont_check_mist
	xor a
	ret

.check_mist
	ld a, BATTLE_VARS_SUBSTATUS4_OPP
	call GetBattleVar
	bit SUBSTATUS_MIST, a
	ret

BattleCommand_StatDownMessage:
	ld a, [wFailedMessage]
	and a
	ret nz

	ld a, [wOptions]
	bit BATTLE_SCENE, a
	jr nz, .skip_stat_down_anim
	
	; play animation after every stat down
	call BattleCommand_SwitchTurn
	xor a
	ld [wNumHits], a
	ld de, ANIM_STAT_DOWN
	farcall Call_PlayBattleAnim
	call BattleCommand_SwitchTurn

.skip_stat_down_anim
	ld a, [wLoweredStat]
	and $f
	ld b, a
	inc b
	call GetStatName
	ld hl, .stat
	jmp BattleTextbox

.stat
	text_far Text_BattleFoeEffectActivate
	text_asm
	ld hl, .BattleStatFellText
	ld a, [wLoweredStat]
	and $f0
	ret z
	ld hl, .BattleStatSharplyFellText
	ret

.BattleStatSharplyFellText:
	text_far _BattleStatSharplyFellText
	text_end

.BattleStatFellText:
	text_far _BattleStatFellText
	text_end

TryLowerStat:
; Lower stat c from stat struct hl (buffer de).

	push bc
	sla c
	ld b, 0
	add hl, bc
	; add de, c
	ld a, c
	add e
	ld e, a
	jr nc, .no_carry
	inc d
.no_carry
	pop bc

; The lowest possible stat is 1.
	ld a, [hld]
	sub 1
	jr nz, .not_min
	ld a, [hl]
	and a
	ret z

.not_min
	ldh a, [hBattleTurn]
	and a
	jr z, .Player

	call BattleCommand_SwitchTurn
	call CalcPlayerStats
	call BattleCommand_SwitchTurn
	jr .end

.Player:
	call BattleCommand_SwitchTurn
	call CalcEnemyStats
	call BattleCommand_SwitchTurn
.end
	ld a, 1
	and a
	ret

BattleCommand_StatUpFailText:
	ld a, [wFailedMessage]
	and a
	ret z
	push af
	call BattleCommand_MoveDelay
	pop af
	dec a
	jmp z, TryPrintButItFailed
	ld a, [wLoweredStat]
	and $f
	ld b, a
	inc b
	call GetStatName
	ld hl, WontRiseAnymoreText
	jmp StdBattleTextbox

BattleCommand_StatDownFailText:
	ld a, [wFailedMessage]
	and a
	ret z
	push af
	call BattleCommand_MoveDelay
	pop af
	dec a
	jmp z, TryPrintButItFailed
	dec a
	ld hl, ProtectedByMistText
	jmp z, StdBattleTextbox
	ld a, [wLoweredStat]
	and $f
	ld b, a
	inc b
	call GetStatName
	ld hl, WontDropAnymoreText
	jmp StdBattleTextbox

GetStatName:
	ld hl, StatNames
	ld c, "@"
.CheckName:
	dec b
	jr z, .Copy
.GetName:
	ld a, [hli]
	cp c
	jr z, .CheckName
	jr .GetName

.Copy:
	ld de, wStringBuffer2
	ld bc, STRING_BUFFER_LENGTH
	jmp CopyBytes

INCLUDE "data/battle/stat_names.asm"

INCLUDE "data/battle/stat_multipliers.asm"

BattleCommand_AllStatsUp:
; Attack
	call ResetMiss
	call BattleCommand_AttackUp
	call BattleCommand_StatUpMessage

; Defense
	call ResetMiss
	call BattleCommand_DefenseUp
	call BattleCommand_StatUpMessage

; Speed
	call ResetMiss
	call BattleCommand_SpeedUp
	call BattleCommand_StatUpMessage

; Special Attack
	call ResetMiss
	call BattleCommand_SpecialAttackUp
	call BattleCommand_StatUpMessage

; Special Defense
	call ResetMiss
	call BattleCommand_SpecialDefenseUp
	; fallthrough

BattleCommand_StatUpMessage:
	ld a, [wFailedMessage]
	and a
	ret nz

	ld a, [wOptions]
	bit BATTLE_SCENE, a
	jr nz, .skip_stat_up_anim

	; play animation after every stat up
	ld de, ANIM_STAT_UP
	farcall Call_PlayBattleAnim	

.skip_stat_up_anim
	ld a, [wLoweredStat]
	and $f
	ld b, a
	inc b
	call GetStatName
	ld hl, .stat
	jmp BattleTextbox

.stat
	text_far Text_BattleEffectActivate
	text_asm
	ld hl, .BattleStatWentUpText
	ld a, [wLoweredStat]
	and $f0
	ret z
	ld hl, .BattleStatWentWayUpText
	ret

.BattleStatWentWayUpText:
	text_far _BattleStatWentWayUpText
	text_end

.BattleStatWentUpText:
	text_far _BattleStatWentUpText
	text_end

ResetMiss:
	xor a
	ld [wAttackMissed], a
	ret

LowerStat:
	ld [wLoweredStat], a

	ld hl, wPlayerStatLevels
	ldh a, [hBattleTurn]
	and a
	jr z, .got_target
	ld hl, wEnemyStatLevels

.got_target
	ld a, [wLoweredStat]
	and $f
	ld c, a
	ld b, 0
	add hl, bc
	ld b, [hl]
	dec b
	jr z, .cant_lower_anymore

	ld a, [wLoweredStat]
	and $f0
	jr z, .got_num_stages
	dec b
	jr nz, .got_num_stages
	inc b

.got_num_stages
	ld [hl], b
	ld a, c
	cp ACCURACY
	jr nc, .accuracy_evasion

	push hl
	ld hl, wBattleMonStats + 1
	ld de, wPlayerStats
	ldh a, [hBattleTurn]
	and a
	jr z, .got_target_2
	ld hl, wEnemyMonStats + 1
	ld de, wEnemyStats

.got_target_2
	call TryLowerStat
	pop hl
	jr z, .failed

.accuracy_evasion
	ldh a, [hBattleTurn]
	and a
	jr z, .player

	call CalcEnemyStats

	jr .finish

.player
	call CalcPlayerStats

.finish
	xor a
	ld [wFailedMessage], a
	ret

.failed
	inc [hl]

.cant_lower_anymore
	ld a, 2
	ld [wFailedMessage], a
	ret

BattleCommand_TriStatusChance:
	call BattleCommand_EffectChance
.loop
	; 1/3 chance of each status
	call BattleRandom
	swap a
	and %11
	jr z, .loop
	dec a
	ld hl, .StatusCommands
	rst JumpTable
	ret

.StatusCommands:
	dw BattleCommand_ParalyzeTarget ; paralyze
	dw BattleCommand_FreezeTarget ; freeze
	dw BattleCommand_BurnTarget ; burn

BattleCommand_Curl:
	ld a, BATTLE_VARS_SUBSTATUS2
	call GetBattleVarAddr
	set SUBSTATUS_CURLED, [hl]
	ret

BattleCommand_RaiseSubNoAnim:
	ld hl, GetBattleMonBackpic
	ldh a, [hBattleTurn]
	and a
	jr z, .PlayerTurn
	ld hl, GetEnemyMonFrontpic
.PlayerTurn:
	xor a
	ldh [hBGMapMode], a
	call CallBattleCore
	jmp WaitBGMap

BattleCommand_LowerSubNoAnim:
	ld hl, DropPlayerSub
	ldh a, [hBattleTurn]
	and a
	jr z, .PlayerTurn
	ld hl, DropEnemySub
.PlayerTurn:
	xor a
	ldh [hBGMapMode], a
	call CallBattleCore
	jmp WaitBGMap

CalcPokemonStats:
	ldh a, [hBattleTurn]
	and a
	jr nz, CalcEnemyStats
	; fallthrough

CalcPlayerStats:
	ld hl, wPlayerAtkLevel
	ld de, wPlayerStats
	ld bc, wBattleMonAttack

	ld a, NUM_BATTLE_STATS
	call CalcBattleStats

	call BattleCommand_SwitchTurn

	ld hl, ApplyPrzEffectOnSpeed
	call CallBattleCore

	ld hl, ApplyBrnEffectOnAttack
	call CallBattleCore

	ld hl, ApplyFrbEffectOnSpclAttack
	call CallBattleCore

	jmp BattleCommand_SwitchTurn

CalcEnemyStats:
	ld hl, wEnemyAtkLevel
	ld de, wEnemyStats
	ld bc, wEnemyMonAttack

	ld a, NUM_BATTLE_STATS
	call CalcBattleStats

	call BattleCommand_SwitchTurn

	ld hl, ApplyPrzEffectOnSpeed
	call CallBattleCore

	ld hl, ApplyBrnEffectOnAttack
	call CallBattleCore

	ld hl, ApplyFrbEffectOnSpclAttack
	call CallBattleCore

	jmp BattleCommand_SwitchTurn

CalcBattleStats:
.loop
	push af
	ld a, [hli]
	push hl
	push bc

	ld c, a
	dec c
	ld b, 0
	ld hl, StatLevelMultipliers
	add hl, bc
	add hl, bc

	xor a
	ldh [hMultiplicand + 0], a
	ld a, [de]
	ldh [hMultiplicand + 1], a
	inc de
	ld a, [de]
	ldh [hMultiplicand + 2], a
	inc de

	ld a, [hli]
	ldh [hMultiplier], a
	call Multiply

	ld a, [hl]
	ldh [hDivisor], a
	ld b, 4
	call Divide

	ldh a, [hQuotient + 2]
	ld b, a
	ldh a, [hQuotient + 3]
	or b
	jr nz, .check_maxed_out

	ld a, 1
	ldh [hQuotient + 3], a
	jr .not_maxed_out

.check_maxed_out
	ldh a, [hQuotient + 3]
	cp LOW(MAX_STAT_VALUE)
	ld a, b
	sbc HIGH(MAX_STAT_VALUE)
	jr c, .not_maxed_out

	ld a, LOW(MAX_STAT_VALUE)
	ldh [hQuotient + 3], a
	ld a, HIGH(MAX_STAT_VALUE)
	ldh [hQuotient + 2], a

.not_maxed_out
	pop bc
	ldh a, [hQuotient + 2]
	ld [bc], a
	inc bc
	ldh a, [hQuotient + 3]
	ld [bc], a
	inc bc
	pop hl
	pop af
	dec a
	jr nz, .loop
	ret

BattleCommand_CheckRampage:
	ld de, wPlayerRolloutCount
	ldh a, [hBattleTurn]
	and a
	jr z, .player
	ld de, wEnemyRolloutCount
.player
	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVarAddr
	bit SUBSTATUS_RAMPAGE, [hl]
	ret z
	ld a, [de]
	dec a
	ld [de], a
	jr nz, .continue_rampage

	res SUBSTATUS_RAMPAGE, [hl]
	call BattleCommand_SwitchTurn
	call SafeCheckSafeguard
	push af
	call BattleCommand_SwitchTurn
	pop af
	jr nz, .continue_rampage

	set SUBSTATUS_CONFUSED, [hl]
	call BattleRandom
	and %00000001
	inc a
	inc a
	inc de ; ConfuseCount
	ld [de], a
.continue_rampage
	ld b, rampage_command
	; fallthrough

SkipToBattleCommand:
; Skip over commands until reaching command b.
	ld a, [wBattleScriptBufferAddress + 1]
	ld h, a
	ld a, [wBattleScriptBufferAddress]
	ld l, a
.loop
	ld a, [hli]
	cp b
	jr nz, .loop

	ld a, h
	ld [wBattleScriptBufferAddress + 1], a
	ld a, l
	ld [wBattleScriptBufferAddress], a
	ret

BattleCommand_Rampage:
; No rampage during Sleep Talk.
	ld a, BATTLE_VARS_STATUS
	call GetBattleVar
	and SLP_MASK
	ret nz

	ld de, wPlayerRolloutCount
	ldh a, [hBattleTurn]
	and a
	jr z, .playerTurn
	ld de, wEnemyRolloutCount
	ld a, [wEnemyMonSpecies]
	jr z, .ok
.playerTurn
	ld de, wPlayerRolloutCount
	ld a, [wBattleMonSpecies]	
.ok

; ============================
; === Ability: Feral Focus ===
; ============================
	; freely use rapage moves
	call GetCurrentMon
	ld hl, FeralFocusPokemon
	call IsInByteArray
	ret c

	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVarAddr
	set SUBSTATUS_RAMPAGE, [hl]
; Rampage for 1 or 2 more turns
	call BattleRandom
	and %00000001
	inc a
	ld [de], a
	ld a, 1
	ld [wSomeoneIsRampaging], a
	ret

INCLUDE "data/abilities/feral_focus_mons.asm"

SetBattleDraw:
	ld a, [wBattleResult]
	and BATTLERESULT_BITMASK
	or DRAW
	ld [wBattleResult], a
	ret

BattleCommand_ForceSwitch:
	ld a, [wBattleType]
	cp BATTLETYPE_FORCESHINY
	jmp z, .fail
	cp BATTLETYPE_TRAP
	jmp z, .fail
	cp BATTLETYPE_CELEBI
	jmp z, .fail
	cp BATTLETYPE_SUICUNE
	jmp z, .fail
	ldh a, [hBattleTurn]
	and a
	jmp nz, .force_player_switch
	ld a, [wAttackMissed]
	and a
	jr nz, .missed
	ld a, [wBattleMode]
	dec a
	jr nz, .trainer
	ld a, [wCurPartyLevel]
	ld b, a
	ld a, [wBattleMonLevel]
	cp b
	jr nc, .wild_force_flee
	add b
	ld c, a
	inc c
.random_loop_wild
	call BattleRandom
	cp c
	jr nc, .random_loop_wild
	srl b
	srl b
	cp b
	jr nc, .wild_force_flee
.missed
	jmp .fail

.wild_force_flee
	call UpdateBattleMonInParty
	xor a
	ld [wNumHits], a
	inc a ; TRUE
	ld [wForcedSwitch], a
	call SetBattleDraw
	ld a, [wPlayerMoveStructAnimation]
	jmp .succeed

.trainer
	call FindAliveEnemyMons
	jr c, .switch_fail
	ld a, [wEnemyGoesFirst]
	and a
	jr z, .switch_fail
	call UpdateEnemyMonInParty
	ld a, $1
	ld [wBattleAnimParam], a
	call AnimateCurrentMove
	ld c, $14
	call DelayFrames
	hlcoord 1, 0
	lb bc, 4, 10
	call ClearBox
	ld c, 20
	call DelayFrames
	ld a, [wOTPartyCount]
	ld b, a
	ld a, [wCurOTMon]
	ld c, a
; select a random enemy mon to switch to
.random_loop_trainer
	call BattleRandom
	and $7
	cp b
	jr nc, .random_loop_trainer
	cp c
	jr z, .random_loop_trainer
	push af
	push bc
	ld hl, wOTPartyMon1HP
	call GetPartyLocation
	ld a, [hli]
	or [hl]
	pop bc
	pop de
	jr z, .random_loop_trainer
	ld a, d
	inc a
	ld [wEnemySwitchMonIndex], a
	callfar ForceEnemySwitch

	ld hl, DraggedOutText
	call StdBattleTextbox

	ld hl, SpikesDamage
	jmp CallBattleCore

.switch_fail
	jmp .fail

.force_player_switch
	ld a, [wAttackMissed]
	and a
	jr nz, .player_miss

	ld a, [wBattleMode]
	dec a
	jr nz, .vs_trainer

	ld a, [wBattleMonLevel]
	ld b, a
	ld a, [wCurPartyLevel]
	cp b
	jr nc, .wild_succeed_playeristarget

	add b
	ld c, a
	inc c
.wild_random_loop_playeristarget
	call BattleRandom
	cp c
	jr nc, .wild_random_loop_playeristarget

	srl b
	srl b
	cp b
	jr nc, .wild_succeed_playeristarget

.player_miss
	jr .fail

.wild_succeed_playeristarget
	call UpdateBattleMonInParty
	xor a
	ld [wNumHits], a
	inc a ; TRUE
	ld [wForcedSwitch], a
	call SetBattleDraw
	ld a, [wEnemyMoveStructAnimation]
	jr .succeed

.vs_trainer
	call CheckPlayerHasMonToSwitchTo
	jr c, .fail

	ld a, [wEnemyGoesFirst]
	cp $1
	jr z, .switch_fail

	call UpdateBattleMonInParty
	ld a, $1
	ld [wBattleAnimParam], a
	call AnimateCurrentMove
	ld c, 20
	call DelayFrames
	hlcoord 9, 7
	lb bc, 5, 11
	call ClearBox
	ld c, 20
	call DelayFrames
	ld a, [wPartyCount]
	ld b, a
	ld a, [wCurBattleMon]
	ld c, a
.random_loop_trainer_playeristarget
	call BattleRandom
	and $7
	cp b
	jr nc, .random_loop_trainer_playeristarget

	cp c
	jr z, .random_loop_trainer_playeristarget

	push af
	push bc
	ld hl, wPartyMon1HP
	call GetPartyLocation
	ld a, [hli]
	or [hl]
	pop bc
	pop de
	jr z, .random_loop_trainer_playeristarget

	ld a, d
	ld [wCurPartyMon], a
	ld hl, SwitchPlayerMon
	call CallBattleCore

	ld hl, DraggedOutText
	call StdBattleTextbox

	ld hl, SpikesDamage
	jmp CallBattleCore

.fail
	call BattleCommand_LowerSub
	call BattleCommand_MoveDelay
	call BattleCommand_RaiseSub
	jmp PrintButItFailed

.succeed
	push af
	call SetBattleDraw
	ld a, $1
	ld [wBattleAnimParam], a
	call AnimateCurrentMove
	ld c, 20
	call DelayFrames
	pop af

	ld hl, FledInFearText
	cp ROAR
	jr z, .do_text
	ld hl, BlownAwayText
.do_text
	jmp StdBattleTextbox

CheckPlayerHasMonToSwitchTo:
	ld a, [wPartyCount]
	ld d, a
	ld e, 0
	ld bc, PARTYMON_STRUCT_LENGTH
.loop
	ld a, [wCurBattleMon]
	cp e
	jr z, .next

	ld a, e
	ld hl, wPartyMon1HP
	call AddNTimes
	ld a, [hli]
	or [hl]
	jr nz, .not_fainted

.next
	inc e
	dec d
	jr nz, .loop

	scf
	ret

.not_fainted
	and a
	ret

BattleCommand_EndLoop:
; Loop back to 'critical'.

	ld de, wPlayerRolloutCount
	ld bc, wPlayerDamageTaken
	ldh a, [hBattleTurn]
	and a
	jr z, .got_addrs
	ld de, wEnemyRolloutCount
	ld bc, wEnemyDamageTaken
.got_addrs

	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVarAddr
	bit SUBSTATUS_IN_LOOP, [hl]
	jr nz, .in_loop
	set SUBSTATUS_IN_LOOP, [hl]
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVarAddr
	ld a, [hl]
	cp EFFECT_POISON_MULTI_HIT
	jr z, .twineedle
	cp EFFECT_DOUBLE_HIT
	ld a, 1
	jr z, .double_hit

	call BattleRandom
	and $1
	jr z, .middle_hits
	call BattleRandom
	and $1
	jr z, .more_hits
	call BattleRandom
	and $1
	jr z, .got_number_hits
	xor a
	inc a
.more_hits
	inc a
.middle_hits
	inc a
.got_number_hits
	inc a
.double_hit
	ld [de], a
	inc a
	ld [bc], a
	jr .loop_back_to_critical

.twineedle
	ld a, 1
	jr .double_hit

.in_loop
	ld a, [de]
	dec a
	ld [de], a
	jr nz, .loop_back_to_critical
	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVarAddr
	res SUBSTATUS_IN_LOOP, [hl]

	ld hl, PlayerHitTimesText
	ldh a, [hBattleTurn]
	and a
	jr z, .got_hit_n_times_text
	ld hl, EnemyHitTimesText
.got_hit_n_times_text

	push bc
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	call StdBattleTextbox

	pop bc
	xor a
	ld [bc], a
	ret

.loop_back_to_critical
	ld a, [wBattleScriptBufferAddress + 1]
	ld h, a
	ld a, [wBattleScriptBufferAddress]
	ld l, a
.not_critical
	ld a, [hld]
	cp critical_command
	jr nz, .not_critical
	inc hl
	ld a, h
	ld [wBattleScriptBufferAddress + 1], a
	ld a, l
	ld [wBattleScriptBufferAddress], a
	ret

BattleCommand_FlinchTarget:
	call CheckSubstituteOpp
	ret nz

	ld a, BATTLE_VARS_STATUS_OPP
	call GetBattleVar
	and SLP_MASK
	ret nz

	call CheckOpponentWentFirst
	ret nz

	ld a, [wEffectFailed]
	and a
	ret nz

; ====================
; === Inner Focus ====
; ====================
	call GetOpposingMon
	ld hl, InnerFocusPokemon
	call IsInByteArray
	jr c, .no_flinch
	jr FlinchTarget

.no_flinch
	ld hl, InnerFocusText
	jmp StdBattleTextbox

INCLUDE "data/abilities/inner_focus_mons.asm"

FlinchTarget:
	ld a, BATTLE_VARS_SUBSTATUS3_OPP
	call GetBattleVarAddr
	set SUBSTATUS_FLINCHED, [hl]
	jmp EndRechargeOpp

CheckOpponentWentFirst:
; Returns a=0, z if user went first
; Returns a=1, nz if opponent went first
	push bc
	ld a, [wEnemyGoesFirst] ; 0 if player went first
	ld b, a
	ldh a, [hBattleTurn] ; 0 if it's the player's turn
	xor b ; 1 if opponent went first
	pop bc
	ret

BattleCommand_HeldFlinch:
; kingsrock

	ld a, [wAttackMissed]
	and a
	ret nz

	call GetUserItem
	ld a, b
	cp HELD_FLINCH
	ret nz

	call CheckSubstituteOpp
	ret nz
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVarAddr
	ld d, h
	ld e, l
	call GetUserItem
	call BattleRandom
	cp c
	ret nc
	call EndRechargeOpp
	ld a, BATTLE_VARS_SUBSTATUS3_OPP
	call GetBattleVarAddr
	set SUBSTATUS_FLINCHED, [hl]
	ret

BattleCommand_CheckCharge:
	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVarAddr
	bit SUBSTATUS_CHARGED, [hl]
	ret z
	res SUBSTATUS_CHARGED, [hl]
	res SUBSTATUS_UNDERGROUND, [hl]
	res SUBSTATUS_FLYING, [hl]
	ld b, charge_command
	jmp SkipToBattleCommand

BattleCommand_Charge:
	call BattleCommand_ClearText
	ld a, BATTLE_VARS_STATUS
	call GetBattleVar
	and SLP_MASK
	jr z, .awake

	call BattleCommand_MoveDelay
	call BattleCommand_RaiseSub
	call PrintButItFailed
	jmp EndMoveEffect

.awake
	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVarAddr
	set SUBSTATUS_CHARGED, [hl]

	call BattleCommand_LowerSub
	xor a
	ld [wNumHits], a
	inc a
	ld [wBattleAnimParam], a
	call LoadMoveAnim
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	cp FLY
	jr z, .flying
	cp DIG
	jr z, .flying
	call BattleCommand_RaiseSub
	jr .not_flying

.flying
	call DisappearUser
.not_flying
	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVarAddr
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	ld b, a
	cp FLY
	jr z, .set_flying
	cp DIG
	jr nz, .dont_set_digging
	set SUBSTATUS_UNDERGROUND, [hl]
	jr .dont_set_digging

.set_flying
	set SUBSTATUS_FLYING, [hl]

.dont_set_digging
	call CheckUserIsCharging
	jr nz, .mimic
	ld a, BATTLE_VARS_LAST_COUNTER_MOVE
	call GetBattleVarAddr
	ld [hl], b
	ld a, BATTLE_VARS_LAST_MOVE
	call GetBattleVarAddr
	ld [hl], b

.mimic
	call ResetDamage

	ld hl, .UsedText
	call BattleTextbox

	;ld a, BATTLE_VARS_MOVE_EFFECT
	;call GetBattleVar
	;cp EFFECT_SKULL_BASH
	;ld b, endturn_command
	;jmp z, SkipToBattleCommand
	jmp EndMoveEffect

.UsedText:
	text_far Text_BattleUser ; "<USER>"
	text_asm
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	cp SOLARBEAM
	ld hl, .BattleTookSunlightText
	ret z

	cp FLY
	ld hl, .BattleFlewText
	ret z

	cp DIG
	ld hl, .BattleDugText
	ret

.BattleTookSunlightText:
	text_far _BattleTookSunlightText
	text_end

.BattleFlewText:
	text_far _BattleFlewText
	text_end

.BattleDugText:
	text_far _BattleDugText
	text_end

BattleCommand_TrapTarget:
	ld a, [wAttackMissed]
	and a
	ret nz
	ld hl, wEnemyWrapCount
	ld de, wEnemyTrappingMove
	ldh a, [hBattleTurn]
	and a
	jr z, .got_trap
	ld hl, wPlayerWrapCount
	ld de, wPlayerTrappingMove

.got_trap
	ld a, [hl]
	and a
	ret nz
	ld a, BATTLE_VARS_SUBSTATUS4_OPP
	call GetBattleVar
	bit SUBSTATUS_SUBSTITUTE, a
	ret nz
	call BattleRandom
	; trapped for 2-5 turns
	and %11
	inc a
	inc a
	inc a
	ld [hl], a
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	ld [de], a
	ld b, a
	ld hl, .Traps

.find_trap_text
	ld a, [hli]
	cp b
	jr z, .found_trap_text
	inc hl
	inc hl
	jr .find_trap_text

.found_trap_text
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jmp StdBattleTextbox

.Traps:
	dbw WRAP,      WrappedByText     ; 'was WRAPPED by'
	dbw FIRE_SPIN, FireSpinTrapText  ; 'was trapped!'
	dbw WHIRLPOOL, WhirlpoolTrapText ; 'was trapped!'
	dbw SAND_TOMB, SandTombTrapText  ; 'was trapped!'

BattleCommand_Recoil:
; recoil
	ld hl, wBattleMonMaxHP
	ldh a, [hBattleTurn]
	and a
	ld a, [wBattleMonSpecies]
	jr z, .got_hp
	ld hl, wEnemyMonMaxHP
	ld a, [wEnemyMonSpecies]
.got_hp
; ===========================
; === Ability: Rock Head ====
; ===========================
	push bc
	push de
	push hl
	ld hl, RockHeadPokemon
	call IsInByteArray
	pop hl
	pop de
	pop bc
	jr c, .rock_head
	jr .finish_rock_head

.rock_head
	ld hl, RockHeadText
	jmp StdBattleTextbox

.finish_rock_head
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	ld d, a
; get 1/3 damage or 1 HP, whichever is higher
	ld a, [wCurDamage]
	ld b, a
	ld a, [wCurDamage + 1]
	ld c, a
	xor a
	inc b
.third_hp_loop
	dec b
	inc a
	dec bc
	dec bc
	dec bc
	inc b
	jr nz, .third_hp_loop
	dec a
	ld c, a
	jr nz, .min_damage
	inc c
	jr .min_damage

.min_damage
	ld a, [hli]
	ld [wHPBuffer1 + 1], a
	ld a, [hl]
	ld [wHPBuffer1], a
	dec hl
	dec hl
	ld a, [hl]
	ld [wHPBuffer2], a
	sub c
	ld [hld], a
	ld [wHPBuffer3], a
	ld a, [hl]
	ld [wHPBuffer2 + 1], a
	sbc b
	ld [hl], a
	ld [wHPBuffer3 + 1], a
	jr nc, .dont_ko
	xor a
	ld [hli], a
	ld [hl], a
	ld hl, wHPBuffer3
	ld [hli], a
	ld [hl], a
.dont_ko
	hlcoord 10, 9
	ldh a, [hBattleTurn]
	and a
	ld a, 1
	jr z, .animate_hp_bar
	hlcoord 2, 2
	xor a
.animate_hp_bar
	ld [wWhichHPBar], a
	predef AnimateHPBar
	call RefreshBattleHuds

	; skip recoil text if quick battles are on
	call CheckIfFastBattlesIsOn
	ret nz

	ld hl, RecoilText
	jmp StdBattleTextbox

INCLUDE "data/abilities/rock_head_mons.asm"

BattleCommand_ConfuseTarget:
; ===========================================
; === Ability: Serenity - Confuse Target ===
; ===========================================
	call GetOpposingMon
	ld hl, SerenityPokemon
	call IsInByteArray
	ret c

	ld a, [wEffectFailed]
	and a
	ret nz
	call SafeCheckSafeguard
	ret nz
	call CheckSubstituteOpp
	ret nz
	ld a, BATTLE_VARS_SUBSTATUS3_OPP
	call GetBattleVarAddr
	bit SUBSTATUS_CONFUSED, [hl]
	ret nz
	jr BattleCommand_FinishConfusingTarget

BattleCommand_Confuse:
; ===================================
; === Ability: Serenity - Confuse ===
; ===================================
	call GetOpposingMon
	ld hl, SerenityPokemon
	call IsInByteArray
	jmp c, Serenity
	; fallthrough

	ld a, BATTLE_VARS_SUBSTATUS3_OPP
	call GetBattleVarAddr
	bit SUBSTATUS_CONFUSED, [hl]
	jr z, .not_already_confused
	call AnimateFailedMove
	ld hl, AlreadyConfusedText
	jmp StdBattleTextbox

.not_already_confused
	call CheckSubstituteOpp
	jr nz, BattleCommand_Confuse_CheckSnore_Swagger_ConfuseHit
	ld a, [wAttackMissed]
	and a
	jr nz, BattleCommand_Confuse_CheckSnore_Swagger_ConfuseHit
BattleCommand_FinishConfusingTarget:

; =======================================================
; === Ability: Serenity - Prevents added on Confusion ===
; =======================================================
	call GetOpposingMon
	ld hl, SerenityPokemon
	call IsInByteArray
	jmp c, Serenity

	ld bc, wEnemyConfuseCount
	ldh a, [hBattleTurn]
	and a
	jr z, .got_confuse_count
	ld bc, wPlayerConfuseCount

.got_confuse_count
	set SUBSTATUS_CONFUSED, [hl]
	; confused for 2-5 turns
	call BattleRandom
	and %11
	inc a
	inc a
	ld [bc], a

	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_CONFUSE_HIT
	jr z, .got_effect
	cp EFFECT_SNORE
	jr z, .got_effect
	cp EFFECT_SWAGGER
	jr z, .got_effect
    cp EFFECT_HURRICANE
    jr z, .got_effect
	call AnimateCurrentMove

.got_effect
	ld de, ANIM_CONFUSED
	call PlayOpponentBattleAnim

	ld hl, BecameConfusedText
	call StdBattleTextbox

	call GetOpponentItem
	ld a, b
	cp HELD_HEAL_STATUS
	jr z, .heal_confusion
	cp HELD_HEAL_CONFUSION
	ret nz
.heal_confusion
	ld hl, UseConfusionHealingItem
	jmp CallBattleCore

BattleCommand_Confuse_CheckSnore_Swagger_ConfuseHit:
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_CONFUSE_HIT
	ret z
	cp EFFECT_SNORE
	ret z
	cp EFFECT_SWAGGER
	ret z
	jmp PrintDidntAffect2

BattleCommand_Paralyze:
	call CheckForStatusIfAlreadyHasAny
	jr nz, .paralyzed
	ld a, [wTypeModifier]
	and EFFECTIVENESS_MASK
	jr z, .didnt_affect

; =====================================
; === Ability: Serenity - Paralyze ===
; =====================================
	call GetOpposingMon
	ld hl, SerenityPokemon
	call IsInByteArray
	jmp c, Serenity
	; fallthrough

	ld a, [wAttackMissed]
	and a
	jr nz, .failed
	call CheckSubstituteOpp
	jr nz, .failed
	ld c, 30
	call DelayFrames
	call AnimateCurrentMove
	ld a, $1
	ldh [hBGMapMode], a
	ld a, BATTLE_VARS_STATUS_OPP
	call GetBattleVarAddr
	set PAR, [hl]
	call UpdateOpponentInParty
	ld hl, ApplyPrzEffectOnSpeed
	call CallBattleCore
	call UpdateBattleHuds
	call PrintParalyze
	ld hl, UseHeldStatusHealingItem
	jmp CallBattleCore

.paralyzed
	push hl
	call AnimateFailedMove
	pop hl
	jmp StdBattleTextbox

.failed
	jmp PrintDidntAffect2

.didnt_affect
	call AnimateFailedMove
	jmp PrintDoesntAffect

BattleCommand_RechargeNextTurn:
; rechargenextturn

; ==========================
; === Ability: Overdrive ===
; ==========================
	call GetCurrentMon
	ld hl, OverdrivePokemon
	call IsInByteArray
	ret c

	ld a, BATTLE_VARS_SUBSTATUS4
	call GetBattleVarAddr
	set SUBSTATUS_RECHARGE, [hl]
	ret

INCLUDE "data/abilities/overdrive_mons.asm"

EndRechargeOpp:
	push hl
	ld a, BATTLE_VARS_SUBSTATUS4_OPP
	call GetBattleVarAddr
	res SUBSTATUS_RECHARGE, [hl]
	pop hl
	ret

BattleCommand_DoubleFlyingDamage:
	ld a, BATTLE_VARS_SUBSTATUS3_OPP
	call GetBattleVar
	bit SUBSTATUS_FLYING, a
	ret z
	jr DoubleDamage

BattleCommand_DoubleUndergroundDamage:
	ld a, BATTLE_VARS_SUBSTATUS3_OPP
	call GetBattleVar
	bit SUBSTATUS_UNDERGROUND, a
	ret z
	; fallthrough

DoubleDamage:
	ld hl, wCurDamage + 1
	sla [hl]
	dec hl
	rl [hl]
	ret nc

	ld a, $ff
	ld [hli], a
	ld [hl], a
	ret

BattleCommand_ResetStats:
	ld a, BASE_STAT_LEVEL
	ld hl, wPlayerStatLevels
	call .Fill
	ld hl, wEnemyStatLevels
	call .Fill

	ldh a, [hBattleTurn]
	push af

	call SetPlayerTurn
	call CalcPlayerStats
	call SetEnemyTurn
	call CalcEnemyStats

	pop af
	ldh [hBattleTurn], a

	call AnimateCurrentMove

	ld hl, EliminatedStatsText
	jmp StdBattleTextbox

.Fill:
	ld b, NUM_LEVEL_STATS
.next
	ld [hli], a
	dec b
	jr nz, .next
	ret

BattleCommand_Heal:
	ld de, wBattleMonHP
	ld hl, wBattleMonMaxHP
	ldh a, [hBattleTurn]
	and a
	jr z, .got_hp
	ld de, wEnemyMonHP
	ld hl, wEnemyMonMaxHP
.got_hp
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	ld b, a
	push hl
	push de
	push bc
	ld c, 2
	call CompareBytes
	pop bc
	pop de
	pop hl
	jr z, .hp_full
	ld a, b
	cp REST
	jr nz, .not_rest

; ================================================
; === Ability: Serenity Pokemon Can't use Rest ===
; ================================================
	call GetCurrentMon
	ld hl, SerenityPokemon
	call IsInByteArray
	jr c, .cant_use_rest

	push hl
	push de
	push af
	call BattleCommand_MoveDelay
	ld a, BATTLE_VARS_SUBSTATUS5
	call GetBattleVarAddr
	res SUBSTATUS_TOXIC, [hl]
	ld a, BATTLE_VARS_STATUS
	call GetBattleVarAddr
	ld a, [hl]
	and a
	ld [hl], REST_SLEEP_TURNS + 1
	ld hl, WentToSleepText
	jr z, .no_status_to_heal
	ld hl, RestedText
.no_status_to_heal
	call StdBattleTextbox
	ldh a, [hBattleTurn]
	and a
	jr nz, .calc_enemy_stats
	call CalcPlayerStats
	jr .got_stats

.calc_enemy_stats
	call CalcEnemyStats
.got_stats
	pop af
	pop de
	pop hl

.not_rest
	jr z, .restore_full_hp
	ld hl, GetHalfMaxHP
	call CallBattleCore
	jr .finish

.restore_full_hp
	ld hl, GetMaxHP
	call CallBattleCore
.finish
	call AnimateCurrentMove
	call BattleCommand_SwitchTurn
	ld hl, RestoreHP
	call CallBattleCore
	call BattleCommand_SwitchTurn
	call UpdateUserInParty
	call RefreshBattleHuds
	ld hl, RegainedHealthText
	jmp StdBattleTextbox

.hp_full
	call AnimateFailedMove
	ld hl, HPIsFullText
	jmp StdBattleTextbox

.cant_use_rest
	; add some delay so the text 
	; isn't instantly skipped
	ld c, 30
	call DelayFrames

	call AnimateFailedMove
	ld hl, SerenityPokemonCantRestText
	jmp StdBattleTextbox

BattleEffect_ButItFailed:
	call AnimateFailedMove
	jmp PrintButItFailed

ClearLastMove:
	ld a, BATTLE_VARS_LAST_COUNTER_MOVE
	call GetBattleVarAddr
	xor a
	ld [hl], a

	ld a, BATTLE_VARS_LAST_MOVE
	call GetBattleVarAddr
	xor a
	ld [hl], a
	ret

ResetActorDisable:
	ldh a, [hBattleTurn]
	and a
	jr z, .player

	xor a
	ld [wEnemyDisableCount], a
	ld [wEnemyDisabledMove], a
	ret

.player
	xor a
	ld [wPlayerDisableCount], a
	ld [wDisabledMove], a
	ret

BattleCommand_Screen:
	ld hl, wPlayerScreens
	ld bc, wPlayerLightScreenCount
	ldh a, [hBattleTurn]
	and a
	jr z, .got_screens_pointer
	ld hl, wEnemyScreens
	ld bc, wEnemyLightScreenCount

.got_screens_pointer
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_LIGHT_SCREEN
	jr nz, .Reflect

	bit SCREENS_LIGHT_SCREEN, [hl]
	jr nz, .failed
	set SCREENS_LIGHT_SCREEN, [hl]
	ld hl, LightScreenEffectText
	jr .good

.Reflect:
	bit SCREENS_REFLECT, [hl]
	jr nz, .failed
	set SCREENS_REFLECT, [hl]

	; LightScreenCount -> ReflectCount
	inc bc

	ld hl, ReflectEffectText

.good
; check for Light Clay
	push hl
	ld a, [hBattleTurn]
	and a
	ld hl, wBattleMonItem
	jr z, .got_item
	ld hl, wEnemyMonItem
.got_item
	ld a, [hl]
	cp LIGHT_CLAY
	ld a, 5
	jr nz, .no_clay
	inc a
	inc a
	inc a
.no_clay
	ld [bc], a
	pop hl
	call AnimateCurrentMove
	jmp StdBattleTextbox

.failed
	call AnimateFailedMove
	jr PrintButItFailed

PrintDoesntAffect:
	ld hl, DoesntAffectText
	jmp StdBattleTextbox

PrintNothingHappened:
	ld hl, NothingHappenedText
	jmp StdBattleTextbox

TryPrintButItFailed:
	ld a, [wAlreadyFailed]
	and a
	ret nz
	; fallthrough

PrintButItFailed:
	ld hl, ButItFailedText
	jmp StdBattleTextbox

FailMove:
	call AnimateFailedMove
	; fallthrough

FailMimic:
	ld hl, ButItFailedText ; 'but it failed!'
	ld de, ItFailedText    ; 'it failed!'
	jmp FailText_CheckOpponentProtect

PrintDidntAffect:
	ld hl, DidntAffect1Text
	jmp StdBattleTextbox

PrintDidntAffect2:
	call AnimateFailedMove
	ld hl, EvadedText ; 'evaded the attack'
	ld de, ProtectingItselfText ; 'protecting itself'
	jmp FailText_CheckOpponentProtect

PrintParalyze:
; 'paralyzed! maybe it can't attack!'
	ld hl, ParalyzedText
	jmp StdBattleTextbox

CheckSubstituteOpp:
	ld a, BATTLE_VARS_SUBSTATUS4_OPP
	call GetBattleVar
	bit SUBSTATUS_SUBSTITUTE, a
	ret

INCLUDE "engine/battle/move_effects/metronome.asm"

CheckUserMove:
; Return z if the user has move a.
	ld b, a
	ld de, wBattleMonMoves
	ldh a, [hBattleTurn]
	and a
	jr z, .ok
	ld de, wEnemyMonMoves
.ok

	ld c, NUM_MOVES
.loop
	ld a, [de]
	inc de
	cp b
	ret z

	dec c
	jr nz, .loop

	ld a, 1
	and a
	ret

ResetTurn:
	ld hl, wPlayerCharging
	ldh a, [hBattleTurn]
	and a
	jr z, .player
	ld hl, wEnemyCharging

.player
	ld [hl], 1
	call DoMove
	jmp EndMoveEffect

BattleCommand_ArenaTrap:
; Doesn't work on an absent opponent.

	call CheckHiddenOpponent
	jr nz, .failed

; Don't trap if the opponent is already trapped.

	ld a, BATTLE_VARS_SUBSTATUS5
	call GetBattleVarAddr
	bit SUBSTATUS_CANT_RUN, [hl]
	jr nz, .failed

; Otherwise trap the opponent.

	set SUBSTATUS_CANT_RUN, [hl]
	call AnimateCurrentMove
	ld hl, CantEscapeNowText
	jmp StdBattleTextbox

.failed
	call AnimateFailedMove
	jmp PrintButItFailed

BattleCommand_Defrost:
; Thaw the user.

	ld a, BATTLE_VARS_STATUS
	call GetBattleVarAddr
	bit FRZ, [hl]
	ret z
	res FRZ, [hl]

; Don't update the enemy's party struct in a wild battle.

	ldh a, [hBattleTurn]
	and a
	jr z, .party

	ld a, [wBattleMode]
	dec a
	jr z, .done

.party
	ld a, MON_STATUS
	call UserPartyAttr
	res FRZ, [hl]

.done
	call RefreshBattleHuds
	ld hl, WasDefrostedText
	jmp StdBattleTextbox

BattleCommand_FarCommand:
	farjp Find_Command

SafeCheckSafeguard:
	push hl
	ld hl, wEnemyScreens
	ldh a, [hBattleTurn]
	and a
	jr z, .got_turn
	ld hl, wPlayerScreens

.got_turn
	bit SCREENS_SAFEGUARD, [hl]
	pop hl
	ret

BattleCommand_CheckSafeguard:
	ld hl, wEnemyScreens
	ldh a, [hBattleTurn]
	and a
	jr z, .got_turn
	ld hl, wPlayerScreens
.got_turn
	bit SCREENS_SAFEGUARD, [hl]
	ret z
	ld a, 1
	ld [wAttackMissed], a
	call BattleCommand_MoveDelay
	ld hl, SafeguardProtectText
	call StdBattleTextbox
	jmp EndMoveEffect

BattleCommand_WeatherBasedHeal:
; Weather-sensitive heal.
	ld hl, wBattleMonMaxHP
	ld de, wBattleMonHP
	ldh a, [hBattleTurn]
	and a
	jr z, .start
	ld hl, wEnemyMonMaxHP
	ld de, wEnemyMonHP

.start
; Index for .Multipliers
; Default restores half max HP.
	ld c, 1

; Don't bother healing if HP is already full.
	inc c
	push bc
	call CompareBytes
	pop bc
	jr z, .Full
	dec c

	ld a, [wTimeOfDay]
	cp NITE_F
	jr z, .moonlight_anim
	ld a, [wTimeOfDay]
	cp EVE_F
	jr z, .moonlight_anim
	xor a ; Morning Sun anim
	jr .got_anim
.moonlight_anim
	ld a, $1
.got_anim
	ld [wBattleAnimParam], a
	call AnimateCurrentMove

.Weather:
	ld a, [wBattleWeather]
	and a
	jr z, .Heal

; x2 in sun
; /2 in rain/sandstorm
	inc c
	cp WEATHER_SUN
	jr z, .Heal
	dec c
	dec c

.Heal:
	ld b, 0
	ld hl, .Multipliers
	add hl, bc
	add hl, bc

	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, BANK(GetMaxHP)
	rst FarCall

	call BattleCommand_SwitchTurn

	callfar RestoreHP

	call BattleCommand_SwitchTurn
	call UpdateUserInParty

; 'regained health!'
	ld hl, RegainedHealthText
	jmp StdBattleTextbox

.Full:
	call AnimateFailedMove

; 'hp is full!'
	ld hl, HPIsFullText
	jmp StdBattleTextbox

.Multipliers:
	dw GetThirdMaxHP
	dw GetHalfMaxHP
	dw GetTwoThirdsMaxHP
	dw GetMaxHP

BattleCommand_DoubleMinimizeDamage:
	ld hl, wEnemyMinimized
	ldh a, [hBattleTurn]
	and a
	jr z, .ok
	ld hl, wPlayerMinimized
.ok
	ld a, [hl]
	and a
	ret z
	ld hl, wCurDamage + 1
	sla [hl]
	dec hl
	rl [hl]
	ret nc
	ld a, $ff
	ld [hli], a
	ld [hl], a
	ret

BattleCommand_SkipSunCharge:
; mimicsuncharge
	ld a, [wBattleWeather]
	cp WEATHER_SUN
	ret nz
	ld b, charge_command
	jmp SkipToBattleCommand

CheckHiddenOpponent:
	ld a, BATTLE_VARS_SUBSTATUS3_OPP
	call GetBattleVar
	and 1 << SUBSTATUS_FLYING | 1 << SUBSTATUS_UNDERGROUND
	ret

GetUserItem:
; Return the effect of the user's item in bc, and its id at hl.
	ld hl, wBattleMonItem
	ldh a, [hBattleTurn]
	and a
	jr z, .go
	ld hl, wEnemyMonItem
.go
	ld b, [hl]
	jr GetItemHeldEffect

GetOpponentItem:
; Return the effect of the opponent's item in bc, and its id at hl.
	ld hl, wEnemyMonItem
	ldh a, [hBattleTurn]
	and a
	jr z, .go
	ld hl, wBattleMonItem
.go
	ld b, [hl]
	; fallthrough

GetItemHeldEffect:
; Return the effect of item b in bc.
	ld a, b
	and a
	ret z

	push hl
	ld hl, ItemAttributes + ITEMATTR_EFFECT
	dec a
	ld c, a
	ld b, 0
	ld a, ITEMATTR_STRUCT_LENGTH
	call AddNTimes
	ld a, BANK(ItemAttributes)
	call GetFarWord
	ld b, l
	ld c, h
	pop hl
	ret

AnimateCurrentMoveEitherSide:
	push hl
	push de
	push bc
	ld a, [wBattleAnimParam]
	push af
	call BattleCommand_LowerSub
	pop af
	ld [wBattleAnimParam], a
	call PlayDamageAnim
	call BattleCommand_RaiseSub
	jmp PopBCDEHL

AnimateCurrentMove:
	push hl
	push de
	push bc
	ld a, [wBattleAnimParam]
	push af
	call BattleCommand_LowerSub
	pop af
	ld [wBattleAnimParam], a
	call LoadMoveAnim
	call BattleCommand_RaiseSub
	jmp PopBCDEHL

PlayDamageAnim:
	xor a
	ld [wFXAnimID + 1], a

	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	and a
	ret z

	ld [wFXAnimID], a

	ldh a, [hBattleTurn]
	and a
	ld a, BATTLEANIM_ENEMY_DAMAGE
	jr z, .player
	ld a, BATTLEANIM_PLAYER_DAMAGE

.player
	ld [wNumHits], a

	jr PlayUserBattleAnim

LoadMoveAnim:
	xor a
	ld [wNumHits], a
	ld [wFXAnimID + 1], a

	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	and a
	ret z
	; fallthrough

LoadAnim:
	ld [wFXAnimID], a
	; fallthrough

PlayUserBattleAnim:
	push hl
	push de
	push bc
	callfar PlayBattleAnim
	jmp PopBCDEHL

PlayOpponentBattleAnim:
	ld a, e
	ld [wFXAnimID], a
	ld a, d
	ld [wFXAnimID + 1], a
	xor a
	ld [wNumHits], a

	push hl
	push de
	push bc
	call BattleCommand_SwitchTurn

	callfar PlayBattleAnim

	call BattleCommand_SwitchTurn
	jmp PopBCDEHL

CallBattleCore:
	ld a, BANK("Battle Core")
	rst FarCall
	ret

AnimateFailedMove:
	call BattleCommand_LowerSub
	call BattleCommand_MoveDelay
	jmp BattleCommand_RaiseSub

BattleCommand_MoveDelay:
; Wait 10 frames.
	ld c, 10
	jmp DelayFrames

BattleCommand_ClearText:
; Used in multi-hit moves.
	ld hl, .text
	jmp BattleTextbox

.text:
	text_end

GetMoveAttr:
; Assuming hl = Moves + x, return attribute x of move a.
	push bc
	ld bc, MOVE_LENGTH
	call AddNTimes
	call GetMoveByte
	pop bc
	ret

GetMoveData:
; Copy move struct a to de.
	ld hl, Moves
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld a, BANK(Moves)
	jmp FarCopyBytes

GetMoveByte:
	ld a, BANK(Moves)
	jmp GetFarByte

DisappearUser:
	farjp _DisappearUser

AppearUserLowerSub:
	farjp _AppearUserLowerSub

AppearUserRaiseSub:
	farjp _AppearUserRaiseSub

_CheckBattleScene:
; Checks the options.  Returns carry if battle animations are disabled.
	push hl
	push de
	push bc
	farcall CheckBattleScene
	jmp PopBCDEHL

BattleCommand_CheckPowder:
; Checks if the move is powder/spore-based and 
; if the opponent is Grass-type
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	ld hl, PowderMoves
	call IsInByteArray
	ret nc

; If the opponent is Grass-type, the move fails.
	ld hl, wEnemyMonType1
	ldh a, [hBattleTurn]
	and a
	jr z, .CheckGrassType
	ld hl, wBattleMonType1

.CheckGrassType:
	ld a, [hli]
	cp GRASS
	jr z, .Immune
	ld a, [hl]
	cp GRASS
	ret nz
	;fallthrough
.Immune:
	ld a, 1
	ld [wAttackMissed], a
	ret

AssaultVestSpDefBoost:
    push bc
	call GetOpponentItem
	ld a, b
	cp HELD_ASSAULT_VEST
	pop bc
	ret nz
	jr SpDefBoost

SandstormSpDefBoost: 
; First, check if Sandstorm is active.
	ld a, [wBattleWeather]
	cp WEATHER_SANDSTORM
	ret nz

; Then, check the opponent's types.
	ld hl, wEnemyMonType1
	ldh a, [hBattleTurn]
	and a
	jr z, .ok
	ld hl, wBattleMonType1
.ok
	ld a, [hli]
	cp ROCK
	jr z, SpDefBoost
	ld a, [hl]
	cp ROCK
	ret nz
	; fallthrough

SpDefBoost:
	ld h, b
	ld l, c
	srl b
	rr c
	add hl, bc
	ld b, h
	ld c, l
	ret

HailDefenseBoost: 
; First, check if Hail is active.
	ld a, [wBattleWeather]
	cp WEATHER_HAIL
	ret nz

; Then, check the opponent's types.
	ld hl, wEnemyMonType1
	ldh a, [hBattleTurn]
	and a
	jr z, .ok
	ld hl, wBattleMonType1
.ok
	ld a, [hli]
	cp ICE
	jr z, SpDefBoost
	ld a, [hl]
	cp ICE
	ret nz
	jr SpDefBoost

Fifty_PercentBoost:
	ld a, 3
	ldh [hMultiplier], a
	call Multiply
	; fallthrough

HalfDamage:
	ld a, 2
	ldh [hDivisor], a
	ld b, 4
	jmp Divide

TenPercentBoost:
	ld a, 11
	ldh [hMultiplier], a
	call Multiply
	ld a, 10
	ldh [hDivisor], a
	ld b, 4
	jmp Divide

EffectCommands_50_50:
	call BattleRandom
	cp 50 percent + 1
	ret

INCLUDE "engine/battle/move_effects/curse.asm"
INCLUDE "engine/battle/move_effects/protect.asm"
INCLUDE "engine/battle/move_effects/bulk_up.asm"
INCLUDE "engine/battle/move_effects/calmmind.asm"
INCLUDE "engine/battle/move_effects/dragondance.asm"
INCLUDE "engine/battle/move_effects/close_combat.asm"
INCLUDE "engine/battle/move_effects/hex.asm"
INCLUDE "engine/battle/move_effects/venoshock.asm"
INCLUDE "engine/battle/move_effects/fury_drive.asm"
INCLUDE "engine/battle/move_effects/quiver_dance.asm"
INCLUDE "engine/battle/move_effects/stealth_rock.asm"
INCLUDE "engine/battle/move_effects/defog.asm"
INCLUDE "engine/battle/move_effects/endure.asm"
INCLUDE "engine/battle/move_effects/spikes.asm"
INCLUDE "engine/battle/move_effects/perish_song.asm"
INCLUDE "engine/battle/move_effects/rollout.asm"
INCLUDE "engine/battle/move_effects/attract.asm"
INCLUDE "engine/battle/move_effects/return.asm"
INCLUDE "engine/battle/move_effects/safeguard.asm"
INCLUDE "engine/battle/move_effects/acrobatics.asm"
INCLUDE "engine/battle/move_effects/baton_pass.asm"
INCLUDE "engine/battle/move_effects/pursuit.asm"
INCLUDE "engine/battle/move_effects/rapid_spin.asm"
INCLUDE "engine/battle/move_effects/hidden_power.asm"
INCLUDE "engine/battle/move_effects/belly_drum.asm"
INCLUDE "engine/battle/move_effects/mirror_coat.asm"
INCLUDE "data/moves/flail_reversal_power.asm"
INCLUDE "engine/battle/move_effects/sticky_web.asm"
INCLUDE "engine/battle/move_effects/hurricane.asm"
INCLUDE "engine/battle/move_effects/facade.asm"
INCLUDE "engine/battle/move_effects/counter.asm"
INCLUDE "engine/battle/move_effects/encore.asm"
INCLUDE "engine/battle/move_effects/snore.asm"
INCLUDE "engine/battle/move_effects/sketch.asm"
INCLUDE "engine/battle/move_effects/sleep_talk.asm"
INCLUDE "engine/battle/move_effects/destiny_bond.asm"
INCLUDE "engine/battle/move_effects/spite.asm"
INCLUDE "engine/battle/move_effects/heal_bell.asm"
INCLUDE "engine/battle/move_effects/transform.asm"
INCLUDE "engine/battle/move_effects/mimic.asm"
INCLUDE "engine/battle/move_effects/substitute.asm"
INCLUDE "engine/battle/move_effects/mist.asm"
INCLUDE "engine/battle/move_effects/focus_energy.asm"
INCLUDE "engine/battle/move_effects/teleport.asm"
