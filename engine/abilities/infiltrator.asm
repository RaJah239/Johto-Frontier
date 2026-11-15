; ============================
; === Ability: Infiltrator ===
; ============================
; The user's moves ignore the foe's Substitute, Reflect, Light Screen,
; Safeguard and Mist. Each place in effect_commands.asm that one of these
; would stop calls InfiltratorBypass only once it's up, so the popup shows
; over the user's HUD the first time it actually gets past one after it's
; sent out.

InfiltratorBypass::
; Carry if hBattleTurn's mon has Infiltrator; its popup then shows (once
; per send-out). Preserves bc, de, hl.
	push hl
	push de
	push bc
	call GetCurrentMon
	ld hl, InfiltratorPokemon
	call IsInByteArray
	jr nc, .done
	ldh a, [hBattleTurn]
	ShowOncePerSendOutPopupOnSide SEND_OUT_POPUP_INFILTRATOR, InfiltratorText
	scf
.done
	jmp PopBCDEHL

InfiltratorText: db "Infiltrator@"

INCLUDE "data/abilities/infiltrator_mons.asm"
