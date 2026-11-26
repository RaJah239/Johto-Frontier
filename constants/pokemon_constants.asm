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
	const SUNFLORA ; 25
	const BUNEARY ; 26
	const LOPUNNY ; 27
	const PIDGEY ; 28
	const PIDGEOTTO ; 29
	const PIDGEOT ; 2a
	const HOOTHOOT ; 2b
	const NOCTOWL ; 2c
	const ZUBAT ; 2d
	const GOLBAT ; 2e
	const CROBAT ; 2f
	const TEDDIURSA ; 30
	const URSARING ; 31
	const URSALUNA ; 32
	const URSALUNA_B ; 33
	const PHANPY ; 34
	const DONPHAN ; 35
	const BELLSPROUT ; 36
	const WEEPINBELL ; 37
	const VICTREEBEL ; 38
	const MAREEP ; 39
	const FLAAFFY ; 3a
	const AMPHAROS ; 3b
	const WIMPOD ; 3c
	const GOLISOPOD ; 3d
	const MARILL ; 3e
	const AZUMARILL ; 3f
	const RHYHORN ; 40
	const RHYDON ; 41
	const DRILBUR ; 42
	const EXCADRILL ; 43
	const ONIX ; 44
	const STEELIX ; 45
	const MAGIKARP ; 46
	const GYARADOS ; 47
	const GASTLY ; 48
	const HAUNTER ; 49
	const GENGAR ; 4a
	const SWABLU ; 4b
	const ALTARIA ; 4c
	const NATU ; 4d
	const KATU ; 4e
	const XATU ; 4f
	const SMEARGLE ; 50
	const GROWLITHE ; 51
	const ARCANINE ; 52
	const HOUNDOUR ; 53
	const HOUNDOOM ; 54
	const WOOPER ; 55
	const QUAGSIRE ; 56
	const GLIGAR ; 57
	const GLISCOR ; 58
	const GIBLE ; 59
	const GABITE ; 5a
	const GARCHOMP ; 5b
	const MAKUHITA ; 5c
	const HARIYAMA ; 5d
	const DODUO ; 5e
	const DODRIO ; 5f
	const PONYTA ; 60
	const RAPIDASH ; 61
	const SLOWPOKE ; 62
	const SLOWBRO ; 63
	const SHROOMISH ; 64
	const BRELOOM ; 65
	const SPINARAK ; 66
	const ARIADOS ; 67
	const VENIPEDE ; 68
	const WHIRLIPEDE ; 69
	const SCOLIPEDE ; 6a
	const JOLTIK ; 6b
	const GALVANTULA ; 6c
	const SKORUPI ; 6d
	const DRAPION ; 6e
	const LARVESTA ; 6f
	const VOLCARONA ; 70
	const IRON_MOTH ; 71
	const TROPIUS ; 72
	const MANKEY ; 73
	const PRIMEAPE ; 74
	const ANNIHILAPE ; 75
	const FERROSEED ; 76
	const FERROTHORN ; 77
	const SCYTHER ; 78
	const SCIZOR ; 79
	const KLEAVOR ; 7a
	const HERACROSS ; 7b
	const TANGELA ; 7c
	const TANGROWTH ; 7d
	const MEOWTH ; 7e
	const PERSIAN ; 7f
	const SNUBBULL ; 80
	const GRANBULL ; 81
	const DROWZEE ; 82
	const HYPNO ; 83
	const MR__MIME ; 84
	const SUDOWOODO ; 85
	const KOFFING ; 86
	const WEEZING ; 87
	const GRIMER ; 88
	const MUK ; 89

	; second 101 pokemon
DEF JOHTO_POKEMON EQU const_value
	const LITWICK ; 8a
	const LAMPENT ; 8b
	const CHANDELURE ; 8c
	const MILTANK ; 8d
	const TAUROS ; 8e
	const ELECTRODE ; 8f
	const ELECTABUZZ ; 90
	const MAGNETON ; 91
	const MAGNEZONE ; 92
	const SHUCKLE ; 93
	const CORSOLA ; 94
	const STARYU ; 95
	const STARMIE ; 96
	const CHINCHOU ; 97
	const LANTURN ; 98
	const TENTACOOL ; 99
	const TENTACRUEL ; 9a
	const SEADRA ; 9b
	const KINGDRA ; 9c
	const LAPRAS ; 9d
	const CLEFAIRY ; 9e
	const CLEFABLE ; 9f
	const SOLROCK ; a0
	const LUNATONE ; a1
	const DELIBIRD ; a2
	const JYNX ; a3
	const SNORUNT ; a4
	const GLALIE ; a5
	const FROSLASS ; a6
	const PILOSWINE ; a7
	const MAMOSWINE ; a8
	const SNEASEL ; a9
	const WEAVILE ; aa
	const SNEASLER ; ab
	const SNOVER ; ac
	const ABOMASNOW ; ad
	const BALTOY ; ae
	const CLAYDOL ; af
	const LUCARIO ; b0
	const BRONZOR ; b1
	const BRONZONG ; b2
	const SKARMORY ; b3
	const AGGRON ; b4
	const AEGISLASH ; b5
	const MISDREAVUS ; b6
	const MISMAGIUS ; b7
	const CHANSEY ; b8
	const BLISSEY ; b9
	const SNORLAX ; ba
	const TYRANITAR ; bb
	const SALAMENCE ; bc
	const METAGROSS ; bd
	const HAXORUS ; be
	const PORYGON ; bf
	const PORYGON2 ; c0
	const PORYGONZ ; c1
	const OMANYTE ; c2
	const OMASTAR ; c3
	const LILEEP ; c4
	const CRADILY ; c5
	const AERODACTYL ; c6
	const ROTOM ; c7
	const ABSOL ; c8
	const DURALUDON ; c9
	const GHOLDENGO ; ca
	const DARKRAI ; cb
	const ARTICUNO ; cc
	const ZAPDOS ; cd
	const MOLTRES ; ce
	const LUGIA ; cf
	const RAIKOU ; d0
	const ENTEI ; d1
	const SUICUNE ; d2
	const HO_OH ; d3
	const UNOWN ; d4
	const NOWN ; d5
	const JIRACHI ; d6
	const CELEBI ; d7
	const DITTO ; d8
	const MEW ; d9
	const MEWTWO ; da
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
