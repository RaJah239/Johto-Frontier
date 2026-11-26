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
	const RALTS ; 1b
	const KIRLIA ; 1c
	const GARDEVOIR ; 1d
	const GALLADE ; 1e
	const WURMPLE ; 1f
	const SILCOON ; 20
	const BEAUTIFLY ; 21
	const CASCOON ; 22
	const DUSTOX ; 23
	const YANMA ; 24
	const YANMEGA ; 25
	const SUNKERN ; 26
	const SUNFLORA ; 27
	const BUNEARY ; 28
	const LOPUNNY ; 29
	const PIDGEY ; 2a
	const PIDGEOTTO ; 2b
	const PIDGEOT ; 2c
	const HOOTHOOT ; 2d
	const NOCTOWL ; 2e
	const ZUBAT ; 2f
	const GOLBAT ; 30
	const CROBAT ; 31
	const TEDDIURSA ; 32
	const URSARING ; 33
	const URSALUNA ; 34
	const URSALUNA_B ; 35
	const PHANPY ; 36
	const DONPHAN ; 37
	const BELLSPROUT ; 38
	const WEEPINBELL ; 39
	const VICTREEBEL ; 3a
	const MAREEP ; 3b
	const FLAAFFY ; 3c
	const AMPHAROS ; 3d
	const WIMPOD ; 3e
	const GOLISOPOD ; 3f
	const MARILL ; 40
	const AZUMARILL ; 41
	const RHYHORN ; 42
	const RHYDON ; 43
	const DRILBUR ; 44
	const EXCADRILL ; 45
	const ONIX ; 46
	const STEELIX ; 47
	const MAGIKARP ; 48
	const GYARADOS ; 49
	const GASTLY ; 4a
	const HAUNTER ; 4b
	const GENGAR ; 4c
	const SWABLU ; 4d
	const ALTARIA ; 4e
	const NATU ; 4f
	const KATU ; 50
	const XATU ; 51
	const SMEARGLE ; 52
	const GROWLITHE ; 53
	const ARCANINE ; 54
	const HOUNDOUR ; 55
	const HOUNDOOM ; 56
	const WOOPER ; 57
	const QUAGSIRE ; 58
	const GLIGAR ; 59
	const GLISCOR ; 5a
	const GIBLE ; 5b
	const GABITE ; 5c
	const GARCHOMP ; 5d
	const MAKUHITA ; 5e
	const HARIYAMA ; 5f
	const DODUO ; 60
	const DODRIO ; 61
	const PONYTA ; 62
	const RAPIDASH ; 63
	const SLOWPOKE ; 64
	const SLOWBRO ; 65
	const SHROOMISH ; 66
	const BRELOOM ; 67
	const SPINARAK ; 68
	const ARIADOS ; 69
	const VENIPEDE ; 6a
	const WHIRLIPEDE ; 6b
	const SCOLIPEDE ; 6c
	const JOLTIK ; 6d
	const GALVANTULA ; 6e
	const SKORUPI ; 6f
	const DRAPION ; 70
	const LARVESTA ; 71
	const VOLCARONA ; 72
	const IRON_MOTH ; 73
	const TROPIUS ; 74
	const MANKEY ; 75
	const PRIMEAPE ; 76
	const ANNIHILAPE ; 77
	const FERROSEED ; 78
	const FERROTHORN ; 79
	const SCYTHER ; 7a
	const SCIZOR ; 7b
	const KLEAVOR ; 7c
	const HERACROSS ; 7d
	const TANGELA ; 7e
	const TANGROWTH ; 7f
	const MEOWTH ; 80
	const PERSIAN ; 81
	const SNUBBULL ; 82
	const GRANBULL ; 83
	const DROWZEE ; 84
	const HYPNO ; 85
	const MR__MIME ; 86
	const SUDOWOODO ; 87
	const KOFFING ; 88
	const WEEZING ; 89
	const GRIMER ; 8a
	const MUK ; 8b

	; second 101 pokemon
DEF JOHTO_POKEMON EQU const_value
	const LITWICK ; 8c
	const LAMPENT ; 8d
	const CHANDELURE ; 8e
	const MILTANK ; 8f
	const TAUROS ; 90
	const ELECTRODE ; 91
	const ELECTABUZZ ; 92
	const MAGNETON ; 93
	const MAGNEZONE ; 94
	const SHUCKLE ; 95
	const CORSOLA ; 96
	const STARYU ; 97
	const STARMIE ; 98
	const CHINCHOU ; 99
	const LANTURN ; 9a
	const TENTACOOL ; 9b
	const TENTACRUEL ; 9c
	const SEADRA ; 9d
	const KINGDRA ; 9e
	const LAPRAS ; 9f
	const CLEFAIRY ; a0
	const CLEFABLE ; a1
	const SOLROCK ; a2
	const LUNATONE ; a3
	const DELIBIRD ; a4
	const JYNX ; a5
	const SNORUNT ; a6
	const GLALIE ; a7
	const FROSLASS ; a8
	const PILOSWINE ; a9
	const MAMOSWINE ; aa
	const SNEASEL ; ab
	const WEAVILE ; ac
	const SNEASLER ; ad
	const SNOVER ; ae
	const ABOMASNOW ; af
	const BALTOY ; b0
	const CLAYDOL ; b1
	const LUCARIO ; b2
	const BRONZOR ; b3
	const BRONZONG ; b4
	const SKARMORY ; b5
	const AGGRON ; b6
	const AEGISLASH ; b7
	const MISDREAVUS ; b8
	const MISMAGIUS ; b9
	const CHANSEY ; ba
	const BLISSEY ; bb
	const SNORLAX ; bc
	const TYRANITAR ; bd
	const SALAMENCE ; be
	const METAGROSS ; bf
	const HAXORUS ; c0
	const PORYGON ; c1
	const PORYGON2 ; c2
	const PORYGONZ ; c3
	const OMANYTE ; c4
	const OMASTAR ; c5
	const LILEEP ; c6
	const CRADILY ; c7
	const AERODACTYL ; c8
	const ROTOM ; c9
	const ABSOL ; ca
	const DURALUDON ; cb
	const GHOLDENGO ; cc
	const DARKRAI ; cd
	const ARTICUNO ; ce
	const ZAPDOS ; cf
	const MOLTRES ; d0
	const LUGIA ; d1
	const RAIKOU ; d2
	const ENTEI ; d3
	const SUICUNE ; d4
	const HO_OH ; d5
	const UNOWN ; d6
	const NOWN ; d7
	const JIRACHI ; d8
	const CELEBI ; d9
	const DITTO ; da
	const MEW ; db
	const MEWTWO ; dc
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
