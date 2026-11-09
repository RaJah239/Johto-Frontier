FindForcedReplacementInOTParty:
; Which OT mon to send out when the enemy has to replace its active mon (a
; KO, U-turn, Baton Pass, Shift mode): the first alive one in party order,
; other than the active mon. Returns the 0-based party index in b.
	ld hl, wOTPartyMon1HP
	ld b, 0
.loop
	ld a, [wOTPartyCount]
	cp b
	jr z, .none
	ld a, [wCurOTMon]
	cp b
	jr z, .next
	ld a, [hli]
	or [hl]
	dec hl
	ret nz
.next
	push bc
	ld bc, PARTYMON_STRUCT_LENGTH
	add hl, bc
	pop bc
	inc b
	jr .loop

.none
	ld b, 0
	ret
