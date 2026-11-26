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
	const RHYHORN ; 39
	const RHYDON ; 3a
	const DRILBUR ; 3b
	const EXCADRILL ; 3c
	const ONIX ; 3d
	const STEELIX ; 3e
	const MAGIKARP ; 3f
	const GYARADOS ; 40
	const GASTLY ; 41
	const HAUNTER ; 42
	const GENGAR ; 43
	const SWABLU ; 44
	const ALTARIA ; 45
	const NATU ; 46
	const KATU ; 47
	const XATU ; 48
	const SMEARGLE ; 49
	const GROWLITHE ; 4a
	const ARCANINE ; 4b
	const HOUNDOUR ; 4c
	const HOUNDOOM ; 4d
	const WOOPER ; 4e
	const QUAGSIRE ; 4f
	const GLIGAR ; 50
	const GLISCOR ; 51
	const GIBLE ; 52
	const GABITE ; 53
	const GARCHOMP ; 54
	const MAKUHITA ; 55
	const HARIYAMA ; 56
	const DODUO ; 57
	const DODRIO ; 58
	const PONYTA ; 59
	const RAPIDASH ; 5a
	const SLOWPOKE ; 5b
	const SLOWBRO ; 5c
	const SHROOMISH ; 5d
	const BRELOOM ; 5e
	const SPINARAK ; 5f
	const ARIADOS ; 60
	const VENIPEDE ; 61
	const WHIRLIPEDE ; 62
	const SCOLIPEDE ; 63
	const JOLTIK ; 64
	const GALVANTULA ; 65
	const SKORUPI ; 66
	const DRAPION ; 67
	const LARVESTA ; 68
	const VOLCARONA ; 69
	const IRON_MOTH ; 6a
	const TROPIUS ; 6b
	const MANKEY ; 6c
	const PRIMEAPE ; 6d
	const ANNIHILAPE ; 6e
	const FERROSEED ; 6f
	const FERROTHORN ; 70
	const SCYTHER ; 71
	const SCIZOR ; 72
	const KLEAVOR ; 73
	const HERACROSS ; 74
	const TANGELA ; 75
	const TANGROWTH ; 76
	const MEOWTH ; 77
	const PERSIAN ; 78
	const SNUBBULL ; 79
	const GRANBULL ; 7a
	const DROWZEE ; 7b
	const HYPNO ; 7c
	const MR__MIME ; 7d
	const SUDOWOODO ; 7e
	const KOFFING ; 7f
	const WEEZING ; 80
	const GRIMER ; 81
	const MUK ; 82

	; second 101 pokemon
DEF JOHTO_POKEMON EQU const_value
	const LITWICK ; 83
	const LAMPENT ; 84
	const CHANDELURE ; 85
	const MILTANK ; 86
	const TAUROS ; 87
	const ELECTRODE ; 88
	const ELECTABUZZ ; 89
	const MAGNETON ; 8a
	const MAGNEZONE ; 8b
	const SHUCKLE ; 8c
	const CORSOLA ; 8d
	const STARYU ; 8e
	const STARMIE ; 8f
	const CHINCHOU ; 90
	const LANTURN ; 91
	const TENTACOOL ; 92
	const TENTACRUEL ; 93
	const SEADRA ; 94
	const KINGDRA ; 95
	const LAPRAS ; 96
	const CLEFAIRY ; 97
	const CLEFABLE ; 98
	const SOLROCK ; 99
	const LUNATONE ; 9a
	const DELIBIRD ; 9b
	const JYNX ; 9c
	const SNORUNT ; 9d
	const GLALIE ; 9e
	const FROSLASS ; 9f
	const PILOSWINE ; a0
	const MAMOSWINE ; a1
	const SNEASEL ; a2
	const WEAVILE ; a3
	const SNEASLER ; a4
	const SNOVER ; a5
	const ABOMASNOW ; a6
	const BALTOY ; a7
	const CLAYDOL ; a8
	const LUCARIO ; a9
	const BRONZOR ; aa
	const BRONZONG ; ab
	const SKARMORY ; ac
	const AGGRON ; ad
	const AEGISLASH ; ae
	const MISDREAVUS ; af
	const MISMAGIUS ; b0
	const CHANSEY ; b1
	const BLISSEY ; b2
	const SNORLAX ; b3
	const TYRANITAR ; b4
	const SALAMENCE ; b5
	const METAGROSS ; b6
	const HAXORUS ; b7
	const PORYGON ; b8
	const PORYGON2 ; b9
	const PORYGONZ ; ba
	const OMANYTE ; bb
	const OMASTAR ; bc
	const LILEEP ; bd
	const CRADILY ; be
	const AERODACTYL ; bf
	const ROTOM ; c0
	const ABSOL ; c1
	const DURALUDON ; c2
	const GHOLDENGO ; c3
	const DARKRAI ; c4
	const ARTICUNO ; c5
	const ZAPDOS ; c6
	const MOLTRES ; c7
	const LUGIA ; c8
	const RAIKOU ; c9
	const ENTEI ; ca
	const SUICUNE ; cb
	const HO_OH ; cc
	const UNOWN ; cd
	const NOWN ; ce
	const JIRACHI ; cf
	const CELEBI ; d0
	const DITTO ; d1
	const MEW ; d2
	const MEWTWO ; d3
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
