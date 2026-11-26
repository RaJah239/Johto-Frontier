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
	const TOTODILE ; 03
	const CROCONAW ; 04
	const FERALIGATR ; 05
	const CHIKORITA ; 06
	const BAYLEEF ; 07
	const MEGANIUM ; 08
	const TOGEPI ; 09
	const TOGETIC ; 0a
	const TOGEKISS ; 0b
	const CHARMANDER ; 0c
	const CHARMELEON ; 0d
	const CHARIZARD ; 0e
	const SQUIRTLE ; 0f
	const WARTORTLE ; 10
	const BLASTOISE ; 11
	const TURTWIG ; 12
	const GROTLE ; 13
	const TORTERRA ; 14
	const PIKACHU ; 15
	const RAICHU ; 16
	const EEVEE ; 17
	const ESPEON ; 18
	const FLAREON ; 19
	const JOLTEON ; 1a
	const SYLVEON ; 1b
	const UMBREON ; 1c
	const VAPOREON ; 1d
	const TORCHIC ; 1e
	const COMBUSKEN ; 1f
	const BLAZIKEN ; 20
	const FEEBAS ; 21
	const MILOTIC ; 22
	const ROWLET ; 23
	const DARTRIX ; 24
	const DECIDUEYE ; 25
	const RALTS ; 26
	const KIRLIA ; 27
	const GARDEVOIR ; 28
	const GALLADE ; 29
	const WURMPLE ; 2a
	const SILCOON ; 2b
	const BEAUTIFLY ; 2c
	const CASCOON ; 2d
	const DUSTOX ; 2e
	const YANMA ; 2f
	const YANMEGA ; 30
	const SUNKERN ; 31
	const SUNFLORA ; 32
	const BUNEARY ; 33
	const LOPUNNY ; 34
	const PIDGEY ; 35
	const PIDGEOTTO ; 36
	const PIDGEOT ; 37
	const HOOTHOOT ; 38
	const NOCTOWL ; 39
	const ZUBAT ; 3a
	const GOLBAT ; 3b
	const CROBAT ; 3c
	const TEDDIURSA ; 3d
	const URSARING ; 3e
	const URSALUNA ; 3f
	const URSALUNA_B ; 40
	const PHANPY ; 41
	const DONPHAN ; 42
	const BELLSPROUT ; 43
	const WEEPINBELL ; 44
	const VICTREEBEL ; 45
	const MAREEP ; 46
	const FLAAFFY ; 47
	const AMPHAROS ; 48
	const WIMPOD ; 49
	const GOLISOPOD ; 4a
	const MARILL ; 4b
	const AZUMARILL ; 4c
	const RHYHORN ; 4d
	const RHYDON ; 4e
	const DRILBUR ; 4f
	const EXCADRILL ; 50
	const ONIX ; 51
	const STEELIX ; 52
	const MAGIKARP ; 53
	const GYARADOS ; 54
	const GASTLY ; 55
	const HAUNTER ; 56
	const GENGAR ; 57
	const SWABLU ; 58
	const ALTARIA ; 59
	const NATU ; 5a
	const KATU ; 5b
	const XATU ; 5c
	const SMEARGLE ; 5d
	const GROWLITHE ; 5e
	const ARCANINE ; 5f
	const HOUNDOUR ; 60
	const HOUNDOOM ; 61
	const WOOPER ; 62
	const QUAGSIRE ; 63
	const GLIGAR ; 64
	const GLISCOR ; 65
	const GIBLE ; 66
	const GABITE ; 67
	const GARCHOMP ; 68
	const MAKUHITA ; 69
	const HARIYAMA ; 6a
	const DODUO ; 6b
	const DODRIO ; 6c
	const PONYTA ; 6d
	const RAPIDASH ; 6e
	const SLOWPOKE ; 6f
	const SLOWBRO ; 70
	const SHROOMISH ; 71
	const BRELOOM ; 72
	const SPINARAK ; 73
	const ARIADOS ; 74
	const VENIPEDE ; 75
	const WHIRLIPEDE ; 76
	const SCOLIPEDE ; 77
	const JOLTIK ; 78
	const GALVANTULA ; 79
	const SKORUPI ; 7a
	const DRAPION ; 7b
	const LARVESTA ; 7c
	const VOLCARONA ; 7d
	const IRON_MOTH ; 7e
	const TROPIUS ; 7f
	const MANKEY ; 80
	const PRIMEAPE ; 81
	const ANNIHILAPE ; 82
	const FERROSEED ; 83
	const FERROTHORN ; 84
	const SCYTHER ; 85
	const SCIZOR ; 86
	const KLEAVOR ; 87
	const HERACROSS ; 88
	const TANGELA ; 89
	const TANGROWTH ; 8a
	const MEOWTH ; 8b
	const PERSIAN ; 8c
	const SNUBBULL ; 8d
	const GRANBULL ; 8e
	const DROWZEE ; 8f
	const HYPNO ; 90
	const MR__MIME ; 91
	const SUDOWOODO ; 92
	const KOFFING ; 93
	const WEEZING ; 94
	const GRIMER ; 95
	const MUK ; 96

	; second 101 pokemon
DEF JOHTO_POKEMON EQU const_value
	const LITWICK ; 97
	const LAMPENT ; 98
	const CHANDELURE ; 99
	const MILTANK ; 9a
	const TAUROS ; 9b
	const ELECTRODE ; 9c
	const ELECTABUZZ ; 9d
	const MAGNETON ; 9e
	const MAGNEZONE ; 9f
	const SHUCKLE ; a0
	const CORSOLA ; a1
	const STARYU ; a2
	const STARMIE ; a3
	const CHINCHOU ; a4
	const LANTURN ; a5
	const TENTACOOL ; a6
	const TENTACRUEL ; a7
	const SEADRA ; a8
	const KINGDRA ; a9
	const LAPRAS ; aa
	const CLEFAIRY ; ab
	const CLEFABLE ; ac
	const SOLROCK ; ad
	const LUNATONE ; ae
	const DELIBIRD ; af
	const JYNX ; b0
	const SNORUNT ; b1
	const GLALIE ; b2
	const FROSLASS ; b3
	const PILOSWINE ; b4
	const MAMOSWINE ; b5
	const SNEASEL ; b6
	const WEAVILE ; b7
	const SNEASLER ; b8
	const SNOVER ; b9
	const ABOMASNOW ; ba
	const BALTOY ; bb
	const CLAYDOL ; bc
	const LUCARIO ; bd
	const BRONZOR ; be
	const BRONZONG ; bf
	const SKARMORY ; c0
	const AGGRON ; c1
	const AEGISLASH ; c2
	const MISDREAVUS ; c3
	const MISMAGIUS ; c4
	const CHANSEY ; c5
	const BLISSEY ; c6
	const SNORLAX ; c7
	const TYRANITAR ; c8
	const SALAMENCE ; c9
	const METAGROSS ; ca
	const HAXORUS ; cb
	const PORYGON ; cc
	const PORYGON2 ; cd
	const PORYGONZ ; ce
	const OMANYTE ; cf
	const OMASTAR ; d0
	const LILEEP ; d1
	const CRADILY ; d2
	const AERODACTYL ; d3
	const ROTOM ; d4
	const ABSOL ; d5
	const DURALUDON ; d6
	const GHOLDENGO ; d7
	const DARKRAI ; d8
	const ARTICUNO ; d9
	const ZAPDOS ; da
	const MOLTRES ; db
	const LUGIA ; dc
	const RAIKOU ; dd
	const ENTEI ; de
	const SUICUNE ; df
	const HO_OH ; e0
	const UNOWN ; e1
	const NOWN ; e2
	const JIRACHI ; e3
	const CELEBI ; e4
	const DITTO ; e5
	const MEW ; e6
	const MEWTWO ; e7
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
