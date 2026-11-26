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
	const ROWLET ; 1b
	const DARTRIX ; 1c
	const DECIDUEYE ; 1d
	const RALTS ; 1e
	const KIRLIA ; 1f
	const GARDEVOIR ; 20
	const GALLADE ; 21
	const WURMPLE ; 22
	const SILCOON ; 23
	const BEAUTIFLY ; 24
	const CASCOON ; 25
	const DUSTOX ; 26
	const YANMA ; 27
	const YANMEGA ; 28
	const SUNKERN ; 29
	const SUNFLORA ; 2a
	const BUNEARY ; 2b
	const LOPUNNY ; 2c
	const PIDGEY ; 2d
	const PIDGEOTTO ; 2e
	const PIDGEOT ; 2f
	const HOOTHOOT ; 30
	const NOCTOWL ; 31
	const ZUBAT ; 32
	const GOLBAT ; 33
	const CROBAT ; 34
	const TEDDIURSA ; 35
	const URSARING ; 36
	const URSALUNA ; 37
	const URSALUNA_B ; 38
	const PHANPY ; 39
	const DONPHAN ; 3a
	const BELLSPROUT ; 3b
	const WEEPINBELL ; 3c
	const VICTREEBEL ; 3d
	const MAREEP ; 3e
	const FLAAFFY ; 3f
	const AMPHAROS ; 40
	const WIMPOD ; 41
	const GOLISOPOD ; 42
	const MARILL ; 43
	const AZUMARILL ; 44
	const RHYHORN ; 45
	const RHYDON ; 46
	const DRILBUR ; 47
	const EXCADRILL ; 48
	const ONIX ; 49
	const STEELIX ; 4a
	const MAGIKARP ; 4b
	const GYARADOS ; 4c
	const GASTLY ; 4d
	const HAUNTER ; 4e
	const GENGAR ; 4f
	const SWABLU ; 50
	const ALTARIA ; 51
	const NATU ; 52
	const KATU ; 53
	const XATU ; 54
	const SMEARGLE ; 55
	const GROWLITHE ; 56
	const ARCANINE ; 57
	const HOUNDOUR ; 58
	const HOUNDOOM ; 59
	const WOOPER ; 5a
	const QUAGSIRE ; 5b
	const GLIGAR ; 5c
	const GLISCOR ; 5d
	const GIBLE ; 5e
	const GABITE ; 5f
	const GARCHOMP ; 60
	const MAKUHITA ; 61
	const HARIYAMA ; 62
	const DODUO ; 63
	const DODRIO ; 64
	const PONYTA ; 65
	const RAPIDASH ; 66
	const SLOWPOKE ; 67
	const SLOWBRO ; 68
	const SHROOMISH ; 69
	const BRELOOM ; 6a
	const SPINARAK ; 6b
	const ARIADOS ; 6c
	const VENIPEDE ; 6d
	const WHIRLIPEDE ; 6e
	const SCOLIPEDE ; 6f
	const JOLTIK ; 70
	const GALVANTULA ; 71
	const SKORUPI ; 72
	const DRAPION ; 73
	const LARVESTA ; 74
	const VOLCARONA ; 75
	const IRON_MOTH ; 76
	const TROPIUS ; 77
	const MANKEY ; 78
	const PRIMEAPE ; 79
	const ANNIHILAPE ; 7a
	const FERROSEED ; 7b
	const FERROTHORN ; 7c
	const SCYTHER ; 7d
	const SCIZOR ; 7e
	const KLEAVOR ; 7f
	const HERACROSS ; 80
	const TANGELA ; 81
	const TANGROWTH ; 82
	const MEOWTH ; 83
	const PERSIAN ; 84
	const SNUBBULL ; 85
	const GRANBULL ; 86
	const DROWZEE ; 87
	const HYPNO ; 88
	const MR__MIME ; 89
	const SUDOWOODO ; 8a
	const KOFFING ; 8b
	const WEEZING ; 8c
	const GRIMER ; 8d
	const MUK ; 8e

	; second 101 pokemon
DEF JOHTO_POKEMON EQU const_value
	const LITWICK ; 8f
	const LAMPENT ; 90
	const CHANDELURE ; 91
	const MILTANK ; 92
	const TAUROS ; 93
	const ELECTRODE ; 94
	const ELECTABUZZ ; 95
	const MAGNETON ; 96
	const MAGNEZONE ; 97
	const SHUCKLE ; 98
	const CORSOLA ; 99
	const STARYU ; 9a
	const STARMIE ; 9b
	const CHINCHOU ; 9c
	const LANTURN ; 9d
	const TENTACOOL ; 9e
	const TENTACRUEL ; 9f
	const SEADRA ; a0
	const KINGDRA ; a1
	const LAPRAS ; a2
	const CLEFAIRY ; a3
	const CLEFABLE ; a4
	const SOLROCK ; a5
	const LUNATONE ; a6
	const DELIBIRD ; a7
	const JYNX ; a8
	const SNORUNT ; a9
	const GLALIE ; aa
	const FROSLASS ; ab
	const PILOSWINE ; ac
	const MAMOSWINE ; ad
	const SNEASEL ; ae
	const WEAVILE ; af
	const SNEASLER ; b0
	const SNOVER ; b1
	const ABOMASNOW ; b2
	const BALTOY ; b3
	const CLAYDOL ; b4
	const LUCARIO ; b5
	const BRONZOR ; b6
	const BRONZONG ; b7
	const SKARMORY ; b8
	const AGGRON ; b9
	const AEGISLASH ; ba
	const MISDREAVUS ; bb
	const MISMAGIUS ; bc
	const CHANSEY ; bd
	const BLISSEY ; be
	const SNORLAX ; bf
	const TYRANITAR ; c0
	const SALAMENCE ; c1
	const METAGROSS ; c2
	const HAXORUS ; c3
	const PORYGON ; c4
	const PORYGON2 ; c5
	const PORYGONZ ; c6
	const OMANYTE ; c7
	const OMASTAR ; c8
	const LILEEP ; c9
	const CRADILY ; ca
	const AERODACTYL ; cb
	const ROTOM ; cc
	const ABSOL ; cd
	const DURALUDON ; ce
	const GHOLDENGO ; cf
	const DARKRAI ; d0
	const ARTICUNO ; d1
	const ZAPDOS ; d2
	const MOLTRES ; d3
	const LUGIA ; d4
	const RAIKOU ; d5
	const ENTEI ; d6
	const SUICUNE ; d7
	const HO_OH ; d8
	const UNOWN ; d9
	const NOWN ; da
	const JIRACHI ; db
	const CELEBI ; dc
	const DITTO ; dd
	const MEW ; de
	const MEWTWO ; df
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
