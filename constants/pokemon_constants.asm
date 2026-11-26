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
	const CHIKORITA ; 05
	const BAYLEEF ; 06
	const MEGANIUM ; 07
	const TOGEPI ; 08
	const TOGETIC ; 09
	const TOGEKISS ; 0a
	const CHARMANDER ; 0b
	const CHARMELEON ; 0c
	const CHARIZARD ; 0d
	const SQUIRTLE ; 0e
	const WARTORTLE ; 0f
	const BLASTOISE ; 10
	const TURTWIG ; 11
	const GROTLE ; 12
	const TORTERRA ; 13
	const PIKACHU ; 14
	const RAICHU ; 15
	const EEVEE ; 16
	const ESPEON ; 17
	const FLAREON ; 18
	const JOLTEON ; 19
	const SYLVEON ; 1a
	const UMBREON ; 1b
	const VAPOREON ; 1c
	const TORCHIC ; 1d
	const COMBUSKEN ; 1e
	const BLAZIKEN ; 1f
	const FEEBAS ; 20
	const MILOTIC ; 21
	const ROWLET ; 22
	const DARTRIX ; 23
	const DECIDUEYE ; 24
	const RALTS ; 25
	const KIRLIA ; 26
	const GARDEVOIR ; 27
	const GALLADE ; 28
	const WURMPLE ; 29
	const SILCOON ; 2a
	const BEAUTIFLY ; 2b
	const CASCOON ; 2c
	const DUSTOX ; 2d
	const YANMA ; 2e
	const YANMEGA ; 2f
	const SUNKERN ; 30
	const SUNFLORA ; 31
	const BUNEARY ; 32
	const LOPUNNY ; 33
	const PIDGEY ; 34
	const PIDGEOTTO ; 35
	const PIDGEOT ; 36
	const HOOTHOOT ; 37
	const NOCTOWL ; 38
	const ZUBAT ; 39
	const GOLBAT ; 3a
	const CROBAT ; 3b
	const TEDDIURSA ; 3c
	const URSARING ; 3d
	const URSALUNA ; 3e
	const URSALUNA_B ; 3f
	const PHANPY ; 40
	const DONPHAN ; 41
	const BELLSPROUT ; 42
	const WEEPINBELL ; 43
	const VICTREEBEL ; 44
	const MAREEP ; 45
	const FLAAFFY ; 46
	const AMPHAROS ; 47
	const WIMPOD ; 48
	const GOLISOPOD ; 49
	const MARILL ; 4a
	const AZUMARILL ; 4b
	const RHYHORN ; 4c
	const RHYDON ; 4d
	const DRILBUR ; 4e
	const EXCADRILL ; 4f
	const ONIX ; 50
	const STEELIX ; 51
	const MAGIKARP ; 52
	const GYARADOS ; 53
	const GASTLY ; 54
	const HAUNTER ; 55
	const GENGAR ; 56
	const SWABLU ; 57
	const ALTARIA ; 58
	const NATU ; 59
	const KATU ; 5a
	const XATU ; 5b
	const SMEARGLE ; 5c
	const GROWLITHE ; 5d
	const ARCANINE ; 5e
	const HOUNDOUR ; 5f
	const HOUNDOOM ; 60
	const WOOPER ; 61
	const QUAGSIRE ; 62
	const GLIGAR ; 63
	const GLISCOR ; 64
	const GIBLE ; 65
	const GABITE ; 66
	const GARCHOMP ; 67
	const MAKUHITA ; 68
	const HARIYAMA ; 69
	const DODUO ; 6a
	const DODRIO ; 6b
	const PONYTA ; 6c
	const RAPIDASH ; 6d
	const SLOWPOKE ; 6e
	const SLOWBRO ; 6f
	const SHROOMISH ; 70
	const BRELOOM ; 71
	const SPINARAK ; 72
	const ARIADOS ; 73
	const VENIPEDE ; 74
	const WHIRLIPEDE ; 75
	const SCOLIPEDE ; 76
	const JOLTIK ; 77
	const GALVANTULA ; 78
	const SKORUPI ; 79
	const DRAPION ; 7a
	const LARVESTA ; 7b
	const VOLCARONA ; 7c
	const IRON_MOTH ; 7d
	const TROPIUS ; 7e
	const MANKEY ; 7f
	const PRIMEAPE ; 80
	const ANNIHILAPE ; 81
	const FERROSEED ; 82
	const FERROTHORN ; 83
	const SCYTHER ; 84
	const SCIZOR ; 85
	const KLEAVOR ; 86
	const HERACROSS ; 87
	const TANGELA ; 88
	const TANGROWTH ; 89
	const MEOWTH ; 8a
	const PERSIAN ; 8b
	const SNUBBULL ; 8c
	const GRANBULL ; 8d
	const DROWZEE ; 8e
	const HYPNO ; 8f
	const MR__MIME ; 90
	const SUDOWOODO ; 91
	const KOFFING ; 92
	const WEEZING ; 93
	const GRIMER ; 94
	const MUK ; 95

	; second 101 pokemon
DEF JOHTO_POKEMON EQU const_value
	const LITWICK ; 96
	const LAMPENT ; 97
	const CHANDELURE ; 98
	const MILTANK ; 99
	const TAUROS ; 9a
	const ELECTRODE ; 9b
	const ELECTABUZZ ; 9c
	const MAGNETON ; 9d
	const MAGNEZONE ; 9e
	const SHUCKLE ; 9f
	const CORSOLA ; a0
	const STARYU ; a1
	const STARMIE ; a2
	const CHINCHOU ; a3
	const LANTURN ; a4
	const TENTACOOL ; a5
	const TENTACRUEL ; a6
	const SEADRA ; a7
	const KINGDRA ; a8
	const LAPRAS ; a9
	const CLEFAIRY ; aa
	const CLEFABLE ; ab
	const SOLROCK ; ac
	const LUNATONE ; ad
	const DELIBIRD ; ae
	const JYNX ; af
	const SNORUNT ; b0
	const GLALIE ; b1
	const FROSLASS ; b2
	const PILOSWINE ; b3
	const MAMOSWINE ; b4
	const SNEASEL ; b5
	const WEAVILE ; b6
	const SNEASLER ; b7
	const SNOVER ; b8
	const ABOMASNOW ; b9
	const BALTOY ; ba
	const CLAYDOL ; bb
	const LUCARIO ; bc
	const BRONZOR ; bd
	const BRONZONG ; be
	const SKARMORY ; bf
	const AGGRON ; c0
	const AEGISLASH ; c1
	const MISDREAVUS ; c2
	const MISMAGIUS ; c3
	const CHANSEY ; c4
	const BLISSEY ; c5
	const SNORLAX ; c6
	const TYRANITAR ; c7
	const SALAMENCE ; c8
	const METAGROSS ; c9
	const HAXORUS ; ca
	const PORYGON ; cb
	const PORYGON2 ; cc
	const PORYGONZ ; cd
	const OMANYTE ; ce
	const OMASTAR ; cf
	const LILEEP ; d0
	const CRADILY ; d1
	const AERODACTYL ; d2
	const ROTOM ; d3
	const ABSOL ; d4
	const DURALUDON ; d5
	const GHOLDENGO ; d6
	const DARKRAI ; d7
	const ARTICUNO ; d8
	const ZAPDOS ; d9
	const MOLTRES ; da
	const LUGIA ; db
	const RAIKOU ; dc
	const ENTEI ; dd
	const SUICUNE ; de
	const HO_OH ; df
	const UNOWN ; e0
	const NOWN ; e1
	const JIRACHI ; e2
	const CELEBI ; e3
	const DITTO ; e4
	const MEW ; e5
	const MEWTWO ; e6
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
