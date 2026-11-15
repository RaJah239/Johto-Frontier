; ======================================
; === Once-per-send-out ability popup ===
; ======================================
; Abilities like No Guard and Prankster show their popup the first time
; their mon uses a move that the ability affects, once each time it is
; sent out. A mon has only one ability, so a single bit per side is
; enough for all of them: wAbilityShownSinceSentOut bit 0 is the
; player's mon, bit 1 the foe's. It's cleared when a new mon comes in.
;
; To add another ability: give it a species list and a name (in this
; section), and from MoveUseAbilityPopups call a routine that returns
; when the move doesn't apply, and otherwise does
;	ld hl, <SpeciesList>
;	ld de, <NameText>
;	jr SendOutAbilityPopup

MoveUseAbilityPopups::
; Called when the user (hBattleTurn) uses a move, before it takes effect.
	call NoGuardPopup
	jmp PranksterPopup

SendOutAbilityPopup:
; If the user's species is in list hl and it hasn't shown its ability
; since it came in, show the popup with name de (in this bank).
	ldh a, [hBattleTurn]
	and a
	ld b, 1 << 0
	jr z, .got_bit
	ld b, 1 << 1
.got_bit
	ld a, [wAbilityShownSinceSentOut]
	and b
	ret nz
	push bc
	push de
	push hl
	call GetCurrentMon ; a = species
	pop hl
	call IsInByteArray
	pop de
	pop bc
	ret nc
	ld a, [wAbilityShownSinceSentOut]
	or b
	ld [wAbilityShownSinceSentOut], a
	ld b, BANK(@)
	ldh a, [hBattleTurn]
	ld c, a ; ABILITY_POPUP_PLAYER / ABILITY_POPUP_ENEMY
	farcall ShowAbilityPopup
	ret
