; pokemon ids
; indexes for:
; - PokemonNames (see data/pokemon/names.asm)
; - BaseData (see data/pokemon/base_stats.asm)
; - EvosAttacksPointers (see data/pokemon/evos_attacks_pointers.asm)
; - EggMovePointers (see data/pokemon/egg_move_pointers.asm)
; - PokemonCries (see data/pokemon/cries.asm)
; - IconPointers (see data/pokemon/icon_pointers.asm)
; - Icons (see gfx/icons.asm)
; - PokemonPicPointers (see data/pokemon/pic_pointers.asm)
; - Pics (gfx/pics.asm)
; - PokemonPalettes (see data/pokemon/palettes.asm)
; - PokedexDataPointerTable (see data/pokemon/dex_entry_pointers.asm)
; - AlphabeticalPokedexOrder (see data/pokemon/dex_order_alpha.asm)
; - NewPokedexOrder (see data/pokemon/dex_order_new.asm)
; - Footprints (see gfx/footprints.asm)
; - AnimationPointers (see gfx/pokemon/anim_pointers.asm)
; - Animations (see gfx/pokemon/anims.asm)
; - AnimationIdlePointers (see gfx/pokemon/idle_pointers.asm)
; - Idles (see gfx/pokemon/idles.asm)
; - BitmasksPointers (see gfx/pokemon/bitmask_pointers.asm)
; - Bitmasks (see gfx/pokemon/bitmasks.asm)
; - FramesPointers (see gfx/pokemon/frame_pointers.asm)
; - Kanto Frames (see gfx/pokemon/kanto_frames.asm)
; - Johto Frames (see gfx/pokemon/johto_frames.asm)
; - MonMenuIconPals (see data/pokemon/menu_icon_pals.asm)

	; first 151 pokemon
	const_def 1
DEF JOHTO_POKEMON EQU const_value + 116
; Pokémon constants follow POKEDEX_LIST.txt
	const QUILAVA ; 01
	const TYPHLOSION ; 02
	const CROCONAW ; 03
	const FERALIGATR ; 04
	const BAYLEEF ; 05
	const MEGANIUM ; 06
	const TOGETIC ; 07
	const TOGEKISS ; 08
	const PIKACHU ; 09
	const RAICHU ; 0a
	const EEVEE ; 0b
	const ESPEON ; 0c
	const FLAREON ; 0d
	const GLACEON ; 0e
	const JOLTEON ; 0f
	const LEAFEON ; 10
	const SYLVEON ; 11
	const UMBREON ; 12
	const VAPOREON ; 13
	const KIRLIA ; 14
	const GARDEVOIR ; 15
	const GALLADE ; 16
	const WURMPLE ; 17
	const SILCOON ; 18
	const BEAUTIFLY ; 19
	const CASCOON ; 1a
	const DUSTOX ; 1b
	const BUNEARY ; 1c
	const LOPUNNY ; 1d
	const JOLTIK ; 1e
	const GALVANTULA ; 1f
	const PIDGEOTTO ; 20
	const PIDGEOT ; 21
	const SPINARAK ; 22
	const ARIADOS ; 23
	const HOOTHOOT ; 24
	const NOCTOWL ; 25
	const GOLBAT ; 26
	const CROBAT ; 27
	const PHANPY ; 28
	const DONPHAN ; 29
	const BALTOY ; 2a
	const CLAYDOL ; 2b
	const BRONZOR ; 2c
	const BRONZONG ; 2d
	const BELLSPROUT ; 2e
	const WEEPINBELL ; 2f
	const VICTREEBEL ; 30
	const FLAAFFY ; 31
	const AMPHAROS ; 32
	const MARILL ; 33
	const AZUMARILL ; 34
	const POLIWHIRL ; 35
	const POLIWRATH ; 36
	const POLITOED ; 37
	const DRILBUR ; 38
	const EXCADRILL ; 39
	const URSARING ; 3a
	const URSALUNA ; 3b
	const URSALUNA_B ; 3c
	const MAWILE ; 3d
	const DUOSION ; 3e
	const REUNICLUS ; 3f
	const HAUNTER ; 40
	const GENGAR ; 41
	const SMEARGLE ; 42
	const COTTONEE ; 43
	const WHIMSICOTT ; 44
	const SWABLU ; 45
	const ALTARIA ; 46
	const YANMA ; 47
	const YANMEGA ; 48
	const SKORUPI ; 49
	const DRAPION ; 4a
	const WOOPER ; 4b
	const QUAGSIRE ; 4c
	const HOUNDOUR ; 4d
	const HOUNDOOM ; 4e
	const MAGIKARP ; 4f
	const GYARADOS ; 50
	const FEEBAS ; 51
	const MILOTIC ; 52
	const GLIGAR ; 53
	const GLISCOR ; 54
	const MACHOKE ; 55
	const MACHAMP ; 56
	const GABITE ; 57
	const GARCHOMP ; 58
	const ONIX ; 59
	const STEELIX ; 5a
	const DODUO ; 5b
	const DODRIO ; 5c
	const PONYTA ; 5d
	const RAPIDASH ; 5e
	const SLOWPOKE ; 5f
	const SLOWBRO ; 60
	const SLOWKING ; 61
	const SHROOMISH ; 62
	const BRELOOM ; 63
	const FOONGUS ; 64
	const AMOONGUSS ; 65
	const VENIPEDE ; 66
	const WHIRLIPEDE ; 67
	const SCOLIPEDE ; 68
	const LARVESTA ; 69
	const VOLCARONA ; 6a
	const SCYTHER ; 6b
	const SCIZOR ; 6c
	const KLEAVOR ; 6d
	const MANKEY ; 6e
	const PRIMEAPE ; 6f
	const ANNIHILAPE ; 70
	const DIPPLIN ; 71
	const HYDRAPPLE ; 72
	const FERROSEED ; 73
	const FERROTHORN ; 74
	const HERACROSS ; 75
	const ROSELIA ; 76
	const ROSERADE ; 77
	const KADABRA ; 78
	const ALAKAZAM ; 79
	const MEOWTH ; 7a
	const PERSIAN ; 7b
	const SNUBBULL ; 7c
	const GRANBULL ; 7d
	const DROWZEE ; 7e
	const HYPNO ; 7f
	const MR__MIME ; 80
	const VULPIX ; 81
	const NINETALES ; 82
	const NINETALES_A ; 83
	const IVYSAUR ; 84
	const VENUSAUR ; 85
	const SUDOWOODO ; 86
	const KOFFING ; 87
	const WEEZING ; 88
	const GRIMER ; 89
	const MUK ; 8a
	const SABLEYE ; 8b
	const CHARMELEON ; 8c
	const CHARIZARD ; 8d
	const MILTANK ; 8e
	const TAUROS ; 8f
	const COMBUSKEN ; 90
	const BLAZIKEN ; 91
	const LAPRAS ; 92
	const SHELLDER ; 93
	const CLOYSTER ; 94
	const STARYU ; 95
	const STARMIE ; 96
	const VIKAVOLT ; 97
	const ELECTABUZZ ; 98
	const DUSCLOPS ; 99
	const DUSKNOIR ; 9a
	const MAGNETON ; 9b
	const MAGNEZONE ; 9c
	const EELEKTROSS ; 9d
	const SHUCKLE ; 9e
	const CORSOLA ; 9f
	const CHINCHOU ; a0
	const LANTURN ; a1
	const TENTACOOL ; a2
	const TENTACRUEL ; a3
	const SEADRA ; a4
	const KINGDRA ; a5
	const DHELMISE ; a6
	const DRAGALGE ; a7
	const CLEFAIRY ; a8
	const CLEFABLE ; a9
	const SOLROCK ; aa
	const LUNATONE ; ab
	const WARTORTLE ; ac
	const BLASTOISE ; ad
	const HONCHKROW ; ae
	const MARSHTOMP ; af
	const SWAMPERT ; b0
	const JUMPLUFF ; b1
	const SNOVER ; b2
	const ABOMASNOW ; b3
	const GROVYLE ; b4
	const SCEPTILE ; b5
	const DELIBIRD ; b6
	const JYNX ; b7
	const SNORUNT ; b8
	const GLALIE ; b9
	const FROSLASS ; ba
	const PILOSWINE ; bb
	const MAMOSWINE ; bc
	const SNEASEL ; bd
	const WEAVILE ; be
	const SNEASLER ; bf
	const CRABOMINABLE ; c0
	const DONDOZO ; c1
	const CYCLIZAR ; c2
	const KROOKODILE ; c3
	const RHYDON ; c4
	const RHYPERIOR ; c5
	const SKARMORY ; c6
	const TORTERRA ; c7
	const CHANDELURE ; c8
	const MIMIKYU ; c9
	const DUGTRIO_A ; ca
	const LUCARIO ; cb
	const AGGRON ; cc
	const AEGISLASH ; cd
	const MISDREAVUS ; ce
	const MISMAGIUS ; cf
	const CHANSEY ; d0
	const BLISSEY ; d1
	const MAGMORTAR ; d2
	const PRIMARINA ; d3
	const EXPLOUD ; d4
	const SNORLAX ; d5
	const TYRANTRUM ; d6
	const HAXORUS ; d7
	const DRAGONITE ; d8
	const TYRANITAR ; d9
	const SALAMENCE ; da
	const METAGROSS ; db
	const HYDREIGON ; dc
	const GOODRA ; dd
	const DRAGAPULT ; de
	const BAXCALIBUR ; df
	const PORYGON ; e0
	const PORYGON2 ; e1
	const PORYGONZ ; e2
	const OMANYTE ; e3
	const OMASTAR ; e4
	const LILEEP ; e5
	const CRADILY ; e6
	const AERODACTYL ; e7
	const DURALUDON ; e8
	const ROTOM ; e9
	const ABSOL ; ea
	const GHOLDENGO ; eb
	const VOLCANION ; ec
	const DARKRAI ; ed
	const MELMETAL ; ee
	const ARTICUNO ; ef
	const ZAPDOS ; f0
	const MOLTRES ; f1
	const LUGIA ; f2
	const RAIKOU ; f3
	const ENTEI ; f4
	const SUICUNE ; f5
	const HO_OH ; f6
	const UNOWN ; f7
	const NOWN ; f8
	const JIRACHI ; f9
	const CELEBI ; fa
	const DITTO ; fb
	const MEW ; fc
	const MEWTWO ; fd
DEF NUM_POKEMON EQU const_value - 1
	const EGG        ; e9

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

; Persistent per-species palette overrides (see the palette editor NPC).
; Each override entry is: species, flags, normal colors (4 bytes), shiny colors (4 bytes).
DEF MAX_MON_PAL_OVERRIDES EQU 32
DEF MON_PAL_OVERRIDE_SIZE EQU 10
; Bits in the flags byte.
DEF MON_PAL_FLAG_NORMAL EQU 0
DEF MON_PAL_FLAG_SHINY EQU 1
