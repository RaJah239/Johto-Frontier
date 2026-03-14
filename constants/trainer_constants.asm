DEF __trainer_class__ = 0

MACRO trainerclass
	DEF \1 EQU __trainer_class__
	DEF __trainer_class__ += 1
	const_def 1
ENDM

; trainer class ids
; `trainerclass` indexes are for:
; - TrainerClassNames (see data/trainers/class_names.asm)
; - TrainerClassAttributes (see data/trainers/attributes.asm)
; - TrainerClassDVs (see data/trainers/dvs.asm)
; - TrainerGroups (see data/trainers/party_pointers.asm)
; - TrainerEncounterMusic (see data/trainers/encounter_music.asm)
; - TrainerPicPointers (see data/trainers/pic_pointers.asm)
; - TrainerPalettes (see data/trainers/palettes.asm)
; - BTTrainerClassSprites (see data/trainers/sprites.asm)
; - BTTrainerClassGenders (see data/trainers/genders.asm)
; trainer constants are Trainers indexes, for the sub-tables of TrainerGroups (see data/trainers/parties.asm)
DEF CHRIS EQU __trainer_class__
	trainerclass TRAINER_NONE ; 0
	const PHONECONTACT_MOM
	const PHONECONTACT_BIKESHOP
	const PHONECONTACT_BILL
	const PHONECONTACT_ELM
DEF NUM_NONTRAINER_PHONECONTACTS EQU const_value - 1

DEF KRIS EQU __trainer_class__
	trainerclass FALKNER ; 1
	const FALKNER1
	const FALKNER2
	const FALKNER3
	const FALKNER4
	const FALKNER5

	trainerclass WHITNEY ; 2
	const WHITNEY1

	trainerclass BUGSY ; 3
	const BUGSY1
	const BUGSY2
	const BUGSY3
	const BUGSY4
	const BUGSY5

	trainerclass MORTY ; 4
	const MORTY1

	trainerclass PRYCE ; 5
	const PRYCE1

	trainerclass JASMINE ; 6
	const JASMINE1

	trainerclass CHUCK ; 7
	const CHUCK1

	trainerclass CLAIR ; 8
	const CLAIR1

	trainerclass RIVAL1 ; 9
	const RIVAL1_1_CHIKORITA
	const RIVAL1_1_CYNDAQUIL
	const RIVAL1_1_TOTODILE
	const RIVAL1_2_CHIKORITA
	const RIVAL1_2_CYNDAQUIL
	const RIVAL1_2_TOTODILE
	const RIVAL1_3_CHIKORITA
	const RIVAL1_3_CYNDAQUIL
	const RIVAL1_3_TOTODILE
	const RIVAL1_4_CHIKORITA
	const RIVAL1_4_CYNDAQUIL
	const RIVAL1_4_TOTODILE
	const RIVAL1_5_CHIKORITA
	const RIVAL1_5_CYNDAQUIL
	const RIVAL1_5_TOTODILE

	trainerclass POKEMON_PROF ; a
	const OAK1

	trainerclass WILL ; b
	const WILL1

	trainerclass CAL ; c
	const CAL1

	trainerclass CAL_F
	const CAL_F1

	trainerclass BRUNO ; d
	const BRUNO1

	trainerclass KAREN ; e
	const KAREN1

	trainerclass KOGA ; f
	const KOGA1

	trainerclass CHAMPION ; 10
	const LANCE

	trainerclass BROCK ; 11
	const BROCK1

	trainerclass MISTY ; 12
	const MISTY1

	trainerclass LT_SURGE ; 13
	const LT_SURGE1

	trainerclass SCIENTIST ; 14

	trainerclass ERIKA ; 15
	const ERIKA1

	trainerclass YOUNGSTER ; 16
	const JOEY    ; route 2
	const MIKEY
	const ALBERT
	const GORDON
	const SAMUEL
	const IAN

	trainerclass SCHOOLBOY ; 17
	const JACK
	const ALAN
	const CHAD
	const LIAM

	trainerclass BIRD_KEEPER ; 18
	const ABE1 ; violet gym trainer
	const ABE2 ; violet gym trainer
	const ABE3 ; violet gym trainer
	const ABE4 ; violet gym trainer
	const ABE5 ; violet gym trainer
	const ROD1 ; violet gym trainer
	const ROD2 ; violet gym trainer
	const ROD3 ; violet gym trainer
	const ROD4 ; violet gym trainer
	const ROD5 ; violet gym trainer
	const BRYAN
	const THEO
	const TOBY
	const DENIS
	const VANCE
	const JOSE
	const PETER

	trainerclass LASS ; 19
	const CARRIE
	const BRIDGET
	const KRISE
	const CONNIE
	const DANA
	const SELINA

	trainerclass JANINE ; 1a
	const JANINE1

	trainerclass COOLTRAINERM ; 1b
	const NICK
	const AARON
	const PAUL
	const CODY
	const MIKE
	const GAVEN
	const RYAN
	const JAKE
	const BLAKE
	const BRIAN
	const KEVIN
	const ALLEN
	const DARIN
	const KYLE

	trainerclass COOLTRAINERF ; 1c
	const GWEN
	const LOIS
	const FRAN
	const LOLA
	const KATE
	const IRENE
	const KELLY
	const JOYCE
	const BETH
	const REENA
	const MEGAN
	const EMMA
	const CYBIL
	const JENN
	const CARA

	trainerclass BEAUTY ; 1d
	const VICTORIA
	const SAMANTHA
	const VALERIE
	const OLIVIA

	trainerclass POKEMANIAC ; 1e
	const LARRY
	const ANDREW
	const CALVIN
	const SHANE
	const BEN
	const BRENT
	const RON
	const ISSAC
	const DONALD
	const ZACH
	const MILLER

	trainerclass GRUNTM ; 1f

	trainerclass GENTLEMAN ; 20
	const PRESTON
	const ALFRED
	const CHARLES

	trainerclass SKIER ; 21
	const ROXANNE
	const CLARISSA

	trainerclass TEACHER ; 22

	trainerclass SABRINA ; 23
	const SABRINA1

	trainerclass BUG_CATCHER ; 24
	const JOSH1 ; azalea gym trainer
	const JOSH2 ; azalea gym trainer
	const JOSH3 ; azalea gym trainer
	const JOSH4 ; azalea gym trainer
	const JOSH5 ; azalea gym trainer
	const BENNY1 ; azalea gym trainer
	const BENNY2 ; azalea gym trainer
	const BENNY3 ; azalea gym trainer
	const BENNY4 ; azalea gym trainer
	const BENNY5 ; azalea gym trainer
	const AL1 ; azalea gym trainer
	const AL2 ; azalea gym trainer
	const AL3 ; azalea gym trainer
	const AL4 ; azalea gym trainer
	const AL5 ; azalea gym trainer
	const DON
	const WADE
	const ARNIE
	const WAYNE
	const EMMANUEL
	const ADAM

	trainerclass FISHER ; 25
	const JUSTIN
	const RALPH
	const HENRY
	const MARVIN
	const TULLY
	const ANDRE
	const RAYMOND
	const WILTON
	const EDGAR
	const SCOTT
	const RALPH5

	trainerclass SWIMMERM ; 26
	const SIMON
	const RANDALL
	const CHARLIE
	const GEORGE
	const BERKE
	const KIRK
	const MATHEW

	trainerclass SWIMMERF ; 27
	const ELAINE
	const PAULA
	const KAYLEE
	const SUSIE
	const DENISE
	const KARA
	const WENDY

	trainerclass SAILOR ; 28
	const EUGENE
	const HUEY
	const TERRELL
	const KENT
	const ERNEST
	const HARRY
	const STEELE

	trainerclass SUPER_NERD ; 29
	const STAN
	const ERIC
	const TERU
	const HUGH
	const MARKUS
	const TONY

	trainerclass RIVAL2 ; 2a
	const RIVAL2_1_CHIKORITA
	const RIVAL2_1_CYNDAQUIL
	const RIVAL2_1_TOTODILE
	const RIVAL2_2_CHIKORITA
	const RIVAL2_2_CYNDAQUIL
	const RIVAL2_2_TOTODILE

	trainerclass GUITARIST ; 2b
	const CLYDE ; unused

	trainerclass HIKER ; 2c
	const ANTHONY
	const RUSSELL
	const PHILLIP
	const LEONARD
	const BENJAMIN
	const ERIK
	const MICHAEL
	const PARRY
	const TIMOTHY
	const BAILEY
	const DANIEL

	trainerclass BIKER ; 2d
	const JIVES ; unused

	trainerclass BLAINE ; 2e
	const BLAINE1

	trainerclass BURGLAR ; 2f
	const DUNCAN
	const EDDIE

	trainerclass FIREBREATHER ; 30
	const BILL
	const WALT
	const RAY

	trainerclass JUGGLER ; 31
	const IRWIN

	trainerclass BLACKBELT_T ; 32
	const YOSHI
	const LAO
	const KIYO
	const LUNG
	const KENJI

	trainerclass EXECUTIVEM ; 33

	trainerclass PSYCHIC_T ; 34
	const NATHAN
	const GREG
	const NORMAN
	const MARK
	const PHIL
	const RICHARD
	const GILBERT

	trainerclass PICNICKER ; 35
	const LIZ
	const GINA
	const BROOKE
	const KIM
	const ERIN
	const TIFFANY

	trainerclass CAMPER ; 36
	const ROLAND
	const TODD
	const IVAN
	const ELLIOT
	const TED
	const SPENCER
	const QUENTIN

	trainerclass EXECUTIVEF ; 37
	const EXECUTIVEF_1
	const EXECUTIVEF_2

	trainerclass SAGE ; 38
	const CHOW
	const NICO
	const JIN
	const TROY
	const JEFFREY
	const PING
	const EDMOND
	const NEAL
	const LI
	const GAKU
	const MASA
	const KOJI

	trainerclass MEDIUM ; 39
	const MARTHA
	const GRACE

	trainerclass BOARDER ; 3a
	const RONALD
	const BRAD
	const DOUGLAS

	trainerclass POKEFANM ; 3b
	const WILLIAM
	const DEREK
	const BRANDON

	trainerclass KIMONO_GIRL ; 3c
	const NAOKO
	const SAYO
	const ZUKI
	const KUNI
	const MIKI

	trainerclass TWINS ; 3d
	const AMYANDMAY1 ; azalea gym trainer
	const AMYANDMAY2 ; azalea gym trainer
	const AMYANDMAY3 ; azalea gym trainer
	const AMYANDMAY4 ; azalea gym trainer
	const AMYANDMAY5 ; azalea gym trainer
	const ANNANDANNE1
	const ANNANDANNE2
	const LEAANDPIA1
	const LEAANDPIA2

	trainerclass POKEFANF ; 3e
	const BEVERLY
	const RUTH
	const JAIME

	trainerclass RED ; 3f
	const RED1
	const RED2

	trainerclass BLUE ; 40
	const BLUE1

	trainerclass OFFICER ; 41
	const KEITH
	const DIRK

	trainerclass GRUNTF ; 42

	trainerclass MYSTICALMAN ; 43
	const EUSINE

	trainerclass LINK_KRIS ; 44
	const LINK_KRIS1

	trainerclass GIOVANNI
	const GIOVANNI1
	const GIOVANNI2

	trainerclass PROTON
	const PROTON1

	trainerclass PETREL
	const PETREL1

	trainerclass LORELEI
	const LORELEI1
	const LORELEI2
	
	trainerclass AGATHA
	const AGATHA1
	const AGATHA2

	trainerclass SCARLET
	const SCARLET1

	trainerclass ARIANA
	const ARIANA1
	
	trainerclass ARCHER
	const ARCHER1

	trainerclass MAXIMA
	const MAXIMA1

	trainerclass NURSE
	const NURSE1
	const NURSE2
	const NURSE3
	const NURSE4
	const NURSE5

	trainerclass INSAF
	const INSAF1

	trainerclass GREEN
	const GREEN1

 	const_def
 	const RANDOMLIST_0
 	const RANDOMLIST_1
 	const RANDOMLIST_2

DEF NUM_TRAINER_CLASSES EQU __trainer_class__ - 1
