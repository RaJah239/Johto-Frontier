; ============================
; === Ability: Infiltrator ===
; ============================
; The user's moves ignore the foe's Substitute, Reflect, Light Screen,
; Safeguard and Mist. Each place in effect_commands.asm that one of these
; would stop calls InfiltratorBypass once it's up. Passive: no popup.

InfiltratorBypass::
; Carry if hBattleTurn's mon has Infiltrator (and Neutralizing Gas doesn't
; suppress it). Preserves bc, de, hl.
	push hl
	push de
	push bc
	call GetCurrentMon
	ld hl, InfiltratorPokemon
	call IsInByteArray
	jr nc, .done
	ldh a, [hBattleTurn]
	call IsSideSuppressed
	ccf ; (no bypass if suppressed by Neutralizing Gas)
.done
	jmp PopBCDEHL


INCLUDE "data/abilities/infiltrator_mons.asm"
