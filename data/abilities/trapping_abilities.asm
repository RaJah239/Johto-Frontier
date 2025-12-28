TrapAbilities:
	call ArenaTrap
	call MagnetPull
	; fallthrough

ShadowTag:
	ld a, [wEnemyMonSpecies]
	ld hl, ShadowTagPokemon
	call IsInByteArray
	ret nc

	; trap player
	ld hl, wEnemySubStatus5
	bit SUBSTATUS_CANT_RUN, [hl]
	ret nz
	set SUBSTATUS_CANT_RUN, [hl]
	ret

INCLUDE "data/abilities/ability_mons/shadow_tag_mons.asm"

ArenaTrap:
	ld a, [wEnemyMonSpecies]
	ld hl, ArenaTrapPokemon
	call IsInByteArray
	ret nc

	; check type
	ld de, wEnemyMonType1
	ldh a, [hBattleTurn]
	and a
	jr z, .ok
	ld de, wBattleMonType1
.ok

	; check if flying type
	ld a, [de]
	cp FLYING
	ret z
	inc de
	ld a, [de]
	cp FLYING
	ret z

	; trap player if not flying type
	ld hl, wEnemySubStatus5
	bit SUBSTATUS_CANT_RUN, [hl]
	ret nz
	set SUBSTATUS_CANT_RUN, [hl]
	ret

INCLUDE "data/abilities/ability_mons/arena_trap_mons.asm"

MagnetPull:
	ld a, [wEnemyMonSpecies]
	ld hl, MagnetPullPokemon
	call IsInByteArray
	ret nc

	; check type
	ld de, wEnemyMonType1
	ldh a, [hBattleTurn]
	and a
	jr z, .ok
	ld de, wBattleMonType1
.ok

	; check if steel type
	ld a, [de]
	cp STEEL
	jr z, .trap
	inc de
	ld a, [de]
	cp STEEL
	ret nz

	; trap player if steel type
.trap
	ld hl, wEnemySubStatus5
	bit SUBSTATUS_CANT_RUN, [hl]
	ret nz
	set SUBSTATUS_CANT_RUN, [hl]
	ret

INCLUDE "data/abilities/ability_mons/magnet_pull_mons.asm"