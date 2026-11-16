; =========================
; === Ability: Overcoat ===
; =========================
; Immune to powder moves (Spore, Sleep Powder, Stun Spore, Poison Powder)
; and to Sandstorm and Hail damage. Its popup only slides in when it
; blocks a powder move.
; BattleCommand_CheckPowder (effect_commands.asm) and HandleWeather
; (core3.asm) check it; the AI avoids powder moves against it and knows it
; takes no weather damage.

IsOvercoatSpecies::
; Carry if species a has Overcoat (not suppressed by Neutralizing Gas).
; Preserves bc, de, hl.
	push hl
	push de
	push bc
	ld hl, OvercoatPokemon
	call IsInAbilityList
	jmp PopBCDEHL

IsOvercoatSpeciesRaw:
; The same, even when suppressed. Preserves bc, de, hl.
	push hl
	push de
	push bc
	ld hl, OvercoatPokemon
	call IsInByteArray
	jmp PopBCDEHL

UserHasOvercoat::
; Carry if hBattleTurn's mon has Overcoat. Preserves bc, de, hl.
	push hl
	call GetCurrentMon
	pop hl
	jr IsOvercoatSpecies

TargetHasOvercoat::
; Carry if the other mon (not hBattleTurn's) has Overcoat, even when
; suppressed (ShowOvercoatPopupOnTarget then says so). Preserves bc, de, hl.
	call GetOpposingMon
	jr IsOvercoatSpeciesRaw

IsOvercoatBlockedMove::
; Carry if move a is a powder move Overcoat blocks. Preserves bc, de, hl.
	push hl
	push de
	push bc
	ld hl, OvercoatBlockedMoves
	call IsInByteArray
	jmp PopBCDEHL

ShowOvercoatPopupOnTarget::
; Slide in Overcoat's popup over the target's (not hBattleTurn's) HUD.
; Carry if suppressed by Neutralizing Gas (whose popup shows instead).
; Preserves bc, de, hl.
	push hl
	push de
	push bc
	ldh a, [hBattleTurn]
	xor 1
	ld c, a
	ld b, BANK(@)
	ld de, OvercoatText
	farcall ShowAbilityPopup
	jmp PopBCDEHL

OvercoatText: db "Overcoat@"

OvercoatBlockedMoves:
	db SPORE
	db SLEEP_POWDER
	db STUN_SPORE
	db POISONPOWDER
	db -1 ; end

INCLUDE "data/abilities/overcoat_mons.asm"
