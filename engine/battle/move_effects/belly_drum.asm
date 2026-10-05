BattleCommand_BellyDrum:
	callfar GetHalfMaxHP
 	callfar CheckUserHasEnoughHP
 	jr nc, .failed
 
 	push bc
	farcall BattleCommand_AttackUp2
	pop bc
	ld a, [wAttackMissed]
	and a
	jr nz, .failed

	push bc
	farcall AnimateCurrentMove
	pop bc
	callfar SubtractHPFromUser
	farcall UpdateUserInParty
	ld a, MAX_STAT_LEVEL - BASE_STAT_LEVEL - 1

.max_attack_loop
	push af
	farcall BattleCommand_AttackUp2
	pop af
	dec a
	jr nz, .max_attack_loop

	ld hl, BellyDrumText
	jmp StdBattleTextbox

.failed
	farcall AnimateFailedMove
	farjp PrintButItFailed
