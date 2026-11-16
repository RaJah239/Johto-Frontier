; ==============================
; === Ability: Leaf Guard    ===
; ==============================
; While the sun is out, a Leaf Guard mon can't be given a status (sleep,
; poison, burn, frostbite, paralysis): status moves, secondary effects,
; Toxic Spikes and Flame / Toxic Orbs all fail on it, and its own Rest fails.
; A status it already has stays; confusion isn't a status.
; The popup only shows when a status move is used on it in the sun, or when
; it uses Rest in the sun. Mold Breaker ignores it (moves used on it), and
; Neutralizing Gas turns it off.

LeafGuardStatusMove::
; A status move is used on the target (hBattleTurn's foe). Carry if Leaf
; Guard stops it: its popup has shown over the target (the caller prints the
; text). With Neutralizing Gas or Mold Breaker, their popup shows instead
; and there's no carry. Use with newfarcall; preserves bc, de and hl.
	push hl
	push de
	push bc
	call LeafGuardSunIsOut
	jr nz, .no
	call GetOpposingMon
	ld hl, LeafGuardPokemon
	call IsInAbilityListNG
	jr nc, .no
	call MoldBreakerBypass
	jr c, .no
	ld b, BANK(@)
	ld de, LeafGuardText
	call ShowDefensiveAbilityBanner
	scf
	jr .done
.no
	and a
.done
	jmp PopBCDEHL

LeafGuardRest::
; The user (hBattleTurn) uses Rest: carry if Leaf Guard makes it fail. Its
; popup has shown over the user. (Neutralizing Gas: its popup, no carry.)
; Use with newfarcall; preserves bc, de and hl.
	push hl
	push de
	push bc
	call LeafGuardSunIsOut
	jr nz, .no
	call GetCurrentMon
	ld hl, LeafGuardPokemon
	call IsInAbilityListNG
	jr nc, .no
	ld b, BANK(@)
	ld de, LeafGuardText
	ldh a, [hBattleTurn]
	ld c, a ; ABILITY_POPUP_PLAYER / ABILITY_POPUP_ENEMY
	farcall ShowAbilityPopup
	; give it the same pause as ShowDefensiveAbilityBanner
	ld a, [wOptions4]
	bit ABILITY_BANNERS, a
	jr z, .shown
	ld c, 30
	call DelayFrames
.shown
	scf
	jr .done
.no
	and a
.done
	jmp PopBCDEHL

LeafGuardBlocksSecondary::
; A move's secondary effect would give the target (hBattleTurn's foe) a
; status: carry if Leaf Guard stops it, silently. Mold Breaker ignores it
; (also silently). Use with newfarcall; preserves bc, de and hl.
	call GetOpposingMon
	call LeafGuardActive_Far
	ret nc
	call AttackerHasMoldBreaker
	ccf
	ret

UserHasLeafGuardInSun::
; Carry if the mon whose turn it is (hBattleTurn) has Leaf Guard and the sun
; is out: Toxic Spikes and Flame / Toxic Orb fail on it, silently.
; Use with newfarcall; preserves bc, de and hl.
	push hl
	call GetCurrentMon
	pop hl
	; fallthrough

LeafGuardActive_Far::
; Carry if species a (one of the mons out) has Leaf Guard and the sun is out.
; Neutralizing Gas: no. No popups. Preserves bc, de and hl.
	push hl
	push de
	push bc
	ld b, a
	call LeafGuardSunIsOut
	ld a, b
	jr nz, .no
	ld hl, LeafGuardPokemon
	call IsInAbilityList
	jr .done
.no
	and a
.done
	jmp PopBCDEHL

LeafGuardSpecies_Far::
; Carry if species a has Leaf Guard, whatever the weather (and Neutralizing
; Gas). Preserves bc, de and hl.
	push hl
	push de
	push bc
	ld hl, LeafGuardPokemon
	call IsInAbilityList
	jmp PopBCDEHL

LeafGuardSunIsOut:
; z if the sun is out.
	ld a, [wBattleWeather]
	cp WEATHER_SUN
	ret

AI_PlayerHasLeafGuard::
; Carry if the player's mon can't be statused right now because of Leaf
; Guard (the sun is out), and the enemy's mon doesn't have Mold Breaker.
; Use with newfarcall; preserves bc, de and hl.
	ld a, [wBattleMonSpecies]
	call LeafGuardActive_Far
	ret nc
	push hl
	push de
	push bc
	ld a, [wEnemyMonSpecies]
	ld hl, MoldBreakerPokemon
	call IsInAbilityList
	ccf
	jmp PopBCDEHL

LeafGuardText: db "Leaf Guard@"

INCLUDE "data/abilities/leaf_guard_mons.asm"
