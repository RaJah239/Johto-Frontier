; Effect command code moved out of the "Effect Commands" bank to make room.
; The BattleCommand_* entry points stay in effect_commands.asm (DoMove jumps to
; them in that bank) and farjp here; calls back into that bank use newfarcall /
; farjp, which pass a, bc, de, hl and flags through both ways.

; =============================
; === Ability: Priority ===
; =============================
PriorityAbilityPopup:
; Show the ability popup the first time each side uses one of the priority
; moves with its matching species this battle. Every move has its own pair
; of popup flags, reset by ResetSureHitEvents at the start of every battle.
; The priority boost itself comes from GetMovePriority in core.asm.
	ldh a, [hBattleTurn]
	and a
	jr nz, .foe

	; player
	ld a, [wCurPlayerMove]
	ld c, a
	ld a, [wBattleMonSpecies]
	jr .got_user

.foe
	ld a, [wCurEnemyMove]
	ld c, a
	ld a, [wEnemyMonSpecies]

.got_user
	; a = user's species, c = move being used
	ld b, a
	ld a, c
	cp IRON_HEAD
	jr nz, .not_iron_head
	ld a, b
	cp_species BLASTOISE
	ret nz
	call PriorityBattleText_Call
	ShowGenericAbilityPopup EVENT_IRON_HEAD_PLAYER, EVENT_IRON_HEAD_FOE, PreemptText
	ret

.not_iron_head
	cp CURSE
	jr nz, .not_curse
	ld a, b
	cp_species SNORLAX
	ret nz
	call PriorityBattleText_Call
	ShowGenericAbilityPopup EVENT_CURSE_PLAYER, EVENT_CURSE_FOE, PreemptText
	ret

.not_curse
	cp ZEN_HEADBUTT
	ret nz
	ld a, b
	cp_species DROWZEE
	jr z, .popup_zen
	cp_species HYPNO
	ret nz

.popup_zen
	call PriorityBattleText_Call
	ShowGenericAbilityPopup EVENT_ZEN_HEADBUTT_PLAYER, EVENT_ZEN_HEADBUTT_FOE, PreemptText
	ret

PriorityBattleText_Call:
	ld hl, PriorityBattleText
	jmp StdBattleTextbox

PreemptText: db "Preempt@"

_BattleCommand_Critical:
; Determine whether this attack's hit will be critical.
	xor a
	ld [wCriticalHit], a

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

	cp_species CHANSEY
	jr nz, .Tropius
	ld a, [hl]
	cp LUCKY_PUNCH
	jr nz, .FocusEnergy

; +2 critical level
	ld c, 2
	jmp .Tally

.Tropius:
	cp_species TROPIUS
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
; Slash Crits and Leaf Blade Crits only apply to a single move each, so
; check the animation first and only look the species up once it has
; picked a list. The lists' lookups wipe a, so keep the species on the stack
; for the lookups that follow.
	call GetCurrentMon
	push af
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	cp SLASH
	jr z, .SlashCrits
	cp LEAF_BLADE
	jr z, .LeafBladeCrits
	jr .SuperLuck

; =================================
; === Ability: Leaf Blade Crits ===
; =================================
.LeafBladeCrits:
	ld hl, LeafBladeCritsPokemon
	jr .AbilityMon

; ============================
; === Ability: Slash Crits ===
; ============================
.SlashCrits:
	ld hl, SlashCritsPokemon

.AbilityMon:
	pop af
	push af ; the species, for Super Luck
	push bc
	call IsSpeciesInList
	pop bc
	jr nc, .SuperLuck
	pop af
	jr .AbilityHit

; ===========================
; === Ability: Super Luck ===
; ===========================
.SuperLuck:
	pop af
	push bc
	ld hl, SuperLuckPokemon
	call IsSpeciesInList
	pop bc
	jmp nc, .continue

; super luck mons have an innate +2 critical hit level
	inc c
	inc c
	ShowGenericAbilityPopup EVENT_SUPER_LUCK_PLAYER, EVENT_SUPER_LUCK_FOE, SuperLuckText
	jr .continue

; The move always lands a critical hit, unless the target has Crit Guard.
.AbilityHit:
; ==========================
; === Ability: Crit Lock ===
; ==========================
	ShowGenericAbilityPopup EVENT_CRIT_LOCK_PLAYER, EVENT_CRIT_LOCK_FOE, CritlockText
	jr .CritGuard

.continue
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	ld hl, CriticalHitMoves
	push bc
	call IsInByteArray
	pop bc
	jr nc, .ScopeLens

; +2 critical level
	inc c
	inc c

.ScopeLens:
	push bc
	newfarcall GetUserItem
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

; ===========================
; === Ability: Crit Guard ===
; ===========================
.CritGuard:
	call GetOpposingMon
	ld hl, CritGuardPokemon
	call IsSpeciesInList
	jr nc, .crit_guard_checks_done

	showdefensiveability CritGuardText
	ret

.crit_guard_checks_done
CriticialHitLoaded:
	ld a, 1
	ld [wCriticalHit], a
	ret

SuperLuckText: db "Super Luck@"
CritlockText: db "Crit Lock@"
CritGuardText: db "Crit Guard@"

INCLUDE "data/moves/critical_hit_moves.asm"
INCLUDE "data/abilities/crit_guard_mons.asm"
INCLUDE "data/abilities/slash_crits_mons.asm"
INCLUDE "data/abilities/leaf_blade_crits_mons.asm"
INCLUDE "data/abilities/super_luck_mons.asm"

INCLUDE "data/battle/critical_hit_chances.asm"

_BattleCommand_CheckHit:
; ================================================================================
; === Defensive Abilities: Flame War, Grounded, Immunity, Levitate, Waterproof ===
; ================================================================================
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
	surefire_ability MEGAHORN, TrueHornPokemon, EVENT_TRUE_HORN_PLAYER, EVENT_TRUE_HORN_FOE, TrueHornText

; ===========================
; === Ability: Stormbound ===
; ===========================
	surefire_ability THUNDER, StormboundPokemon, EVENT_STORMBOUND_PLAYER, EVENT_STORMBOUND_FOE, StormboundText

; ===========================
; === Ability: True Flame ===
; ===========================
	surefire_ability FIRE_BLAST, TrueFlamePokemon, EVENT_TRUE_FLAME_PLAYER, EVENT_TRUE_FLAME_FOE, TrueFlameText

; ===========================
; === Ability: Frost Lock ===
; ===========================
	surefire_ability BLIZZARD, FrostLockPokemon, EVENT_FROST_LOCK_PLAYER, EVENT_FROST_LOCK_FOE, FrostLockText

; ==========================
; === Ability: Hydro Aim ===
; ==========================
	surefire_ability HYDRO_PUMP, HydroAimPokemon, EVENT_HYDRO_AIM_PLAYER, EVENT_HYDRO_AIM_FOE, HydroAimText

; ============================
; === Ability: Stonefall =====
; ============================
	surefire_ability ROCK_SLIDE, StonefallPokemon, EVENT_STONE_FALL_PLAYER, EVENT_STONE_FALL_FOE, Stone_FallText

; ============================
; === Ability: Stonebound =====
; ============================
	surefire_ability STONE_EDGE, StoneboundPokemon, EVENT_STONEBOUND_PLAYER, EVENT_STONEBOUND_FOE, StoneboundText

; ===========================
; === Ability: Dream Gaze ===
; ===========================
	surefire_ability HYPNOSIS, DreamGazePokemon, EVENT_DREAM_GAZE_PLAYER, EVENT_DREAM_GAZE_FOE, DreamGazeText

; ===========================
; === Ability: Dream Song ===
; ===========================
	surefire_ability SING, DreamSongPokemon, EVENT_DREAM_SONG_PLAYER, EVENT_DREAM_SONG_FOE, DreamSongText

; ===========================
; === Ability: Astral Aim ===
; ===========================
	surefire_ability METEOR_MASH, AstralAimPokemon, EVENT_ASTRAL_AIM_PLAYER, EVENT_ASTRAL_AIM_FOE, AstralAimText

	call .StatModifiers

	ld a, [wPlayerMoveStruct + MOVE_ACC]
	ld b, a
	ldh a, [hBattleTurn]
	and a
	jr z, .WideLens
	ld a, [wEnemyMoveStruct + MOVE_ACC]
	ld b, a

.WideLens:
	call .WideLensBoost

;.BrightPowder:
	push bc
	newfarcall GetOpponentItem
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
	farjp Eff_Comands_AttackedMissed

.WideLensBoost:
	push bc
	newfarcall GetUserItem
	pop bc
	ld a, [hl]
	cp ZOOM_LENS
	jr z, .zoom_lens
	cp WIDE_LENS
	ret nz
	jmp Add10PercentToB

.zoom_lens
; Only works if user goes second
	newfarcall CheckOpponentWentFirst
	ret z
	jmp Add20PercentToB

.StatModifiers:
	; load the user's accuracy into b and the opponent's evasion into c.
	ld hl, wPlayerMoveStruct + MOVE_ACC
	ld a, [wPlayerAccLevel]
	ld b, a
	ld a, [wEnemyEvaLevel]
	ld c, a
	call .UnawareStages

	ld a, [wBattleWeather]
	cp WEATHER_HAIL
	jr nz, .finish_foe_snow_cloak
	ld a, [wEnemyMonSpecies]
	call SnowCloak

.finish_foe_snow_cloak
	ld a, [wEnemyMonSpecies] ; the target (it was the attacker's species)
	call FadeIn

	ldh a, [hBattleTurn]
	and a
	jr z, .got_acc_eva

	ld hl, wEnemyMoveStruct + MOVE_ACC
	ld a, [wEnemyAccLevel]
	ld b, a
	ld a, [wPlayerEvaLevel]
	ld c, a
	call .UnawareStages

	ld a, [wBattleWeather]
	cp WEATHER_HAIL
	jr nz, .finish_player_snow_cloak
	ld a, [wBattleMonSpecies]
	call SnowCloak

.finish_player_snow_cloak
	ld a, [wBattleMonSpecies] ; the target (it was the attacker's species)
	call FadeIn

.got_acc_eva
	ld a, c
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

; ==========================
; === Ability: Keen Eyes ===
; ==========================
	call GetCurrentMon
	ld hl, KeenEyesMons
	call IsSpeciesInList
	jr nc, .skip_keen_eyes

	ShowGenericAbilityPopup EVENT_KEEN_EYES_PLAYER, EVENT_KEEN_EYES_FOE, KeenEyesText
	ld a, 130
	call AccuracyCalc

.skip_keen_eyes
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

KeenEyesText: db "Keen Eyes@"

_BattleCommand_CheckHit.UnawareStages:
; b = the attacker's accuracy stage, c = the target's evasion stage.
; Unaware: an Unaware attacker ignores the target's evasion stage, and an
; Unaware target ignores the attacker's accuracy stage. Keeps hl.
	push hl
	farcall IsAttackerUnaware ; (keeps bc)
	jr nc, .attacker_not_unaware
	ld c, BASE_STAT_LEVEL
.attacker_not_unaware
	farcall IsTargetUnaware
	jr nc, .done
	ld b, BASE_STAT_LEVEL
.done
	pop hl
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
INCLUDE "data/abilities/hypnotic_aura_mons.asm"
INCLUDE "data/abilities/lullaby_mastery_mons.asm"
INCLUDE "data/abilities/meteor_lock_mons.asm"

IncrementC:
; For FadeIn / SnowCloak (their lists call z, IncrementC):
; it has to be in this bank
	inc c
	ret

INCLUDE "data/abilities/fade_in_mons.asm"
INCLUDE "data/abilities/snow_cloak_mons.asm"
INCLUDE "data/abilities/keen_eyes_mons.asm"

INCLUDE "data/battle/accuracy_multipliers.asm"

; Input: percentage in B.
; Output: B *= 1.1. A clobbered.
Add10PercentToB:
	ld a, b
	push bc
	ld c, 10
	call SimpleDivide ; Divide a by c. Return quotient b and remainder a.
	cp 5 ; We use the remainder to round the quotient.
	ld a, b ; Saves the quotient in A.
	pop bc
	jr c, .floor

	; ceil
	inc a

.floor
	add b
	ld b, a
	ret nc

	ld b, $ff ; Prevent overflow.
	ret

; Input: percentage in B.
; Output: B *= 1.2. A clobbered.
Add20PercentToB:
	ld a, b
	push bc
	ld c, 5
	call SimpleDivide ; Divide a by c. Return quotient b and remainder a.
	cp 3 ; round if remainder >= 3 (half of 5)
	ld a, b ; quotient
	pop bc
	jr c, .floor

	; ceil
	inc a

.floor
	add b
	ld b, a
	ret nc

	ld b, $ff ; Prevent overflow.
	ret
