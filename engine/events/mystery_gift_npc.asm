MysteryGiftNPC:
	ld hl, NPC_MysteryGiftItems
	call Random
.loop
	sub [hl]
	jr c, .ok
	inc hl
	inc hl
	jr .loop

.ok
	ld a, [hli]
	inc a
	jr z, .failsafe
	ld a, [hli]
	jr .done

	; failsafe item if one from the list wasn't chosen
.failsafe
	ld a, BERRY
.done
	ld [wScriptVar], a
	ret

INCLUDE "data/items/npc_mystery_gift_items.asm"
