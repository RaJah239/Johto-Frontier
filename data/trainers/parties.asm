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
WhitneyGroup:
BugsyGroup:
MortyGroup:
PryceGroup:
JasmineGroup:
ChuckGroup:
ClairGroup:
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
ScientistGroup:
ErikaGroup:
YoungsterGroup:
SchoolboyGroup:
BirdKeeperGroup:
LassGroup:
JanineGroup:
CooltrainerMGroup:
CooltrainerFGroup:
BeautyGroup:
PokemaniacGroup:
GruntMGroup:
GentlemanGroup:
SkierGroup:
TeacherGroup:
SabrinaGroup:
BugCatcherGroup:
FisherGroup:
SwimmerMGroup:
SwimmerFGroup:
SailorGroup:
SuperNerdGroup:
Rival2Group:
GuitaristGroup:
HikerGroup:
BikerGroup:
BlaineGroup:
BurglarGroup:
FirebreatherGroup:
JugglerGroup:
BlackbeltGroup:
ExecutiveMGroup:
PsychicGroup:
PicnickerGroup:
CamperGroup:
ExecutiveFGroup:
SageGroup:
MediumGroup:
BoarderGroup:
PokefanMGroup:
KimonoGirlGroup:
TwinsGroup:
PokefanFGroup:
BlueGroup:
OfficerGroup:
GruntFGroup:
MysticalmanGroup:
GiovanniGroup:
ProtonGroup:
PetrelGroup:
ArianaGroup:
ArcherGroup:
LoreleiGroup:
AgathaGroup:
MaximaGroup:
ScarletGroup:
	db "L@", TRAINERTYPE_NORMAL
	db 2, ZUBAT
	db -1 ; end

	db "L@", TRAINERTYPE_NORMAL
	db 2, ZUBAT
	db -1 ; end

	db "L@", TRAINERTYPE_NORMAL
	db 2, ZUBAT
	db -1 ; end

	db "L@", TRAINERTYPE_NORMAL
	db 2, ZUBAT
	db -1 ; end

	db "L@", TRAINERTYPE_NORMAL
	db 2, ZUBAT
	db -1 ; end

	db "L@", TRAINERTYPE_NORMAL
	db 2, ZUBAT
	db -1 ; end

	db "L@", TRAINERTYPE_NORMAL
	db 2, ZUBAT
	db -1 ; end

	db "L@", TRAINERTYPE_NORMAL
	db 2, ZUBAT
	db -1 ; end

	db "L@", TRAINERTYPE_NORMAL
	db 2, ZUBAT
	db -1 ; end

	db "L@", TRAINERTYPE_NORMAL
	db 2, ZUBAT
	db -1 ; end

	db "L@", TRAINERTYPE_NORMAL
	db 2, ZUBAT
	db -1 ; end

	db "L@", TRAINERTYPE_NORMAL
	db 2, ZUBAT
	db -1 ; end

	db "L@", TRAINERTYPE_NORMAL
	db 2, ZUBAT
	db -1 ; end

	db "L@", TRAINERTYPE_NORMAL
	db 2, ZUBAT
	db -1 ; end

	db "L@", TRAINERTYPE_NORMAL
	db 2, ZUBAT
	db -1 ; end

	db "L@", TRAINERTYPE_NORMAL
	db 2, ZUBAT
	db -1 ; end

	db "L@", TRAINERTYPE_NORMAL
	db 2, ZUBAT
	db -1 ; end

	db "L@", TRAINERTYPE_NORMAL
	db 2, ZUBAT
	db -1 ; end

	db "L@", TRAINERTYPE_NORMAL
	db 2, ZUBAT
	db -1 ; end

	db "L@", TRAINERTYPE_NORMAL
	db 2, ZUBAT
	db -1 ; end

	db "L@", TRAINERTYPE_NORMAL
	db 2, ZUBAT
	db -1 ; end

	db "L@", TRAINERTYPE_NORMAL
	db 2, ZUBAT
	db -1 ; end

	db "L@", TRAINERTYPE_NORMAL
	db 2, ZUBAT
	db -1 ; end

	db "L@", TRAINERTYPE_NORMAL
	db 2, ZUBAT
	db -1 ; end

	db "L@", TRAINERTYPE_NORMAL
	db 2, ZUBAT
	db -1 ; end

	db "L@", TRAINERTYPE_NORMAL
	db 2, ZUBAT
	db -1 ; end

	db "L@", TRAINERTYPE_NORMAL
	db 2, ZUBAT
	db -1 ; end

	db "L@", TRAINERTYPE_NORMAL
	db 2, ZUBAT
	db -1 ; end

	db "L@", TRAINERTYPE_NORMAL
	db 2, ZUBAT
	db -1 ; end

	db "L@", TRAINERTYPE_NORMAL
	db 2, ZUBAT
	db -1 ; end

KrisGroup:
	; KRIS (1)
	db "KRIS@", TRAINERTYPE_NORMAL
	db 5, CYNDAQUIL
	db -1 ; end

PKMNTrainerGroup:
	; CAL (1)
	db "Self@", TRAINERTYPE_NORMAL
	db 5, HO_OH
	db -1 ; end
