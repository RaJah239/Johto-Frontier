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
	const MAREEP ; 35
	const FLAAFFY ; 36
	const AMPHAROS ; 37
	const WIMPOD ; 38
	const GOLISOPOD ; 39
	const MARILL ; 3a
	const AZUMARILL ; 3b
	const RHYHORN ; 3c
	const RHYDON ; 3d
	const DRILBUR ; 3e
	const EXCADRILL ; 3f
	const ONIX ; 40
	const STEELIX ; 41
	const MAGIKARP ; 42
	const GYARADOS ; 43
	const GASTLY ; 44
	const HAUNTER ; 45
	const GENGAR ; 46
	const SWABLU ; 47
	const ALTARIA ; 48
	const NATU ; 49
	const KATU ; 4a
	const XATU ; 4b
	const SMEARGLE ; 4c
	const GROWLITHE ; 4d
	const ARCANINE ; 4e
	const HOUNDOUR ; 4f
	const HOUNDOOM ; 50
	const WOOPER ; 51
	const QUAGSIRE ; 52
	const GLIGAR ; 53
	const GLISCOR ; 54
	const GIBLE ; 55
	const GABITE ; 56
	const GARCHOMP ; 57
	const MAKUHITA ; 58
	const HARIYAMA ; 59
	const DODUO ; 5a
	const DODRIO ; 5b
	const PONYTA ; 5c
	const RAPIDASH ; 5d
	const SLOWPOKE ; 5e
	const SLOWBRO ; 5f
	const SHROOMISH ; 60
	const BRELOOM ; 61
	const SPINARAK ; 62
	const ARIADOS ; 63
	const VENIPEDE ; 64
	const WHIRLIPEDE ; 65
	const SCOLIPEDE ; 66
	const JOLTIK ; 67
	const GALVANTULA ; 68
	const SKORUPI ; 69
	const DRAPION ; 6a
	const LARVESTA ; 6b
	const VOLCARONA ; 6c
	const IRON_MOTH ; 6d
	const TROPIUS ; 6e
	const MANKEY ; 6f
	const PRIMEAPE ; 70
	const ANNIHILAPE ; 71
	const FERROSEED ; 72
	const FERROTHORN ; 73
	const SCYTHER ; 74
	const SCIZOR ; 75
	const KLEAVOR ; 76
	const HERACROSS ; 77
	const TANGELA ; 78
	const TANGROWTH ; 79
	const MEOWTH ; 7a
	const PERSIAN ; 7b
	const SNUBBULL ; 7c
	const GRANBULL ; 7d
	const DROWZEE ; 7e
	const HYPNO ; 7f
	const MR__MIME ; 80
	const SUDOWOODO ; 81
	const KOFFING ; 82
	const WEEZING ; 83
	const GRIMER ; 84
	const MUK ; 85

	; second 101 pokemon
DEF JOHTO_POKEMON EQU const_value
	const LITWICK ; 86
	const LAMPENT ; 87
	const CHANDELURE ; 88
	const MILTANK ; 89
	const TAUROS ; 8a
	const ELECTRODE ; 8b
	const ELECTABUZZ ; 8c
	const MAGNETON ; 8d
	const MAGNEZONE ; 8e
	const SHUCKLE ; 8f
	const CORSOLA ; 90
	const STARYU ; 91
	const STARMIE ; 92
	const CHINCHOU ; 93
	const LANTURN ; 94
	const TENTACOOL ; 95
	const TENTACRUEL ; 96
	const SEADRA ; 97
	const KINGDRA ; 98
	const LAPRAS ; 99
	const CLEFAIRY ; 9a
	const CLEFABLE ; 9b
	const SOLROCK ; 9c
	const LUNATONE ; 9d
	const DELIBIRD ; 9e
	const JYNX ; 9f
	const SNORUNT ; a0
	const GLALIE ; a1
	const FROSLASS ; a2
	const PILOSWINE ; a3
	const MAMOSWINE ; a4
	const SNEASEL ; a5
	const WEAVILE ; a6
	const SNEASLER ; a7
	const SNOVER ; a8
	const ABOMASNOW ; a9
	const BALTOY ; aa
	const CLAYDOL ; ab
	const LUCARIO ; ac
	const BRONZOR ; ad
	const BRONZONG ; ae
	const SKARMORY ; af
	const AGGRON ; b0
	const AEGISLASH ; b1
	const MISDREAVUS ; b2
	const MISMAGIUS ; b3
	const CHANSEY ; b4
	const BLISSEY ; b5
	const SNORLAX ; b6
	const TYRANITAR ; b7
	const SALAMENCE ; b8
	const METAGROSS ; b9
	const HAXORUS ; ba
	const PORYGON ; bb
	const PORYGON2 ; bc
	const PORYGONZ ; bd
	const OMANYTE ; be
	const OMASTAR ; bf
	const LILEEP ; c0
	const CRADILY ; c1
	const AERODACTYL ; c2
	const ROTOM ; c3
	const ABSOL ; c4
	const DURALUDON ; c5
	const GHOLDENGO ; c6
	const DARKRAI ; c7
	const ARTICUNO ; c8
	const ZAPDOS ; c9
	const MOLTRES ; ca
	const LUGIA ; cb
	const RAIKOU ; cc
	const ENTEI ; cd
	const SUICUNE ; ce
	const HO_OH ; cf
	const UNOWN ; d0
	const NOWN ; d1
	const JIRACHI ; d2
	const CELEBI ; d3
	const DITTO ; d4
	const MEW ; d5
	const MEWTWO ; d6
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
