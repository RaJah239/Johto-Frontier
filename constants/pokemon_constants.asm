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
	const TURTWIG ; 0d
	const GROTLE ; 0e
	const TORTERRA ; 0f
	const PIKACHU ; 10
	const RAICHU ; 11
	const EEVEE ; 12
	const ESPEON ; 13
	const FLAREON ; 14
	const JOLTEON ; 15
	const SYLVEON ; 16
	const UMBREON ; 17
	const VAPOREON ; 18
	const TORCHIC ; 19
	const COMBUSKEN ; 1a
	const BLAZIKEN ; 1b
	const FEEBAS ; 1c
	const MILOTIC ; 1d
	const ROWLET ; 1e
	const DARTRIX ; 1f
	const DECIDUEYE ; 20
	const RALTS ; 21
	const KIRLIA ; 22
	const GARDEVOIR ; 23
	const GALLADE ; 24
	const WURMPLE ; 25
	const SILCOON ; 26
	const BEAUTIFLY ; 27
	const CASCOON ; 28
	const DUSTOX ; 29
	const YANMA ; 2a
	const YANMEGA ; 2b
	const SUNKERN ; 2c
	const SUNFLORA ; 2d
	const BUNEARY ; 2e
	const LOPUNNY ; 2f
	const PIDGEY ; 30
	const PIDGEOTTO ; 31
	const PIDGEOT ; 32
	const HOOTHOOT ; 33
	const NOCTOWL ; 34
	const ZUBAT ; 35
	const GOLBAT ; 36
	const CROBAT ; 37
	const TEDDIURSA ; 38
	const URSARING ; 39
	const URSALUNA ; 3a
	const URSALUNA_B ; 3b
	const PHANPY ; 3c
	const DONPHAN ; 3d
	const BELLSPROUT ; 3e
	const WEEPINBELL ; 3f
	const VICTREEBEL ; 40
	const MAREEP ; 41
	const FLAAFFY ; 42
	const AMPHAROS ; 43
	const WIMPOD ; 44
	const GOLISOPOD ; 45
	const MARILL ; 46
	const AZUMARILL ; 47
	const RHYHORN ; 48
	const RHYDON ; 49
	const DRILBUR ; 4a
	const EXCADRILL ; 4b
	const ONIX ; 4c
	const STEELIX ; 4d
	const MAGIKARP ; 4e
	const GYARADOS ; 4f
	const GASTLY ; 50
	const HAUNTER ; 51
	const GENGAR ; 52
	const SWABLU ; 53
	const ALTARIA ; 54
	const NATU ; 55
	const KATU ; 56
	const XATU ; 57
	const SMEARGLE ; 58
	const GROWLITHE ; 59
	const ARCANINE ; 5a
	const HOUNDOUR ; 5b
	const HOUNDOOM ; 5c
	const WOOPER ; 5d
	const QUAGSIRE ; 5e
	const GLIGAR ; 5f
	const GLISCOR ; 60
	const GIBLE ; 61
	const GABITE ; 62
	const GARCHOMP ; 63
	const MAKUHITA ; 64
	const HARIYAMA ; 65
	const DODUO ; 66
	const DODRIO ; 67
	const PONYTA ; 68
	const RAPIDASH ; 69
	const SLOWPOKE ; 6a
	const SLOWBRO ; 6b
	const SHROOMISH ; 6c
	const BRELOOM ; 6d
	const SPINARAK ; 6e
	const ARIADOS ; 6f
	const VENIPEDE ; 70
	const WHIRLIPEDE ; 71
	const SCOLIPEDE ; 72
	const JOLTIK ; 73
	const GALVANTULA ; 74
	const SKORUPI ; 75
	const DRAPION ; 76
	const LARVESTA ; 77
	const VOLCARONA ; 78
	const IRON_MOTH ; 79
	const TROPIUS ; 7a
	const MANKEY ; 7b
	const PRIMEAPE ; 7c
	const ANNIHILAPE ; 7d
	const FERROSEED ; 7e
	const FERROTHORN ; 7f
	const SCYTHER ; 80
	const SCIZOR ; 81
	const KLEAVOR ; 82
	const HERACROSS ; 83
	const TANGELA ; 84
	const TANGROWTH ; 85
	const MEOWTH ; 86
	const PERSIAN ; 87
	const SNUBBULL ; 88
	const GRANBULL ; 89
	const DROWZEE ; 8a
	const HYPNO ; 8b
	const MR__MIME ; 8c
	const SUDOWOODO ; 8d
	const KOFFING ; 8e
	const WEEZING ; 8f
	const GRIMER ; 90
	const MUK ; 91

	; second 101 pokemon
DEF JOHTO_POKEMON EQU const_value
	const LITWICK ; 92
	const LAMPENT ; 93
	const CHANDELURE ; 94
	const MILTANK ; 95
	const TAUROS ; 96
	const ELECTRODE ; 97
	const ELECTABUZZ ; 98
	const MAGNETON ; 99
	const MAGNEZONE ; 9a
	const SHUCKLE ; 9b
	const CORSOLA ; 9c
	const STARYU ; 9d
	const STARMIE ; 9e
	const CHINCHOU ; 9f
	const LANTURN ; a0
	const TENTACOOL ; a1
	const TENTACRUEL ; a2
	const SEADRA ; a3
	const KINGDRA ; a4
	const LAPRAS ; a5
	const CLEFAIRY ; a6
	const CLEFABLE ; a7
	const SOLROCK ; a8
	const LUNATONE ; a9
	const DELIBIRD ; aa
	const JYNX ; ab
	const SNORUNT ; ac
	const GLALIE ; ad
	const FROSLASS ; ae
	const PILOSWINE ; af
	const MAMOSWINE ; b0
	const SNEASEL ; b1
	const WEAVILE ; b2
	const SNEASLER ; b3
	const SNOVER ; b4
	const ABOMASNOW ; b5
	const BALTOY ; b6
	const CLAYDOL ; b7
	const LUCARIO ; b8
	const BRONZOR ; b9
	const BRONZONG ; ba
	const SKARMORY ; bb
	const AGGRON ; bc
	const AEGISLASH ; bd
	const MISDREAVUS ; be
	const MISMAGIUS ; bf
	const CHANSEY ; c0
	const BLISSEY ; c1
	const SNORLAX ; c2
	const TYRANITAR ; c3
	const SALAMENCE ; c4
	const METAGROSS ; c5
	const HAXORUS ; c6
	const PORYGON ; c7
	const PORYGON2 ; c8
	const PORYGONZ ; c9
	const OMANYTE ; ca
	const OMASTAR ; cb
	const LILEEP ; cc
	const CRADILY ; cd
	const AERODACTYL ; ce
	const ROTOM ; cf
	const ABSOL ; d0
	const DURALUDON ; d1
	const GHOLDENGO ; d2
	const DARKRAI ; d3
	const ARTICUNO ; d4
	const ZAPDOS ; d5
	const MOLTRES ; d6
	const LUGIA ; d7
	const RAIKOU ; d8
	const ENTEI ; d9
	const SUICUNE ; da
	const HO_OH ; db
	const UNOWN ; dc
	const NOWN ; dd
	const JIRACHI ; de
	const CELEBI ; df
	const DITTO ; e0
	const MEW ; e1
	const MEWTWO ; e2
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
