; =============================
; === Ability: Suction Cups ===
; =============================
; A Suction Cups mon can't be forced out by Roar or Whirlwind (in a wild
; battle too: it doesn't flee or run). Its popup slides in over its HUD
; when one of them is used on it (BattleCommand_ForceSwitch).

IsSuctionCupsSpecies::
; Carry if species a has Suction Cups. Preserves bc, de, hl.
	push hl
	push de
	push bc
	ld hl, SuctionCupsPokemon
	call IsInByteArray
	jmp PopBCDEHL

SuctionCupsBlocksForceSwitch::
; Carry if the target (not hBattleTurn's mon) has Suction Cups: then show
; its popup over the target's HUD.
	call GetOpposingMon
	call IsSuctionCupsSpecies
	ret nc
	ld b, BANK(@)
	ldh a, [hBattleTurn]
	xor 1
	ld c, a ; the target's side
	ld de, SuctionCupsText
	farcall ShowAbilityPopup
	scf
	ret

SuctionCupsText: db "Suction Cups@"
INCLUDE "data/abilities/suction_cups_mons.asm"
