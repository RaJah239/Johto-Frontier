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
	const TORCHIC ; 17
	const COMBUSKEN ; 18
	const BLAZIKEN ; 19
	const FEEBAS ; 1a
	const MILOTIC ; 1b
	const ROWLET ; 1c
	const DARTRIX ; 1d
	const DECIDUEYE ; 1e
	const RALTS ; 1f
	const KIRLIA ; 20
	const GARDEVOIR ; 21
	const GALLADE ; 22
	const WURMPLE ; 23
	const SILCOON ; 24
	const BEAUTIFLY ; 25
	const CASCOON ; 26
	const DUSTOX ; 27
	const YANMA ; 28
	const YANMEGA ; 29
	const SUNKERN ; 2a
	const SUNFLORA ; 2b
	const BUNEARY ; 2c
	const LOPUNNY ; 2d
	const PIDGEY ; 2e
	const PIDGEOTTO ; 2f
	const PIDGEOT ; 30
	const HOOTHOOT ; 31
	const NOCTOWL ; 32
	const ZUBAT ; 33
	const GOLBAT ; 34
	const CROBAT ; 35
	const TEDDIURSA ; 36
	const URSARING ; 37
	const URSALUNA ; 38
	const URSALUNA_B ; 39
	const PHANPY ; 3a
	const DONPHAN ; 3b
	const BELLSPROUT ; 3c
	const WEEPINBELL ; 3d
	const VICTREEBEL ; 3e
	const MAREEP ; 3f
	const FLAAFFY ; 40
	const AMPHAROS ; 41
	const WIMPOD ; 42
	const GOLISOPOD ; 43
	const MARILL ; 44
	const AZUMARILL ; 45
	const RHYHORN ; 46
	const RHYDON ; 47
	const DRILBUR ; 48
	const EXCADRILL ; 49
	const ONIX ; 4a
	const STEELIX ; 4b
	const MAGIKARP ; 4c
	const GYARADOS ; 4d
	const GASTLY ; 4e
	const HAUNTER ; 4f
	const GENGAR ; 50
	const SWABLU ; 51
	const ALTARIA ; 52
	const NATU ; 53
	const KATU ; 54
	const XATU ; 55
	const SMEARGLE ; 56
	const GROWLITHE ; 57
	const ARCANINE ; 58
	const HOUNDOUR ; 59
	const HOUNDOOM ; 5a
	const WOOPER ; 5b
	const QUAGSIRE ; 5c
	const GLIGAR ; 5d
	const GLISCOR ; 5e
	const GIBLE ; 5f
	const GABITE ; 60
	const GARCHOMP ; 61
	const MAKUHITA ; 62
	const HARIYAMA ; 63
	const DODUO ; 64
	const DODRIO ; 65
	const PONYTA ; 66
	const RAPIDASH ; 67
	const SLOWPOKE ; 68
	const SLOWBRO ; 69
	const SHROOMISH ; 6a
	const BRELOOM ; 6b
	const SPINARAK ; 6c
	const ARIADOS ; 6d
	const VENIPEDE ; 6e
	const WHIRLIPEDE ; 6f
	const SCOLIPEDE ; 70
	const JOLTIK ; 71
	const GALVANTULA ; 72
	const SKORUPI ; 73
	const DRAPION ; 74
	const LARVESTA ; 75
	const VOLCARONA ; 76
	const IRON_MOTH ; 77
	const TROPIUS ; 78
	const MANKEY ; 79
	const PRIMEAPE ; 7a
	const ANNIHILAPE ; 7b
	const FERROSEED ; 7c
	const FERROTHORN ; 7d
	const SCYTHER ; 7e
	const SCIZOR ; 7f
	const KLEAVOR ; 80
	const HERACROSS ; 81
	const TANGELA ; 82
	const TANGROWTH ; 83
	const MEOWTH ; 84
	const PERSIAN ; 85
	const SNUBBULL ; 86
	const GRANBULL ; 87
	const DROWZEE ; 88
	const HYPNO ; 89
	const MR__MIME ; 8a
	const SUDOWOODO ; 8b
	const KOFFING ; 8c
	const WEEZING ; 8d
	const GRIMER ; 8e
	const MUK ; 8f

	; second 101 pokemon
DEF JOHTO_POKEMON EQU const_value
	const LITWICK ; 90
	const LAMPENT ; 91
	const CHANDELURE ; 92
	const MILTANK ; 93
	const TAUROS ; 94
	const ELECTRODE ; 95
	const ELECTABUZZ ; 96
	const MAGNETON ; 97
	const MAGNEZONE ; 98
	const SHUCKLE ; 99
	const CORSOLA ; 9a
	const STARYU ; 9b
	const STARMIE ; 9c
	const CHINCHOU ; 9d
	const LANTURN ; 9e
	const TENTACOOL ; 9f
	const TENTACRUEL ; a0
	const SEADRA ; a1
	const KINGDRA ; a2
	const LAPRAS ; a3
	const CLEFAIRY ; a4
	const CLEFABLE ; a5
	const SOLROCK ; a6
	const LUNATONE ; a7
	const DELIBIRD ; a8
	const JYNX ; a9
	const SNORUNT ; aa
	const GLALIE ; ab
	const FROSLASS ; ac
	const PILOSWINE ; ad
	const MAMOSWINE ; ae
	const SNEASEL ; af
	const WEAVILE ; b0
	const SNEASLER ; b1
	const SNOVER ; b2
	const ABOMASNOW ; b3
	const BALTOY ; b4
	const CLAYDOL ; b5
	const LUCARIO ; b6
	const BRONZOR ; b7
	const BRONZONG ; b8
	const SKARMORY ; b9
	const AGGRON ; ba
	const AEGISLASH ; bb
	const MISDREAVUS ; bc
	const MISMAGIUS ; bd
	const CHANSEY ; be
	const BLISSEY ; bf
	const SNORLAX ; c0
	const TYRANITAR ; c1
	const SALAMENCE ; c2
	const METAGROSS ; c3
	const HAXORUS ; c4
	const PORYGON ; c5
	const PORYGON2 ; c6
	const PORYGONZ ; c7
	const OMANYTE ; c8
	const OMASTAR ; c9
	const LILEEP ; ca
	const CRADILY ; cb
	const AERODACTYL ; cc
	const ROTOM ; cd
	const ABSOL ; ce
	const DURALUDON ; cf
	const GHOLDENGO ; d0
	const DARKRAI ; d1
	const ARTICUNO ; d2
	const ZAPDOS ; d3
	const MOLTRES ; d4
	const LUGIA ; d5
	const RAIKOU ; d6
	const ENTEI ; d7
	const SUICUNE ; d8
	const HO_OH ; d9
	const UNOWN ; da
	const NOWN ; db
	const JIRACHI ; dc
	const CELEBI ; dd
	const DITTO ; de
	const MEW ; df
	const MEWTWO ; e0
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
