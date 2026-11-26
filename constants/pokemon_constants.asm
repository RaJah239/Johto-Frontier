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
	const DODUO ; 4d
	const DODRIO ; 4e
	const PONYTA ; 4f
	const RAPIDASH ; 50
	const SLOWPOKE ; 51
	const SLOWBRO ; 52
	const SHROOMISH ; 53
	const BRELOOM ; 54
	const SPINARAK ; 55
	const ARIADOS ; 56
	const VENIPEDE ; 57
	const WHIRLIPEDE ; 58
	const SCOLIPEDE ; 59
	const JOLTIK ; 5a
	const GALVANTULA ; 5b
	const SKORUPI ; 5c
	const DRAPION ; 5d
	const LARVESTA ; 5e
	const VOLCARONA ; 5f
	const MANKEY ; 60
	const PRIMEAPE ; 61
	const ANNIHILAPE ; 62
	const FERROSEED ; 63
	const FERROTHORN ; 64
	const SCYTHER ; 65
	const SCIZOR ; 66
	const KLEAVOR ; 67
	const HERACROSS ; 68
	const TANGELA ; 69
	const TANGROWTH ; 6a
	const MEOWTH ; 6b
	const PERSIAN ; 6c
	const SNUBBULL ; 6d
	const GRANBULL ; 6e
	const DROWZEE ; 6f
	const HYPNO ; 70
	const MR__MIME ; 71
	const SUDOWOODO ; 72
	const KOFFING ; 73
	const WEEZING ; 74
	const GRIMER ; 75
	const MUK ; 76

	; second 101 pokemon
DEF JOHTO_POKEMON EQU const_value
	const LITWICK ; 77
	const LAMPENT ; 78
	const CHANDELURE ; 79
	const MILTANK ; 7a
	const TAUROS ; 7b
	const ELECTABUZZ ; 7c
	const MAGNETON ; 7d
	const MAGNEZONE ; 7e
	const SHUCKLE ; 7f
	const CORSOLA ; 80
	const STARYU ; 81
	const STARMIE ; 82
	const CHINCHOU ; 83
	const LANTURN ; 84
	const TENTACOOL ; 85
	const TENTACRUEL ; 86
	const SEADRA ; 87
	const KINGDRA ; 88
	const LAPRAS ; 89
	const CLEFAIRY ; 8a
	const CLEFABLE ; 8b
	const SOLROCK ; 8c
	const LUNATONE ; 8d
	const DELIBIRD ; 8e
	const JYNX ; 8f
	const SNORUNT ; 90
	const GLALIE ; 91
	const FROSLASS ; 92
	const PILOSWINE ; 93
	const MAMOSWINE ; 94
	const SNEASEL ; 95
	const WEAVILE ; 96
	const SNEASLER ; 97
	const SNOVER ; 98
	const ABOMASNOW ; 99
	const BALTOY ; 9a
	const CLAYDOL ; 9b
	const LUCARIO ; 9c
	const BRONZOR ; 9d
	const BRONZONG ; 9e
	const SKARMORY ; 9f
	const AGGRON ; a0
	const AEGISLASH ; a1
	const MISDREAVUS ; a2
	const MISMAGIUS ; a3
	const CHANSEY ; a4
	const BLISSEY ; a5
	const SNORLAX ; a6
	const TYRANITAR ; a7
	const SALAMENCE ; a8
	const METAGROSS ; a9
	const HAXORUS ; aa
	const PORYGON ; ab
	const PORYGON2 ; ac
	const PORYGONZ ; ad
	const OMANYTE ; ae
	const OMASTAR ; af
	const LILEEP ; b0
	const CRADILY ; b1
	const AERODACTYL ; b2
	const ROTOM ; b3
	const ABSOL ; b4
	const DURALUDON ; b5
	const GHOLDENGO ; b6
	const DARKRAI ; b7
	const ARTICUNO ; b8
	const ZAPDOS ; b9
	const MOLTRES ; ba
	const LUGIA ; bb
	const RAIKOU ; bc
	const ENTEI ; bd
	const SUICUNE ; be
	const HO_OH ; bf
	const UNOWN ; c0
	const NOWN ; c1
	const JIRACHI ; c2
	const CELEBI ; c3
	const DITTO ; c4
	const MEW ; c5
	const MEWTWO ; c6
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
