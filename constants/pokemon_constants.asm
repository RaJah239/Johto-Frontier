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
	const XATU ; 44
	const SMEARGLE ; 45
	const GROWLITHE ; 46
	const ARCANINE ; 47
	const HOUNDOUR ; 48
	const HOUNDOOM ; 49
	const WOOPER ; 4a
	const QUAGSIRE ; 4b
	const GLIGAR ; 4c
	const GLISCOR ; 4d
	const GIBLE ; 4e
	const GABITE ; 4f
	const GARCHOMP ; 50
	const MAKUHITA ; 51
	const HARIYAMA ; 52
	const DODUO ; 53
	const DODRIO ; 54
	const PONYTA ; 55
	const RAPIDASH ; 56
	const SLOWPOKE ; 57
	const SLOWBRO ; 58
	const SHROOMISH ; 59
	const BRELOOM ; 5a
	const SPINARAK ; 5b
	const ARIADOS ; 5c
	const VENIPEDE ; 5d
	const WHIRLIPEDE ; 5e
	const SCOLIPEDE ; 5f
	const JOLTIK ; 60
	const GALVANTULA ; 61
	const SKORUPI ; 62
	const DRAPION ; 63
	const LARVESTA ; 64
	const VOLCARONA ; 65
	const IRON_MOTH ; 66
	const TROPIUS ; 67
	const MANKEY ; 68
	const PRIMEAPE ; 69
	const ANNIHILAPE ; 6a
	const FERROSEED ; 6b
	const FERROTHORN ; 6c
	const SCYTHER ; 6d
	const SCIZOR ; 6e
	const KLEAVOR ; 6f
	const HERACROSS ; 70
	const TANGELA ; 71
	const TANGROWTH ; 72
	const MEOWTH ; 73
	const PERSIAN ; 74
	const SNUBBULL ; 75
	const GRANBULL ; 76
	const DROWZEE ; 77
	const HYPNO ; 78
	const MR__MIME ; 79
	const SUDOWOODO ; 7a
	const KOFFING ; 7b
	const WEEZING ; 7c
	const GRIMER ; 7d
	const MUK ; 7e

	; second 101 pokemon
DEF JOHTO_POKEMON EQU const_value
	const LITWICK ; 7f
	const LAMPENT ; 80
	const CHANDELURE ; 81
	const MILTANK ; 82
	const TAUROS ; 83
	const ELECTRODE ; 84
	const ELECTABUZZ ; 85
	const MAGNETON ; 86
	const MAGNEZONE ; 87
	const SHUCKLE ; 88
	const CORSOLA ; 89
	const STARYU ; 8a
	const STARMIE ; 8b
	const CHINCHOU ; 8c
	const LANTURN ; 8d
	const TENTACOOL ; 8e
	const TENTACRUEL ; 8f
	const SEADRA ; 90
	const KINGDRA ; 91
	const LAPRAS ; 92
	const CLEFAIRY ; 93
	const CLEFABLE ; 94
	const SOLROCK ; 95
	const LUNATONE ; 96
	const DELIBIRD ; 97
	const JYNX ; 98
	const SNORUNT ; 99
	const GLALIE ; 9a
	const FROSLASS ; 9b
	const PILOSWINE ; 9c
	const MAMOSWINE ; 9d
	const SNEASEL ; 9e
	const WEAVILE ; 9f
	const SNEASLER ; a0
	const SNOVER ; a1
	const ABOMASNOW ; a2
	const BALTOY ; a3
	const CLAYDOL ; a4
	const LUCARIO ; a5
	const BRONZOR ; a6
	const BRONZONG ; a7
	const SKARMORY ; a8
	const AGGRON ; a9
	const AEGISLASH ; aa
	const MISDREAVUS ; ab
	const MISMAGIUS ; ac
	const CHANSEY ; ad
	const BLISSEY ; ae
	const SNORLAX ; af
	const TYRANITAR ; b0
	const SALAMENCE ; b1
	const METAGROSS ; b2
	const HAXORUS ; b3
	const PORYGON ; b4
	const PORYGON2 ; b5
	const PORYGONZ ; b6
	const OMANYTE ; b7
	const OMASTAR ; b8
	const LILEEP ; b9
	const CRADILY ; ba
	const AERODACTYL ; bb
	const ROTOM ; bc
	const ABSOL ; bd
	const DURALUDON ; be
	const GHOLDENGO ; bf
	const DARKRAI ; c0
	const ARTICUNO ; c1
	const ZAPDOS ; c2
	const MOLTRES ; c3
	const LUGIA ; c4
	const RAIKOU ; c5
	const ENTEI ; c6
	const SUICUNE ; c7
	const HO_OH ; c8
	const UNOWN ; c9
	const NOWN ; ca
	const JIRACHI ; cb
	const CELEBI ; cc
	const DITTO ; cd
	const MEW ; ce
	const MEWTWO ; cf
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
