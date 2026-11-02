; Grand Gauntlet dungeon bag
;
; On the first entry to Battle Room 1 the player's whole bag (TMs/HMs and
; every pocket, plus the pockets' cursor positions) is moved into
; wGGBagStash (WRAM bank 2) and the run starts with a bag that only holds
; the Key Items in GGDungeonBagKeyItems (Move Dex, Music Player, Type
; Chart, Score Card), whether or not the player owns them. Whatever is
; picked up during the run lands in that dungeon bag. Finishing floor 50
; or giving up puts the player's own bag back and the dungeon bag is
; gone. The stash is saved with the game (sGGBagStash), so a run saved
; and reloaded still gives the right bag back.

GGDungeonBag_Enter::
; Stash the player's bag and start the run with an empty one.
	ldh a, [rSVBK]
	push af

	; already stashed (shouldn't happen): don't overwrite the real bag
	ld a, BANK(wGGBagStash)
	ldh [rSVBK], a
	ld a, [wGGBagStashCheck]
	cp SAVE_CHECK_VALUE_1
	jmp z, .done

	ld hl, wTMsHMs
	ld de, wGGBagStashBag
	ld bc, GG_BAG_LENGTH
	call GGBag_CopyToStash
	ld hl, wLastPocket
	ld de, wGGBagStashLastPocket
	ld bc, 1
	call GGBag_CopyToStash
	ld hl, wItemsPocketCursor
	ld de, wGGBagStashPocketCursors
	ld bc, NUM_POCKETS
	call GGBag_CopyToStash
	ld hl, wItemsPocketScrollPosition
	ld de, wGGBagStashScrollPositions
	ld bc, NUM_POCKETS
	call GGBag_CopyToStash

	ld a, BANK(wGGBagStash)
	ldh [rSVBK], a
	ld a, SAVE_CHECK_VALUE_1
	ld [wGGBagStashCheck], a

	; empty bag, cursors back at the top
	ld a, BANK(wTMsHMs)
	ldh [rSVBK], a
	ld hl, wTMsHMs
	ld bc, GG_BAG_LENGTH
	xor a
	call ByteFill
	ld a, -1
	ld [wItems], a
	ld [wKeyItems], a
	ld [wBalls], a
	ld [wFruits], a
	ld [wBattles], a
	xor a
	ld [wLastPocket], a
	ld hl, wItemsPocketCursor
	ld bc, NUM_POCKETS
	call ByteFill
	ld hl, wItemsPocketScrollPosition
	ld bc, NUM_POCKETS
	xor a
	call ByteFill

	; the dungeon bag always comes with these Key Items, whether or not
	; the player owns them (they go when the player's own bag comes back)
	ld hl, GGDungeonBagKeyItems
	ld de, wKeyItems
	ld bc, GGDungeonBagKeyItemsEnd - GGDungeonBagKeyItems
	call CopyBytes
	ld a, GGDungeonBagKeyItemsEnd - GGDungeonBagKeyItems - 1
	ld [wNumKeyItems], a

.done
	pop af
	ldh [rSVBK], a
	ret

GGDungeonBagKeyItems:
; Key Items every dungeon bag starts with (EDIT: one item per line, -1 last)
	db MOVE_DEX
	db MUSIC_PLAYER
	db SCORE_CARD
	db TYPE_CHART
	db -1 ; end
GGDungeonBagKeyItemsEnd:
	assert GGDungeonBagKeyItemsEnd - GGDungeonBagKeyItems - 1 <= MAX_KEY_ITEMS

GGDungeonBag_Exit::
; Throw away the dungeon bag and give the player's own bag back. Does
; nothing if no bag is stashed (e.g. a run saved before this existed).
	ldh a, [rSVBK]
	push af

	ld a, BANK(wGGBagStash)
	ldh [rSVBK], a
	ld a, [wGGBagStashCheck]
	cp SAVE_CHECK_VALUE_1
	jr nz, .done
	xor a
	ld [wGGBagStashCheck], a

	ld hl, wGGBagStashBag
	ld de, wTMsHMs
	ld bc, GG_BAG_LENGTH
	call GGBag_CopyFromStash
	ld hl, wGGBagStashLastPocket
	ld de, wLastPocket
	ld bc, 1
	call GGBag_CopyFromStash
	ld hl, wGGBagStashPocketCursors
	ld de, wItemsPocketCursor
	ld bc, NUM_POCKETS
	call GGBag_CopyFromStash
	ld hl, wGGBagStashScrollPositions
	ld de, wItemsPocketScrollPosition
	ld bc, NUM_POCKETS
	call GGBag_CopyFromStash

.done
	pop af
	ldh [rSVBK], a
	ret

GGBag_CopyToStash:
; Copy bc bytes from hl (bag, WRAM bank 1) to de (stash, WRAM bank 2).
.loop
	ld a, BANK(wTMsHMs)
	ldh [rSVBK], a
	ld a, [hli]
	push af
	ld a, BANK(wGGBagStash)
	ldh [rSVBK], a
	pop af
	ld [de], a
	inc de
	dec bc
	ld a, b
	or c
	jr nz, .loop
	ret

GGBag_CopyFromStash:
; Copy bc bytes from hl (stash, WRAM bank 2) to de (bag, WRAM bank 1).
.loop
	ld a, BANK(wGGBagStash)
	ldh [rSVBK], a
	ld a, [hli]
	push af
	ld a, BANK(wTMsHMs)
	ldh [rSVBK], a
	pop af
	ld [de], a
	inc de
	dec bc
	ld a, b
	or c
	jr nz, .loop
	ret

GGBagStash_SaveToSRAM::
; Copy wGGBagStash to the save slot at de. The slot's SRAM bank must be
; open.
	ld hl, wGGBagStash
	jr GGBagStash_CopyBank2

GGBagStash_LoadFromSRAM::
; Copy the save slot at de to wGGBagStash. The slot's SRAM bank must be
; open. (farcall uses hl, so the address comes in de.)
	ld h, d
	ld l, e
	ld de, wGGBagStash
	; fallthrough

GGBagStash_CopyBank2:
	ldh a, [rSVBK]
	push af
	ld a, BANK(wGGBagStash)
	ldh [rSVBK], a
	ld bc, GG_BAG_STASH_LENGTH
	call CopyBytes
	pop af
	ldh [rSVBK], a
	ret
