DEF PARTY_MENU_MAIL_TILE EQU $5e
DEF PARTY_MENU_ITEM_TILE EQU $5f
DEF PARTY_MENU_HELD_ITEM_PAL EQU HP_RED + 1

LoadPartyMenuHeldItemIconGFX:
	ld de, PartyMenuMailIconGFX
	ld hl, vTiles2 tile PARTY_MENU_MAIL_TILE
	lb bc, BANK(PartyMenuMailIconGFX), 1
	call Request2bpp
	ld de, PartyMenuItemIconGFX
	ld hl, vTiles2 tile PARTY_MENU_ITEM_TILE
	lb bc, BANK(PartyMenuItemIconGFX), 1
	jmp Request2bpp

PartyMenuMailIconGFX:
	INCBIN "gfx/stats/mail.2bpp"

PartyMenuItemIconGFX:
	INCBIN "gfx/stats/item.2bpp"

PlacePartyMenuHeldItemIcons:
	ld a, [wPartyCount]
	and a
	ret z
	ld c, a ; remaining party slots
	ld b, 0 ; current party slot
	hlcoord 3, 2 ; directly under the first letter of the name

.loop
	push bc
	push hl
	ld a, b
	ld bc, PARTYMON_STRUCT_LENGTH
	ld hl, wPartyMon1Item
	call AddNTimes
	ld a, [hl]
	and a
	jr z, .next

	ld d, a
	callfar ItemIsMail
	ld a, PARTY_MENU_MAIL_TILE
	jr c, .got_tile
	ld a, PARTY_MENU_ITEM_TILE

.got_tile
	pop hl
	ld [hl], a
	push hl
	ld de, wAttrmap - wTilemap
	add hl, de
	ld [hl], PARTY_MENU_HELD_ITEM_PAL

.next
	pop hl
	ld de, 2 * SCREEN_WIDTH
	add hl, de
	pop bc
	inc b
	dec c
	jr nz, .loop

	ldh a, [hCGB]
	and a
	ret z
	farjp ApplyAttrmap
