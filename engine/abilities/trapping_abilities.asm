TrapAbilities:
	call ArenaTrap
	call MagnetPull
	; fallthrough

ShadowTag:
	ld a, [wEnemyMonSpecies]
	ld hl, ShadowTagPokemon
	call IsInByteArray
	ret nc
	jr TrappedByOpponent

INCLUDE "data/abilities/shadow_tag_mons.asm"

ArenaTrap:
	; check if player has a levitating pokemon
	; can't trap levitating pokemon
	ld a, [wBattleMonSpecies]
	ld hl, LevitatePokemon
	call IsInByteArray
	ret c

	; check if enemy has an arena trap pokemon
	ld a, [wEnemyMonSpecies]
	ld hl, ArenaTrapPokemon
	call IsInByteArray
	ret nc

	; check type
	ld de, wBattleMonType1

	; check if flying type
	ld a, [de]
	cp FLYING
	ret z
	inc de
	ld a, [de]
	cp FLYING
	ret z
	jr TrappedByOpponent

INCLUDE "data/abilities/arena_trap_mons.asm"

MagnetPull:
	ld a, [wEnemyMonSpecies]
	ld hl, MagnetPullPokemon
	call IsInByteArray
	ret nc

	; check type
	ld de, wBattleMonType1

	; check if steel type
	ld a, [de]
	cp STEEL
	jr z, TrappedByOpponent
	inc de
	ld a, [de]
	cp STEEL
	ret nz
	; fallthrough

TrappedByOpponent:
	ld hl, wEnemySubStatus5
	bit SUBSTATUS_CANT_RUN, [hl]
	ret nz
	set SUBSTATUS_CANT_RUN, [hl]
	ret

INCLUDE "data/abilities/magnet_pull_mons.asm"
