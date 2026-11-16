; ============================
; === Ability: Sticky Hold ===
; ============================
; The foe's moves and Abilities can't take the mon's held item: Knock Off
; (and the Disarm Ability, which uses it), Thief and Trick. Its popup slides
; in over its HUD whenever it keeps its item.

IsStickyHoldSpecies::
; Carry if species a has Sticky Hold. Preserves bc, de, hl.
	push hl
	push de
	push bc
	ld hl, StickyHoldPokemon
	call IsInAbilityList
	jmp PopBCDEHL

IsStickyHoldSpeciesRaw:
; The same, even when suppressed by Neutralizing Gas. Preserves bc, de, hl.
	push hl
	push de
	push bc
	ld hl, StickyHoldPokemon
	call IsInByteArray
	jmp PopBCDEHL

StickyHoldBlocks::
; Carry if the target (not hBattleTurn's mon) has Sticky Hold; its popup
; then slides in over the target's HUD. Preserves bc, de, hl.
	call GetOpposingMon
	call IsStickyHoldSpeciesRaw
	ret nc
	push hl
	push de
	push bc
	ldh a, [hBattleTurn]
	xor 1
	ld c, a
	ld b, BANK(@)
	ld de, StickyHoldText
	farcall ShowAbilityPopup
	pop bc
	pop de
	pop hl
	ccf ; (not if suppressed by Neutralizing Gas: its popup showed)
	ret

StickyHoldText: db "Sticky Hold@"
INCLUDE "data/abilities/sticky_hold_mons.asm"
