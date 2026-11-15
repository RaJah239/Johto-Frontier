CheckBoostingAbilities:
	call HandleGuts
	call HandleRivalry
	call HandleSandForce
	call HandleTechnician
	call HandleSheerForceBoost
	call HandleAnalytic
	call HandleHugePower
	call HandleMultiscale
	call HandleThickFat
	call HandleSolarPowerBoost
	call HandleIronArm
	call HandleZenFocus
	call HandleRainSurge
	call HandlePillowFort
	call HandleChrysalisHide
	call HandleMoveEnchancingAbilities
	; fallthrough

; added last to recalculate after boosting abilities are factored in
; =================
; === Hard Mode ===
; =================
; hard mode gives 20% boosted Attack and Defense stats to all enemy trainers
CheckIfHardModeAndBoost:
	; exit if in link battles
	; prevents desyncs and any other shenanigans
	ld a, [wLinkMode]
	and a
	ret nz

	; exit if in wild battle
	; don't want to make every foe 20% stronger...
	ld a, [wBattleMode]
	dec a
	ret z

	; is hard mode enabled?
	ld a, [wOptions2]
	bit HARD_MODE, a
	ret z

	; hard mode is enabled
	; so boost offense and defense by 20%
	; decide offense vs defense by turn
	ldh a, [hBattleTurn]
	and a
	jr nz, .boost_attack              ; player turn -> return

	; this only applies when it's the player's turn
	; reduce the player's attack by 20%
	jmp TwentyPercentNerf

.boost_attack
	; this only applies when it's the enemy's turn
	; boost the enemy's attack by 20%
	jmp TwentyPercentBoost

HandleGuts:
	call GetCurrentMon
	ld hl, GutsPokemon
	call IsInByteArray
	ret nc

	ld a, BATTLE_VARS_STATUS
	call GetBattleVar
	and 1 << PSN | 1 << BRN | 1 << PAR | 1 << FRZ
	ret z
	ld a, BATTLE_VARS_MOVE_TYPE
	call GetBattleVar
	cp SPECIAL
	ret nc
	ShowOncePerSendOutPopup SEND_OUT_POPUP_GUTS, GutsText
	jmp FiftyPercentBoost

GutsText: db "Guts@"
INCLUDE "data/abilities/guts_mons.asm"

HandleRivalry:
	call GetCurrentMon
	ld hl, RivalryPokemon
	call IsInByteArray
	ret nc

	farcall CheckOppositeGender
	ret c
	jmp z, TwentyFivePercentBoost
	ShowOncePerSendOutPopup SEND_OUT_POPUP_RIVALRY, RivalryText
	jmp TwentyFivePercentNerf

RivalryText: db "Rivalry@"
INCLUDE "data/abilities/rivalry_mons.asm"

HandleSandForce:
	; get move type
	ld a, BATTLE_VARS_MOVE_TYPE
	call GetBattleVar
	and TYPE_MASK
	ld d, a

	; select attacker types
	ld hl, wBattleMonType1
	ldh a, [hBattleTurn]
	and a
	jr z, .check
	ld hl, wEnemyMonType1

.check
	ld a, [hl]
	cp d
	ret z         ; STAB → exit
	inc hl
	ld a, [hl]
	cp d
	ret z         ; STAB → exit
	; no STAB → continue

	; boost damage of non stab moves that fit
	call GetCurrentMon
	ld hl, SandForcePokemon
	call IsInByteArray
	ret nc

	ld a, [wBattleWeather]
	cp WEATHER_SANDSTORM
	ret nz

	ld a, BATTLE_VARS_MOVE_TYPE
	call GetBattleVar
	and TYPE_MASK
	cp ROCK
	jr z, .SandForceBoost
	cp GROUND
	jr z, .SandForceBoost
	cp STEEL
	ret nz

.SandForceBoost:
	ShowOncePerSendOutPopup SEND_OUT_POPUP_SAND_FORCE, SandForceText
	jmp ThirtyPercentBoost

SandForceText: db "Sand Force@"
INCLUDE "data/abilities/sand_force_mons.asm"

HandleTechnician:
	call GetCurrentMon
	ld hl, TechnicianPokemon
	call IsInByteArray
	ret nc

	ld a, BATTLE_VARS_MOVE_POWER
	call GetBattleVar
	cp 61            ; power < 61 → boost
	ret nc           ; power >= 61, no boost
	ShowOncePerSendOutPopup SEND_OUT_POPUP_TECHNICIAN, TechnicianText
	jmp FiftyPercentBoost

TechnicianText: db "Technician@"
INCLUDE "data/abilities/technician_mons.asm"

HandleAnalytic:
; attacks do 1.3x when the user moves after the foe this turn
	call GetCurrentMon
	ld hl, AnalyticPokemon
	call IsInByteArray
	ret nc

	ld a, [wEnemyGoesFirst] ; 0 if the player went first
	ld b, a
	ldh a, [hBattleTurn] ; 0 on the player's turn
	xor b
	ret z ; the user went first
	ShowOncePerSendOutPopup SEND_OUT_POPUP_ANALYTIC, AnalyticText
	jmp ThirtyPercentBoost

AnalyticText: db "Analytic@"
INCLUDE "data/abilities/analytic_mons.asm"

HandleSheerForceBoost:
; moves with a secondary effect do 1.3x (engine/abilities/sheer_force.asm)
	newfarcall SheerForceApplies
	ret nc
	jmp ThirtyPercentBoost

HandleMultiscale:
	call GetOpposingMon
	ld hl, MultiscalePokemon
	call IsInByteArray
	ret nc

	farcall CheckOpponentFullHP
	ret nz
	newfarcall MoldBreakerBypass
	ret c
	ShowOncePerSendOutPopup SEND_OUT_POPUP_MULTISCALE, MultiscaleText
	jmp FiftyPercentNerf

MultiscaleText: db "Multiscale@"
INCLUDE "data/abilities/multiscale_mons.asm"

HandleThickFat:
	call GetOpposingMon
	ld hl, ThickFatPokemon
	call IsInByteArray
	ret nc

	ld a, BATTLE_VARS_MOVE_TYPE
	call GetBattleVar
	and TYPE_MASK
	cp FIRE
	jr z, .nerf
	cp ICE
	ret nz
.nerf
	newfarcall MoldBreakerBypass
	ret c
	ShowOncePerSendOutPopup SEND_OUT_POPUP_THICK_FAT, ThickFatText
	jmp FiftyPercentNerf

ThickFatText: db "Thick Fat@"
INCLUDE "data/abilities/thick_fat_mons.asm"

; handle the HP loss in engine/abilities/turn_end_abilities.asm 
HandleSolarPowerBoost:
	call GetCurrentMon
	ld hl, SolarPowerPokemon
	call IsInByteArray
	ret nc

	; check if it is sunny
	ld a, [wBattleWeather]
	cp WEATHER_SUN
	ret nz

	; boost special type attacks by 50 percent
	ld a, BATTLE_VARS_MOVE_TYPE
	call GetBattleVar
	cp SPECIAL
	ret c
	ShowOncePerSendOutPopup SEND_OUT_POPUP_SOLAR_POWER, SolarPowerText
	jmp FiftyPercentBoost

SolarPowerText: db "SolarPower@"
INCLUDE "data/abilities/solar_power_mons.asm"

HandleIronArm:
	call GetCurrentMon
	ld hl, IronArmPokemon
	call IsInByteArray
	ret nc

	ld a, BATTLE_VARS_MOVE_TYPE
	call GetBattleVar
	and TYPE_MASK
	cp STEEL
	ret nz
	ShowOncePerSendOutPopup SEND_OUT_POPUP_IRON_ARM, IronArmText
	jmp FiftyPercentBoost

IronArmText: db "Iron Arm@"
INCLUDE "data/abilities/iron_arm_mons.asm"

HandleZenFocus:
	call GetCurrentMon
	ld hl, ZenFocusPokemon
	call IsInByteArray
	ret nc

	ld a, BATTLE_VARS_MOVE_TYPE
	call GetBattleVar
	and TYPE_MASK
	cp PSYCHIC_TYPE
	ret nz
	ShowOncePerSendOutPopup SEND_OUT_POPUP_ZEN_FOCUS, ZenFocusText
	jmp FiftyPercentBoost

ZenFocusText: db "Zen Focus@"
INCLUDE "data/abilities/zen_focus_mons.asm"

HandleRainSurge:
	call GetCurrentMon
	ld hl, RainSurgePokemon
	call IsInByteArray
	ret nc

	; check if it is raining
	ld a, [wBattleWeather]
	cp WEATHER_RAIN
	ret nz

	; boost special type attacks by 50 percent
	ld a, BATTLE_VARS_MOVE_TYPE
	call GetBattleVar
	cp SPECIAL
	ret c
	ShowOncePerSendOutPopup SEND_OUT_POPUP_RAIN_SURGE, RainSurgeText
	jmp FiftyPercentBoost

RainSurgeText: db "Rain Surge@"
INCLUDE "data/abilities/rain_surge_mons.asm"

HandlePillowFort:
	call GetOpposingMon
	ld hl, PillowFortPokemon
	call IsInByteArray
	ret nc

	ld a, BATTLE_VARS_MOVE_TYPE
	call GetBattleVar
	cp SPECIAL
	ret nc
	newfarcall MoldBreakerBypass
	ret c
	ShowOncePerSendOutPopup SEND_OUT_POPUP_PILLOW_FORT, PillowFortText
	jmp TwentyFivePercentNerf

PillowFortText: db "PillowFort@"
INCLUDE "data/abilities/pillow_fort_mons.asm"

HandleChrysalisHide:
	call GetOpposingMon
	ld hl, ChrysalisHidePokemon
	call IsInByteArray
	ret nc

	ld a, BATTLE_VARS_MOVE_TYPE
	call GetBattleVar
	cp SPECIAL
	ret c
	newfarcall MoldBreakerBypass
	ret c
	jmp FiftyPercentNerf

INCLUDE "data/abilities/chrysalis_hide_mons.asm"

HandleMoveEnchancingAbilities:
	; get move type
	ld a, BATTLE_VARS_MOVE_TYPE
	call GetBattleVar
	and TYPE_MASK
	ld d, a

	; select attacker types
	ld hl, wBattleMonType1
	ldh a, [hBattleTurn]
	and a
	jr z, .check
	ld hl, wEnemyMonType1

.check
	ld a, [hl]
	cp d
	ret z         ; STAB → exit
	inc hl
	ld a, [hl]
	cp d
	ret z         ; STAB → exit
	; no STAB → continue

	; boost damage of non stab moves that fit
	call HandleSharpness
	call HandleBallistics
	call HandleIronFist
	call HandleStrongJaw
	ret

HandleSharpness:
	call GetCurrentMon
	ld hl, SharpnessPokemon
	call IsInByteArray
	ret nc

	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	ld hl, SharpMoves
	call IsInByteArray
	ret nc
	ShowOncePerSendOutPopup SEND_OUT_POPUP_SHARPNESS, SharpnessText
	jmp FiftyPercentBoost

SharpnessText: db "Sharpness@"
INCLUDE "data/abilities/sharpness_mons.asm"

HandleBallistics:
	call GetCurrentMon
	ld hl, BallisticsPokemon
	call IsInByteArray
	ret nc

	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	ld hl, BallisticsMoves
	call IsInByteArray
	ret nc
	ShowOncePerSendOutPopup SEND_OUT_POPUP_BALLISTICS, BallisticsText
	jmp FiftyPercentBoost

BallisticsText: db "Ballistics@"
INCLUDE "data/abilities/ballistics_mons.asm"

HandleIronFist:
	call GetCurrentMon
	ld hl, IronFistPokemon
	call IsInByteArray
	ret nc

	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	ld hl, PunchingMoves
	call IsInByteArray
	ret nc
	ShowOncePerSendOutPopup SEND_OUT_POPUP_IRON_FIST, IronFistText
	jmp TwentyPercentBoost

IronFistText: db "Iron Fist@"
INCLUDE "data/abilities/iron_fist_mons.asm"

HandleStrongJaw:
	call GetCurrentMon
	ld hl, StrongJawPokemon
	call IsInByteArray
	ret nc

	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	ld hl, StrongJawMoves
	call IsInByteArray
	ret nc
	ShowOncePerSendOutPopup SEND_OUT_POPUP_STRONG_JAW, StrongJawText
	jmp FiftyPercentBoost

StrongJawText: db "Strong Jaw@"
INCLUDE "data/abilities/strong_jaw_mons.asm"

; ===========================
; === Ability: Huge Power ===
; ===========================
; A Huge Power mon's Attack stat is doubled: in its damage
; (PolarFangorLightBallBoost in effect_commands.asm, so the AI's damage
; estimates and the move info preview see it too) and in the battle Info
; tab (StatsInfoBox). Not Defense for Body Press, nor special moves.
HandleHugePower:
; Its popup, the first time it uses a physical move after being sent out.
	call GetCurrentMon
	ld hl, HugePowerPokemon
	call IsInByteArray
	ret nc
	ld a, BATTLE_VARS_MOVE_TYPE
	call GetBattleVar
	cp SPECIAL
	ret nc
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_BODY_PRESS
	ret z
	ShowOncePerSendOutPopup SEND_OUT_POPUP_HUGE_POWER, HugePowerText
	ret

IsHugePowerSpecies::
; Carry if species a has Huge Power. Preserves bc, de, hl.
	push hl
	push de
	push bc
	ld hl, HugePowerPokemon
	call IsInByteArray
	jmp PopBCDEHL

HugePowerText: db "Huge Power@"
INCLUDE "data/abilities/huge_power_mons.asm"

TwentyPercentNerf:
	ld a, 80
	ldh [hMultiplier], a
	call Multiply

	ld a, 100
	ldh [hDivisor], a
	ld b, 4
	jmp Divide

FiftyPercentNerf:
	ld a, 50
	ldh [hMultiplier], a
	call Multiply

	ld a, 100
	ldh [hDivisor], a
	ld b, 4
	jmp Divide

TwentyFivePercentNerf:
	ld a, 75
	ldh [hMultiplier], a
	call Multiply

	ld a, 100
	ldh [hDivisor], a
	ld b, 4
	jmp Divide

HundredPercentBoost:
	ld a, 100
	jr FinishBoost

FiftyPercentBoost:
	ld a, 50
	jr FinishBoost

ThirtyPercentBoost:
	ld a, 30
	jr FinishBoost

TwentyFivePercentBoost:
	ld a, 25
	jr FinishBoost

TwentyPercentBoost:
	ld a, 20
	; fallthrough

FinishBoost:
	add 100
	ldh [hMultiplier], a
	call Multiply

	ld a, 100
	ldh [hDivisor], a
	ld b, 4
	jmp Divide

PunchingMoves:
	db BULLET_PUNCH
	db DRAIN_PUNCH
	db FIRE_PUNCH
	db ICE_PUNCH
	db MACH_PUNCH
	db METEOR_MASH
	db SHADOW_PUNCH
	db THUNDERPUNCH
	db -1 ; end

SharpMoves:
	db CROSS_CHOP
	db CUT
	db DRAGON_CLAW
	db LEAF_BLADE
	db NIGHT_SLASH
	db SLASH
	db THROAT_CHOP
	db X_SCISSOR
	db -1 ; end

BallisticsMoves:
	db AURORA_BEAM
	db BUBBLEBEAM
	db FIRE_BLAST
	db FLASH_CANNON
	db GUNK_SHOT
	db HYPER_BEAM
	db ICE_BEAM
	db PSYBEAM
	db ROCK_BLAST
	db SIGNAL_BEAM
	db SLUDGE_BOMB
	db WATER_GUN
	db -1 ; end

StrongJawMoves:
	db BITE
	db CRUNCH
	db FIRE_FANG
	db ICE_FANG
	db THUNDER_FANG
	db -1 ; end

; saving a few bytes by putting it here
KnockOffBoost:
	; only apply to knock off
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	cp KNOCK_OFF
	ret nz

	; check turn
	ldh a, [hBattleTurn]
	and a
	jr nz, .enemy_turn

; =====================
; === PLAYER'S TURN ===
; =====================
	ld a, [wEnemyMonItem]
	and a
	ret z                 ; no item → no boost

	; mail don't get knocked off so no boost
	ld [wNamedObjectIndex], a
	ld d, a
	farcall ItemIsMail
	ret c                 ; mail → no boost

	jr FiftyPercentBoost

; ====================
; === ENEMY'S TURN ===
; ====================
.enemy_turn
	ld a, [wBattleMonItem]
	and a
	ret z                 ; no item → no boost

	; mail don't get knocked off so no boost
	ld [wNamedObjectIndex], a
	ld d, a
	farcall ItemIsMail
	ret c                 ; mail → no boost

	jr FiftyPercentBoost
