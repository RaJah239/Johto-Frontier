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
	const KATU ; 44
	const XATU ; 45
	const SMEARGLE ; 46
	const GROWLITHE ; 47
	const ARCANINE ; 48
	const HOUNDOUR ; 49
	const HOUNDOOM ; 4a
	const WOOPER ; 4b
	const QUAGSIRE ; 4c
	const GLIGAR ; 4d
	const GLISCOR ; 4e
	const GIBLE ; 4f
	const GABITE ; 50
	const GARCHOMP ; 51
	const MAKUHITA ; 52
	const HARIYAMA ; 53
	const DODUO ; 54
	const DODRIO ; 55
	const PONYTA ; 56
	const RAPIDASH ; 57
	const SLOWPOKE ; 58
	const SLOWBRO ; 59
	const SHROOMISH ; 5a
	const BRELOOM ; 5b
	const SPINARAK ; 5c
	const ARIADOS ; 5d
	const VENIPEDE ; 5e
	const WHIRLIPEDE ; 5f
	const SCOLIPEDE ; 60
	const JOLTIK ; 61
	const GALVANTULA ; 62
	const SKORUPI ; 63
	const DRAPION ; 64
	const LARVESTA ; 65
	const VOLCARONA ; 66
	const IRON_MOTH ; 67
	const TROPIUS ; 68
	const MANKEY ; 69
	const PRIMEAPE ; 6a
	const ANNIHILAPE ; 6b
	const FERROSEED ; 6c
	const FERROTHORN ; 6d
	const SCYTHER ; 6e
	const SCIZOR ; 6f
	const KLEAVOR ; 70
	const HERACROSS ; 71
	const TANGELA ; 72
	const TANGROWTH ; 73
	const MEOWTH ; 74
	const PERSIAN ; 75
	const SNUBBULL ; 76
	const GRANBULL ; 77
	const DROWZEE ; 78
	const HYPNO ; 79
	const MR__MIME ; 7a
	const SUDOWOODO ; 7b
	const KOFFING ; 7c
	const WEEZING ; 7d
	const GRIMER ; 7e
	const MUK ; 7f

	; second 101 pokemon
DEF JOHTO_POKEMON EQU const_value
	const LITWICK ; 80
	const LAMPENT ; 81
	const CHANDELURE ; 82
	const MILTANK ; 83
	const TAUROS ; 84
	const ELECTRODE ; 85
	const ELECTABUZZ ; 86
	const MAGNETON ; 87
	const MAGNEZONE ; 88
	const SHUCKLE ; 89
	const CORSOLA ; 8a
	const STARYU ; 8b
	const STARMIE ; 8c
	const CHINCHOU ; 8d
	const LANTURN ; 8e
	const TENTACOOL ; 8f
	const TENTACRUEL ; 90
	const SEADRA ; 91
	const KINGDRA ; 92
	const LAPRAS ; 93
	const CLEFAIRY ; 94
	const CLEFABLE ; 95
	const SOLROCK ; 96
	const LUNATONE ; 97
	const DELIBIRD ; 98
	const JYNX ; 99
	const SNORUNT ; 9a
	const GLALIE ; 9b
	const FROSLASS ; 9c
	const PILOSWINE ; 9d
	const MAMOSWINE ; 9e
	const SNEASEL ; 9f
	const WEAVILE ; a0
	const SNEASLER ; a1
	const SNOVER ; a2
	const ABOMASNOW ; a3
	const BALTOY ; a4
	const CLAYDOL ; a5
	const LUCARIO ; a6
	const BRONZOR ; a7
	const BRONZONG ; a8
	const SKARMORY ; a9
	const AGGRON ; aa
	const AEGISLASH ; ab
	const MISDREAVUS ; ac
	const MISMAGIUS ; ad
	const CHANSEY ; ae
	const BLISSEY ; af
	const SNORLAX ; b0
	const TYRANITAR ; b1
	const SALAMENCE ; b2
	const METAGROSS ; b3
	const HAXORUS ; b4
	const PORYGON ; b5
	const PORYGON2 ; b6
	const PORYGONZ ; b7
	const OMANYTE ; b8
	const OMASTAR ; b9
	const LILEEP ; ba
	const CRADILY ; bb
	const AERODACTYL ; bc
	const ROTOM ; bd
	const ABSOL ; be
	const DURALUDON ; bf
	const GHOLDENGO ; c0
	const DARKRAI ; c1
	const ARTICUNO ; c2
	const ZAPDOS ; c3
	const MOLTRES ; c4
	const LUGIA ; c5
	const RAIKOU ; c6
	const ENTEI ; c7
	const SUICUNE ; c8
	const HO_OH ; c9
	const UNOWN ; ca
	const NOWN ; cb
	const JIRACHI ; cc
	const CELEBI ; cd
	const DITTO ; ce
	const MEW ; cf
	const MEWTWO ; d0
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
