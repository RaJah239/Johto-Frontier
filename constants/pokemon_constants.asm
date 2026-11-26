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
	const KIRLIA ; 1b
	const GARDEVOIR ; 1c
	const GALLADE ; 1d
	const WURMPLE ; 1e
	const SILCOON ; 1f
	const BEAUTIFLY ; 20
	const CASCOON ; 21
	const DUSTOX ; 22
	const YANMA ; 23
	const YANMEGA ; 24
	const BUNEARY ; 25
	const LOPUNNY ; 26
	const PIDGEOTTO ; 27
	const PIDGEOT ; 28
	const HOOTHOOT ; 29
	const NOCTOWL ; 2a
	const GOLBAT ; 2b
	const CROBAT ; 2c
	const URSARING ; 2d
	const URSALUNA ; 2e
	const URSALUNA_B ; 2f
	const PHANPY ; 30
	const DONPHAN ; 31
	const BELLSPROUT ; 32
	const WEEPINBELL ; 33
	const VICTREEBEL ; 34
	const FLAAFFY ; 35
	const AMPHAROS ; 36
	const MARILL ; 37
	const AZUMARILL ; 38
	const RHYDON ; 39
	const DRILBUR ; 3a
	const EXCADRILL ; 3b
	const ONIX ; 3c
	const STEELIX ; 3d
	const MAGIKARP ; 3e
	const GYARADOS ; 3f
	const HAUNTER ; 40
	const GENGAR ; 41
	const SWABLU ; 42
	const ALTARIA ; 43
	const SMEARGLE ; 44
	const HOUNDOUR ; 45
	const HOUNDOOM ; 46
	const WOOPER ; 47
	const QUAGSIRE ; 48
	const GLIGAR ; 49
	const GLISCOR ; 4a
	const GIBLE ; 4b
	const GABITE ; 4c
	const GARCHOMP ; 4d
	const MAKUHITA ; 4e
	const HARIYAMA ; 4f
	const DODUO ; 50
	const DODRIO ; 51
	const PONYTA ; 52
	const RAPIDASH ; 53
	const SLOWPOKE ; 54
	const SLOWBRO ; 55
	const SHROOMISH ; 56
	const BRELOOM ; 57
	const SPINARAK ; 58
	const ARIADOS ; 59
	const VENIPEDE ; 5a
	const WHIRLIPEDE ; 5b
	const SCOLIPEDE ; 5c
	const JOLTIK ; 5d
	const GALVANTULA ; 5e
	const SKORUPI ; 5f
	const DRAPION ; 60
	const LARVESTA ; 61
	const VOLCARONA ; 62
	const IRON_MOTH ; 63
	const TROPIUS ; 64
	const MANKEY ; 65
	const PRIMEAPE ; 66
	const ANNIHILAPE ; 67
	const FERROSEED ; 68
	const FERROTHORN ; 69
	const SCYTHER ; 6a
	const SCIZOR ; 6b
	const KLEAVOR ; 6c
	const HERACROSS ; 6d
	const TANGELA ; 6e
	const TANGROWTH ; 6f
	const MEOWTH ; 70
	const PERSIAN ; 71
	const SNUBBULL ; 72
	const GRANBULL ; 73
	const DROWZEE ; 74
	const HYPNO ; 75
	const MR__MIME ; 76
	const SUDOWOODO ; 77
	const KOFFING ; 78
	const WEEZING ; 79
	const GRIMER ; 7a
	const MUK ; 7b

	; second 101 pokemon
DEF JOHTO_POKEMON EQU const_value
	const LITWICK ; 7c
	const LAMPENT ; 7d
	const CHANDELURE ; 7e
	const MILTANK ; 7f
	const TAUROS ; 80
	const ELECTRODE ; 81
	const ELECTABUZZ ; 82
	const MAGNETON ; 83
	const MAGNEZONE ; 84
	const SHUCKLE ; 85
	const CORSOLA ; 86
	const STARYU ; 87
	const STARMIE ; 88
	const CHINCHOU ; 89
	const LANTURN ; 8a
	const TENTACOOL ; 8b
	const TENTACRUEL ; 8c
	const SEADRA ; 8d
	const KINGDRA ; 8e
	const LAPRAS ; 8f
	const CLEFAIRY ; 90
	const CLEFABLE ; 91
	const SOLROCK ; 92
	const LUNATONE ; 93
	const DELIBIRD ; 94
	const JYNX ; 95
	const SNORUNT ; 96
	const GLALIE ; 97
	const FROSLASS ; 98
	const PILOSWINE ; 99
	const MAMOSWINE ; 9a
	const SNEASEL ; 9b
	const WEAVILE ; 9c
	const SNEASLER ; 9d
	const SNOVER ; 9e
	const ABOMASNOW ; 9f
	const BALTOY ; a0
	const CLAYDOL ; a1
	const LUCARIO ; a2
	const BRONZOR ; a3
	const BRONZONG ; a4
	const SKARMORY ; a5
	const AGGRON ; a6
	const AEGISLASH ; a7
	const MISDREAVUS ; a8
	const MISMAGIUS ; a9
	const CHANSEY ; aa
	const BLISSEY ; ab
	const SNORLAX ; ac
	const TYRANITAR ; ad
	const SALAMENCE ; ae
	const METAGROSS ; af
	const HAXORUS ; b0
	const PORYGON ; b1
	const PORYGON2 ; b2
	const PORYGONZ ; b3
	const OMANYTE ; b4
	const OMASTAR ; b5
	const LILEEP ; b6
	const CRADILY ; b7
	const AERODACTYL ; b8
	const ROTOM ; b9
	const ABSOL ; ba
	const DURALUDON ; bb
	const GHOLDENGO ; bc
	const DARKRAI ; bd
	const ARTICUNO ; be
	const ZAPDOS ; bf
	const MOLTRES ; c0
	const LUGIA ; c1
	const RAIKOU ; c2
	const ENTEI ; c3
	const SUICUNE ; c4
	const HO_OH ; c5
	const UNOWN ; c6
	const NOWN ; c7
	const JIRACHI ; c8
	const CELEBI ; c9
	const DITTO ; ca
	const MEW ; cb
	const MEWTWO ; cc
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
