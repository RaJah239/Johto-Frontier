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
	const IRON_MOTH ; 60
	const TROPIUS ; 61
	const MANKEY ; 62
	const PRIMEAPE ; 63
	const ANNIHILAPE ; 64
	const FERROSEED ; 65
	const FERROTHORN ; 66
	const SCYTHER ; 67
	const SCIZOR ; 68
	const KLEAVOR ; 69
	const HERACROSS ; 6a
	const TANGELA ; 6b
	const TANGROWTH ; 6c
	const MEOWTH ; 6d
	const PERSIAN ; 6e
	const SNUBBULL ; 6f
	const GRANBULL ; 70
	const DROWZEE ; 71
	const HYPNO ; 72
	const MR__MIME ; 73
	const SUDOWOODO ; 74
	const KOFFING ; 75
	const WEEZING ; 76
	const GRIMER ; 77
	const MUK ; 78

	; second 101 pokemon
DEF JOHTO_POKEMON EQU const_value
	const LITWICK ; 79
	const LAMPENT ; 7a
	const CHANDELURE ; 7b
	const MILTANK ; 7c
	const TAUROS ; 7d
	const ELECTRODE ; 7e
	const ELECTABUZZ ; 7f
	const MAGNETON ; 80
	const MAGNEZONE ; 81
	const SHUCKLE ; 82
	const CORSOLA ; 83
	const STARYU ; 84
	const STARMIE ; 85
	const CHINCHOU ; 86
	const LANTURN ; 87
	const TENTACOOL ; 88
	const TENTACRUEL ; 89
	const SEADRA ; 8a
	const KINGDRA ; 8b
	const LAPRAS ; 8c
	const CLEFAIRY ; 8d
	const CLEFABLE ; 8e
	const SOLROCK ; 8f
	const LUNATONE ; 90
	const DELIBIRD ; 91
	const JYNX ; 92
	const SNORUNT ; 93
	const GLALIE ; 94
	const FROSLASS ; 95
	const PILOSWINE ; 96
	const MAMOSWINE ; 97
	const SNEASEL ; 98
	const WEAVILE ; 99
	const SNEASLER ; 9a
	const SNOVER ; 9b
	const ABOMASNOW ; 9c
	const BALTOY ; 9d
	const CLAYDOL ; 9e
	const LUCARIO ; 9f
	const BRONZOR ; a0
	const BRONZONG ; a1
	const SKARMORY ; a2
	const AGGRON ; a3
	const AEGISLASH ; a4
	const MISDREAVUS ; a5
	const MISMAGIUS ; a6
	const CHANSEY ; a7
	const BLISSEY ; a8
	const SNORLAX ; a9
	const TYRANITAR ; aa
	const SALAMENCE ; ab
	const METAGROSS ; ac
	const HAXORUS ; ad
	const PORYGON ; ae
	const PORYGON2 ; af
	const PORYGONZ ; b0
	const OMANYTE ; b1
	const OMASTAR ; b2
	const LILEEP ; b3
	const CRADILY ; b4
	const AERODACTYL ; b5
	const ROTOM ; b6
	const ABSOL ; b7
	const DURALUDON ; b8
	const GHOLDENGO ; b9
	const DARKRAI ; ba
	const ARTICUNO ; bb
	const ZAPDOS ; bc
	const MOLTRES ; bd
	const LUGIA ; be
	const RAIKOU ; bf
	const ENTEI ; c0
	const SUICUNE ; c1
	const HO_OH ; c2
	const UNOWN ; c3
	const NOWN ; c4
	const JIRACHI ; c5
	const CELEBI ; c6
	const DITTO ; c7
	const MEW ; c8
	const MEWTWO ; c9
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
