BattleCommand_CloseCombat:
	ld a, [wAttackMissed]
	and a
	ret nz

	ld a, DEFENSE
	ld [wLoweredStat], a
	farcall LowerStatFar
	farcall BattleCommand_SwitchTurn
	farcall BattleCommand_StatDownMessage
	farcall ResetMiss
	farcall BattleCommand_SwitchTurn
	ld a, SP_DEFENSE
	ld [wLoweredStat], a
	farcall LowerStatFar
	farcall BattleCommand_SwitchTurn
	farcall BattleCommand_StatDownMessage
	farcall ResetMiss
	farjp BattleCommand_SwitchTurn
