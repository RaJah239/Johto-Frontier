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
	jr SwitchOutPlayerMon

.Enemy:
; Wildmons don't have anything to switch to
	ld a, [wBattleMode]
	cp WILD_BATTLE
	ret z

	call CheckAnyOtherAliveEnemyMons
	ret z
	; fallthrough

SwitchOutEnemyMon:
; The enemy's mon switches out (U-turn, Teleport): the AI picks the mon.
	call UpdateEnemyMonInParty

	farcall RegeneratorShowEnemy

; Passed enemy PartyMon entrance
	farcall EnemyUTurnSwitch
	ld hl, SpikesDamage
	jmp CallBattleCore

SwitchOutPlayerMon:
; The player's mon switches out (U-turn, Teleport): the player picks the mon.
	call UpdateBattleMonInParty

	ld c, 20
	call DelayFrames

	farcall RegeneratorShowPlayer

; Transition into switchmon menu
	call SwitchMoveTransitionIntoMenu

; Return to battle scene
	call SwitchMoveReturnToBattleScene

	ld hl, SwitchPlayerMon
	call CallBattleCore
	ld hl, SpikesDamage
	jmp CallBattleCore

SwitchMoveTransitionIntoMenu:
	call LoadStandardMenuHeader
	farcall SetUpBattlePartyMenu
	farjp ForcePickSwitchMonInBattle

SwitchMoveReturnToBattleScene:
	call ClearPalettes
	farcall LoadBattleFontsHPBar
	call ExitMenu
	call ClearSprites
	; The outgoing mon has left. Remove it before showing the restored
	; battle screen, and leave the opponent's HUD intact.
	xor a
	ldh [hBGMapMode], a
	hlcoord 1, 5
	lb bc, 7, 8
	call ClearBox
	hlcoord 9, 7
	lb bc, 5, 11
	call ClearBox
	call WaitBGMap
	ld b, SCGB_BATTLE_COLORS
	call GetSGBLayout
	jmp SetDefaultBGPAndOBP
