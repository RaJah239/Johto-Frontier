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
; Side effects too: when a damaging move's side effect (poison, burn,
; frostbite, paralysis: Flamethrower, Thunderbolt, Ice Beam, Tri Attack...)
; would give the Magic Bounce mon a status, it doesn't get it, and the user
; gets it instead if it can (not a Fire-type for a burn, a Poison- or
; Steel-type for poison, an Ice-type or in the sun for frostbite, nor
; already statused, behind a Substitute, Safeguarded, Serenity, Leaf Guard
; in the sun). The popup only slides in when the user does get it. The
; move's damage is dealt as usual. (MagicBounceSecondary)
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

MagicBounceSecondary::
; A damaging move's side effect is about to give the target (hBattleTurn's
; foe) a status; hl = that BattleCommand_*Target (effect commands bank).
; Carry if it doesn't land (the caller returns). Use with newfarcall.
; A Magic Bounce target doesn't get it: the side effect runs again from the
; Magic Bounce mon at the user, so the user gets it if it can (that run does
; all the checks: no status yet, Substitute, types, Safeguard, Leaf
; Guard...), and only then does the popup slide in (just below).
	ld a, [wEntryAbilitiesPending]
	bit MAGIC_BOUNCE_ACTIVE_F, a
	jr nz, .landing_on_user
	push hl
	call GetOpposingMon
	ld hl, MagicBouncePokemon
	call IsInAbilityListNG
	pop hl
	ret nc ; no Magic Bounce: it lands
	call MoldBreakerBypass
	ccf
	ret nc ; Mold Breaker: it lands
	; the user must have no status (a Fire move would thaw it instead) and no
	; Serenity (that run would show Serenity's popup)
	ld a, BATTLE_VARS_STATUS
	call GetBattleVar
	and a
	jr nz, .blocked
	newfarcall UserHasSerenity ; engine/battle/effect_commands.asm
	jr c, .blocked
	push hl
	ld hl, wEntryAbilitiesPending
	set MAGIC_BOUNCE_ACTIVE_F, [hl]
	farcall BattleCommand_SwitchTurn
	pop hl
	ld a, BANK(BattleCommand_PoisonTarget) ; (all four are there)
	call FarCall_hl
	farcall BattleCommand_SwitchTurn
	ld hl, wEntryAbilitiesPending
	res MAGIC_BOUNCE_ACTIVE_F, [hl]
.blocked
	scf
	ret

.landing_on_user
	; (the run from the Magic Bounce mon: hBattleTurn is it) it's about to
	; give the user the status: the popup slides in over the Magic Bounce mon
	ld b, BANK(@)
	ld de, MagicBounceText
	ldh a, [hBattleTurn]
	ld c, a ; ABILITY_POPUP_PLAYER / ABILITY_POPUP_ENEMY
	farcall ShowAbilityPopup
	ld a, [wOptions4]
	bit ABILITY_BANNERS, a
	jr z, .shown
	ld c, 30
	call DelayFrames
.shown
	and a
	ret

AI_PlayerHasMagicBounce::
; Carry if the player's mon has Magic Bounce and the enemy's mon doesn't have
; Mold Breaker (a side effect would bounce back). Use with newfarcall;
; preserves bc, de and hl.
	push hl
	push de
	push bc
	ld a, [wBattleMonSpecies]
	ld hl, MagicBouncePokemon
	call IsInAbilityList
	jr nc, .done
	ld a, [wEnemyMonSpecies]
	ld hl, MoldBreakerPokemon
	call IsInAbilityList
	ccf
.done
	jmp PopBCDEHL

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
