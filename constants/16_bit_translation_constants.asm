; 16-bit species and move indexes (pokecrystal16, as in ChattyCrystal).
;
; Species and moves are numbered with 16-bit indexes (the constants in
; pokemon_constants.asm / move_constants.asm, and every ROM table). RAM keeps
; 8-bit IDs: each one is a slot in a conversion table (engine/16) that holds
; the 16-bit index it stands for. GetPokemonIndexFromID / GetMoveIndexFromID
; turn an ID into its index, GetPokemonIDFromIndex / GetMoveIDFromIndex the
; other way round (allocating a slot if the index has none).
;
; _ENTRIES: number of entries in the table; 8-bit IDs $01 .. _ENTRIES are slots
; _LOCKED_ENTRIES: IDs stored here are never evicted by the garbage collector
;                  (for IDs in use on the current screen, map script, etc.)
; _CACHE_SIZE: fast lookup cache for index -> ID (power of two, or 0)
; _SAVED_RECENT_INDEXES: recently allocated IDs, also never evicted
; _MINIMUM_RESERVED_INDEX: IDs at or above this aren't in the table: they stand
;                          for $FF00 + ID (e.g. EGG = $FD = index -3)

; While the port is in progress, the tables hold every index at the same
; 8-bit ID (identity mapping, filled in by InitIndexTables), so code that
; still uses 8-bit constants keeps working. Set to 0 once everything is
; converted.
DEF IDENTITY_INDEX_TABLES EQU 1

; the tables' size once the IDs are allocated freely: how many species / moves
; can be in RAM at once (party, battle, day-care, screens...)
DEF MON_TABLE_FINAL_ENTRIES  EQU 100
DEF MOVE_TABLE_FINAL_ENTRIES EQU 230

if IDENTITY_INDEX_TABLES
DEF MON_TABLE_ENTRIES                EQU $FC ; = NUM_POKEMON while the IDs are fixed
DEF MON_TABLE_LOCKED_ENTRIES         EQU   0
DEF MON_TABLE_CACHE_SIZE             EQU   4
DEF MON_TABLE_SAVED_RECENT_INDEXES   EQU   2

DEF MOVE_TABLE_ENTRIES               EQU $FD ; = NUM_ATTACKS while the IDs are fixed
DEF MOVE_TABLE_LOCKED_ENTRIES        EQU   0
DEF MOVE_TABLE_CACHE_SIZE            EQU   0
DEF MOVE_TABLE_SAVED_RECENT_INDEXES  EQU   2
else
DEF MON_TABLE_ENTRIES                EQU MON_TABLE_FINAL_ENTRIES
DEF MON_TABLE_LOCKED_ENTRIES         EQU  30
DEF MON_TABLE_CACHE_SIZE             EQU  16
DEF MON_TABLE_SAVED_RECENT_INDEXES   EQU   8

DEF MOVE_TABLE_ENTRIES               EQU MOVE_TABLE_FINAL_ENTRIES
DEF MOVE_TABLE_LOCKED_ENTRIES        EQU  18
DEF MOVE_TABLE_CACHE_SIZE            EQU  16
DEF MOVE_TABLE_SAVED_RECENT_INDEXES  EQU  16
endc

DEF MON_TABLE_MINIMUM_RESERVED_INDEX  EQU $FD ; keeps EGG ($FD) reserved
DEF MOVE_TABLE_MINIMUM_RESERVED_INDEX EQU $FF

; the part of each table that is saved: used slots, last allocated index and
; entries (the cache, locked and recent IDs are cleared when a game is loaded);
; sized for the final tables, since the identity tables aren't saved
DEF SAVED_MON_TABLE_LENGTH  EQU 2 + 2 * MON_TABLE_FINAL_ENTRIES
DEF SAVED_MOVE_TABLE_LENGTH EQU 2 + 2 * MOVE_TABLE_FINAL_ENTRIES
