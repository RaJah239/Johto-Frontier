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
	const TOGEPI ; 07
	const TOGETIC ; 08
	const TOGEKISS ; 09
	const CHARMANDER ; 0a
	const CHARMELEON ; 0b
	const CHARIZARD ; 0c
	const SQUIRTLE ; 0d
	const WARTORTLE ; 0e
	const BLASTOISE ; 0f
	const TURTWIG ; 10
	const GROTLE ; 11
	const TORTERRA ; 12
	const PIKACHU ; 13
	const RAICHU ; 14
	const EEVEE ; 15
	const ESPEON ; 16
	const FLAREON ; 17
	const JOLTEON ; 18
	const SYLVEON ; 19
	const UMBREON ; 1a
	const VAPOREON ; 1b
	const TORCHIC ; 1c
	const COMBUSKEN ; 1d
	const BLAZIKEN ; 1e
	const FEEBAS ; 1f
	const MILOTIC ; 20
	const ROWLET ; 21
	const DARTRIX ; 22
	const DECIDUEYE ; 23
	const RALTS ; 24
	const KIRLIA ; 25
	const GARDEVOIR ; 26
	const GALLADE ; 27
	const WURMPLE ; 28
	const SILCOON ; 29
	const BEAUTIFLY ; 2a
	const CASCOON ; 2b
	const DUSTOX ; 2c
	const YANMA ; 2d
	const YANMEGA ; 2e
	const SUNKERN ; 2f
	const SUNFLORA ; 30
	const BUNEARY ; 31
	const LOPUNNY ; 32
	const PIDGEY ; 33
	const PIDGEOTTO ; 34
	const PIDGEOT ; 35
	const HOOTHOOT ; 36
	const NOCTOWL ; 37
	const ZUBAT ; 38
	const GOLBAT ; 39
	const CROBAT ; 3a
	const TEDDIURSA ; 3b
	const URSARING ; 3c
	const URSALUNA ; 3d
	const URSALUNA_B ; 3e
	const PHANPY ; 3f
	const DONPHAN ; 40
	const BELLSPROUT ; 41
	const WEEPINBELL ; 42
	const VICTREEBEL ; 43
	const MAREEP ; 44
	const FLAAFFY ; 45
	const AMPHAROS ; 46
	const WIMPOD ; 47
	const GOLISOPOD ; 48
	const MARILL ; 49
	const AZUMARILL ; 4a
	const RHYHORN ; 4b
	const RHYDON ; 4c
	const DRILBUR ; 4d
	const EXCADRILL ; 4e
	const ONIX ; 4f
	const STEELIX ; 50
	const MAGIKARP ; 51
	const GYARADOS ; 52
	const GASTLY ; 53
	const HAUNTER ; 54
	const GENGAR ; 55
	const SWABLU ; 56
	const ALTARIA ; 57
	const NATU ; 58
	const KATU ; 59
	const XATU ; 5a
	const SMEARGLE ; 5b
	const GROWLITHE ; 5c
	const ARCANINE ; 5d
	const HOUNDOUR ; 5e
	const HOUNDOOM ; 5f
	const WOOPER ; 60
	const QUAGSIRE ; 61
	const GLIGAR ; 62
	const GLISCOR ; 63
	const GIBLE ; 64
	const GABITE ; 65
	const GARCHOMP ; 66
	const MAKUHITA ; 67
	const HARIYAMA ; 68
	const DODUO ; 69
	const DODRIO ; 6a
	const PONYTA ; 6b
	const RAPIDASH ; 6c
	const SLOWPOKE ; 6d
	const SLOWBRO ; 6e
	const SHROOMISH ; 6f
	const BRELOOM ; 70
	const SPINARAK ; 71
	const ARIADOS ; 72
	const VENIPEDE ; 73
	const WHIRLIPEDE ; 74
	const SCOLIPEDE ; 75
	const JOLTIK ; 76
	const GALVANTULA ; 77
	const SKORUPI ; 78
	const DRAPION ; 79
	const LARVESTA ; 7a
	const VOLCARONA ; 7b
	const IRON_MOTH ; 7c
	const TROPIUS ; 7d
	const MANKEY ; 7e
	const PRIMEAPE ; 7f
	const ANNIHILAPE ; 80
	const FERROSEED ; 81
	const FERROTHORN ; 82
	const SCYTHER ; 83
	const SCIZOR ; 84
	const KLEAVOR ; 85
	const HERACROSS ; 86
	const TANGELA ; 87
	const TANGROWTH ; 88
	const MEOWTH ; 89
	const PERSIAN ; 8a
	const SNUBBULL ; 8b
	const GRANBULL ; 8c
	const DROWZEE ; 8d
	const HYPNO ; 8e
	const MR__MIME ; 8f
	const SUDOWOODO ; 90
	const KOFFING ; 91
	const WEEZING ; 92
	const GRIMER ; 93
	const MUK ; 94

	; second 101 pokemon
DEF JOHTO_POKEMON EQU const_value
	const LITWICK ; 95
	const LAMPENT ; 96
	const CHANDELURE ; 97
	const MILTANK ; 98
	const TAUROS ; 99
	const ELECTRODE ; 9a
	const ELECTABUZZ ; 9b
	const MAGNETON ; 9c
	const MAGNEZONE ; 9d
	const SHUCKLE ; 9e
	const CORSOLA ; 9f
	const STARYU ; a0
	const STARMIE ; a1
	const CHINCHOU ; a2
	const LANTURN ; a3
	const TENTACOOL ; a4
	const TENTACRUEL ; a5
	const SEADRA ; a6
	const KINGDRA ; a7
	const LAPRAS ; a8
	const CLEFAIRY ; a9
	const CLEFABLE ; aa
	const SOLROCK ; ab
	const LUNATONE ; ac
	const DELIBIRD ; ad
	const JYNX ; ae
	const SNORUNT ; af
	const GLALIE ; b0
	const FROSLASS ; b1
	const PILOSWINE ; b2
	const MAMOSWINE ; b3
	const SNEASEL ; b4
	const WEAVILE ; b5
	const SNEASLER ; b6
	const SNOVER ; b7
	const ABOMASNOW ; b8
	const BALTOY ; b9
	const CLAYDOL ; ba
	const LUCARIO ; bb
	const BRONZOR ; bc
	const BRONZONG ; bd
	const SKARMORY ; be
	const AGGRON ; bf
	const AEGISLASH ; c0
	const MISDREAVUS ; c1
	const MISMAGIUS ; c2
	const CHANSEY ; c3
	const BLISSEY ; c4
	const SNORLAX ; c5
	const TYRANITAR ; c6
	const SALAMENCE ; c7
	const METAGROSS ; c8
	const HAXORUS ; c9
	const PORYGON ; ca
	const PORYGON2 ; cb
	const PORYGONZ ; cc
	const OMANYTE ; cd
	const OMASTAR ; ce
	const LILEEP ; cf
	const CRADILY ; d0
	const AERODACTYL ; d1
	const ROTOM ; d2
	const ABSOL ; d3
	const DURALUDON ; d4
	const GHOLDENGO ; d5
	const DARKRAI ; d6
	const ARTICUNO ; d7
	const ZAPDOS ; d8
	const MOLTRES ; d9
	const LUGIA ; da
	const RAIKOU ; db
	const ENTEI ; dc
	const SUICUNE ; dd
	const HO_OH ; de
	const UNOWN ; df
	const NOWN ; e0
	const JIRACHI ; e1
	const CELEBI ; e2
	const DITTO ; e3
	const MEW ; e4
	const MEWTWO ; e5
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
