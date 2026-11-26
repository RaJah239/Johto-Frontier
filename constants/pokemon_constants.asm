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
	const DECIDUEYE ; 1b
	const RALTS ; 1c
	const KIRLIA ; 1d
	const GARDEVOIR ; 1e
	const GALLADE ; 1f
	const WURMPLE ; 20
	const SILCOON ; 21
	const BEAUTIFLY ; 22
	const CASCOON ; 23
	const DUSTOX ; 24
	const YANMA ; 25
	const YANMEGA ; 26
	const SUNKERN ; 27
	const SUNFLORA ; 28
	const BUNEARY ; 29
	const LOPUNNY ; 2a
	const PIDGEY ; 2b
	const PIDGEOTTO ; 2c
	const PIDGEOT ; 2d
	const HOOTHOOT ; 2e
	const NOCTOWL ; 2f
	const ZUBAT ; 30
	const GOLBAT ; 31
	const CROBAT ; 32
	const TEDDIURSA ; 33
	const URSARING ; 34
	const URSALUNA ; 35
	const URSALUNA_B ; 36
	const PHANPY ; 37
	const DONPHAN ; 38
	const BELLSPROUT ; 39
	const WEEPINBELL ; 3a
	const VICTREEBEL ; 3b
	const MAREEP ; 3c
	const FLAAFFY ; 3d
	const AMPHAROS ; 3e
	const WIMPOD ; 3f
	const GOLISOPOD ; 40
	const MARILL ; 41
	const AZUMARILL ; 42
	const RHYHORN ; 43
	const RHYDON ; 44
	const DRILBUR ; 45
	const EXCADRILL ; 46
	const ONIX ; 47
	const STEELIX ; 48
	const MAGIKARP ; 49
	const GYARADOS ; 4a
	const GASTLY ; 4b
	const HAUNTER ; 4c
	const GENGAR ; 4d
	const SWABLU ; 4e
	const ALTARIA ; 4f
	const NATU ; 50
	const KATU ; 51
	const XATU ; 52
	const SMEARGLE ; 53
	const GROWLITHE ; 54
	const ARCANINE ; 55
	const HOUNDOUR ; 56
	const HOUNDOOM ; 57
	const WOOPER ; 58
	const QUAGSIRE ; 59
	const GLIGAR ; 5a
	const GLISCOR ; 5b
	const GIBLE ; 5c
	const GABITE ; 5d
	const GARCHOMP ; 5e
	const MAKUHITA ; 5f
	const HARIYAMA ; 60
	const DODUO ; 61
	const DODRIO ; 62
	const PONYTA ; 63
	const RAPIDASH ; 64
	const SLOWPOKE ; 65
	const SLOWBRO ; 66
	const SHROOMISH ; 67
	const BRELOOM ; 68
	const SPINARAK ; 69
	const ARIADOS ; 6a
	const VENIPEDE ; 6b
	const WHIRLIPEDE ; 6c
	const SCOLIPEDE ; 6d
	const JOLTIK ; 6e
	const GALVANTULA ; 6f
	const SKORUPI ; 70
	const DRAPION ; 71
	const LARVESTA ; 72
	const VOLCARONA ; 73
	const IRON_MOTH ; 74
	const TROPIUS ; 75
	const MANKEY ; 76
	const PRIMEAPE ; 77
	const ANNIHILAPE ; 78
	const FERROSEED ; 79
	const FERROTHORN ; 7a
	const SCYTHER ; 7b
	const SCIZOR ; 7c
	const KLEAVOR ; 7d
	const HERACROSS ; 7e
	const TANGELA ; 7f
	const TANGROWTH ; 80
	const MEOWTH ; 81
	const PERSIAN ; 82
	const SNUBBULL ; 83
	const GRANBULL ; 84
	const DROWZEE ; 85
	const HYPNO ; 86
	const MR__MIME ; 87
	const SUDOWOODO ; 88
	const KOFFING ; 89
	const WEEZING ; 8a
	const GRIMER ; 8b
	const MUK ; 8c

	; second 101 pokemon
DEF JOHTO_POKEMON EQU const_value
	const LITWICK ; 8d
	const LAMPENT ; 8e
	const CHANDELURE ; 8f
	const MILTANK ; 90
	const TAUROS ; 91
	const ELECTRODE ; 92
	const ELECTABUZZ ; 93
	const MAGNETON ; 94
	const MAGNEZONE ; 95
	const SHUCKLE ; 96
	const CORSOLA ; 97
	const STARYU ; 98
	const STARMIE ; 99
	const CHINCHOU ; 9a
	const LANTURN ; 9b
	const TENTACOOL ; 9c
	const TENTACRUEL ; 9d
	const SEADRA ; 9e
	const KINGDRA ; 9f
	const LAPRAS ; a0
	const CLEFAIRY ; a1
	const CLEFABLE ; a2
	const SOLROCK ; a3
	const LUNATONE ; a4
	const DELIBIRD ; a5
	const JYNX ; a6
	const SNORUNT ; a7
	const GLALIE ; a8
	const FROSLASS ; a9
	const PILOSWINE ; aa
	const MAMOSWINE ; ab
	const SNEASEL ; ac
	const WEAVILE ; ad
	const SNEASLER ; ae
	const SNOVER ; af
	const ABOMASNOW ; b0
	const BALTOY ; b1
	const CLAYDOL ; b2
	const LUCARIO ; b3
	const BRONZOR ; b4
	const BRONZONG ; b5
	const SKARMORY ; b6
	const AGGRON ; b7
	const AEGISLASH ; b8
	const MISDREAVUS ; b9
	const MISMAGIUS ; ba
	const CHANSEY ; bb
	const BLISSEY ; bc
	const SNORLAX ; bd
	const TYRANITAR ; be
	const SALAMENCE ; bf
	const METAGROSS ; c0
	const HAXORUS ; c1
	const PORYGON ; c2
	const PORYGON2 ; c3
	const PORYGONZ ; c4
	const OMANYTE ; c5
	const OMASTAR ; c6
	const LILEEP ; c7
	const CRADILY ; c8
	const AERODACTYL ; c9
	const ROTOM ; ca
	const ABSOL ; cb
	const DURALUDON ; cc
	const GHOLDENGO ; cd
	const DARKRAI ; ce
	const ARTICUNO ; cf
	const ZAPDOS ; d0
	const MOLTRES ; d1
	const LUGIA ; d2
	const RAIKOU ; d3
	const ENTEI ; d4
	const SUICUNE ; d5
	const HO_OH ; d6
	const UNOWN ; d7
	const NOWN ; d8
	const JIRACHI ; d9
	const CELEBI ; da
	const DITTO ; db
	const MEW ; dc
	const MEWTWO ; dd
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
