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
	const ZUBAT ; 2b
	const GOLBAT ; 2c
	const CROBAT ; 2d
	const TEDDIURSA ; 2e
	const URSARING ; 2f
	const URSALUNA ; 30
	const URSALUNA_B ; 31
	const PHANPY ; 32
	const DONPHAN ; 33
	const BELLSPROUT ; 34
	const WEEPINBELL ; 35
	const VICTREEBEL ; 36
	const MAREEP ; 37
	const FLAAFFY ; 38
	const AMPHAROS ; 39
	const WIMPOD ; 3a
	const GOLISOPOD ; 3b
	const MARILL ; 3c
	const AZUMARILL ; 3d
	const RHYHORN ; 3e
	const RHYDON ; 3f
	const DRILBUR ; 40
	const EXCADRILL ; 41
	const ONIX ; 42
	const STEELIX ; 43
	const MAGIKARP ; 44
	const GYARADOS ; 45
	const GASTLY ; 46
	const HAUNTER ; 47
	const GENGAR ; 48
	const SWABLU ; 49
	const ALTARIA ; 4a
	const NATU ; 4b
	const KATU ; 4c
	const XATU ; 4d
	const SMEARGLE ; 4e
	const GROWLITHE ; 4f
	const ARCANINE ; 50
	const HOUNDOUR ; 51
	const HOUNDOOM ; 52
	const WOOPER ; 53
	const QUAGSIRE ; 54
	const GLIGAR ; 55
	const GLISCOR ; 56
	const GIBLE ; 57
	const GABITE ; 58
	const GARCHOMP ; 59
	const MAKUHITA ; 5a
	const HARIYAMA ; 5b
	const DODUO ; 5c
	const DODRIO ; 5d
	const PONYTA ; 5e
	const RAPIDASH ; 5f
	const SLOWPOKE ; 60
	const SLOWBRO ; 61
	const SHROOMISH ; 62
	const BRELOOM ; 63
	const SPINARAK ; 64
	const ARIADOS ; 65
	const VENIPEDE ; 66
	const WHIRLIPEDE ; 67
	const SCOLIPEDE ; 68
	const JOLTIK ; 69
	const GALVANTULA ; 6a
	const SKORUPI ; 6b
	const DRAPION ; 6c
	const LARVESTA ; 6d
	const VOLCARONA ; 6e
	const IRON_MOTH ; 6f
	const TROPIUS ; 70
	const MANKEY ; 71
	const PRIMEAPE ; 72
	const ANNIHILAPE ; 73
	const FERROSEED ; 74
	const FERROTHORN ; 75
	const SCYTHER ; 76
	const SCIZOR ; 77
	const KLEAVOR ; 78
	const HERACROSS ; 79
	const TANGELA ; 7a
	const TANGROWTH ; 7b
	const MEOWTH ; 7c
	const PERSIAN ; 7d
	const SNUBBULL ; 7e
	const GRANBULL ; 7f
	const DROWZEE ; 80
	const HYPNO ; 81
	const MR__MIME ; 82
	const SUDOWOODO ; 83
	const KOFFING ; 84
	const WEEZING ; 85
	const GRIMER ; 86
	const MUK ; 87

	; second 101 pokemon
DEF JOHTO_POKEMON EQU const_value
	const LITWICK ; 88
	const LAMPENT ; 89
	const CHANDELURE ; 8a
	const MILTANK ; 8b
	const TAUROS ; 8c
	const ELECTRODE ; 8d
	const ELECTABUZZ ; 8e
	const MAGNETON ; 8f
	const MAGNEZONE ; 90
	const SHUCKLE ; 91
	const CORSOLA ; 92
	const STARYU ; 93
	const STARMIE ; 94
	const CHINCHOU ; 95
	const LANTURN ; 96
	const TENTACOOL ; 97
	const TENTACRUEL ; 98
	const SEADRA ; 99
	const KINGDRA ; 9a
	const LAPRAS ; 9b
	const CLEFAIRY ; 9c
	const CLEFABLE ; 9d
	const SOLROCK ; 9e
	const LUNATONE ; 9f
	const DELIBIRD ; a0
	const JYNX ; a1
	const SNORUNT ; a2
	const GLALIE ; a3
	const FROSLASS ; a4
	const PILOSWINE ; a5
	const MAMOSWINE ; a6
	const SNEASEL ; a7
	const WEAVILE ; a8
	const SNEASLER ; a9
	const SNOVER ; aa
	const ABOMASNOW ; ab
	const BALTOY ; ac
	const CLAYDOL ; ad
	const LUCARIO ; ae
	const BRONZOR ; af
	const BRONZONG ; b0
	const SKARMORY ; b1
	const AGGRON ; b2
	const AEGISLASH ; b3
	const MISDREAVUS ; b4
	const MISMAGIUS ; b5
	const CHANSEY ; b6
	const BLISSEY ; b7
	const SNORLAX ; b8
	const TYRANITAR ; b9
	const SALAMENCE ; ba
	const METAGROSS ; bb
	const HAXORUS ; bc
	const PORYGON ; bd
	const PORYGON2 ; be
	const PORYGONZ ; bf
	const OMANYTE ; c0
	const OMASTAR ; c1
	const LILEEP ; c2
	const CRADILY ; c3
	const AERODACTYL ; c4
	const ROTOM ; c5
	const ABSOL ; c6
	const DURALUDON ; c7
	const GHOLDENGO ; c8
	const DARKRAI ; c9
	const ARTICUNO ; ca
	const ZAPDOS ; cb
	const MOLTRES ; cc
	const LUGIA ; cd
	const RAIKOU ; ce
	const ENTEI ; cf
	const SUICUNE ; d0
	const HO_OH ; d1
	const UNOWN ; d2
	const NOWN ; d3
	const JIRACHI ; d4
	const CELEBI ; d5
	const DITTO ; d6
	const MEW ; d7
	const MEWTWO ; d8
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
