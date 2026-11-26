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
	const GROTLE ; 0d
	const TORTERRA ; 0e
	const PIKACHU ; 0f
	const RAICHU ; 10
	const EEVEE ; 11
	const ESPEON ; 12
	const FLAREON ; 13
	const JOLTEON ; 14
	const SYLVEON ; 15
	const UMBREON ; 16
	const VAPOREON ; 17
	const TORCHIC ; 18
	const COMBUSKEN ; 19
	const BLAZIKEN ; 1a
	const FEEBAS ; 1b
	const MILOTIC ; 1c
	const ROWLET ; 1d
	const DARTRIX ; 1e
	const DECIDUEYE ; 1f
	const RALTS ; 20
	const KIRLIA ; 21
	const GARDEVOIR ; 22
	const GALLADE ; 23
	const WURMPLE ; 24
	const SILCOON ; 25
	const BEAUTIFLY ; 26
	const CASCOON ; 27
	const DUSTOX ; 28
	const YANMA ; 29
	const YANMEGA ; 2a
	const SUNKERN ; 2b
	const SUNFLORA ; 2c
	const BUNEARY ; 2d
	const LOPUNNY ; 2e
	const PIDGEY ; 2f
	const PIDGEOTTO ; 30
	const PIDGEOT ; 31
	const HOOTHOOT ; 32
	const NOCTOWL ; 33
	const ZUBAT ; 34
	const GOLBAT ; 35
	const CROBAT ; 36
	const TEDDIURSA ; 37
	const URSARING ; 38
	const URSALUNA ; 39
	const URSALUNA_B ; 3a
	const PHANPY ; 3b
	const DONPHAN ; 3c
	const BELLSPROUT ; 3d
	const WEEPINBELL ; 3e
	const VICTREEBEL ; 3f
	const MAREEP ; 40
	const FLAAFFY ; 41
	const AMPHAROS ; 42
	const WIMPOD ; 43
	const GOLISOPOD ; 44
	const MARILL ; 45
	const AZUMARILL ; 46
	const RHYHORN ; 47
	const RHYDON ; 48
	const DRILBUR ; 49
	const EXCADRILL ; 4a
	const ONIX ; 4b
	const STEELIX ; 4c
	const MAGIKARP ; 4d
	const GYARADOS ; 4e
	const GASTLY ; 4f
	const HAUNTER ; 50
	const GENGAR ; 51
	const SWABLU ; 52
	const ALTARIA ; 53
	const NATU ; 54
	const KATU ; 55
	const XATU ; 56
	const SMEARGLE ; 57
	const GROWLITHE ; 58
	const ARCANINE ; 59
	const HOUNDOUR ; 5a
	const HOUNDOOM ; 5b
	const WOOPER ; 5c
	const QUAGSIRE ; 5d
	const GLIGAR ; 5e
	const GLISCOR ; 5f
	const GIBLE ; 60
	const GABITE ; 61
	const GARCHOMP ; 62
	const MAKUHITA ; 63
	const HARIYAMA ; 64
	const DODUO ; 65
	const DODRIO ; 66
	const PONYTA ; 67
	const RAPIDASH ; 68
	const SLOWPOKE ; 69
	const SLOWBRO ; 6a
	const SHROOMISH ; 6b
	const BRELOOM ; 6c
	const SPINARAK ; 6d
	const ARIADOS ; 6e
	const VENIPEDE ; 6f
	const WHIRLIPEDE ; 70
	const SCOLIPEDE ; 71
	const JOLTIK ; 72
	const GALVANTULA ; 73
	const SKORUPI ; 74
	const DRAPION ; 75
	const LARVESTA ; 76
	const VOLCARONA ; 77
	const IRON_MOTH ; 78
	const TROPIUS ; 79
	const MANKEY ; 7a
	const PRIMEAPE ; 7b
	const ANNIHILAPE ; 7c
	const FERROSEED ; 7d
	const FERROTHORN ; 7e
	const SCYTHER ; 7f
	const SCIZOR ; 80
	const KLEAVOR ; 81
	const HERACROSS ; 82
	const TANGELA ; 83
	const TANGROWTH ; 84
	const MEOWTH ; 85
	const PERSIAN ; 86
	const SNUBBULL ; 87
	const GRANBULL ; 88
	const DROWZEE ; 89
	const HYPNO ; 8a
	const MR__MIME ; 8b
	const SUDOWOODO ; 8c
	const KOFFING ; 8d
	const WEEZING ; 8e
	const GRIMER ; 8f
	const MUK ; 90

	; second 101 pokemon
DEF JOHTO_POKEMON EQU const_value
	const LITWICK ; 91
	const LAMPENT ; 92
	const CHANDELURE ; 93
	const MILTANK ; 94
	const TAUROS ; 95
	const ELECTRODE ; 96
	const ELECTABUZZ ; 97
	const MAGNETON ; 98
	const MAGNEZONE ; 99
	const SHUCKLE ; 9a
	const CORSOLA ; 9b
	const STARYU ; 9c
	const STARMIE ; 9d
	const CHINCHOU ; 9e
	const LANTURN ; 9f
	const TENTACOOL ; a0
	const TENTACRUEL ; a1
	const SEADRA ; a2
	const KINGDRA ; a3
	const LAPRAS ; a4
	const CLEFAIRY ; a5
	const CLEFABLE ; a6
	const SOLROCK ; a7
	const LUNATONE ; a8
	const DELIBIRD ; a9
	const JYNX ; aa
	const SNORUNT ; ab
	const GLALIE ; ac
	const FROSLASS ; ad
	const PILOSWINE ; ae
	const MAMOSWINE ; af
	const SNEASEL ; b0
	const WEAVILE ; b1
	const SNEASLER ; b2
	const SNOVER ; b3
	const ABOMASNOW ; b4
	const BALTOY ; b5
	const CLAYDOL ; b6
	const LUCARIO ; b7
	const BRONZOR ; b8
	const BRONZONG ; b9
	const SKARMORY ; ba
	const AGGRON ; bb
	const AEGISLASH ; bc
	const MISDREAVUS ; bd
	const MISMAGIUS ; be
	const CHANSEY ; bf
	const BLISSEY ; c0
	const SNORLAX ; c1
	const TYRANITAR ; c2
	const SALAMENCE ; c3
	const METAGROSS ; c4
	const HAXORUS ; c5
	const PORYGON ; c6
	const PORYGON2 ; c7
	const PORYGONZ ; c8
	const OMANYTE ; c9
	const OMASTAR ; ca
	const LILEEP ; cb
	const CRADILY ; cc
	const AERODACTYL ; cd
	const ROTOM ; ce
	const ABSOL ; cf
	const DURALUDON ; d0
	const GHOLDENGO ; d1
	const DARKRAI ; d2
	const ARTICUNO ; d3
	const ZAPDOS ; d4
	const MOLTRES ; d5
	const LUGIA ; d6
	const RAIKOU ; d7
	const ENTEI ; d8
	const SUICUNE ; d9
	const HO_OH ; da
	const UNOWN ; db
	const NOWN ; dc
	const JIRACHI ; dd
	const CELEBI ; de
	const DITTO ; df
	const MEW ; e0
	const MEWTWO ; e1
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
