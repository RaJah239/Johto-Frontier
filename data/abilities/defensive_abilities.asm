DefensiveAbilities:
	call HandleLevitate
	ret

HandleLevitate:
    ldh a, [hBattleTurn]
	and a
	ld a, [wEnemyMoveStruct + MOVE_TYPE]
	jr nz, .checkType
	ld a, [wPlayerMoveStruct + MOVE_TYPE]
.checkType
	and TYPE_MASK
	cp GROUND
    ret nz

	ldh a, [hBattleTurn]
	and a
	ld a, [wEnemyMonSpecies]
	jr z, .check_levitate
	ld a, [wBattleMonSpecies]

.check_levitate
	ld hl, LevitatePokemon
	call IsInByteArray
    ret nc

    ; add some delay so the text 
    ; isn't instantly skipped
	ld c, 30
	call DelayFrames

	ld hl, LevitateText
	call StdBattleTextbox
	ld a, 1
	ld [wAttackMissed], a
	ret
