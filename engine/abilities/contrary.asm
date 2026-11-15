; =========================
; === Ability: Contrary ===
; =========================
; A Contrary mon's stat changes are turned around: raising one of its stats
; lowers it instead and vice versa, whoever causes it (its own moves like
; Swords Dance or Close Combat, the foe's Growl or Intimidate...). Its
; popup slides in over its HUD right before each such stat change.
; RaiseStat, BattleCommand_StatDown and LowerStat in effect_commands.asm do
; the opposite change and set wContraryInverted, so the next stat message
; (or fail text) prints the opposite one too.

IsContrarySpecies::
; Carry if species a has Contrary. Preserves bc, de, hl.
	push hl
	push de
	push bc
	ld hl, ContraryPokemon
	call IsInByteArray
	jmp PopBCDEHL

ShowContraryPopupOnSide::
; Slide in Contrary's popup over side a's HUD
; (ABILITY_POPUP_PLAYER / ABILITY_POPUP_ENEMY). Preserves bc, de, hl.
	push hl
	push de
	push bc
	ld c, a
	ld b, BANK(@)
	ld de, ContraryText
	farcall ShowAbilityPopup
	ld a, TRUE
	ld [wContraryInverted], a
	jmp PopBCDEHL

ContraryText: db "Contrary@"

INCLUDE "data/abilities/contrary_mons.asm"
