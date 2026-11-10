INCLUDE "engine/16/macros.asm"

; Note: ID = 8-bit ID used in RAM; index = true 16-bit index into tables.
;
; The garbage collector frees table slots whose IDs aren't used anywhere in
; RAM. Boxed Pokémon (the newbox storage in SRAM) are stored with their
; 16-bit indexes, so only RAM needs scanning. The bitmap of used IDs lives in
; WRAM bank 2 with the tables, so .set_bit switches to it.

ForceGarbageCollection::
; (identity tables are never collected: their IDs are fixed)
if !IDENTITY_INDEX_TABLES
	push bc
	ldh a, [rSVBK]
	push af
if !IDENTITY_MON_TABLE
	ld a, BANK(wPokemonIndexTable)
	ldh [rSVBK], a
	call PokemonTableGarbageCollection
endc
if !IDENTITY_MOVE_TABLE
	ld a, BANK(wMoveIndexTable)
	ldh [rSVBK], a
	call MoveTableGarbageCollection
endc
	pop af
	ldh [rSVBK], a
	pop bc
endc
	ret

InitIndexTables::
; Clear both tables (new game). While IDENTITY_INDEX_TABLES is set, fill them
; with the identity mapping instead, so 8-bit constants still work.
	ldh a, [rSVBK]
	push af
	ld a, BANK(wPokemonIndexTable)
	ldh [rSVBK], a
	ld hl, wPokemonIndexTable
	ld bc, wPokemonIndexTableEnd - wPokemonIndexTable
	xor a
	call ByteFill
	ld a, BANK(wMoveIndexTable)
	ldh [rSVBK], a
	ld hl, wMoveIndexTable
	ld bc, wMoveIndexTableEnd - wMoveIndexTable
	xor a
	call ByteFill
if IDENTITY_MON_TABLE
	assert MON_TABLE_ENTRIES >= NUM_POKEMON, "identity table too small for NUM_POKEMON"
	ld a, BANK(wPokemonIndexTable)
	ldh [rSVBK], a
	ld hl, wPokemonIndexTableEntries
	ld c, NUM_POKEMON
	call .identity
	ld a, NUM_POKEMON
	ld [wPokemonIndexTableUsedSlots], a
endc
if IDENTITY_MOVE_TABLE
	assert MOVE_TABLE_ENTRIES >= NUM_ATTACKS, "identity table too small for NUM_ATTACKS"
	ld a, BANK(wMoveIndexTable)
	ldh [rSVBK], a
	ld hl, wMoveIndexTableEntries
	ld c, NUM_ATTACKS
	call .identity
	ld a, NUM_ATTACKS
	ld [wMoveIndexTableUsedSlots], a
endc
	pop af
	ldh [rSVBK], a
	ret

if IDENTITY_MON_TABLE || IDENTITY_MOVE_TABLE
.identity
; hl = entries, c = count: entry n (from 1) = n
	ld b, 1
.identity_loop
	ld a, b
	ld [hli], a
	xor a
	ld [hli], a
	inc b
	dec c
	jr nz, .identity_loop
	ret
endc

_GetPokemonIndexFromID::
	___conversion_table_load wPokemonIndexTable, MON_TABLE

_GetPokemonIDFromIndex::
	___conversion_table_store wPokemonIndexTable, MON_TABLE
	; fallthrough - as required by the macro
PokemonTableGarbageCollection:
	; must preserve de and rSVBK
	push de
	ldh a, [rSVBK]
	push af
	___conversion_bitmap_initialize wPokemonIndexTable, MON_TABLE, .set_bit
	ld a, 1
	ldh [rSVBK], a
	___conversion_bitmap_check_structs wPartyMons, PARTYMON_STRUCT_LENGTH, PARTY_LENGTH, .set_bit
	___conversion_bitmap_check_structs wBreedMon1Species, wBreedMon2 - wBreedMon1, 2, .set_bit
	; may or may not be valid, but marking them in use is free
	___conversion_bitmap_check_structs wOTPartyMons, PARTYMON_STRUCT_LENGTH, PARTY_LENGTH, .set_bit
	___conversion_bitmap_check_structs wRoamMon1Species, wRoamMon2 - wRoamMon1, 3, .set_bit
	___conversion_bitmap_check_structs wBugContestFirstPlaceMon, wBugContestSecondPlaceMon - wBugContestFirstPlaceMon, 3, .set_bit
	; Bill's PC icons (species IDs of the box and party on screen); outside the
	; PC this union holds other data, and marking its bytes in use is harmless
	___conversion_bitmap_check_structs wBillsPC_PartyList, 1, PARTY_LENGTH, .set_bit
	___conversion_bitmap_check_structs wBillsPC_BoxList, 1, MONS_PER_BOX, .set_bit
	___conversion_bitmap_check_values .set_bit, wBillsPC_HeldIcon, wBillsPC_QuickIcon
	___conversion_bitmap_check_values .set_bit, wEggMonSpecies, wBufferMonSpecies, wTempMonSpecies, wContestMonSpecies, \
	                                            wBattleMonSpecies, wEnemyMonSpecies, wOddEggSpecies, wBaseDexNo, \
	                                            wCurPartySpecies, wCurSpecies, wTempSpecies, wScriptVar, wPrevDexEntry
	pop af
	ldh [rSVBK], a
	___conversion_bitmap_free_unused wPokemonIndexTable, MON_TABLE
	pop de
	ret

.set_bit
; a = ID; the bitmap is in the tables' WRAM bank
	ld b, a
	ldh a, [rSVBK]
	push af
	ld a, BANK(wConversionTableBitmap)
	ldh [rSVBK], a
	ld a, b
	call .set_bit_in_bank
	pop af
	ldh [rSVBK], a
	ret

.set_bit_in_bank
	___conversion_bitmap_set MON_TABLE

_LockPokemonID::
if MON_TABLE_LOCKED_ENTRIES
	___conversion_table_lock_ID wPokemonIndexTable, MON_TABLE
else
	ld a, h
	scf ; no locked entries (while IDENTITY_INDEX_TABLES, nothing is evicted)
	ret
endc

_GetMoveIndexFromID::
	___conversion_table_load wMoveIndexTable, MOVE_TABLE

_GetMoveIDFromIndex::
	___conversion_table_store wMoveIndexTable, MOVE_TABLE
	; fallthrough
MoveTableGarbageCollection:
	; must preserve de and rSVBK
	push de
	ldh a, [rSVBK]
	push af
	___conversion_bitmap_initialize wMoveIndexTable, MOVE_TABLE, .set_bit
	ld a, 1
	ldh [rSVBK], a
	for ___move, NUM_MOVES
		___conversion_bitmap_check_structs wPartyMon1Moves + ___move, PARTYMON_STRUCT_LENGTH, PARTY_LENGTH, .set_bit
		___conversion_bitmap_check_structs wBreedMon1Moves + ___move, wBreedMon2 - wBreedMon1, 2, .set_bit
		; may or may not be valid
		___conversion_bitmap_check_structs wOTPartyMon1Moves + ___move, PARTYMON_STRUCT_LENGTH, PARTY_LENGTH, .set_bit
		___conversion_bitmap_check_values .set_bit, wEggMonMoves + ___move, wBufferMonMoves + ___move, wTempMonMoves + ___move, \
		                                            wBattleMonMoves + ___move, wEnemyMonMoves + ___move, wWildMonMoves + ___move, \
		                                            wPlayerUsedMoves + ___move
	endr
	ld a, [wNamedObjectIndex] ; or any of its aliases...
	call .set_bit
	; only valid sometimes
	___conversion_bitmap_check_values .set_bit, wCurPlayerMove, wCurEnemyMove, wDisabledMove, wEnemyDisabledMove, \
	                                            wLastPlayerMove, wLastEnemyMove, wLastPlayerCounterMove, wLastEnemyCounterMove, \
	                                            wPlayerTrappingMove, wEnemyTrappingMove, wPlayerMoveStructAnimation, wEnemyMoveStructAnimation, \
	                                            wPutativeTMHMMove
	pop af
	ldh [rSVBK], a
	___conversion_bitmap_free_unused wMoveIndexTable, MOVE_TABLE
	pop de
	ret

.set_bit
	ld b, a
	ldh a, [rSVBK]
	push af
	ld a, BANK(wConversionTableBitmap)
	ldh [rSVBK], a
	ld a, b
	call .set_bit_in_bank
	pop af
	ldh [rSVBK], a
	ret

.set_bit_in_bank
	___conversion_bitmap_set MOVE_TABLE

_LockMoveID::
if MOVE_TABLE_LOCKED_ENTRIES
	___conversion_table_lock_ID wMoveIndexTable, MOVE_TABLE
else
	ld a, h
	scf ; no locked entries (while IDENTITY_INDEX_TABLES, nothing is evicted)
	ret
endc
