; =================================
; === Ability: Neutralizing Gas ===
; =================================
; While a Neutralizing Gas mon is out (and standing), the other mon's ability
; has no effect (two Neutralizing Gas mons cancel each other out: nothing is
; suppressed). wNeutralizingGas says which side is suppressed; it's worked
; out whenever a mon comes in (UpdateNeutralizingGas) and IsSideSuppressed
; (home/extra_functions.asm) also checks the Neutralizing Gas mon still has
; HP.
;
; - Abilities without a popup are simply off: their species list checks use
;   IsInAbilityList (the AI's too, so it plays around it).
; - Abilities with a popup show Neutralizing Gas's popup instead, at the same
;   moment and as often: ShowAbilityPopup (and the once-per-send-out popups)
;   swap it and return carry, and the ability then skips its effect (the
;   popup macros do `ret c`). Abilities checked right where they act use
;   IsInAbilityListNG, which shows the popup itself.
; - When it comes in, its own popup and "Neutralizing gas filled the area!"
;   show before any other entry ability.
; - When it leaves, the foe's entry abilities go off (the foe's mon "comes
;   in" again as far as they're concerned).

IsNeutralizingGasSpecies::
; Carry if species a has Neutralizing Gas. Preserves bc, de, hl.
	push hl
	push de
	push bc
	ld hl, NeutralizingGasPokemon
	call IsInByteArray
	jmp PopBCDEHL

UpdateNeutralizingGas::
; Work out wNeutralizingGas for the mons now out. A side that was suppressed
; and isn't anymore gets its entry abilities queued (they couldn't act while
; the gas was out).
	ld a, [wBattleMonSpecies]
	call IsNeutralizingGasSpecies
	sbc a
	and %10 ; the player's gas suppresses the enemy
	ld b, a
	ld a, [wEnemyMonSpecies]
	call IsNeutralizingGasSpecies
	sbc a
	and %01 ; the enemy's suppresses the player
	or b
	cp %11
	jr nz, .got_bits
	xor a ; both: they cancel out
.got_bits
	ld b, a
	ld a, [wNeutralizingGas]
	ld c, a
	ld a, b
	ld [wNeutralizingGas], a
	; c = suppressed before, b = now: the sides that are free again
	ld a, b
	cpl
	and c
	ret z
	ld hl, wEntryAbilitiesPending
	bit 0, a
	jr z, .enemy
	set ENTRY_ABILITIES_PLAYER_F, [hl]
.enemy
	bit 1, a
	ret z
	set ENTRY_ABILITIES_ENEMY_F, [hl]
	ret

AnnounceNeutralizingGas::
; Before the entry abilities of the pending sides go off: for each of them
; whose new mon has Neutralizing Gas, its popup and text (in link battle
; order). Only once both mons are out, like the entry abilities.
	ld hl, wBattleMonHP
	ld a, [hli]
	or [hl]
	ret z
	ld hl, wEnemyMonHP
	ld a, [hli]
	or [hl]
	ret z
	ldh a, [hBattleTurn]
	push af
	ldh a, [hSerialConnectionStatus]
	cp USING_EXTERNAL_CLOCK
	jr z, .enemy_first
	call .player
	call .enemy
	jr .done
.enemy_first
	call .enemy
	call .player
.done
	pop af
	ldh [hBattleTurn], a
	ret

.player
	ld a, [wEntryAbilitiesPending]
	bit ENTRY_ABILITIES_PLAYER_F, a
	ret z
	ld a, [wBattleMonSpecies]
	ld c, 0
	jr .side

.enemy
	ld a, [wEntryAbilitiesPending]
	bit ENTRY_ABILITIES_ENEMY_F, a
	ret z
	ld a, [wEnemyMonSpecies]
	ld c, 1
.side
	call IsNeutralizingGasSpecies
	ret nc
	ld a, c
	ldh [hBattleTurn], a
	push bc
	farcall EmptyBattleTextbox
	pop bc
	ld b, BANK(NeutralizingGasPopupText)
	ld de, NeutralizingGasPopupText
	farcall ShowAbilityPopup
	ld hl, NeutralizingGasBattleText
	call StdBattleTextbox
	; (a Levitate mon's HUD loses its float icon)
	farjp RefreshBattleHuds

NGIgnoresSturdy::
; Carry if the target's Sturdy is suppressed by Neutralizing Gas. Its popup
; then shows if Sturdy would have saved the target: it's at full HP and this
; hit (wCurDamage) would knock it out. Preserves bc, de, hl.
	ldh a, [hBattleTurn]
	xor 1
	call IsSideSuppressed
	ret nc
	push hl
	push de
	push bc
	farcall CheckOpponentFullHP
	jr nz, .done
	ld hl, wEnemyMonHP
	ldh a, [hBattleTurn]
	and a
	jr z, .got_hp
	ld hl, wBattleMonHP
.got_hp
	ld a, [hli]
	ld b, a
	ld c, [hl]
	ld a, [wCurDamage + 1]
	sub c
	ld a, [wCurDamage]
	sbc b
	jr c, .done ; it survives anyway
	ldh a, [hBattleTurn]
	xor 1
	ld c, a ; the target's side: its popup is swapped for Neutralizing Gas's
	ld b, BANK(NeutralizingGasPopupText)
	ld de, NeutralizingGasPopupText
	farcall ShowAbilityPopup
.done
	pop bc
	pop de
	pop hl
	scf
	ret

INCLUDE "data/abilities/neutralizing_gas_mons.asm"
