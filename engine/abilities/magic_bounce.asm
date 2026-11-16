; ==============================
; === Ability: Magic Bounce  ===
; ==============================
; A status move aimed at a Magic Bounce mon (status conditions, stat drops,
; confusion, Leech Seed, Taunt, Encore, Disable, Attract, Mean Look,
; Foresight, Roar / Whirlwind, entry hazards, Defog: MagicBounceEffects)
; doesn't affect it: its popup slides in, then the move hits the user
; instead, as if the Magic Bounce mon had used it (its accuracy, the user's
; type immunities, Substitute, Serenity and so on all apply to the user).
; A bounced move doesn't bounce back off a Magic Bounce user. Mold Breaker
; ignores it (its popup shows), Neutralizing Gas turns it off, and it
; doesn't bounce moves at a target that's in the air or underground (they
; miss anyway).
;
; Roar / Whirlwind bounced back drag the user out (it has acted this turn).
;
; How: BattleCommand_DoTurn (once the user has paid the move's PP) calls
; MagicBounceCheck. To bounce, the target's current move becomes this move
; and the turn switches to it, so the rest of the move's script runs as the
; target's move, aimed at the user. After the script, DoTurn calls
; MagicBounceEnd: the target gets its own move back and the turn switches
; back.

MagicBounceCheck::
; After doturn. Bounce the move if it's a status move aimed at a Magic
; Bounce mon. Use with farjp / farcall.
	ld a, [wEntryAbilitiesPending]
	bit MAGIC_BOUNCE_ACTIVE_F, a
	ret nz ; already bounced
	; doturn ended the move (out of PP)?
	ld hl, wBattleScriptBufferAddress
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [hl]
	cp endmove_command
	ret z
	call MagicBounceIsReflectable
	ret nc
	; the target must be standing, and not in the air or underground
	ldh a, [hBattleTurn]
	and a
	ld hl, wEnemyMonHP
	jr z, .got_hp
	ld hl, wBattleMonHP
.got_hp
	ld a, [hli]
	or [hl]
	ret z
	ld a, BATTLE_VARS_SUBSTATUS3_OPP
	call GetBattleVar
	and 1 << SUBSTATUS_FLYING | 1 << SUBSTATUS_UNDERGROUND
	ret nz
	call GetOpposingMon
	ld hl, MagicBouncePokemon
	call IsInAbilityListNG
	ret nc
	call MoldBreakerBypass
	ret c
	; it would be hit: the popup slides in over it...
	ld b, BANK(@)
	ld de, MagicBounceText
	call ShowDefensiveAbilityBanner
	ret c
	; ...and it uses the move on the user
	ld a, BATTLE_VARS_MOVE
	call GetBattleVar
	ld b, a
	ldh a, [hBattleTurn]
	and a
	ld hl, wCurEnemyMove
	jr z, .got_target_move
	ld hl, wCurPlayerMove
.got_target_move
	ld a, [hl]
	ld [wMagicBounceSavedMove], a
	ld [hl], b
	ld hl, wEntryAbilitiesPending
	set MAGIC_BOUNCE_ACTIVE_F, [hl]
	; the user is acting now, so for the bounced move it has already moved
	; (Roar and Whirlwind only drag out a target that has)
	res MAGIC_BOUNCE_GOES_FIRST_F, [hl]
	ld a, [wEnemyGoesFirst]
	and a
	jr z, .saved_order
	set MAGIC_BOUNCE_GOES_FIRST_F, [hl]
.saved_order
	ldh a, [hBattleTurn]
	ld [wEnemyGoesFirst], a ; (1 if the user is the enemy)
	farcall BattleCommand_SwitchTurn
	farjp UpdateMoveData

MagicBounceEnd::
; After a move's script (DoTurn): if it was bounced, the Magic Bounce mon
; gets its own move back and the turn goes back to the user.
; Use with farjp / farcall.
	ld hl, wEntryAbilitiesPending
	bit MAGIC_BOUNCE_ACTIVE_F, [hl]
	ret z
	res MAGIC_BOUNCE_ACTIVE_F, [hl]
	; the real turn order back
	xor a
	bit MAGIC_BOUNCE_GOES_FIRST_F, [hl]
	jr z, .got_order
	inc a
.got_order
	ld [wEnemyGoesFirst], a
	; (it's still the Magic Bounce mon's turn)
	ld a, BATTLE_VARS_MOVE
	call GetBattleVarAddr
	ld a, [wMagicBounceSavedMove]
	ld [hl], a
	; reload its move's data, if it has picked one
	and a
	jr z, .switch
	inc a
	jr z, .switch
	farcall UpdateMoveData
.switch
	farjp BattleCommand_SwitchTurn

MagicBounceIsReflectable:
; Carry if the user's move (hBattleTurn) is a status move Magic Bounce
; reflects.
	ld a, BATTLE_VARS_MOVE_POWER
	call GetBattleVar
	and a
	ret nz ; (no carry)
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	ld hl, MagicBounceEffects
	jmp IsInByteArray

AI_MagicBounceBlocksMove::
; Carry if the enemy's move (wEnemyMoveStruct) is a status move that would
; bounce off the player's Magic Bounce mon: the AI never uses one on it.
; Use with newfarcall; preserves bc, de and hl.
	push hl
	push de
	push bc
	ld a, [wEnemyMoveStruct + MOVE_POWER]
	and a
	jr nz, .no
	ld a, [wEnemyMoveStruct + MOVE_EFFECT]
	ld hl, MagicBounceEffects
	call IsInByteArray
	jr nc, .done
	ld a, [wBattleMonSpecies]
	ld hl, MagicBouncePokemon
	call IsInAbilityList
	jr .done
.no
	and a
.done
	jmp PopBCDEHL

MagicBounceEffects:
; status moves aimed at the target (power 0)
	db EFFECT_SLEEP
	db EFFECT_POISON
	db EFFECT_TOXIC
	db EFFECT_PARALYZE
	db EFFECT_BURN
	db EFFECT_CONFUSE
	db EFFECT_SWAGGER
	db EFFECT_ATTACK_DOWN
	db EFFECT_DEFENSE_DOWN
	db EFFECT_SPEED_DOWN
	db EFFECT_SP_ATK_DOWN
	db EFFECT_SP_DEF_DOWN
	db EFFECT_ACCURACY_DOWN
	db EFFECT_EVASION_DOWN
	db EFFECT_ATTACK_DOWN_2
	db EFFECT_DEFENSE_DOWN_2
	db EFFECT_SPEED_DOWN_2
	db EFFECT_SP_ATK_DOWN_2
	db EFFECT_SP_DEF_DOWN_2
	db EFFECT_ACCURACY_DOWN_2
	db EFFECT_EVASION_DOWN_2
	db EFFECT_LEECH_SEED
	db EFFECT_DISABLE
	db EFFECT_ENCORE
	db EFFECT_TAUNT
	db EFFECT_ATTRACT
	db EFFECT_MEAN_LOOK
	db EFFECT_FORESIGHT
	db EFFECT_FORCE_SWITCH
	db EFFECT_SPIKES
	db EFFECT_TOXIC_SPIKES
	db EFFECT_STEALTH_ROCK
	db EFFECT_STICKY_WEB
	db EFFECT_DEFOG
	db -1

MagicBounceText: db "Magic Bounce@"

INCLUDE "data/abilities/magic_bounce_mons.asm"
