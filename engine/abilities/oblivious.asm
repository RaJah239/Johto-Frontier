; ==========================
; === Ability: Oblivious ===
; ==========================
; The mon can't be infatuated (Attract, the Allure Ability) or taunted, and
; Intimidate doesn't lower its Attack. Its popup slides in over its HUD only
; when it blocks one of these.

IsObliviousSpecies::
; Carry if species a has Oblivious. Preserves bc, de, hl.
	push hl
	push de
	push bc
	ld hl, ObliviousPokemon
	call IsInAbilityList
	jmp PopBCDEHL

IsObliviousSpeciesRaw:
; The same, even when suppressed by Neutralizing Gas. Preserves bc, de, hl.
	push hl
	push de
	push bc
	ld hl, ObliviousPokemon
	call IsInByteArray
	jmp PopBCDEHL

ObliviousBlocks::
; Carry if the target (not hBattleTurn's mon) has Oblivious; its popup then
; slides in over the target's HUD. Preserves bc, de, hl.
	call GetOpposingMon
	call IsObliviousSpeciesRaw
	ret nc
	push hl
	push de
	push bc
	ldh a, [hBattleTurn]
	xor 1
	ld c, a
	ld b, BANK(@)
	ld de, ObliviousText
	farcall ShowAbilityPopup
	pop bc
	pop de
	pop hl
	ccf ; (not if suppressed by Neutralizing Gas: its popup showed)
	ret

ObliviousText: db "Oblivious@"
INCLUDE "data/abilities/oblivious_mons.asm"
