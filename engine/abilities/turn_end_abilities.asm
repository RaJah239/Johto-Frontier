MACRO turn_end_ability
; \1 = species list, \2 = WEATHER_* it needs (or ANY_WEATHER), \3 = activation
	ld hl, \1
	lb bc, TRUE, \2 ; not the turn its mon was sent out
	ld de, \3
	call TurnEndAbilityBothSides
ENDM

DEF ANY_WEATHER EQU -1

TurnEndAbilities:
	turn_end_ability RecoveryPokemon,       ANY_WEATHER,       Recovery_Activate
	turn_end_ability SpeedBoostPokemon,     ANY_WEATHER,       SpeedBoost_Activate
	turn_end_ability HydrationPokemon,      WEATHER_RAIN,      Hydration_Activate
	turn_end_ability IceBodyPokemon,        WEATHER_HAIL,      IceBody_Activate
	turn_end_ability RainDishPokemon,       WEATHER_RAIN,      RainDish_Activate
	turn_end_ability SandBodyPokemon,       WEATHER_SANDSTORM, SandBody_Activate
	turn_end_ability TenacityPokemon,       ANY_WEATHER,       Tenacity_Activate
	turn_end_ability PhotosynthesisPokemon, WEATHER_SUN,       Photosynthesis_Activate
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
	ld a, b
	and a
	jr z, .species
	farcall SentOutThisTurn
	jr nz, .no
.species
	call GetCurrentMon
	pop hl
	call IsInByteArray
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
	ld hl, BattleText_TargetRegenerates
	call StdBattleTextbox
	ShowActivationOrEntryOrKOAbilityPopup RecoveryText
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
	call TurnEndAbility_CureStatus
	ret z
	ld hl, TenacityHealingText
	call StdBattleTextbox
	ShowActivationOrEntryOrKOAbilityPopup TenacityText
	ret

SpeedBoost_Activate:
	ShowActivationOrEntryOrKOAbilityPopup SpeedBoostText
	ld b, SPEED
	farcall BattleCommand_StatUp
	farjp BattleCommand_StatUpMessage

SolarPowerHPLoss_Activate:
	ShowOncePerSendOutPopup SEND_OUT_POPUP_SOLAR_POWER_HP_LOSS, SolarPowerHPLossText
	; subtract 1/8 max hp end of each turn
	farcall GetEighthMaxHP
	farcall SubtractHPFromUser
	ld hl, SolarPowerBattleText
	jmp StdBattleTextbox

RecoveryText: db "Recovery@"
SpeedBoostText: db "Speed Boost@"
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
INCLUDE "data/abilities/hydration_mons.asm"
INCLUDE "data/abilities/ice_body_mons.asm"
INCLUDE "data/abilities/rain_dish_mons.asm"
INCLUDE "data/abilities/sand_body_mons.asm"
INCLUDE "data/abilities/tenacity_mons.asm"
INCLUDE "data/abilities/photosynthesis_mons.asm"
