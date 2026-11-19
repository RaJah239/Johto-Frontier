; ==============================
; === Ability: Prankster     ===
; ==============================
; Status moves used by a Prankster mon get +1 priority. The popup shows the
; first time it uses a status move after it comes out (each time it's sent
; out).

PranksterPriority::
; b = the priority of move c used by species d. Add 1 if it's a status
; move and the species has Prankster. For farcall: returns b (and c).
	ld a, c
	and a
	ret z ; no move
	push bc
	ld a, d
	ld hl, PranksterPokemon
	call IsInAbilityList
	pop bc
	ret nc
	ld a, c
	call PranksterIsStatusMove
	ret nz
	inc b
	ret

PranksterIsStatusMove:
; z if move a is a status move. Preserves bc.
	push bc
	dec a
	ld hl, Moves + MOVE_TYPE
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld a, BANK(Moves)
	call GetFarByte
	pop bc
	and ~TYPE_MASK
	cp STATUS
	ret

PranksterPopup:
; hBattleTurn = the user. Only for status moves.
	ldh a, [hBattleTurn]
	and a
	ld a, [wCurPlayerMove]
	jr z, .got_move
	ld a, [wCurEnemyMove]
.got_move
	and a
	ret z
	call PranksterIsStatusMove
	ret nz
	ld hl, PranksterPokemon
	ld de, PranksterText
	ld c, SEND_OUT_POPUP_PRANKSTER
	jmp SendOutAbilityPopup

PranksterText: db "Prankster@"

INCLUDE "data/abilities/prankster_mons.asm"
