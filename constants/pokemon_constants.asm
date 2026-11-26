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
	const GABITE ; 4b
	const GARCHOMP ; 4c
	const MAKUHITA ; 4d
	const HARIYAMA ; 4e
	const DODUO ; 4f
	const DODRIO ; 50
	const PONYTA ; 51
	const RAPIDASH ; 52
	const SLOWPOKE ; 53
	const SLOWBRO ; 54
	const SHROOMISH ; 55
	const BRELOOM ; 56
	const SPINARAK ; 57
	const ARIADOS ; 58
	const VENIPEDE ; 59
	const WHIRLIPEDE ; 5a
	const SCOLIPEDE ; 5b
	const JOLTIK ; 5c
	const GALVANTULA ; 5d
	const SKORUPI ; 5e
	const DRAPION ; 5f
	const LARVESTA ; 60
	const VOLCARONA ; 61
	const IRON_MOTH ; 62
	const TROPIUS ; 63
	const MANKEY ; 64
	const PRIMEAPE ; 65
	const ANNIHILAPE ; 66
	const FERROSEED ; 67
	const FERROTHORN ; 68
	const SCYTHER ; 69
	const SCIZOR ; 6a
	const KLEAVOR ; 6b
	const HERACROSS ; 6c
	const TANGELA ; 6d
	const TANGROWTH ; 6e
	const MEOWTH ; 6f
	const PERSIAN ; 70
	const SNUBBULL ; 71
	const GRANBULL ; 72
	const DROWZEE ; 73
	const HYPNO ; 74
	const MR__MIME ; 75
	const SUDOWOODO ; 76
	const KOFFING ; 77
	const WEEZING ; 78
	const GRIMER ; 79
	const MUK ; 7a

	; second 101 pokemon
DEF JOHTO_POKEMON EQU const_value
	const LITWICK ; 7b
	const LAMPENT ; 7c
	const CHANDELURE ; 7d
	const MILTANK ; 7e
	const TAUROS ; 7f
	const ELECTRODE ; 80
	const ELECTABUZZ ; 81
	const MAGNETON ; 82
	const MAGNEZONE ; 83
	const SHUCKLE ; 84
	const CORSOLA ; 85
	const STARYU ; 86
	const STARMIE ; 87
	const CHINCHOU ; 88
	const LANTURN ; 89
	const TENTACOOL ; 8a
	const TENTACRUEL ; 8b
	const SEADRA ; 8c
	const KINGDRA ; 8d
	const LAPRAS ; 8e
	const CLEFAIRY ; 8f
	const CLEFABLE ; 90
	const SOLROCK ; 91
	const LUNATONE ; 92
	const DELIBIRD ; 93
	const JYNX ; 94
	const SNORUNT ; 95
	const GLALIE ; 96
	const FROSLASS ; 97
	const PILOSWINE ; 98
	const MAMOSWINE ; 99
	const SNEASEL ; 9a
	const WEAVILE ; 9b
	const SNEASLER ; 9c
	const SNOVER ; 9d
	const ABOMASNOW ; 9e
	const BALTOY ; 9f
	const CLAYDOL ; a0
	const LUCARIO ; a1
	const BRONZOR ; a2
	const BRONZONG ; a3
	const SKARMORY ; a4
	const AGGRON ; a5
	const AEGISLASH ; a6
	const MISDREAVUS ; a7
	const MISMAGIUS ; a8
	const CHANSEY ; a9
	const BLISSEY ; aa
	const SNORLAX ; ab
	const TYRANITAR ; ac
	const SALAMENCE ; ad
	const METAGROSS ; ae
	const HAXORUS ; af
	const PORYGON ; b0
	const PORYGON2 ; b1
	const PORYGONZ ; b2
	const OMANYTE ; b3
	const OMASTAR ; b4
	const LILEEP ; b5
	const CRADILY ; b6
	const AERODACTYL ; b7
	const ROTOM ; b8
	const ABSOL ; b9
	const DURALUDON ; ba
	const GHOLDENGO ; bb
	const DARKRAI ; bc
	const ARTICUNO ; bd
	const ZAPDOS ; be
	const MOLTRES ; bf
	const LUGIA ; c0
	const RAIKOU ; c1
	const ENTEI ; c2
	const SUICUNE ; c3
	const HO_OH ; c4
	const UNOWN ; c5
	const NOWN ; c6
	const JIRACHI ; c7
	const CELEBI ; c8
	const DITTO ; c9
	const MEW ; ca
	const MEWTWO ; cb
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
