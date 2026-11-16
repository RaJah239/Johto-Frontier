BattleCommand_Teleport:
; Wild battles: the user escapes (the wild mon flees, or the player runs
; away). Only when both mons are the same level it's a 50% chance.
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

	; wild battle: same level, 50% chance; otherwise it always works
	ld a, [wCurPartyLevel] ; the wild mon's level
	ld b, a
	ld a, [wBattleMonLevel]
	cp b
	jr nz, .run_away
	call BattleRandom
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
