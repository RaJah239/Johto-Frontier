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
	const GASTLY ; 40
	const HAUNTER ; 41
	const GENGAR ; 42
	const SWABLU ; 43
	const ALTARIA ; 44
	const NATU ; 45
	const KATU ; 46
	const XATU ; 47
	const SMEARGLE ; 48
	const GROWLITHE ; 49
	const ARCANINE ; 4a
	const HOUNDOUR ; 4b
	const HOUNDOOM ; 4c
	const WOOPER ; 4d
	const QUAGSIRE ; 4e
	const GLIGAR ; 4f
	const GLISCOR ; 50
	const GIBLE ; 51
	const GABITE ; 52
	const GARCHOMP ; 53
	const MAKUHITA ; 54
	const HARIYAMA ; 55
	const DODUO ; 56
	const DODRIO ; 57
	const PONYTA ; 58
	const RAPIDASH ; 59
	const SLOWPOKE ; 5a
	const SLOWBRO ; 5b
	const SHROOMISH ; 5c
	const BRELOOM ; 5d
	const SPINARAK ; 5e
	const ARIADOS ; 5f
	const VENIPEDE ; 60
	const WHIRLIPEDE ; 61
	const SCOLIPEDE ; 62
	const JOLTIK ; 63
	const GALVANTULA ; 64
	const SKORUPI ; 65
	const DRAPION ; 66
	const LARVESTA ; 67
	const VOLCARONA ; 68
	const IRON_MOTH ; 69
	const TROPIUS ; 6a
	const MANKEY ; 6b
	const PRIMEAPE ; 6c
	const ANNIHILAPE ; 6d
	const FERROSEED ; 6e
	const FERROTHORN ; 6f
	const SCYTHER ; 70
	const SCIZOR ; 71
	const KLEAVOR ; 72
	const HERACROSS ; 73
	const TANGELA ; 74
	const TANGROWTH ; 75
	const MEOWTH ; 76
	const PERSIAN ; 77
	const SNUBBULL ; 78
	const GRANBULL ; 79
	const DROWZEE ; 7a
	const HYPNO ; 7b
	const MR__MIME ; 7c
	const SUDOWOODO ; 7d
	const KOFFING ; 7e
	const WEEZING ; 7f
	const GRIMER ; 80
	const MUK ; 81

	; second 101 pokemon
DEF JOHTO_POKEMON EQU const_value
	const LITWICK ; 82
	const LAMPENT ; 83
	const CHANDELURE ; 84
	const MILTANK ; 85
	const TAUROS ; 86
	const ELECTRODE ; 87
	const ELECTABUZZ ; 88
	const MAGNETON ; 89
	const MAGNEZONE ; 8a
	const SHUCKLE ; 8b
	const CORSOLA ; 8c
	const STARYU ; 8d
	const STARMIE ; 8e
	const CHINCHOU ; 8f
	const LANTURN ; 90
	const TENTACOOL ; 91
	const TENTACRUEL ; 92
	const SEADRA ; 93
	const KINGDRA ; 94
	const LAPRAS ; 95
	const CLEFAIRY ; 96
	const CLEFABLE ; 97
	const SOLROCK ; 98
	const LUNATONE ; 99
	const DELIBIRD ; 9a
	const JYNX ; 9b
	const SNORUNT ; 9c
	const GLALIE ; 9d
	const FROSLASS ; 9e
	const PILOSWINE ; 9f
	const MAMOSWINE ; a0
	const SNEASEL ; a1
	const WEAVILE ; a2
	const SNEASLER ; a3
	const SNOVER ; a4
	const ABOMASNOW ; a5
	const BALTOY ; a6
	const CLAYDOL ; a7
	const LUCARIO ; a8
	const BRONZOR ; a9
	const BRONZONG ; aa
	const SKARMORY ; ab
	const AGGRON ; ac
	const AEGISLASH ; ad
	const MISDREAVUS ; ae
	const MISMAGIUS ; af
	const CHANSEY ; b0
	const BLISSEY ; b1
	const SNORLAX ; b2
	const TYRANITAR ; b3
	const SALAMENCE ; b4
	const METAGROSS ; b5
	const HAXORUS ; b6
	const PORYGON ; b7
	const PORYGON2 ; b8
	const PORYGONZ ; b9
	const OMANYTE ; ba
	const OMASTAR ; bb
	const LILEEP ; bc
	const CRADILY ; bd
	const AERODACTYL ; be
	const ROTOM ; bf
	const ABSOL ; c0
	const DURALUDON ; c1
	const GHOLDENGO ; c2
	const DARKRAI ; c3
	const ARTICUNO ; c4
	const ZAPDOS ; c5
	const MOLTRES ; c6
	const LUGIA ; c7
	const RAIKOU ; c8
	const ENTEI ; c9
	const SUICUNE ; ca
	const HO_OH ; cb
	const UNOWN ; cc
	const NOWN ; cd
	const JIRACHI ; ce
	const CELEBI ; cf
	const DITTO ; d0
	const MEW ; d1
	const MEWTWO ; d2
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
