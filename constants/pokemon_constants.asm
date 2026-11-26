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
	const TROPIUS ; 60
	const MANKEY ; 61
	const PRIMEAPE ; 62
	const ANNIHILAPE ; 63
	const FERROSEED ; 64
	const FERROTHORN ; 65
	const SCYTHER ; 66
	const SCIZOR ; 67
	const KLEAVOR ; 68
	const HERACROSS ; 69
	const TANGELA ; 6a
	const TANGROWTH ; 6b
	const MEOWTH ; 6c
	const PERSIAN ; 6d
	const SNUBBULL ; 6e
	const GRANBULL ; 6f
	const DROWZEE ; 70
	const HYPNO ; 71
	const MR__MIME ; 72
	const SUDOWOODO ; 73
	const KOFFING ; 74
	const WEEZING ; 75
	const GRIMER ; 76
	const MUK ; 77

	; second 101 pokemon
DEF JOHTO_POKEMON EQU const_value
	const LITWICK ; 78
	const LAMPENT ; 79
	const CHANDELURE ; 7a
	const MILTANK ; 7b
	const TAUROS ; 7c
	const ELECTRODE ; 7d
	const ELECTABUZZ ; 7e
	const MAGNETON ; 7f
	const MAGNEZONE ; 80
	const SHUCKLE ; 81
	const CORSOLA ; 82
	const STARYU ; 83
	const STARMIE ; 84
	const CHINCHOU ; 85
	const LANTURN ; 86
	const TENTACOOL ; 87
	const TENTACRUEL ; 88
	const SEADRA ; 89
	const KINGDRA ; 8a
	const LAPRAS ; 8b
	const CLEFAIRY ; 8c
	const CLEFABLE ; 8d
	const SOLROCK ; 8e
	const LUNATONE ; 8f
	const DELIBIRD ; 90
	const JYNX ; 91
	const SNORUNT ; 92
	const GLALIE ; 93
	const FROSLASS ; 94
	const PILOSWINE ; 95
	const MAMOSWINE ; 96
	const SNEASEL ; 97
	const WEAVILE ; 98
	const SNEASLER ; 99
	const SNOVER ; 9a
	const ABOMASNOW ; 9b
	const BALTOY ; 9c
	const CLAYDOL ; 9d
	const LUCARIO ; 9e
	const BRONZOR ; 9f
	const BRONZONG ; a0
	const SKARMORY ; a1
	const AGGRON ; a2
	const AEGISLASH ; a3
	const MISDREAVUS ; a4
	const MISMAGIUS ; a5
	const CHANSEY ; a6
	const BLISSEY ; a7
	const SNORLAX ; a8
	const TYRANITAR ; a9
	const SALAMENCE ; aa
	const METAGROSS ; ab
	const HAXORUS ; ac
	const PORYGON ; ad
	const PORYGON2 ; ae
	const PORYGONZ ; af
	const OMANYTE ; b0
	const OMASTAR ; b1
	const LILEEP ; b2
	const CRADILY ; b3
	const AERODACTYL ; b4
	const ROTOM ; b5
	const ABSOL ; b6
	const DURALUDON ; b7
	const GHOLDENGO ; b8
	const DARKRAI ; b9
	const ARTICUNO ; ba
	const ZAPDOS ; bb
	const MOLTRES ; bc
	const LUGIA ; bd
	const RAIKOU ; be
	const ENTEI ; bf
	const SUICUNE ; c0
	const HO_OH ; c1
	const UNOWN ; c2
	const NOWN ; c3
	const JIRACHI ; c4
	const CELEBI ; c5
	const DITTO ; c6
	const MEW ; c7
	const MEWTWO ; c8
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
