ShadowTagPokemon_AI:
	db CHANDELURE
	db GENGAR
	db -1 ; end

ArenaTrapPokemon_AI:
	db DRILBUR
	db EXCADRILL
    db -1 ; end

MagnetPullPokemon_AI:
	db MAGNEMITE
	db MAGNETON
	db MAGNEZONE
	db -1 ; end

RunAwayPokemon_AI:
	db DODUO
	db DODRIO
    db -1 ; end

AI_SwitchOrTryItem:
	and a

	ld a, [wBattleMode]
	dec a
	ret z

	ld a, [wLinkMode]
	and a
	ret nz

	farcall CheckEnemyLockedIn
	ret nz

	ld a, [wPlayerSubStatus5]
	bit SUBSTATUS_CANT_RUN, a
	jr nz, DontSwitch

	ld a, [wEnemyWrapCount]
	and a
	jr nz, DontSwitch

	; always load the first trainer class in wTrainerClass for Battle Tower trainers
	ld hl, TrainerClassAttributes + TRNATTR_AI_ITEM_SWITCH
	ld a, [wInBattleTowerBattle]
	and a
	jr nz, .ok

	ld a, [wTrainerClass]
	dec a
	ld bc, NUM_TRAINER_ATTRIBUTES
	call AddNTimes

.ok
	bit SWITCH_OFTEN_F, [hl]
	jr nz, SwitchOften
	bit SWITCH_RARELY_F, [hl]
	jr nz, SwitchRarely
	bit SWITCH_SOMETIMES_F, [hl]
	jr nz, SwitchSometimes
	; fallthrough

DontSwitch:
	jmp AI_TryItem

; this switches with probabilities:
; 50%, 80%, 96% depending on switch score
SwitchOften:
	call CheckSetUp
	jr c, DontSwitch
	callfar CheckAbleToSwitch
	ld a, [wEnemySwitchMonParam]
	and $f0
	jr z, DontSwitch

	cp $10
	jr nz, .not_10
	call AI_50_50
	jr c, .switch
	jr DontSwitch

.not_10
	cp $20
	jr nz, .not_20
	call Random
	cp 79 percent - 1
	jr c, .switch
	jr DontSwitch

.not_20
	; $30
	call Random
	cp 4 percent
	jr c, DontSwitch
	; fallthrough

.switch
	ld a, [wEnemySwitchMonParam]
	and $f
	inc a
	; In register 'a' is the number (1-6) of the mon to switch to
	ld [wEnemySwitchMonIndex], a
	jr AI_TrySwitch

; this switches with probabilities:
; 8%, 12%, 80% depending on switch score
SwitchRarely:
	call CheckSetUp
	jr c, DontSwitch
	callfar CheckAbleToSwitch
	ld a, [wEnemySwitchMonParam]
	and $f0
	jr z, DontSwitch

	cp $10
	jr nz, .not_10
	call Random
	cp 20 percent - 1
	jr c, .switch
	jr DontSwitch

.not_10
	cp $20
	jr nz, .not_20
	call Random
	cp 50 percent + 1
	jr c, .switch
	jr DontSwitch

.not_20
	; $30
	call Random
	cp 20 percent - 1
	jr c, DontSwitch
	; fallthrough

.switch
	ld a, [wEnemySwitchMonParam]
	and $f
	inc a
	ld [wEnemySwitchMonIndex], a
	jr AI_TrySwitch

; this switches with probabilities:
; 20%, 50%, 80% depending on switch score
SwitchSometimes:
	call CheckSetUp
	jmp c, DontSwitch
	callfar CheckAbleToSwitch
	ld a, [wEnemySwitchMonParam]
	and $f0
	jmp z, DontSwitch

	cp $10
	jr nz, .not_10
	call AI_80_20
	jr c, .switch
	jmp DontSwitch

.not_10
	cp $20
	jr nz, .not_20
	call AI_50_50
	jr c, .switch
	jmp DontSwitch

.not_20
	; $30
	call AI_80_20
	jmp c, DontSwitch
	; fallthrough

.switch
	ld a, [wEnemySwitchMonParam]
	and $f
	inc a
	; In register 'a' is the number (1-6) of the mon to switch to
	ld [wEnemySwitchMonIndex], a
	; fallthrough

AI_TrySwitch:
; Determine whether the AI can switch based on how many Pokemon are still alive.

; =========================
; === Ability: Run Away ===
; =========================
	; enemy can switch when the player has a shadow tag pokemon
	ld a, [wEnemyMonSpecies]
	ld hl, RunAwayPokemon_AI
	call IsInByteArray
	jr c, .skip_trapping_mons

; ===========================
; === Ability: Shadow Tag ===
; ===========================
	; enemy can't switch when the player has a shadow tag pokemon
	ld a, [wBattleMonSpecies]
	ld hl, ShadowTagPokemon_AI
	call IsInByteArray
	jr nc, .check_arena_trap
	jmp TrappedByPlayerPlayer

.check_arena_trap
; ===========================
; === Ability: Arena Trap ===
; ===========================
; enemy can't switch when the player has an arena trap pokemon
; if enemy has a non-flier or levitator

	; check if enemy has a levitating pokemon
	; can't trap levitating pokemon
	ld a, [wEnemyMonSpecies]
	ld hl, LevitatePokemon
	call IsInByteArray
	jr c, .check_magnet_pull
	
	; check if player has an arena trap pokemon
	ld a, [wBattleMonSpecies]
	ld hl, ArenaTrapPokemon_AI
	call IsInByteArray
	jr nc, .check_magnet_pull

	; check type
	ld de, wEnemyMonType1

	; check if flying type
	ld a, [de]
	cp FLYING
	jr z, .check_magnet_pull
	inc de
	ld a, [de]
	cp FLYING
	jr z, .check_magnet_pull
	jmp TrappedByPlayerPlayer

.check_magnet_pull
; ============================
; === Ability: Magnet Pull ===
; ============================
; enemy can't switch when the player has a magnet pull pokemon
; if enemy has a steel type pokemon

	; check if player has a magnet pull pokemon
	ld a, [wBattleMonSpecies]
	ld hl, MagnetPullPokemon_AI
	call IsInByteArray
	jr nc, .check_stat_boosted_levels

	; check type
	ld de, wEnemyMonType1

	; check if steel type and trap if so
	ld a, [de]
	cp STEEL
	jr z, .trapped_by_magnet_pull
	inc de
	ld a, [de]
	cp STEEL
	jr z, .trapped_by_magnet_pull
	jr .check_stat_boosted_levels

.trapped_by_magnet_pull
	jmp TrappedByPlayerPlayer

.skip_trapping_mons
.check_stat_boosted_levels
; switching routine
; don't switch if already set up
; there is a bit of an issue here
; this prevents the AI from switching out a set up mon because there is another with a better type match - which is good
; but this also prevents the ai from switching out a set up mon which has ran out of pp on a common mono-attacking move
	ld a, [wEnemyAtkLevel]
	cp BASE_STAT_LEVEL + 2
	ret nc
	ld a, [wEnemySAtkLevel]
	cp BASE_STAT_LEVEL + 2
	ret nc
	ld a, [wEnemyDefLevel]
	cp BASE_STAT_LEVEL + 2
	ret nc
	ld a, [wEnemySDefLevel]
	cp BASE_STAT_LEVEL + 2
	ret nc

; If it can switch, it will.
	ld a, [wOTPartyCount]
	ld c, a
	ld hl, wOTPartyMon1HP
	ld d, 0
.SwitchLoop:
	ld a, [hli]
	ld b, a
	ld a, [hld]
	or b
	jr z, .fainted
	inc d
.fainted
	push bc
	ld bc, PARTYMON_STRUCT_LENGTH
	add hl, bc
	pop bc
	dec c
	jr nz, .SwitchLoop

	ld a, d
	cp 2
	jr nc, AI_Switch
	; fallthrough

AI_Switch:
; if enemy's Perish Count is 1 or
; if TrappedByPlayerped by warp, mean look, etc.,
; we never reach here

	ld a, [wEnemySubStatus1]
	bit SUBSTATUS_PERISH, a
	jr z, .continue

	ld a, [wEnemyPerishCount]
	cp 1
	jr nz, .continue

; if enemy has x accuracy status, skip checking accuracy and evasion
	ld a, [wEnemySubStatus4]
	bit SUBSTATUS_X_ACCURACY, a
	jr nz, .no_miss

; if player is identified by foresight, skip checking accuracy and evasion
	ld a, [wPlayerSubStatus1]
	bit SUBSTATUS_IDENTIFIED, a
	jr nz, .no_miss

; if enemy's accuracy is lowered or player's evasion is raised, switch
	ld a, [wEnemyAccLevel]
	cp BASE_STAT_LEVEL
	jr c, .continue
	ld a, [wPlayerEvaLevel]
	cp BASE_STAT_LEVEL + 1
	jr nc, .continue

.no_miss
; switch if enemy is infatuated, confused,
; destiny bonded, paralyzed, or asleep

	ld a, [wEnemySubStatus1]
	bit SUBSTATUS_IN_LOVE, a
	jr nz, .continue

	ld a, [wEnemySubStatus3]
	bit SUBSTATUS_CONFUSED, a
	jr nz, .continue

	ld a, [wEnemySubStatus5]
	and 1 << SUBSTATUS_DESTINY_BOND
	jr nz, .continue

	ld a, [wEnemyMonStatus]
	and 1 << PAR | SLP_MASK
	jr nz, .continue

; clear carry flag
	and a
	ret

.continue
	ld a, $1
	ld [wEnemyIsSwitching], a
	ld [wEnemyGoesFirst], a
	xor a
	ldh [hBattleTurn], a
	callfar PursuitSwitch

	push af
	ld a, [wCurOTMon]
	ld hl, wOTPartyMon1Status
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld d, h
	ld e, l
	ld hl, wEnemyMonStatus
	ld bc, MON_MAXHP - MON_STATUS
	call CopyBytes
	pop af

	jr c, .skiptext
	ld hl, EnemyWithdrewText
	call PrintText

.skiptext
	ld a, 1
	ld [wBattleHasJustStarted], a
	callfar NewEnemyMonStatus
	callfar ResetEnemyStatLevels
	ld hl, wPlayerSubStatus1
	res SUBSTATUS_IN_LOVE, [hl]
	farcall EnemySwitch
	farcall ResetBattleParticipants
	xor a
	ld [wBattleHasJustStarted], a
	ld a, [wLinkMode]
	and a
	ret nz
	scf
	ret

CheckSetUp:
; return carry if enemy mon has set up
; don't switch if enemy mon is already set up
; also dont switch if enemy mon low on health
	farcall AICheckEnemyQuarterHP
	jr nc, .dont_switch
	ld a, [wEnemyAtkLevel]
	cp BASE_STAT_LEVEL + 2
	jr nc, .switch
	ld a, [wEnemySAtkLevel]
	cp BASE_STAT_LEVEL + 2
	jr nc, .switch
.dont_switch
; not set up
	xor a
	ret

.switch
	scf
	ret

EnemyWithdrewText:
	text_far _EnemyWithdrewText
	text_end

TrappedByPlayerPlayer:
	ld hl, wPlayerSubStatus5
	bit SUBSTATUS_CANT_RUN, [hl]
	ret nz
	set SUBSTATUS_CANT_RUN, [hl]
	ret




























; ============
; === Note ===
; ============
; Need to remove this and everything under eventually
AI_TryItem:
	; items are not allowed in the Battle Tower
	ld a, [wInBattleTowerBattle]
	and a
	ret nz

	ld a, [wEnemyTrainerItem1]
	ld b, a
	ld a, [wEnemyTrainerItem2]
	or b
	ret z

	call .IsHighestLevel
	ret nc

	ld a, [wTrainerClass]
	dec a
	ld hl, TrainerClassAttributes + TRNATTR_AI_ITEM_SWITCH
	ld bc, NUM_TRAINER_ATTRIBUTES
	call AddNTimes
	ld b, h
	ld c, l
	ld hl, AI_Items
.loop
	ld de, wEnemyTrainerItem1
	ld a, [hl]
	and a
	inc a
	ret z

	ld a, [de]
	cp [hl]
	jr z, .has_item
	inc de
	ld a, [de]
	cp [hl]
	jr z, .has_item

	dec de
	inc hl
	inc hl
	inc hl
	jr .loop

.has_item
	inc hl

	push hl
	push de
	ld de, .callback
	push de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl
.callback
	pop de
	pop hl

	inc hl
	inc hl
	jr c, .loop

; used item
	xor a
	ld [de], a
	inc a
	ld [wEnemyGoesFirst], a

	xor a
	ld [wEnemyProtectCount], a

	xor a
	ld [wLastEnemyCounterMove], a

	scf
	ret

.IsHighestLevel:
	ld a, [wOTPartyCount]
	ld d, a
	ld e, 0
	ld hl, wOTPartyMon1Level
	ld bc, PARTYMON_STRUCT_LENGTH
.next
	ld a, [hl]
	cp e
	jr c, .ok
	ld e, a
.ok
	add hl, bc
	dec d
	jr nz, .next

	ld a, [wCurOTMon]
	ld hl, wOTPartyMon1Level
	call AddNTimes
	ld a, [hl]
	cp e
	jr nc, .yes

.yes
	scf
	ret

AI_Items:
	dbw FULL_RESTORE, .FullRestore
	dbw MAX_POTION,   .MaxPotion
	dbw HYPER_POTION, .HyperPotion
	dbw SUPER_POTION, .SuperPotion
	dbw POTION,       .Potion
	dbw X_ACCURACY,   .XAccuracy
	dbw FULL_HEAL,    .FullHeal
	dbw DIRE_HIT,     .DireHit
	db -1 ; end

.FullHeal:
	call .Status
	jmp c, .DontUse
	call EnemyUsedFullHeal
	jmp .Use

.Status:
	ld a, [wEnemyMonStatus]
	and a
	jmp z, .DontUse

	ld a, [bc]
	bit CONTEXT_USE_F, a
	jr nz, .StatusCheckContext
	ld a, [bc]
	bit ALWAYS_USE_F, a
	jmp nz, .Use
	call Random
	cp 20 percent - 1
	jmp c, .Use
	jmp .DontUse

.StatusCheckContext:
	ld a, [wEnemySubStatus5]
	bit SUBSTATUS_TOXIC, a
	jr z, .FailToxicCheck
	ld a, [wEnemyToxicCount]
	cp 4
	jr c, .FailToxicCheck
	call Random
	cp 50 percent + 1
	jmp c, .Use
.FailToxicCheck:
	ld a, [wEnemyMonStatus]
	and SLP_MASK
	jmp z, .DontUse
	jmp .Use

.FullRestore:
	call .HealItem
	jr nc, .UseFullRestore
	ld a, [bc]
	bit CONTEXT_USE_F, a
	jmp z, .DontUse
	call .Status
	jmp c, .DontUse

.UseFullRestore:
	call EnemyUsedFullRestore
	jmp .Use

.MaxPotion:
	call .HealItem
	jmp c, .DontUse
	call EnemyUsedMaxPotion
	jmp .Use

.HealItem:
	ld a, [bc]
	bit CONTEXT_USE_F, a
	jr nz, .CheckHalfOrQuarterHP
	callfar AICheckEnemyHalfHP
	jmp c, .DontUse
	ld a, [bc]
	bit UNKNOWN_USE_F, a
	jr nz, .CheckQuarterHP
	callfar AICheckEnemyQuarterHP
	jr nc, .UseHealItem
	call Random
	cp 50 percent + 1
	jr c, .UseHealItem
	jmp .DontUse

.CheckQuarterHP:
	callfar AICheckEnemyQuarterHP
	jmp c, .DontUse
	call Random
	cp 20 percent - 1
	jmp c, .DontUse
	jr .UseHealItem

.CheckHalfOrQuarterHP:
	callfar AICheckEnemyHalfHP
	jr c, .DontUse
	callfar AICheckEnemyQuarterHP
	jr nc, .UseHealItem
	call Random
	cp 20 percent - 1
	jr nc, .DontUse

.UseHealItem:
	jr .Use

.HyperPotion:
	call .HealItem
	jr c, .DontUse
	ld b, 200
	call EnemyUsedHyperPotion
	jr .Use

.SuperPotion:
	call .HealItem
	jr c, .DontUse
	ld b, 50
	call EnemyUsedSuperPotion
	jr .Use

.Potion:
	call .HealItem
	jr c, .DontUse
	ld b, 20
	call EnemyUsedPotion
	jr .Use

.XAccuracy:
	call .XItem
	jr c, .DontUse
	call EnemyUsedXAccuracy
	jr .Use

.DireHit:
	call .XItem
	jr c, .DontUse
	call EnemyUsedDireHit
	jr .Use

.XItem:
	ld a, [wEnemyTurnsTaken]
	and a
	jr nz, .notfirstturnout
	ld a, [bc]
	bit ALWAYS_USE_F, a
	jr nz, .Use
	call Random
	cp 50 percent + 1
	jr c, .DontUse
	ld a, [bc]
	bit CONTEXT_USE_F, a
	jr nz, .Use
	call Random
	cp 50 percent + 1
	jr c, .DontUse
	jr .Use
.notfirstturnout
	ld a, [bc]
	bit ALWAYS_USE_F, a
	jr z, .DontUse
	call Random
	cp 20 percent - 1
	jr nc, .DontUse
	jr .Use

.DontUse:
	scf
	ret

.Use:
	and a
	ret

AIUpdateHUD:
	call UpdateEnemyMonInParty
	farcall UpdateEnemyHUD
	ld a, $1
	ldh [hBGMapMode], a
	ld hl, wEnemyItemState
	dec [hl]
	scf
	ret

AIUsedItemSound:
	push de
	ld de, SFX_FULL_HEAL
	call PlaySFX
	pop de
	ret

EnemyUsedFullHeal:
	call AIUsedItemSound
	call AI_HealStatus
	ld a, FULL_HEAL
	jmp PrintText_UsedItemOn_AND_AIUpdateHUD

EnemyUsedMaxPotion:
	ld a, MAX_POTION
	ld [wCurEnemyItem], a
	jr FullRestoreContinue

EnemyUsedFullRestore:
	call AI_HealStatus
	ld a, FULL_RESTORE
	ld [wCurEnemyItem], a
	; fallthrough

FullRestoreContinue:
	ld de, wCurHPAnimOldHP
	ld hl, wEnemyMonHP + 1
	ld a, [hld]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	inc de
	ld hl, wEnemyMonMaxHP + 1
	ld a, [hld]
	ld [de], a
	inc de
	ld [wCurHPAnimMaxHP], a
	ld [wEnemyMonHP + 1], a
	ld a, [hl]
	ld [de], a
	ld [wCurHPAnimMaxHP + 1], a
	ld [wEnemyMonHP], a
	jr EnemyPotionFinish

EnemyUsedPotion:
	ld a, POTION
	ld b, 20
	jr EnemyPotionContinue

EnemyUsedSuperPotion:
	ld a, SUPER_POTION
	ld b, 50
	jr EnemyPotionContinue

EnemyUsedHyperPotion:
	ld a, HYPER_POTION
	ld b, 200

EnemyPotionContinue:
	ld [wCurEnemyItem], a
	ld hl, wEnemyMonHP + 1
	ld a, [hl]
	ld [wCurHPAnimOldHP], a
	add b
	ld [hld], a
	ld [wCurHPAnimNewHP], a
	ld a, [hl]
	ld [wCurHPAnimOldHP + 1], a
	ld [wCurHPAnimNewHP + 1], a
	jr nc, .ok
	inc a
	ld [hl], a
	ld [wCurHPAnimNewHP + 1], a
.ok
	inc hl
	ld a, [hld]
	ld b, a
	ld de, wEnemyMonMaxHP + 1
	ld a, [de]
	dec de
	ld [wCurHPAnimMaxHP], a
	sub b
	ld a, [hli]
	ld b, a
	ld a, [de]
	ld [wCurHPAnimMaxHP + 1], a
	sbc b
	jr nc, EnemyPotionFinish
	inc de
	ld a, [de]
	dec de
	ld [hld], a
	ld [wCurHPAnimNewHP], a
	ld a, [de]
	ld [hl], a
	ld [wCurHPAnimNewHP + 1], a

EnemyPotionFinish:
	call PrintText_UsedItemOn
	hlcoord 2, 2
	xor a
	ld [wWhichHPBar], a
	call AIUsedItemSound
	predef AnimateHPBar
	jmp AIUpdateHUD

AI_HealStatus:
	ld a, [wCurOTMon]
	ld hl, wOTPartyMon1Status
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	xor a
	ld [hl], a
	ld [wEnemyMonStatus], a
	ld hl, wEnemySubStatus1
 	res SUBSTATUS_NIGHTMARE, [hl]
 	ld [wEnemyConfuseCount], a
 	ld hl, wEnemySubStatus3
 	res SUBSTATUS_CONFUSED, [hl]	
	ld hl, wEnemySubStatus5
	res SUBSTATUS_TOXIC, [hl]
	ret

EnemyUsedXAccuracy:
	call AIUsedItemSound
	ld hl, wEnemySubStatus4
	set SUBSTATUS_X_ACCURACY, [hl]
	ld a, X_ACCURACY
	jr PrintText_UsedItemOn_AND_AIUpdateHUD

EnemyUsedDireHit:
	call AIUsedItemSound
	ld hl, wEnemySubStatus4
	set SUBSTATUS_FOCUS_ENERGY, [hl]
	ld a, DIRE_HIT
	jr PrintText_UsedItemOn_AND_AIUpdateHUD

; Parameter
; a = ITEM_CONSTANT
PrintText_UsedItemOn_AND_AIUpdateHUD:
	ld [wCurEnemyItem], a
	call PrintText_UsedItemOn
	jmp AIUpdateHUD

PrintText_UsedItemOn:
	ld a, [wCurEnemyItem]
	ld [wNamedObjectIndex], a
	call GetItemName
	ld hl, wStringBuffer1
	ld de, wMonOrItemNameBuffer
	ld bc, ITEM_NAME_LENGTH
	call CopyBytes
	ld hl, EnemyUsedOnText
	jmp PrintText

EnemyUsedOnText:
	text_far _EnemyUsedOnText
	text_end
