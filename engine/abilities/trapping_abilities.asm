TrapAbilities:
	call ArenaTrap
	call MagnetPull
	; fallthrough

ShadowTag:
	ld a, [wEnemyMonSpecies]
	ld hl, ShadowTagPokemon
	call IsInByteArray
	ret nc
	jr TrapOpponent

INCLUDE "data/abilities/ability_mons/shadow_tag_mons.asm"

ArenaTrap:
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
	jr TrapOpponent

INCLUDE "data/abilities/ability_mons/arena_trap_mons.asm"

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
	jr z, TrapOpponent
	inc de
	ld a, [de]
	cp STEEL
	ret nz
	; fallthrough

TrapOpponent:
	ld hl, wEnemySubStatus5
	bit SUBSTATUS_CANT_RUN, [hl]
	ret nz
	set SUBSTATUS_CANT_RUN, [hl]
	ret

INCLUDE "data/abilities/ability_mons/magnet_pull_mons.asm"
