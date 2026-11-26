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
	const ARCANINE ; 45
	const HOUNDOUR ; 46
	const HOUNDOOM ; 47
	const WOOPER ; 48
	const QUAGSIRE ; 49
	const GLIGAR ; 4a
	const GLISCOR ; 4b
	const GIBLE ; 4c
	const GABITE ; 4d
	const GARCHOMP ; 4e
	const MAKUHITA ; 4f
	const HARIYAMA ; 50
	const DODUO ; 51
	const DODRIO ; 52
	const PONYTA ; 53
	const RAPIDASH ; 54
	const SLOWPOKE ; 55
	const SLOWBRO ; 56
	const SHROOMISH ; 57
	const BRELOOM ; 58
	const SPINARAK ; 59
	const ARIADOS ; 5a
	const VENIPEDE ; 5b
	const WHIRLIPEDE ; 5c
	const SCOLIPEDE ; 5d
	const JOLTIK ; 5e
	const GALVANTULA ; 5f
	const SKORUPI ; 60
	const DRAPION ; 61
	const LARVESTA ; 62
	const VOLCARONA ; 63
	const IRON_MOTH ; 64
	const TROPIUS ; 65
	const MANKEY ; 66
	const PRIMEAPE ; 67
	const ANNIHILAPE ; 68
	const FERROSEED ; 69
	const FERROTHORN ; 6a
	const SCYTHER ; 6b
	const SCIZOR ; 6c
	const KLEAVOR ; 6d
	const HERACROSS ; 6e
	const TANGELA ; 6f
	const TANGROWTH ; 70
	const MEOWTH ; 71
	const PERSIAN ; 72
	const SNUBBULL ; 73
	const GRANBULL ; 74
	const DROWZEE ; 75
	const HYPNO ; 76
	const MR__MIME ; 77
	const SUDOWOODO ; 78
	const KOFFING ; 79
	const WEEZING ; 7a
	const GRIMER ; 7b
	const MUK ; 7c

	; second 101 pokemon
DEF JOHTO_POKEMON EQU const_value
	const LITWICK ; 7d
	const LAMPENT ; 7e
	const CHANDELURE ; 7f
	const MILTANK ; 80
	const TAUROS ; 81
	const ELECTRODE ; 82
	const ELECTABUZZ ; 83
	const MAGNETON ; 84
	const MAGNEZONE ; 85
	const SHUCKLE ; 86
	const CORSOLA ; 87
	const STARYU ; 88
	const STARMIE ; 89
	const CHINCHOU ; 8a
	const LANTURN ; 8b
	const TENTACOOL ; 8c
	const TENTACRUEL ; 8d
	const SEADRA ; 8e
	const KINGDRA ; 8f
	const LAPRAS ; 90
	const CLEFAIRY ; 91
	const CLEFABLE ; 92
	const SOLROCK ; 93
	const LUNATONE ; 94
	const DELIBIRD ; 95
	const JYNX ; 96
	const SNORUNT ; 97
	const GLALIE ; 98
	const FROSLASS ; 99
	const PILOSWINE ; 9a
	const MAMOSWINE ; 9b
	const SNEASEL ; 9c
	const WEAVILE ; 9d
	const SNEASLER ; 9e
	const SNOVER ; 9f
	const ABOMASNOW ; a0
	const BALTOY ; a1
	const CLAYDOL ; a2
	const LUCARIO ; a3
	const BRONZOR ; a4
	const BRONZONG ; a5
	const SKARMORY ; a6
	const AGGRON ; a7
	const AEGISLASH ; a8
	const MISDREAVUS ; a9
	const MISMAGIUS ; aa
	const CHANSEY ; ab
	const BLISSEY ; ac
	const SNORLAX ; ad
	const TYRANITAR ; ae
	const SALAMENCE ; af
	const METAGROSS ; b0
	const HAXORUS ; b1
	const PORYGON ; b2
	const PORYGON2 ; b3
	const PORYGONZ ; b4
	const OMANYTE ; b5
	const OMASTAR ; b6
	const LILEEP ; b7
	const CRADILY ; b8
	const AERODACTYL ; b9
	const ROTOM ; ba
	const ABSOL ; bb
	const DURALUDON ; bc
	const GHOLDENGO ; bd
	const DARKRAI ; be
	const ARTICUNO ; bf
	const ZAPDOS ; c0
	const MOLTRES ; c1
	const LUGIA ; c2
	const RAIKOU ; c3
	const ENTEI ; c4
	const SUICUNE ; c5
	const HO_OH ; c6
	const UNOWN ; c7
	const NOWN ; c8
	const JIRACHI ; c9
	const CELEBI ; ca
	const DITTO ; cb
	const MEW ; cc
	const MEWTWO ; cd
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
