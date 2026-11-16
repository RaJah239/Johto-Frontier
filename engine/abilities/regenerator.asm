; ===============================
; === Ability: Regenerator    ===
; ===============================
; A mon that switches out (not one that fainted) restores 1/3 of its max HP,
; rounded down, before it goes back. Each switch-out path calls
; RegeneratorShowPlayer / RegeneratorShowEnemy while the mon is still out
; (after Pursuit, before it's withdrawn): ability popup, then its HP bar fills.
; PlayerRegenerator / EnemyRegenerator run just before the incoming mon
; replaces it and heal silently, unless that already happened on screen
; (wRegeneratorShown), so no switch path can miss it.

RegeneratorShowPlayer:
; the HUD shows the mon in wCurBattleMon's party slot (its gender, shininess),
; which can already be the incoming mon's
	ld a, [wCurBattleMon]
	push af
	ld a, [wBattleMonPartySlot]
	ld [wCurBattleMon], a
	xor a
	call RegeneratorShow
	pop af
	ld [wCurBattleMon], a
	ret

RegeneratorShowEnemy:
	ld a, [wBattleMode]
	cp TRAINER_BATTLE
	ret nz
	ld a, [wCurOTMon]
	cp PARTY_LENGTH
	ret nc
	ld a, 1
	; fallthrough

RegeneratorShow:
; a = side (0: player, 1: enemy)
	ld c, a
	ldh a, [hBGMapMode]
	push af
	ldh a, [hBattleTurn]
	push af
	ld a, c
	ldh [hBattleTurn], a
	call .Show
	pop af
	ldh [hBattleTurn], a
	; the HP bar update leaves BG map updates off; the switch-out slide that
	; follows needs them as they were (or the mon just disappears)
	pop af
	ldh [hBGMapMode], a
	ret

.Show:
	call GetCurrentMon ; a = species, hl = its HP (then max HP)
	push hl
	ld hl, RegeneratorPokemon
	call IsInByteArray
	pop hl
	ret nc
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld c, a ; bc = HP
	or b
	ret z ; fainted
	ld a, [hli]
	ld d, a
	ld e, [hl] ; de = max HP
	ld a, c
	cp e
	jr nz, .not_full
	ld a, b
	cp d
	ret z ; already at max HP
.not_full
	call WaitBGMap ; show the "come back"/"withdrew" text first
	ShowActivationOrEntryOrKOAbilityPopup RegeneratorText
	farcall GetMaxHP ; bc = max HP
	call RegeneratorThird ; bc = 1/3 of it, rounded down
	farcall SwitchTurnCore
	farcall RestoreHP ; (heals the other side of hBattleTurn, animating its HP bar)
	farcall SwitchTurnCore
	; its party struct gets the new HP (it's leaving)
	ldh a, [hBattleTurn]
	and a
	ld a, [wBattleMonPartySlot]
	ld hl, wPartyMon1HP
	ld de, wBattleMonHP
	ld c, 1 << 0
	jr z, .got_side
	ld a, [wCurOTMon]
	ld hl, wOTPartyMon1HP
	ld de, wEnemyMonHP
	ld c, 1 << 1
.got_side
	push bc
	call GetPartyLocation
	pop bc
	ld a, [de]
	ld [hli], a
	inc de
	ld a, [de]
	ld [hl], a
	ld hl, wRegeneratorShown
	ld a, [hl]
	or c
	ld [hl], a
	ret

RegeneratorThird:
; bc = bc / 3, rounded down
	ld de, 0
.loop
	ld a, c
	sub 3
	ld c, a
	ld a, b
	sbc 0
	ld b, a
	jr c, .done
	inc de
	jr .loop
.done
	ld b, d
	ld c, e
	ret

IsRegeneratorSpecies::
; Carry if species a has Regenerator (not suppressed by Neutralizing Gas;
; for the AI). Preserves bc, de, hl.
	push hl
	push de
	push bc
	ld hl, RegeneratorPokemon
	call IsInAbilityList
	jmp PopBCDEHL

RegeneratorText: db "Regenerator@"

PlayerRegenerator:
; (wBattleMonSpecies is cleared at the start of each battle)
	ld hl, wRegeneratorShown
	bit 0, [hl]
	res 0, [hl]
	ret nz ; already healed on screen
	ld a, [wBattleMonPartySlot]
	ld hl, wPartyMon1HP
	call GetPartyLocation
	ld de, wBattleMonHP
	ld a, [wBattleMonSpecies]
	jr Regenerator

EnemyRegenerator:
	ld hl, wRegeneratorShown
	bit 1, [hl]
	res 1, [hl]
	ret nz ; already healed on screen
	ld a, [wBattleMode]
	cp TRAINER_BATTLE
	ret nz
	ld a, [wCurOTMon] ; -1 when a trainer battle starts
	cp PARTY_LENGTH
	ret nc
	ld hl, wOTPartyMon1HP
	call GetPartyLocation
	ld de, wEnemyMonHP
	ld a, [wEnemyMonSpecies]
	; fallthrough

Regenerator:
; a = species, de = its battle HP (then max HP), hl = its party HP
	push hl
	push de
	ld hl, RegeneratorPokemon
	call IsInAbilityList
	pop de
	pop hl
	ret nc
	ld a, [de]
	ld b, a
	inc de
	ld a, [de]
	ld c, a ; bc = HP
	inc de
	or b
	ret z ; fainted
	push hl
	ld a, [de]
	ld h, a
	inc de
	ld a, [de]
	ld l, a ; hl = max HP
	push hl
	; de = max HP / 3, rounded down
	ld de, 0
.third
	ld a, l
	sub 3
	ld l, a
	ld a, h
	sbc 0
	ld h, a
	jr c, .got_third
	inc de
	jr .third
.got_third
	ld h, b
	ld l, c
	add hl, de ; HP + 1/3
	pop de ; max HP
	ld a, e
	sub l
	ld a, d
	sbc h
	jr nc, .not_above_max
	ld h, d
	ld l, e
.not_above_max
	ld d, h
	ld e, l
	pop hl
	ld [hl], d
	inc hl
	ld [hl], e
	ret

INCLUDE "data/abilities/regenerator_mons.asm"
