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
	; Falkner (1)
	db "Falkner@", TRAINERTYPE_NICKNAME | TRAINERTYPE_DVS | TRAINERTYPE_ITEM_MOVES
	db 50, SKARMORY
		db "Skarmory@"		; Nickname
		db $FF, $FF		; DVs - atk|def dv, spd|spc dv
		db LEFTOVERS	; ITEM/ NO_ITEM is a thing
		db ROOST, STEALTH_ROCK, IRON_BASH, TOXIC ; Moveset - NO_MOVE is a thing
	db 50, PIDGEOT
		db "Pidgeot@"		; Nickname
		db $FF, $FF ; dvs - atk|def dv, spd|spc dv
		db FOCUS_SASH	; ITEM/ NO_ITEM is a thing
		db ROOST, STEEL_WING, SKY_ATTACK, EXTREMESPEED ; Moveset - NO_MOVE is a thing
	db 50, ZAPDOS
		db "Zapdos@"		; Nickname
		db $FF, $FF		; DVs - atk|def dv, spd|spc dv
		db LEFTOVERS	; ITEM/ NO_ITEM is a thing
		db THUNDERBOLT, SKY_ATTACK, ROOST, TOXIC ; Moveset - NO_MOVE is a thing
	db 50, AERODACTYL
		db "Aerodactyl@"		; Nickname
		db $FF, $FF		; DVs - atk|def dv, spd|spc dv
		db LIFE_ORB	; ITEM/ NO_ITEM is a thing
		db EARTHQUAKE, ROCK_SLIDE, SKY_ATTACK, IRON_HEAD ; Moveset - NO_MOVE is a thing
	db 50, GLISCOR
		db "Gliscor@"		; Nickname
		db $FF, $FF		; DVs - atk|def dv, spd|spc dv
		db LEFTOVERS	; ITEM/ NO_ITEM is a thing
		db ROOST, EARTHQUAKE, ROCK_SLIDE, DIVE_BOMB ; Moveset - NO_MOVE is a thing
	db 50, LUGIA
		db "Lugia@"		; Nickname
		db $FF, $FF		; DVs - atk|def dv, spd|spc dv
		db LEFTOVERS	; ITEM/ NO_ITEM is a thing
		db CALM_MIND, AEROBLAST, SCALD, RECOVER ; Moveset - NO_MOVE is a thing
	db -1 ; end

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
	db "@", TRAINERTYPE_NORMAL
	db -1 ; end

PKMNFTrainerGroup:
	; CAL_F (1)
	db "@", TRAINERTYPE_NORMAL
	db -1 ; end

NurseGroup:
;	; JOY (1)
	db "Joy@", TRAINERTYPE_ITEM_MOVES
	db 10, BLISSEY,	LUCKY_EGG,	THUNDERBOLT, FLAMETHROWER, ICE_BEAM, SOFTBOILED
	db 10, BLISSEY,	LEFTOVERS,	CHARM, SEISMIC_TOSS, PROTECT, SOFTBOILED
	db 10, BLISSEY,	LEFTOVERS,	SEISMIC_TOSS, TOXIC, PROTECT, SOFTBOILED
	db 10, BLISSEY,	LEFTOVERS,	SUNNY_DAY, SOLARBEAM, FLAMETHROWER, SOFTBOILED
	db 10, BLISSEY,	LEFTOVERS,	SHADOW_BALL, CALM_MIND, PSYCHIC_M, SOFTBOILED
	db 10, BLISSEY,	FOCUS_SASH,	COUNTER, TOXIC, FLAMETHROWER, SOFTBOILED
	db -1 ; end

	; Joy (2)
	db "Joy@", TRAINERTYPE_ITEM_MOVES
	db 20, BLISSEY,	LUCKY_EGG,	THUNDERBOLT, FLAMETHROWER, ICE_BEAM, SOFTBOILED
	db 20, BLISSEY,	LEFTOVERS,	CHARM, SEISMIC_TOSS, PROTECT, SOFTBOILED
	db 20, BLISSEY,	LEFTOVERS,	SEISMIC_TOSS, TOXIC, PROTECT, SOFTBOILED
	db 20, BLISSEY,	LEFTOVERS,	SUNNY_DAY, SOLARBEAM, FLAMETHROWER, SOFTBOILED
	db 20, BLISSEY,	LEFTOVERS,	SHADOW_BALL, CALM_MIND, PSYCHIC_M, SOFTBOILED
	db 20, BLISSEY,	FOCUS_SASH,	COUNTER, TOXIC, FLAMETHROWER, SOFTBOILED
	db -1 ; end

	; Joy (3)
	db "Joy@", TRAINERTYPE_ITEM_MOVES
	db 30, BLISSEY,	LUCKY_EGG,	THUNDERBOLT, FLAMETHROWER, ICE_BEAM, SOFTBOILED
	db 30, BLISSEY,	LEFTOVERS,	CHARM, SEISMIC_TOSS, PROTECT, SOFTBOILED
	db 30, BLISSEY,	LEFTOVERS,	SEISMIC_TOSS, TOXIC, PROTECT, SOFTBOILED
	db 30, BLISSEY,	LEFTOVERS,	SUNNY_DAY, SOLARBEAM, FLAMETHROWER, SOFTBOILED
	db 30, BLISSEY,	LEFTOVERS,	SHADOW_BALL, CALM_MIND, PSYCHIC_M, SOFTBOILED
	db 30, BLISSEY,	FOCUS_SASH,	COUNTER, TOXIC, FLAMETHROWER, SOFTBOILED
	db -1 ; end

	; Joy (4)
	db "Joy@", TRAINERTYPE_ITEM_MOVES
	db 40, BLISSEY,	LUCKY_EGG,	THUNDERBOLT, FLAMETHROWER, ICE_BEAM, SOFTBOILED
	db 40, BLISSEY,	LEFTOVERS,	CHARM, SEISMIC_TOSS, PROTECT, SOFTBOILED
	db 40, BLISSEY,	LEFTOVERS,	SEISMIC_TOSS, TOXIC, PROTECT, SOFTBOILED
	db 40, BLISSEY,	LEFTOVERS,	SUNNY_DAY, SOLARBEAM, FLAMETHROWER, SOFTBOILED
	db 40, BLISSEY,	LEFTOVERS,	SHADOW_BALL, CALM_MIND, PSYCHIC_M, SOFTBOILED
	db 40, BLISSEY,	FOCUS_SASH,	COUNTER, TOXIC, FLAMETHROWER, SOFTBOILED
	db -1 ; end

	; Joy (5)
	db "Joy@", TRAINERTYPE_ITEM_MOVES
	db 50, BLISSEY,	LUCKY_EGG,	THUNDERBOLT, FLAMETHROWER, ICE_BEAM, SOFTBOILED
	db 50, BLISSEY,	LEFTOVERS,	CHARM, SEISMIC_TOSS, PROTECT, SOFTBOILED
	db 50, BLISSEY,	LEFTOVERS,	SEISMIC_TOSS, TOXIC, PROTECT, SOFTBOILED
	db 50, BLISSEY,	LEFTOVERS,	SUNNY_DAY, SOLARBEAM, FLAMETHROWER, SOFTBOILED
	db 50, BLISSEY,	LEFTOVERS,	SHADOW_BALL, CALM_MIND, PSYCHIC_M, SOFTBOILED
	db 50, BLISSEY,	FOCUS_SASH,	COUNTER, TOXIC, FLAMETHROWER, SOFTBOILED
	db -1 ; end

InsafGroup:
	; Insaf (1)
	db "Insaf@", TRAINERTYPE_NICKNAME | TRAINERTYPE_DVS | TRAINERTYPE_ITEM_MOVES
	db 50, FERALIGATR
		db "Feraligatr@"		; Nickname
		db $FF, $FF ; dvs - atk|def dv, spd|spc dv
		db FOCUS_SASH	; ITEM/ NO_ITEM is a thing
		db FURY_DRIVE, WATERFALL, ROCK_SLIDE, EARTHQUAKE ; Moveset - NO_MOVE is a thing
	db 50, TAUROS
		db "Tauros@"		; Nickname
		db $FF, $FF		; DVs - atk|def dv, spd|spc dv
		db GOLD_BERRY	; ITEM/ NO_ITEM is a thing
		db THRASH, EARTHQUAKE, IRON_HEAD, EXTREMESPEED ; Moveset - NO_MOVE is a thing
	db 50, ZAPDOS
		db "Zapdos@"		; Nickname
		db $FF, $FF		; DVs - atk|def dv, spd|spc dv
		db LEFTOVERS	; ITEM/ NO_ITEM is a thing
		db THUNDERBOLT, SKY_ATTACK, ROOST, TOXIC ; Moveset - NO_MOVE is a thing
	db 50, ENTEI
		db "Entei@"		; Nickname
		db $FF, $FF		; DVs - atk|def dv, spd|spc dv
		db LIFE_ORB	; ITEM/ NO_ITEM is a thing
		db EARTHQUAKE, ROCK_SLIDE, FLARE_BLITZ, EXTREMESPEED ; Moveset - NO_MOVE is a thing
	db 50, CELEBI
		db "Celebi@"		; Nickname
		db $FF, $FF		; DVs - atk|def dv, spd|spc dv
		db LEFTOVERS	; ITEM/ NO_ITEM is a thing
		db RECOVER, LEECH_SEED, CALM_MIND, GIGA_DRAIN ; Moveset - NO_MOVE is a thing
	db 50, MEW
		db "Mew@"		; Nickname
		db $FF, $FF		; DVs - atk|def dv, spd|spc dv
		db LEFTOVERS	; ITEM/ NO_ITEM is a thing
		db BULK_UP, ZEN_HEADBUTT, RECOVER, DRAIN_PUNCH ; Moveset - NO_MOVE is a thing
	db -1 ; end

GreenGroup:
	; GREEN (1)
	db "Green@", TRAINERTYPE_NICKNAME | TRAINERTYPE_DVS | TRAINERTYPE_ITEM_MOVES
	db 50, TORTERRA
		db "Torterra@"		; Nickname
		db $FF, $FF ; dvs - atk|def dv, spd|spc dv
		db LEFTOVERS	; ITEM/ NO_ITEM is a thing
		db EARTHQUAKE, ROCK_SLIDE, WOOD_BASH, HEALING_LIGHT ; Moveset - NO_MOVE is a thing
	db 50, GYARADOS
		db "Tauros@"		; Nickname
		db $FF, $FF		; DVs - atk|def dv, spd|spc dv
		db FOCUS_SASH	; ITEM/ NO_ITEM is a thing
		db DRAGON_DANCE, EARTHQUAKE, DIVE_BOMB, WATERFALL ; Moveset - NO_MOVE is a thing
	db 50, ARCANINE
		db "Arcanine@"		; Nickname
		db $FF, $FF		; DVs - atk|def dv, spd|spc dv
		db GOLD_BERRY	; ITEM/ NO_ITEM is a thing
		db FLARE_BLITZ, DOUBLE_EDGE, EXTREMESPEED, BULK_UP ; Moveset - NO_MOVE is a thing
	db 50, ARTICUNO
		db "Articuno@"		; Nickname
		db $FF, $FF		; DVs - atk|def dv, spd|spc dv
		db LEFTOVERS	; ITEM/ NO_ITEM is a thing
		db ICE_BEAM, SKY_ATTACK, ROOST, TOXIC ; Moveset - NO_MOVE is a thing
	db 50, BRONZONG
		db "Celebi@"		; Nickname
		db $FF, $FF		; DVs - atk|def dv, spd|spc dv
		db TRICK_STICK	; ITEM/ NO_ITEM is a thing
		db TRICK_ROOM, ZEN_HEADBUTT, IRON_BASH, EARTHQUAKE ; Moveset - NO_MOVE is a thing
	db 50, MEW
		db "Mew@"		; Nickname
		db $FF, $FF		; DVs - atk|def dv, spd|spc dv
		db LEFTOVERS	; ITEM/ NO_ITEM is a thing
		db BULK_UP, ZEN_HEADBUTT, RECOVER, DRAIN_PUNCH ; Moveset - NO_MOVE is a thing
	db -1 ; end
