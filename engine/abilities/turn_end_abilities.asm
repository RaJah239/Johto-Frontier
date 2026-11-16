MACRO turn_end_ability
; \1 = species list, \2 = WEATHER_* it needs (or ANY_WEATHER), \3 = activation
; \4 = SILENT for an ability without a popup: Neutralizing Gas simply turns it
; off (the others show its popup instead of theirs, in the activation)
	ld hl, \1
	IF _NARG > 3
	lb bc, TRUE | TURN_END_SILENT, \2 ; not the turn its mon was sent out
	ELSE
	lb bc, TRUE, \2 ; not the turn its mon was sent out
	ENDC
	ld de, \3
	call TurnEndAbilityBothSides
ENDM

DEF TURN_END_SILENT EQU %10

DEF ANY_WEATHER EQU -1

TurnEndAbilities:
	turn_end_ability RecoveryPokemon,       ANY_WEATHER,       Recovery_Activate
	turn_end_ability SpeedBoostPokemon,     ANY_WEATHER,       SpeedBoost_Activate
	turn_end_ability HydrationPokemon,      WEATHER_RAIN,      Hydration_Activate, SILENT
	turn_end_ability IceBodyPokemon,        WEATHER_HAIL,      IceBody_Activate, SILENT
	turn_end_ability RainDishPokemon,       WEATHER_RAIN,      RainDish_Activate, SILENT
	turn_end_ability SandBodyPokemon,       WEATHER_SANDSTORM, SandBody_Activate, SILENT
	turn_end_ability TenacityPokemon,       ANY_WEATHER,       Tenacity_Activate
	turn_end_ability PhotosynthesisPokemon, WEATHER_SUN,       Photosynthesis_Activate, SILENT
	turn_end_ability HarvestPokemon,        ANY_WEATHER,       Harvest_Activate
	ret

; handle boosted attack in engine/abilities/boosting_abilities.asm
HandleSolarPowerHPLoss:
; (activates the turn its mon is sent out too)
	ld hl, SolarPowerHPLossPokemon
	lb bc, FALSE, WEATHER_SUN
	ld de, SolarPowerHPLoss_Activate
	; fallthrough

TurnEndAbilityBothSides:
; For each side (hBattleTurn), the player's first unless this is the external
; clock side of a link battle: if its mon is in species list hl, the weather is
; c (or c is ANY_WEATHER) and, when b is TRUE, the mon wasn't sent out this
; turn, jump to de with hBattleTurn set to that side.
	ldh a, [hSerialConnectionStatus]
	cp USING_EXTERNAL_CLOCK
	ld a, 0 ; player first
	jr nz, .got_first
	inc a ; enemy first
.got_first
	push af
	call .Side
	pop af
	xor 1
.Side:
	push hl
	push de
	push bc
	ldh [hBattleTurn], a
	call .Check
	pop bc
	pop de
	pop hl
	ret

.Check:
	ld a, c
	cp ANY_WEATHER
	jr z, .weather_ok
	ld a, [wBattleWeather]
	cp c
	ret nz
.weather_ok
	push de
	push hl
	bit 0, b
	jr z, .species
	push bc
	farcall SentOutThisTurn
	pop bc
	jr nz, .no
.species
	call GetCurrentMon
	pop hl
	bit 1, b ; TURN_END_SILENT
	jr z, .raw
	call IsInAbilityList
	jr .listed
.raw
	call IsInByteArray
.listed
	pop hl ; activation
	ret nc
	jp hl

.no
	pop hl
	pop de
	ret

Recovery_Activate:
	call TurnEndAbility_AtMaxHP
	ret z
	ShowActivationOrEntryOrKOAbilityPopup RecoveryText
	ld hl, BattleText_TargetRegenerates
	call StdBattleTextbox
	; fallthrough

TurnEndAbility_HealSixteenth:
	farcall GetSixteenthMaxHP
	farcall SwitchTurnCore
	farjp RestoreHP

Photosynthesis_Activate:
	ld hl, PhotosynthesisText
	jr TurnEndAbility_HealWithText

IceBody_Activate:
	ld hl, IceBodyText
	jr TurnEndAbility_HealWithText

RainDish_Activate:
	ld hl, RainDishText
	jr TurnEndAbility_HealWithText

SandBody_Activate:
	ld hl, SandBodyText
	; fallthrough

TurnEndAbility_HealWithText:
; Unless the current side's mon is at max HP: heal 1/16 of it, then text hl.
	push hl
	call TurnEndAbility_AtMaxHP
	jr z, .done
	call TurnEndAbility_HealSixteenth
	pop hl
	jmp StdBattleTextbox

.done
	pop hl
	ret

TurnEndAbility_AtMaxHP:
; z if the current side's (hBattleTurn) mon is at max HP
	ld hl, wBattleMonHP
	ldh a, [hBattleTurn]
	and a
	jr z, .got_hp
	ld hl, wEnemyMonHP
.got_hp
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld c, a
	ld a, [hli]
	cp b
	ret nz
	ld a, [hl]
	cp c
	ret

TurnEndAbility_CureStatus:
; Cure the current side's mon's status; z if it had none.
	ld a, BATTLE_VARS_STATUS
	call GetBattleVarAddr
	and a
	ret z
	ld [hl], 0
	ret

Hydration_Activate:
	call TurnEndAbility_CureStatus
	ret z
	ld hl, HydrationHealingText
	jmp StdBattleTextbox

Tenacity_Activate:
	call Random
	cp 33 percent + 1
	ret nc ; 1/3 chance
	ld a, BATTLE_VARS_STATUS
	call GetBattleVar
	and a
	ret z
	ShowActivationOrEntryOrKOAbilityPopup TenacityText
	call TurnEndAbility_CureStatus
	ld hl, TenacityHealingText
	jmp StdBattleTextbox

SpeedBoost_Activate:
	ShowActivationOrEntryOrKOAbilityPopup SpeedBoostText
	ld b, SPEED
	farcall BattleCommand_StatUp
	farjp BattleCommand_StatUpMessage

; ========================
; === Ability: Harvest ===
; ========================
RecordHarvestBerry::
; Item a, a Berry or not, was just used up by the other side's mon (not
; hBattleTurn's: see ConsumeHeldItem). Remember it if it's a Berry.
; Preserves bc, de, hl.
	push hl
	push de
	push bc
	ld hl, HarvestBerries
	call IsInByteArray
	jr nc, .done
	ld b, a
	ld hl, wHarvestBerries
	ldh a, [hBattleTurn]
	and a
	jr nz, .got_side ; the enemy's turn: the player's mon used it
	inc hl
.got_side
	ld [hl], b
.done
	jmp PopBCDEHL

HarvestBerries:
	db BERRY
	db GOLD_BERRY
	db SILVER_BERRY
	db MYSTERYBERRY
	db MIRACLEBERRY
	db PSNCUREBERRY
	db PRZCUREBERRY
	db BURNT_BERRY
	db ICE_BERRY
	db BITTER_BERRY
	db MINT_BERRY
	db -1 ; end

Harvest_Activate:
; If the mon used a Berry and holds nothing now, regrow it: 50%, or always
; in the sun.
	ld hl, wHarvestBerries
	ld de, wBattleMonItem
	ldh a, [hBattleTurn]
	and a
	jr z, .got_side
	inc hl
	ld de, wEnemyMonItem
.got_side
	ld a, [hl]
	and a
	ret z ; no Berry used
	ld a, [de]
	and a
	ret nz ; holding something
	ld a, [wBattleWeather]
	cp WEATHER_SUN
	jr z, .regrow
	call BattleRandom ; (link battles stay in sync)
	cp 50 percent
	ret nc

.regrow
	push hl
	push de
	ShowActivationOrEntryOrKOAbilityPopup HarvestText, KEEP
	pop de
	pop hl
	ret c ; suppressed by Neutralizing Gas
	ld a, [hl]
	ld [de], a
	ld [hl], 0
	ld [wNamedObjectIndex], a
	ld b, a
	; and in the party (not a wild mon's)
	ldh a, [hBattleTurn]
	and a
	ld hl, wPartyMon1Item
	ld a, [wCurBattleMon]
	jr z, .got_party
	ld a, [wBattleMode]
	dec a
	jr z, .regrown ; wild
	ld hl, wOTPartyMon1Item
	ld a, [wCurOTMon]
.got_party
	push bc
	call GetPartyLocation
	pop bc
	ld [hl], b
.regrown
	call GetItemName
	farcall RefreshBattleHuds
	ld hl, HarvestBattleText
	jmp StdBattleTextbox

SolarPowerHPLoss_Activate:
	ShowOncePerSendOutPopup SEND_OUT_POPUP_SOLAR_POWER_HP_LOSS, SolarPowerHPLossText
	; subtract 1/8 max hp end of each turn
	farcall GetEighthMaxHP
	farcall SubtractHPFromUser
	ld hl, SolarPowerBattleText
	jmp StdBattleTextbox

; =============================
; === Ability: Poison Heal ===
; =============================
PoisonHeal::
; Called by ResidualDamage for a poisoned mon (hBattleTurn). If it has Poison
; Heal, it heals instead of losing HP: 1/8 of its max HP, or with Toxic the
; amount it would have lost (Toxic's counter still goes up). Return carry
; then, so no poison damage is done.
	call GetCurrentMon
	ld hl, PoisonHealPokemon
	call IsInAbilityListNG
	ret nc

	ld a, BATTLE_VARS_SUBSTATUS5
	call GetBattleVar
	bit SUBSTATUS_TOXIC, a
	jr nz, .toxic
	farcall GetEighthMaxHP
	jr .got_amount

.toxic
	ld hl, wPlayerToxicCount
	ldh a, [hBattleTurn]
	and a
	jr z, .got_count
	ld hl, wEnemyToxicCount
.got_count
	inc [hl]
	push hl
	farcall GetSixteenthMaxHP
	pop hl
	ld a, [hl]
	ld hl, 0
.add
	add hl, bc
	dec a
	jr nz, .add
	ld b, h
	ld c, l
.got_amount
	push bc
	call TurnEndAbility_AtMaxHP
	pop bc
	jr z, .done ; nothing to heal, but no damage either
	push bc
	farcall EmptyBattleTextbox ; clear the last move's text first
	ShowActivationOrEntryOrKOAbilityPopup PoisonHealText
	farcall SwitchTurnCore
	pop bc
	farcall RestoreHP ; heals the other side's (hBattleTurn's original) mon
	farcall SwitchTurnCore
	ld hl, PoisonHealBattleText
	call StdBattleTextbox
.done
	scf
	ret

IsPoisonHealSpecies::
; Carry if species a has Poison Heal (for the AI). Preserves bc, de, hl.
	push hl
	push de
	push bc
	ld hl, PoisonHealPokemon
	call IsInAbilityList
	jmp PopBCDEHL

PoisonHealText: db "Poison Heal@"

RecoveryText: db "Recovery@"
SpeedBoostText: db "Speed Boost@"
HarvestText:    db "Harvest@"
TenacityText: db "Tenacity@"
SolarPowerHPLossText: db "SolarPower@"

SolarPowerHPLossPokemon:
	db SUNKERN
	db SUNFLORA
	db TROPIUS
	db CHARMANDER
	db CHARMELEON
	db CHARIZARD
	db -1 ; end

INCLUDE "data/abilities/recovery_mons.asm"
INCLUDE "data/abilities/speed_boost_mons.asm"
HydrationPokemon:
INCLUDE "data/abilities/hydration_mons.asm"
IceBodyPokemon:
INCLUDE "data/abilities/ice_body_mons.asm"
RainDishPokemon:
INCLUDE "data/abilities/rain_dish_mons.asm"
SandBodyPokemon:
INCLUDE "data/abilities/sand_body_mons.asm"
INCLUDE "data/abilities/tenacity_mons.asm"
PhotosynthesisPokemon:
INCLUDE "data/abilities/photosynthesis_mons.asm"
INCLUDE "data/abilities/poison_heal_mons.asm"
INCLUDE "data/abilities/harvest_mons.asm"
