; ======================================
; === Once-per-send-out ability popup ===
; ======================================
; Many abilities slide in their popup the first time they do something,
; once each time their mon is sent out. Every such popup has a
; SEND_OUT_POPUP_* number (constants/battle_constants.asm) and a flag per
; side in wSendOutPopupsShown: the player's SEND_OUT_POPUP_BYTES bytes,
; then the foe's. A side's flags are cleared when it sends out a new mon.
;
; In code that already knows the ability applies:
;	ShowOncePerSendOutPopup SEND_OUT_POPUP_<NAME>, <NameText>
; or, when the ability belongs to the mon that isn't acting, with that
; side's ABILITY_POPUP_PLAYER / ABILITY_POPUP_ENEMY in a:
;	ShowOncePerSendOutPopupOnSide SEND_OUT_POPUP_<NAME>, <NameText>
; For an ability that only needs its species checked when a move is used
; (like No Guard and Prankster), call a routine from MoveUseAbilityPopups
; that returns when the move doesn't apply, and otherwise does
;	ld hl, <SpeciesList>
;	ld de, <NameText> ; in this section
;	ld c, SEND_OUT_POPUP_<NAME>
;	jr SendOutAbilityPopup

MoveUseAbilityPopups::
; Called when the user (hBattleTurn) uses a move, before it takes effect.
	call NoGuardPopup
	jmp PranksterPopup

SendOutAbilityPopup:
; If the user's species is in list hl, show popup c with name de (in this
; bank) once per send-out.
	push bc
	push de
	push hl
	call GetCurrentMon ; a = species
	pop hl
	call IsInByteArray
	pop de
	pop bc
	ret nc
	ld b, BANK(@)
	; fallthrough

_ShowOncePerSendOutPopup::
; Show popup c (SEND_OUT_POPUP_*) with name b:de over the acting side's
; HUD, unless it's already been shown since that side's mon came in.
	ldh a, [hBattleTurn]
	; fallthrough

_ShowOncePerSendOutPopupOnSide::
; The same over side a's HUD (ABILITY_POPUP_PLAYER / ABILITY_POPUP_ENEMY):
; for an ability of the mon that isn't the one acting.
	push af
	call GetSendOutPopupFlag
	jr nz, .shown
	ld a, c
	or [hl]
	ld [hl], a
	pop af
	ld c, a
	farcall ShowAbilityPopup
	ret

.shown
	pop af
	ret

CheckSendOutPopupShown::
; Return nz if popup c (SEND_OUT_POPUP_*) has already been shown over the
; acting side's HUD since its mon came in. Use with newfarcall.
	ldh a, [hBattleTurn]
	; fallthrough

GetSendOutPopupFlag:
; hl = side a's flag byte for popup c, c = its mask; nz if it's set.
	ld l, a
	ld a, c
	rrca
	rrca
	rrca
	and %00011111 ; byte
	dec l
	jr nz, .got_side ; player
	add SEND_OUT_POPUP_BYTES
.got_side
	ld hl, wSendOutPopupsShown
	add l
	ld l, a
	adc h
	sub l
	ld h, a
	ld a, c
	and 7
	inc a
	ld c, a
	xor a
	scf
.bit
	rla
	dec c
	jr nz, .bit
	ld c, a ; mask
	and [hl]
	ret

ResetPlayerSendOutPopups::
; The player sent out a mon: its popups can show again.
	; and its entry item is pending from now on (so its HUD doesn't show a
	; weather shard it's about to use: PrintPlayerHUD)
	ld hl, wEntryAbilitiesPending
	set ENTRY_ITEM_PLAYER_F, [hl]
	ld hl, wSendOutPopupsShown
	jr ResetSendOutPopups

ResetEnemySendOutPopups::
; The foe sent out a mon.
	ld hl, wEntryAbilitiesPending
	set ENTRY_ITEM_ENEMY_F, [hl]
	ld hl, wSendOutPopupsShown + SEND_OUT_POPUP_BYTES
ResetSendOutPopups:
	xor a
rept SEND_OUT_POPUP_BYTES
	ld [hli], a
endr
	ret

ResetAllSendOutPopups::
; at the start of a battle
	call ResetPlayerSendOutPopups
	jr ResetEnemySendOutPopups
