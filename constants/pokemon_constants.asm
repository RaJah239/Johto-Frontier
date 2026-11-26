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
	const GOLISOPOD ; 37
	const MARILL ; 38
	const AZUMARILL ; 39
	const RHYHORN ; 3a
	const RHYDON ; 3b
	const DRILBUR ; 3c
	const EXCADRILL ; 3d
	const ONIX ; 3e
	const STEELIX ; 3f
	const MAGIKARP ; 40
	const GYARADOS ; 41
	const GASTLY ; 42
	const HAUNTER ; 43
	const GENGAR ; 44
	const SWABLU ; 45
	const ALTARIA ; 46
	const NATU ; 47
	const KATU ; 48
	const XATU ; 49
	const SMEARGLE ; 4a
	const GROWLITHE ; 4b
	const ARCANINE ; 4c
	const HOUNDOUR ; 4d
	const HOUNDOOM ; 4e
	const WOOPER ; 4f
	const QUAGSIRE ; 50
	const GLIGAR ; 51
	const GLISCOR ; 52
	const GIBLE ; 53
	const GABITE ; 54
	const GARCHOMP ; 55
	const MAKUHITA ; 56
	const HARIYAMA ; 57
	const DODUO ; 58
	const DODRIO ; 59
	const PONYTA ; 5a
	const RAPIDASH ; 5b
	const SLOWPOKE ; 5c
	const SLOWBRO ; 5d
	const SHROOMISH ; 5e
	const BRELOOM ; 5f
	const SPINARAK ; 60
	const ARIADOS ; 61
	const VENIPEDE ; 62
	const WHIRLIPEDE ; 63
	const SCOLIPEDE ; 64
	const JOLTIK ; 65
	const GALVANTULA ; 66
	const SKORUPI ; 67
	const DRAPION ; 68
	const LARVESTA ; 69
	const VOLCARONA ; 6a
	const IRON_MOTH ; 6b
	const TROPIUS ; 6c
	const MANKEY ; 6d
	const PRIMEAPE ; 6e
	const ANNIHILAPE ; 6f
	const FERROSEED ; 70
	const FERROTHORN ; 71
	const SCYTHER ; 72
	const SCIZOR ; 73
	const KLEAVOR ; 74
	const HERACROSS ; 75
	const TANGELA ; 76
	const TANGROWTH ; 77
	const MEOWTH ; 78
	const PERSIAN ; 79
	const SNUBBULL ; 7a
	const GRANBULL ; 7b
	const DROWZEE ; 7c
	const HYPNO ; 7d
	const MR__MIME ; 7e
	const SUDOWOODO ; 7f
	const KOFFING ; 80
	const WEEZING ; 81
	const GRIMER ; 82
	const MUK ; 83

	; second 101 pokemon
DEF JOHTO_POKEMON EQU const_value
	const LITWICK ; 84
	const LAMPENT ; 85
	const CHANDELURE ; 86
	const MILTANK ; 87
	const TAUROS ; 88
	const ELECTRODE ; 89
	const ELECTABUZZ ; 8a
	const MAGNETON ; 8b
	const MAGNEZONE ; 8c
	const SHUCKLE ; 8d
	const CORSOLA ; 8e
	const STARYU ; 8f
	const STARMIE ; 90
	const CHINCHOU ; 91
	const LANTURN ; 92
	const TENTACOOL ; 93
	const TENTACRUEL ; 94
	const SEADRA ; 95
	const KINGDRA ; 96
	const LAPRAS ; 97
	const CLEFAIRY ; 98
	const CLEFABLE ; 99
	const SOLROCK ; 9a
	const LUNATONE ; 9b
	const DELIBIRD ; 9c
	const JYNX ; 9d
	const SNORUNT ; 9e
	const GLALIE ; 9f
	const FROSLASS ; a0
	const PILOSWINE ; a1
	const MAMOSWINE ; a2
	const SNEASEL ; a3
	const WEAVILE ; a4
	const SNEASLER ; a5
	const SNOVER ; a6
	const ABOMASNOW ; a7
	const BALTOY ; a8
	const CLAYDOL ; a9
	const LUCARIO ; aa
	const BRONZOR ; ab
	const BRONZONG ; ac
	const SKARMORY ; ad
	const AGGRON ; ae
	const AEGISLASH ; af
	const MISDREAVUS ; b0
	const MISMAGIUS ; b1
	const CHANSEY ; b2
	const BLISSEY ; b3
	const SNORLAX ; b4
	const TYRANITAR ; b5
	const SALAMENCE ; b6
	const METAGROSS ; b7
	const HAXORUS ; b8
	const PORYGON ; b9
	const PORYGON2 ; ba
	const PORYGONZ ; bb
	const OMANYTE ; bc
	const OMASTAR ; bd
	const LILEEP ; be
	const CRADILY ; bf
	const AERODACTYL ; c0
	const ROTOM ; c1
	const ABSOL ; c2
	const DURALUDON ; c3
	const GHOLDENGO ; c4
	const DARKRAI ; c5
	const ARTICUNO ; c6
	const ZAPDOS ; c7
	const MOLTRES ; c8
	const LUGIA ; c9
	const RAIKOU ; ca
	const ENTEI ; cb
	const SUICUNE ; cc
	const HO_OH ; cd
	const UNOWN ; ce
	const NOWN ; cf
	const JIRACHI ; d0
	const CELEBI ; d1
	const DITTO ; d2
	const MEW ; d3
	const MEWTWO ; d4
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
