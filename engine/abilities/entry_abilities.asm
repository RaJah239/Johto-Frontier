; Entry abilities: abilities that activate when their mon comes onto the field.
;
; Each side has a "pending" bit in wEntryAbilitiesPending. A side's bit is set
; whenever it sends out a mon (SpikesDamage calls QueueEntryAbilities). The
; abilities of the pending sides only run once BOTH sides have a mon on the
; field: e.g. after a double KO the player sends out first, and its mon waits
; until the foe's mon is out, so Intimidate never hits an empty field.
;
; When both sides are pending (battle start, double KO) they run in the same
; order on both Game Boys in a link battle: the internal clock player's mon
; first (that's "player" on its Game Boy and "enemy" on the other one), the
; same order the link battle code uses for everything else.

DEF ENTRY_ABILITIES_PLAYER_F EQU 0
DEF ENTRY_ABILITIES_ENEMY_F  EQU 1

DEF HAZARDS_MASK EQU 1 << SCREENS_SPIKES | 1 << SCREENS_STEALTH_ROCK | 1 << SCREENS_TOXIC_SPIKES | 1 << SCREENS_STICKY_WEB

StartBattleEntryAbilities::
; Both sides' first mons are out: run their entry abilities.
	ld a, (1 << ENTRY_ABILITIES_PLAYER_F) | (1 << ENTRY_ABILITIES_ENEMY_F)
	ld [wEntryAbilitiesPending], a
	jr RunPendingEntryAbilities

QueueEntryAbilities::
; The hBattleTurn side has just sent out a mon.
	ld hl, wEntryAbilitiesPending
	ldh a, [hBattleTurn]
	and a
	jr nz, .enemy
	set ENTRY_ABILITIES_PLAYER_F, [hl]
	jr .queued
.enemy
	set ENTRY_ABILITIES_ENEMY_F, [hl]
.queued
	; at the start of a battle, wait until DoBattle has sent out both mons
	ld a, [wBattleHasJustStarted]
	and a
	ret nz
	; fallthrough

RunPendingEntryAbilities:
	ld a, [wEntryAbilitiesPending]
	and a
	ret z
	; both sides need a mon on the field
	ld hl, wBattleMonHP
	ld a, [hli]
	or [hl]
	ret z
	ld hl, wEnemyMonHP
	ld a, [hli]
	or [hl]
	ret z

	ldh a, [hBattleTurn]
	push af
	call ClearSprites
	ldh a, [hSerialConnectionStatus]
	cp USING_EXTERNAL_CLOCK
	jr z, .enemy_first
	call .player
	call .enemy
	jr .done

.enemy_first
	call .enemy
	call .player
.done
	pop af
	ldh [hBattleTurn], a
	ret

.player
	ld hl, wEntryAbilitiesPending
	bit ENTRY_ABILITIES_PLAYER_F, [hl]
	ret z
	res ENTRY_ABILITIES_PLAYER_F, [hl]
	xor a ; player's turn
	jr RunEntryAbilities

.enemy
	ld hl, wEntryAbilitiesPending
	bit ENTRY_ABILITIES_ENEMY_F, [hl]
	ret z
	res ENTRY_ABILITIES_ENEMY_F, [hl]
	ld a, 1 ; enemy's turn
	; fallthrough

RunEntryAbilities:
; Run every entry ability handler for side a.
	ld hl, EntryAbilityHandlers
.loop
	push af
	ldh [hBattleTurn], a
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	or e
	jr z, .done
	push hl
	; clear any stale failure flags so the stat changes always apply
	xor a
	ld [wFailedMessage], a
	ld [wEffectFailed], a
	ld [wAttackMissed], a
	call _de_
	pop hl
	pop af
	jr .loop

.done
	pop af
	ret

EntryAbilityHandlers:
	dw HandleSpinGuard
	dw HandleDrizzle
	dw HandleDrought
	dw HandleSandStream
	dw HandleSnowWarning
	dw HandleNaturalCure
	dw HandleSeedfall
	dw HandleDefenseMode
	dw HandleIntimidate
	dw HandleCleanSweep
	dw HandleLightBarrier
	dw HandleRockSnare
	dw HandleCaltropper
	dw HandleVenomField
	dw HandleSilkSnare
	dw HandleChronoShift
	dw HandleFortify
	dw HandleImposter
	dw HandleReflectBarrier
	dw HandleInfernalHowl
	dw HandleBattleStance
	dw HandleBattleDrive
	dw HandleTrueSight
	dw HandleFogOfWar
	dw HandleChaoticBoost
	dw HandleSanctuary
	dw HandleSiegebreaker
	dw HandleProvocateur
	dw HandleDisarm
	dw HandleAllure
	dw 0 ; end

; ===============
; === Helpers ===
; ===============

CurMonInList:
; Return carry if the hBattleTurn side's mon is in species list hl.
	push hl
	call GetCurrentMon
	pop hl
	jmp IsInByteArray

ShowEntryAbilityPopup:
; Slide in ability name de (in this bank) over the user's HUD. Preserves hl.
	ld b, BANK(@)
	ldh a, [hBattleTurn]
	ld c, a ; ABILITY_POPUP_PLAYER / ABILITY_POPUP_ENEMY
	push hl
	farcall ShowAbilityPopup
	pop hl
	ret

PlayEntryAbilityAnim:
; Play animation de unless battle animations are off. Preserves hl.
	ld a, [wOptions]
	bit BATTLE_SCENE, a
	ret nz
	push hl
	farcall Call_PlayBattleAnim
	pop hl
	ret

PlayEntryAnimAndText:
; Play animation de, then print text hl.
	call PlayEntryAbilityAnim
	jmp StdBattleTextbox

GetUserScreens:
; hl = the hBattleTurn side's wPlayerScreens/wEnemyScreens
	ld hl, wPlayerScreens
	ldh a, [hBattleTurn]
	and a
	ret z
	ld hl, wEnemyScreens
	ret

GetTargetScreens:
	ld hl, wEnemyScreens
	ldh a, [hBattleTurn]
	and a
	ret z
	ld hl, wPlayerScreens
	ret

EitherSideScreens:
; Return nz if either side has any of the screens in mask b up.
	ld a, [wPlayerScreens]
	ld c, a
	ld a, [wEnemyScreens]
	or c
	and b
	ret

; ===============
; === Weather ===
; ===============

SetEntryWeather:
; Set weather a for 255 turns. Return z if that weather was already up.
	ld hl, wBattleWeather
	cp [hl]
	ret z
	ld [hl], a
	ld a, 255
	ld [wWeatherCount], a
	ret ; nz

HandleDrizzle:
	ld hl, DrizzlePokemon
	call CurMonInList
	ret nc
	ld a, WEATHER_RAIN
	call SetEntryWeather
	ret z
	ld de, DrizzlePopupText
	jr ShowEntryAbilityPopup

DrizzlePopupText: db "Drizzle@"

INCLUDE "data/abilities/drizzle_mons.asm"

HandleDrought:
	ld hl, DroughtPokemon
	call CurMonInList
	ret nc
	ld a, WEATHER_SUN
	call SetEntryWeather
	ret z
	ld de, DroughtPopupText
	call ShowEntryAbilityPopup
	ld hl, BattleText_DroughtText
	jmp StdBattleTextbox

INCLUDE "data/abilities/drought_mons.asm"

HandleSandStream:
	ld hl, SandStreamPokemon
	call CurMonInList
	ret nc
	ld a, WEATHER_SANDSTORM
	call SetEntryWeather
	ret z
	ld de, SandStreamPopupText
	call ShowEntryAbilityPopup
	ld hl, BattleText_SandStreamText
	jmp StdBattleTextbox

INCLUDE "data/abilities/sand_stream_mons.asm"

HandleSnowWarning:
	ld hl, SnowWarningPokemon
	call CurMonInList
	ret nc
	ld a, WEATHER_HAIL
	call SetEntryWeather
	ret z
	ld de, SnowWarningPopupText
	call ShowEntryAbilityPopup
	ld hl, BattleText_SnowWarningText
	jmp StdBattleTextbox

INCLUDE "data/abilities/snow_warning_mons.asm"

; ===================
; === Own effects ===
; ===================

HandleSpinGuard:
	ld hl, SpinGuardPokemon
	call CurMonInList
	ret nc
	ld b, HAZARDS_MASK
	call EitherSideScreens
	ret z
	ld de, SpinGuardPopupText
	call ShowEntryAbilityPopup
	callfar BattleCommand_ClearHazards
	ld de, ANIM_SPIN_GUARD
	ld hl, BlewSpikesText
	jmp PlayEntryAnimAndText

INCLUDE "data/abilities/spin_guard_mons.asm"

HandleNaturalCure:
	ld hl, NaturalCurePokemon
	call CurMonInList
	ret nc
	ld a, BATTLE_VARS_STATUS
	call GetBattleVarAddr
	and a
	jr z, .done
	ld de, NaturalCurePopupText
	call ShowEntryAbilityPopup
	ld [hl], 0
	farcall SwitchTurnCore
	farcall ItemRecoveryAnim
	farcall SwitchTurnCore
	ld hl, BecameHealthyText
	call StdBattleTextbox
.done
	farjp CalcPokemonStats

INCLUDE "data/abilities/natural_cure_mons.asm"

HandleDefenseMode:
	ld hl, DefenseModePokemon
	call CurMonInList
	ret nc
	ld de, DefenseModePopupText
	call ShowEntryAbilityPopup
	farcall BattleCommand_DefenseUp2
	farcall BattleCommand_StatUpMessage
	farcall BattleCommand_SpecialDefenseUp2
	farcall BattleCommand_StatUpMessage
	ld hl, DefenseModeText
	jmp StdBattleTextbox

DefenseModePopupText: db "Defense!@"

INCLUDE "data/abilities/defense_mode_mons.asm"

HandleBattleStance:
	ld hl, BattleStancePokemon
	call CurMonInList
	ret nc
	ld de, BattleStancePopupText
	call ShowEntryAbilityPopup
	ld hl, BattleStanceText
	call StdBattleTextbox
	farcall BattleCommand_DefenseUp
	farjp BattleCommand_StatUpMessage

INCLUDE "data/abilities/battle_stance_mons.asm"

HandleBattleDrive:
	ld hl, BattleDrivePokemon
	call CurMonInList
	ret nc
	ld de, BattleDrivePopupText
	call ShowEntryAbilityPopup
	ld hl, BattleDriveText
	call StdBattleTextbox
	farcall BattleCommand_AttackUp
	farjp BattleCommand_StatUpMessage

INCLUDE "data/abilities/battle_drive_mons.asm"

HandleChaoticBoost:
	ld hl, ChaoticBoostPokemon
	call CurMonInList
	ret nc
	ld de, ChaoticBoostPopupText
	call ShowEntryAbilityPopup
	ld hl, ChaoticBoostText
	call StdBattleTextbox
	call BattleRandom
	cp 43
	jr c, .AtkUp
	cp 86
	jr c, .DefUp
	cp 129
	jr c, .SpAtkUp
	cp 172
	jr c, .SpDefUp
	cp 215
	jr c, .SpdUp
	farcall BattleCommand_EvasionUp
	farjp BattleCommand_StatUpMessage

.AtkUp
	farcall BattleCommand_AttackUp
	farjp BattleCommand_StatUpMessage

.DefUp
	farcall BattleCommand_DefenseUp
	farjp BattleCommand_StatUpMessage

.SpAtkUp
	farcall BattleCommand_SpecialAttackUp
	farjp BattleCommand_StatUpMessage

.SpDefUp
	farcall BattleCommand_SpecialDefenseUp
	farjp BattleCommand_StatUpMessage

.SpdUp
	farcall BattleCommand_SpeedUp
	farjp BattleCommand_StatUpMessage

INCLUDE "data/abilities/chaotic_boost_mons.asm"

HandleFortify:
	ld hl, FortifyPokemon
	call CurMonInList
	ret nc
	ld de, FortifyPopupText
	call ShowEntryAbilityPopup
	ld de, BARRIER
	ld hl, FortifyText
	call PlayEntryAnimAndText
	farjp BattleCommand_Barrier

INCLUDE "data/abilities/fortify_mons.asm"

HandleImposter:
	ld hl, ImposterPokemon
	call CurMonInList
	ret nc
	ld de, ImposterPopupText
	call ShowEntryAbilityPopup
	ld de, TRANSFORM
	ld hl, ImposterText
	call PlayEntryAnimAndText
	farjp BattleCommand_Transform

INCLUDE "data/abilities/imposter_mons.asm"

; ===============
; === Screens ===
; ===============

HandleReflectBarrier:
	ld hl, ReflectBarrierPokemon
	call CurMonInList
	ret nc
	ld a, 1 << SCREENS_REFLECT
	ld bc, wPlayerReflectCount
	ld de, wEnemyReflectCount
	call SetEntryScreen
	ret z
	ld de, ReflectBarrierPopupText
	call ShowEntryAbilityPopup
	ld de, REFLECT
	ld hl, ReflectBarrierText
	jmp PlayEntryAnimAndText

INCLUDE "data/abilities/reflect_barrier_mons.asm"

HandleLightBarrier:
	ld hl, LightBarrierPokemon
	call CurMonInList
	ret nc
	ld a, 1 << SCREENS_LIGHT_SCREEN
	ld bc, wPlayerLightScreenCount
	ld de, wEnemyLightScreenCount
	call SetEntryScreen
	ret z
	ld de, LightBarrierPopupText
	call ShowEntryAbilityPopup
	ld de, LIGHT_SCREEN
	ld hl, LightBarrierText
	jmp PlayEntryAnimAndText

INCLUDE "data/abilities/light_barrier_mons.asm"

SetEntryScreen:
; Put up screen mask a on the user's side for 5 turns.
; bc = the player's turn counter, de = the enemy's. Return z if already up.
	push af
	ldh a, [hBattleTurn]
	and a
	jr z, .got_counter
	ld b, d
	ld c, e
.got_counter
	call GetUserScreens
	pop de ; d = mask
	ld a, [hl]
	and d
	jr nz, .already_up
	ld a, [hl]
	or d
	ld [hl], a
	ld a, 5
	ld [bc], a
	ret ; nz

.already_up
	xor a
	ret

HandleSanctuary:
	ld hl, SanctuaryPokemon
	call CurMonInList
	ret nc
	call GetUserScreens
	bit SCREENS_SAFEGUARD, [hl]
	ret nz
	ld de, SanctuaryPopupText
	call ShowEntryAbilityPopup
	ld de, SAFEGUARD
	call PlayEntryAbilityAnim
	farjp BattleCommand_Safeguard ; prints its own text

INCLUDE "data/abilities/sanctuary_mons.asm"

HandleSiegebreaker:
	ld hl, SiegebreakerPokemon
	call CurMonInList
	ret nc
	ld b, 1 << SCREENS_REFLECT | 1 << SCREENS_LIGHT_SCREEN
	call EitherSideScreens
	ret z
	ld de, SiegebreakerPopupText
	call ShowEntryAbilityPopup
	ld de, BRICK_BREAK
	ld hl, SiegebreakerText
	call PlayEntryAnimAndText
	farjp BattleCommand_BreakScreens

INCLUDE "data/abilities/siegebreaker_mons.asm"

HandleCleanSweep:
	ld hl, CleanSweepPokemon
	call CurMonInList
	ret nc
	; any weather or any screen/hazard on either side
	ld a, [wFieldWeather]
	ld b, a
	ld a, [wBattleWeather]
	or b ; WEATHER_NONE
	jr nz, .sweep
	ld b, $ff ; every SCREENS_* bit
	call EitherSideScreens
	ret z
.sweep
	ld de, CleanSweepPopupText
	call ShowEntryAbilityPopup
	ld de, DEFOG
	ld hl, CleanSweepText
	call PlayEntryAnimAndText
	farjp BattleCommand_Defog

INCLUDE "data/abilities/clean_sweep_mons.asm"

; ===============
; === Hazards ===
; ===============

HandleRockSnare:
	ld hl, RockSnarePokemon
	call CurMonInList
	ret nc
	ld b, 1 << SCREENS_STEALTH_ROCK
	call SetEntryHazard
	ret z
	ld de, RockSnarePopupText
	call ShowEntryAbilityPopup
	ld de, STEALTH_ROCK
	ld hl, RockSnareText
	jmp PlayEntryAnimAndText

INCLUDE "data/abilities/rock_snare_mons.asm"

HandleCaltropper:
	ld hl, CaltropperPokemon
	call CurMonInList
	ret nc
	ld b, 1 << SCREENS_SPIKES
	call SetEntryHazard
	ret z
	ld de, CaltropperPopupText
	call ShowEntryAbilityPopup
	ld de, SPIKES
	ld hl, CaltropperText
	jmp PlayEntryAnimAndText

INCLUDE "data/abilities/caltropper_mons.asm"

HandleVenomField:
	ld hl, VenomFieldPokemon
	call CurMonInList
	ret nc
	ld b, 1 << SCREENS_TOXIC_SPIKES
	call SetEntryHazard
	ret z
	ld de, VenomFieldPopupText
	call ShowEntryAbilityPopup
	ld de, TOXIC_SPIKES
	ld hl, VenomFieldText
	jmp PlayEntryAnimAndText

INCLUDE "data/abilities/venom_field_mons.asm"

HandleSilkSnare:
	ld hl, SilkSnarePokemon
	call CurMonInList
	ret nc
	ld b, 1 << SCREENS_STICKY_WEB
	call SetEntryHazard
	ret z
	ld de, SilkSnarePopupText
	call ShowEntryAbilityPopup
	ld de, STICKY_WEB
	ld hl, SilkSnareText
	jmp PlayEntryAnimAndText

INCLUDE "data/abilities/silk_snare_mons.asm"

SetEntryHazard:
; Lay hazard mask b on the target's side. Return z if it was already there.
	call GetTargetScreens
	ld a, [hl]
	and b
	jr nz, .already_up
	ld a, [hl]
	or b
	ld [hl], a
	ret ; nz

.already_up
	xor a
	ret

; =========================
; === Effects on target ===
; =========================

HandleIntimidate:
	ld hl, IntimidatePokemon
	call CurMonInList
	ret nc
	ld de, IntimidatePopupText
	call ShowEntryAbilityPopup
	ld de, LEER
	call PlayEntryAbilityAnim
	farcall BattleCommand_AttackDown
	farjp BattleCommand_StatDownMessage

IntimidatePopupText: db "Intimidate@"

INCLUDE "data/abilities/intimidate_mons.asm"

HandleInfernalHowl:
	ld hl, InfernalHowlPokemon
	call CurMonInList
	ret nc
	ld de, InfernalHowlPopupText
	call ShowEntryAbilityPopup
	ld de, GROWL
	ld hl, InfernalHowlText
	call PlayEntryAnimAndText
	farcall BattleCommand_SpecialAttackDown
	farjp BattleCommand_StatDownMessage

INCLUDE "data/abilities/infernal_howl_mons.asm"

HandleSeedfall:
	ld hl, SeedfallPokemon
	call CurMonInList
	ret nc
	; skip if the target is already seeded
	ld a, BATTLE_VARS_SUBSTATUS4_OPP
	call GetBattleVarAddr
	bit SUBSTATUS_LEECH_SEED, [hl]
	ret nz
	ld de, SeedfallPopupText
	call ShowEntryAbilityPopup
	ld de, LEECH_SEED
	call PlayEntryAbilityAnim
	farjp BattleCommand_LeechSeed

INCLUDE "data/abilities/seedfall_mons.asm"

HandleTrueSight:
	ld hl, TrueSightPokemon
	call CurMonInList
	ret nc
	ld de, TrueSightPopupText
	call ShowEntryAbilityPopup
	ld de, FORESIGHT
	ld hl, TrueSightText
	call PlayEntryAnimAndText
	farjp BattleCommand_Foresight

INCLUDE "data/abilities/true_sight_mons.asm"

HandleFogOfWar:
	ld hl, FogOfWarPokemon
	call CurMonInList
	ret nc
	; only if one of the target's stats is raised
	ld hl, wEnemyStatLevels
	ldh a, [hBattleTurn]
	and a
	jr z, .got_levels
	ld hl, wPlayerStatLevels
.got_levels
	ld b, NUM_LEVEL_STATS
.loop
	ld a, [hli]
	cp BASE_STAT_LEVEL + 1
	jr nc, .raised
	dec b
	jr nz, .loop
	ret

.raised
	ld de, FogOfWarPopupText
	call ShowEntryAbilityPopup
	ld de, HAZE
	ld hl, FogOfWarText
	call PlayEntryAnimAndText
	farjp BattleCommand_ResetStats

INCLUDE "data/abilities/fog_of_war_mons.asm"

HandleChronoShift:
	ld hl, ChronoShiftPokemon
	call CurMonInList
	ret nc
	ld hl, wTrickRoomCount
	ld a, [hl]
	and a
	ret nz
	ld [hl], 5
	ld de, ChronoShiftPopupText
	call ShowEntryAbilityPopup
	ld de, TRICK_ROOM
	ld hl, ChronoShiftText
	jmp PlayEntryAnimAndText

INCLUDE "data/abilities/chrono_shift_mons.asm"

HandleProvocateur:
	ld hl, ProvocateurPokemon
	call CurMonInList
	ret nc
	; not if the target is already taunted
	ld a, [wEnemyTauntCount]
	ld b, a
	ldh a, [hBattleTurn]
	and a
	jr z, .got_taunt
	ld a, [wPlayerTauntCount]
	ld b, a
.got_taunt
	ld a, b
	and a
	ret nz
	ld de, ProvocateurPopupText
	call ShowEntryAbilityPopup
	ld de, TAUNT
	ld hl, ProvocateurText
	call PlayEntryAnimAndText
	farjp BattleCommand_Taunt

INCLUDE "data/abilities/provocateur_mons.asm"

HandleDisarm:
	ld hl, DisarmPokemon
	call CurMonInList
	ret nc
	; the target must hold an item
	ld a, [wEnemyMonItem]
	ld b, a
	ldh a, [hBattleTurn]
	and a
	jr z, .got_item
	ld a, [wBattleMonItem]
	ld b, a
.got_item
	ld a, b
	and a
	ret z
	ld de, DisarmPopupText
	call ShowEntryAbilityPopup
	ld de, KNOCK_OFF
	ld hl, DisarmText
	call PlayEntryAnimAndText
	farjp BattleCommand_KnockOff

INCLUDE "data/abilities/disarm_mons.asm"

HandleAllure:
	ld hl, AllurePokemon
	call CurMonInList
	ret nc
	; only on the opposite gender
	farcall CheckOppositeGender
	ret c
	ld de, AllurePopupText
	call ShowEntryAbilityPopup
	ld de, ATTRACT
	ld hl, AllureText
	call PlayEntryAnimAndText
	farjp BattleCommand_Attract

INCLUDE "data/abilities/allure_mons.asm"

; ability names for the popups (ShowEntryAbilityPopup)
DroughtPopupText: db "Drought@"
SandStreamPopupText: db "Sand Stream@"
SnowWarningPopupText: db "Snow Warning@"
SpinGuardPopupText: db "Spin Guard@"
NaturalCurePopupText: db "Natural Cure@"
BattleStancePopupText: db "Battle Stance@"
BattleDrivePopupText: db "Battle Drive@"
ChaoticBoostPopupText: db "Chaotic Boost@"
FortifyPopupText: db "Fortify@"
ImposterPopupText: db "Imposter@"
ReflectBarrierPopupText: db "Reflect Barrier@"
LightBarrierPopupText: db "Light Barrier@"
SanctuaryPopupText: db "Sanctuary@"
SiegebreakerPopupText: db "Siegebreaker@"
InfernalHowlPopupText: db "Infernal Howl@"
SeedfallPopupText: db "Seedfall@"
TrueSightPopupText: db "True Sight@"
FogOfWarPopupText: db "Fog of War@"
ChronoShiftPopupText: db "Chrono Shift@"
ProvocateurPopupText: db "Provocateur@"
DisarmPopupText: db "Disarm@"
AllurePopupText: db "Allure@"
CleanSweepPopupText: db "Clean Sweep@"
RockSnarePopupText: db "Rock Snare@"
CaltropperPopupText: db "Caltropper@"
VenomFieldPopupText: db "Venom Field@"
SilkSnarePopupText: db "Silk Snare@"
