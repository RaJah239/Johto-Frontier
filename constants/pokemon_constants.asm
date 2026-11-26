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
	const QUILAVA ; 01
	const TYPHLOSION ; 02
	const CROCONAW ; 03
	const FERALIGATR ; 04
	const BAYLEEF ; 05
	const MEGANIUM ; 06
	const TOGETIC ; 07
	const TOGEKISS ; 08
	const CHARMELEON ; 09
	const CHARIZARD ; 0a
	const WARTORTLE ; 0b
	const BLASTOISE ; 0c
	const TORTERRA ; 0d
	const PIKACHU ; 0e
	const RAICHU ; 0f
	const EEVEE ; 10
	const ESPEON ; 11
	const FLAREON ; 12
	const JOLTEON ; 13
	const SYLVEON ; 14
	const UMBREON ; 15
	const VAPOREON ; 16
	const COMBUSKEN ; 17
	const BLAZIKEN ; 18
	const FEEBAS ; 19
	const MILOTIC ; 1a
	const KIRLIA ; 1b
	const GARDEVOIR ; 1c
	const GALLADE ; 1d
	const WURMPLE ; 1e
	const SILCOON ; 1f
	const BEAUTIFLY ; 20
	const CASCOON ; 21
	const DUSTOX ; 22
	const YANMA ; 23
	const YANMEGA ; 24
	const BUNEARY ; 25
	const LOPUNNY ; 26
	const PIDGEOTTO ; 27
	const PIDGEOT ; 28
	const HOOTHOOT ; 29
	const NOCTOWL ; 2a
	const GOLBAT ; 2b
	const CROBAT ; 2c
	const URSARING ; 2d
	const URSALUNA ; 2e
	const URSALUNA_B ; 2f
	const PHANPY ; 30
	const DONPHAN ; 31
	const BELLSPROUT ; 32
	const WEEPINBELL ; 33
	const VICTREEBEL ; 34
	const FLAAFFY ; 35
	const AMPHAROS ; 36
	const MARILL ; 37
	const AZUMARILL ; 38
	const RHYDON ; 39
	const DRILBUR ; 3a
	const EXCADRILL ; 3b
	const ONIX ; 3c
	const STEELIX ; 3d
	const MAGIKARP ; 3e
	const GYARADOS ; 3f
	const HAUNTER ; 40
	const GENGAR ; 41
	const SWABLU ; 42
	const ALTARIA ; 43
	const SMEARGLE ; 44
	const HOUNDOUR ; 45
	const HOUNDOOM ; 46
	const WOOPER ; 47
	const QUAGSIRE ; 48
	const GLIGAR ; 49
	const GLISCOR ; 4a
	const GABITE ; 4b
	const GARCHOMP ; 4c
	const DODUO ; 4d
	const DODRIO ; 4e
	const PONYTA ; 4f
	const RAPIDASH ; 50
	const SLOWPOKE ; 51
	const SLOWBRO ; 52
	const SHROOMISH ; 53
	const BRELOOM ; 54
	const SPINARAK ; 55
	const ARIADOS ; 56
	const VENIPEDE ; 57
	const WHIRLIPEDE ; 58
	const SCOLIPEDE ; 59
	const JOLTIK ; 5a
	const GALVANTULA ; 5b
	const SKORUPI ; 5c
	const DRAPION ; 5d
	const LARVESTA ; 5e
	const VOLCARONA ; 5f
	const MANKEY ; 60
	const PRIMEAPE ; 61
	const ANNIHILAPE ; 62
	const FERROSEED ; 63
	const FERROTHORN ; 64
	const SCYTHER ; 65
	const SCIZOR ; 66
	const KLEAVOR ; 67
	const HERACROSS ; 68
	const MEOWTH ; 69
	const PERSIAN ; 6a
	const SNUBBULL ; 6b
	const GRANBULL ; 6c
	const DROWZEE ; 6d
	const HYPNO ; 6e
	const MR__MIME ; 6f
	const SUDOWOODO ; 70
	const KOFFING ; 71
	const WEEZING ; 72
	const GRIMER ; 73
	const MUK ; 74

	; second 101 pokemon
DEF JOHTO_POKEMON EQU const_value
	const CHANDELURE ; 75
	const MILTANK ; 76
	const TAUROS ; 77
	const ELECTABUZZ ; 78
	const MAGNETON ; 79
	const MAGNEZONE ; 7a
	const SHUCKLE ; 7b
	const CORSOLA ; 7c
	const STARYU ; 7d
	const STARMIE ; 7e
	const CHINCHOU ; 7f
	const LANTURN ; 80
	const TENTACOOL ; 81
	const TENTACRUEL ; 82
	const SEADRA ; 83
	const KINGDRA ; 84
	const LAPRAS ; 85
	const CLEFAIRY ; 86
	const CLEFABLE ; 87
	const SOLROCK ; 88
	const LUNATONE ; 89
	const DELIBIRD ; 8a
	const JYNX ; 8b
	const SNORUNT ; 8c
	const GLALIE ; 8d
	const FROSLASS ; 8e
	const PILOSWINE ; 8f
	const MAMOSWINE ; 90
	const SNEASEL ; 91
	const WEAVILE ; 92
	const SNEASLER ; 93
	const SNOVER ; 94
	const ABOMASNOW ; 95
	const BALTOY ; 96
	const CLAYDOL ; 97
	const LUCARIO ; 98
	const BRONZOR ; 99
	const BRONZONG ; 9a
	const SKARMORY ; 9b
	const AGGRON ; 9c
	const AEGISLASH ; 9d
	const MISDREAVUS ; 9e
	const MISMAGIUS ; 9f
	const CHANSEY ; a0
	const BLISSEY ; a1
	const SNORLAX ; a2
	const TYRANITAR ; a3
	const SALAMENCE ; a4
	const METAGROSS ; a5
	const HAXORUS ; a6
	const PORYGON ; a7
	const PORYGON2 ; a8
	const PORYGONZ ; a9
	const OMANYTE ; aa
	const OMASTAR ; ab
	const LILEEP ; ac
	const CRADILY ; ad
	const AERODACTYL ; ae
	const ROTOM ; af
	const ABSOL ; b0
	const DURALUDON ; b1
	const GHOLDENGO ; b2
	const DARKRAI ; b3
	const ARTICUNO ; b4
	const ZAPDOS ; b5
	const MOLTRES ; b6
	const LUGIA ; b7
	const RAIKOU ; b8
	const ENTEI ; b9
	const SUICUNE ; ba
	const HO_OH ; bb
	const UNOWN ; bc
	const NOWN ; bd
	const JIRACHI ; be
	const CELEBI ; bf
	const DITTO ; c0
	const MEW ; c1
	const MEWTWO ; c2
	const GLACEON ; c3
	const LEAFEON ; c4
	const POLIWHIRL ; c5
	const POLIWRATH ; c6
	const POLITOED ; c7
	const MAWILE ; c8
	const DUOSION ; c9
	const REUNICLUS ; ca
	const COTTONEE ; cb
	const WHIMSICOTT ; cc
	const MACHOKE ; cd
	const MACHAMP ; ce
	const SLOWKING ; cf
	const FOONGUS ; d0
	const AMOONGUSS ; d1
	const DIPPLIN ; d2
	const HYDRAPPLE ; d3
	const ROSELIA ; d4
	const ROSERADE ; d5
	const KADABRA ; d6
	const ALAKAZAM ; d7
	const VULPIX ; d8
	const NINETALES ; d9
	const NINETALES_A ; da
	const IVYSAUR ; db
	const VENUSAUR ; dc
	const SABLEYE ; dd
	const SHELLDER ; de
	const CLOYSTER ; df
	const VIKAVOLT ; e0
	const DUSCLOPS ; e1
	const DUSKNOIR ; e2
	const EELEKTROSS ; e3
	const DHELMISE ; e4
	const DRAGALGE ; e5
	const HONCHKROW ; e6
	const MARSHTOMP ; e7
	const SWAMPERT ; e8
	const JUMPLUFF ; e9
	const GROVYLE ; ea
	const SCEPTILE ; eb
	const CRABOMINABLE ; ec
	const DONDOZO ; ed
	const CYCLIZAR ; ee
	const KROOKODILE ; ef
	const RHYPERIOR ; f0
	const MIMIKYU ; f1
	const DUGTRIO_A ; f2
	const MAGMORTAR ; f3
	const PRIMARINA ; f4
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
