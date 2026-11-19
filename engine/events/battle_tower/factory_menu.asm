BattleFactory_Menu::
	ldh a, [rSVBK]
	push af
	ld a, BANK(wPartyCount)
	ldh [rSVBK], a
	call FactoryMenu_ClearSelections
	ld a, FACTORY_REVIEW_TEAM
	ld b, PARTY_LENGTH ; Continue
	call FactoryMenu_SetPhaseAndCursor
	call FactoryMenu_LoadScreen
.loop
	call DelayFrame
	call GetJoypad
	farcall PlaySpriteAnimations
	ldh a, [hJoyPressed]
	call FactoryMenu_HandleInput
	jr nc, .loop
	call ClearSprites
	pop af
	ldh [rSVBK], a
	ret

FactoryMenu_HandleInput::
; Carry only when Continue commits the team and leaves the menu.
	bit B_BUTTON_F, a
	jmp nz, FactoryMenu_Back
	bit START_F, a
	jmp nz, FactoryMenu_Summary
	bit SELECT_F, a
	jmp nz, FactoryMenu_MoveMon
	bit A_BUTTON_F, a
	jr nz, FactoryMenu_AButton
	bit D_UP_F, a
	jr nz, .up
	bit D_DOWN_F, a
	jr nz, .down
	bit D_LEFT_F, a
	jr nz, .left
	bit D_RIGHT_F, a
	jr nz, .right
	and a
	ret
.up
	ld hl, sFactoryCursor
	newfarcall BattleFactory_ReadByte
	and a
	jr nz, .decrement
	call FactoryMenu_GetCursorLimit
.decrement
	dec a
	jr .store
.down
	ld hl, sFactoryCursor
	newfarcall BattleFactory_ReadByte
	inc a
	ld b, a
	call FactoryMenu_GetCursorLimit
	cp b
	ld a, b
	jr nz, .store
	xor a
	jr .store
.left
	ld hl, sFactoryCursor
	newfarcall BattleFactory_ReadByte
	cp PARTY_LENGTH
	jr c, .stay
	ld a, PARTY_LENGTH
	jr .store
.right
	ld hl, sFactoryPhase
	newfarcall BattleFactory_ReadByte
	cp FACTORY_REVIEW_FINAL_TEAM
	jr z, .stay
	ld hl, sFactoryCursor
	newfarcall BattleFactory_ReadByte
	cp PARTY_LENGTH
	jr c, .stay
	ld a, PARTY_LENGTH + 1
.store
	ld hl, sFactoryCursor
	newfarcall BattleFactory_WriteByte
	call FactoryMenu_DrawCursor
	call ApplyTilemap
.stay
	and a
	ret

FactoryMenu_GetCursorLimit:
	ld hl, sFactoryPhase
	newfarcall BattleFactory_ReadByte
	cp FACTORY_REVIEW_FINAL_TEAM
	ld a, PARTY_LENGTH + 2
	ret nz
	dec a ; only Continue after committing this round's exchanges
	ret

FactoryMenu_AButton:
	ld hl, sFactoryCursor
	newfarcall BattleFactory_ReadByte
	cp PARTY_LENGTH
	jmp c, FactoryMenu_MonSelected
	jr z, FactoryMenu_LeftAction
	ld hl, sFactoryPhase
	newfarcall BattleFactory_ReadByte
	and a
	jr z, .begin_exchange
	cp FACTORY_SELECT_OUTGOING
	jr z, .choose_replacements
	ld hl, sFactoryOutCount
	newfarcall BattleFactory_ReadByte
	ld b, a
	ld hl, sFactoryInCount
	newfarcall BattleFactory_ReadByte
	cp b
	jr nz, .wrong_count
	farcall BattleFactory_CommitExchange
	jr c, .duplicate
	call FactoryMenu_ClearSelections
	ld a, FACTORY_REVIEW_FINAL_TEAM
	ld b, PARTY_LENGTH
	jr .change_screen
.begin_exchange
	call FactoryMenu_ClearSelections
	ld a, FACTORY_SELECT_OUTGOING
	ld b, 0
	jr .change_screen
.choose_replacements
	ld hl, sFactoryOutCount
	newfarcall BattleFactory_ReadByte
	and a
	jr z, .wrong_count
	call FactoryMenu_ClearIncoming
	farcall BattleFactory_LoadOffers
	ld a, FACTORY_SELECT_REPLACEMENTS
	ld b, 0
.change_screen
	call FactoryMenu_SetPhaseAndCursor
	call FactoryMenu_LoadScreen
	and a
	ret
.wrong_count
	ld a, 2
	jmp FactoryMenu_Error
.duplicate
	ld a, 3
	jmp FactoryMenu_Error

FactoryMenu_LeftAction:
	ld hl, sFactoryPhase
	newfarcall BattleFactory_ReadByte
	cp FACTORY_REVIEW_FINAL_TEAM
	jr z, .continue
	and a
	jr nz, FactoryMenu_Back
.continue
	scf ; Continue without exchanging
	ret

FactoryMenu_Back:
	ld hl, sFactoryMoveSlot
	newfarcall BattleFactory_ReadByte
	cp -1
	jr z, .not_moving
	call FactoryMenu_ClearMoveSlot
	jr .refresh
.not_moving
	ld hl, sFactoryPhase
	newfarcall BattleFactory_ReadByte
	and a
	jr z, .review
	cp FACTORY_REVIEW_FINAL_TEAM
	jr z, .review
	cp FACTORY_SELECT_OUTGOING
	jr z, .cancel_exchange
	call FactoryMenu_ClearIncoming
	farcall BattleFactory_LoadTeam
	ld a, FACTORY_SELECT_OUTGOING
	ld b, PARTY_LENGTH + 1
	jr .redraw
.cancel_exchange
	call FactoryMenu_ClearSelections
	xor a ; FACTORY_REVIEW_TEAM
	ld b, PARTY_LENGTH + 1
.redraw
	call FactoryMenu_SetPhaseAndCursor
	call FactoryMenu_LoadScreen
	and a
	ret
.review
	ld a, PARTY_LENGTH ; B focuses Continue; it cannot abandon the challenge.
	ld hl, sFactoryCursor
	newfarcall BattleFactory_WriteByte
	call FactoryMenu_DrawCursor
	call ApplyTilemap
	and a
	ret
.refresh
	call FactoryMenu_DrawOverlay
	farcall ApplyPartyMenuTilemap
	and a
	ret

FactoryMenu_MonSelected:
; a is the selected party row. A inspects in review, marks during exchange.
	ld c, a
	ld hl, sFactoryPhase
	newfarcall BattleFactory_ReadByte
	and a
	jr z, .review
	cp FACTORY_REVIEW_FINAL_TEAM
	jr z, .review
	ld hl, sFactoryOutSlots
	ld de, sFactoryOutCount
	cp FACTORY_SELECT_OUTGOING
	jr z, .toggle
	ld hl, sFactoryInSlots
	ld de, sFactoryInCount
.toggle
	call FactoryMenu_ToggleSlot
	ld a, 1
	jmp c, FactoryMenu_Error
	xor a
	ld hl, sFactoryMessage
	newfarcall BattleFactory_WriteByte
	call FactoryMenu_DrawOverlay
	farcall ApplyPartyMenuTilemap
	and a
	ret
.review
	ld hl, sFactoryMoveSlot
	newfarcall BattleFactory_ReadByte
	cp -1
	jmp z, FactoryMenu_Summary
	; A also confirms the destination while SELECT is moving a rental.
	jr FactoryMenu_MoveMon

FactoryMenu_MoveMon:
	ld hl, sFactoryPhase
	newfarcall BattleFactory_ReadByte
	and a
	jr z, .own_team
	cp FACTORY_REVIEW_FINAL_TEAM
	jr nz, .done
.own_team
	ld hl, sFactoryCursor
	newfarcall BattleFactory_ReadByte
	cp PARTY_LENGTH
	jr nc, .done
	ld b, a
	ld hl, sFactoryMoveSlot
	newfarcall BattleFactory_ReadByte
	cp -1
	jr nz, .swap
	ld a, b
	newfarcall BattleFactory_WriteByte
	call FactoryMenu_DrawOverlay
	farcall ApplyPartyMenuTilemap
	jr .done
.swap
	farcall BattleFactory_SwapRentals
	call FactoryMenu_ClearMoveSlot
	call FactoryMenu_LoadScreen
.done
	and a
	ret

FactoryMenu_ClearMoveSlot:
	ld a, -1
	ld hl, sFactoryMoveSlot
	newfarcall BattleFactory_WriteByte
	ret

FactoryMenu_ToggleSlot::
; c = row, hl = two selected slots, de = count. Return carry at the limit.
	ld a, BANK(sFactoryPhase)
	call OpenSRAM
	push hl
	ld a, [de]
	ld b, a
	and a
	jr z, .append
	ld a, [hl]
	cp c
	jr z, .remove_first
	ld a, b
	cp BATTLE_FACTORY_MAX_EXCHANGES
	jr c, .append
	inc hl
	ld a, [hl]
	cp c
	jr z, .remove_second
.append
	pop hl
	ld a, b
	cp BATTLE_FACTORY_MAX_EXCHANGES
	jr nc, .full
	and a
	jr z, .write
	inc hl
.write
	ld [hl], c
	inc b
	jr .store_count
.remove_first
	pop hl
	inc hl
	ld a, [hld]
	ld [hli], a
	ld [hl], -1
	dec b
	jr .store_count
.remove_second
	pop hl
	inc hl
	ld [hl], -1
	dec b
.store_count
	ld a, b
	ld [de], a
	call CloseSRAM
	and a
	ret
.full
	call CloseSRAM
	scf
	ret

FactoryMenu_Error:
	ld hl, sFactoryMessage
	newfarcall BattleFactory_WriteByte
	ld de, SFX_WRONG
	call PlaySFX
	call FactoryMenu_DrawOverlay
	farcall ApplyPartyMenuTilemap
	and a
	ret

FactoryMenu_Summary:
	ld hl, sFactoryCursor
	newfarcall BattleFactory_ReadByte
	cp PARTY_LENGTH
	jr nc, .done
	ld [wCurPartyMon], a
	xor a ; PARTYMON
	ld [wMonType], a
	call ClearSprites
	farcall ClearSpriteAnims
	farcall StatsScreenInit
	call FactoryMenu_LoadScreen
.done
	and a
	ret

FactoryMenu_ClearSelections:
	ld a, BANK(sFactoryPhase)
	call OpenSRAM
	xor a
	ld [sFactoryOutCount], a
	ld [sFactoryInCount], a
	ld hl, sFactoryOutSlots
	ld bc, BATTLE_FACTORY_MAX_EXCHANGES * 2
	ld a, -1
	call ByteFill
	ld [sFactoryMoveSlot], a
	jmp CloseSRAM

FactoryMenu_ClearIncoming:
	ld a, BANK(sFactoryPhase)
	call OpenSRAM
	xor a
	ld [sFactoryInCount], a
	dec a
	ld [sFactoryInSlots], a
	ld [sFactoryInSlots + 1], a
	jmp CloseSRAM

FactoryMenu_SetPhaseAndCursor:
; a = phase, b = cursor. Reset only the message, retaining marked slots.
	push af
	ld a, BANK(sFactoryPhase)
	call OpenSRAM
	pop af
	ld [sFactoryPhase], a
	ld a, b
	ld [sFactoryCursor], a
	xor a
	ld [sFactoryMessage], a
	jmp CloseSRAM

FactoryMenu_LoadScreen:
	call ClearBGPalettes
	call ClearSprites
	call LoadStandardFont
	farcall LoadPartyMenuGFX
	farcall LoadPartyMenuPalsOnly
	xor a
	ld [wSwitchMon], a
	ld [wMenuCursorY], a
	ld a, PARTYMENUACTION_GIVE_MON ; name, level, gender, status; room for markers
	ld [wPartyMenuActionText], a
	farcall InitPartyMenuGFX
	; Leave column zero free for the cursor. XOFFSET survives the icon's
	; normal animation function resetting XCOORD every frame.
	ld hl, wSpriteAnimationStructs + SPRITEANIMSTRUCT_XOFFSET
	ld de, SPRITEANIMSTRUCT_LENGTH
	ld b, PARTY_LENGTH
.offset_icons
	ld [hl], TILE_WIDTH
	add hl, de
	dec b
	jr nz, .offset_icons
	farcall PlaySpriteAnimations
	farcall WritePartyMenuTilemap
	xor a
	ldh [hBGMapMode], a
	hlcoord 0, 14
	lb bc, 2, 18
	call Textbox
	call FactoryMenu_DrawOverlay
	call SetDefaultBGPAndOBP
	farjp ApplyPartyMenuTilemap

FactoryMenu_DrawOverlay:
	xor a
	ldh [hBGMapMode], a
	hlcoord 0, 0
	lb bc, 1, SCREEN_WIDTH
	call ClearBox
	hlcoord 0, 13 ; remove the ordinary party menu's Cancel row
	lb bc, 1, SCREEN_WIDTH
	call ClearBox
	hlcoord 1, 15
	lb bc, 2, 18
	call ClearBox
	ld hl, sFactoryPhase
	newfarcall BattleFactory_ReadByte
	ld de, FactoryMenu_YourTeam
	cp FACTORY_SELECT_REPLACEMENTS
	jr nz, .title
	ld hl, sFactoryOfferKind
	newfarcall BattleFactory_ReadByte
	ld de, FactoryMenu_FreshRentals
	and a
	jr z, .title
	ld de, FactoryMenu_DefeatedTeam
.title
	hlcoord 3, 0 ; leave the icon column clear
	call PlaceString
	ld hl, sFactoryPhase
	newfarcall BattleFactory_ReadByte
	ld de, FactoryMenu_Continue
	cp FACTORY_REVIEW_FINAL_TEAM
	jr z, .left_action
	and a
	jr z, .left_action
	ld de, FactoryMenu_BackLabel
.left_action
	hlcoord 2, 15
	call PlaceString
	ld hl, sFactoryPhase
	newfarcall BattleFactory_ReadByte
	cp FACTORY_REVIEW_FINAL_TEAM
	jr z, .summary_hint
	ld de, FactoryMenu_Exchange
	cp FACTORY_SELECT_REPLACEMENTS
	jr nz, .right_action
	ld de, FactoryMenu_Continue
.right_action
	hlcoord 11, 15
	call PlaceString
.summary_hint
	hlcoord 2, 16
	ld de, FactoryMenu_SummaryHint
	call PlaceString
	ld hl, sFactoryMessage
	newfarcall BattleFactory_ReadByte
	ld de, FactoryMenu_LimitMessage
	cp 1
	jr z, .hint
	ld de, FactoryMenu_CountMessage
	cp 2
	jr z, .hint
	ld de, FactoryMenu_DuplicateMessage
	cp 3
	jr z, .hint
	ld hl, sFactoryPhase
	newfarcall BattleFactory_ReadByte
	ld de, FactoryMenu_ReviewHint
	and a
	jr z, .review_hint
	cp FACTORY_REVIEW_FINAL_TEAM
	jr z, .review_hint
	ld de, FactoryMenu_MarkHint
	cp FACTORY_SELECT_OUTGOING
	jr z, .hint
	ld de, FactoryMenu_PickHint
	jr .hint
.review_hint
	ld hl, sFactoryMoveSlot
	newfarcall BattleFactory_ReadByte
	cp -1
	ld de, FactoryMenu_ReviewHint
	jr z, .hint
	ld de, FactoryMenu_MoveHint
.hint
	hlcoord 1, 13
	call PlaceString
	call FactoryMenu_DrawMarkers
	; fallthrough

FactoryMenu_DrawCursor:
	; This screen has its own cursor. Keep the ordinary party selection inactive
	; so a selected icon cannot jump into the title or the Pokemon's name.
	xor a
	ld [wMenuCursorY], a
	hlcoord 0, 1
	ld b, PARTY_LENGTH
	ld de, 2 * SCREEN_WIDTH
.clear
	ld [hl], " "
	add hl, de
	dec b
	jr nz, .clear
	hlcoord 1, 15
	ld [hl], " "
	hlcoord 10, 15
	ld [hl], " "
	ld hl, sFactoryMoveSlot
	newfarcall BattleFactory_ReadByte
	cp -1
	jr z, .cursor
	hlcoord 0, 1
	ld bc, 2 * SCREEN_WIDTH
	call AddNTimes
	ld [hl], "▷"
.cursor
	ld hl, sFactoryCursor
	newfarcall BattleFactory_ReadByte
	cp PARTY_LENGTH
	jr nc, .footer
	hlcoord 0, 1
	ld bc, 2 * SCREEN_WIDTH
	call AddNTimes
	jr .place
.footer
	hlcoord 1, 15
	cp PARTY_LENGTH
	jr z, .place
	hlcoord 10, 15
.place
	ld [hl], "▶"
	ret

FactoryMenu_DrawMarkers:
	ld b, PARTY_LENGTH
	hlcoord 18, 1
.clear
	ld [hl], " "
	ld de, 2 * SCREEN_WIDTH
	add hl, de
	dec b
	jr nz, .clear
	ld hl, sFactoryPhase
	newfarcall BattleFactory_ReadByte
	and a
	ret z
	cp FACTORY_REVIEW_FINAL_TEAM
	ret z
	ld hl, sFactoryOutSlots
	ld de, sFactoryOutCount
	cp FACTORY_SELECT_OUTGOING
	jr z, .selected
	ld hl, sFactoryInSlots
	ld de, sFactoryInCount
.selected
	ld a, BANK(sFactoryPhase)
	call OpenSRAM
	ld a, [de]
	and a
	jr z, .done
	ld b, a
	ld c, 0
.loop
	push bc
	ld a, [hli]
	push hl
	hlcoord 18, 1
	ld bc, 2 * SCREEN_WIDTH
	call AddNTimes
	pop de
	pop bc
	ld a, c
	add "1"
	ld [hl], a
	ld h, d
	ld l, e
	inc c
	dec b
	jr nz, .loop
.done
	jmp CloseSRAM

FactoryMenu_YourTeam:         db "Factory Rentals@"
FactoryMenu_FreshRentals:     db "New Rentals@"
FactoryMenu_DefeatedTeam:     db "Defeated Team@"
FactoryMenu_Continue:         db "Continue@"
FactoryMenu_Exchange:         db "Exchange@"
FactoryMenu_BackLabel:        db "Back@"
FactoryMenu_SummaryHint:      db "Start: Summary@"
FactoryMenu_ReviewHint:       db "Select: Reorder@"
FactoryMenu_MoveHint:         db "Move to where?@"
FactoryMenu_MarkHint:         db "Mark up to two.@"
FactoryMenu_PickHint:         db "Pick same number.@"
FactoryMenu_LimitMessage:     db "Only two allowed.@"
FactoryMenu_CountMessage:     db "Pick same number.@"
FactoryMenu_DuplicateMessage: db "Duplicate species!@"
