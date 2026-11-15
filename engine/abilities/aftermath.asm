; ==========================
; === Ability: Aftermath ===
; ==========================
; When a damaging move knocks out a mon with Aftermath, the move's user
; loses 1/4 of its max HP. Its popup slides in over the fainted mon's HUD
; before the damage. KOs that aren't from the foe's own attack don't count:
; poison, weather and other residual damage, Destiny Bond, and the
; damage-reflecting Counter and Mirror Coat. A Magic Guard user takes no
; damage.

AftermathOnKO::
; Called from BattleCommand_CheckFaint once hBattleTurn's move has
; knocked out the target.
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_COUNTER
	ret z
	cp EFFECT_MIRROR_COAT
	ret z

	call GetOpposingMon
	ld hl, AftermathPokemon
	call IsInByteArray
	ret nc

	; the user must still be standing (Explosion, recoil, Life Orb...)
	call GetCurrentMon
	ld a, [hli]
	or [hl]
	ret z

	; Magic Guard: no indirect damage
	call GetCurrentMon
	ld hl, MagicGuardPokemon
	call IsInByteArray
	ret c

	ldh a, [hBattleTurn]
	xor 1
	ld c, a
	ld b, BANK(@)
	ld de, AftermathText
	farcall ShowAbilityPopup

	farcall GetQuarterMaxHP
	farcall SubtractHPFromUser
	ld hl, AftermathBattleText
	jmp StdBattleTextbox

AftermathText: db "Aftermath@"

INCLUDE "data/abilities/aftermath_mons.asm"
