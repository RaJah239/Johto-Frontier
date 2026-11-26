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
	const DARTRIX ; 1b
	const DECIDUEYE ; 1c
	const RALTS ; 1d
	const KIRLIA ; 1e
	const GARDEVOIR ; 1f
	const GALLADE ; 20
	const WURMPLE ; 21
	const SILCOON ; 22
	const BEAUTIFLY ; 23
	const CASCOON ; 24
	const DUSTOX ; 25
	const YANMA ; 26
	const YANMEGA ; 27
	const SUNKERN ; 28
	const SUNFLORA ; 29
	const BUNEARY ; 2a
	const LOPUNNY ; 2b
	const PIDGEY ; 2c
	const PIDGEOTTO ; 2d
	const PIDGEOT ; 2e
	const HOOTHOOT ; 2f
	const NOCTOWL ; 30
	const ZUBAT ; 31
	const GOLBAT ; 32
	const CROBAT ; 33
	const TEDDIURSA ; 34
	const URSARING ; 35
	const URSALUNA ; 36
	const URSALUNA_B ; 37
	const PHANPY ; 38
	const DONPHAN ; 39
	const BELLSPROUT ; 3a
	const WEEPINBELL ; 3b
	const VICTREEBEL ; 3c
	const MAREEP ; 3d
	const FLAAFFY ; 3e
	const AMPHAROS ; 3f
	const WIMPOD ; 40
	const GOLISOPOD ; 41
	const MARILL ; 42
	const AZUMARILL ; 43
	const RHYHORN ; 44
	const RHYDON ; 45
	const DRILBUR ; 46
	const EXCADRILL ; 47
	const ONIX ; 48
	const STEELIX ; 49
	const MAGIKARP ; 4a
	const GYARADOS ; 4b
	const GASTLY ; 4c
	const HAUNTER ; 4d
	const GENGAR ; 4e
	const SWABLU ; 4f
	const ALTARIA ; 50
	const NATU ; 51
	const KATU ; 52
	const XATU ; 53
	const SMEARGLE ; 54
	const GROWLITHE ; 55
	const ARCANINE ; 56
	const HOUNDOUR ; 57
	const HOUNDOOM ; 58
	const WOOPER ; 59
	const QUAGSIRE ; 5a
	const GLIGAR ; 5b
	const GLISCOR ; 5c
	const GIBLE ; 5d
	const GABITE ; 5e
	const GARCHOMP ; 5f
	const MAKUHITA ; 60
	const HARIYAMA ; 61
	const DODUO ; 62
	const DODRIO ; 63
	const PONYTA ; 64
	const RAPIDASH ; 65
	const SLOWPOKE ; 66
	const SLOWBRO ; 67
	const SHROOMISH ; 68
	const BRELOOM ; 69
	const SPINARAK ; 6a
	const ARIADOS ; 6b
	const VENIPEDE ; 6c
	const WHIRLIPEDE ; 6d
	const SCOLIPEDE ; 6e
	const JOLTIK ; 6f
	const GALVANTULA ; 70
	const SKORUPI ; 71
	const DRAPION ; 72
	const LARVESTA ; 73
	const VOLCARONA ; 74
	const IRON_MOTH ; 75
	const TROPIUS ; 76
	const MANKEY ; 77
	const PRIMEAPE ; 78
	const ANNIHILAPE ; 79
	const FERROSEED ; 7a
	const FERROTHORN ; 7b
	const SCYTHER ; 7c
	const SCIZOR ; 7d
	const KLEAVOR ; 7e
	const HERACROSS ; 7f
	const TANGELA ; 80
	const TANGROWTH ; 81
	const MEOWTH ; 82
	const PERSIAN ; 83
	const SNUBBULL ; 84
	const GRANBULL ; 85
	const DROWZEE ; 86
	const HYPNO ; 87
	const MR__MIME ; 88
	const SUDOWOODO ; 89
	const KOFFING ; 8a
	const WEEZING ; 8b
	const GRIMER ; 8c
	const MUK ; 8d

	; second 101 pokemon
DEF JOHTO_POKEMON EQU const_value
	const LITWICK ; 8e
	const LAMPENT ; 8f
	const CHANDELURE ; 90
	const MILTANK ; 91
	const TAUROS ; 92
	const ELECTRODE ; 93
	const ELECTABUZZ ; 94
	const MAGNETON ; 95
	const MAGNEZONE ; 96
	const SHUCKLE ; 97
	const CORSOLA ; 98
	const STARYU ; 99
	const STARMIE ; 9a
	const CHINCHOU ; 9b
	const LANTURN ; 9c
	const TENTACOOL ; 9d
	const TENTACRUEL ; 9e
	const SEADRA ; 9f
	const KINGDRA ; a0
	const LAPRAS ; a1
	const CLEFAIRY ; a2
	const CLEFABLE ; a3
	const SOLROCK ; a4
	const LUNATONE ; a5
	const DELIBIRD ; a6
	const JYNX ; a7
	const SNORUNT ; a8
	const GLALIE ; a9
	const FROSLASS ; aa
	const PILOSWINE ; ab
	const MAMOSWINE ; ac
	const SNEASEL ; ad
	const WEAVILE ; ae
	const SNEASLER ; af
	const SNOVER ; b0
	const ABOMASNOW ; b1
	const BALTOY ; b2
	const CLAYDOL ; b3
	const LUCARIO ; b4
	const BRONZOR ; b5
	const BRONZONG ; b6
	const SKARMORY ; b7
	const AGGRON ; b8
	const AEGISLASH ; b9
	const MISDREAVUS ; ba
	const MISMAGIUS ; bb
	const CHANSEY ; bc
	const BLISSEY ; bd
	const SNORLAX ; be
	const TYRANITAR ; bf
	const SALAMENCE ; c0
	const METAGROSS ; c1
	const HAXORUS ; c2
	const PORYGON ; c3
	const PORYGON2 ; c4
	const PORYGONZ ; c5
	const OMANYTE ; c6
	const OMASTAR ; c7
	const LILEEP ; c8
	const CRADILY ; c9
	const AERODACTYL ; ca
	const ROTOM ; cb
	const ABSOL ; cc
	const DURALUDON ; cd
	const GHOLDENGO ; ce
	const DARKRAI ; cf
	const ARTICUNO ; d0
	const ZAPDOS ; d1
	const MOLTRES ; d2
	const LUGIA ; d3
	const RAIKOU ; d4
	const ENTEI ; d5
	const SUICUNE ; d6
	const HO_OH ; d7
	const UNOWN ; d8
	const NOWN ; d9
	const JIRACHI ; da
	const CELEBI ; db
	const DITTO ; dc
	const MEW ; dd
	const MEWTWO ; de
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
