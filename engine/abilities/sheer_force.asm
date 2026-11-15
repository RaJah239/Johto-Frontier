; ============================
; === Ability: Sheer Force ===
; ============================
; A Sheer Force mon's moves with a secondary effect (an effect chance, like
; Bite's flinch or Flamethrower's burn) do 1.3x damage (HandleSheerForce in
; boosting_abilities.asm), and the effect never happens
; (BattleCommand_EffectChance). Its popup shows when it's sent out
; (HandleSheerForce in entry_abilities.asm).

SheerForceApplies::
; Carry if the mon whose turn it is (hBattleTurn) has Sheer Force and is
; using a damaging move with a secondary effect. Preserves bc, de, hl.
	push hl
	push de
	push bc
	call GetCurrentMon
	ld hl, SheerForcePokemon
	call IsInByteArray
	jr nc, .done
	ld hl, wPlayerMoveStruct
	ldh a, [hBattleTurn]
	and a
	jr z, .got_move
	ld hl, wEnemyMoveStruct
.got_move
	; a damaging move...
	ld de, MOVE_POWER
	add hl, de
	ld a, [hl]
	and a
	jr z, .done ; nc
	; ...with an effect chance...
	ld de, MOVE_CHANCE - MOVE_POWER
	add hl, de
	ld a, [hl]
	and a
	jr z, .done ; nc
	; ...that is a secondary effect (not Thief or Knock Off's item steal)
	ld de, MOVE_EFFECT - MOVE_CHANCE
	add hl, de
	ld a, [hl]
	cp EFFECT_THIEF
	jr z, .no
	cp EFFECT_KNOCK_OFF
	jr z, .no
	scf
	jr .done

.no
	and a
.done
	jmp PopBCDEHL

ShowSheerForcePopup::
; Slide in Sheer Force's popup over the acting side's HUD.
	ld b, BANK(@)
	ldh a, [hBattleTurn]
	ld c, a ; ABILITY_POPUP_PLAYER / ABILITY_POPUP_ENEMY
	ld de, SheerForceText
	farjp ShowAbilityPopup

AttackerHasSheerForce::
; Carry if the mon whose turn it is (hBattleTurn) has Sheer Force.
	call GetCurrentMon
	ld hl, SheerForcePokemon
	jmp IsInByteArray

SheerForceText: db "Sheer Force@"

INCLUDE "data/abilities/sheer_force_mons.asm"
