AI_IsPlayerImmuneByAbility:
; b = move type. Return carry if the player's active mon's ability makes it
; immune to moves of that type: Levitate (Ground), Waterproof (Water),
; Flame Ward (Fire) or Grounded (Electric). Reads each table from its own
; bank, so it works from any bank (call with farcall; b and carry survive).
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
	ld a, [wBattleMonSpecies]
	ld e, a
.loop
	ld a, d
	call GetFarByte
	inc hl
	cp -1
	jr z, .no
	cp e
	jr nz, .loop
	scf
	ret

.no
	and a
	ret
