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
	const PIDGEY ; 27
	const PIDGEOTTO ; 28
	const PIDGEOT ; 29
	const HOOTHOOT ; 2a
	const NOCTOWL ; 2b
	const ZUBAT ; 2c
	const GOLBAT ; 2d
	const CROBAT ; 2e
	const TEDDIURSA ; 2f
	const URSARING ; 30
	const URSALUNA ; 31
	const URSALUNA_B ; 32
	const PHANPY ; 33
	const DONPHAN ; 34
	const BELLSPROUT ; 35
	const WEEPINBELL ; 36
	const VICTREEBEL ; 37
	const MAREEP ; 38
	const FLAAFFY ; 39
	const AMPHAROS ; 3a
	const WIMPOD ; 3b
	const GOLISOPOD ; 3c
	const MARILL ; 3d
	const AZUMARILL ; 3e
	const RHYHORN ; 3f
	const RHYDON ; 40
	const DRILBUR ; 41
	const EXCADRILL ; 42
	const ONIX ; 43
	const STEELIX ; 44
	const MAGIKARP ; 45
	const GYARADOS ; 46
	const GASTLY ; 47
	const HAUNTER ; 48
	const GENGAR ; 49
	const SWABLU ; 4a
	const ALTARIA ; 4b
	const NATU ; 4c
	const KATU ; 4d
	const XATU ; 4e
	const SMEARGLE ; 4f
	const GROWLITHE ; 50
	const ARCANINE ; 51
	const HOUNDOUR ; 52
	const HOUNDOOM ; 53
	const WOOPER ; 54
	const QUAGSIRE ; 55
	const GLIGAR ; 56
	const GLISCOR ; 57
	const GIBLE ; 58
	const GABITE ; 59
	const GARCHOMP ; 5a
	const MAKUHITA ; 5b
	const HARIYAMA ; 5c
	const DODUO ; 5d
	const DODRIO ; 5e
	const PONYTA ; 5f
	const RAPIDASH ; 60
	const SLOWPOKE ; 61
	const SLOWBRO ; 62
	const SHROOMISH ; 63
	const BRELOOM ; 64
	const SPINARAK ; 65
	const ARIADOS ; 66
	const VENIPEDE ; 67
	const WHIRLIPEDE ; 68
	const SCOLIPEDE ; 69
	const JOLTIK ; 6a
	const GALVANTULA ; 6b
	const SKORUPI ; 6c
	const DRAPION ; 6d
	const LARVESTA ; 6e
	const VOLCARONA ; 6f
	const IRON_MOTH ; 70
	const TROPIUS ; 71
	const MANKEY ; 72
	const PRIMEAPE ; 73
	const ANNIHILAPE ; 74
	const FERROSEED ; 75
	const FERROTHORN ; 76
	const SCYTHER ; 77
	const SCIZOR ; 78
	const KLEAVOR ; 79
	const HERACROSS ; 7a
	const TANGELA ; 7b
	const TANGROWTH ; 7c
	const MEOWTH ; 7d
	const PERSIAN ; 7e
	const SNUBBULL ; 7f
	const GRANBULL ; 80
	const DROWZEE ; 81
	const HYPNO ; 82
	const MR__MIME ; 83
	const SUDOWOODO ; 84
	const KOFFING ; 85
	const WEEZING ; 86
	const GRIMER ; 87
	const MUK ; 88

	; second 101 pokemon
DEF JOHTO_POKEMON EQU const_value
	const LITWICK ; 89
	const LAMPENT ; 8a
	const CHANDELURE ; 8b
	const MILTANK ; 8c
	const TAUROS ; 8d
	const ELECTRODE ; 8e
	const ELECTABUZZ ; 8f
	const MAGNETON ; 90
	const MAGNEZONE ; 91
	const SHUCKLE ; 92
	const CORSOLA ; 93
	const STARYU ; 94
	const STARMIE ; 95
	const CHINCHOU ; 96
	const LANTURN ; 97
	const TENTACOOL ; 98
	const TENTACRUEL ; 99
	const SEADRA ; 9a
	const KINGDRA ; 9b
	const LAPRAS ; 9c
	const CLEFAIRY ; 9d
	const CLEFABLE ; 9e
	const SOLROCK ; 9f
	const LUNATONE ; a0
	const DELIBIRD ; a1
	const JYNX ; a2
	const SNORUNT ; a3
	const GLALIE ; a4
	const FROSLASS ; a5
	const PILOSWINE ; a6
	const MAMOSWINE ; a7
	const SNEASEL ; a8
	const WEAVILE ; a9
	const SNEASLER ; aa
	const SNOVER ; ab
	const ABOMASNOW ; ac
	const BALTOY ; ad
	const CLAYDOL ; ae
	const LUCARIO ; af
	const BRONZOR ; b0
	const BRONZONG ; b1
	const SKARMORY ; b2
	const AGGRON ; b3
	const AEGISLASH ; b4
	const MISDREAVUS ; b5
	const MISMAGIUS ; b6
	const CHANSEY ; b7
	const BLISSEY ; b8
	const SNORLAX ; b9
	const TYRANITAR ; ba
	const SALAMENCE ; bb
	const METAGROSS ; bc
	const HAXORUS ; bd
	const PORYGON ; be
	const PORYGON2 ; bf
	const PORYGONZ ; c0
	const OMANYTE ; c1
	const OMASTAR ; c2
	const LILEEP ; c3
	const CRADILY ; c4
	const AERODACTYL ; c5
	const ROTOM ; c6
	const ABSOL ; c7
	const DURALUDON ; c8
	const GHOLDENGO ; c9
	const DARKRAI ; ca
	const ARTICUNO ; cb
	const ZAPDOS ; cc
	const MOLTRES ; cd
	const LUGIA ; ce
	const RAIKOU ; cf
	const ENTEI ; d0
	const SUICUNE ; d1
	const HO_OH ; d2
	const UNOWN ; d3
	const NOWN ; d4
	const JIRACHI ; d5
	const CELEBI ; d6
	const DITTO ; d7
	const MEW ; d8
	const MEWTWO ; d9
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
