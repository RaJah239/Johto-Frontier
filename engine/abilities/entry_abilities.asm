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

; The same goes for held items that activate on entry (weather shards): their
; own pending bits are run by RunPendingEntryItems at the end of SpikesDamage,
; so after the mon took its hazard damage and every entry ability went off.

; (ENTRY_ABILITIES_*_F and ENTRY_ITEM_*_F are in constants/battle_constants.asm)

DEF HAZARDS_MASK EQU 1 << SCREENS_SPIKES | 1 << SCREENS_STEALTH_ROCK | 1 << SCREENS_TOXIC_SPIKES | 1 << SCREENS_STICKY_WEB

StartBattleEntryAbilities::
; Both sides' first mons are out: run their entry abilities, then their
; entry items.
	xor a
	ld [wNeutralizingGas], a
	ld a, (1 << ENTRY_ABILITIES_PLAYER_F) | (1 << ENTRY_ABILITIES_ENEMY_F) \
	    | (1 << ENTRY_ITEM_PLAYER_F) | (1 << ENTRY_ITEM_ENEMY_F)
	ld [wEntryAbilitiesPending], a
	; Unburden: which mons hold an item
	xor a
	ldh [hBattleTurn], a
	newfarcall UnburdenRecordSide ; engine/abilities/unburden.asm
	ld a, 1
	ldh [hBattleTurn], a
	newfarcall UnburdenRecordSide
	call RunPendingEntryAbilities
	jmp RunPendingEntryItems.run

QueueEntryAbilities::
; The hBattleTurn side has just sent out a mon.
	newfarcall UnburdenRecordSide ; engine/abilities/unburden.asm
	ld hl, wEntryAbilitiesPending
	ldh a, [hBattleTurn]
	and a
	ld a, (1 << ENTRY_ABILITIES_PLAYER_F) | (1 << ENTRY_ITEM_PLAYER_F)
	jr z, .got_bits
	ld a, (1 << ENTRY_ABILITIES_ENEMY_F) | (1 << ENTRY_ITEM_ENEMY_F)
.got_bits
	or [hl]
	ld [hl], a
	; at the start of a battle, wait until DoBattle has sent out both mons
	ld a, [wBattleHasJustStarted]
	and a
	ret nz
	; fallthrough

RunPendingEntryAbilities:
	; Neutralizing Gas: who's suppressed now (a side freed from it gets its
	; entry abilities queued), and its own popup before the other abilities
	farcall UpdateNeutralizingGas
	farcall AnnounceNeutralizingGas
	lb bc, ENTRY_ABILITIES_PLAYER_F, ENTRY_ABILITIES_ENEMY_F
	ld de, RunEntryAbilities
	; fallthrough

RunPendingEntrySides:
; Run de for each side whose pending bit (b: player's, c: enemy's) is set,
; once both sides have a mon out, in link battle order, with a = the side.
	ld hl, wEntryAbilitiesPending
	ld a, [hl]
	call .BitMask
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
	push bc
	push de
	call ClearSprites
	pop de
	pop bc
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
	push bc
	push de
	ld a, b
	call .TestAndReset
	ld a, 0 ; player's turn
	jr .run_side

.enemy
	push bc
	push de
	ld a, c
	call .TestAndReset
	ld a, 1 ; enemy's turn
.run_side
	pop hl ; de
	pop bc
	ret z
	push bc
	push hl
	call _hl_
	pop de
	pop bc
	ret

.TestAndReset:
; Reset pending bit a; return nz if it was set.
	call .Mask
	ld hl, wEntryAbilitiesPending
	and [hl]
	ret z
	xor [hl]
	ld [hl], a
	or 1 ; nz
	ret

.BitMask:
; Return a & (1 << b | 1 << c), z if neither is set. Preserves de.
	push de
	ld e, a
	ld a, b
	call .Mask
	ld d, a
	ld a, c
	call .Mask
	or d
	and e
	pop de
	ret

.Mask:
; a = 1 << a
	push bc
	ld b, a
	ld a, 1
	inc b
.shift
	dec b
	jr z, .got_mask
	add a
	jr .shift
.got_mask
	pop bc
	ret

RunPendingEntryItems::
; At the end of SpikesDamage: use the entry items of the sides that sent out
; a mon (after its hazard damage and entry abilities).
	ld a, [wBattleHasJustStarted]
	and a
	ret nz ; DoBattle runs them once both mons are out
.run
	lb bc, ENTRY_ITEM_PLAYER_F, ENTRY_ITEM_ENEMY_F
	ld de, RunEntryItems
	jmp RunPendingEntrySides

RunEntryItems:
; Side a's mon just came in: use its weather shard
; (engine/battle/turn_end_effects.asm).
	ldh [hBattleTurn], a
	xor a
	ld [wFailedMessage], a
	ld [wEffectFailed], a
	ld [wAttackMissed], a
	farcall UseHeldWeatherShard
	; Unburden, if it used its shard
	ldh a, [hBattleTurn]
	newfarcall CheckUnburdenSide ; engine/abilities/unburden.asm
	; the player's HUD hid its shard until now (PrintPlayerHUD): show it
	; if it kept it
	ldh a, [hBattleTurn]
	and a
	ret nz
	farjp UpdatePlayerHUD

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
	dw HandleScrappy
	dw HandleSheerForce
	dw HandleIntimidate
	dw HandleStiflingAura
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
	dw HandleDownload
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
; Clear the text box (of the previous ability's text), then slide in ability
; name de (in this bank) over the user's HUD. Preserves hl.
	push hl
	push de
	farcall EmptyBattleTextbox
	pop de
	ld b, BANK(@)
	ldh a, [hBattleTurn]
	ld c, a ; ABILITY_POPUP_PLAYER / ABILITY_POPUP_ENEMY
	farcall ShowAbilityPopup
	pop hl
	ret nc
	; suppressed by Neutralizing Gas (its popup showed instead): return
	; from the handler too, skipping the ability's effect
	inc sp
	inc sp
	ret

EntryAbilityMoveEffect:
; Run move effect a:hl for an entry ability whose animation already played.
; Many effects (Barrier, Safeguard, Taunt...) animate the user's current
; move themselves, which would replay the last move it used, so the user's
; move animation is cleared while the effect runs and put back after.
	push af
	push hl
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVarAddr
	ld b, [hl]
	ld [hl], 0
	pop hl
	pop af
	push bc
	rst FarCall
	pop bc
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVarAddr
	ld [hl], b
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
EntryNGCancel:
; Called right before an entry ability puts up its effect: if Neutralizing
; Gas suppresses the user's ability, show its popup and return carry (the
; ability does nothing). Preserves bc, de, hl.
	ldh a, [hBattleTurn]
	call IsSideSuppressed
	ret nc
	push hl
	push de
	push bc
	farcall EmptyBattleTextbox
	ld b, BANK(@)
	ld de, NeutralizingGasEntryText ; (replaced by the Neutralizing Gas popup)
	ldh a, [hBattleTurn]
	ld c, a
	farcall ShowAbilityPopup
	pop bc
	pop de
	pop hl
	scf
	ret

NeutralizingGasEntryText: db "@"

SetEntryWeather:
; Set weather a for 255 turns. Return z if that weather was already up (or
; Neutralizing Gas suppresses the ability).
	ld hl, wBattleWeather
	cp [hl]
	ret z
	push af
	call EntryNGCancel
	jr nc, .set
	pop af
	xor a ; z
	ret
.set
	pop af
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
	jmp ShowEntryAbilityPopup

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
	jmp ShowEntryAbilityPopup

DroughtPopupText: db "Drought@"
INCLUDE "data/abilities/drought_mons.asm"

HandleSandStream:
	ld hl, SandStreamPokemon
	call CurMonInList
	ret nc
	ld a, WEATHER_SANDSTORM
	call SetEntryWeather
	ret z
	ld de, SandStreamPopupText
	jmp ShowEntryAbilityPopup

SandStreamPopupText: db "Sand Stream@"
INCLUDE "data/abilities/sand_stream_mons.asm"

HandleSnowWarning:
	ld hl, SnowWarningPokemon
	call CurMonInList
	ret nc
	ld a, WEATHER_HAIL
	call SetEntryWeather
	ret z
	ld de, SnowWarningPopupText
	jmp ShowEntryAbilityPopup

SnowWarningPopupText: db "Snow Warning@"
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
	jmp PlayEntryAbilityAnim

SpinGuardPopupText: db "Spin Guard@"
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
.done
	farjp CalcPokemonStats

NaturalCurePopupText: db "Natural Cure@"
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
	farjp BattleCommand_StatUpMessage

DefenseModePopupText: db "Defense Mode@"
INCLUDE "data/abilities/defense_mode_mons.asm"

HandleBattleStance:
	ld hl, BattleStancePokemon
	call CurMonInList
	ret nc
	ld de, BattleStancePopupText
	call ShowEntryAbilityPopup
	farcall BattleCommand_DefenseUp
	farjp BattleCommand_StatUpMessage

BattleStancePopupText: db "Battle Stance@"
INCLUDE "data/abilities/battle_stance_mons.asm"

HandleBattleDrive:
	ld hl, BattleDrivePokemon
	call CurMonInList
	ret nc
	ld de, BattleDrivePopupText
	call ShowEntryAbilityPopup
	farcall BattleCommand_AttackUp
	farjp BattleCommand_StatUpMessage

BattleDrivePopupText: db "Battle Drive@"
INCLUDE "data/abilities/battle_drive_mons.asm"

HandleDownload:
; Raise Attack if the foe's Defense is lower than its Sp. Def,
; otherwise Sp. Atk.
	ld hl, DownloadPokemon
	call CurMonInList
	ret nc
	ld de, DownloadPopupText
	call ShowEntryAbilityPopup
	ldh a, [hBattleTurn]
	and a
	ld hl, wEnemyMonDefense
	ld de, wEnemyMonSpclDef
	jr z, .got_foe
	ld hl, wBattleMonDefense
	ld de, wBattleMonSpclDef
.got_foe
	; carry if Defense < Sp. Def
	inc hl
	inc de
	ld a, [de]
	ld c, a
	ld a, [hld]
	sub c
	dec de
	ld a, [de]
	ld c, a
	ld a, [hl]
	sbc c
	jr c, .attack
	farcall BattleCommand_SpecialAttackUp
	farjp BattleCommand_StatUpMessage

.attack
	farcall BattleCommand_AttackUp
	farjp BattleCommand_StatUpMessage

DownloadPopupText: db "Download@"
INCLUDE "data/abilities/download_mons.asm"

HandleChaoticBoost:
	ld hl, ChaoticBoostPokemon
	call CurMonInList
	ret nc
	ld de, ChaoticBoostPopupText
	call ShowEntryAbilityPopup
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

ChaoticBoostPopupText: db "Chaotic Boost@"
INCLUDE "data/abilities/chaotic_boost_mons.asm"

HandleFortify:
	ld hl, FortifyPokemon
	call CurMonInList
	ret nc
	ld de, FortifyPopupText
	call ShowEntryAbilityPopup
	ld de, BARRIER
	call PlayEntryAbilityAnim
	ld a, BANK(BattleCommand_Barrier)
	ld hl, BattleCommand_Barrier
	jmp EntryAbilityMoveEffect

FortifyPopupText: db "Fortify@"
INCLUDE "data/abilities/fortify_mons.asm"

HandleImposter:
	ld hl, ImposterPokemon
	call CurMonInList
	ret nc
	ld de, ImposterPopupText
	call ShowEntryAbilityPopup
	ld de, TRANSFORM
	call PlayEntryAbilityAnim
	ld a, BANK(BattleCommand_Transform)
	ld hl, BattleCommand_Transform
	jmp EntryAbilityMoveEffect

ImposterPopupText: db "Imposter@"
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
	jmp PlayEntryAbilityAnim

ReflectBarrierPopupText: db "Reflect Barrier@"
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
	jmp PlayEntryAbilityAnim

LightBarrierPopupText: db "Light Barrier@"
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
	call EntryNGCancel
	jr c, .already_up
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
	ld a, BANK(BattleCommand_Safeguard)
	ld hl, BattleCommand_Safeguard ; prints its own text
	jmp EntryAbilityMoveEffect

SanctuaryPopupText: db "Sanctuary@"
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
	call PlayEntryAbilityAnim
	farjp BattleCommand_BreakScreens

SiegebreakerPopupText: db "Siegebreaker@"
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
	call PlayEntryAbilityAnim
	ld a, BANK(BattleCommand_Defog)
	ld hl, BattleCommand_Defog
	jmp EntryAbilityMoveEffect

CleanSweepPopupText: db "Clean Sweep@"
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
	jmp PlayEntryAbilityAnim

RockSnarePopupText: db "Rock Snare@"
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
	jmp PlayEntryAbilityAnim

CaltropperPopupText: db "Caltropper@"
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
	jmp PlayEntryAbilityAnim

VenomFieldPopupText: db "Venom Field@"
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
	jmp PlayEntryAbilityAnim

SilkSnarePopupText: db "Silk Snare@"
INCLUDE "data/abilities/silk_snare_mons.asm"

SetEntryHazard:
; Lay hazard mask b on the target's side. Return z if it was already there.
	call GetTargetScreens
	ld a, [hl]
	and b
	jr nz, .already_up
	call EntryNGCancel
	jr c, .already_up
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
	; Scrappy isn't affected: its popup shows over the target instead
	newfarcall TargetHasScrappy
	jr c, .scrappy
	; nor is Oblivious: its popup shows over the target
	newfarcall ObliviousBlocks
	ret c
	ld de, LEER
	call PlayEntryAbilityAnim
	farcall BattleCommand_AttackDown
	farjp BattleCommand_StatDownMessage

.scrappy
	ldh a, [hBattleTurn]
	xor 1
	newfarcall ShowScrappyPopupOnSide
	ret nc
	; Scrappy is suppressed by Neutralizing Gas: Intimidate works
	ld de, LEER
	call PlayEntryAbilityAnim
	farcall BattleCommand_AttackDown
	farjp BattleCommand_StatDownMessage

IntimidatePopupText: db "Intimidate@"

IsBadEntryVsContrary::
; For the AI's switch-in choice: carry if OT species a has an entry ability
; that lowers a stat which the player's Contrary mon would then raise to its
; benefit: Stifling Aura (Speed) always, Intimidate (Attack) if the player's
; mon is physical, Infernal Howl (Sp. Atk) if it is special.
; Preserves bc, de, hl.
	push hl
	push de
	push bc
	push af
	ld a, [wBattleMonSpecies]
	newfarcall IsContrarySpecies
	jr nc, .no
	pop af
	push af
	ld hl, StiflingAuraPokemon
	call IsInAbilityList
	jr c, .yes
	pop af
	push af
	ld hl, IntimidatePokemon
	call IsInAbilityList
	jr c, .intimidate
	pop af
	push af
	ld hl, InfernalHowlPokemon
	call IsInAbilityList
	jr nc, .no
	; Sp. Atk drop: only bad for a special attacker
	farcall IsPlayerPhysicalOrSpecial
	jr nc, .yes
	jr .no

.intimidate
	; Attack drop: only bad for a physical attacker
	farcall IsPlayerPhysicalOrSpecial
	jr c, .yes
.no
	pop af
	and a
	jmp PopBCDEHL

.yes
	pop af
	scf
	jmp PopBCDEHL

HandleSheerForce:
; just its popup when it comes in (engine/abilities/sheer_force.asm)
	newfarcall AttackerHasSheerForce
	ret nc
	farjp ShowSheerForcePopup

HandleScrappy:
; just its popup when it comes in (engine/abilities/scrappy.asm)
	newfarcall AttackerHasScrappyRaw
	ret nc
	ldh a, [hBattleTurn]
	newfarcall ShowScrappyPopupOnSide
	ret

INCLUDE "data/abilities/intimidate_mons.asm"

HandleStiflingAura:
	ld hl, StiflingAuraPokemon
	call CurMonInList
	ret nc
	ld de, StiflingAuraPopupText
	call ShowEntryAbilityPopup
	ld de, SCARY_FACE
	call PlayEntryAbilityAnim
	farcall BattleCommand_SpeedDown
	farjp BattleCommand_StatDownMessage

StiflingAuraPopupText: db "Stifling Aura@"
INCLUDE "data/abilities/stifling_aura_mons.asm"

HandleInfernalHowl:
	ld hl, InfernalHowlPokemon
	call CurMonInList
	ret nc
	ld de, InfernalHowlPopupText
	call ShowEntryAbilityPopup
	ld de, GROWL
	call PlayEntryAbilityAnim
	farcall BattleCommand_SpecialAttackDown
	farjp BattleCommand_StatDownMessage

InfernalHowlPopupText: db "Infernal Howl@"
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
	ld a, BANK(BattleCommand_LeechSeed)
	ld hl, BattleCommand_LeechSeed
	jmp EntryAbilityMoveEffect

SeedfallPopupText: db "Seedfall@"
INCLUDE "data/abilities/seedfall_mons.asm"

HandleTrueSight:
	ld hl, TrueSightPokemon
	call CurMonInList
	ret nc
	ld de, TrueSightPopupText
	call ShowEntryAbilityPopup
	ld de, FORESIGHT
	call PlayEntryAbilityAnim
	ld a, BANK(BattleCommand_Foresight)
	ld hl, BattleCommand_Foresight
	jmp EntryAbilityMoveEffect

TrueSightPopupText: db "True Sight@"
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
	call PlayEntryAbilityAnim
	ld a, BANK(BattleCommand_ResetStats)
	ld hl, BattleCommand_ResetStats
	jmp EntryAbilityMoveEffect

FogOfWarPopupText: db "Fog of War@"
INCLUDE "data/abilities/fog_of_war_mons.asm"

HandleChronoShift:
	ld hl, ChronoShiftPokemon
	call CurMonInList
	ret nc
	ld hl, wTrickRoomCount
	ld a, [hl]
	and a
	ret nz
	call EntryNGCancel
	ret c
	ld [hl], 5
	ld de, ChronoShiftPopupText
	call ShowEntryAbilityPopup
	ld de, TRICK_ROOM
	jmp PlayEntryAbilityAnim

ChronoShiftPopupText: db "Chrono Shift@"
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
	call PlayEntryAbilityAnim
	ld a, BANK(BattleCommand_Taunt)
	ld hl, BattleCommand_Taunt
	jmp EntryAbilityMoveEffect

ProvocateurPopupText: db "Provocateur@"
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
	call PlayEntryAbilityAnim
	farjp BattleCommand_KnockOff

DisarmPopupText: db "Disarm@"
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
	call PlayEntryAbilityAnim
	ld a, BANK(BattleCommand_Attract)
	ld hl, BattleCommand_Attract
	jmp EntryAbilityMoveEffect

AllurePopupText: db "Allure@"
INCLUDE "data/abilities/allure_mons.asm"
