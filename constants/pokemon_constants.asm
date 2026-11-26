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
	const GROWLITHE ; 45
	const ARCANINE ; 46
	const HOUNDOUR ; 47
	const HOUNDOOM ; 48
	const WOOPER ; 49
	const QUAGSIRE ; 4a
	const GLIGAR ; 4b
	const GLISCOR ; 4c
	const GIBLE ; 4d
	const GABITE ; 4e
	const GARCHOMP ; 4f
	const MAKUHITA ; 50
	const HARIYAMA ; 51
	const DODUO ; 52
	const DODRIO ; 53
	const PONYTA ; 54
	const RAPIDASH ; 55
	const SLOWPOKE ; 56
	const SLOWBRO ; 57
	const SHROOMISH ; 58
	const BRELOOM ; 59
	const SPINARAK ; 5a
	const ARIADOS ; 5b
	const VENIPEDE ; 5c
	const WHIRLIPEDE ; 5d
	const SCOLIPEDE ; 5e
	const JOLTIK ; 5f
	const GALVANTULA ; 60
	const SKORUPI ; 61
	const DRAPION ; 62
	const LARVESTA ; 63
	const VOLCARONA ; 64
	const IRON_MOTH ; 65
	const TROPIUS ; 66
	const MANKEY ; 67
	const PRIMEAPE ; 68
	const ANNIHILAPE ; 69
	const FERROSEED ; 6a
	const FERROTHORN ; 6b
	const SCYTHER ; 6c
	const SCIZOR ; 6d
	const KLEAVOR ; 6e
	const HERACROSS ; 6f
	const TANGELA ; 70
	const TANGROWTH ; 71
	const MEOWTH ; 72
	const PERSIAN ; 73
	const SNUBBULL ; 74
	const GRANBULL ; 75
	const DROWZEE ; 76
	const HYPNO ; 77
	const MR__MIME ; 78
	const SUDOWOODO ; 79
	const KOFFING ; 7a
	const WEEZING ; 7b
	const GRIMER ; 7c
	const MUK ; 7d

	; second 101 pokemon
DEF JOHTO_POKEMON EQU const_value
	const LITWICK ; 7e
	const LAMPENT ; 7f
	const CHANDELURE ; 80
	const MILTANK ; 81
	const TAUROS ; 82
	const ELECTRODE ; 83
	const ELECTABUZZ ; 84
	const MAGNETON ; 85
	const MAGNEZONE ; 86
	const SHUCKLE ; 87
	const CORSOLA ; 88
	const STARYU ; 89
	const STARMIE ; 8a
	const CHINCHOU ; 8b
	const LANTURN ; 8c
	const TENTACOOL ; 8d
	const TENTACRUEL ; 8e
	const SEADRA ; 8f
	const KINGDRA ; 90
	const LAPRAS ; 91
	const CLEFAIRY ; 92
	const CLEFABLE ; 93
	const SOLROCK ; 94
	const LUNATONE ; 95
	const DELIBIRD ; 96
	const JYNX ; 97
	const SNORUNT ; 98
	const GLALIE ; 99
	const FROSLASS ; 9a
	const PILOSWINE ; 9b
	const MAMOSWINE ; 9c
	const SNEASEL ; 9d
	const WEAVILE ; 9e
	const SNEASLER ; 9f
	const SNOVER ; a0
	const ABOMASNOW ; a1
	const BALTOY ; a2
	const CLAYDOL ; a3
	const LUCARIO ; a4
	const BRONZOR ; a5
	const BRONZONG ; a6
	const SKARMORY ; a7
	const AGGRON ; a8
	const AEGISLASH ; a9
	const MISDREAVUS ; aa
	const MISMAGIUS ; ab
	const CHANSEY ; ac
	const BLISSEY ; ad
	const SNORLAX ; ae
	const TYRANITAR ; af
	const SALAMENCE ; b0
	const METAGROSS ; b1
	const HAXORUS ; b2
	const PORYGON ; b3
	const PORYGON2 ; b4
	const PORYGONZ ; b5
	const OMANYTE ; b6
	const OMASTAR ; b7
	const LILEEP ; b8
	const CRADILY ; b9
	const AERODACTYL ; ba
	const ROTOM ; bb
	const ABSOL ; bc
	const DURALUDON ; bd
	const GHOLDENGO ; be
	const DARKRAI ; bf
	const ARTICUNO ; c0
	const ZAPDOS ; c1
	const MOLTRES ; c2
	const LUGIA ; c3
	const RAIKOU ; c4
	const ENTEI ; c5
	const SUICUNE ; c6
	const HO_OH ; c7
	const UNOWN ; c8
	const NOWN ; c9
	const JIRACHI ; ca
	const CELEBI ; cb
	const DITTO ; cc
	const MEW ; cd
	const MEWTWO ; ce
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
