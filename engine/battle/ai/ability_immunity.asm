AI_IsPlayerImmuneByAbility:
; b = move type. Return carry if the player's active mon's ability makes it
; immune to moves of that type: Levitate (Ground), Waterproof (Water),
; Flame Ward (Fire), Grounded (Electric) or Immunity (Poison). Reads each
; table from its own bank, so it works from any bank (call with farcall;
; b and carry survive).
	ld a, [wBattleMonSpecies]
	jr IsSpeciesImmuneByAbility

AI_IsTargetImmuneByAbility:
; Same, for the mon being attacked this turn (hBattleTurn).
	ldh a, [hBattleTurn]
	and a
	jr z, AI_IsEnemyImmuneByAbility
	jr AI_IsPlayerImmuneByAbility

AI_IsEnemyImmuneByAbility:
; Same as AI_IsPlayerImmuneByAbility, for the opponent's active mon.
	ld a, [wEnemyMonSpecies]
	; fallthrough

IsSpeciesImmuneByAbility:
; a = species, b = move type.
	ld e, a
	ld a, b
	ld hl, LevitatePokemon
	ld d, BANK(LevitatePokemon)
	cp GROUND
	jr z, .check
	ld hl, WaterproofPokemon
	ld d, BANK(WaterproofPokemon)
	cp WATER
	jr z, .check
	ld hl, FlameWardPokemon
	ld d, BANK(FlameWardPokemon)
	cp FIRE
	jr z, .check
	ld hl, GroundedPokemon
	ld d, BANK(GroundedPokemon)
	cp ELECTRIC
	jr z, .check
	ld hl, ImmunityPokemon
	ld d, BANK(ImmunityPokemon)
	cp POISON
	jr z, .check
	and a
	ret

.check
	ld a, e
	jmp IsSpeciesInFarList

.no
	and a
	ret
