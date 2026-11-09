; Switch-in picker, from repo A (FindMonInOTPartyToSwitchIntoBattle there).

FindForcedReplacementInOTParty:
	; the mon that wins the 1-on-1 taking the least damage, if any
	; (AI_MatchupPick, engine/battle/ai/matchup.asm)
	farcall AI_MatchupPick
	ld a, b
	cp $ff
	ret nz
; Which OT mon to send out when the enemy has to replace its active mon (a
; KO, U-turn, Baton Pass, Shift mode): FindMonInOTPartyToSwitchIntoBattle,
; keeping the battle state it overwrites while it scans (U-turn and Baton
; Pass call this in the middle of a move: SpikesDamage needs hBattleTurn).
; Returns the 0-based party index in b.
	ldh a, [hBattleTurn]
	push af
	ld a, [wCurDamage]
	push af
	ld a, [wCurDamage + 1]
	push af
	ld a, [wTypeMatchup]
	push af
	ld a, [wTypeModifier]
	push af
	ld hl, wEnemyMoveStruct
	ld de, wSwitchInSavedEnemyMove
	ld bc, MOVE_LENGTH
	call CopyBytes
	ld hl, wPlayerMoveStruct
	ld de, wSwitchInSavedPlayerMove
	ld bc, MOVE_LENGTH
	call CopyBytes

	call FindMonInOTPartyToSwitchIntoBattle

	push bc
	ld hl, wSwitchInSavedEnemyMove
	ld de, wEnemyMoveStruct
	ld bc, MOVE_LENGTH
	call CopyBytes
	ld hl, wSwitchInSavedPlayerMove
	ld de, wPlayerMoveStruct
	ld bc, MOVE_LENGTH
	call CopyBytes
	pop bc
	pop af
	ld [wTypeModifier], a
	pop af
	ld [wTypeMatchup], a
	pop af
	ld [wCurDamage + 1], a
	pop af
	ld [wCurDamage], a
	pop af
	ldh [hBattleTurn], a
	ret

FindMonInOTPartyToSwitchIntoBattle:
; Score each alive OT mon (not the active one, not asleep or frozen): does it
; have a super-effective move against the player's mon, and is it weak to one
; of the player's mon's moves? ScoreMonTypeMatchups then picks one.
; Returns the 0-based party index in b.
	ld b, -1
	ld a, %000001
	ld [wEnemyEffectivenessVsPlayerMons], a
	ld [wPlayerEffectivenessVsEnemyMons], a
.loop ; this loops through enemy pokemon
	ld hl, wEnemyEffectivenessVsPlayerMons
	sla [hl]
	inc hl ; wPlayerEffectivenessVsEnemyMons
	sla [hl]
	inc b ; b is the index of the current poke in loop

	ld a, [wOTPartyCount]
	cp b ; if b is equal to partyCount we have done all pokes
	jmp z, ScoreMonTypeMatchups ; get final scores if finished all pokes

	ld a, [wCurOTMon]
	cp b
	jr z, .discourage ; don't switch to the poke already out

	ld hl, wOTPartyMon1HP
	push bc
	ld a, b
	call GetPartyLocation
	ld a, [hli]
	ld c, a
	ld a, [hl]
	or c
	pop bc
	jr z, .discourage

	ld hl, wOTPartyMon1Status
	push bc
	ld a, b
	call GetPartyLocation
	ld a, [hl]
	and 1 << FRZ | SLP_MASK
	pop bc
	jr nz, .discourage ; don't switch to a sleeping or frozen mon

	call LookUpTheEffectivenessOfEveryEnemyMove ; does this mon have a SE move on the player?
	call AreThePlayerMonMovesEffectiveAgainstOTMon ; does the player have a SE move on this mon?
	jr .loop

.discourage
	ld hl, wPlayerEffectivenessVsEnemyMons
	set 0, [hl]
	jr .loop

LookUpTheEffectivenessOfEveryEnemyMove:
	push bc
	ld hl, wOTPartyMon1Moves
	ld a, b ; b is index of current enemy mon in the loop, now in a
	call GetPartyLocation ; increments hl so we have the current enemy mon moves
	pop bc
	ld e, NUM_MOVES + 1
.loop
	dec e
	jr z, .done ; done when we are out of moves
	ld a, [hli] ; a is the current move
	and a
	jr z, .done
	push hl
	push de
	push bc
	dec a
	ld hl, Moves
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld de, wEnemyMoveStruct
	ld a, BANK(Moves)
	call FarCopyBytes
	call SetEnemyTurn
	callfar BattleCheckTypeMatchup
	pop bc
	pop de
	pop hl
	ld a, [wTypeMatchup]
	cp EFFECTIVE + 1
	jr c, .loop
	ld hl, wEnemyEffectivenessVsPlayerMons
	set 0, [hl]
	ret

.done
	ret

AreThePlayerMonMovesEffectiveAgainstOTMon:
; Calculates the effectiveness of the types of the PlayerMon
; against the OTMon
	push bc
	ld hl, wOTPartyCount ; how many enemy mon are there
	ld a, b ; a is now current enemy poke index
	inc a
	ld c, a ; c is index of the next enemy mon
	ld b, 0
	add hl, bc ; increment hl to to current enemy mon in the loop
	ld a, [hl] ; a is the current enemy mon
	call GetBaseDataPointer
	ld bc, BASE_TYPES
	add hl, bc ; the current enemy mon's types
	ld de, wEnemyMonType
	ld bc, BASE_CATCH_RATE - BASE_TYPES
	call FarCopyBytes ; at this point wEnemyMonType contains both enemy types in de
	ld hl, wBattleMonMoves ; load player moves
	ld e, NUM_MOVES + 1 ; didn't have much choice but to override e
.checkmove
	dec e ; e is num moves on 1st pass
	jr z, .done ; if b is 0 return we are done
	ld a, [hl] ; load the move
	and a
	jr z, .done ; return if no move
	inc hl ; increment to next move
	push hl
	push de
	dec a
	ld hl, Moves
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld de, wPlayerMoveStruct
	ld a, BANK(Moves)
	call FarCopyBytes
	call SetPlayerTurn
	callfar BattleCheckTypeMatchup ; consider type matchup
	pop de
	pop hl
	ld a, [wTypeMatchup]
	cp EFFECTIVE + 1
	jr nc, .super_effective
	jr .checkmove

.super_effective ; here the current enemy mon is discouraged due to being weak to player type
	pop bc
	ld hl, wEnemyEffectivenessVsPlayerMons
	bit 0, [hl]
	jr nz, .reset
	inc hl ; wPlayerEffectivenessVsEnemyMons
	set 0, [hl]
	ret

.reset
	res 0, [hl]
	ret

.done
	pop bc
	ret

ScoreMonTypeMatchups:
.loop1
	ld hl, wEnemyEffectivenessVsPlayerMons
	sla [hl]
	inc hl ; wPlayerEffectivenessVsEnemyMons
	sla [hl]
	jr nc, .loop1
	ld a, [wOTPartyCount]
	ld b, a
	ld c, [hl]
.loop2
	sla c
	jr nc, .okay
	dec b
	jr z, .loop5
	jr .loop2

.okay
	ld a, [wEnemyEffectivenessVsPlayerMons]
	and a
	jr z, .okay2
	ld b, -1
	ld c, a
.loop3
	inc b
	sla c
	jr nc, .loop3
	jr .quit

.okay2
	ld b, -1
	ld a, [wPlayerEffectivenessVsEnemyMons]
	ld c, a
.loop4
	inc b
	sla c
	jr c, .loop4
	jr .quit

.loop5
	call FindRandomMonForSwitch
.quit
	ret

FindRandomMonForSwitch:
; b = a random alive OT mon other than the active one (there must be one)
.randLoop
	ld a, [wOTPartyCount]
	ld b, a
	call BattleRandom
	and $7
	cp b
	jr nc, .randLoop
	ld b, a
	ld a, [wCurOTMon]
	cp b
	jr z, .randLoop
	ld hl, wOTPartyMon1HP
	push bc
	ld a, b
	call GetPartyLocation
	pop bc
	ld a, [hli]
	ld c, a
	ld a, [hl]
	or c
	jr z, .randLoop
	ret
