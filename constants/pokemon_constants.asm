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

; +=========+
; | DevNote |
; +=========+

; to change the constants order,
; the following files to must be edited:

; these are already done in files\re-ordered files
; data\pokemon\menu_icon_pals.asm
; constants\pokemon_constants.asm


; to do:
; data\pokemon\names.asm
; data\pokemon\base_stats.asm
; data\pokemon\palettes.asm
; data\pokemon\pic_pointers.asm
; gfx\footprints.asm
; gfx\icons.asm
; gfx\pokemon\anim_pointers.asm
; gfx\pokemon\anims.asm
; gfx\pokemon\bitmask_pointers.asm
; gfx\pokemon\bitmasks.asm
; gfx\pokemon\frame_pointers.asm
; gfx\pokemon\idle_pointers.asm
; gfx\pokemon\idles.asm
; gfx\pokemon\johto_frames.asm
; gfx\pokemon\kanto_frames.asm
; data\pokemon\dex_entries.asm
; data\pokemon\dex_entry_pointers.asm
; data\pokemon\evos_attacks.asm
; data\pokemon\evos_attacks_pointers.asm
; data\pokemon\gen1_order.asm
; data\pokemon\icon_pointers.asm
; data\pokemon\gen1_base_special.asm
; data\pokemon\cries.asm

	const_def 1
	const ROTOM      ; 01
	const VICTINI    ; 02
	const DURALUDON  ; 03
	const CHARMANDER ; 04
	const CHARMELEON ; 05
	const CHARIZARD  ; 06
	const SQUIRTLE   ; 07
	const WARTORTLE  ; 08
	const BLASTOISE  ; 09
	const TORCHIC    ; 0a
	const COMBUSKEN  ; 0b
	const BLAZIKEN   ; 0c
	const TURTWIG    ; 0d
	const GROTLE     ; 0e
	const TORTERRA   ; 0f
	const PIDGEY     ; 10
	const PIDGEOTTO  ; 11
	const PIDGEOT    ; 12
	const BUNEARY    ; 13
	const LOPUNNY    ; 14
	const SHROOMISH  ; 15
	const BRELOOM    ; 16
	const SKORUPI    ; 17
	const DRAPION    ; 18
	const PIKACHU    ; 19
	const RAICHU     ; 1a
	const DRILBUR    ; 1b
	const EXCADRILL  ; 1c
	const NIDORAN_F  ; 1d
	const NIDORINA   ; 1e
	const NIDOQUEEN  ; 1f
	const NIDORAN_M  ; 20
	const NIDORINO   ; 21
	const NIDOKING   ; 22
	const CLEFAIRY   ; 23
	const CLEFABLE   ; 24
	const MAKUHITA   ; 25
	const HARIYAMA   ; 26
	const BALTOY     ; 27
	const CLAYDOL    ; 28
	const ZUBAT      ; 29
	const GOLBAT     ; 2a
	const RHYHORN    ; 2b
	const OMANYTE    ; 2c
	const WYRDEER    ; 2d
	const LARVESTA   ; 2e
	const LILEEP     ; 2f
	const JOLTIK     ; 30
	const GALVANTULA ; 31
	const AXEW       ; 32
	const FRAXURE    ; 33
	const MEOWTH     ; 34
	const PERSIAN    ; 35
	const SWABLU     ; 36
	const ALTARIA    ; 37
	const MANKEY     ; 38
	const PRIMEAPE   ; 39
	const GROWLITHE  ; 3a
	const ARCANINE   ; 3b
	const GIBLE      ; 3c
	const GABITE     ; 3d
	const GARCHOMP   ; 3e
	const ROWLET     ; 3f
	const DARTRIX    ; 40
	const DECIDUEYE  ; 41
	const VENIPEDE   ; 42
	const WHIRLIPEDE ; 43
	const SCOLIPEDE  ; 44
	const BELLSPROUT ; 45
	const WEEPINBELL ; 46
	const VICTREEBEL ; 47
	const TENTACOOL  ; 48
	const TENTACRUEL ; 49
	const SNORUNT    ; 4a
	const GLALIE     ; 4b
	const FROSLASS   ; 4c
	const PONYTA     ; 4d
	const RAPIDASH   ; 4e
	const SLOWPOKE   ; 4f
	const SLOWBRO    ; 50
	const MAGNEMITE  ; 51
	const MAGNETON   ; 52
	const TROPIUS    ; 53
	const DODUO      ; 54
	const DODRIO     ; 55
	const SEEL       ; 56
	const DEWGONG    ; 57
	const GRIMER     ; 58
	const MUK        ; 59
	const RIOLU      ; 5a
	const LUCARIO    ; 5b
	const GASTLY     ; 5c
	const HAUNTER    ; 5d
	const GENGAR     ; 5e
	const ONIX       ; 5f
	const DROWZEE    ; 60
	const HYPNO      ; 61
	const BRONZOR    ; 62
	const BRONZONG   ; 63
	const VOLTORB    ; 64
	const ELECTRODE  ; 65
	const WIMPOD     ; 66
	const GOLISOPOD  ; 67
	const LITWICK    ; 68
	const LAMPENT    ; 69
	const RALTS      ; 6a
	const KIRLIA     ; 6b
	const YANMEGA    ; 6c
	const KOFFING    ; 6d
	const WEEZING    ; 6e
	const MAGNEZONE  ; 6f
	const URSALUNA   ; 70
	const CHANSEY    ; 71
	const TANGELA    ; 72
	const GLISCOR    ; 73
	const HORSEA     ; 74
	const SEADRA     ; 75
	const VOLCARONA  ; 76
	const SMOOCHUM   ; 77
	const STARYU     ; 78
	const STARMIE    ; 79
	const MISMAGIUS  ; 7a
	const SCYTHER    ; 7b
	const JYNX       ; 7c
	const ELECTABUZZ ; 7d
	const KATU       ; 7e
	const ANNIHILAPE ; 7f
	const TAUROS     ; 80
	const MAGIKARP   ; 81
	const GYARADOS   ; 82
	const LAPRAS     ; 83
	const DITTO      ; 84
	const EEVEE      ; 85
	const KLEAVOR    ; 86
	const TANGROWTH  ; 87
	const MAMOSWINE  ; 88
	const PORYGON    ; 89
	const WEAVILE    ; 8a
	const OMASTAR    ; 8b
	const SNEASLER   ; 8c
	const DARKRAI    ; 8d
	const AERODACTYL ; 8e
	const SNORLAX    ; 8f
	const ARTICUNO   ; 90
	const ZAPDOS     ; 91
	const MOLTRES    ; 92
	const BAGON      ; 93
	const SHELGON    ; 94
	const SALAMENCE  ; 95
	const MEWTWO     ; 96
	const MEW        ; 97
DEF JOHTO_POKEMON EQU const_value
	const CHIKORITA  ; 98
	const BAYLEEF    ; 99
	const MEGANIUM   ; 9a
	const CYNDAQUIL  ; 9b
	const QUILAVA    ; 9c
	const TYPHLOSION ; 9d
	const TOTODILE   ; 9e
	const CROCONAW   ; 9f
	const FERALIGATR ; a0
	const WURMPLE    ; a1
	const SILCOON    ; a2
	const HOOTHOOT   ; a3
	const NOCTOWL    ; a4
	const BEAUTIFLY  ; a5
	const DUSTOX     ; a6
	const SPINARAK   ; a7
	const ARIADOS    ; a8
	const CROBAT     ; a9
	const CHINCHOU   ; aa
	const LANTURN    ; ab
	const REGIROCK   ; ac
	const REGICE     ; ad
	const REGISTEEL  ; ae
	const TOGEPI     ; af
	const TOGETIC    ; b0
	const NATU       ; b1
	const XATU       ; b2
	const MAREEP     ; b3
	const FLAAFFY    ; b4
	const AMPHAROS   ; b5
	const CASCOON    ; b6
	const MARILL     ; b7
	const AZUMARILL  ; b8
	const SUDOWOODO  ; b9
	const CRADILY    ; ba
	const SNOVER     ; bb
	const ABOMASNOW  ; bc
	const SOLROCK    ; bd
	const LUNATONE   ; be
	const SUNKERN    ; bf
	const SUNFLORA   ; c0
	const YANMA      ; c1
	const WOOPER     ; c2
	const QUAGSIRE   ; c3
	const PORYGONZ   ; c4
	const UMBREON    ; c5
	const RHYDON     ; c6
	const TOGEKISS   ; c7
	const MISDREAVUS ; c8
	const UNOWN      ; c9
	const SYLVEON    ; ca
	const CHANDELURE ; cb
	const FERROTHORN ; cc
	const FERROSEED  ; cd
	const HAXORUS    ; ce
	const GLIGAR     ; cf
	const STEELIX    ; d0
	const SNUBBULL   ; d1
	const GRANBULL   ; d2
	const ELEKID     ; d3
	const SCIZOR     ; d4
	const SHUCKLE    ; d5
	const HERACROSS  ; d6
	const SNEASEL    ; d7
	const TEDDIURSA  ; d8
	const URSARING   ; d9
	const FEEBAS     ; da
	const MILOTIC    ; db
	const SWINUB     ; dc
	const PILOSWINE  ; dd
	const CORSOLA    ; de
	const REMORAID   ; df
	const OCTILLERY  ; e0
	const DELIBIRD   ; e1
	const MANTINE    ; e2
	const SKARMORY   ; e3
	const HOUNDOUR   ; e4
	const HOUNDOOM   ; e5
	const KINGDRA    ; e6
	const PHANPY     ; e7
	const DONPHAN    ; e8
	const PORYGON2   ; e9
	const STANTLER   ; ea
	const SMEARGLE   ; eb
	const GALLADE    ; ec
	const GARDEVOIR  ; ed
	const ABSOL      ; ee
	const REGIGIGAS  ; ef
	const NOWN       ; f0
	const MILTANK    ; f1
	const BLISSEY    ; f2
	const RAIKOU     ; f3
	const ENTEI      ; f4
	const SUICUNE    ; f5
	const LARVITAR   ; f6
	const PUPITAR    ; f7
	const TYRANITAR  ; f8
	const LUGIA      ; f9
	const HO_OH      ; fa
	const CELEBI     ; fb
	const GHOLDENGO  ; fc
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
