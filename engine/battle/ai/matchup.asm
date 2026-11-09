; 1-on-1 matchup simulation for the enemy trainer AI.
;
; At the start of a turn the AI plays out "the mon that's out vs the player's
; mon". If it would lose, it plays out each other mon in its party (after
; entry hazards and the player's best hit on the way in) and switches to one
; that would win, taking the least damage. Forced replacements (KO, U-turn,
; Baton Pass) use the same ranking without the entry hit.
;
; Damage: the AI's moves at their lowest roll, the player's at their highest
; (no crits). Each side uses its strongest move every turn, or a priority move
; when that move KOs for sure. Order: higher priority first, then speed (ties:
; the player first).
;
; Also played out, for both sides:
; - healing moves (Recover etc. 1/2, Slack Off 1/3 with priority, Healing
;   Light by weather, Rest: full HP + sleep, cures status), used when the
;   mon can't KO this turn, the other side's best hit would KO it, and the
;   heal is bigger than that hit;
; - draining moves (the best move heals half the damage it deals);
; - sleep (turns from the status counter, as CheckEnemyTurn counts them);
; - after each side acts: poison / burn / frostbite 1/16, bad poison n/16,
;   Leech Seed 1/8 (to the other side), Curse 1/4; Magic Guard ignores them;
; - end of turn: sandstorm / hail 1/16 while the weather lasts, Leftovers 1/16.
;
; The enemy's mon also gets a second try with "boost once, then attack" when
; it has a boosting move (MSim_RunBest). The player is assumed to attack.
;
; A benched mon is simulated by loading it into the wEnemyMon battle struct
; (stats from its party data, stat stages reset, Sticky Web applied). The real
; struct, stats, stat stages and substatus are saved in WRAMX bank 5 and put
; back afterwards, together with the move structs and damage variables.

DEF MSIM_MAX_TURNS EQU 32

; wMSimFlags
DEF MSIM_E_BEST_PRIO_F  EQU 0 ; the enemy's strongest move has priority
DEF MSIM_P_BEST_PRIO_F  EQU 1 ; the player's strongest move has priority
DEF MSIM_E_FASTER_F     EQU 2 ; the enemy outspeeds the player
DEF MSIM_E_PRIO_THIS_F  EQU 3 ; (per turn) the enemy uses priority
DEF MSIM_P_PRIO_THIS_F  EQU 4 ; (per turn) the player uses priority
DEF MSIM_DMG_CONSTANT_F EQU 5 ; (per move) fixed damage: no damage roll
DEF MSIM_E_BEST_DRAIN_F EQU 6 ; the enemy's strongest move drains
DEF MSIM_P_BEST_DRAIN_F EQU 7 ; the player's strongest move drains

; wMSimFlags2
DEF MSIM_E_LEFTOVERS_F   EQU 0
DEF MSIM_P_LEFTOVERS_F   EQU 1
DEF MSIM_E_MAGIC_GUARD_F EQU 2
DEF MSIM_P_MAGIC_GUARD_F EQU 3
DEF MSIM_E_REST_F        EQU 4 ; its heal move is Rest
DEF MSIM_P_REST_F        EQU 5
DEF MSIM_E_HEAL_PRIO_F   EQU 6 ; its heal move has priority (Slack Off)
DEF MSIM_P_HEAL_PRIO_F   EQU 7

; wMSimFlags3
DEF MSIM_E_CURED_F       EQU 0 ; Rest cured its status
DEF MSIM_P_CURED_F       EQU 1
DEF MSIM_E_HEALS_F       EQU 2 ; (per turn) it heals instead of attacking
DEF MSIM_P_HEALS_F       EQU 3
DEF MSIM_MOVE_DRAINS_F   EQU 4 ; (per move) the move being scored drains

DEF MSIM_SIDE_ENEMY  EQU 0
DEF MSIM_SIDE_PLAYER EQU 1

; wMSimT1Kind (AI_SimMoveChoice's forced first-turn move)
DEF MSIM_T1_DAMAGE  EQU 1
DEF MSIM_T1_STATUS  EQU 2
DEF MSIM_T1_HEAL    EQU 3
DEF MSIM_T1_CAPTURE EQU 4 ; (MSim_EnemyMoveDamage stores into wMSimT1Dmg)
DEF MSIM_T1_PRIO_F  EQU 7

; wMSimInflict / wMSimT1Effect
DEF MSIM_INF_PSN_F  EQU 0
DEF MSIM_INF_TOX_F  EQU 1
DEF MSIM_INF_BRN_F  EQU 2
DEF MSIM_INF_SEED_F EQU 3
DEF MSIM_INF_SLP_F  EQU 4
DEF MSIM_INF_PAR_F  EQU 5


; wMSimMode
DEF MSIM_MODE_ENTRY_HIT_F EQU 0 ; candidates take the player's best hit as they come in

DEF MSIM_SAVED_STRUCT_LENGTH EQU 32 ; wEnemyMonSpecies .. wEnemyMonStructEnd
DEF MSIM_SAVED_LEVELS_LENGTH EQU 7  ; wEnemyAtkLevel .. wEnemyEvaLevel
DEF MSIM_SAVED_SUBSTATUS_LENGTH EQU 5

	assert wEnemyMonStructEnd - wEnemyMonSpecies == MSIM_SAVED_STRUCT_LENGTH
	assert wEnemyEvaLevel - wEnemyAtkLevel + 1 == MSIM_SAVED_LEVELS_LENGTH
	assert wEnemySubStatus5 - wEnemySubStatus1 + 1 == MSIM_SAVED_SUBSTATUS_LENGTH
	assert wEnemySpDef - wEnemyStats + 2 == NUM_BATTLE_STATS * 2

AI_MatchupSwitch:
; Start-of-turn switch decision (trainer battles; the caller checked that the
; enemy isn't trapped). Return carry and wEnemySwitchMonIndex (1-6) to switch.
; - A mon it just switched in stays for a turn (no back-and-forth).
; - It stays if the mon that's out wins the 1-on-1.
; - It switches to the mon that wins taking the least damage when the
;   current one loses badly (the player keeps more than 1/4 of its HP) and
;   that mon wins comfortably (it keeps at least 1/4 of its own).
; - Otherwise it switches only to a mon that takes at least 1/4 of the
;   player's max HP more off it than staying would.
; - Even then, 10% of the time it stays (so it isn't fully predictable).
	ld hl, wMSimJustSwitched
	ld a, [hl]
	ld [hl], 0
	and a
	jr nz, .stay
	farcall FindAliveEnemyMons
	jr c, .stay ; nobody to switch to
	call MSim_Begin

	; the mon that's out
	call MSim_SetupActive
	call MSim_RunBest
	jr c, .stay_end ; it wins: stay in
	call MSim_PlayerDealtShare
	ld [wMSimActiveDealt], a
	call MSim_PlayerLeftShare
	ld [wMSimActiveLeft], a

	ld a, 1 << MSIM_MODE_ENTRY_HIT_F
	ld [wMSimMode], a
	call MSim_FindBest
	xor a
	ld [wMSimMode], a
	call MSim_End

	; a comfortable winner, and the current mon loses badly?
	ld a, [wMSimBestIndex]
	cp $ff
	jr z, .by_damage
	ld a, [wMSimBestTaken]
	cp 3 * 255 / 4 + 1
	jr nc, .by_damage
	ld a, [wMSimActiveLeft]
	cp 255 / 4 + 1
	jr c, .by_damage
	ld a, [wMSimBestIndex]
	jr .switch

.by_damage
	; a mon that does clearly more damage than staying
	ld a, [wMSimDealtIndex]
	cp $ff
	jr z, .stay
	ld a, [wMSimActiveDealt]
	add 255 / 4
	jr c, .stay
	ld b, a
	ld a, [wMSimBestDealt]
	cp b
	jr c, .stay
	ld a, [wMSimDealtIndex]

.switch
	push af
	call Random
	cp 10 percent
	pop bc
	jr c, .stay
	ld a, b
	inc a
	ld [wEnemySwitchMonIndex], a
	ld a, 1
	ld [wMSimJustSwitched], a
	scf
	ret

.stay_end
	call MSim_End
.stay
	and a
	ret

AI_MatchupPick:
; Switch-in choice for the switch-in picker: the mon that wins the 1-on-1
; taking the least damage, else the one that does the most damage, or $ff in
; b if none can do anything. wMSimMode says whether the candidates take an
; entry hit (cleared afterwards).
	call MSim_Begin
	call MSim_FindBest
	call MSim_End
	xor a
	ld [wMSimMode], a
	ld [wMSimJustSwitched], a
	ld a, [wMSimBestIndex]
	cp $ff
	jr nz, .got
	ld a, [wMSimDealtIndex]
.got
	ld b, a
	ret

MSim_FindBest:
; Simulate every other alive mon in the OT party. wMSimBestIndex = the
; winner that loses the smallest share of its max HP (wMSimBestTaken), or
; $ff; wMSimDealtIndex = the mon that takes the biggest share off the
; player's max HP (wMSimBestDealt), or $ff.
	ld a, $ff
	ld [wMSimBestIndex], a
	ld [wMSimBestTaken], a
	ld [wMSimDealtIndex], a
	xor a
	ld [wMSimBestDealt], a
	ld b, 0
.loop
	ld a, [wOTPartyCount]
	cp b
	ret z
	ld a, [wCurOTMon]
	cp b
	jr z, .next
	push bc
	call MSim_TryCandidate
	pop bc
	push af
	ld a, [wMSimLastDealt]
	ld hl, wMSimBestDealt
	cp [hl]
	jr c, .dealt_done
	jr z, .dealt_done
	ld [hl], a
	ld a, b
	ld [wMSimDealtIndex], a
.dealt_done
	pop af
	jr nc, .next
	; a = share of max HP lost (0-254): keep the smallest
	ld hl, wMSimBestTaken
	cp [hl]
	jr nc, .next
	ld [hl], a
	ld a, b
	ld [wMSimBestIndex], a
.next
	inc b
	jr .loop

MSim_TryCandidate:
; b = OT party index. Return carry if it wins the 1-on-1, with a = the share
; of its max HP it loses doing so (0-254). wMSimLastDealt = the share of the
; player's max HP it takes off either way.
	xor a
	ld [wMSimLastDealt], a
	push bc
	ld hl, wOTPartyMon1HP
	ld a, b
	call GetPartyLocation
	pop bc
	ld a, [hli]
	or [hl]
	ret z ; fainted (carry clear)

	call MSim_LoadCandidate

	; hazards on the way in
	call MSim_HazardDamage
	call MSim_SubtractEnemyHP
	jr c, .loses

	call MSim_ComputeDamages
	ld a, [wBattleMonHP]
	ld [wMSimPlayerHP], a
	ld a, [wBattleMonHP + 1]
	ld [wMSimPlayerHP + 1], a

	; the player's best hit as it comes in
	ld a, [wMSimMode]
	bit MSIM_MODE_ENTRY_HIT_F, a
	jr z, .fight
	ld a, [wMSimPlayerDmg]
	ld b, a
	ld a, [wMSimPlayerDmg + 1]
	ld c, a
	call MSim_SubtractEnemyHP
	jr c, .loses

.fight
	call MSim_RunBest
	push af
	call MSim_PlayerDealtShare
	ld [wMSimLastDealt], a
	pop af
	ret nc

	; share of max HP lost = (max HP - HP left) * 255 / max HP
	ld a, [wEnemyMonMaxHP]
	ld d, a
	ld a, [wEnemyMonMaxHP + 1]
	ld e, a
	ld a, [wMSimEnemyHP + 1]
	ld c, a
	ld a, e
	sub c
	ld c, a
	ld a, [wMSimEnemyHP]
	ld b, a
	ld a, d
	sbc b
	ld b, a
	call MSim_ShareOf
	cp 255
	jr nz, .got_share
	dec a
.got_share
	scf
	ret

.loses
	and a
	ret

MSim_PlayerDealtShare:
; a = the share of the player's max HP the last run took off (0-255).
	ld a, [wMSimPlayerHP + 1]
	ld c, a
	ld a, [wBattleMonHP + 1]
	sub c
	ld c, a
	ld a, [wMSimPlayerHP]
	ld b, a
	ld a, [wBattleMonHP]
	sbc b
	ld b, a
	jr MSim_PlayerShare

MSim_PlayerLeftShare:
; a = the share of its max HP the player's mon has left after the last run.
	ld a, [wMSimPlayerHP]
	ld b, a
	ld a, [wMSimPlayerHP + 1]
	ld c, a
	; fallthrough

MSim_PlayerShare:
	ld a, [wBattleMonMaxHP]
	ld d, a
	ld a, [wBattleMonMaxHP + 1]
	ld e, a
	; fallthrough

MSim_ShareOf:
; a = bc * 255 / de (bc <= de, de > 0), at most 255.
.scale
	ld a, d
	and a
	jr z, .scaled
	srl d
	rr e
	srl b
	rr c
	jr .scale
.scaled
	ld a, e
	and a
	jr nz, .ok
	inc e
.ok
	xor a
	ldh [hMultiplicand + 0], a
	ld a, b
	ldh [hMultiplicand + 1], a
	ld a, c
	ldh [hMultiplicand + 2], a
	ld a, 255
	ldh [hMultiplier], a
	push de
	call Multiply
	pop de
	ld a, e
	ldh [hDivisor], a
	ld b, 4
	call Divide
	ldh a, [hQuotient + 2]
	and a
	ld a, 255
	ret nz
	ldh a, [hQuotient + 3]
	ret

MSim_SubtractEnemyHP:
; wMSimEnemyHP -= bc; carry (and 0) if that leaves nothing.
	ld hl, wMSimEnemyHP
	jr MSim_SubtractHP

MSim_SubtractPlayerHP:
; wMSimPlayerHP -= bc; carry (and 0) if that leaves nothing.
	ld hl, wMSimPlayerHP
	; fallthrough

MSim_SubtractHP:
; [hl] (big-endian) -= bc; carry (and 0) if that leaves nothing.
	inc hl
	ld a, [hl]
	sub c
	ld [hld], a
	ld a, [hl]
	sbc b
	ld [hli], a
	jr c, .zero
	or [hl]
	jr z, .zero
	and a
	ret
.zero
	xor a
	ld [hld], a
	ld [hl], a
	scf
	ret

MSim_SetupActive:
; Simulate the mon that's out, as it is now.
	call MSim_SetActiveHP
	jmp MSim_ComputeDamages

MSim_SetActiveHP:
	ld a, [wEnemyMonHP]
	ld [wMSimEnemyHP], a
	ld a, [wEnemyMonHP + 1]
	ld [wMSimEnemyHP + 1], a
	ld a, [wBattleMonHP]
	ld [wMSimPlayerHP], a
	ld a, [wBattleMonHP + 1]
	ld [wMSimPlayerHP + 1], a
	ret

MSim_LoadCandidate:
; b = OT party index. Load that mon into the wEnemyMon battle struct (and
; wEnemyStats) as it would be right after switching in, and set
; wMSimEnemyHP to its HP.
	ld a, b
	ld hl, wOTPartyMon1Species
	call GetPartyLocation
	push hl
	ld de, wEnemyMonSpecies
	ld bc, MON_MOVES + NUM_MOVES ; species, item, moves
	call CopyBytes
	pop hl
	push hl
	ld bc, MON_DVS
	add hl, bc
	ld de, wEnemyMonDVs
	ld bc, 2 + NUM_MOVES + 1 ; DVs, PP, happiness
	call CopyBytes
	pop hl
	push hl
	ld bc, MON_LEVEL
	add hl, bc
	ld a, [hl]
	ld [wEnemyMonLevel], a
	pop hl
	push hl
	ld bc, MON_STATUS
	add hl, bc
	ld de, wEnemyMonStatus
	ld bc, 2 + 2 + 2 + NUM_BATTLE_STATS * 2 ; status, HP, max HP, stats
	call CopyBytes
	pop hl
	ld bc, MON_ATK
	add hl, bc
	ld de, wEnemyStats
	ld bc, NUM_BATTLE_STATS * 2
	call CopyBytes

	; types
	ld a, [wEnemyMonSpecies]
	dec a
	ld hl, BaseData + BASE_TYPES
	ld bc, BASE_DATA_SIZE
	call AddNTimes
	ld a, BANK(BaseData)
	call GetFarWord
	ld a, l
	ld [wEnemyMonType1], a
	ld a, h
	ld [wEnemyMonType2], a

	; switching in resets stat stages and substatus
	ld hl, wEnemyStatLevels
	ld a, BASE_STAT_LEVEL
	ld bc, MSIM_SAVED_LEVELS_LENGTH
	call ByteFill
	ld hl, wEnemySubStatus1
	xor a
	ld bc, MSIM_SAVED_SUBSTATUS_LENGTH
	call ByteFill

	; Sticky Web: -1 Speed (as for Spikes: not if it's immune to hazards)
	ld a, [wEnemyScreens]
	bit SCREENS_STICKY_WEB, a
	jr z, .stats
	call MSim_HazardImmune
	jr c, .stats
	call MSim_Grounded
	jr nc, .stats
	ld a, BASE_STAT_LEVEL - 1
	ld [wEnemySpdLevel], a
.stats
	ld a, 1
	ldh [hBattleTurn], a
	callfar CalcEnemyStats

	ld a, [wEnemyMonHP]
	ld [wMSimEnemyHP], a
	ld a, [wEnemyMonHP + 1]
	ld [wMSimEnemyHP + 1], a
	ret

MSim_HazardImmune:
; Carry if the loaded mon ignores entry hazards: Hazard Guard, Spin Guard
; (it clears them as it comes in) or Heavy Boots.
	ld a, [wEnemyMonSpecies]
	ld hl, HazardGuardMons
	ld d, BANK(HazardGuardMons)
	call MSim_IsInFarList
	ret c
	ld a, [wEnemyMonSpecies]
	ld hl, SpinGuardPokemon
	ld d, BANK(SpinGuardPokemon)
	call MSim_IsInFarList
	ret c
	ld a, [wEnemyMonItem]
	ld b, a
	callfar GetItemHeldEffect
	ld a, b
	cp HELD_HEAVY_BOOTS
	jr z, .yes
	and a
	ret
.yes
	scf
	ret

MSim_Grounded:
; Carry if the loaded mon touches the ground: not Flying-type, no Levitate.
	ld a, [wEnemyMonType1]
	cp FLYING
	jr z, .no
	ld a, [wEnemyMonType2]
	cp FLYING
	jr z, .no
	ld a, [wEnemyMonSpecies]
	ld hl, LevitatePokemon
	call IsInByteArray
	ccf
	ret
.no
	and a
	ret

MSim_HazardDamage:
; Return bc = the damage the loaded mon takes from Spikes and Stealth Rock as
; it switches in, by SpikesDamage's rules.
	ld bc, 0
	ld a, [wEnemyScreens]
	and (1 << SCREENS_SPIKES) | (1 << SCREENS_STEALTH_ROCK)
	ret z
	call MSim_HazardImmune
	ld bc, 0
	ret c

	; Spikes: 1/8; not Flying types or SpikesImmunePokemon
	ld a, [wEnemyScreens]
	bit SCREENS_SPIKES, a
	jr z, .stealth_rock
	ld a, [wEnemyMonType1]
	cp FLYING
	jr z, .stealth_rock
	ld a, [wEnemyMonType2]
	cp FLYING
	jr z, .stealth_rock
	ld a, [wEnemyMonSpecies]
	ld hl, SpikesImmunePokemon
	ld d, BANK(SpikesImmunePokemon)
	call MSim_IsInFarList
	jr c, .stealth_rock
	ld a, 3
	call MSim_MaxHPShare
	ld b, d
	ld c, e

.stealth_rock
	ld a, [wEnemyScreens]
	bit SCREENS_STEALTH_ROCK, a
	ret z
	push bc
	ld a, [wEnemyMonSpecies]
	ld hl, MagicGuardPokemon
	call IsInByteArray
	pop bc
	ret c
	push bc
	call SetEnemyTurn
	callfar CheckStealthRockTypeMatchup ; (the enemy's types, by hBattleTurn)
	ld a, [wTypeMatchup]
	cp EFFECTIVE + 1
	ld a, 2 ; super effective: 1/4
	jr nc, .got_share
	ld a, [wTypeMatchup]
	cp EFFECTIVE - 1
	ld a, 3 ; neutral: 1/8
	jr nc, .got_share
	ld a, 4 ; resisted: 1/16
.got_share
	call MSim_MaxHPShare
	pop bc
	ld a, c
	add e
	ld c, a
	ld a, b
	adc d
	ld b, a
	ret

MSim_MaxHPShare:
; de = the loaded mon's max HP >> a (at least 1). Preserves bc.
	push bc
	ld b, a
	ld a, [wEnemyMonMaxHP]
	ld d, a
	ld a, [wEnemyMonMaxHP + 1]
	ld e, a
.loop
	srl d
	rr e
	dec b
	jr nz, .loop
	pop bc
	ld a, d
	or e
	ret nz
	inc e
	ret

MSim_IsInFarList:
; Carry if a is in the $ff-terminated list at d:hl. Preserves d.
	ld e, a
.loop
	ld a, d
	push de
	call GetFarByte
	pop de
	inc hl
	cp $ff
	jr z, .no
	cp e
	jr nz, .loop
	scf
	ret
.no
	and a
	ret

MSim_ComputeDamages:
; Fill wMSimEnemyDmg / wMSimEnemyPrioDmg (lowest roll) and wMSimPlayerDmg /
; wMSimPlayerPrioDmg (highest roll) for the loaded enemy mon vs the player's
; mon, the priority flags, and who is faster.
	xor a
	ld [wCriticalHit], a
	ld hl, wMSimEnemyDmg
	ld bc, 8
	call ByteFill
	ld hl, wMSimFlags
	res MSIM_E_BEST_PRIO_F, [hl]
	res MSIM_P_BEST_PRIO_F, [hl]
	res MSIM_E_FASTER_F, [hl]

	; enemy moves
	ld de, wEnemyMonMoves
	ld hl, wEnemyMonPP
	ld b, NUM_MOVES
	ld a, [wEnemySubStatus5]
	bit SUBSTATUS_ENCORED, a
	jr z, .enemy_loop
	; locked into one move (choice item or Encore)
	ld a, [wCurEnemyMoveNum]
	ld c, a
	ld a, e
	add c
	ld e, a
	adc d
	sub e
	ld d, a
	ld a, l
	add c
	ld l, a
	adc h
	sub l
	ld h, a
	ld b, 1
.enemy_loop
	ld a, [de]
	and a
	jr z, .player
	push bc
	push de
	push hl
	ld b, a
	ld a, [hl]
	and PP_MASK
	call nz, MSim_EnemyMoveDamage
	pop hl
	pop de
	pop bc
	inc de
	inc hl
	dec b
	jr nz, .enemy_loop

.player
	ld de, wBattleMonMoves
	ld hl, wBattleMonPP
	ld b, NUM_MOVES
	ld a, [wPlayerSubStatus5]
	bit SUBSTATUS_ENCORED, a
	jr z, .player_loop
	ld a, [wCurMoveNum]
	ld c, a
	ld a, e
	add c
	ld e, a
	adc d
	sub e
	ld d, a
	ld a, l
	add c
	ld l, a
	adc h
	sub l
	ld h, a
	ld b, 1
.player_loop
	ld a, [de]
	and a
	jr z, .speed
	push bc
	push de
	push hl
	ld b, a
	ld a, [hl]
	and PP_MASK
	call nz, MSim_PlayerMoveDamage
	pop hl
	pop de
	pop bc
	inc de
	inc hl
	dec b
	jr nz, .player_loop

.speed
	farcall DoesAIOutSpeedPlayer
	jr nc, .setup
	ld hl, wMSimFlags
	set MSIM_E_FASTER_F, [hl]
.setup
	jmp MSim_SetupSides

MSim_EnemyMoveDamage:
; b = move. Work out its damage (lowest roll) and keep the best values.
	push bc
	ld a, b
	ld de, wEnemyMoveStruct
	call MSim_LoadMove
	pop bc
	ret z
	ld a, [wEnemyMoveStruct + MOVE_EFFECT]
	ld e, a
	ld a, [wBattleMonStatus]
	call MSim_CheckDrain
	ret z ; Dream Eater on an awake target
	push bc
	farcall AIDamageCalc ; (hBattleTurn = 1; handles fixed-damage moves)
	pop bc
	push bc
	ld a, [wEnemyMoveStruct + MOVE_TYPE]
	and TYPE_MASK
	ld b, a
	farcall AI_IsPlayerImmuneByAbility
	pop bc
	jr c, .none
	push bc
	ld a, [wEnemyMonSpecies]
	ld d, a
	ld a, [wBattleMonSpecies]
	ld e, a
	ld a, [wEnemyMoveStruct + MOVE_TYPE]
	call MSim_DefensiveAbilities
	ld a, [wMSimFlags]
	bit MSIM_DMG_CONSTANT_F, a
	call z, MSim_LowestRoll
	pop bc
	; priority? (carry if above normal)
	ld a, [wEnemyMonItem]
	ld c, a
	farcall GetMovePriority_Far
	ld a, BASE_PRIORITY
	cp b
	push af
	ld a, [wMSimT1Kind]
	cp MSIM_T1_CAPTURE
	jr z, .capture
	pop af
	ld hl, wMSimEnemyDmg
	ld c, MSIM_E_BEST_DRAIN_F
	ld b, MSIM_E_BEST_PRIO_F
	jmp MSim_KeepBest
.capture
	; (AI_SimMoveChoice) this move's damage and priority for the first turn
	pop af
	ld a, MSIM_T1_DAMAGE
	jr nc, .no_prio
	ld a, MSIM_T1_DAMAGE | 1 << MSIM_T1_PRIO_F
.no_prio
	ld [wMSimT1Kind], a
	ld a, [wCurDamage]
	ld [wMSimT1Dmg], a
	ld a, [wCurDamage + 1]
	ld [wMSimT1Dmg + 1], a
	ret
.none
	ret

MSim_PlayerMoveDamage:
; b = move. Work out its damage (highest roll) and keep the best values.
	push bc
	ld a, b
	ld de, wPlayerMoveStruct
	call MSim_LoadMove
	pop bc
	ret z
	ld a, [wPlayerMoveStruct + MOVE_EFFECT]
	ld e, a
	ld a, [wEnemyMonStatus]
	call MSim_CheckDrain
	ret z ; Dream Eater on an awake target
	push bc
	xor a
	ldh [hBattleTurn], a
	ld a, [wPlayerMoveStruct + MOVE_EFFECT]
	ld hl, ConstantDamageEffects
	call MSim_IsInFarList_Bank
	jr nc, .normal
	callfar BattleCommand_ConstantDamage
	jr .got
.normal
	callfar PlayerAttackDamage
	callfar BattleCommand_DamageCalc
	callfar BattleCommand_Stab
.got
	pop bc
	push bc
	ld a, [wPlayerMoveStruct + MOVE_TYPE]
	and TYPE_MASK
	ld b, a
	farcall AI_IsEnemyImmuneByAbility
	pop bc
	ret c
	push bc
	ld a, [wBattleMonSpecies]
	ld d, a
	ld a, [wEnemyMonSpecies]
	ld e, a
	ld a, [wPlayerMoveStruct + MOVE_TYPE]
	call MSim_DefensiveAbilities
	pop bc
	ld a, [wBattleMonItem]
	ld c, a
	farcall GetMovePriority_Far
	ld a, BASE_PRIORITY
	cp b
	ld hl, wMSimPlayerDmg
	ld c, MSIM_P_BEST_DRAIN_F
	ld b, MSIM_P_BEST_PRIO_F
	; fallthrough

MSim_KeepBest:
; wCurDamage is a move's damage; carry if it has priority. hl = the side's
; best damage (followed by its best priority damage); b = that side's
; "best move has priority" flag, c = its "best move drains" flag. Keep the
; biggest of each.
	push af
	ld a, c
	ld [wMSimSide], a
	ld a, [wCurDamage]
	ld d, a
	ld a, [wCurDamage + 1]
	ld e, a
	; best damage: bigger, or equal with priority
	ld a, [hli]
	ld c, [hl]
	dec hl
	cp d
	jr c, .new_best
	jr nz, .check_prio
	ld a, c
	cp e
	jr c, .new_best
	jr nz, .check_prio
	pop af
	push af
	jr nc, .check_prio
.new_best
	ld a, d
	ld [hli], a
	ld a, e
	ld [hld], a
	pop af
	push af
	push hl
	ld hl, wMSimFlags
	ld a, b
	call MSim_SetFlagCarry
	ld a, [wMSimFlags3]
	bit MSIM_MOVE_DRAINS_F, a
	scf
	jr nz, .drains
	ccf
.drains
	ld a, [wMSimSide]
	call MSim_SetFlagCarry
	pop hl
.check_prio
	pop af
	ret nc
	inc hl
	inc hl
	ld a, [hli]
	ld c, [hl]
	dec hl
	cp d
	jr c, .new_prio
	ret nz
	ld a, c
	cp e
	ret nc
.new_prio
	ld a, d
	ld [hli], a
	ld [hl], e
	ret

MSim_SetFlagCarry:
; Set bit a of [hl] if carry, else reset it.
	push af
	ld c, 1
	and a
	jr z, .got_mask
.shift
	sla c
	dec a
	jr nz, .shift
.got_mask
	pop af
	ld a, c
	jr nc, .reset
	or [hl]
	ld [hl], a
	ret
.reset
	cpl
	and [hl]
	ld [hl], a
	ret

MSim_IsInFarList_Bank:
; Carry if a is in the $ff-terminated list ConstantDamageEffects.
	ld d, BANK(ConstantDamageEffects)
	jmp MSim_IsInFarList

MSim_LoadMove:
; Copy move a into the move struct at de. Return z to skip it: no power,
; Explosion, or a two-turn (Solar Beam) move. Sets MSIM_DMG_CONSTANT_F for
; fixed-damage moves.
	push de
	push af
	ld hl, wMSimFlags
	res MSIM_DMG_CONSTANT_F, [hl]
	pop af
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
	push bc
	ld hl, ConstantDamageEffects
	call MSim_IsInFarList_Bank
	pop bc
	jr nc, .done
	ld hl, wMSimFlags
	set MSIM_DMG_CONSTANT_F, [hl]
.done
	or 1 ; nz
	ret

MSim_DefensiveAbilities:
; wCurDamage after the abilities BattleCommand_DamageVariation applies
; (EffectiveDefensiveAbilities, without its popups). d = attacker's species,
; e = defender's species, a = the move's type byte (category bits included).
	ld [wMSimMoveType], a
	; Tinted Lens: not very effective moves do double
	push de
	ld a, d
	ld hl, TintedLensPokemon
	ld d, BANK(TintedLensPokemon)
	call MSim_IsInFarList
	pop de
	jr nc, .solid_rock
	ld a, [wTypeModifier]
	and EFFECTIVENESS_MASK
	cp NOT_VERY_EFFECTIVE
	call z, MSim_DoubleDamage
.solid_rock
	; Solid Rock: super effective moves do half (4x: a quarter)
	push de
	ld a, e
	ld hl, SolidRockPokemon
	ld d, BANK(SolidRockPokemon)
	call MSim_IsInFarList
	pop de
	jr nc, .fur_coat
	ld a, [wTypeModifier]
	and EFFECTIVENESS_MASK
	cp EXTREMELY_EFFECTIVE
	jr nz, .not_4x
	call MSim_HalveDamage
	jr .half
.not_4x
	cp SUPER_EFFECTIVE
	jr nz, .fur_coat
.half
	call MSim_HalveDamage
.fur_coat
	; Fur Coat: physical moves do half
	ld a, e
	ld hl, FurCoatPokemon
	ld d, BANK(FurCoatPokemon)
	call MSim_IsInFarList
	ret nc
	ld a, [wMSimMoveType]
	cp SPECIAL
	ret nc
	; fallthrough

MSim_HalveDamage:
	ld hl, wCurDamage
	srl [hl]
	inc hl
	rr [hl]
	ret

MSim_DoubleDamage:
	ld hl, wCurDamage + 1
	sla [hl]
	dec hl
	rl [hl]
	ret nc
	ld a, $ff
	ld [hli], a
	ld [hl], a
	ret

MSim_LowestRoll:
; wCurDamage = its lowest damage roll (as BattleCommand_DamageVariation:
; * (85 percent + 1) / (100 percent), not below 1 or 0 damage).
	ld a, [wCurDamage]
	and a
	jr nz, .go
	ld a, [wCurDamage + 1]
	cp 2
	ret c
.go
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
	ld [wCurDamage], a
	ldh a, [hQuotient + 3]
	ld [wCurDamage + 1], a
	ret

DEF MSIM_ENEMY_WINS  EQU 1
DEF MSIM_PLAYER_WINS EQU 2

MSim_CheckDrain:
; e = move effect, a = the target's status. Set MSIM_MOVE_DRAINS_F if the
; move drains. Return z to skip it (Dream Eater on an awake target).
	ld d, a
	ld hl, wMSimFlags3
	res MSIM_MOVE_DRAINS_F, [hl]
	ld a, e
	cp EFFECT_LEECH_HIT
	jr z, .drains
	cp EFFECT_SACRED_FIRE
	jr z, .drains
	cp EFFECT_DREAM_EATER
	jr nz, .ok
	ld a, d
	and SLP_MASK
	ret z
.drains
	set MSIM_MOVE_DRAINS_F, [hl]
.ok
	or 1 ; nz
	ret

MSim_SetupSides:
; Per-side setup for MSim_Run: Leftovers, Magic Guard, sleep and bad-poison
; counters, weather turns, heal moves.
	xor a
	ld [wMSimFlags2], a
	ld [wMSimFlags3], a
	ld a, [wEnemyMonItem]
	ld b, a
	callfar GetItemHeldEffect
	ld a, b
	cp HELD_LEFTOVERS
	jr nz, .player_leftovers
	ld hl, wMSimFlags2
	set MSIM_E_LEFTOVERS_F, [hl]
.player_leftovers
	ld a, [wBattleMonItem]
	ld b, a
	callfar GetItemHeldEffect
	ld a, b
	cp HELD_LEFTOVERS
	jr nz, .magic_guard
	ld hl, wMSimFlags2
	set MSIM_P_LEFTOVERS_F, [hl]
.magic_guard
	ld a, [wEnemyMonSpecies]
	ld hl, MagicGuardPokemon
	call IsInByteArray
	jr nc, .player_magic_guard
	ld hl, wMSimFlags2
	set MSIM_E_MAGIC_GUARD_F, [hl]
.player_magic_guard
	ld a, [wBattleMonSpecies]
	ld hl, MagicGuardPokemon
	call IsInByteArray
	jr nc, .counters
	ld hl, wMSimFlags2
	set MSIM_P_MAGIC_GUARD_F, [hl]
.counters
	ld a, [wEnemyMonStatus]
	and SLP_MASK
	ld [wMSimEnemySleep], a
	ld a, [wBattleMonStatus]
	and SLP_MASK
	ld [wMSimPlayerSleep], a
	ld a, [wEnemyToxicCount]
	ld [wMSimEnemyToxic], a
	ld a, [wPlayerToxicCount]
	ld [wMSimPlayerToxic], a
	ld a, [wWeatherCount]
	ld [wMSimWeatherTurns], a
	ld a, MSIM_SIDE_ENEMY
	call MSim_FindHeal
	ld a, MSIM_SIDE_PLAYER
	; fallthrough

MSim_FindHeal:
; a = side. Store its usable heal move's HP gain in wMSim*Heal (0 if none)
; and its Rest / priority flags.
	ld [wMSimSide], a
	and a
	ld hl, wEnemyMonMoves
	ld de, wEnemyMonPP
	jr z, .got_moves
	ld hl, wBattleMonMoves
	ld de, wBattleMonPP
.got_moves
	ld b, NUM_MOVES
.loop
	ld a, [hli]
	and a
	jr z, .none
	ld c, a
	ld a, [de]
	inc de
	and PP_MASK
	jr z, .next
	push hl
	push de
	push bc
	ld a, c
	dec a
	ld hl, Moves + MOVE_EFFECT
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld a, BANK(Moves)
	call GetFarByte
	pop bc
	pop de
	pop hl
	cp EFFECT_HEAL
	jr z, .heal
	cp EFFECT_SLACK_OFF
	jr z, .slack_off
	cp EFFECT_WEATHER_HEAL
	jr z, .weather_heal
.next
	dec b
	jr nz, .loop
.none
	ld de, 0
	jr .store

.heal
	ld a, c
	cp REST
	ld a, 1 ; 1/2
	jr nz, .share
	ld a, MSIM_E_REST_F
	call .set_flag
	xor a ; full
	jr .share

.slack_off
	ld a, MSIM_E_HEAL_PRIO_F
	call .set_flag
	call .max_hp
	call MSim_DivDEBy3
	jr .store

.weather_heal
	ld a, [wBattleWeather]
	and a ; WEATHER_NONE
	ld a, 1 ; 1/2
	jr z, .share
	ld a, [wBattleWeather]
	cp WEATHER_SUN
	ld a, 0 ; full
	jr z, .share
	ld a, 2 ; 1/4
.share
	push af
	call .max_hp
	pop af
	and a
	jr z, .store
.shift
	srl d
	rr e
	dec a
	jr nz, .shift
.store
	ld a, [wMSimSide]
	and a
	ld hl, wMSimEnemyHeal
	jr z, .store_it
	ld hl, wMSimPlayerHeal
.store_it
	ld [hl], d
	inc hl
	ld [hl], e
	ret

.set_flag
; set the side's flag a (the enemy's bit; the player's is the next one)
	ld b, a
	ld a, [wMSimSide]
	add b
	ld hl, wMSimFlags2
	scf
	jmp MSim_SetFlagCarry

.max_hp
	ld a, [wMSimSide]
	and a
	ld hl, wEnemyMonMaxHP
	jr z, .got_max
	ld hl, wBattleMonMaxHP
.got_max
	ld d, [hl]
	inc hl
	ld e, [hl]
	ret

MSim_DivDEBy3:
	xor a
	ldh [hDividend + 0], a
	ldh [hDividend + 1], a
	ld a, d
	ldh [hDividend + 2], a
	ld a, e
	ldh [hDividend + 3], a
	ld a, 3
	ldh [hDivisor], a
	ld b, 4
	call Divide
	ldh a, [hQuotient + 2]
	ld d, a
	ldh a, [hQuotient + 3]
	ld e, a
	ret

MSim_Run:
; Play out the 1-on-1 from wMSimEnemyHP / wMSimPlayerHP. Return carry if the
; enemy wins (the player's mon goes down first) within MSIM_MAX_TURNS.
	ld a, MSIM_MAX_TURNS
	ld [wMSimTurns], a
.turn
	call MSim_ChooseActions
	; order: higher priority first, then speed (ties: the player)
	ld a, [wMSimFlags]
	ld b, a
	and 1 << MSIM_E_PRIO_THIS_F | 1 << MSIM_P_PRIO_THIS_F
	jr z, .by_speed
	cp 1 << MSIM_E_PRIO_THIS_F | 1 << MSIM_P_PRIO_THIS_F
	jr z, .by_speed
	cp 1 << MSIM_E_PRIO_THIS_F
	jr z, .enemy_first
	jr .player_first
.by_speed
	bit MSIM_E_FASTER_F, b
	jr z, .player_first
.enemy_first
	call MSim_EnemyActs
	and a
	jr nz, .result
	call MSim_PlayerActs
	and a
	jr nz, .result
	jr .end_of_turn
.player_first
	call MSim_PlayerActs
	and a
	jr nz, .result
	call MSim_EnemyActs
	and a
	jr nz, .result
.end_of_turn
	call MSim_EndOfTurn
	and a
	jr nz, .result
	xor a
	ld [wMSimT1Kind], a ; (a forced move is only for the first turn)
	ld hl, wMSimTurns
	dec [hl]
	jr nz, .turn
	; out of turns: no win (a = 0, carry clear)
	ret
.result
	cp MSIM_ENEMY_WINS
	jr z, .enemy_wins
	and a
	ret
.enemy_wins
	scf
	ret

MSim_ChooseActions:
; Each side uses its strongest move, or its best priority move when that
; KOs for sure, or its heal move (MSim_*ShouldHeal). Sets wMSimEnemyHit /
; wMSimPlayerHit and the per-turn priority and heal flags.
	ld hl, wMSimFlags
	res MSIM_E_PRIO_THIS_F, [hl]
	res MSIM_P_PRIO_THIS_F, [hl]
	ld hl, wMSimFlags3
	res MSIM_E_HEALS_F, [hl]
	res MSIM_P_HEALS_F, [hl]
	; enemy: a forced first-turn move (AI_SimMoveChoice)?
	ld a, [wMSimT1Kind]
	and $7f
	jr z, .enemy
	cp MSIM_T1_HEAL
	jr z, .player
	ld hl, wMSimT1Dmg ; (status moves: 0)
	ld de, wMSimEnemyHit
	call MSim_CopyWord
	ld a, [wMSimT1Kind]
	bit MSIM_T1_PRIO_F, a
	jr z, .player
	ld hl, wMSimFlags
	set MSIM_E_PRIO_THIS_F, [hl]
	jr .player
.enemy
	ld hl, wMSimEnemyPrioDmg
	ld de, wMSimPlayerHP
	call MSim_PrioKOs
	jr nc, .enemy_best
	ld hl, wMSimEnemyPrioDmg
	ld de, wMSimEnemyHit
	call MSim_CopyWord
	ld hl, wMSimFlags
	set MSIM_E_PRIO_THIS_F, [hl]
	jr .player
.enemy_best
	ld hl, wMSimEnemyDmg
	ld de, wMSimEnemyHit
	call MSim_CopyWord
	ld hl, wMSimFlags
	bit MSIM_E_BEST_PRIO_F, [hl]
	jr z, .player
	set MSIM_E_PRIO_THIS_F, [hl]
.player
	ld hl, wMSimPlayerPrioDmg
	ld de, wMSimEnemyHP
	call MSim_PrioKOs
	jr nc, .player_best
	ld hl, wMSimPlayerPrioDmg
	ld de, wMSimPlayerHit
	call MSim_CopyWord
	ld hl, wMSimFlags
	set MSIM_P_PRIO_THIS_F, [hl]
	jr .heals
.player_best
	ld hl, wMSimPlayerDmg
	ld de, wMSimPlayerHit
	call MSim_CopyWord
	ld hl, wMSimFlags
	bit MSIM_P_BEST_PRIO_F, [hl]
	jr z, .heals
	set MSIM_P_PRIO_THIS_F, [hl]

.heals
	ld a, [wMSimT1Kind]
	and $7f
	jr z, .heal_check
	cp MSIM_T1_HEAL
	jr nz, .player_heal ; a forced attack or status move
	scf
	jr .heal_decided
.heal_check
	call MSim_EnemyShouldHeal
.heal_decided
	jr nc, .player_heal
	ld hl, wMSimFlags3
	set MSIM_E_HEALS_F, [hl]
	ld hl, wMSimFlags
	res MSIM_E_PRIO_THIS_F, [hl]
	ld a, [wMSimFlags2]
	bit MSIM_E_HEAL_PRIO_F, a
	jr z, .player_heal
	set MSIM_E_PRIO_THIS_F, [hl]
.player_heal
	call MSim_PlayerShouldHeal
	ret nc
	ld hl, wMSimFlags3
	set MSIM_P_HEALS_F, [hl]
	ld hl, wMSimFlags
	res MSIM_P_PRIO_THIS_F, [hl]
	ld a, [wMSimFlags2]
	bit MSIM_P_HEAL_PRIO_F, a
	ret z
	set MSIM_P_PRIO_THIS_F, [hl]
	ret

MSim_PrioKOs:
; Carry if the (nonzero) priority damage at hl >= the HP at de.
	ld a, [hli]
	ld b, a
	ld a, [hld]
	ld c, a
	or b
	ret z
	ld a, [de]
	ld h, a
	inc de
	ld a, [de]
	ld l, a
	; damage - HP: no borrow = KO
	ld a, c
	sub l
	ld a, b
	sbc h
	ccf
	ret

MSim_CopyWord:
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	ret

MSim_WordGE:
; Carry if the word at hl >= the word at de (big-endian). Preserves bc.
	push bc
	ld a, [hli]
	ld b, a
	ld c, [hl]
	ld a, [de]
	ld h, a
	inc de
	ld a, [de]
	ld l, a
	ld a, c
	sub l
	ld a, b
	sbc h
	ccf
	pop bc
	ret

MACRO msim_should_heal
; \1 = this side (Enemy / Player), \2 = the other side, \3 = E / P,
; \4 = the jr condition on MSIM_E_FASTER_F that means this side moves first
MSim_\1ShouldHeal:
; Carry if this side heals this turn: it has a heal move, isn't asleep, can't
; KO now (or would be KO'd first), it's in KO range (the other side's best hit; two of them if it
; moves second), and the heal is bigger than that hit (Rest: its max HP).
	ld hl, wMSim\1Heal
	ld a, [hli]
	ld b, a
	ld c, [hl]
	or c
	ret z
	ld a, [wMSim\1Sleep]
	cp 2
	jr nc, .no
	ld hl, wMSim\1Hit
	ld de, wMSim\2HP
	call MSim_WordGE
	jr nc, .no_ko
	; it can KO: attack, unless it moves second and the other side's hit
	; KOs it first
	ld a, [wMSimFlags]
	bit MSIM_E_FASTER_F, a
	jr \4, .no
	ld hl, wMSim\2Dmg
	ld de, wMSim\1HP
	call MSim_WordGE
	jr nc, .no
.no_ko
	; KO range: the other side's best hit, doubled if this side moves second
	ld hl, wMSim\2Dmg
	ld a, [hli]
	ld d, a
	ld e, [hl]
	ld a, [wMSimFlags2]
	bit MSIM_\3_HEAL_PRIO_F, a
	jr nz, .threshold
	ld a, [wMSimFlags]
	bit MSIM_E_FASTER_F, a
	jr \4, .threshold
	sla e
	rl d
	jr nc, .threshold
	ld de, $ffff
.threshold
	ld hl, wMSim\1HP
	ld a, [hli]
	ld l, [hl]
	ld h, a
	; range - HP: a borrow means it isn't in range yet
	ld a, e
	sub l
	ld a, d
	sbc h
	jr c, .no
	; the other side's best hit < heal
	ld hl, wMSim\2Dmg
	ld a, [hli]
	ld d, a
	ld e, [hl]
	ld a, e
	sub c
	ld a, d
	sbc b
	ret
.no
	and a
	ret
ENDM

	msim_should_heal Enemy, Player, E, nz
	msim_should_heal Player, Enemy, P, z

MACRO msim_acts
; \1 = this side (Enemy / Player), \2 = the other side, \3 = E / P,
; \4 = this side's win code
MSim_\1Acts:
; This side's action and its residual damage. a = 0, or the winner.
	; asleep: it wakes up (and acts) when the counter runs out
	ld hl, wMSim\1Sleep
	ld a, [hl]
	and a
	jr z, .awake
	dec [hl]
	jr nz, .residual
.awake
	ld a, [wMSimFlags3]
	bit MSIM_\3_HEALS_F, a
	jr z, .attack
	ld a, [wMSimFlags2]
	bit MSIM_\3_REST_F, a
	jr z, .heal
	ld a, REST_SLEEP_TURNS
	ld [wMSim\1Sleep], a
	ld hl, wMSimFlags3
	set MSIM_\3_CURED_F, [hl]
.heal
	ld hl, wMSim\1Heal
	ld a, [hli]
	ld b, a
	ld c, [hl]
	call MSim_Heal\1
	jr .residual

.attack
	ld a, [wMSim\1Hit]
	ld b, a
	ld a, [wMSim\1Hit + 1]
	ld c, a
	push bc
	call MSim_Subtract\2HP
	pop bc
	ld a, \4
	ret c
	IF !STRCMP("\1", "Enemy")
	push bc
	call MSim_ApplyInflict
	pop bc
	ENDC
	; its strongest move drains: heal half the damage
	ld a, [wMSimFlags]
	bit MSIM_\3_BEST_DRAIN_F, a
	jr z, .residual
	; (not if it used a priority move that isn't its strongest)
	and 1 << MSIM_\3_PRIO_THIS_F | 1 << MSIM_\3_BEST_PRIO_F
	jr z, .drain
	cp 1 << MSIM_\3_PRIO_THIS_F | 1 << MSIM_\3_BEST_PRIO_F
	jr nz, .residual
.drain
	srl b
	rr c
	ld a, b
	or c
	jr nz, .drain_heal
	inc c
.drain_heal
	call MSim_Heal\1
.residual
	jmp MSim_\1Residual
ENDM

	msim_acts Enemy, Player, E, MSIM_ENEMY_WINS
	msim_acts Player, Enemy, P, MSIM_PLAYER_WINS

MACRO msim_residual
; \1 = this side (Enemy / Player), \2 = E / P, \3 = the other side's win
; code, \4 = this side's battle mon prefix (wEnemyMon / wBattleMon),
; \5 = its substatus prefix (wEnemySubStatus / wPlayerSubStatus),
; \6 = the other side (Enemy / Player)
MSim_\1Residual:
; Poison / burn / frostbite, Leech Seed, Curse after this side acts.
; a = 0, or the other side's win code if this KOs it.
	ld a, [wMSimFlags2]
	bit MSIM_\2_MAGIC_GUARD_F, a
	jr nz, .none
	ld a, [wMSimFlags3]
	bit MSIM_\2_CURED_F, a
	jr nz, .seed
	ld a, [\4Status]
	and 1 << PSN | 1 << BRN | 1 << FRZ
	IF !STRCMP("\1", "Player")
	jr nz, .has_status
	ld a, [wMSimInflict]
	and 1 << MSIM_INF_PSN_F | 1 << MSIM_INF_TOX_F | 1 << MSIM_INF_BRN_F
	ENDC
	jr z, .seed
.has_status
	ld a, 4
	call MSim_\1MaxShare
	ld a, [\55]
	bit SUBSTATUS_TOXIC, a
	IF !STRCMP("\1", "Player")
	jr nz, .toxic
	ld a, [wMSimInflict]
	bit MSIM_INF_TOX_F, a
	ENDC
	jr z, .status_damage
.toxic
	ld hl, wMSim\1Toxic
	inc [hl]
	ld a, [hl]
	call MSim_MultiplyBC
.status_damage
	call MSim_Subtract\1HP
	jr c, .faints
.seed
	ld a, [\54]
	bit SUBSTATUS_LEECH_SEED, a
	IF !STRCMP("\1", "Player")
	jr nz, .seeded
	ld a, [wMSimInflict]
	bit MSIM_INF_SEED_F, a
	ENDC
	jr z, .curse
.seeded
	ld a, 3
	call MSim_\1MaxShare
	push bc
	call MSim_Subtract\1HP
	pop bc
	jr c, .faints
	call MSim_Heal\6
.curse
	ld a, [\51]
	bit SUBSTATUS_CURSE, a
	jr z, .none
	ld a, 2
	call MSim_\1MaxShare
	call MSim_Subtract\1HP
	jr c, .faints
.none
	xor a
	ret
.faints
	ld a, \3
	ret
ENDM

	msim_residual Enemy, E, MSIM_PLAYER_WINS, wEnemyMon, wEnemySubStatus, Player
	msim_residual Player, P, MSIM_ENEMY_WINS, wBattleMon, wPlayerSubStatus, Enemy

MSim_EndOfTurn:
; Sandstorm / hail while it lasts, then Leftovers. a = 0, or the winner
; (if both go down, the player wins).
	ld hl, wMSimWeatherTurns
	ld a, [hl]
	and a
	jr z, .leftovers
	dec [hl]
	ld a, [wBattleWeather]
	cp WEATHER_SANDSTORM
	jr z, .weather
	cp WEATHER_HAIL
	jr nz, .leftovers
.weather
	call MSim_PlayerWeather
	jr nc, .enemy_weather
	call MSim_EnemyWeather
	ld a, MSIM_PLAYER_WINS
	ret c
	ld a, MSIM_ENEMY_WINS
	ret
.enemy_weather
	call MSim_EnemyWeather
	ld a, MSIM_PLAYER_WINS
	ret c
.leftovers
	ld a, [wMSimFlags2]
	bit MSIM_E_LEFTOVERS_F, a
	jr z, .player_leftovers
	ld a, 4
	call MSim_EnemyMaxShare
	call MSim_HealEnemy
.player_leftovers
	ld a, [wMSimFlags2]
	bit MSIM_P_LEFTOVERS_F, a
	jr z, .done
	ld a, 4
	call MSim_PlayerMaxShare
	call MSim_HealPlayer
.done
	xor a
	ret

MSim_EnemyWeather:
; Carry if this turn's weather damage KOs the enemy's mon.
	ld a, [wMSimFlags2]
	bit MSIM_E_MAGIC_GUARD_F, a
	jr nz, MSim_WeatherImmune
	ld hl, wEnemyMonType1
	call MSim_WeatherImmuneTypes
	jr c, MSim_WeatherImmune
	ld a, 4
	call MSim_EnemyMaxShare
	jmp MSim_SubtractEnemyHP

MSim_PlayerWeather:
; Carry if this turn's weather damage KOs the player's mon.
	ld a, [wMSimFlags2]
	bit MSIM_P_MAGIC_GUARD_F, a
	jr nz, MSim_WeatherImmune
	ld hl, wBattleMonType1
	call MSim_WeatherImmuneTypes
	jr c, MSim_WeatherImmune
	ld a, 4
	call MSim_PlayerMaxShare
	jmp MSim_SubtractPlayerHP

MSim_WeatherImmune:
	and a
	ret

MSim_WeatherImmuneTypes:
; hl = a mon's two types. Carry if they're immune to the weather (sandstorm:
; Rock, Ground, Steel; hail: Ice).
	ld a, [wBattleWeather]
	cp WEATHER_HAIL
	jr z, .hail
	ld a, [hli]
	call .sand
	ret c
	ld a, [hl]
.sand
	cp ROCK
	jr z, .yes
	cp GROUND
	jr z, .yes
	cp STEEL
	jr z, .yes
	and a
	ret
.hail
	ld a, [hli]
	cp ICE
	jr z, .yes
	ld a, [hl]
	cp ICE
	jr z, .yes
	and a
	ret
.yes
	scf
	ret

MSim_HealEnemy:
; HP += bc, up to the max.
	ld hl, wMSimEnemyHP
	ld de, wEnemyMonMaxHP
	jr MSim_HealHP

MSim_HealPlayer:
	ld hl, wMSimPlayerHP
	ld de, wBattleMonMaxHP
	; fallthrough

MSim_HealHP:
; [hl] += bc, capped at [de] (big-endian words).
	push hl
	inc hl
	ld a, [hl]
	add c
	ld c, a
	dec hl
	ld a, [hl]
	adc b
	ld b, a
	jr c, .cap
	inc de
	ld a, [de]
	sub c
	dec de
	ld a, [de]
	sbc b
	jr c, .cap
	pop hl
	ld [hl], b
	inc hl
	ld [hl], c
	ret
.cap
	pop hl
	ld a, [de]
	ld [hli], a
	inc de
	ld a, [de]
	ld [hl], a
	ret

MSim_EnemyMaxShare:
; bc = the enemy mon's max HP >> a (at least 1).
	ld hl, wEnemyMonMaxHP
	jr MSim_HLMaxShare

MSim_PlayerMaxShare:
	ld hl, wBattleMonMaxHP
	; fallthrough

MSim_HLMaxShare:
	ld b, [hl]
	inc hl
	ld c, [hl]
.loop
	srl b
	rr c
	dec a
	jr nz, .loop
	ld a, b
	or c
	ret nz
	inc c
	ret

MSim_MultiplyBC:
; bc *= a (a >= 1).
	ld h, b
	ld l, c
	dec a
	ret z
.loop
	add hl, bc
	dec a
	jr nz, .loop
	ld b, h
	ld c, l
	ret


MSim_RunBest:
; MSim_Run from the current HP. If that loses and the enemy's mon has a
; usable boosting move, try again: on the first turn it boosts (and the
; player gets a free hit), then it attacks with the boosted stats. Carry if
; either way wins.
	ld hl, wMSimEnemyHP
	ld de, wMSimStartHP
	ld bc, 4
	call CopyBytes
	call MSim_Run
	ret c

	; asleep for more than this turn: it can't boost first
	ld a, [wEnemyMonStatus]
	and SLP_MASK
	cp 2
	jr nc, .no
	call MSim_FindBoost
	jr nc, .no
	jr MSim_RunBoost

.no
	and a
	ret

MSim_RunBoost:
; hl = stat stage changes (MSim_BoostEffects); wMSimStartHP = the HP to start
; from. The enemy boosts on the first turn (the player gets a free hit), then
; MSim_Run. Carry if it wins. Leaves the enemy's stats raised.
	; raise its stat stages (up to MAX_STAT_LEVEL) and recalculate
	ld de, wEnemyStatLevels
	ld c, NUM_BATTLE_STATS
.raise
	ld a, [de]
	add [hl]
	cp MAX_STAT_LEVEL + 1
	jr c, .got_level
	ld a, MAX_STAT_LEVEL
.got_level
	ld [de], a
	inc de
	inc hl
	dec c
	jr nz, .raise
	ld a, 1
	ldh [hBattleTurn], a
	callfar CalcEnemyStats
	call MSim_ComputeDamages
	ld hl, wMSimStartHP
	ld de, wMSimEnemyHP
	ld bc, 4
	call CopyBytes

	; the boost turn: only the player attacks
	xor a
	ld [wMSimEnemySleep], a
	call MSim_ChooseActions
	call MSim_PlayerActs
	cp MSIM_PLAYER_WINS
	jr z, .no
	call MSim_EnemyResidual
	cp MSIM_PLAYER_WINS
	jr z, .no
	call MSim_EndOfTurn
	and a
	jr z, .fight
	cp MSIM_ENEMY_WINS
	jr nz, .no
	scf
	ret
.fight
	jmp MSim_Run

.no
	and a
	ret

MSim_FindBoost:
; Carry and hl = the stat changes (Atk, Def, Spe, SpA, SpD) of the enemy
; mon's first usable boosting move.
	ld hl, wEnemyMonMoves
	ld de, wEnemyMonPP
	ld b, NUM_MOVES
.loop
	ld a, [hli]
	and a
	ret z ; (carry clear)
	ld c, a
	ld a, [de]
	inc de
	and PP_MASK
	jr z, .next
	push hl
	push de
	push bc
	ld a, c
	dec a
	ld hl, Moves + MOVE_EFFECT
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld a, BANK(Moves)
	call GetFarByte
	ld c, a
	ld hl, MSim_BoostEffects
.find
	ld a, [hli]
	cp -1
	jr z, .not_boost
	cp c
	jr z, .found
	ld de, NUM_BATTLE_STATS
	add hl, de
	jr .find
.found
	pop bc
	pop de
	pop de ; (hl stays the table entry)
	scf
	ret
.not_boost
	pop bc
	pop de
	pop hl
.next
	dec b
	jr nz, .loop
	and a
	ret

MSim_BoostEffects:
; effect, then stat stage changes: Attack, Defense, Speed, Sp. Atk, Sp. Def
	db EFFECT_ATTACK_UP_2,  2, 0, 0, 0, 0 ; Swords Dance
	db EFFECT_SP_ATK_UP_2,  0, 0, 0, 2, 0 ; Nasty Plot
	db EFFECT_SPEED_UP_2,   0, 0, 2, 0, 0 ; Agility
	db EFFECT_SP_DEF_UP_2,  0, 0, 0, 0, 2 ; Amnesia
	db EFFECT_DRAGON_DANCE, 1, 0, 1, 0, 0
	db EFFECT_CALM_MIND,    0, 0, 0, 1, 1
	db EFFECT_BULK_UP,      1, 1, 0, 0, 0
	db EFFECT_QUIVER_DANCE, 0, 0, 1, 1, 1
	db EFFECT_GROWTH,       1, 0, 0, 1, 0
	db EFFECT_MYSTIC_DANCE, 0, 0, 1, 1, 0
	db EFFECT_FURY_DRIVE,   1, 0, 1, 1, 0
	db -1

; ===== Move choice by simulation =====
;
; After the scoring layers (and AI_DismissImmuneMoves), every move the AI
; would consider (score within 20 of its favourite) is played out: "use this
; move now, then play on as in MSim_Run". Damaging moves hit with their own
; damage and priority; boosting moves boost (the player gets a free hit);
; healing moves heal; sleep, poison, bad poison, burn, paralysis and Leech
; Seed are inflicted on the player's mon (when they can work). If any move
; wins, the winners that keep the most HP (100%-accurate moves first) get
; score 1 and every other usable move at least 21. If none wins, the move
; that takes the most HP off the player gets a small nudge.

AI_MoveChoiceFinal:
; Farcalled by AIChooseMove after NormalizeAIMoveScores.
	farcall AI_DismissImmuneMoves
	; fallthrough

AI_SimMoveChoice:
	call MSim_Begin
	call MSim_SetupActive
	ld hl, wMSimEnemyDmg
	ld de, wMSimSavedDmg
	ld c, 8
	call MSim_ToSaveBank
	ld hl, wMSimFlags
	ld de, wMSimSavedDmg + 8
	ld c, 1
	call MSim_ToSaveBank

	; d = the lowest score of a usable move
	ld d, $fe
	ld c, 0
.find_min
	call .slot
	jr z, .min_done
	ld a, [hl]
	cp d
	jr nc, .next_min
	ld d, a
.next_min
	inc c
	ld a, c
	cp NUM_MOVES
	jr nz, .find_min
.min_done
	; d = the cutoff: lowest + 20 (at most $fe)
	ld a, d
	add 20
	jr c, .cap
	cp $fe
	jr c, .got_cutoff
.cap
	ld a, $fe
.got_cutoff
	ld d, a

	xor a
	ld [wMSimBestKey], a
	ld [wMSimBestMask], a
	ld [wMSimBestDealt], a
	dec a
	ld [wMSimDealtIndex], a
	ld c, 0
.eval_loop
	call .slot
	jr z, .evaluated
	ld a, [hl]
	cp d
	jr nc, .eval_next
	push bc
	push de
	call MSim_EvalSlot
	pop de
	pop bc
	jr nc, .loses
	; a winner: keep the best key (ties share it)
	ld hl, wMSimBestKey
	cp [hl]
	jr c, .eval_next
	jr z, .add_winner
	ld [hl], a
	xor a
	ld [wMSimBestMask], a
.add_winner
	call .slot_bit
	ld hl, wMSimBestMask
	or [hl]
	ld [hl], a
	jr .eval_next
.loses
	ld hl, wMSimBestDealt
	cp [hl]
	jr c, .eval_next
	jr z, .eval_next
	ld [hl], a
	ld a, c
	ld [wMSimDealtIndex], a
.eval_next
	inc c
	ld a, c
	cp NUM_MOVES
	jr nz, .eval_loop
.evaluated
	call MSim_End

	ld a, [wMSimBestMask]
	and a
	jr z, .no_winner
	ld e, a
	ld c, 0
.apply
	call .slot
	ret z
	ld a, [hl]
	cp $fe
	jr nc, .apply_next
	srl e
	jr nc, .not_best
	ld [hl], 1
	jr .apply_next_e
.not_best
	cp 21
	jr nc, .apply_next_e
	ld [hl], 21
	jr .apply_next_e
.apply_next
	srl e
.apply_next_e
	inc c
	ld a, c
	cp NUM_MOVES
	jr nz, .apply
	ret

.no_winner
	; nudge the move that does the most damage
	ld a, [wMSimDealtIndex]
	cp $ff
	ret z
	ld c, a
	call .slot
	ld a, [hl]
	cp 3
	ret c
	sub 2
	ld [hl], a
	ret

.slot
; c = slot: hl = its score; z if the slot is empty.
	ld hl, wEnemyMonMoves
	ld b, 0
	add hl, bc
	ld a, [hl]
	ld hl, wEnemyAIMoveScores
	add hl, bc
	and a
	ret

.slot_bit
; a = 1 << c
	push bc
	ld a, 1
	inc c
.bit_loop
	dec c
	jr z, .bit_done
	add a
	jr .bit_loop
.bit_done
	pop bc
	ret

MSim_EvalSlot:
; c = move slot of the enemy's active mon. Play out "use this move now, then
; play on". Return carry if that wins, with a = key (100%-accurate: 128 +;
; plus half the share of its HP left); else a = the share of the player's
; HP it takes off (0 if the move isn't simulated).
	push bc
	call MSim_ResetActive
	pop bc
	xor a
	ld [wMSimT1Kind], a
	ld [wMSimInflict], a
	ld [wMSimT1Dmg], a
	ld [wMSimT1Dmg + 1], a
	ld hl, wEnemyMonMoves
	ld b, 0
	add hl, bc
	ld a, [hl]
	ld b, a
	push bc
	ld de, wEnemyMoveStruct
	call MSim_LoadMove
	pop bc
	ld a, [wEnemyMoveStruct + MOVE_ACC]
	push af ; accuracy
	ld a, [wEnemyMoveStruct + MOVE_POWER]
	and a
	jr z, .non_damaging

	; damaging: its own damage and priority on the first turn
	ld a, MSIM_T1_CAPTURE
	ld [wMSimT1Kind], a
	call MSim_EnemyMoveDamage
	ld a, [wMSimT1Kind]
	cp MSIM_T1_CAPTURE
	jp nz, .run
	ld a, MSIM_T1_DAMAGE
	ld [wMSimT1Kind], a
	jp .run

.non_damaging
	ld a, [wEnemyMoveStruct + MOVE_EFFECT]
	ld c, a
	; boosting move
	ld hl, MSim_BoostEffects
.find_boost
	ld a, [hli]
	cp -1
	jr z, .not_boost
	cp c
	jr z, .boost
	ld de, NUM_BATTLE_STATS
	add hl, de
	jr .find_boost
.boost
	push hl
	ld hl, wMSimEnemyHP
	ld de, wMSimStartHP
	ld bc, 4
	call CopyBytes
	pop hl
	call MSim_RunBoost
	call MSim_EvalKey
	push af
	call MSim_RestoreEnemy
	pop af
	ld b, a
	jp nc, .lost
	pop af ; accuracy (boosting moves don't miss)
	ld a, b
	add 128
	scf
	ret

.not_boost
	ld a, c
	cp EFFECT_HEAL
	jr z, .heal
	cp EFFECT_SLACK_OFF
	jr z, .heal
	cp EFFECT_WEATHER_HEAL
	jr z, .heal
	call MSim_T1Inflict
	jr z, .not_simulated
	ld [wMSimT1Effect], a
	ld a, MSIM_T1_STATUS
	ld [wMSimT1Kind], a
	; paralysis and burn change the player's stats: apply them from the
	; start, recompute, and put the stats back after the run
	ld a, [wBattleMonSpeed]
	ld d, a
	ld a, [wBattleMonSpeed + 1]
	ld e, a
	push de
	ld a, [wBattleMonAttack]
	ld d, a
	ld a, [wBattleMonAttack + 1]
	ld e, a
	push de
	ld a, [wMSimT1Effect]
	and 1 << MSIM_INF_PAR_F | 1 << MSIM_INF_BRN_F
	jr z, .status_run
	ld a, [wMSimT1Effect]
	bit MSIM_INF_PAR_F, a
	jr z, .burn
	ld hl, wBattleMonSpeed
	call .quarter
.burn
	ld a, [wMSimT1Effect]
	bit MSIM_INF_BRN_F, a
	jr z, .recompute
	ld hl, wBattleMonAttack
	call .half
.recompute
	call MSim_ComputeDamages
.status_run
	call MSim_Run
	pop de
	push af
	ld a, d
	ld [wBattleMonAttack], a
	ld a, e
	ld [wBattleMonAttack + 1], a
	pop af
	pop de
	push af
	ld a, d
	ld [wBattleMonSpeed], a
	ld a, e
	ld [wBattleMonSpeed + 1], a
	pop af
	jr .result

.heal
	ld a, MSIM_T1_HEAL
	ld [wMSimT1Kind], a
.run
	call MSim_Run
.result
	call MSim_EvalKey
	ld b, a
	jr nc, .lost
	; +128 if 100% accurate
	pop af ; accuracy
	cp 100 percent
	ld a, b
	jr c, .key
	add 128
.key
	scf
	ret

.lost
	pop af
	ld a, b
	and a
	ret

.not_simulated
	pop af
	xor a
	ret

.quarter
	call .half
.half
	srl [hl]
	inc hl
	rr [hl]
	ld a, [hld]
	or [hl]
	ret nz
	inc hl
	inc [hl] ; at least 1
	dec hl
	ret

MSim_T1Inflict:
; c = a status move's effect (wEnemyMoveStruct loaded). Return the
; MSIM_INF_* bits it would inflict on the player's mon, or z if it can't
; (or isn't simulated).
	ld a, [wPlayerSubStatus4]
	bit SUBSTATUS_SUBSTITUTE, a
	jr nz, .none
	ld a, c
	cp EFFECT_LEECH_SEED
	jr z, .seed
	ld b, 1 << MSIM_INF_SLP_F
	cp EFFECT_SLEEP
	jr z, .status
	ld b, 1 << MSIM_INF_PSN_F
	cp EFFECT_POISON
	jr z, .poison
	ld b, 1 << MSIM_INF_TOX_F
	cp EFFECT_TOXIC
	jr z, .poison
	ld b, 1 << MSIM_INF_BRN_F
	cp EFFECT_BURN
	jr z, .burn
	ld b, 1 << MSIM_INF_PAR_F
	cp EFFECT_PARALYZE
	jr z, .status
.none
	xor a
	ret

.seed
	ld a, [wPlayerSubStatus4]
	bit SUBSTATUS_LEECH_SEED, a
	jr nz, .none
	ld a, GRASS
	call .has_type
	jr z, .none
	ld a, 1 << MSIM_INF_SEED_F
	and a
	ret

.poison
	ld a, POISON
	call .has_type
	jr z, .none
	ld a, STEEL
	call .has_type
	jr z, .none
	jr .status

.burn
	ld a, FIRE
	call .has_type
	jr z, .none
	; fallthrough

.status
	ld a, [wBattleMonStatus]
	and a
	jr nz, .none
	ld a, [wPlayerScreens]
	bit SCREENS_SAFEGUARD, a
	jr nz, .none
	; the move's type has to affect the player's mon
	push bc
	ld a, 1
	ldh [hBattleTurn], a
	callfar BattleCheckTypeMatchup
	pop bc
	ld a, [wTypeMatchup]
	and a
	jr z, .none
	ld a, b
	and a
	ret

.has_type
; z if the player's mon has type a
	ld hl, wBattleMonType1
	cp [hl]
	ret z
	inc hl
	cp [hl]
	ret

MSim_ApplyInflict:
; The enemy's first-turn status move lands: add its effect.
	ld a, [wMSimT1Kind]
	and $7f
	cp MSIM_T1_STATUS
	ret nz
	ld a, [wMSimT1Effect]
	ld hl, wMSimInflict
	or [hl]
	ld [hl], a
	bit MSIM_INF_TOX_F, a
	jr z, .sleep
	xor a
	ld [wMSimPlayerToxic], a
	ld a, [hl]
.sleep
	bit MSIM_INF_SLP_F, a
	ret z
	ld a, [wMSimPlayerSleep]
	and a
	ret nz
	ld a, 2 ; the shortest sleep: one skipped turn
	ld [wMSimPlayerSleep], a
	ret

MSim_ResetActive:
; Back to the start for the mon that's out: HP, the damages AI_SimMoveChoice
; saved, and the per-side state.
	call MSim_SetActiveHP
	ld hl, wMSimSavedDmg
	ld de, wMSimEnemyDmg
	ld c, 8
	call MSim_FromSaveBank
	ld hl, wMSimSavedDmg + 8
	ld de, wMSimFlags
	ld c, 1
	call MSim_FromSaveBank
	jmp MSim_SetupSides

MSim_EvalKey:
; After a run: carry (won) and a = half the share of its HP left, or no carry
; and a = the share of the player's max HP it took off.
	jr nc, .lost
	ld a, [wMSimEnemyHP]
	ld b, a
	ld a, [wMSimEnemyHP + 1]
	ld c, a
	ld a, [wEnemyMonMaxHP]
	ld d, a
	ld a, [wEnemyMonMaxHP + 1]
	ld e, a
	call MSim_ShareOf
	srl a
	scf
	ret
.lost
	call MSim_PlayerDealtShare
	and a
	ret

MSim_Begin:
; Save what the simulation overwrites.
	xor a
	ld [wMSimT1Kind], a
	ld [wMSimInflict], a
	pop hl ; return address
	ldh a, [hBattleTurn]
	push af
	ld a, [wCurDamage]
	push af
	ld a, [wCurDamage + 1]
	push af
	ld a, [wTypeMatchup]
	push af
	ld a, [wTypeModifier]
	push af
	ld a, [wCriticalHit]
	push af
	ld a, [wCurType]
	push af
	ld a, [wAttackMissed]
	push af
	push hl
	ld hl, wEnemyMoveStruct
	ld de, wSwitchInSavedEnemyMove
	ld bc, MOVE_LENGTH
	call CopyBytes
	ld hl, wPlayerMoveStruct
	ld de, wSwitchInSavedPlayerMove
	ld bc, MOVE_LENGTH
	call CopyBytes
	ld hl, wEnemyMonSpecies
	ld de, wMSimSavedStruct
	ld c, MSIM_SAVED_STRUCT_LENGTH
	call MSim_ToSaveBank
	ld hl, wEnemyStats
	ld de, wMSimSavedStats
	ld c, NUM_BATTLE_STATS * 2
	call MSim_ToSaveBank
	ld hl, wEnemyStatLevels
	ld de, wMSimSavedLevels
	ld c, MSIM_SAVED_LEVELS_LENGTH
	call MSim_ToSaveBank
	ld hl, wEnemySubStatus1
	ld de, wMSimSavedSubStatus
	ld c, MSIM_SAVED_SUBSTATUS_LENGTH
	jr MSim_ToSaveBank

MSim_End:
; Put back what MSim_Begin saved.
	call MSim_RestoreEnemy
	jr MSim_EndRest

MSim_RestoreEnemy:
; Put back the enemy mon's battle struct, stats, stat stages and substatus.
	ld hl, wMSimSavedStruct
	ld de, wEnemyMonSpecies
	ld c, MSIM_SAVED_STRUCT_LENGTH
	call MSim_FromSaveBank
	ld hl, wMSimSavedStats
	ld de, wEnemyStats
	ld c, NUM_BATTLE_STATS * 2
	call MSim_FromSaveBank
	ld hl, wMSimSavedLevels
	ld de, wEnemyStatLevels
	ld c, MSIM_SAVED_LEVELS_LENGTH
	call MSim_FromSaveBank
	ld hl, wMSimSavedSubStatus
	ld de, wEnemySubStatus1
	ld c, MSIM_SAVED_SUBSTATUS_LENGTH
	jr MSim_FromSaveBank

MSim_EndRest:
	ld hl, wSwitchInSavedEnemyMove
	ld de, wEnemyMoveStruct
	ld bc, MOVE_LENGTH
	call CopyBytes
	ld hl, wSwitchInSavedPlayerMove
	ld de, wPlayerMoveStruct
	ld bc, MOVE_LENGTH
	call CopyBytes
	pop hl ; return address
	pop af
	ld [wAttackMissed], a
	pop af
	ld [wCurType], a
	pop af
	ld [wCriticalHit], a
	pop af
	ld [wTypeModifier], a
	pop af
	ld [wTypeMatchup], a
	pop af
	ld [wCurDamage + 1], a
	pop af
	ld [wCurDamage], a
	pop af
	ldh [hBattleTurn], a
	jp hl

MSim_ToSaveBank:
; Copy c bytes from hl (WRAMX bank 1) to de (the save bank).
	ldh a, [rSVBK]
	ld b, a
.loop
	ld a, [hli]
	di
	push af
	ld a, BANK(wMSimSavedStruct)
	ldh [rSVBK], a
	pop af
	ld [de], a
	ld a, b
	ldh [rSVBK], a
	ei
	inc de
	dec c
	jr nz, .loop
	ret

MSim_FromSaveBank:
; Copy c bytes from hl (the save bank) to de (WRAMX bank 1).
	ldh a, [rSVBK]
	ld b, a
.loop
	di
	ld a, BANK(wMSimSavedStruct)
	ldh [rSVBK], a
	ld a, [hli]
	push af
	ld a, b
	ldh [rSVBK], a
	ei
	pop af
	ld [de], a
	inc de
	dec c
	jr nz, .loop
	ret
