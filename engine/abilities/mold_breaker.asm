; =============================
; === Ability: Mold Breaker ===
; =============================
; A Mold Breaker mon's moves ignore the target's Levitate, Sturdy, Unaware,
; Multiscale, Flame Ward, Grounded, Waterproof, Immunity, Thick Fat,
; Pillow Fort and Chrysalis Hide. Its popup shows every time it ignores
; one of them.
; Those abilities call MoldBreakerBypass (or AttackerHasMoldBreaker, where
; no popup should show, e.g. in the AI's damage estimates) with newfarcall
; once they know they'd apply.

AttackerHasMoldBreaker::
; Carry if the mon whose turn it is (hBattleTurn) has Mold Breaker.
; Preserves bc, de, hl.
	push hl
	push de
	push bc
	call GetCurrentMon
	ld hl, MoldBreakerPokemon
	call IsInAbilityList
	jmp PopBCDEHL

MoldBreakerBypass::
; Carry if the attacker has Mold Breaker, so the target's ability is
; ignored: then show Mold Breaker's popup.
; Preserves bc, de, hl.
	call AttackerHasMoldBreaker
	ret nc
	; fallthrough

ShowMoldBreakerPopup:
	push hl
	push de
	push bc
	ld b, BANK(@)
	ldh a, [hBattleTurn]
	ld c, a ; ABILITY_POPUP_PLAYER / ABILITY_POPUP_ENEMY
	ld de, MoldBreakerText
	farcall ShowAbilityPopup
	pop bc
	pop de
	pop hl
	scf
	ret

MoldBreakerIgnoresSturdy::
; Carry if the attacker has Mold Breaker. The popup only shows if Sturdy
; would have saved the target: it's at full HP and this hit (wCurDamage)
; would knock it out. Preserves bc, de, hl.
	call AttackerHasMoldBreaker
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
	call nc, ShowMoldBreakerPopup ; damage >= HP
.done
	pop bc
	pop de
	pop hl
	scf
	ret

MoldBreakerText: db "Mold Breaker@"

INCLUDE "data/abilities/mold_breaker_mons.asm"
