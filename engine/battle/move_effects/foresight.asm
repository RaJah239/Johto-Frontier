BattleCommand_Foresight:
; foresight

	ld a, [wAttackMissed]
	and a
	jr nz, .failed

	farcall CheckHiddenOpponent
	jr nz, .failed

	ld a, BATTLE_VARS_SUBSTATUS1_OPP
	call GetBattleVarAddr
	bit SUBSTATUS_IDENTIFIED, [hl]
	jr nz, .failed

	set SUBSTATUS_IDENTIFIED, [hl]
	farcall AnimateCurrentMove
	ld hl, IdentifiedText
	jmp StdBattleTextbox

.failed
	farjp FailMove
