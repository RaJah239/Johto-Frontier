; Valid sprite IDs for each map group.
; Maps with environment ROUTE or TOWN can only use these sprites.

OutdoorSprites:
; entries correspond to MAPGROUP_* constants
	table_width 2, OutdoorSprites
	dw OlivineGroupSprites
	dw MahoganyGroupSprites
	dw DungeonsGroupSprites
	dw EcruteakGroupSprites
	dw BlackthornGroupSprites
	dw AzaleaGroupSprites
	dw LakeOfRageGroupSprites
	dw VioletGroupSprites
	dw GoldenrodGroupSprites
	dw FastShipGroupSprites
	dw IndigoGroupSprites
	dw SilverGroupSprites
	dw CableClubGroupSprites
	dw CianwoodGroupSprites
	dw NewBarkGroupSprites
	dw CherrygroveGroupSprites
	dw BattlePlazaGroupSprites
	assert_table_length NUM_MAP_GROUPS

IndigoGroupSprites:
; Route23
	; 0 of max 9 walking sprites
	db 0 ; end

; Route1 and CherrygroveCity are connected
NewBarkGroupSprites:
; Route26, Route27, Route1, NewBarkTown
CherrygroveGroupSprites:
; Route2, Route3, CherrygroveCity
	db SPRITE_RIVAL
	db SPRITE_TEACHER
	db SPRITE_FISHER
	db SPRITE_COOLTRAINER_M
	db SPRITE_YOUNGSTER
	db SPRITE_MONSTER
	db SPRITE_GRAMPS
	db SPRITE_BUG_CATCHER
	db SPRITE_COOLTRAINER_F
	; max 9 of 9 walking sprites
	db SPRITE_POKE_BALL
	db SPRITE_APRICORN
	db SPRITE_BERRY
	db SPRITE_UNKNOWN
	db 0 ; end

; Route9 and EcruteakCity are connected
VioletGroupSprites:
; Route4, Route7, Route8, Route9, VioletCity
EcruteakGroupSprites:
; EcruteakCity
	db SPRITE_FISHER
	db SPRITE_LASS
	db SPRITE_OFFICER
	db SPRITE_GRAMPS
	db SPRITE_YOUNGSTER
	db SPRITE_COOLTRAINER_M
	db SPRITE_BUG_CATCHER
	db SPRITE_SUPER_NERD
	; 8 of max 9 walking sprites
	db SPRITE_TWIN
	db SPRITE_SUDOWOODO
	db SPRITE_POKE_BALL
	db SPRITE_BERRY
	db SPRITE_APRICORN
	db SPRITE_SUICUNE
	db SPRITE_OTIS
	db 0 ; end

AzaleaGroupSprites:
; Route5, AzaleaTown
	db SPRITE_GRAMPS
	db SPRITE_YOUNGSTER
	db SPRITE_POKEFAN_M
	db SPRITE_TEACHER
	db SPRITE_ROCKET
	db SPRITE_RIVAL
	db SPRITE_LASS
	; 6 of max 9 walking sprites
	db SPRITE_SLOWPOKE
	db SPRITE_KURT
	db SPRITE_BERRY
	db SPRITE_APRICORN
	db 0 ; end

GoldenrodGroupSprites:
; Route6, GoldenrodCity
	db SPRITE_GRAMPS
	db SPRITE_YOUNGSTER
	db SPRITE_OFFICER
	db SPRITE_POKEFAN_M
	db SPRITE_COOLTRAINER_F
	db SPRITE_ROCKET
	db SPRITE_LASS
	; 7 of max 9 walking sprites
	db SPRITE_DAY_CARE_MON_1
	db SPRITE_DAY_CARE_MON_2
	db SPRITE_POKE_BALL
	db 0 ; end

; OlivineCity and Route40 are connected
OlivineGroupSprites:
; Route10, Route39, OlivineCity
CianwoodGroupSprites:
; Route40, Route41, CianwoodCity, PowerPlantOutside
	db SPRITE_RIVAL
	db SPRITE_POKEFAN_M
	db SPRITE_LASS
	db SPRITE_BEAUTY
	db SPRITE_SWIMMER_GIRL
	db SPRITE_SWIMMER_GUY
	db SPRITE_SAILOR
	db SPRITE_POKEFAN_F
	db SPRITE_EUSINE
	; 8 of max 9 walking sprites
	db SPRITE_TAUROS
	db SPRITE_BERRY
	db SPRITE_APRICORN
	db SPRITE_ROCK
	db SPRITE_YOUNGSTER
	db SPRITE_SUICUNE
	db SPRITE_OTIS
	db 0 ; end

MahoganyGroupSprites:
; Route42, Route44, MahoganyTown
	db SPRITE_GRAMPS
	db SPRITE_YOUNGSTER
	db SPRITE_LASS
	db SPRITE_SUPER_NERD
	db SPRITE_COOLTRAINER_M
	db SPRITE_POKEFAN_M
	db SPRITE_COOLTRAINER_F
	db SPRITE_FISHER
	; 8 of max 9 walking sprites
	db SPRITE_BERRY
	db SPRITE_APRICORN
	db SPRITE_POKE_BALL
	db SPRITE_SUICUNE
	db 0 ; end

LakeOfRageGroupSprites:
; Route43, LakeOfRage
	db SPRITE_LANCE
	db SPRITE_GRAMPS
	db SPRITE_SUPER_NERD
	db SPRITE_COOLTRAINER_F
	db SPRITE_FISHER
	db SPRITE_COOLTRAINER_M
	db SPRITE_LASS
	db SPRITE_YOUNGSTER
	; 8 of max 9 walking sprites
	db SPRITE_GYARADOS
	db SPRITE_BERRY
	db SPRITE_APRICORN
	db SPRITE_POKE_BALL
	db SPRITE_OTIS
	db 0 ; end

BlackthornGroupSprites:
; Route45, Route46, BlackthornCity
	db SPRITE_GRAMPS
	db SPRITE_YOUNGSTER
	db SPRITE_LASS
	db SPRITE_SUPER_NERD
	db SPRITE_COOLTRAINER_M
	db SPRITE_POKEFAN_M
	db SPRITE_BLACK_BELT
	db SPRITE_COOLTRAINER_F
	; 8 of max 9 walking sprites
	db SPRITE_BERRY
	db SPRITE_POKE_BALL
	db SPRITE_RAIKOU_OW
	db SPRITE_OTIS
	db 0 ; end

SilverGroupSprites:
; Route28, SilverCaveOutside
	; 0 of max 9 walking sprites
	db SPRITE_POKE_BALL
	db 0 ; end

DungeonsGroupSprites:
; NationalPark, NationalParkBugContest, RuinsOfAlphOutside
	db SPRITE_LASS
	db SPRITE_POKEFAN_F
	db SPRITE_TEACHER
	db SPRITE_YOUNGSTER
	db SPRITE_POKEFAN_M
	db SPRITE_COOLTRAINER_M
	db SPRITE_FISHER
	db SPRITE_SCIENTIST
	db SPRITE_BUG_CATCHER
	; 9 of max 9 walking sprites
	db SPRITE_GAMEBOY_KID
	db SPRITE_GROWLITHE
	db SPRITE_POKE_BALL
	db SPRITE_GHOLDENGO
	db 0 ; end

FastShipGroupSprites:
; OlivinePort, VermilionPort, MountMortarSquare, TinTowerRoof
	db SPRITE_SAILOR
	db SPRITE_FISHING_GURU
	db SPRITE_SUPER_NERD
	db SPRITE_COOLTRAINER_F
	db SPRITE_YOUNGSTER
	db SPRITE_FAIRY
	; 6 of max 9 walking sprites
	db SPRITE_HO_OH
	db SPRITE_ROCK
	db 0 ; end

BattlePlazaGroupSprites:
; Battle Plaza
	db SPRITE_SUPER_NERD
	; 1 of max 9 walking sprites
	db 0 ; end

CableClubGroupSprites:
; (no outdoor maps)
	; 0 of max 9 walking sprites
	db 0 ; end
