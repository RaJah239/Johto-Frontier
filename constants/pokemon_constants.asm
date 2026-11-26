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
	const HARIYAMA ; 4d
	const DODUO ; 4e
	const DODRIO ; 4f
	const PONYTA ; 50
	const RAPIDASH ; 51
	const SLOWPOKE ; 52
	const SLOWBRO ; 53
	const SHROOMISH ; 54
	const BRELOOM ; 55
	const SPINARAK ; 56
	const ARIADOS ; 57
	const VENIPEDE ; 58
	const WHIRLIPEDE ; 59
	const SCOLIPEDE ; 5a
	const JOLTIK ; 5b
	const GALVANTULA ; 5c
	const SKORUPI ; 5d
	const DRAPION ; 5e
	const LARVESTA ; 5f
	const VOLCARONA ; 60
	const IRON_MOTH ; 61
	const TROPIUS ; 62
	const MANKEY ; 63
	const PRIMEAPE ; 64
	const ANNIHILAPE ; 65
	const FERROSEED ; 66
	const FERROTHORN ; 67
	const SCYTHER ; 68
	const SCIZOR ; 69
	const KLEAVOR ; 6a
	const HERACROSS ; 6b
	const TANGELA ; 6c
	const TANGROWTH ; 6d
	const MEOWTH ; 6e
	const PERSIAN ; 6f
	const SNUBBULL ; 70
	const GRANBULL ; 71
	const DROWZEE ; 72
	const HYPNO ; 73
	const MR__MIME ; 74
	const SUDOWOODO ; 75
	const KOFFING ; 76
	const WEEZING ; 77
	const GRIMER ; 78
	const MUK ; 79

	; second 101 pokemon
DEF JOHTO_POKEMON EQU const_value
	const LITWICK ; 7a
	const LAMPENT ; 7b
	const CHANDELURE ; 7c
	const MILTANK ; 7d
	const TAUROS ; 7e
	const ELECTRODE ; 7f
	const ELECTABUZZ ; 80
	const MAGNETON ; 81
	const MAGNEZONE ; 82
	const SHUCKLE ; 83
	const CORSOLA ; 84
	const STARYU ; 85
	const STARMIE ; 86
	const CHINCHOU ; 87
	const LANTURN ; 88
	const TENTACOOL ; 89
	const TENTACRUEL ; 8a
	const SEADRA ; 8b
	const KINGDRA ; 8c
	const LAPRAS ; 8d
	const CLEFAIRY ; 8e
	const CLEFABLE ; 8f
	const SOLROCK ; 90
	const LUNATONE ; 91
	const DELIBIRD ; 92
	const JYNX ; 93
	const SNORUNT ; 94
	const GLALIE ; 95
	const FROSLASS ; 96
	const PILOSWINE ; 97
	const MAMOSWINE ; 98
	const SNEASEL ; 99
	const WEAVILE ; 9a
	const SNEASLER ; 9b
	const SNOVER ; 9c
	const ABOMASNOW ; 9d
	const BALTOY ; 9e
	const CLAYDOL ; 9f
	const LUCARIO ; a0
	const BRONZOR ; a1
	const BRONZONG ; a2
	const SKARMORY ; a3
	const AGGRON ; a4
	const AEGISLASH ; a5
	const MISDREAVUS ; a6
	const MISMAGIUS ; a7
	const CHANSEY ; a8
	const BLISSEY ; a9
	const SNORLAX ; aa
	const TYRANITAR ; ab
	const SALAMENCE ; ac
	const METAGROSS ; ad
	const HAXORUS ; ae
	const PORYGON ; af
	const PORYGON2 ; b0
	const PORYGONZ ; b1
	const OMANYTE ; b2
	const OMASTAR ; b3
	const LILEEP ; b4
	const CRADILY ; b5
	const AERODACTYL ; b6
	const ROTOM ; b7
	const ABSOL ; b8
	const DURALUDON ; b9
	const GHOLDENGO ; ba
	const DARKRAI ; bb
	const ARTICUNO ; bc
	const ZAPDOS ; bd
	const MOLTRES ; be
	const LUGIA ; bf
	const RAIKOU ; c0
	const ENTEI ; c1
	const SUICUNE ; c2
	const HO_OH ; c3
	const UNOWN ; c4
	const NOWN ; c5
	const JIRACHI ; c6
	const CELEBI ; c7
	const DITTO ; c8
	const MEW ; c9
	const MEWTWO ; ca
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
