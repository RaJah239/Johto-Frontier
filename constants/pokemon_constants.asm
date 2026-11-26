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
	const CYNDAQUIL  ; 01
	const QUILAVA    ; 02
	const TYPHLOSION ; 03
	const TOTODILE   ; 04
	const CROCONAW   ; 05
	const FERALIGATR ; 06
	const CHIKORITA  ; 07
	const BAYLEEF    ; 08
	const MEGANIUM   ; 09
	const TOGEPI     ; 0a
	const TOGETIC    ; 0b
	const TOGEKISS   ; 0c
	const CHARMANDER ; 0d
	const CHARMELEON ; 0e
	const CHARIZARD  ; 0f
	const SQUIRTLE   ; 10
	const WARTORTLE  ; 11
	const BLASTOISE  ; 12
	const TURTWIG    ; 13
	const GROTLE     ; 14
	const TORTERRA   ; 15
	const PIKACHU    ; 16
	const RAICHU     ; 17
	const EEVEE      ; 18
	const ESPEON     ; 19
	const FLAREON    ; 1a
	const JOLTEON    ; 1b
	const SYLVEON    ; 1c
	const UMBREON    ; 1d
	const VAPOREON   ; 1e
	const TORCHIC    ; 1f
	const COMBUSKEN  ; 20
	const BLAZIKEN   ; 21
	const FEEBAS     ; 22
	const MILOTIC    ; 23
	const ROWLET     ; 24
	const DARTRIX    ; 25
	const DECIDUEYE  ; 26
	const RALTS      ; 27
	const KIRLIA     ; 28
	const GARDEVOIR  ; 29
	const GALLADE    ; 2a
	const WURMPLE    ; 2b
	const SILCOON    ; 2c
	const BEAUTIFLY  ; 2d
	const CASCOON    ; 2e
	const DUSTOX     ; 2f
	const YANMA      ; 30
	const YANMEGA    ; 31
	const SUNKERN    ; 32
	const SUNFLORA   ; 33
	const BUNEARY    ; 34
	const LOPUNNY    ; 35
	const PIDGEY     ; 36
	const PIDGEOTTO  ; 37
	const PIDGEOT    ; 38
	const HOOTHOOT   ; 39
	const NOCTOWL    ; 3a
	const ZUBAT      ; 3b
	const GOLBAT     ; 3c
	const CROBAT     ; 3d
	const TEDDIURSA  ; 3e
	const URSARING   ; 3f
	const URSALUNA   ; 40
	const URSALUNA_B ; 41
	const PHANPY     ; 42
	const DONPHAN    ; 43
	const BELLSPROUT ; 44
	const WEEPINBELL ; 45
	const VICTREEBEL ; 46
	const MAREEP     ; 47
	const FLAAFFY    ; 48
	const AMPHAROS   ; 49
	const WIMPOD     ; 4a
	const GOLISOPOD  ; 4b
	const MARILL     ; 4c
	const AZUMARILL  ; 4d
	const RHYHORN    ; 4e
	const RHYDON     ; 4f
	const DRILBUR    ; 50
	const EXCADRILL  ; 51
	const ONIX       ; 52
	const STEELIX    ; 53
	const MAGIKARP   ; 54
	const GYARADOS   ; 55
	const GASTLY     ; 56
	const HAUNTER    ; 57
	const GENGAR     ; 58
	const SWABLU     ; 59
	const ALTARIA    ; 5a
	const NATU       ; 5b
	const KATU       ; 5c
	const XATU       ; 5d
	const SMEARGLE   ; 5e
	const GROWLITHE  ; 5f
	const ARCANINE   ; 60
	const HOUNDOUR   ; 61
	const HOUNDOOM   ; 62
	const WOOPER     ; 63
	const QUAGSIRE   ; 64
	const GLIGAR     ; 65
	const GLISCOR    ; 66
	const GIBLE      ; 67
	const GABITE     ; 68
	const GARCHOMP   ; 69
	const MAKUHITA   ; 6a
	const HARIYAMA   ; 6b
	const DODUO      ; 6c
	const DODRIO     ; 6d
	const PONYTA     ; 6e
	const RAPIDASH   ; 6f
	const SLOWPOKE   ; 70
	const SLOWBRO    ; 71
	const SHROOMISH  ; 72
	const BRELOOM    ; 73
	const SPINARAK   ; 74
	const ARIADOS    ; 75
	const VENIPEDE   ; 76
	const WHIRLIPEDE ; 77
	const SCOLIPEDE  ; 78
	const JOLTIK     ; 79
	const GALVANTULA ; 7a
	const SKORUPI    ; 7b
	const DRAPION    ; 7c
	const LARVESTA   ; 7d
	const VOLCARONA  ; 7e
	const IRON_MOTH  ; 7f
	const TROPIUS    ; 80
	const MANKEY     ; 81
	const PRIMEAPE   ; 82
	const ANNIHILAPE ; 83
	const FERROSEED  ; 84
	const FERROTHORN ; 85
	const SCYTHER    ; 86
	const SCIZOR     ; 87
	const KLEAVOR    ; 88
	const HERACROSS  ; 89
	const TANGELA    ; 8a
	const TANGROWTH  ; 8b
	const MEOWTH     ; 8c
	const PERSIAN    ; 8d
	const SNUBBULL   ; 8e
	const GRANBULL   ; 8f
	const DROWZEE    ; 90
	const HYPNO      ; 91
	const MR__MIME   ; 92
	const SUDOWOODO  ; 93
	const KOFFING    ; 94
	const WEEZING    ; 95
	const GRIMER     ; 96
	const MUK        ; 97

	; second 101 pokemon
DEF JOHTO_POKEMON EQU const_value
	const LITWICK    ; 98
	const LAMPENT    ; 99
	const CHANDELURE ; 9a
	const MILTANK    ; 9b
	const TAUROS     ; 9c
	const VOLTORB    ; 9d
	const ELECTRODE  ; 9e
	const ELEKID     ; 9f
	const ELECTABUZZ ; a0
	const MAGNETON   ; a1
	const MAGNEZONE  ; a2
	const SHUCKLE    ; a3
	const CORSOLA    ; a4
	const STARYU     ; a5
	const STARMIE    ; a6
	const CHINCHOU   ; a7
	const LANTURN    ; a8
	const TENTACOOL  ; a9
	const TENTACRUEL ; aa
	const SEADRA     ; ab
	const KINGDRA    ; ac
	const LAPRAS     ; ad
	const CLEFAIRY   ; ae
	const CLEFABLE   ; af
	const SOLROCK    ; b0
	const LUNATONE   ; b1
	const DELIBIRD   ; b2
	const JYNX       ; b3
	const SNORUNT    ; b4
	const GLALIE     ; b5
	const FROSLASS   ; b6
	const PILOSWINE  ; b7
	const MAMOSWINE  ; b8
	const SNEASEL    ; b9
	const WEAVILE    ; ba
	const SNEASLER   ; bb
	const SNOVER     ; bc
	const ABOMASNOW  ; bd
	const BALTOY     ; be
	const CLAYDOL    ; bf
	const LUCARIO    ; c0
	const BRONZOR    ; c1
	const BRONZONG   ; c2
	const SKARMORY   ; c3
	const AGGRON     ; c4
	const AEGISLASH  ; c5
	const MISDREAVUS ; c6
	const MISMAGIUS  ; c7
	const CHANSEY    ; c8
	const BLISSEY    ; c9
	const SNORLAX    ; ca
	const TYRANITAR  ; cb
	const SALAMENCE  ; cc
	const METAGROSS  ; cd
	const HAXORUS    ; ce
	const PORYGON    ; cf
	const PORYGON2   ; d0
	const PORYGONZ   ; d1
	const OMANYTE    ; d2
	const OMASTAR    ; d3
	const LILEEP     ; d4
	const CRADILY    ; d5
	const AERODACTYL ; d6
	const ROTOM      ; d7
	const ABSOL      ; d8
	const DURALUDON  ; d9
	const GHOLDENGO  ; da
	const DARKRAI    ; db
	const ARTICUNO   ; dc
	const ZAPDOS     ; dd
	const MOLTRES    ; de
	const LUGIA      ; df
	const RAIKOU     ; e0
	const ENTEI      ; e1
	const SUICUNE    ; e2
	const HO_OH      ; e3
	const UNOWN      ; e4
	const NOWN       ; e5
	const JIRACHI    ; e6
	const CELEBI     ; e7
	const DITTO      ; e8
	const MEW        ; e9
	const MEWTWO     ; ea
DEF NUM_POKEMON EQU const_value - 1
	const EGG        ; eb

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
