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


RedGroup:
	; RED (1)
	next_list_item
	db "RED1@", TRAINERTYPE_RANDOM | TRAINERTYPE_NICKNAME | TRAINERTYPE_DVS | TRAINERTYPE_EVS | TRAINERTYPE_ITEM | TRAINERTYPE_MOVES, 1, RANDOMLIST_0
	db -1 ; end

	; RED (1)
	next_list_item
	db "RED2@", TRAINERTYPE_RANDOM | TRAINERTYPE_NICKNAME | TRAINERTYPE_DVS | TRAINERTYPE_ITEM | TRAINERTYPE_MOVES, 1, RANDOMLIST_1
	db -1 ; end

	end_list_items
MaximaGroup:
	; Maxima (1)
	next_list_item
	db "Maxima@", TRAINERTYPE_RANDOM | TRAINERTYPE_NICKNAME | TRAINERTYPE_DVS | TRAINERTYPE_ITEM | TRAINERTYPE_MOVES, 6, RANDOMLIST_2
	db -1 ; end

	end_list_items
RandomPartyLists::

	next_list_item ; RANDOMLIST_0
	db 2
	next_random_mon
	db 1
	dw TORTERRA
			db "DINO@"		; Nickname
			db $EA, $AA		; DVs - atk|def dv, spd|spc dv
			ds 6, MAX_EV	; EVs - hp, atk, def, spd, sat, sdf 
			db LEFTOVERS	; ITEM/ NO_ITEM is a thing
			dw SLEEP_POWDER, LEECH_SEED, GIGA_DRAIN, ROCK_SLIDE ; Moveset - NO_MOVE is a thing
	next_random_mon
	db 1
	dw CHARIZARD
			db "ZARD@"		; Nickname
			db $DD, $DD		; DVs - atk|def dv, spd|spc dv
			ds 6, MAX_EV	; EVs - hp, atk, def, spd, sat, sdf 
			db LEFTOVERS	; ITEM/ NO_ITEM is a thing
			dw SLEEP_POWDER, LEECH_SEED, GIGA_DRAIN, ROCK_SLIDE ; Moveset - NO_MOVE is a thing
	end_random_mons
	db -1 ; end

	next_list_item ; RANDOMLIST_1
	db 1
	next_random_mon
	db 35
	dw MAGIKARP
			db "Lax@"		; Nickname
			db $EA, $AA		; DVs - atk|def dv, spd|spc dv
			db NO_ITEM	; ITEM/ NO_ITEM is a thing
			dw SPLASH, NO_MOVE, NO_MOVE, NO_MOVE ; Moveset - NO_MOVE is a thing
	end_random_mons
	db -1 ; end




; commented out team for future tests

	next_list_item ; RANDOMLIST_2
	db 10
	next_random_mon
	db 50
	dw RHYDON
			db "Don@"		; Nickname
			db $EA, $AA		; DVs - atk|def dv, spd|spc dv
			db FOCUS_SASH	; ITEM/ NO_ITEM is a thing
			dw EARTHQUAKE, DRAGON_DANCE, STONE_EDGE, DRAIN_PUNCH ; Moveset - NO_MOVE is a thing
	next_random_mon
	db 50
	dw MEWTWO
			db "Mewtwo@"		; Nickname
			db $EA, $AA		; DVs - atk|def dv, spd|spc dv
			db LEFTOVERS	; ITEM/ NO_ITEM is a thing
			dw CALM_MIND, PSYBLAST, AURA_SPHERE, RECOVER ; Moveset - NO_MOVE is a thing
	next_random_mon
	db 50
	dw HAXORUS
			db "Dino@"		; Nickname
			db $EA, $AA		; DVs - atk|def dv, spd|spc dv
			db LEFTOVERS	; ITEM/ NO_ITEM is a thing
			dw DRAGON_DANCE, OUTRAGE, EARTHQUAKE, ROCK_SLIDE ; Moveset - NO_MOVE is a thing
	next_random_mon
	db 50
	dw HO_OH
			db "Rainbow@"		; Nickname
			db $DD, $DD		; DVs - atk|def dv, spd|spc dv
			db LEFTOVERS	; ITEM/ NO_ITEM is a thing
			dw BULK_UP, RECOVER, SACRED_FIRE, SKY_ATTACK ; Moveset - NO_MOVE is a thing
	next_random_mon
	db 50
	dw CHARIZARD
			db "Zard@"		; Nickname
			db $DD, $DD		; DVs - atk|def dv, spd|spc dv
			db LEFTOVERS	; ITEM/ NO_ITEM is a thing
			dw DRAGON_CLAW, FLARE_BLITZ, DRAGON_DANCE, ROOST ; Moveset - NO_MOVE is a thing
	next_random_mon
	db 50
	dw MOLTRES
			db "Moltres@"		; Nickname
			db $DD, $DD		; DVs - atk|def dv, spd|spc dv
			db LEFTOVERS	; ITEM/ NO_ITEM is a thing
			dw FLAMETHROWER, SOLARBEAM, ROOST, SKY_ATTACK ; Moveset - NO_MOVE is a thing
	next_random_mon
	db 50
	dw SUDOWOODO
			db "Sudowoodo@"		; Nickname
			db $DD, $DD		; DVs - atk|def dv, spd|spc dv
			db LEFTOVERS	; ITEM/ NO_ITEM is a thing
			dw STONE_EDGE, DRAIN_PUNCH, EARTHQUAKE, SEED_BOMB ; Moveset - NO_MOVE is a thing
	next_random_mon
	db 50
	dw LUGIA
			db "Silver@"	; Nickname
			db $DD, $DD		; DVs - atk|def dv, spd|spc dv
			db LEFTOVERS	; ITEM/ NO_ITEM is a thing
			dw CALM_MIND, RECOVER, AEROBLAST, SCALD ; Moveset - NO_MOVE is a thing
	next_random_mon
	db 50
	dw GARCHOMP
			db "Chomp@"		; Nickname
			db $DD, $DD		; DVs - atk|def dv, spd|spc dv
			db LIFE_ORB	; ITEM/ NO_ITEM is a thing
			dw IRON_HEAD, OUTRAGE, EARTHQUAKE, FIRE_FANG ; Moveset - NO_MOVE is a thing
	next_random_mon
	db 50
	dw GARDEVOIR
			db "Tulpa@"		; Nickname
			db $FF, $FF		; DVs - atk|def dv, spd|spc dv
			db ZOOM_LENS	; ITEM/ NO_ITEM is a thing
			dw HYPNOSIS, DREAM_EATER, MOONBLAST, AURA_SPHERE ; Moveset - NO_MOVE is a thing
	end_random_mons
	db -1 ; end
	end_list_items
