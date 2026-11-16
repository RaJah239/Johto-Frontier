BattleCommand_Teleport:
; Wild battles: the user escapes (the wild mon flees, or the player runs
; away) from a higher-level foe, always; against a lower-level foe it always
; fails; at the same level it's a 50% chance.
; Trainer battles: the user switches out, like a switch (the player picks the
; mon, the AI picks its best one). Teleport's priority is 0, so it goes last.
; It fails in scripted battles, when the user is trapped (Mean Look, Spider
; Web, a trapping ability, bound by Wrap...; Run Away escapes those), and
; with no other mon to switch to.
	ld a, [wBattleType]
	cp BATTLETYPE_FORCESHINY
	jr z, .failed
	cp BATTLETYPE_TRAP
	jr z, .failed
	cp BATTLETYPE_CELEBI
	jr z, .failed
	cp BATTLETYPE_SUICUNE
	jr z, .failed

	newfarcall TeleportUserTrapped ; engine/battle/core.asm
	jr c, .failed

	ld a, [wBattleMode]
	dec a
	jr nz, .switch

	; wild battle: b = the user's level, c = the foe's
	ld a, [wBattleMonLevel]
	ld b, a
	ld a, [wCurPartyLevel] ; the wild mon's level
	ld c, a
	ldh a, [hBattleTurn]
	and a
	jr z, .got_levels
	ld a, b ; the wild mon uses it
	ld b, c
	ld c, a
.got_levels
	ld a, b
	cp c
	jr c, .run_away ; the foe is higher level: it escapes
	jr nz, .failed ; the user is higher level: it fails
	call BattleRandom ; same level: 50%
	cp 50 percent
	jr c, .run_away

.failed
	call AnimateFailedMove
	jmp PrintButItFailed

.switch
	ldh a, [hBattleTurn]
	and a
	jr nz, .enemy_switch
	call CheckAnyOtherAlivePartyMons
	jr z, .failed
	call AnimateCurrentMove
	jmp SwitchOutPlayerMon ; engine/battle/move_effects/hitandswitch.asm

.enemy_switch
	call CheckAnyOtherAliveEnemyMons
	jr z, .failed
	call AnimateCurrentMove
	jmp SwitchOutEnemyMon

.run_away
	call UpdateBattleMonInParty
	xor a
	ld [wNumHits], a
	inc a
	ld [wForcedSwitch], a
	ld [wBattleAnimParam], a
	call SetBattleDraw
	call BattleCommand_LowerSub
	call LoadMoveAnim
	ld c, 20
	call DelayFrames
	call SetBattleDraw

	ld hl, FledFromBattleText
	jmp StdBattleTextbox
