BattleCommand_HitAndSwitch:
; for moves like uturn and volt switch

; Hit and Switch doesn't switch in link battles
;	ld a, [wLinkMode]
;	and a
;	ret nz

	ldh a, [hBattleTurn]
	and a
	jr nz, .Enemy

; Need something to switch to
	call CheckAnyOtherAlivePartyMons
	ret z

	call UpdateBattleMonInParty

	ld c, 20
	call DelayFrames

; Transition into switchmon menu
	call SwitchMoveTransitionIntoMenu

; Return to battle scene
	call SwitchMoveReturnToBattleScene

	ld hl, SwitchPlayerMon
	call CallBattleCore
	ld hl, SpikesDamage
	jmp CallBattleCore

.Enemy:
; Wildmons don't have anything to switch to
	ld a, [wBattleMode]
	cp WILD_BATTLE
	ret z

	call CheckAnyOtherAliveEnemyMons
	ret z

	call UpdateEnemyMonInParty

; Passed enemy PartyMon entrance
	farcall EnemyUTurnSwitch
	ld hl, SpikesDamage
	jmp CallBattleCore

SwitchMoveTransitionIntoMenu:
	call LoadStandardMenuHeader
	farcall SetUpBattlePartyMenu
	farcall ForcePickSwitchMonInBattle
	ret

SwitchMoveReturnToBattleScene:
	call ClearPalettes
	farcall LoadBattleFontsHPBar
	call CloseWindow
	call ClearSprites
	hlcoord 1, 0
	lb bc, 4, 10
	call ClearBox
	ld b, SCGB_BATTLE_COLORS
	call GetSGBLayout
	jmp SetDefaultBGPAndOBP
