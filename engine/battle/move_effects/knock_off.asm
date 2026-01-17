BattleCommand_KnockOff:

; ============
; === Note ===
; ============
; boosted damage is located in
; engine/abilities/boosting_abilities.asm `KnockOffBoost`

	ldh a, [hBattleTurn]
	and a
	jr nz, .enemy

; =====================
; === PLAYER'S TURN ===
; =====================

; Enemy must have an item
	call .enemyitem
	ld a, [hl]
	and a
	ret z

; Can't remove mail
	ld [wNamedObjectIndex], a
	ld d, a
	farcall ItemIsMail
	ret c

	ld a, [wEffectFailed]
	and a
	ret nz

; Remove enemy item
	call .enemyitem
	xor a
	ld [hl], a
	ld [de], a
	jr .handle_choice_item

.enemy
; ====================
; === ENEMY'S TURN ===
; ====================

; Player must have an item
	call .playeritem
	ld a, [hl]
	and a
	ret z

; Can't remove mail
	ld [wNamedObjectIndex], a
	ld d, a
	farcall ItemIsMail
	ret c

	ld a, [wEffectFailed]
	and a
	ret nz

; Remove player item
	call .playeritem
	xor a
	ld [hl], a
	ld [de], a

.handle_choice_item
	ld a, [wNamedObjectIndex]
	cp CHOICE_BAND
	jr z, .clear_encore
	cp CHOICE_SPECS
	jr nz, .continue

.clear_encore
	ldh a, [hBattleTurn]
	and a
	jr nz, .enemy_removed_player_choice

; Player removed enemy Choice item
	ld hl, wEnemySubStatus5
	res SUBSTATUS_ENCORED, [hl]
	jr .continue

.enemy_removed_player_choice
	ld hl, wPlayerSubStatus5
	res SUBSTATUS_ENCORED, [hl]

.continue
	call GetItemName
	ld hl, KnockOffText
	jmp StdBattleTextbox

; ===============
; === HELPERS ===
; ===============

.playeritem
	ld a, MON_ITEM
	call BattlePartyAttr
	ld d, h
	ld e, l
	ld hl, wBattleMonItem
	ret

.enemyitem
	ld a, MON_ITEM
	call OTPartyAttr
	ld d, h
	ld e, l
	ld hl, wEnemyMonItem
	ret
