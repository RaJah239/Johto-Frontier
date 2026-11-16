; ========================
; === Ability: Scrappy ===
; ========================
; A Scrappy mon's Normal and Fighting moves hit Ghost types (like Foresight:
; CheckIgnoreGhostImmunity in effect_commands.asm), and it isn't affected by
; Intimidate. Its popup shows when it's sent out (HandleScrappy in
; entry_abilities.asm) and when it blocks Intimidate (HandleIntimidate).

IsScrappySpecies::
; Carry if species a has Scrappy. Preserves bc, de, hl.
	push hl
	push de
	push bc
	ld hl, ScrappyPokemon
	call IsInByteArray
	jmp PopBCDEHL

AttackerHasScrappy::
; Carry if the mon whose turn it is (hBattleTurn) has Scrappy (and it isn't
; suppressed by Neutralizing Gas). Preserves bc, de, hl.
	push hl
	call GetCurrentMon
	call IsSpeciesSuppressed
	pop hl
	ccf
	ret nc
	jr IsScrappySpecies

AttackerHasScrappyRaw::
; The same, even when suppressed (for its popup: Neutralizing Gas's shows).
	push hl
	call GetCurrentMon
	pop hl
	jr IsScrappySpecies

TargetHasScrappy::
; Carry if the other mon (not hBattleTurn's) has Scrappy.
; Preserves bc, de, hl.
	call GetOpposingMon
	jr IsScrappySpecies

ShowScrappyPopupOnSide::
; Slide in Scrappy's popup over side a's HUD
; (ABILITY_POPUP_PLAYER / ABILITY_POPUP_ENEMY). Preserves bc, de, hl.
	push hl
	push de
	push bc
	ld c, a
	ld b, BANK(@)
	ld de, ScrappyText
	farcall ShowAbilityPopup ; (carry if suppressed by Neutralizing Gas)
	jmp PopBCDEHL

ScrappyText:: db "Scrappy@"

INCLUDE "data/abilities/scrappy_mons.asm"
