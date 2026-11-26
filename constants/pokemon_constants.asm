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
	const CHARMANDER ; 09
	const CHARMELEON ; 0a
	const CHARIZARD ; 0b
	const SQUIRTLE ; 0c
	const WARTORTLE ; 0d
	const BLASTOISE ; 0e
	const TURTWIG ; 0f
	const GROTLE ; 10
	const TORTERRA ; 11
	const PIKACHU ; 12
	const RAICHU ; 13
	const EEVEE ; 14
	const ESPEON ; 15
	const FLAREON ; 16
	const JOLTEON ; 17
	const SYLVEON ; 18
	const UMBREON ; 19
	const VAPOREON ; 1a
	const TORCHIC ; 1b
	const COMBUSKEN ; 1c
	const BLAZIKEN ; 1d
	const FEEBAS ; 1e
	const MILOTIC ; 1f
	const ROWLET ; 20
	const DARTRIX ; 21
	const DECIDUEYE ; 22
	const RALTS ; 23
	const KIRLIA ; 24
	const GARDEVOIR ; 25
	const GALLADE ; 26
	const WURMPLE ; 27
	const SILCOON ; 28
	const BEAUTIFLY ; 29
	const CASCOON ; 2a
	const DUSTOX ; 2b
	const YANMA ; 2c
	const YANMEGA ; 2d
	const SUNKERN ; 2e
	const SUNFLORA ; 2f
	const BUNEARY ; 30
	const LOPUNNY ; 31
	const PIDGEY ; 32
	const PIDGEOTTO ; 33
	const PIDGEOT ; 34
	const HOOTHOOT ; 35
	const NOCTOWL ; 36
	const ZUBAT ; 37
	const GOLBAT ; 38
	const CROBAT ; 39
	const TEDDIURSA ; 3a
	const URSARING ; 3b
	const URSALUNA ; 3c
	const URSALUNA_B ; 3d
	const PHANPY ; 3e
	const DONPHAN ; 3f
	const BELLSPROUT ; 40
	const WEEPINBELL ; 41
	const VICTREEBEL ; 42
	const MAREEP ; 43
	const FLAAFFY ; 44
	const AMPHAROS ; 45
	const WIMPOD ; 46
	const GOLISOPOD ; 47
	const MARILL ; 48
	const AZUMARILL ; 49
	const RHYHORN ; 4a
	const RHYDON ; 4b
	const DRILBUR ; 4c
	const EXCADRILL ; 4d
	const ONIX ; 4e
	const STEELIX ; 4f
	const MAGIKARP ; 50
	const GYARADOS ; 51
	const GASTLY ; 52
	const HAUNTER ; 53
	const GENGAR ; 54
	const SWABLU ; 55
	const ALTARIA ; 56
	const NATU ; 57
	const KATU ; 58
	const XATU ; 59
	const SMEARGLE ; 5a
	const GROWLITHE ; 5b
	const ARCANINE ; 5c
	const HOUNDOUR ; 5d
	const HOUNDOOM ; 5e
	const WOOPER ; 5f
	const QUAGSIRE ; 60
	const GLIGAR ; 61
	const GLISCOR ; 62
	const GIBLE ; 63
	const GABITE ; 64
	const GARCHOMP ; 65
	const MAKUHITA ; 66
	const HARIYAMA ; 67
	const DODUO ; 68
	const DODRIO ; 69
	const PONYTA ; 6a
	const RAPIDASH ; 6b
	const SLOWPOKE ; 6c
	const SLOWBRO ; 6d
	const SHROOMISH ; 6e
	const BRELOOM ; 6f
	const SPINARAK ; 70
	const ARIADOS ; 71
	const VENIPEDE ; 72
	const WHIRLIPEDE ; 73
	const SCOLIPEDE ; 74
	const JOLTIK ; 75
	const GALVANTULA ; 76
	const SKORUPI ; 77
	const DRAPION ; 78
	const LARVESTA ; 79
	const VOLCARONA ; 7a
	const IRON_MOTH ; 7b
	const TROPIUS ; 7c
	const MANKEY ; 7d
	const PRIMEAPE ; 7e
	const ANNIHILAPE ; 7f
	const FERROSEED ; 80
	const FERROTHORN ; 81
	const SCYTHER ; 82
	const SCIZOR ; 83
	const KLEAVOR ; 84
	const HERACROSS ; 85
	const TANGELA ; 86
	const TANGROWTH ; 87
	const MEOWTH ; 88
	const PERSIAN ; 89
	const SNUBBULL ; 8a
	const GRANBULL ; 8b
	const DROWZEE ; 8c
	const HYPNO ; 8d
	const MR__MIME ; 8e
	const SUDOWOODO ; 8f
	const KOFFING ; 90
	const WEEZING ; 91
	const GRIMER ; 92
	const MUK ; 93

	; second 101 pokemon
DEF JOHTO_POKEMON EQU const_value
	const LITWICK ; 94
	const LAMPENT ; 95
	const CHANDELURE ; 96
	const MILTANK ; 97
	const TAUROS ; 98
	const ELECTRODE ; 99
	const ELECTABUZZ ; 9a
	const MAGNETON ; 9b
	const MAGNEZONE ; 9c
	const SHUCKLE ; 9d
	const CORSOLA ; 9e
	const STARYU ; 9f
	const STARMIE ; a0
	const CHINCHOU ; a1
	const LANTURN ; a2
	const TENTACOOL ; a3
	const TENTACRUEL ; a4
	const SEADRA ; a5
	const KINGDRA ; a6
	const LAPRAS ; a7
	const CLEFAIRY ; a8
	const CLEFABLE ; a9
	const SOLROCK ; aa
	const LUNATONE ; ab
	const DELIBIRD ; ac
	const JYNX ; ad
	const SNORUNT ; ae
	const GLALIE ; af
	const FROSLASS ; b0
	const PILOSWINE ; b1
	const MAMOSWINE ; b2
	const SNEASEL ; b3
	const WEAVILE ; b4
	const SNEASLER ; b5
	const SNOVER ; b6
	const ABOMASNOW ; b7
	const BALTOY ; b8
	const CLAYDOL ; b9
	const LUCARIO ; ba
	const BRONZOR ; bb
	const BRONZONG ; bc
	const SKARMORY ; bd
	const AGGRON ; be
	const AEGISLASH ; bf
	const MISDREAVUS ; c0
	const MISMAGIUS ; c1
	const CHANSEY ; c2
	const BLISSEY ; c3
	const SNORLAX ; c4
	const TYRANITAR ; c5
	const SALAMENCE ; c6
	const METAGROSS ; c7
	const HAXORUS ; c8
	const PORYGON ; c9
	const PORYGON2 ; ca
	const PORYGONZ ; cb
	const OMANYTE ; cc
	const OMASTAR ; cd
	const LILEEP ; ce
	const CRADILY ; cf
	const AERODACTYL ; d0
	const ROTOM ; d1
	const ABSOL ; d2
	const DURALUDON ; d3
	const GHOLDENGO ; d4
	const DARKRAI ; d5
	const ARTICUNO ; d6
	const ZAPDOS ; d7
	const MOLTRES ; d8
	const LUGIA ; d9
	const RAIKOU ; da
	const ENTEI ; db
	const SUICUNE ; dc
	const HO_OH ; dd
	const UNOWN ; de
	const NOWN ; df
	const JIRACHI ; e0
	const CELEBI ; e1
	const DITTO ; e2
	const MEW ; e3
	const MEWTWO ; e4
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
