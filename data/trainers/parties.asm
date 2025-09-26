INCLUDE "data/trainers/party_pointers.asm"

Trainers:
; Trainer data structure:
; - db "NAME@", TRAINERTYPE_* constant
; - 1 to 6 Pokémon:
;    * for TRAINERTYPE_NORMAL:     db level, species
;    * for TRAINERTYPE_MOVES:      db level, species, 4 moves
;    * for TRAINERTYPE_ITEM:       db level, species, item
;    * for TRAINERTYPE_ITEM_MOVES: db level, species, item, 4 moves
; - db -1 ; end

RedGroup:
	; RED (1)
	db "RED@", TRAINERTYPE_NORMAL
	db 5, PIKACHU
	db -1 ; end

if DEF(_DEBUG)
	db "TEST@", TRAINERTYPE_ITEM_MOVES
	db 5, PIKACHU,   NO_ITEM,     THUNDERBOLT, NO_MOVE, NO_MOVE, NO_MOVE
	db 5, PIKACHU,   NO_ITEM,     DOUBLE_EDGE, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end
endc

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
PKMNTrainerGroup:
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
