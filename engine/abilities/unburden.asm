; ==============================
; === Ability: Unburden      ===
; ==============================
; When an Unburden mon loses its held item (used up, Knocked Off, stolen,
; Tricked away...), its popup slides in and then its Speed rises 1 stage.
; It goes off each time it loses an item it held, and not when a fainted
; mon loses one. Neutralizing Gas: its popup shows instead, no boost.
;
; Item effects don't call it: each side's "held an item" bit
; (UNBURDEN_ITEM_*_F in wEntryAbilitiesPending) is set when a mon comes in
; holding one, and CheckUnburden compares it with the item it holds now:
; after each move (DoPlayerTurn / DoEnemyTurn), at the end of the turn, and
; after entry items. So any new way of losing an item works too.

UnburdenRecordSide::
; The hBattleTurn side has just sent out a mon: remember whether it holds an
; item (no popup). Preserves bc, de and hl.
	push hl
	push bc
	call UnburdenGetBits
	ld a, [de]
	and a
	ld a, [hl]
	jr z, .no_item
	or c
	jr .done
.no_item
	ld b, a
	ld a, c
	cpl
	and b
.done
	ld [hl], a
	pop bc
	pop hl
	ret

CheckUnburden::
; Both sides: has a mon lost the item it held? Use with farcall.
; Preserves hBattleTurn.
	ldh a, [hBattleTurn]
	push af
	xor a
	call CheckUnburdenSide
	ld a, 1
	call CheckUnburdenSide
	pop af
	ldh [hBattleTurn], a
	ret

CheckUnburdenSide::
; Side a (0 = player, 1 = enemy; sets hBattleTurn to it): if its mon held an
; item and holds none now, it has lost it: Unburden goes off.
	ldh [hBattleTurn], a
	push de
	call UnburdenGetBits
	ld a, [de]
	pop de
	and a
	jr z, .no_item
	; it holds one (maybe a new one): remember it
	ld a, [hl]
	or c
	ld [hl], a
	ret

.no_item
	ld a, [hl]
	and c
	ret z ; it didn't hold one before either
	ld a, c
	cpl
	and [hl]
	ld [hl], a ; lost now: until it gets another item
	call GetCurrentMon ; a = species, hl = HP
	ld b, a
	ld a, [hli]
	or [hl]
	ret z ; fainted
	ld a, b
	ld hl, UnburdenPokemon
	call IsInByteArray
	ret nc
	; (keep the move's results for whatever comes next)
	ld a, [wAttackMissed]
	push af
	ld a, [wEffectFailed]
	push af
	ld a, [wFailedMessage]
	push af
	call .activate
	pop af
	ld [wFailedMessage], a
	pop af
	ld [wEffectFailed], a
	pop af
	ld [wAttackMissed], a
	ret

.activate
	; the popup slides in first, then Speed rises
	ShowActivationOrEntryOrKOAbilityPopup UnburdenText
	xor a
	ld [wAttackMissed], a
	ld [wEffectFailed], a
	ld [wFailedMessage], a
	ld b, SPEED
	farcall BattleCommand_StatUp
	farjp BattleCommand_StatUpMessage

UnburdenGetBits:
; For the hBattleTurn side: de = its mon's item, hl = wEntryAbilitiesPending,
; c = its UNBURDEN_ITEM_*_F mask.
	ld hl, wEntryAbilitiesPending
	ldh a, [hBattleTurn]
	and a
	ld de, wBattleMonItem
	ld c, 1 << UNBURDEN_ITEM_PLAYER_F
	ret z
	ld de, wEnemyMonItem
	ld c, 1 << UNBURDEN_ITEM_ENEMY_F
	ret

UnburdenText: db "Unburden@"
INCLUDE "data/abilities/unburden_mons.asm"

IsUnburdenSpecies::
; Carry if species a has Unburden (not suppressed by Neutralizing Gas; for
; the AI). Preserves bc, de, hl.
	push hl
	push de
	push bc
	ld hl, UnburdenPokemon
	call IsInAbilityList
	jmp PopBCDEHL
