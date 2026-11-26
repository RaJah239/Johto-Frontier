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
	const SUNKERN ; 25
	const SUNFLORA ; 26
	const BUNEARY ; 27
	const LOPUNNY ; 28
	const PIDGEY ; 29
	const PIDGEOTTO ; 2a
	const PIDGEOT ; 2b
	const HOOTHOOT ; 2c
	const NOCTOWL ; 2d
	const ZUBAT ; 2e
	const GOLBAT ; 2f
	const CROBAT ; 30
	const TEDDIURSA ; 31
	const URSARING ; 32
	const URSALUNA ; 33
	const URSALUNA_B ; 34
	const PHANPY ; 35
	const DONPHAN ; 36
	const BELLSPROUT ; 37
	const WEEPINBELL ; 38
	const VICTREEBEL ; 39
	const MAREEP ; 3a
	const FLAAFFY ; 3b
	const AMPHAROS ; 3c
	const WIMPOD ; 3d
	const GOLISOPOD ; 3e
	const MARILL ; 3f
	const AZUMARILL ; 40
	const RHYHORN ; 41
	const RHYDON ; 42
	const DRILBUR ; 43
	const EXCADRILL ; 44
	const ONIX ; 45
	const STEELIX ; 46
	const MAGIKARP ; 47
	const GYARADOS ; 48
	const GASTLY ; 49
	const HAUNTER ; 4a
	const GENGAR ; 4b
	const SWABLU ; 4c
	const ALTARIA ; 4d
	const NATU ; 4e
	const KATU ; 4f
	const XATU ; 50
	const SMEARGLE ; 51
	const GROWLITHE ; 52
	const ARCANINE ; 53
	const HOUNDOUR ; 54
	const HOUNDOOM ; 55
	const WOOPER ; 56
	const QUAGSIRE ; 57
	const GLIGAR ; 58
	const GLISCOR ; 59
	const GIBLE ; 5a
	const GABITE ; 5b
	const GARCHOMP ; 5c
	const MAKUHITA ; 5d
	const HARIYAMA ; 5e
	const DODUO ; 5f
	const DODRIO ; 60
	const PONYTA ; 61
	const RAPIDASH ; 62
	const SLOWPOKE ; 63
	const SLOWBRO ; 64
	const SHROOMISH ; 65
	const BRELOOM ; 66
	const SPINARAK ; 67
	const ARIADOS ; 68
	const VENIPEDE ; 69
	const WHIRLIPEDE ; 6a
	const SCOLIPEDE ; 6b
	const JOLTIK ; 6c
	const GALVANTULA ; 6d
	const SKORUPI ; 6e
	const DRAPION ; 6f
	const LARVESTA ; 70
	const VOLCARONA ; 71
	const IRON_MOTH ; 72
	const TROPIUS ; 73
	const MANKEY ; 74
	const PRIMEAPE ; 75
	const ANNIHILAPE ; 76
	const FERROSEED ; 77
	const FERROTHORN ; 78
	const SCYTHER ; 79
	const SCIZOR ; 7a
	const KLEAVOR ; 7b
	const HERACROSS ; 7c
	const TANGELA ; 7d
	const TANGROWTH ; 7e
	const MEOWTH ; 7f
	const PERSIAN ; 80
	const SNUBBULL ; 81
	const GRANBULL ; 82
	const DROWZEE ; 83
	const HYPNO ; 84
	const MR__MIME ; 85
	const SUDOWOODO ; 86
	const KOFFING ; 87
	const WEEZING ; 88
	const GRIMER ; 89
	const MUK ; 8a

	; second 101 pokemon
DEF JOHTO_POKEMON EQU const_value
	const LITWICK ; 8b
	const LAMPENT ; 8c
	const CHANDELURE ; 8d
	const MILTANK ; 8e
	const TAUROS ; 8f
	const ELECTRODE ; 90
	const ELECTABUZZ ; 91
	const MAGNETON ; 92
	const MAGNEZONE ; 93
	const SHUCKLE ; 94
	const CORSOLA ; 95
	const STARYU ; 96
	const STARMIE ; 97
	const CHINCHOU ; 98
	const LANTURN ; 99
	const TENTACOOL ; 9a
	const TENTACRUEL ; 9b
	const SEADRA ; 9c
	const KINGDRA ; 9d
	const LAPRAS ; 9e
	const CLEFAIRY ; 9f
	const CLEFABLE ; a0
	const SOLROCK ; a1
	const LUNATONE ; a2
	const DELIBIRD ; a3
	const JYNX ; a4
	const SNORUNT ; a5
	const GLALIE ; a6
	const FROSLASS ; a7
	const PILOSWINE ; a8
	const MAMOSWINE ; a9
	const SNEASEL ; aa
	const WEAVILE ; ab
	const SNEASLER ; ac
	const SNOVER ; ad
	const ABOMASNOW ; ae
	const BALTOY ; af
	const CLAYDOL ; b0
	const LUCARIO ; b1
	const BRONZOR ; b2
	const BRONZONG ; b3
	const SKARMORY ; b4
	const AGGRON ; b5
	const AEGISLASH ; b6
	const MISDREAVUS ; b7
	const MISMAGIUS ; b8
	const CHANSEY ; b9
	const BLISSEY ; ba
	const SNORLAX ; bb
	const TYRANITAR ; bc
	const SALAMENCE ; bd
	const METAGROSS ; be
	const HAXORUS ; bf
	const PORYGON ; c0
	const PORYGON2 ; c1
	const PORYGONZ ; c2
	const OMANYTE ; c3
	const OMASTAR ; c4
	const LILEEP ; c5
	const CRADILY ; c6
	const AERODACTYL ; c7
	const ROTOM ; c8
	const ABSOL ; c9
	const DURALUDON ; ca
	const GHOLDENGO ; cb
	const DARKRAI ; cc
	const ARTICUNO ; cd
	const ZAPDOS ; ce
	const MOLTRES ; cf
	const LUGIA ; d0
	const RAIKOU ; d1
	const ENTEI ; d2
	const SUICUNE ; d3
	const HO_OH ; d4
	const UNOWN ; d5
	const NOWN ; d6
	const JIRACHI ; d7
	const CELEBI ; d8
	const DITTO ; d9
	const MEW ; da
	const MEWTWO ; db
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
