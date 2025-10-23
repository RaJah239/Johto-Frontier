; pokemon ids
; indexes for:
; - PokemonNames (see data/pokemon/names.asm)
; - BaseData (see data/pokemon/base_stats.asm)
; - EvosAttacksPointers (see data/pokemon/evos_attacks_pointers.asm)
; - EggMovePointers (see data/pokemon/egg_move_pointers.asm)
; - PokemonCries (see data/pokemon/cries.asm)
; - IconPointers (see data/pokemon/icon_pointers.asm)
; - PokemonPicPointers (see data/pokemon/pic_pointers.asm)
; - PokemonPalettes (see data/pokemon/palettes.asm)
; - PokedexDataPointerTable (see data/pokemon/dex_entry_pointers.asm)
; - AlphabeticalPokedexOrder (see data/pokemon/dex_order_alpha.asm)
; - NewPokedexOrder (see data/pokemon/dex_order_new.asm)
; - Pokered_MonIndices (see data/pokemon/gen1_order.asm)
; - Footprints (see gfx/footprints.asm)
; - AnimationPointers (see gfx/pokemon/anim_pointers.asm)
; - AnimationIdlePointers (see gfx/pokemon/idle_pointers.asm)
; - BitmasksPointers (see gfx/pokemon/bitmask_pointers.asm)
; - FramesPointers (see gfx/pokemon/frame_pointers.asm)
; - EZChat_SortedPokemon (see data/pokemon/ezchat_order.asm)

	; first 151 pokemon
	const_def 1
	const CYNDAQUIL  ; 01
	const QUILAVA    ; 02
	const TYPHLOSION ; 03
	const TOTODILE   ; 04
	const CROCONAW   ; 05
	const FERALIGATR ; 06
	const CHIKORITA  ; 07
	const BAYLEEF    ; 08
	const MEGANIUM   ; 09
	const TOGEPI     ; 0a
	const TOGETIC    ; 0b
	const TOGEKISS   ; 0c
	const CHARMANDER ; 0d
	const CHARMELEON ; 0e
	const CHARIZARD  ; 0f
	const SQUIRTLE   ; 10
	const WARTORTLE  ; 11
	const BLASTOISE  ; 12
	const TURTWIG    ; 13
	const GROTLE     ; 14
	const TORTERRA   ; 15
	const PIKACHU    ; 16
	const RAICHU     ; 17
	const EEVEE      ; 18
	const UMBREON    ; 19
	const SYLVEON    ; 1a
	const TORCHIC    ; 1b
	const COMBUSKEN  ; 1c
	const BLAZIKEN   ; 1d
	const FEEBAS     ; 1e
	const MILOTIC    ; 1f
	const ROWLET     ; 20
	const DARTRIX    ; 21
	const DECIDUEYE  ; 22
	const RALTS      ; 23
	const KIRLIA     ; 24
	const GARDEVOIR  ; 25
	const GALLADE    ; 26
	const WURMPLE    ; 27
	const SILCOON    ; 28
	const BEAUTIFLY  ; 29
	const CASCOON    ; 2a
	const DUSTOX     ; 2b
	const YANMA      ; 2c
	const YANMEGA    ; 2d
	const SUNKERN    ; 2e
	const SUNFLORA   ; 2f
	const BUNEARY    ; 30
	const LOPUNNY    ; 31
	const PIDGEY     ; 32
	const PIDGEOTTO  ; 33
	const PIDGEOT    ; 34
	const HOOTHOOT   ; 35
	const NOCTOWL    ; 36
	const ZUBAT      ; 37
	const GOLBAT     ; 38
	const CROBAT     ; 39
	const TEDDIURSA  ; 3a
	const URSARING   ; 3b
	const URSALUNA   ; 3c
	const PHANPY     ; 3d
	const DONPHAN    ; 3e
	const BELLSPROUT ; 3f
	const WEEPINBELL ; 40
	const VICTREEBEL ; 41
	const MAREEP     ; 42
	const FLAAFFY    ; 43
	const AMPHAROS   ; 44
	const NIDORAN_F  ; 45
	const NIDORINA   ; 46
	const NIDOQUEEN  ; 47
	const NIDORAN_M  ; 48
	const NIDORINO   ; 49
	const NIDOKING   ; 4a
	const WIMPOD     ; 4b
	const GOLISOPOD  ; 4c
	const MARILL     ; 4d
	const AZUMARILL  ; 4e
	const RHYHORN    ; 4f
	const RHYDON     ; 50
	const DRILBUR    ; 51
	const EXCADRILL  ; 52
	const ONIX       ; 53
	const STEELIX    ; 54
	const MAGIKARP   ; 55
	const GYARADOS   ; 56
	const GASTLY     ; 57
	const HAUNTER    ; 58
	const GENGAR     ; 59
	const SWABLU     ; 5a
	const ALTARIA    ; 5b
	const NATU       ; 5c
	const KATU       ; 5d
	const XATU       ; 5e
	const SMEARGLE   ; 5f
	const GROWLITHE  ; 60
	const ARCANINE   ; 61
	const HOUNDOUR   ; 62
	const HOUNDOOM   ; 63
	const WOOPER     ; 64
	const QUAGSIRE   ; 65
	const GLIGAR     ; 66
	const GLISCOR    ; 67
	const GIBLE      ; 68
	const GABITE     ; 69
	const GARCHOMP   ; 6a
	const MAKUHITA   ; 6b
	const HARIYAMA   ; 6c
	const DODUO      ; 6d
	const DODRIO     ; 6e
	const PONYTA     ; 6f
	const RAPIDASH   ; 70
	const SLOWPOKE   ; 71
	const SLOWBRO    ; 72
	const SHROOMISH  ; 73
	const BRELOOM    ; 74
	const SPINARAK   ; 75
	const ARIADOS    ; 76
	const VENIPEDE   ; 77
	const WHIRLIPEDE ; 78
	const SCOLIPEDE  ; 79
	const JOLTIK     ; 7a
	const GALVANTULA ; 7b
	const SKORUPI    ; 7c
	const DRAPION    ; 7d
	const LARVESTA   ; 7e
	const VOLCARONA  ; 7f
	const TROPIUS    ; 80
	const MANKEY     ; 81
	const PRIMEAPE   ; 82
	const ANNIHILAPE ; 83
	const FERROSEED  ; 84
	const FERROTHORN ; 85
	const SCYTHER    ; 86
	const SCIZOR     ; 87
	const KLEAVOR    ; 88
	const HERACROSS  ; 89
	const TANGELA    ; 8a
	const TANGROWTH  ; 8b
	const MEOWTH     ; 8c
	const PERSIAN    ; 8d
	const SNUBBULL   ; 8e
	const GRANBULL   ; 8f
	const DROWZEE    ; 90
	const HYPNO      ; 91
	const SUDOWOODO  ; 92
	const KOFFING    ; 93
	const WEEZING    ; 94
	const GRIMER     ; 95
	const MUK        ; 96
	const LITWICK    ; 97

	; second 101 pokemon
DEF JOHTO_POKEMON EQU const_value
	const LAMPENT    ; 98
	const CHANDELURE ; 99
	const MILTANK    ; 9a
	const TAUROS     ; 9b
	const VOLTORB    ; 9c
	const ELECTRODE  ; 9d
	const ELEKID     ; 9e
	const ELECTABUZZ ; 9f
	const MAGNEMITE  ; a0
	const MAGNETON   ; a1
	const MAGNEZONE  ; a2
	const SHUCKLE    ; a3
	const CORSOLA    ; a4
	const STARYU     ; a5
	const STARMIE    ; a6
	const REMORAID   ; a7
	const OCTILLERY  ; a8
	const CHINCHOU   ; a9
	const LANTURN    ; aa
	const MANTINE    ; ab
	const TENTACOOL  ; ac
	const TENTACRUEL ; ad
	const SEEL       ; ae
	const DEWGONG    ; af
	const HORSEA     ; b0
	const SEADRA     ; b1
	const KINGDRA    ; b2
	const LAPRAS     ; b3
	const CLEFAIRY   ; b4
	const CLEFABLE   ; b5
	const SOLROCK    ; b6
	const LUNATONE   ; b7
	const STANTLER   ; b8
	const WYRDEER    ; b9
	const DELIBIRD   ; ba
	const SMOOCHUM   ; bb
	const JYNX       ; bc
	const SNORUNT    ; bd
	const GLALIE     ; be
	const FROSLASS   ; bf
	const SWINUB     ; c0
	const PILOSWINE  ; c1
	const MAMOSWINE  ; c2
	const SNEASEL    ; c3
	const WEAVILE    ; c4
	const SNEASLER   ; c5
	const SNOVER     ; c6
	const ABOMASNOW  ; c7
	const BALTOY     ; c8
	const CLAYDOL    ; c9
	const RIOLU      ; ca
	const LUCARIO    ; cb
	const BRONZOR    ; cc
	const BRONZONG   ; cd
	const SKARMORY   ; ce
	const MISDREAVUS ; cf
	const MISMAGIUS  ; d0
	const CHANSEY    ; d1
	const BLISSEY    ; d2
	const SNORLAX    ; d3
	const LARVITAR   ; d4
	const PUPITAR    ; d5
	const TYRANITAR  ; d6
	const BAGON      ; d7
	const SHELGON    ; d8
	const SALAMENCE  ; d9
	const AXEW       ; da
	const FRAXURE    ; db
	const HAXORUS    ; dc
	const PORYGON    ; dd
	const PORYGON2   ; de
	const PORYGONZ   ; df
	const OMANYTE    ; e0
	const OMASTAR    ; e1
	const LILEEP     ; e2
	const CRADILY    ; e3
	const AERODACTYL ; e4
	const ROTOM      ; e5
	const ABSOL      ; e6
	const DURALUDON  ; e7
	const GHOLDENGO  ; e8
	const DARKRAI    ; e9
	const REGIROCK   ; ea
	const REGICE     ; eb
	const REGISTEEL  ; ec
	const REGIGIGAS  ; ed
	const ARTICUNO   ; ee
	const ZAPDOS     ; ef
	const MOLTRES    ; f0
	const LUGIA      ; f1
	const RAIKOU     ; f2
	const ENTEI      ; f3
	const SUICUNE    ; f4
	const HO_OH      ; f5
	const UNOWN      ; f6
	const NOWN       ; f7
	const VICTINI    ; f8
	const CELEBI     ; f9
	const DITTO      ; fa
	const MEW        ; fb
	const MEWTWO     ; fc
DEF NUM_POKEMON EQU const_value - 1
	const EGG        ; fd

; Unown forms
; indexes for:
; - UnownWords (see data/pokemon/unown_words.asm)
; - UnownPicPointers (see data/pokemon/unown_pic_pointers.asm)
; - UnownAnimationPointers (see gfx/pokemon/unown_anim_pointers.asm)
; - UnownAnimationIdlePointers (see gfx/pokemon/unown_idle_pointers.asm)
; - UnownBitmasksPointers (see gfx/pokemon/unown_bitmask_pointers.asm)
; - UnownFramesPointers (see gfx/pokemon/unown_frame_pointers.asm)
	const_def 1
	const UNOWN_A ;  1
	const UNOWN_B ;  2
	const UNOWN_C ;  3
	const UNOWN_D ;  4
	const UNOWN_E ;  5
	const UNOWN_F ;  6
	const UNOWN_G ;  7
	const UNOWN_H ;  8
	const UNOWN_I ;  9
	const UNOWN_J ; 10
	const UNOWN_K ; 11
	const UNOWN_L ; 12
	const UNOWN_M ; 13
	const UNOWN_N ; 14
	const UNOWN_O ; 15
	const UNOWN_P ; 16
	const UNOWN_Q ; 17
	const UNOWN_R ; 18
	const UNOWN_S ; 19
	const UNOWN_T ; 20
	const UNOWN_U ; 21
	const UNOWN_V ; 22
	const UNOWN_W ; 23
	const UNOWN_X ; 24
	const UNOWN_Y ; 25
	const UNOWN_Z ; 26
DEF NUM_UNOWN EQU const_value - 1 ; 26
