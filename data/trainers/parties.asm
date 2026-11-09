; Trainer data structure:
; - next_list_item (the trainer's length, so trainers are skipped by length:
;   the 16-bit species / moves can hold any byte); end each group with
;   end_list_items
; - db "NAME@", TRAINERTYPE_* constants |ed together
; - 1 to 6 Pokémon:
;    * in all cases:              db level / dw species (16-bit index)
;    * with TRAINERTYPE_NICKNAME: db "NICKNAME@"
;    * with TRAINERTYPE_DVS:      db atk|def dv, spd|spc dv
;    * with TRAINERTYPE_EVS: 	  db hp, atk, def, spd, sat, sdf 
;    * with TRAINERTYPE_ITEM:     db item
;    * with TRAINERTYPE_MOVES:    dw move 1, move 2, move 3, move 4 (16-bit indexes)
;    (TRAINERTYPE_ITEM_MOVES is just TRAINERTYPE_ITEM | TRAINERTYPE_MOVES)
; - db -1 ; end

; EXAMPLE
;	; RED (1)
;	db "Red@", TRAINERTYPE_NICKNAME | TRAINERTYPE_DVS | TRAINERTYPE_EVS | TRAINERTYPE_ITEM_MOVES
;	db 100, PIKACHU
;		db "ZAPPY@"
;		db $EA, $AA ; dvs - atk|def dv, spd|spc dv
;		ds 6, MAX_EV ; evs - hp, atk, def, spd, sat, sdf 
;		db LIGHT_BALL
;		db PROTECT, EXTREMESPEED, THUNDERBOLT, SURF
;	db 100, SNORLAX
;		db "BIGFOOT@"
;		db $EC, PERFECT_DV ; dvs - atk|def dv, spd|spc dv
;		db 12, 16, 12, 16, 16, 12 ; evs - hp, atk, def, spd, sat, sdf 
;		db LEFTOVERS
;		db CURSE, REST, EARTHQUAKE, BODY_SLAM
;	db -1 ; end

SECTION "Enemy Trainer Parties 1", ROMX

FalknerGroup:
	; Falkner (1)
	next_list_item
	db "Falkner@", TRAINERTYPE_ITEM_MOVES
	db PARTY_LV
	dw SKARMORY
	db LEFTOVERS
	dw STEALTH_ROCK, IRON_BASH, TOXIC, ROOST
	db -1 ; end

	; Falkner (2)
	next_list_item
	db "Falkner@", TRAINERTYPE_ITEM_MOVES
	db PARTY_LV
	dw SKARMORY
	db LEFTOVERS
	dw STEALTH_ROCK, IRON_BASH, TOXIC, ROOST
	db PARTY_LV
	dw PIDGEOT
	db LEFTOVERS
	dw ROOST, STEEL_WING, SKY_ATTACK, EXTREMESPEED
	db -1 ; end

	; Falkner (3)
	next_list_item
	db "Falkner@", TRAINERTYPE_ITEM_MOVES
	db PARTY_LV
	dw SKARMORY
	db LEFTOVERS
	dw STEALTH_ROCK, IRON_BASH, TOXIC, ROOST
	db PARTY_LV
	dw PIDGEOT
	db LEFTOVERS
	dw ROOST, STEEL_WING, SKY_ATTACK, EXTREMESPEED
	db PARTY_LV
	dw PIDGEOT
	db LEFTOVERS
	dw THUNDERBOLT, SKY_ATTACK, ROOST, TOXIC
	db -1 ; end

	; Falkner (4)
	next_list_item
	db "Falkner@", TRAINERTYPE_ITEM_MOVES
	db PARTY_LV
	dw SKARMORY
	db LEFTOVERS
	dw STEALTH_ROCK, IRON_BASH, TOXIC, ROOST
	db PARTY_LV
	dw PIDGEOT
	db LEFTOVERS
	dw ROOST, STEEL_WING, SKY_ATTACK, EXTREMESPEED
	db PARTY_LV
	dw PIDGEOT
	db LEFTOVERS
	dw THUNDERBOLT, SKY_ATTACK, ROOST, TOXIC
	db PARTY_LV
	dw AERODACTYL
	db CHOICE_BAND
	dw EARTHQUAKE, ROCK_SLIDE, SKY_ATTACK, IRON_HEAD
	db -1 ; end

	; Falkner (5)
	next_list_item
	db "Falkner@", TRAINERTYPE_ITEM_MOVES
	db 50
	dw SKARMORY
	db LEFTOVERS
	dw STEALTH_ROCK, IRON_BASH, TOXIC, ROOST
	db 50
	dw PIDGEOT
	db LEFTOVERS
	dw ROOST, STEEL_WING, SKY_ATTACK, EXTREMESPEED
	db 50
	dw PIDGEOT
	db LEFTOVERS
	dw THUNDERBOLT, SKY_ATTACK, ROOST, TOXIC
	db 50
	dw AERODACTYL
	db CHOICE_BAND
	dw EARTHQUAKE, ROCK_SLIDE, SKY_ATTACK, IRON_HEAD
	db 50
	dw GLISCOR
	db LEFTOVERS
	dw ROOST, EARTHQUAKE, ROCK_SLIDE, DIVE_BOMB
	db 50
	dw LUGIA
	db LEFTOVERS
	dw CALM_MIND, AEROBLAST, SCALD, RECOVER
	db -1 ; end

	end_list_items
BugsyGroup:
	; Bugsy (1)
	next_list_item
	db "Bugsy@", TRAINERTYPE_ITEM_MOVES
	db PARTY_LV
	dw SKARMORY
	db LEFTOVERS
	dw STEALTH_ROCK, IRON_BASH, TOXIC, ROOST
	db -1 ; end

	; Bugsy (2)
	next_list_item
	db "Bugsy@", TRAINERTYPE_ITEM_MOVES
	db PARTY_LV
	dw SKARMORY
	db LEFTOVERS
	dw STEALTH_ROCK, IRON_BASH, TOXIC, ROOST
	db PARTY_LV
	dw PIDGEOT
	db LEFTOVERS
	dw ROOST, STEEL_WING, SKY_ATTACK, EXTREMESPEED
	db -1 ; end

	; Bugsy (3)
	next_list_item
	db "Bugsy@", TRAINERTYPE_ITEM_MOVES
	db PARTY_LV
	dw SKARMORY
	db LEFTOVERS
	dw STEALTH_ROCK, IRON_BASH, TOXIC, ROOST
	db PARTY_LV
	dw PIDGEOT
	db LEFTOVERS
	dw ROOST, STEEL_WING, SKY_ATTACK, EXTREMESPEED
	db PARTY_LV
	dw PIDGEOT
	db LEFTOVERS
	dw THUNDERBOLT, SKY_ATTACK, ROOST, TOXIC
	db -1 ; end

	; Bugsy (4)
	next_list_item
	db "Bugsy@", TRAINERTYPE_ITEM_MOVES
	db PARTY_LV
	dw SKARMORY
	db LEFTOVERS
	dw STEALTH_ROCK, IRON_BASH, TOXIC, ROOST
	db PARTY_LV
	dw PIDGEOT
	db LEFTOVERS
	dw ROOST, STEEL_WING, SKY_ATTACK, EXTREMESPEED
	db PARTY_LV
	dw PIDGEOT
	db LEFTOVERS
	dw THUNDERBOLT, SKY_ATTACK, ROOST, TOXIC
	db PARTY_LV
	dw AERODACTYL
	db CHOICE_BAND
	dw EARTHQUAKE, ROCK_SLIDE, SKY_ATTACK, IRON_HEAD
	db -1 ; end

	; Bugsy (5)
	next_list_item
	db "Bugsy@", TRAINERTYPE_ITEM_MOVES
	db 50
	dw SKARMORY
	db LEFTOVERS
	dw STEALTH_ROCK, IRON_BASH, TOXIC, ROOST
	db 50
	dw PIDGEOT
	db LEFTOVERS
	dw ROOST, STEEL_WING, SKY_ATTACK, EXTREMESPEED
	db 50
	dw PIDGEOT
	db LEFTOVERS
	dw THUNDERBOLT, SKY_ATTACK, ROOST, TOXIC
	db 50
	dw AERODACTYL
	db CHOICE_BAND
	dw EARTHQUAKE, ROCK_SLIDE, SKY_ATTACK, IRON_HEAD
	db 50
	dw GLISCOR
	db LEFTOVERS
	dw ROOST, EARTHQUAKE, ROCK_SLIDE, DIVE_BOMB
	db 50
	dw LUGIA
	db LEFTOVERS
	dw CALM_MIND, AEROBLAST, SCALD, RECOVER
	db -1 ; end

	end_list_items
WhitneyGroup:
	; WHITNEY1 (1)
	next_list_item
	db "Whitney@", TRAINERTYPE_ITEM_MOVES
	db PARTY_LV
	dw SKARMORY
	db LEFTOVERS
	dw STEALTH_ROCK, IRON_BASH, TOXIC, ROOST
	db -1 ; end

	; WHITNEY2 (2)
	next_list_item
	db "Whitney@", TRAINERTYPE_ITEM_MOVES
	db PARTY_LV
	dw SKARMORY
	db LEFTOVERS
	dw STEALTH_ROCK, IRON_BASH, TOXIC, ROOST
	db PARTY_LV
	dw PIDGEOT
	db LEFTOVERS
	dw ROOST, STEEL_WING, SKY_ATTACK, EXTREMESPEED
	db -1 ; end

	; WHITNEY3 (3)
	next_list_item
	db "Whitney@", TRAINERTYPE_ITEM_MOVES
	db PARTY_LV
	dw SKARMORY
	db LEFTOVERS
	dw STEALTH_ROCK, IRON_BASH, TOXIC, ROOST
	db PARTY_LV
	dw PIDGEOT
	db LEFTOVERS
	dw ROOST, STEEL_WING, SKY_ATTACK, EXTREMESPEED
	db PARTY_LV
	dw PIDGEOT
	db LEFTOVERS
	dw THUNDERBOLT, SKY_ATTACK, ROOST, TOXIC
	db -1 ; end

	; WHITNEY4 (4)
	next_list_item
	db "Whitney@", TRAINERTYPE_ITEM_MOVES
	db PARTY_LV
	dw SKARMORY
	db LEFTOVERS
	dw STEALTH_ROCK, IRON_BASH, TOXIC, ROOST
	db PARTY_LV
	dw PIDGEOT
	db LEFTOVERS
	dw ROOST, STEEL_WING, SKY_ATTACK, EXTREMESPEED
	db PARTY_LV
	dw PIDGEOT
	db LEFTOVERS
	dw THUNDERBOLT, SKY_ATTACK, ROOST, TOXIC
	db PARTY_LV
	dw AERODACTYL
	db CHOICE_BAND
	dw EARTHQUAKE, ROCK_SLIDE, SKY_ATTACK, IRON_HEAD
	db -1 ; end

	; WHITNEY5 (5)
	next_list_item
	db "Whitney@", TRAINERTYPE_ITEM_MOVES
	db 50
	dw SKARMORY
	db LEFTOVERS
	dw STEALTH_ROCK, IRON_BASH, TOXIC, ROOST
	db 50
	dw PIDGEOT
	db LEFTOVERS
	dw ROOST, STEEL_WING, SKY_ATTACK, EXTREMESPEED
	db 50
	dw PIDGEOT
	db LEFTOVERS
	dw THUNDERBOLT, SKY_ATTACK, ROOST, TOXIC
	db 50
	dw AERODACTYL
	db CHOICE_BAND
	dw EARTHQUAKE, ROCK_SLIDE, SKY_ATTACK, IRON_HEAD
	db 50
	dw GLISCOR
	db LEFTOVERS
	dw ROOST, EARTHQUAKE, ROCK_SLIDE, DIVE_BOMB
	db 50
	dw LUGIA
	db LEFTOVERS
	dw CALM_MIND, AEROBLAST, SCALD, RECOVER
	db -1 ; end

	end_list_items
MortyGroup:
	; MORTY1 (1)
	next_list_item
	db "Morty@", TRAINERTYPE_ITEM_MOVES
	db PARTY_LV
	dw SKARMORY
	db LEFTOVERS
	dw STEALTH_ROCK, IRON_BASH, TOXIC, ROOST
	db -1 ; end

	; MORTY2 (2)
	next_list_item
	db "Morty@", TRAINERTYPE_ITEM_MOVES
	db PARTY_LV
	dw SKARMORY
	db LEFTOVERS
	dw STEALTH_ROCK, IRON_BASH, TOXIC, ROOST
	db PARTY_LV
	dw PIDGEOT
	db LEFTOVERS
	dw ROOST, STEEL_WING, SKY_ATTACK, EXTREMESPEED
	db -1 ; end

	; MORTY3 (3)
	next_list_item
	db "Morty@", TRAINERTYPE_ITEM_MOVES
	db PARTY_LV
	dw SKARMORY
	db LEFTOVERS
	dw STEALTH_ROCK, IRON_BASH, TOXIC, ROOST
	db PARTY_LV
	dw PIDGEOT
	db LEFTOVERS
	dw ROOST, STEEL_WING, SKY_ATTACK, EXTREMESPEED
	db PARTY_LV
	dw PIDGEOT
	db LEFTOVERS
	dw THUNDERBOLT, SKY_ATTACK, ROOST, TOXIC
	db -1 ; end

	; MORTY4 (4)
	next_list_item
	db "Morty@", TRAINERTYPE_ITEM_MOVES
	db PARTY_LV
	dw SKARMORY
	db LEFTOVERS
	dw STEALTH_ROCK, IRON_BASH, TOXIC, ROOST
	db PARTY_LV
	dw PIDGEOT
	db LEFTOVERS
	dw ROOST, STEEL_WING, SKY_ATTACK, EXTREMESPEED
	db PARTY_LV
	dw PIDGEOT
	db LEFTOVERS
	dw THUNDERBOLT, SKY_ATTACK, ROOST, TOXIC
	db PARTY_LV
	dw AERODACTYL
	db CHOICE_BAND
	dw EARTHQUAKE, ROCK_SLIDE, SKY_ATTACK, IRON_HEAD
	db -1 ; end

	; MORTY5 (5)
	next_list_item
	db "Morty@", TRAINERTYPE_ITEM_MOVES
	db 50
	dw SKARMORY
	db LEFTOVERS
	dw STEALTH_ROCK, IRON_BASH, TOXIC, ROOST
	db 50
	dw PIDGEOT
	db LEFTOVERS
	dw ROOST, STEEL_WING, SKY_ATTACK, EXTREMESPEED
	db 50
	dw PIDGEOT
	db LEFTOVERS
	dw THUNDERBOLT, SKY_ATTACK, ROOST, TOXIC
	db 50
	dw AERODACTYL
	db CHOICE_BAND
	dw EARTHQUAKE, ROCK_SLIDE, SKY_ATTACK, IRON_HEAD
	db 50
	dw GLISCOR
	db LEFTOVERS
	dw ROOST, EARTHQUAKE, ROCK_SLIDE, DIVE_BOMB
	db 50
	dw LUGIA
	db LEFTOVERS
	dw CALM_MIND, AEROBLAST, SCALD, RECOVER
	db -1 ; end

	end_list_items
JasmineGroup:
	; JASMINE1 (1)
	next_list_item
	db "Jasmine@", TRAINERTYPE_ITEM_MOVES
	db PARTY_LV
	dw SKARMORY
	db LEFTOVERS
	dw STEALTH_ROCK, IRON_BASH, TOXIC, ROOST
	db -1 ; end

	; JASMINE2 (2)
	next_list_item
	db "Jasmine@", TRAINERTYPE_ITEM_MOVES
	db PARTY_LV
	dw SKARMORY
	db LEFTOVERS
	dw STEALTH_ROCK, IRON_BASH, TOXIC, ROOST
	db PARTY_LV
	dw PIDGEOT
	db LEFTOVERS
	dw ROOST, STEEL_WING, SKY_ATTACK, EXTREMESPEED
	db -1 ; end

	; JASMINE3 (3)
	next_list_item
	db "Jasmine@", TRAINERTYPE_ITEM_MOVES
	db PARTY_LV
	dw SKARMORY
	db LEFTOVERS
	dw STEALTH_ROCK, IRON_BASH, TOXIC, ROOST
	db PARTY_LV
	dw PIDGEOT
	db LEFTOVERS
	dw ROOST, STEEL_WING, SKY_ATTACK, EXTREMESPEED
	db PARTY_LV
	dw PIDGEOT
	db LEFTOVERS
	dw THUNDERBOLT, SKY_ATTACK, ROOST, TOXIC
	db -1 ; end

	; JASMINE4 (4)
	next_list_item
	db "Jasmine@", TRAINERTYPE_ITEM_MOVES
	db PARTY_LV
	dw SKARMORY
	db LEFTOVERS
	dw STEALTH_ROCK, IRON_BASH, TOXIC, ROOST
	db PARTY_LV
	dw PIDGEOT
	db LEFTOVERS
	dw ROOST, STEEL_WING, SKY_ATTACK, EXTREMESPEED
	db PARTY_LV
	dw PIDGEOT
	db LEFTOVERS
	dw THUNDERBOLT, SKY_ATTACK, ROOST, TOXIC
	db PARTY_LV
	dw AERODACTYL
	db CHOICE_BAND
	dw EARTHQUAKE, ROCK_SLIDE, SKY_ATTACK, IRON_HEAD
	db -1 ; end

	; JASMINE5 (5)
	next_list_item
	db "Jasmine@", TRAINERTYPE_ITEM_MOVES
	db 50
	dw SKARMORY
	db LEFTOVERS
	dw STEALTH_ROCK, IRON_BASH, TOXIC, ROOST
	db 50
	dw PIDGEOT
	db LEFTOVERS
	dw ROOST, STEEL_WING, SKY_ATTACK, EXTREMESPEED
	db 50
	dw PIDGEOT
	db LEFTOVERS
	dw THUNDERBOLT, SKY_ATTACK, ROOST, TOXIC
	db 50
	dw AERODACTYL
	db CHOICE_BAND
	dw EARTHQUAKE, ROCK_SLIDE, SKY_ATTACK, IRON_HEAD
	db 50
	dw GLISCOR
	db LEFTOVERS
	dw ROOST, EARTHQUAKE, ROCK_SLIDE, DIVE_BOMB
	db 50
	dw LUGIA
	db LEFTOVERS
	dw CALM_MIND, AEROBLAST, SCALD, RECOVER
	db -1 ; end

	end_list_items
ChuckGroup:
	; CHUCK1 (1)
	next_list_item
	db "Chuck@", TRAINERTYPE_ITEM_MOVES
	db PARTY_LV
	dw SKARMORY
	db LEFTOVERS
	dw STEALTH_ROCK, IRON_BASH, TOXIC, ROOST
	db -1 ; end

	; CHUCK2 (2)
	next_list_item
	db "Chuck@", TRAINERTYPE_ITEM_MOVES
	db PARTY_LV
	dw SKARMORY
	db LEFTOVERS
	dw STEALTH_ROCK, IRON_BASH, TOXIC, ROOST
	db PARTY_LV
	dw PIDGEOT
	db LEFTOVERS
	dw ROOST, STEEL_WING, SKY_ATTACK, EXTREMESPEED
	db -1 ; end

	; CHUCK3 (3)
	next_list_item
	db "Chuck@", TRAINERTYPE_ITEM_MOVES
	db PARTY_LV
	dw SKARMORY
	db LEFTOVERS
	dw STEALTH_ROCK, IRON_BASH, TOXIC, ROOST
	db PARTY_LV
	dw PIDGEOT
	db LEFTOVERS
	dw ROOST, STEEL_WING, SKY_ATTACK, EXTREMESPEED
	db PARTY_LV
	dw PIDGEOT
	db LEFTOVERS
	dw THUNDERBOLT, SKY_ATTACK, ROOST, TOXIC
	db -1 ; end

	; CHUCK4 (4)
	next_list_item
	db "Chuck@", TRAINERTYPE_ITEM_MOVES
	db PARTY_LV
	dw SKARMORY
	db LEFTOVERS
	dw STEALTH_ROCK, IRON_BASH, TOXIC, ROOST
	db PARTY_LV
	dw PIDGEOT
	db LEFTOVERS
	dw ROOST, STEEL_WING, SKY_ATTACK, EXTREMESPEED
	db PARTY_LV
	dw PIDGEOT
	db LEFTOVERS
	dw THUNDERBOLT, SKY_ATTACK, ROOST, TOXIC
	db PARTY_LV
	dw AERODACTYL
	db CHOICE_BAND
	dw EARTHQUAKE, ROCK_SLIDE, SKY_ATTACK, IRON_HEAD
	db -1 ; end

	; CHUCK5 (5)
	next_list_item
	db "Chuck@", TRAINERTYPE_ITEM_MOVES
	db 50
	dw SKARMORY
	db LEFTOVERS
	dw STEALTH_ROCK, IRON_BASH, TOXIC, ROOST
	db 50
	dw PIDGEOT
	db LEFTOVERS
	dw ROOST, STEEL_WING, SKY_ATTACK, EXTREMESPEED
	db 50
	dw PIDGEOT
	db LEFTOVERS
	dw THUNDERBOLT, SKY_ATTACK, ROOST, TOXIC
	db 50
	dw AERODACTYL
	db CHOICE_BAND
	dw EARTHQUAKE, ROCK_SLIDE, SKY_ATTACK, IRON_HEAD
	db 50
	dw GLISCOR
	db LEFTOVERS
	dw ROOST, EARTHQUAKE, ROCK_SLIDE, DIVE_BOMB
	db 50
	dw LUGIA
	db LEFTOVERS
	dw CALM_MIND, AEROBLAST, SCALD, RECOVER
	db -1 ; end

	end_list_items
PryceGroup:
	; PRYCE1 (1)
	next_list_item
	db "Pryce@", TRAINERTYPE_ITEM_MOVES
	db PARTY_LV
	dw SKARMORY
	db LEFTOVERS
	dw STEALTH_ROCK, IRON_BASH, TOXIC, ROOST
	db -1 ; end

	; PRYCE2 (2)
	next_list_item
	db "Pryce@", TRAINERTYPE_ITEM_MOVES
	db PARTY_LV
	dw SKARMORY
	db LEFTOVERS
	dw STEALTH_ROCK, IRON_BASH, TOXIC, ROOST
	db PARTY_LV
	dw PIDGEOT
	db LEFTOVERS
	dw ROOST, STEEL_WING, SKY_ATTACK, EXTREMESPEED
	db -1 ; end

	; PRYCE3 (3)
	next_list_item
	db "Pryce@", TRAINERTYPE_ITEM_MOVES
	db PARTY_LV
	dw SKARMORY
	db LEFTOVERS
	dw STEALTH_ROCK, IRON_BASH, TOXIC, ROOST
	db PARTY_LV
	dw PIDGEOT
	db LEFTOVERS
	dw ROOST, STEEL_WING, SKY_ATTACK, EXTREMESPEED
	db PARTY_LV
	dw PIDGEOT
	db LEFTOVERS
	dw THUNDERBOLT, SKY_ATTACK, ROOST, TOXIC
	db -1 ; end

	; PRYCE4 (4)
	next_list_item
	db "Pryce@", TRAINERTYPE_ITEM_MOVES
	db PARTY_LV
	dw SKARMORY
	db LEFTOVERS
	dw STEALTH_ROCK, IRON_BASH, TOXIC, ROOST
	db PARTY_LV
	dw PIDGEOT
	db LEFTOVERS
	dw ROOST, STEEL_WING, SKY_ATTACK, EXTREMESPEED
	db PARTY_LV
	dw PIDGEOT
	db LEFTOVERS
	dw THUNDERBOLT, SKY_ATTACK, ROOST, TOXIC
	db PARTY_LV
	dw AERODACTYL
	db CHOICE_BAND
	dw EARTHQUAKE, ROCK_SLIDE, SKY_ATTACK, IRON_HEAD
	db -1 ; end

	; PRYCE5 (5)
	next_list_item
	db "Pryce@", TRAINERTYPE_ITEM_MOVES
	db 50
	dw SKARMORY
	db LEFTOVERS
	dw STEALTH_ROCK, IRON_BASH, TOXIC, ROOST
	db 50
	dw PIDGEOT
	db LEFTOVERS
	dw ROOST, STEEL_WING, SKY_ATTACK, EXTREMESPEED
	db 50
	dw PIDGEOT
	db LEFTOVERS
	dw THUNDERBOLT, SKY_ATTACK, ROOST, TOXIC
	db 50
	dw AERODACTYL
	db CHOICE_BAND
	dw EARTHQUAKE, ROCK_SLIDE, SKY_ATTACK, IRON_HEAD
	db 50
	dw GLISCOR
	db LEFTOVERS
	dw ROOST, EARTHQUAKE, ROCK_SLIDE, DIVE_BOMB
	db 50
	dw LUGIA
	db LEFTOVERS
	dw CALM_MIND, AEROBLAST, SCALD, RECOVER
	db -1 ; end

	end_list_items
ClairGroup:
	; CLAIR1 (1)
	next_list_item
	db "Clair@", TRAINERTYPE_ITEM_MOVES
	db PARTY_LV
	dw SKARMORY
	db LEFTOVERS
	dw STEALTH_ROCK, IRON_BASH, TOXIC, ROOST
	db -1 ; end

	; Clair (2)
	next_list_item
	db "Pryce@", TRAINERTYPE_ITEM_MOVES
	db 50
	dw SKARMORY
	db LEFTOVERS
	dw STEALTH_ROCK, IRON_BASH, TOXIC, ROOST
	db 50
	dw PIDGEOT
	db LEFTOVERS
	dw ROOST, STEEL_WING, SKY_ATTACK, EXTREMESPEED
	db 50
	dw PIDGEOT
	db LEFTOVERS
	dw THUNDERBOLT, SKY_ATTACK, ROOST, TOXIC
	db 50
	dw AERODACTYL
	db CHOICE_BAND
	dw EARTHQUAKE, ROCK_SLIDE, SKY_ATTACK, IRON_HEAD
	db 50
	dw GLISCOR
	db LEFTOVERS
	dw ROOST, EARTHQUAKE, ROCK_SLIDE, DIVE_BOMB
	db 50
	dw LUGIA
	db LEFTOVERS
	dw CALM_MIND, AEROBLAST, SCALD, RECOVER
	db -1 ; end

	end_list_items
Rival1Group:
PokemonProfGroup:
WillGroup:
BrunoGroup:
KarenGroup:
KogaGroup:
ChampionGroup:
BrockGroup:
MistyGroup:
LtSurgeGroup:
ErikaGroup:
YoungsterGroup:
SchoolboyGroup:
JanineGroup:
CooltrainerMGroup:
CooltrainerFGroup:
PokemaniacGroup:
GruntMGroup:
GentlemanGroup:
SabrinaGroup:
FisherGroup:
SwimmerMGroup:
SwimmerFGroup:
SuperNerdGroup:
Rival2Group:
GuitaristGroup:
BikerGroup:
BlaineGroup:
BurglarGroup:
FirebreatherGroup:
JugglerGroup:
ExecutiveMGroup:
PsychicGroup:
PicnickerGroup:
CamperGroup:
ExecutiveFGroup:
PokefanMGroup:
KimonoGirlGroup:
PokefanFGroup:
BlueGroup:
OfficerGroup:
GruntFGroup:
MysticalmanGroup:
ScientistGroup:
GiovanniGroup:
ProtonGroup:
PetrelGroup:
ArianaGroup:
ArcherGroup:
LoreleiGroup:
AgathaGroup:
	next_list_item
	db "L@", TRAINERTYPE_NORMAL
	db 2
	dw ZUBAT
	db -1 ; end

	next_list_item
	db "L@", TRAINERTYPE_NORMAL
	db 2
	dw ZUBAT
	db -1 ; end

	next_list_item
	db "L@", TRAINERTYPE_NORMAL
	db 2
	dw ZUBAT
	db -1 ; end

	next_list_item
	db "L@", TRAINERTYPE_NORMAL
	db 2
	dw ZUBAT
	db -1 ; end

	next_list_item
	db "L@", TRAINERTYPE_NORMAL
	db 2
	dw ZUBAT
	db -1 ; end

	next_list_item
	db "L@", TRAINERTYPE_NORMAL
	db 2
	dw ZUBAT
	db -1 ; end

	next_list_item
	db "L@", TRAINERTYPE_NORMAL
	db 2
	dw ZUBAT
	db -1 ; end

	next_list_item
	db "L@", TRAINERTYPE_NORMAL
	db 2
	dw ZUBAT
	db -1 ; end

	next_list_item
	db "L@", TRAINERTYPE_NORMAL
	db 2
	dw ZUBAT
	db -1 ; end

	next_list_item
	db "L@", TRAINERTYPE_NORMAL
	db 2
	dw ZUBAT
	db -1 ; end

	next_list_item
	db "L@", TRAINERTYPE_NORMAL
	db 2
	dw ZUBAT
	db -1 ; end

	next_list_item
	db "L@", TRAINERTYPE_NORMAL
	db 2
	dw ZUBAT
	db -1 ; end

	next_list_item
	db "L@", TRAINERTYPE_NORMAL
	db 2
	dw ZUBAT
	db -1 ; end

	next_list_item
	db "L@", TRAINERTYPE_NORMAL
	db 2
	dw ZUBAT
	db -1 ; end

	next_list_item
	db "L@", TRAINERTYPE_NORMAL
	db 2
	dw ZUBAT
	db -1 ; end

	next_list_item
	db "L@", TRAINERTYPE_NORMAL
	db 2
	dw ZUBAT
	db -1 ; end

	next_list_item
	db "L@", TRAINERTYPE_NORMAL
	db 2
	dw ZUBAT
	db -1 ; end

	next_list_item
	db "L@", TRAINERTYPE_NORMAL
	db 2
	dw ZUBAT
	db -1 ; end

	next_list_item
	db "L@", TRAINERTYPE_NORMAL
	db 2
	dw ZUBAT
	db -1 ; end

	next_list_item
	db "L@", TRAINERTYPE_NORMAL
	db 2
	dw ZUBAT
	db -1 ; end

	next_list_item
	db "L@", TRAINERTYPE_NORMAL
	db 2
	dw ZUBAT
	db -1 ; end

	next_list_item
	db "L@", TRAINERTYPE_NORMAL
	db 2
	dw ZUBAT
	db -1 ; end

	next_list_item
	db "L@", TRAINERTYPE_NORMAL
	db 2
	dw ZUBAT
	db -1 ; end

	next_list_item
	db "L@", TRAINERTYPE_NORMAL
	db 2
	dw ZUBAT
	db -1 ; end

	next_list_item
	db "L@", TRAINERTYPE_NORMAL
	db 2
	dw ZUBAT
	db -1 ; end

	next_list_item
	db "L@", TRAINERTYPE_NORMAL
	db 2
	dw ZUBAT
	db -1 ; end

	next_list_item
	db "L@", TRAINERTYPE_NORMAL
	db 2
	dw ZUBAT
	db -1 ; end

	next_list_item
	db "L@", TRAINERTYPE_NORMAL
	db 2
	dw ZUBAT
	db -1 ; end

	next_list_item
	db "L@", TRAINERTYPE_NORMAL
	db 2
	dw ZUBAT
	db -1 ; end

	next_list_item
	db "L@", TRAINERTYPE_NORMAL
	db 2
	dw ZUBAT
	db -1 ; end

	end_list_items
SkierGroup:
	; ROXANNE1
	next_list_item
	db "Roxanne@", TRAINERTYPE_ITEM_MOVES
	db 1
	dw SEEL
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; ROXANNE2
	next_list_item
	db "Roxanne@", TRAINERTYPE_ITEM_MOVES
	db 2
	dw SEEL
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; ROXANNE3
	next_list_item
	db "Roxanne@", TRAINERTYPE_ITEM_MOVES
	db 3
	dw SEEL
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; ROXANNE4
	next_list_item
	db "Roxanne@", TRAINERTYPE_ITEM_MOVES
	db 4
	dw SEEL
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; ROXANNE5
	next_list_item
	db "Roxanne@", TRAINERTYPE_ITEM_MOVES
	db 5
	dw SEEL
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; CLARISSA1
	next_list_item
	db "Clarissa@", TRAINERTYPE_ITEM_MOVES
	db 1
	dw DEWGONG
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; CLARISSA2
	next_list_item
	db "Clarissa@", TRAINERTYPE_ITEM_MOVES
	db 2
	dw DEWGONG
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; CLARISSA3
	next_list_item
	db "Clarissa@", TRAINERTYPE_ITEM_MOVES
	db 3
	dw DEWGONG
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; CLARISSA4
	next_list_item
	db "Clarissa@", TRAINERTYPE_ITEM_MOVES
	db 4
	dw DEWGONG
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; CLARISSA5
	next_list_item
	db "Clarissa@", TRAINERTYPE_ITEM_MOVES
	db 5
	dw DEWGONG
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	end_list_items
BoarderGroup:
	; RONALD1
	next_list_item
	db "Ronald@", TRAINERTYPE_ITEM_MOVES
	db 1
	dw SNOVER
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; RONALD2
	next_list_item
	db "Ronald@", TRAINERTYPE_ITEM_MOVES
	db 2
	dw SNOVER
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; RONALD3
	next_list_item
	db "Ronald@", TRAINERTYPE_ITEM_MOVES
	db 3
	dw SNOVER
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; RONALD4
	next_list_item
	db "Ronald@", TRAINERTYPE_ITEM_MOVES
	db 4
	dw SNOVER
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; RONALD5
	next_list_item
	db "Ronald@", TRAINERTYPE_ITEM_MOVES
	db 5
	dw SNOVER
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; DOUGLAS1
	next_list_item
	db "Douglas@", TRAINERTYPE_ITEM_MOVES
	db 1
	dw ABOMASNOW
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; DOUGLAS2
	next_list_item
	db "Douglas@", TRAINERTYPE_ITEM_MOVES
	db 2
	dw ABOMASNOW
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; DOUGLAS3
	next_list_item
	db "Douglas@", TRAINERTYPE_ITEM_MOVES
	db 3
	dw ABOMASNOW
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; DOUGLAS4
	next_list_item
	db "Douglas@", TRAINERTYPE_ITEM_MOVES
	db 4
	dw ABOMASNOW
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; DOUGLAS5
	next_list_item
	db "Douglas@", TRAINERTYPE_ITEM_MOVES
	db 5
	dw ABOMASNOW
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	end_list_items
SailorGroup:
	; STEELE1
	next_list_item
	db "Steele@", TRAINERTYPE_ITEM_MOVES
	db 1
	dw WOOPER
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; STEELE2
	next_list_item
	db "Steele@", TRAINERTYPE_ITEM_MOVES
	db 2
	dw WOOPER
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; STEELE3
	next_list_item
	db "Steele@", TRAINERTYPE_ITEM_MOVES
	db 3
	dw WOOPER
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; STEELE4
	next_list_item
	db "Steele@", TRAINERTYPE_ITEM_MOVES
	db 4
	dw WOOPER
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; STEELE5
	next_list_item
	db "Steele@", TRAINERTYPE_ITEM_MOVES
	db 5
	dw WOOPER
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	end_list_items
BlackbeltGroup:
	; YOSHI1
	next_list_item
	db "Yoshi@", TRAINERTYPE_ITEM_MOVES
	db 1
	dw SUDOWOODO
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; YOSHI2
	next_list_item
	db "Yoshi@", TRAINERTYPE_ITEM_MOVES
	db 2
	dw SUDOWOODO
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; YOSHI3
	next_list_item
	db "Yoshi@", TRAINERTYPE_ITEM_MOVES
	db 3
	dw SUDOWOODO
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; YOSHI4
	next_list_item
	db "Yoshi@", TRAINERTYPE_ITEM_MOVES
	db 4
	dw SUDOWOODO
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; YOSHI5
	next_list_item
	db "Yoshi@", TRAINERTYPE_ITEM_MOVES
	db 5
	dw SUDOWOODO
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; LUNG1
	next_list_item
	db "Lung@", TRAINERTYPE_ITEM_MOVES
	db 1
	dw MANKEY
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; LUNG2
	next_list_item
	db "Lung@", TRAINERTYPE_ITEM_MOVES
	db 2
	dw MANKEY
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; LUNG3
	next_list_item
	db "Lung@", TRAINERTYPE_ITEM_MOVES
	db 3
	dw MANKEY
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; LUNG4
	next_list_item
	db "Lung@", TRAINERTYPE_ITEM_MOVES
	db 4
	dw MANKEY
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; LUNG5
	next_list_item
	db "Lung@", TRAINERTYPE_ITEM_MOVES
	db 5
	dw MANKEY
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	end_list_items
HikerGroup:
	; RUSTY1
	next_list_item
	db "Rusty@", TRAINERTYPE_ITEM_MOVES
	db 1
	dw MAGNEMITE
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; RUSTY2
	next_list_item
	db "Rusty@", TRAINERTYPE_ITEM_MOVES
	db 2
	dw MAGNEMITE
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; RUSTY3
	next_list_item
	db "Rusty@", TRAINERTYPE_ITEM_MOVES
	db 3
	dw MAGNEMITE
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; RUSTY4
	next_list_item
	db "Rusty@", TRAINERTYPE_ITEM_MOVES
	db 4
	dw MAGNEMITE
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; RUSTY5
	next_list_item
	db "Rusty@", TRAINERTYPE_ITEM_MOVES
	db 5
	dw MAGNEMITE
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	end_list_items
TeacherGroup:
	; RAVEN1
	next_list_item
	db "Raven@", TRAINERTYPE_ITEM_MOVES
	db 1
	dw STEELIX
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; RAVEN2
	next_list_item
	db "Raven@", TRAINERTYPE_ITEM_MOVES
	db 2
	dw STEELIX
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; RAVEN3
	next_list_item
	db "Raven@", TRAINERTYPE_ITEM_MOVES
	db 3
	dw STEELIX
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; RAVEN4
	next_list_item
	db "Raven@", TRAINERTYPE_ITEM_MOVES
	db 4
	dw STEELIX
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; RAVEN5
	next_list_item
	db "Raven@", TRAINERTYPE_ITEM_MOVES
	db 5
	dw STEELIX
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	end_list_items
SageGroup:
	; PING1
	next_list_item
	db "Ping@", TRAINERTYPE_ITEM_MOVES
	db 1
	dw GASTLY
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; PING2
	next_list_item
	db "Ping@", TRAINERTYPE_ITEM_MOVES
	db 2
	dw GASTLY
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; PING3
	next_list_item
	db "Ping@", TRAINERTYPE_ITEM_MOVES
	db 3
	dw GASTLY
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; PING4
	next_list_item
	db "Ping@", TRAINERTYPE_ITEM_MOVES
	db 4
	dw GASTLY
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; PING5
	next_list_item
	db "Ping@", TRAINERTYPE_ITEM_MOVES
	db 5
	dw GASTLY
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; JEFFREY1
	next_list_item
	db "Jeffrey@", TRAINERTYPE_ITEM_MOVES
	db 1
	dw GENGAR
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; JEFFREY2
	next_list_item
	db "Jeffrey@", TRAINERTYPE_ITEM_MOVES
	db 2
	dw GENGAR
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; JEFFREY3
	next_list_item
	db "Jeffrey@", TRAINERTYPE_ITEM_MOVES
	db 3
	dw GENGAR
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; JEFFREY4
	next_list_item
	db "Jeffrey@", TRAINERTYPE_ITEM_MOVES
	db 4
	dw GENGAR
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; JEFFREY5
	next_list_item
	db "Jeffrey@", TRAINERTYPE_ITEM_MOVES
	db 5
	dw GENGAR
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	end_list_items
MediumGroup:
	; GRACE1
	next_list_item
	db "Grace@", TRAINERTYPE_ITEM_MOVES
	db 1
	dw HAUNTER
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; GRACE2
	next_list_item
	db "Grace@", TRAINERTYPE_ITEM_MOVES
	db 2
	dw HAUNTER
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; GRACE3
	next_list_item
	db "Grace@", TRAINERTYPE_ITEM_MOVES
	db 3
	dw HAUNTER
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; GRACE4
	next_list_item
	db "Grace@", TRAINERTYPE_ITEM_MOVES
	db 4
	dw HAUNTER
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; GRACE5
	next_list_item
	db "Grace@", TRAINERTYPE_ITEM_MOVES
	db 5
	dw HAUNTER
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; MARTHA1
	next_list_item
	db "Martha@", TRAINERTYPE_ITEM_MOVES
	db 1
	dw MISMAGIUS
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; MARTHA1
	next_list_item
	db "MISMAGIUS@", TRAINERTYPE_ITEM_MOVES
	db 2
	dw HAUNTER
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; MARTHA1
	next_list_item
	db "MISMAGIUS@", TRAINERTYPE_ITEM_MOVES
	db 3
	dw HAUNTER
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; MARTHA1
	next_list_item
	db "MISMAGIUS@", TRAINERTYPE_ITEM_MOVES
	db 4
	dw HAUNTER
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; Martha
	next_list_item
	db "MISMAGIUS@", TRAINERTYPE_ITEM_MOVES
	db 5
	dw HAUNTER
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	end_list_items
BeautyGroup:
	; VICTORIA1
	next_list_item
	db "Victoria@", TRAINERTYPE_ITEM_MOVES
	db 1
	dw ARIADOS
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; VICTORIA2
	next_list_item
	db "Victoria@", TRAINERTYPE_ITEM_MOVES
	db 2
	dw ARIADOS
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; VICTORIA3
	next_list_item
	db "Victoria@", TRAINERTYPE_ITEM_MOVES
	db 3
	dw ARIADOS
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; VICTORIA4
	next_list_item
	db "Victoria@", TRAINERTYPE_ITEM_MOVES
	db 4
	dw ARIADOS
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; VICTORIA5
	next_list_item
	db "Victoria@", TRAINERTYPE_ITEM_MOVES
	db 5
	dw ARIADOS
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; SAMANTHA1
	next_list_item
	db "Samantha@", TRAINERTYPE_ITEM_MOVES
	db 1
	dw CLEFAIRY
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; SAMANTHA2
	next_list_item
	db "Samantha@", TRAINERTYPE_ITEM_MOVES
	db 2
	dw CLEFAIRY
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; SAMANTHA3
	next_list_item
	db "Samantha@", TRAINERTYPE_ITEM_MOVES
	db 3
	dw CLEFAIRY
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; SAMANTHA4
	next_list_item
	db "Samantha@", TRAINERTYPE_ITEM_MOVES
	db 4
	dw CLEFAIRY
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; SAMANTHA5
	next_list_item
	db "Samantha@", TRAINERTYPE_ITEM_MOVES
	db 5
	dw CLEFAIRY
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	end_list_items
BirdKeeperGroup:
	; ABE1
	next_list_item
	db "Abe@", TRAINERTYPE_ITEM_MOVES
	db PARTY_LV
	dw SWABLU
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; ABE2
	next_list_item
	db "Abe@", TRAINERTYPE_ITEM_MOVES
	db PARTY_LV
	dw SWABLU
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; ABE3
	next_list_item
	db "Abe@", TRAINERTYPE_ITEM_MOVES
	db PARTY_LV
	dw SWABLU
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; ABE4
	next_list_item
	db "Abe@", TRAINERTYPE_ITEM_MOVES
	db PARTY_LV
	dw SWABLU
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; ABE5
	next_list_item
	db "Rod@", TRAINERTYPE_ITEM_MOVES
	db PARTY_LV
	dw SWABLU
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; ROD1
	next_list_item
	db "Rod@", TRAINERTYPE_ITEM_MOVES
	db PARTY_LV
	dw DODUO
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; ROD2
	next_list_item
	db "Rod@", TRAINERTYPE_ITEM_MOVES
	db PARTY_LV
	dw DODUO
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; ROD3
	next_list_item
	db "Rod@", TRAINERTYPE_ITEM_MOVES
	db PARTY_LV
	dw DODUO
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; ROD4
	next_list_item
	db "Rod@", TRAINERTYPE_ITEM_MOVES
	db PARTY_LV
	dw DODUO
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; ROD5
	next_list_item
	db "Rod@", TRAINERTYPE_ITEM_MOVES
	db PARTY_LV
	dw DODUO
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	end_list_items
TwinsGroup:
	; AMYANDMAY1
	next_list_item
	db "Amy & May@", TRAINERTYPE_ITEM_MOVES
	db 1
	dw ARIADOS
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; AMYANDMAY2
	next_list_item
	db "Amy & May@", TRAINERTYPE_ITEM_MOVES
	db 2
	dw ARIADOS
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; AMYANDMAY3
	next_list_item
	db "Amy & May@", TRAINERTYPE_ITEM_MOVES
	db 3
	dw ARIADOS
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; AMYANDMAY4
	next_list_item
	db "Amy & May@", TRAINERTYPE_ITEM_MOVES
	db 4
	dw ARIADOS
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; AMYANDMAY5
	next_list_item
	db "Amy & May@", TRAINERTYPE_ITEM_MOVES
	db 5
	dw ARIADOS
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	end_list_items
BugCatcherGroup:
	; JOSH1
	next_list_item
	db "Josh@", TRAINERTYPE_ITEM_MOVES
	db 1
	dw SPINARAK
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; JOSH2
	next_list_item
	db "Josh@", TRAINERTYPE_ITEM_MOVES
	db 2
	dw SPINARAK
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; JOSH3
	next_list_item
	db "Josh@", TRAINERTYPE_ITEM_MOVES
	db 3
	dw SPINARAK
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; JOSH4
	next_list_item
	db "Josh@", TRAINERTYPE_ITEM_MOVES
	db 4
	dw SPINARAK
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; JOSH5
	next_list_item
	db "Josh@", TRAINERTYPE_ITEM_MOVES
	db 5
	dw SPINARAK
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; BENNY1
	next_list_item
	db "Benny@", TRAINERTYPE_ITEM_MOVES
	db 1
	dw SKORUPI
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; BENNY2
	next_list_item
	db "Benny@", TRAINERTYPE_ITEM_MOVES
	db 2
	dw SKORUPI
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; BENNY3
	next_list_item
	db "Benny@", TRAINERTYPE_ITEM_MOVES
	db 3
	dw SKORUPI
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; BENNY4
	next_list_item
	db "Benny@", TRAINERTYPE_ITEM_MOVES
	db 4
	dw SKORUPI
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; BENNY5
	next_list_item
	db "Benny@", TRAINERTYPE_ITEM_MOVES
	db 5
	dw SKORUPI
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; AL1
	next_list_item
	db "Al@", TRAINERTYPE_ITEM_MOVES
	db 1
	dw DRAPION
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; AL2
	next_list_item
	db "Al@", TRAINERTYPE_ITEM_MOVES
	db 2
	dw DRAPION
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; AL3
	next_list_item
	db "Al@", TRAINERTYPE_ITEM_MOVES
	db 3
	dw DRAPION
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; AL4
	next_list_item
	db "Al@", TRAINERTYPE_ITEM_MOVES
	db 4
	dw DRAPION
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; AL5
	next_list_item
	db "Al@", TRAINERTYPE_ITEM_MOVES
	db 5
	dw DRAPION
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	end_list_items
LassGroup:
	; CARRIE1
	next_list_item
	db "Carrie@", TRAINERTYPE_ITEM_MOVES
	db 1
	dw CLEFABLE
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; CARRIE2
	next_list_item
	db "Carrie@", TRAINERTYPE_ITEM_MOVES
	db 2
	dw CLEFABLE
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; CARRIE3
	next_list_item
	db "Carrie@", TRAINERTYPE_ITEM_MOVES
	db 3
	dw CLEFABLE
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; CARRIE4
	next_list_item
	db "Carrie@", TRAINERTYPE_ITEM_MOVES
	db 4
	dw CLEFABLE
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; CARRIE5
	next_list_item
	db "Carrie@", TRAINERTYPE_ITEM_MOVES
	db 5
	dw CLEFABLE
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; BRIDGET1
	next_list_item
	db "Bridget@", TRAINERTYPE_ITEM_MOVES
	db 1
	dw PIKACHU
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; BRIDGET2
	next_list_item
	db "Bridget@", TRAINERTYPE_ITEM_MOVES
	db 2
	dw PIKACHU
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; BRIDGET3
	next_list_item
	db "Bridget@", TRAINERTYPE_ITEM_MOVES
	db 3
	dw PIKACHU
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; BRIDGET4
	next_list_item
	db "Bridget@", TRAINERTYPE_ITEM_MOVES
	db 4
	dw PIKACHU
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	; BRIDGET5
	next_list_item
	db "Bridget@", TRAINERTYPE_ITEM_MOVES
	db 5
	dw CLEFABLE
	db BERRY
	dw TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end

	end_list_items
KrisGroup:
	; KRIS (1)
	next_list_item
	db "KRIS@", TRAINERTYPE_NORMAL
	db 5
	dw CYNDAQUIL
	db -1 ; end

	end_list_items
PKMNTrainerGroup:
	; CAL (1)
	next_list_item
	db "@", TRAINERTYPE_NORMAL
	db -1 ; end

	end_list_items
PKMNFTrainerGroup:
	; CAL_F (1)
	next_list_item
	db "@", TRAINERTYPE_NORMAL
	db -1 ; end

	end_list_items
NurseGroup:
;	; JOY (1)
	next_list_item
	db "Joy@", TRAINERTYPE_ITEM_MOVES
	db 10
	dw BLISSEY
	db LUCKY_EGG
	dw THUNDERBOLT, FLAMETHROWER, ICE_BEAM, SOFTBOILED
	db 10
	dw BLISSEY
	db LEFTOVERS
	dw CHARM, SEISMIC_TOSS, PROTECT, SOFTBOILED
	db 10
	dw BLISSEY
	db LEFTOVERS
	dw SEISMIC_TOSS, TOXIC, PROTECT, SOFTBOILED
	db 10
	dw BLISSEY
	db LEFTOVERS
	dw SUNNY_DAY, SOLARBEAM, FLAMETHROWER, SOFTBOILED
	db 10
	dw BLISSEY
	db LEFTOVERS
	dw SHADOW_BALL, CALM_MIND, PSYCHIC_M, SOFTBOILED
	db 10
	dw BLISSEY
	db FOCUS_SASH
	dw COUNTER, TOXIC, FLAMETHROWER, SOFTBOILED
	db -1 ; end

	; Joy (2)
	next_list_item
	db "Joy@", TRAINERTYPE_ITEM_MOVES
	db 20
	dw BLISSEY
	db LUCKY_EGG
	dw THUNDERBOLT, FLAMETHROWER, ICE_BEAM, SOFTBOILED
	db 20
	dw BLISSEY
	db LEFTOVERS
	dw CHARM, SEISMIC_TOSS, PROTECT, SOFTBOILED
	db 20
	dw BLISSEY
	db LEFTOVERS
	dw SEISMIC_TOSS, TOXIC, PROTECT, SOFTBOILED
	db 20
	dw BLISSEY
	db LEFTOVERS
	dw SUNNY_DAY, SOLARBEAM, FLAMETHROWER, SOFTBOILED
	db 20
	dw BLISSEY
	db LEFTOVERS
	dw SHADOW_BALL, CALM_MIND, PSYCHIC_M, SOFTBOILED
	db 20
	dw BLISSEY
	db FOCUS_SASH
	dw COUNTER, TOXIC, FLAMETHROWER, SOFTBOILED
	db -1 ; end

	; Joy (3)
	next_list_item
	db "Joy@", TRAINERTYPE_ITEM_MOVES
	db 30
	dw BLISSEY
	db LUCKY_EGG
	dw THUNDERBOLT, FLAMETHROWER, ICE_BEAM, SOFTBOILED
	db 30
	dw BLISSEY
	db LEFTOVERS
	dw CHARM, SEISMIC_TOSS, PROTECT, SOFTBOILED
	db 30
	dw BLISSEY
	db LEFTOVERS
	dw SEISMIC_TOSS, TOXIC, PROTECT, SOFTBOILED
	db 30
	dw BLISSEY
	db LEFTOVERS
	dw SUNNY_DAY, SOLARBEAM, FLAMETHROWER, SOFTBOILED
	db 30
	dw BLISSEY
	db LEFTOVERS
	dw SHADOW_BALL, CALM_MIND, PSYCHIC_M, SOFTBOILED
	db 30
	dw BLISSEY
	db FOCUS_SASH
	dw COUNTER, TOXIC, FLAMETHROWER, SOFTBOILED
	db -1 ; end

	; Joy (4)
	next_list_item
	db "Joy@", TRAINERTYPE_ITEM_MOVES
	db 40
	dw BLISSEY
	db LUCKY_EGG
	dw THUNDERBOLT, FLAMETHROWER, ICE_BEAM, SOFTBOILED
	db 40
	dw BLISSEY
	db LEFTOVERS
	dw CHARM, SEISMIC_TOSS, PROTECT, SOFTBOILED
	db 40
	dw BLISSEY
	db LEFTOVERS
	dw SEISMIC_TOSS, TOXIC, PROTECT, SOFTBOILED
	db 40
	dw BLISSEY
	db LEFTOVERS
	dw SUNNY_DAY, SOLARBEAM, FLAMETHROWER, SOFTBOILED
	db 40
	dw BLISSEY
	db LEFTOVERS
	dw SHADOW_BALL, CALM_MIND, PSYCHIC_M, SOFTBOILED
	db 40
	dw BLISSEY
	db FOCUS_SASH
	dw COUNTER, TOXIC, FLAMETHROWER, SOFTBOILED
	db -1 ; end

	; Joy (5)
	next_list_item
	db "Joy@", TRAINERTYPE_ITEM_MOVES
	db 50
	dw BLISSEY
	db LUCKY_EGG
	dw THUNDERBOLT, FLAMETHROWER, ICE_BEAM, SOFTBOILED
	db 50
	dw BLISSEY
	db LEFTOVERS
	dw CHARM, SEISMIC_TOSS, PROTECT, SOFTBOILED
	db 50
	dw BLISSEY
	db LEFTOVERS
	dw SEISMIC_TOSS, TOXIC, PROTECT, SOFTBOILED
	db 50
	dw BLISSEY
	db LEFTOVERS
	dw SUNNY_DAY, SOLARBEAM, FLAMETHROWER, SOFTBOILED
	db 50
	dw BLISSEY
	db LEFTOVERS
	dw SHADOW_BALL, CALM_MIND, PSYCHIC_M, SOFTBOILED
	db 50
	dw BLISSEY
	db FOCUS_SASH
	dw COUNTER, TOXIC, FLAMETHROWER, SOFTBOILED
	db -1 ; end

	end_list_items
InsafGroup:
	; Insaf (1)
	next_list_item
	db "Insaf@", TRAINERTYPE_NICKNAME | TRAINERTYPE_DVS | TRAINERTYPE_ITEM_MOVES
	db 50
	dw FERALIGATR
		db "Feraligatr@"		; Nickname
		db $FF, $FF ; dvs - atk|def dv, spd|spc dv
		db FOCUS_SASH	; ITEM/ NO_ITEM is a thing
		dw FURY_DRIVE, WATERFALL, ROCK_SLIDE, EARTHQUAKE ; Moveset - NO_MOVE is a thing
	db 50
	dw TAUROS
		db "Tauros@"		; Nickname
		db $FF, $FF		; DVs - atk|def dv, spd|spc dv
		db GOLD_BERRY	; ITEM/ NO_ITEM is a thing
		dw THRASH, EARTHQUAKE, IRON_HEAD, EXTREMESPEED ; Moveset - NO_MOVE is a thing
	db 50
	dw ZAPDOS
		db "Zapdos@"		; Nickname
		db $FF, $FF		; DVs - atk|def dv, spd|spc dv
		db LEFTOVERS	; ITEM/ NO_ITEM is a thing
		dw THUNDERBOLT, SKY_ATTACK, ROOST, TOXIC ; Moveset - NO_MOVE is a thing
	db 50
	dw ENTEI
		db "Entei@"		; Nickname
		db $FF, $FF		; DVs - atk|def dv, spd|spc dv
		db LIFE_ORB	; ITEM/ NO_ITEM is a thing
		dw EARTHQUAKE, ROCK_SLIDE, FLARE_BLITZ, EXTREMESPEED ; Moveset - NO_MOVE is a thing
	db 50
	dw CELEBI
		db "Celebi@"		; Nickname
		db $FF, $FF		; DVs - atk|def dv, spd|spc dv
		db LEFTOVERS	; ITEM/ NO_ITEM is a thing
		dw RECOVER, LEECH_SEED, CALM_MIND, GIGA_DRAIN ; Moveset - NO_MOVE is a thing
	db 50
	dw MEW
		db "Mew@"		; Nickname
		db $FF, $FF		; DVs - atk|def dv, spd|spc dv
		db LEFTOVERS	; ITEM/ NO_ITEM is a thing
		dw BULK_UP, ZEN_HEADBUTT, RECOVER, DRAIN_PUNCH ; Moveset - NO_MOVE is a thing
	db -1 ; end

	end_list_items
GreenGroup:
	; GREEN (1)
	next_list_item
	db "Green@", TRAINERTYPE_NICKNAME | TRAINERTYPE_DVS | TRAINERTYPE_ITEM_MOVES
	db 50
	dw TORTERRA
		db "Torterra@"		; Nickname
		db $FF, $FF ; dvs - atk|def dv, spd|spc dv
		db LEFTOVERS	; ITEM/ NO_ITEM is a thing
		dw EARTHQUAKE, ROCK_SLIDE, WOOD_BASH, HEALING_LIGHT ; Moveset - NO_MOVE is a thing
	db 50
	dw GYARADOS
		db "Tauros@"		; Nickname
		db $FF, $FF		; DVs - atk|def dv, spd|spc dv
		db FOCUS_SASH	; ITEM/ NO_ITEM is a thing
		dw DRAGON_DANCE, EARTHQUAKE, DIVE_BOMB, WATERFALL ; Moveset - NO_MOVE is a thing
	db 50
	dw ARCANINE
		db "Arcanine@"		; Nickname
		db $FF, $FF		; DVs - atk|def dv, spd|spc dv
		db GOLD_BERRY	; ITEM/ NO_ITEM is a thing
		dw FLARE_BLITZ, DOUBLE_EDGE, EXTREMESPEED, BULK_UP ; Moveset - NO_MOVE is a thing
	db 50
	dw ARTICUNO
		db "Articuno@"		; Nickname
		db $FF, $FF		; DVs - atk|def dv, spd|spc dv
		db LEFTOVERS	; ITEM/ NO_ITEM is a thing
		dw ICE_BEAM, SKY_ATTACK, ROOST, TOXIC ; Moveset - NO_MOVE is a thing
	db 50
	dw BRONZONG
		db "Celebi@"		; Nickname
		db $FF, $FF		; DVs - atk|def dv, spd|spc dv
		db TRICK_STICK	; ITEM/ NO_ITEM is a thing
		dw TRICK_ROOM, ZEN_HEADBUTT, IRON_BASH, EARTHQUAKE ; Moveset - NO_MOVE is a thing
	db 50
	dw MEW
		db "Mew@"		; Nickname
		db $FF, $FF		; DVs - atk|def dv, spd|spc dv
		db LEFTOVERS	; ITEM/ NO_ITEM is a thing
		dw BULK_UP, ZEN_HEADBUTT, RECOVER, DRAIN_PUNCH ; Moveset - NO_MOVE is a thing
	db -1 ; end
	end_list_items
