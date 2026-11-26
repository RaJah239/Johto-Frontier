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
	const NATU ; 44
	const KATU ; 45
	const XATU ; 46
	const SMEARGLE ; 47
	const GROWLITHE ; 48
	const ARCANINE ; 49
	const HOUNDOUR ; 4a
	const HOUNDOOM ; 4b
	const WOOPER ; 4c
	const QUAGSIRE ; 4d
	const GLIGAR ; 4e
	const GLISCOR ; 4f
	const GIBLE ; 50
	const GABITE ; 51
	const GARCHOMP ; 52
	const MAKUHITA ; 53
	const HARIYAMA ; 54
	const DODUO ; 55
	const DODRIO ; 56
	const PONYTA ; 57
	const RAPIDASH ; 58
	const SLOWPOKE ; 59
	const SLOWBRO ; 5a
	const SHROOMISH ; 5b
	const BRELOOM ; 5c
	const SPINARAK ; 5d
	const ARIADOS ; 5e
	const VENIPEDE ; 5f
	const WHIRLIPEDE ; 60
	const SCOLIPEDE ; 61
	const JOLTIK ; 62
	const GALVANTULA ; 63
	const SKORUPI ; 64
	const DRAPION ; 65
	const LARVESTA ; 66
	const VOLCARONA ; 67
	const IRON_MOTH ; 68
	const TROPIUS ; 69
	const MANKEY ; 6a
	const PRIMEAPE ; 6b
	const ANNIHILAPE ; 6c
	const FERROSEED ; 6d
	const FERROTHORN ; 6e
	const SCYTHER ; 6f
	const SCIZOR ; 70
	const KLEAVOR ; 71
	const HERACROSS ; 72
	const TANGELA ; 73
	const TANGROWTH ; 74
	const MEOWTH ; 75
	const PERSIAN ; 76
	const SNUBBULL ; 77
	const GRANBULL ; 78
	const DROWZEE ; 79
	const HYPNO ; 7a
	const MR__MIME ; 7b
	const SUDOWOODO ; 7c
	const KOFFING ; 7d
	const WEEZING ; 7e
	const GRIMER ; 7f
	const MUK ; 80

	; second 101 pokemon
DEF JOHTO_POKEMON EQU const_value
	const LITWICK ; 81
	const LAMPENT ; 82
	const CHANDELURE ; 83
	const MILTANK ; 84
	const TAUROS ; 85
	const ELECTRODE ; 86
	const ELECTABUZZ ; 87
	const MAGNETON ; 88
	const MAGNEZONE ; 89
	const SHUCKLE ; 8a
	const CORSOLA ; 8b
	const STARYU ; 8c
	const STARMIE ; 8d
	const CHINCHOU ; 8e
	const LANTURN ; 8f
	const TENTACOOL ; 90
	const TENTACRUEL ; 91
	const SEADRA ; 92
	const KINGDRA ; 93
	const LAPRAS ; 94
	const CLEFAIRY ; 95
	const CLEFABLE ; 96
	const SOLROCK ; 97
	const LUNATONE ; 98
	const DELIBIRD ; 99
	const JYNX ; 9a
	const SNORUNT ; 9b
	const GLALIE ; 9c
	const FROSLASS ; 9d
	const PILOSWINE ; 9e
	const MAMOSWINE ; 9f
	const SNEASEL ; a0
	const WEAVILE ; a1
	const SNEASLER ; a2
	const SNOVER ; a3
	const ABOMASNOW ; a4
	const BALTOY ; a5
	const CLAYDOL ; a6
	const LUCARIO ; a7
	const BRONZOR ; a8
	const BRONZONG ; a9
	const SKARMORY ; aa
	const AGGRON ; ab
	const AEGISLASH ; ac
	const MISDREAVUS ; ad
	const MISMAGIUS ; ae
	const CHANSEY ; af
	const BLISSEY ; b0
	const SNORLAX ; b1
	const TYRANITAR ; b2
	const SALAMENCE ; b3
	const METAGROSS ; b4
	const HAXORUS ; b5
	const PORYGON ; b6
	const PORYGON2 ; b7
	const PORYGONZ ; b8
	const OMANYTE ; b9
	const OMASTAR ; ba
	const LILEEP ; bb
	const CRADILY ; bc
	const AERODACTYL ; bd
	const ROTOM ; be
	const ABSOL ; bf
	const DURALUDON ; c0
	const GHOLDENGO ; c1
	const DARKRAI ; c2
	const ARTICUNO ; c3
	const ZAPDOS ; c4
	const MOLTRES ; c5
	const LUGIA ; c6
	const RAIKOU ; c7
	const ENTEI ; c8
	const SUICUNE ; c9
	const HO_OH ; ca
	const UNOWN ; cb
	const NOWN ; cc
	const JIRACHI ; cd
	const CELEBI ; ce
	const DITTO ; cf
	const MEW ; d0
	const MEWTWO ; d1
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
