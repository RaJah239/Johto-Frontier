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
	const WIMPOD ; 37
	const GOLISOPOD ; 38
	const MARILL ; 39
	const AZUMARILL ; 3a
	const RHYHORN ; 3b
	const RHYDON ; 3c
	const DRILBUR ; 3d
	const EXCADRILL ; 3e
	const ONIX ; 3f
	const STEELIX ; 40
	const MAGIKARP ; 41
	const GYARADOS ; 42
	const GASTLY ; 43
	const HAUNTER ; 44
	const GENGAR ; 45
	const SWABLU ; 46
	const ALTARIA ; 47
	const NATU ; 48
	const KATU ; 49
	const XATU ; 4a
	const SMEARGLE ; 4b
	const GROWLITHE ; 4c
	const ARCANINE ; 4d
	const HOUNDOUR ; 4e
	const HOUNDOOM ; 4f
	const WOOPER ; 50
	const QUAGSIRE ; 51
	const GLIGAR ; 52
	const GLISCOR ; 53
	const GIBLE ; 54
	const GABITE ; 55
	const GARCHOMP ; 56
	const MAKUHITA ; 57
	const HARIYAMA ; 58
	const DODUO ; 59
	const DODRIO ; 5a
	const PONYTA ; 5b
	const RAPIDASH ; 5c
	const SLOWPOKE ; 5d
	const SLOWBRO ; 5e
	const SHROOMISH ; 5f
	const BRELOOM ; 60
	const SPINARAK ; 61
	const ARIADOS ; 62
	const VENIPEDE ; 63
	const WHIRLIPEDE ; 64
	const SCOLIPEDE ; 65
	const JOLTIK ; 66
	const GALVANTULA ; 67
	const SKORUPI ; 68
	const DRAPION ; 69
	const LARVESTA ; 6a
	const VOLCARONA ; 6b
	const IRON_MOTH ; 6c
	const TROPIUS ; 6d
	const MANKEY ; 6e
	const PRIMEAPE ; 6f
	const ANNIHILAPE ; 70
	const FERROSEED ; 71
	const FERROTHORN ; 72
	const SCYTHER ; 73
	const SCIZOR ; 74
	const KLEAVOR ; 75
	const HERACROSS ; 76
	const TANGELA ; 77
	const TANGROWTH ; 78
	const MEOWTH ; 79
	const PERSIAN ; 7a
	const SNUBBULL ; 7b
	const GRANBULL ; 7c
	const DROWZEE ; 7d
	const HYPNO ; 7e
	const MR__MIME ; 7f
	const SUDOWOODO ; 80
	const KOFFING ; 81
	const WEEZING ; 82
	const GRIMER ; 83
	const MUK ; 84

	; second 101 pokemon
DEF JOHTO_POKEMON EQU const_value
	const LITWICK ; 85
	const LAMPENT ; 86
	const CHANDELURE ; 87
	const MILTANK ; 88
	const TAUROS ; 89
	const ELECTRODE ; 8a
	const ELECTABUZZ ; 8b
	const MAGNETON ; 8c
	const MAGNEZONE ; 8d
	const SHUCKLE ; 8e
	const CORSOLA ; 8f
	const STARYU ; 90
	const STARMIE ; 91
	const CHINCHOU ; 92
	const LANTURN ; 93
	const TENTACOOL ; 94
	const TENTACRUEL ; 95
	const SEADRA ; 96
	const KINGDRA ; 97
	const LAPRAS ; 98
	const CLEFAIRY ; 99
	const CLEFABLE ; 9a
	const SOLROCK ; 9b
	const LUNATONE ; 9c
	const DELIBIRD ; 9d
	const JYNX ; 9e
	const SNORUNT ; 9f
	const GLALIE ; a0
	const FROSLASS ; a1
	const PILOSWINE ; a2
	const MAMOSWINE ; a3
	const SNEASEL ; a4
	const WEAVILE ; a5
	const SNEASLER ; a6
	const SNOVER ; a7
	const ABOMASNOW ; a8
	const BALTOY ; a9
	const CLAYDOL ; aa
	const LUCARIO ; ab
	const BRONZOR ; ac
	const BRONZONG ; ad
	const SKARMORY ; ae
	const AGGRON ; af
	const AEGISLASH ; b0
	const MISDREAVUS ; b1
	const MISMAGIUS ; b2
	const CHANSEY ; b3
	const BLISSEY ; b4
	const SNORLAX ; b5
	const TYRANITAR ; b6
	const SALAMENCE ; b7
	const METAGROSS ; b8
	const HAXORUS ; b9
	const PORYGON ; ba
	const PORYGON2 ; bb
	const PORYGONZ ; bc
	const OMANYTE ; bd
	const OMASTAR ; be
	const LILEEP ; bf
	const CRADILY ; c0
	const AERODACTYL ; c1
	const ROTOM ; c2
	const ABSOL ; c3
	const DURALUDON ; c4
	const GHOLDENGO ; c5
	const DARKRAI ; c6
	const ARTICUNO ; c7
	const ZAPDOS ; c8
	const MOLTRES ; c9
	const LUGIA ; ca
	const RAIKOU ; cb
	const ENTEI ; cc
	const SUICUNE ; cd
	const HO_OH ; ce
	const UNOWN ; cf
	const NOWN ; d0
	const JIRACHI ; d1
	const CELEBI ; d2
	const DITTO ; d3
	const MEW ; d4
	const MEWTWO ; d5
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
