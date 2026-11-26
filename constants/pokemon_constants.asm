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
	const TEDDIURSA ; 2d
	const URSARING ; 2e
	const URSALUNA ; 2f
	const URSALUNA_B ; 30
	const PHANPY ; 31
	const DONPHAN ; 32
	const BELLSPROUT ; 33
	const WEEPINBELL ; 34
	const VICTREEBEL ; 35
	const MAREEP ; 36
	const FLAAFFY ; 37
	const AMPHAROS ; 38
	const WIMPOD ; 39
	const GOLISOPOD ; 3a
	const MARILL ; 3b
	const AZUMARILL ; 3c
	const RHYHORN ; 3d
	const RHYDON ; 3e
	const DRILBUR ; 3f
	const EXCADRILL ; 40
	const ONIX ; 41
	const STEELIX ; 42
	const MAGIKARP ; 43
	const GYARADOS ; 44
	const GASTLY ; 45
	const HAUNTER ; 46
	const GENGAR ; 47
	const SWABLU ; 48
	const ALTARIA ; 49
	const NATU ; 4a
	const KATU ; 4b
	const XATU ; 4c
	const SMEARGLE ; 4d
	const GROWLITHE ; 4e
	const ARCANINE ; 4f
	const HOUNDOUR ; 50
	const HOUNDOOM ; 51
	const WOOPER ; 52
	const QUAGSIRE ; 53
	const GLIGAR ; 54
	const GLISCOR ; 55
	const GIBLE ; 56
	const GABITE ; 57
	const GARCHOMP ; 58
	const MAKUHITA ; 59
	const HARIYAMA ; 5a
	const DODUO ; 5b
	const DODRIO ; 5c
	const PONYTA ; 5d
	const RAPIDASH ; 5e
	const SLOWPOKE ; 5f
	const SLOWBRO ; 60
	const SHROOMISH ; 61
	const BRELOOM ; 62
	const SPINARAK ; 63
	const ARIADOS ; 64
	const VENIPEDE ; 65
	const WHIRLIPEDE ; 66
	const SCOLIPEDE ; 67
	const JOLTIK ; 68
	const GALVANTULA ; 69
	const SKORUPI ; 6a
	const DRAPION ; 6b
	const LARVESTA ; 6c
	const VOLCARONA ; 6d
	const IRON_MOTH ; 6e
	const TROPIUS ; 6f
	const MANKEY ; 70
	const PRIMEAPE ; 71
	const ANNIHILAPE ; 72
	const FERROSEED ; 73
	const FERROTHORN ; 74
	const SCYTHER ; 75
	const SCIZOR ; 76
	const KLEAVOR ; 77
	const HERACROSS ; 78
	const TANGELA ; 79
	const TANGROWTH ; 7a
	const MEOWTH ; 7b
	const PERSIAN ; 7c
	const SNUBBULL ; 7d
	const GRANBULL ; 7e
	const DROWZEE ; 7f
	const HYPNO ; 80
	const MR__MIME ; 81
	const SUDOWOODO ; 82
	const KOFFING ; 83
	const WEEZING ; 84
	const GRIMER ; 85
	const MUK ; 86

	; second 101 pokemon
DEF JOHTO_POKEMON EQU const_value
	const LITWICK ; 87
	const LAMPENT ; 88
	const CHANDELURE ; 89
	const MILTANK ; 8a
	const TAUROS ; 8b
	const ELECTRODE ; 8c
	const ELECTABUZZ ; 8d
	const MAGNETON ; 8e
	const MAGNEZONE ; 8f
	const SHUCKLE ; 90
	const CORSOLA ; 91
	const STARYU ; 92
	const STARMIE ; 93
	const CHINCHOU ; 94
	const LANTURN ; 95
	const TENTACOOL ; 96
	const TENTACRUEL ; 97
	const SEADRA ; 98
	const KINGDRA ; 99
	const LAPRAS ; 9a
	const CLEFAIRY ; 9b
	const CLEFABLE ; 9c
	const SOLROCK ; 9d
	const LUNATONE ; 9e
	const DELIBIRD ; 9f
	const JYNX ; a0
	const SNORUNT ; a1
	const GLALIE ; a2
	const FROSLASS ; a3
	const PILOSWINE ; a4
	const MAMOSWINE ; a5
	const SNEASEL ; a6
	const WEAVILE ; a7
	const SNEASLER ; a8
	const SNOVER ; a9
	const ABOMASNOW ; aa
	const BALTOY ; ab
	const CLAYDOL ; ac
	const LUCARIO ; ad
	const BRONZOR ; ae
	const BRONZONG ; af
	const SKARMORY ; b0
	const AGGRON ; b1
	const AEGISLASH ; b2
	const MISDREAVUS ; b3
	const MISMAGIUS ; b4
	const CHANSEY ; b5
	const BLISSEY ; b6
	const SNORLAX ; b7
	const TYRANITAR ; b8
	const SALAMENCE ; b9
	const METAGROSS ; ba
	const HAXORUS ; bb
	const PORYGON ; bc
	const PORYGON2 ; bd
	const PORYGONZ ; be
	const OMANYTE ; bf
	const OMASTAR ; c0
	const LILEEP ; c1
	const CRADILY ; c2
	const AERODACTYL ; c3
	const ROTOM ; c4
	const ABSOL ; c5
	const DURALUDON ; c6
	const GHOLDENGO ; c7
	const DARKRAI ; c8
	const ARTICUNO ; c9
	const ZAPDOS ; ca
	const MOLTRES ; cb
	const LUGIA ; cc
	const RAIKOU ; cd
	const ENTEI ; ce
	const SUICUNE ; cf
	const HO_OH ; d0
	const UNOWN ; d1
	const NOWN ; d2
	const JIRACHI ; d3
	const CELEBI ; d4
	const DITTO ; d5
	const MEW ; d6
	const MEWTWO ; d7
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
