	assert HIGH(TACKLE) == 0 ; (its high byte would go in the padding)

BadEgg:
; Failsafe if there is a checksum error. Species and moves are 16-bit indexes,
; as in storage (see EncodeBufferMon): low bytes here, high bytes in the
; padding (zero) and AltSpecies; BufferMonIndexesToIDs turns them into IDs.
	db LOW(DITTO)
	db NO_ITEM
	db LOW(TACKLE), NO_MOVE, NO_MOVE, NO_MOVE
	dw 0 ; OT ID
	db 0, 0, 0 ; Exp
	; Stat exp
	bigdw 0
	bigdw 0
	bigdw 0
	bigdw 0
	bigdw 0
	dn 0, 0, 0, 0 ; DVs
	db 0, 0, 0, 0 ; PP
	db 255 ; Step cycles to hatch
	db 0, 0, 0 ; Pokérus, Caught data
	db EGG_LEVEL ; Level
	db 0 ; Status
	db 0 ; Unused (party_struct has it: without it, everything after was a byte off)
	bigdw 0 ; HP
	bigdw 11 ; Max HP
	bigdw 5 ; Atk
	bigdw 5 ; Def
	bigdw 5 ; Spd
	bigdw 5 ; SAtk
	bigdw 5 ; SDef
	db $80 | HIGH(DITTO) ; Alt species: egg, species high byte
	db "BAD EGG@@@@" ; Nickname
	db "?@@@@@@@@@@" ; OT name
BadEggEnd:
	assert BadEggEnd - BadEgg == wBufferMonOT + NAME_LENGTH - wBufferMon
