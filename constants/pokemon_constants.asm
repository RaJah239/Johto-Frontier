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
	const SQUIRTLE ; 0b
	const WARTORTLE ; 0c
	const BLASTOISE ; 0d
	const TURTWIG ; 0e
	const GROTLE ; 0f
	const TORTERRA ; 10
	const PIKACHU ; 11
	const RAICHU ; 12
	const EEVEE ; 13
	const ESPEON ; 14
	const FLAREON ; 15
	const JOLTEON ; 16
	const SYLVEON ; 17
	const UMBREON ; 18
	const VAPOREON ; 19
	const TORCHIC ; 1a
	const COMBUSKEN ; 1b
	const BLAZIKEN ; 1c
	const FEEBAS ; 1d
	const MILOTIC ; 1e
	const ROWLET ; 1f
	const DARTRIX ; 20
	const DECIDUEYE ; 21
	const RALTS ; 22
	const KIRLIA ; 23
	const GARDEVOIR ; 24
	const GALLADE ; 25
	const WURMPLE ; 26
	const SILCOON ; 27
	const BEAUTIFLY ; 28
	const CASCOON ; 29
	const DUSTOX ; 2a
	const YANMA ; 2b
	const YANMEGA ; 2c
	const SUNKERN ; 2d
	const SUNFLORA ; 2e
	const BUNEARY ; 2f
	const LOPUNNY ; 30
	const PIDGEY ; 31
	const PIDGEOTTO ; 32
	const PIDGEOT ; 33
	const HOOTHOOT ; 34
	const NOCTOWL ; 35
	const ZUBAT ; 36
	const GOLBAT ; 37
	const CROBAT ; 38
	const TEDDIURSA ; 39
	const URSARING ; 3a
	const URSALUNA ; 3b
	const URSALUNA_B ; 3c
	const PHANPY ; 3d
	const DONPHAN ; 3e
	const BELLSPROUT ; 3f
	const WEEPINBELL ; 40
	const VICTREEBEL ; 41
	const MAREEP ; 42
	const FLAAFFY ; 43
	const AMPHAROS ; 44
	const WIMPOD ; 45
	const GOLISOPOD ; 46
	const MARILL ; 47
	const AZUMARILL ; 48
	const RHYHORN ; 49
	const RHYDON ; 4a
	const DRILBUR ; 4b
	const EXCADRILL ; 4c
	const ONIX ; 4d
	const STEELIX ; 4e
	const MAGIKARP ; 4f
	const GYARADOS ; 50
	const GASTLY ; 51
	const HAUNTER ; 52
	const GENGAR ; 53
	const SWABLU ; 54
	const ALTARIA ; 55
	const NATU ; 56
	const KATU ; 57
	const XATU ; 58
	const SMEARGLE ; 59
	const GROWLITHE ; 5a
	const ARCANINE ; 5b
	const HOUNDOUR ; 5c
	const HOUNDOOM ; 5d
	const WOOPER ; 5e
	const QUAGSIRE ; 5f
	const GLIGAR ; 60
	const GLISCOR ; 61
	const GIBLE ; 62
	const GABITE ; 63
	const GARCHOMP ; 64
	const MAKUHITA ; 65
	const HARIYAMA ; 66
	const DODUO ; 67
	const DODRIO ; 68
	const PONYTA ; 69
	const RAPIDASH ; 6a
	const SLOWPOKE ; 6b
	const SLOWBRO ; 6c
	const SHROOMISH ; 6d
	const BRELOOM ; 6e
	const SPINARAK ; 6f
	const ARIADOS ; 70
	const VENIPEDE ; 71
	const WHIRLIPEDE ; 72
	const SCOLIPEDE ; 73
	const JOLTIK ; 74
	const GALVANTULA ; 75
	const SKORUPI ; 76
	const DRAPION ; 77
	const LARVESTA ; 78
	const VOLCARONA ; 79
	const IRON_MOTH ; 7a
	const TROPIUS ; 7b
	const MANKEY ; 7c
	const PRIMEAPE ; 7d
	const ANNIHILAPE ; 7e
	const FERROSEED ; 7f
	const FERROTHORN ; 80
	const SCYTHER ; 81
	const SCIZOR ; 82
	const KLEAVOR ; 83
	const HERACROSS ; 84
	const TANGELA ; 85
	const TANGROWTH ; 86
	const MEOWTH ; 87
	const PERSIAN ; 88
	const SNUBBULL ; 89
	const GRANBULL ; 8a
	const DROWZEE ; 8b
	const HYPNO ; 8c
	const MR__MIME ; 8d
	const SUDOWOODO ; 8e
	const KOFFING ; 8f
	const WEEZING ; 90
	const GRIMER ; 91
	const MUK ; 92

	; second 101 pokemon
DEF JOHTO_POKEMON EQU const_value
	const LITWICK ; 93
	const LAMPENT ; 94
	const CHANDELURE ; 95
	const MILTANK ; 96
	const TAUROS ; 97
	const ELECTRODE ; 98
	const ELECTABUZZ ; 99
	const MAGNETON ; 9a
	const MAGNEZONE ; 9b
	const SHUCKLE ; 9c
	const CORSOLA ; 9d
	const STARYU ; 9e
	const STARMIE ; 9f
	const CHINCHOU ; a0
	const LANTURN ; a1
	const TENTACOOL ; a2
	const TENTACRUEL ; a3
	const SEADRA ; a4
	const KINGDRA ; a5
	const LAPRAS ; a6
	const CLEFAIRY ; a7
	const CLEFABLE ; a8
	const SOLROCK ; a9
	const LUNATONE ; aa
	const DELIBIRD ; ab
	const JYNX ; ac
	const SNORUNT ; ad
	const GLALIE ; ae
	const FROSLASS ; af
	const PILOSWINE ; b0
	const MAMOSWINE ; b1
	const SNEASEL ; b2
	const WEAVILE ; b3
	const SNEASLER ; b4
	const SNOVER ; b5
	const ABOMASNOW ; b6
	const BALTOY ; b7
	const CLAYDOL ; b8
	const LUCARIO ; b9
	const BRONZOR ; ba
	const BRONZONG ; bb
	const SKARMORY ; bc
	const AGGRON ; bd
	const AEGISLASH ; be
	const MISDREAVUS ; bf
	const MISMAGIUS ; c0
	const CHANSEY ; c1
	const BLISSEY ; c2
	const SNORLAX ; c3
	const TYRANITAR ; c4
	const SALAMENCE ; c5
	const METAGROSS ; c6
	const HAXORUS ; c7
	const PORYGON ; c8
	const PORYGON2 ; c9
	const PORYGONZ ; ca
	const OMANYTE ; cb
	const OMASTAR ; cc
	const LILEEP ; cd
	const CRADILY ; ce
	const AERODACTYL ; cf
	const ROTOM ; d0
	const ABSOL ; d1
	const DURALUDON ; d2
	const GHOLDENGO ; d3
	const DARKRAI ; d4
	const ARTICUNO ; d5
	const ZAPDOS ; d6
	const MOLTRES ; d7
	const LUGIA ; d8
	const RAIKOU ; d9
	const ENTEI ; da
	const SUICUNE ; db
	const HO_OH ; dc
	const UNOWN ; dd
	const NOWN ; de
	const JIRACHI ; df
	const CELEBI ; e0
	const DITTO ; e1
	const MEW ; e2
	const MEWTWO ; e3
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
