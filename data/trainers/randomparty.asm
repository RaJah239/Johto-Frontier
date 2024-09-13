; Trainer data structure:
; - db "NAME@", TRAINERTYPE_* constants |ed together
; - 1 to 6 Pokémon:
;    * in all cases:              db level, species
;    * with TRAINERTYPE_NICKNAME: db "NICKNAME@"
;    * with TRAINERTYPE_DVS:      db atk|def dv, spd|spc dv
;    * with TRAINERTYPE_EVS: 	  db hp, atk, def, spd, sat, sdf 
;    * with TRAINERTYPE_ITEM:     db item
;    * with TRAINERTYPE_MOVES:    db move 1, move 2, move 3, move 4
;    (TRAINERTYPE_ITEM_MOVES is just TRAINERTYPE_ITEM | TRAINERTYPE_MOVES)
; - db -1 ; end

SECTION "Random Party Lists", ROMX

; EXAMPLE -: The Trainer's Group must be above RandomPartyLists::
;TrainerGroup: 
;	; MAXIMA (1)
	db "MAXIMA@", TRAINERTYPE_RANDOM | TRAINERTYPE_NICKNAME | TRAINERTYPE_DVS | TRAINERTYPE_EVS | TRAINERTYPE_ITEM | TRAINERTYPE_MOVES, 1, RANDOMLIST_0 ; RANDOMLIST_0 matches const RANDOMLIST_0
;	db -1 ; end

RandomPartyLists::

; EXAMPLE from above continued -:
;   ; RANDOMLIST_0
;   db 2
;	db 1, VENUSAUR
;			db "DINO@"		; Nickname
;			db $EA, $AA		; atk|def dv, spd|spc dv
;			ds 6, MAX_EV	; hp, atk, def, spd, sat, sdf 
;			db LEFTOVERS	; NO_ITEM is a thing
;			db SLEEP_POWDER, LEECH_SEED, GIGA_DRAIN, ROCK_SLIDE ; Moveset - NO_MOVE is a thing
;			db $fe ; End of Pokemon
;	db 1, CHARIZARD
;			db "ZARD@"		; Nickname
;			db $DE, $DD		; atk|def dv, spd|spc dv
;			ds 6, MAX_EV	; hp, atk, def, spd, sat, sdf 
;			db LEFTOVERS	; NO_ITEM is a thing
;			db SLEEP_POWDER, LEECH_SEED, GIGA_DRAIN, ROCK_SLIDE ; Moveset - NO_MOVE is a thing
;			db $fe ; End of Pokemon
;	db -1 ; end
