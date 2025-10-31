MACRO mon_cry
; index, pitch, length
	dw \1, \2, \3
ENDM

PokemonCries::
; entries correspond to constants/pokemon_constants.asm
	table_width MON_CRY_LENGTH, PokemonCries
	mon_cry CRY_CYNDAQUIL,    839,   128 ; CYNDAQUIL
	mon_cry CRY_CYNDAQUIL,    801,   288 ; QUILAVA
	mon_cry CRY_TYPHLOSION,  3840,   212 ; TYPHLOSION
	mon_cry CRY_TOTODILE,    1132,   232 ; TOTODILE
	mon_cry CRY_TOTODILE,    1088,   272 ; CROCONAW
	mon_cry CRY_TOTODILE,    1020,   384 ; FERALIGATR
	mon_cry CRY_CHIKORITA,    -16,   176 ; CHIKORITA
	mon_cry CRY_CHIKORITA,    -34,   288 ; BAYLEEF
	mon_cry CRY_CHIKORITA,   -183,   512 ; MEGANIUM
	mon_cry CRY_TOGEPI,        16,   256 ; TOGEPI
	mon_cry CRY_TOGETIC,       59,    56 ; TOGETIC
	mon_cry CRY_TOGETIC,       59,    56 ; TOGEKISS
	mon_cry CRY_CHARMANDER,    96,   192 ; CHARMANDER
	mon_cry CRY_CHARMANDER,    32,   192 ; CHARMELEON
	mon_cry CRY_CHARMANDER,     0,   256 ; CHARIZARD
	mon_cry CRY_SQUIRTLE,      96,   192 ; SQUIRTLE
	mon_cry CRY_SQUIRTLE,      32,   192 ; WARTORTLE
	mon_cry CRY_BLASTOISE,      0,   256 ; BLASTOISE
	mon_cry CRY_TOGETIC,     $d00,  $050 ; TURTWIG SourApple
	mon_cry CRY_MARILL,      $eec,  $180 ; GROTLE SourApple
	mon_cry CRY_ENTEI,       $eee,  $480 ; TORTERRA SourApple
	mon_cry CRY_BULBASAUR,    238,   129 ; PIKACHU
	mon_cry CRY_RAICHU,       238,   136 ; RAICHU
	mon_cry CRY_VENONAT,      136,   224 ; EEVEE
	mon_cry CRY_VENONAT,     -233,   240 ; UMBREON
	mon_cry CRY_VENONAT,     $0b0,   $16f; SYLVEON Polisheddevs
	mon_cry CRY_HOOTHOOT,    $0ff,  $0c8 ; TORCHIC Celadonk
	mon_cry CRY_HOOTHOOT,    $0b9,  $124 ; COMBUSKEN Celadonk
	mon_cry CRY_TYPHLOSION,  $f43,  $100 ; BLAZIKEN SourApple
	mon_cry CRY_GRIMER,      $04d,  $0f0 ; FEEBAS SourApple
	mon_cry CRY_SQUIRTLE,    $084,  $23c ; MILOTIC SourApple
	mon_cry CRY_PIDGEY,      $740,  $337 ; ROWLET Ferropexola
	mon_cry CRY_PIDGEY,      $840,  $337 ; DARTRIX Ferropexola
	mon_cry CRY_PIDGEY,      $548,  $407 ; DECIDUEYE Ferropexola
	mon_cry CRY_GLIGAR,      $ffc,  $110 ; RALTS SourApple
	mon_cry CRY_VILEPLUME,   $008,  $100 ; KIRLIA Celadonk
	mon_cry CRY_VILEPLUME,   $f22,   163 ; GARDEVOIR Celadonk
	mon_cry CRY_SPEAROW,     $070,  $170 ; GALLADE
	mon_cry CRY_CATERPIE,    $073,  $100 ; WURMPLE
	mon_cry CRY_BLASTOISE,   $182,  $091 ; SILCOON
	mon_cry CRY_CATERPIE,    $07b,  $0c0 ; BEAUTIFLY
	mon_cry CRY_BLASTOISE,   $192,  $091 ; CASCOON
	mon_cry CRY_WEEDLE,      $013,  $081 ; DUSTOX
	mon_cry CRY_TOTODILE,      49,   200 ; YANMA
	mon_cry CRY_TOTODILE,   -$16f,  $168 ; YANMEGA AzureKeys
	mon_cry CRY_MARILL,       299,   184 ; SUNKERN
	mon_cry CRY_SUNFLORA,     -32,   384 ; SUNFLORA
	mon_cry CRY_BUNEARY,    -$012,  $09a ; BUNEARY Ax6
	mon_cry CRY_VULPIX,     -$00f,  $0a9 ; LOPUNNY Ax6
	mon_cry CRY_PIDGEY,       223,   132 ; PIDGEY
	mon_cry CRY_PIDGEOTTO,     40,   320 ; PIDGEOTTO
	mon_cry CRY_PIDGEOTTO,     17,   383 ; PIDGEOT
	mon_cry CRY_HOOTHOOT,     145,   216 ; HOOTHOOT
	mon_cry CRY_HOOTHOOT,       0,   416 ; NOCTOWL
	mon_cry CRY_SQUIRTLE,     224,   256 ; ZUBAT
	mon_cry CRY_SQUIRTLE,     250,   256 ; GOLBAT
	mon_cry CRY_SQUIRTLE,     -16,   320 ; CROBAT
	mon_cry CRY_TEDDIURSA,   1954,   110 ; TEDDIURSA
	mon_cry CRY_TEDDIURSA,   1600,   216 ; URSARING
	mon_cry CRY_TEDDIURSA,   $58e,  $0c8 ; URSALUNA
	mon_cry CRY_SENTRET,       72,   560 ; PHANPY
	mon_cry CRY_DONPHAN,        0,   416 ; DONPHAN
	mon_cry CRY_PSYDUCK,       85,   129 ; BELLSPROUT
	mon_cry CRY_WEEPINBELL,    68,   160 ; WEEPINBELL
	mon_cry CRY_WEEPINBELL,   102,   332 ; VICTREEBEL
	mon_cry CRY_MAREEP,        34,   216 ; MAREEP
	mon_cry CRY_MAREEP,        -7,   384 ; FLAAFFY
	mon_cry CRY_AMPHAROS,    -124,   232 ; AMPHAROS
	mon_cry CRY_NIDORAN_F,      0,   256 ; NIDORAN_F
	mon_cry CRY_NIDORAN_F,     44,   352 ; NIDORINA
	mon_cry CRY_NIDOQUEEN,      0,   256 ; NIDOQUEEN
	mon_cry CRY_NIDORAN_M,      0,   256 ; NIDORAN_M
	mon_cry CRY_NIDORAN_M,     44,   320 ; NIDORINO
	mon_cry CRY_RAICHU,         0,   256 ; NIDOKING
	mon_cry CRY_SPINARAK,    $450,  $1b3 ; WIMPOD
	mon_cry CRY_VENONAT,     $e0b,  $200 ; GOLISOPOD
	mon_cry CRY_MARILL,       283,   288 ; MARILL
	mon_cry CRY_MARILL,       182,   384 ; AZUMARILL
	mon_cry CRY_CHARMANDER,     0,   256 ; RHYHORN
	mon_cry CRY_RHYDON,         0,   256 ; RHYDON
	mon_cry CRY_TEDDIURSA,  -$018,  $0b3 ; DRILBUR Ax6
	mon_cry CRY_NIDOQUEEN,  -$108,  $14d ; EXCADRILL Ax6
	mon_cry CRY_EKANS,        255,   320 ; ONIX
	mon_cry CRY_TYPHLOSION,   239,   247 ; STEELIX
	mon_cry CRY_EKANS,        128,   128 ; MAGIKARP
	mon_cry CRY_EKANS,          0,   256 ; GYARADOS
	mon_cry CRY_METAPOD,        0,   256 ; GASTLY
	mon_cry CRY_METAPOD,       48,   192 ; HAUNTER
	mon_cry CRY_MUK,            0,   383 ; GENGAR
	mon_cry CRY_TOGETIC,     $010,  $017 ; SWABLU FrostedGeulleisia
	mon_cry CRY_NIDORAN_M,   $045,  $155 ; ALTARIA SourApple
	mon_cry CRY_NATU,        -103,   256 ; NATU
	mon_cry CRY_NATU,       -$07c,  $166 ; KATU
	mon_cry CRY_NATU,        -167,   360 ; XATU
	mon_cry CRY_PICHU,       -538,   496 ; SMEARGLE
	mon_cry CRY_GROWLITHE,     32,   192 ; GROWLITHE
	mon_cry CRY_WEEDLE,         0,   256 ; ARCANINE
	mon_cry CRY_CYNDAQUIL,     57,   320 ; HOUNDOUR
	mon_cry CRY_TOTODILE,    -266,   256 ; HOUNDOOM
	mon_cry CRY_WOOPER,       147,   175 ; WOOPER
	mon_cry CRY_WOOPER,      -198,   320 ; QUAGSIRE
	mon_cry CRY_GLIGAR,      -258,   256 ; GLIGAR
	mon_cry CRY_NIDOQUEEN,   $73d,  $1b0 ; GLISCOR AzureKeys
	mon_cry CRY_NIDORAN_F,   $f26,  $0c0 ; GIBLE SourApple
	mon_cry CRY_NIDORAN_F,   $e15,  $200 ; GABITE SourApple
	mon_cry CRY_RAICHU,      $f1f,  $130 ; GARCHOMP SourApple
	mon_cry CRY_MUK,         $02d,  $0a0 ; MAKUHITA SourApple
	mon_cry CRY_MUK,         $e22,  $1d0 ; HARIYAMA SourApple
	mon_cry CRY_DIGLETT,      187,   129 ; DODUO
	mon_cry CRY_DIGLETT,      153,   160 ; DODRIO
	mon_cry CRY_WEEPINBELL,     0,   256 ; PONYTA
	mon_cry CRY_WEEPINBELL,    32,   320 ; RAPIDASH
	mon_cry CRY_SLOWPOKE,       0,   256 ; SLOWPOKE
	mon_cry CRY_GROWLITHE,      0,   256 ; SLOWBRO
	mon_cry CRY_SHROOMISH,    255,   112 ; SHROOMISH PiaCRT
	mon_cry CRY_BRELOOM,       80,   278 ; BRELOOM PiaCRT
	mon_cry CRY_SPINARAK,      17,   512 ; SPINARAK
	mon_cry CRY_SPINARAK,    -174,   482 ; ARIADOS
	mon_cry CRY_SPINARAK,   -$1c7,  $1b0 ; VENIPEDE AzureKeys
	mon_cry CRY_TYPHLOSION,  $301,  $095 ; WHIRLIPEDE AzureKeys
	mon_cry CRY_TYPHLOSION,  $210,  $095 ; SCOLIPEDE AzureKeys
	mon_cry CRY_PIDGEY,      $16a,  $0d4 ; JOLTIK AzureKeys
	mon_cry CRY_NIDOQUEEN,   $035,  $0b6 ; GALVANTULA AzureKeys
	mon_cry CRY_AMPHAROS,    $1c8,  $190 ; SKORUPI AzureKeys
	mon_cry CRY_CLEFFA,     -$33e,  $200 ; DRAPION AzureKeys
	mon_cry CRY_CYNDAQUIL,  -$4c7,  $0f5 ; LARVESTA AzureKeys
	mon_cry CRY_METAPOD,    -$420,  $1a6 ; VOLCARONA AzureKeys
	mon_cry CRY_TYPHLOSION,  $c00,  $130 ; TROPIUS
	mon_cry CRY_NIDOQUEEN,    221,   224 ; MANKEY
	mon_cry CRY_NIDOQUEEN,    175,   192 ; PRIMEAPE
	mon_cry CRY_NIDOQUEEN,   -275,   212 ; ANNIHILAPE
	mon_cry CRY_MANTINE,     $032,  $080 ; FERROSEED AzureKeys
	mon_cry CRY_MANTINE,     $184,  $0a0 ; FERROTHORN AzureKeys
	mon_cry CRY_CATERPIE,       0,   256 ; SCYTHER
	mon_cry CRY_AMPHAROS,       0,   352 ; SCIZOR
	mon_cry CRY_CATERPIE,     -64,   256 ; KLEAVOR
	mon_cry CRY_AMPHAROS,      53,   224 ; HERACROSS
	mon_cry CRY_GOLEM,          0,   256 ; TANGELA
	mon_cry CRY_GOLEM,       $100,  $170 ; TANGROWTH
	mon_cry CRY_CLEFAIRY,     119,   144 ; MEOWTH
	mon_cry CRY_CLEFAIRY,     153,   383 ; PERSIAN
	mon_cry CRY_DUNSPARCE,    274,   232 ; SNUBBULL
	mon_cry CRY_DUNSPARCE,      0,   384 ; GRANBULL
	mon_cry CRY_DROWZEE,      136,   160 ; DROWZEE
	mon_cry CRY_DROWZEE,      238,   192 ; HYPNO
	mon_cry CRY_CLEFFA,      3904,   384 ; SUDOWOODO
	mon_cry CRY_GOLEM,        230,   349 ; KOFFING
	mon_cry CRY_GOLEM,        255,   383 ; WEEZING
	mon_cry CRY_GRIMER,         0,   256 ; GRIMER
	mon_cry CRY_MUK,          239,   383 ; MUK
	mon_cry CRY_WOOPER,      $030,  $0d0 ; LITWICK Ax6
	mon_cry CRY_CLEFAIRY,   -$02e,  $1dd ; LAMPENT Ax6
	mon_cry CRY_ENTEI,       $078,  $4c0 ; CHANDELURE Ax6
	mon_cry CRY_GLIGAR,      -461,   416 ; MILTANK
	mon_cry CRY_SQUIRTLE,      17,   192 ; TAUROS
	mon_cry CRY_VOLTORB,      237,   256 ; VOLTORB
	mon_cry CRY_VOLTORB,      168,   272 ; ELECTRODE
	mon_cry CRY_SUNFLORA,    -728,   180 ; ELEKID
	mon_cry CRY_VOLTORB,      143,   383 ; ELECTABUZZ
	mon_cry CRY_METAPOD,      128,   224 ; MAGNEMITE
	mon_cry CRY_METAPOD,       32,   320 ; MAGNETON
	mon_cry CRY_METAPOD,      -17,   512 ; MAGNEZONE
	mon_cry CRY_DUNSPARCE,    656,   168 ; SHUCKLE
	mon_cry CRY_MAGCARGO,     161,   232 ; CORSOLA
	mon_cry CRY_PARAS,          2,   160 ; STARYU
	mon_cry CRY_PARAS,          0,   256 ; STARMIE
	mon_cry CRY_SUNFLORA,      13,   256 ; REMORAID
	mon_cry CRY_TOTODILE,       0,   384 ; OCTILLERY
	mon_cry CRY_CYNDAQUIL,    969,   320 ; CHINCHOU
	mon_cry CRY_CYNDAQUIL,    720,   272 ; LANTURN
	mon_cry CRY_MANTINE,     -190,   240 ; MANTINE
	mon_cry CRY_VENONAT,        0,   256 ; TENTACOOL
	mon_cry CRY_VENONAT,      238,   383 ; TENTACRUEL
	mon_cry CRY_SEEL,         136,   320 ; SEEL
	mon_cry CRY_SEEL,          35,   383 ; DEWGONG
	mon_cry CRY_CLEFAIRY,     153,   144 ; HORSEA
	mon_cry CRY_CLEFAIRY,      60,   129 ; SEADRA
	mon_cry CRY_SLUGMA,       763,   256 ; KINGDRA
	mon_cry CRY_LAPRAS,         0,   256 ; LAPRAS
	mon_cry CRY_CLEFAIRY,     204,   129 ; CLEFAIRY
	mon_cry CRY_CLEFAIRY,     170,   160 ; CLEFABLE
	mon_cry CRY_SQUIRTLE,   $ffda,  $097 ; SOLROCK
	mon_cry CRY_SQUIRTLE,   $feda,  $097 ; LUNATONE
	mon_cry CRY_AIPOM,       -352,   384 ; STANTLER
	mon_cry CRY_BLASTOISE,    196,   187 ; WYRDEER
	mon_cry CRY_TEDDIURSA,      2,   106 ; DELIBIRD
	mon_cry CRY_MARILL,       104,   256 ; SMOOCHUM
	mon_cry CRY_DROWZEE,      255,   383 ; JYNX
	mon_cry CRY_PIDGEY,      $8a8,  $220 ; SNORUNT
	mon_cry CRY_BULBASAUR,   $fe0,  $150 ; GLALIE
	mon_cry CRY_PICHU,       $feb,  $500 ; FROSLASS
	mon_cry CRY_CYNDAQUIL,    510,   320 ; SWINUB
	mon_cry CRY_MAGCARGO,    -265,   256 ; PILOSWINE
	mon_cry CRY_TYPHLOSION, -$160,  $0d3 ; MAMOSWINE AzureKeys
	mon_cry CRY_WOOPER,        83,   175 ; SNEASEL
	mon_cry CRY_WOOPER,      $073,  $151 ; WEAVILE
    mon_cry CRY_SNEASLER,       0,   256 ; SNEASLER PiaCRT
	mon_cry CRY_CYNDAQUIL,   $10e,  $050 ; SNOVER SourApple
	mon_cry CRY_NATU,        $a5e,  $160 ; ABOMASNOW SourApple
	mon_cry CRY_SEEL,        $130,  $060 ; BALTOY SourApple
	mon_cry CRY_CLEFFA,      $e88,  $140 ; CLAYDOL SourApple
	mon_cry CRY_SUNFLORA,    $702,  $100 ; RIOLU AzureKeys
	mon_cry CRY_SLUGMA,     -$25c,  $0e0 ; LUCARIO AzureKeys
	mon_cry CRY_EKANS,       $101,  $086 ; BRONZOR Ax6
	mon_cry CRY_EKANS,       $12a,  $170 ; BRONZONG Ax6
	mon_cry CRY_AMPHAROS,    2217,   384 ; SKARMORY
	mon_cry CRY_HOOTHOOT,     304,   232 ; MISDREAVUS
	mon_cry CRY_HOOTHOOT,    $1b4,  $1e8 ; MISMAGIUS
	mon_cry CRY_PIDGEOTTO,     10,   320 ; CHANSEY
	mon_cry CRY_SLOWKING,     659,   320 ; BLISSEY
	mon_cry CRY_GRIMER,        85,   129 ; SNORLAX
	mon_cry CRY_RAIKOU,        95,   208 ; LARVITAR
	mon_cry CRY_SPINARAK,    -475,   336 ; PUPITAR
	mon_cry CRY_RAIKOU,      -256,   384 ; TYRANITAR
	mon_cry CRY_NIDORAN_F,   $f26,  $0c0 ; BAGON SourApple
	mon_cry CRY_NIDORAN_F,   $e15,  $200 ; SHELGON SourApple
	mon_cry CRY_RAICHU,      $f1f,  $130 ; SALAMENCE SourApple
	mon_cry CRY_CATERPIE,    $83c,  $0c0 ; AXEW AzureKeys
	mon_cry CRY_EKANS,       $9c5,  $170 ; FRAXURE AzureKeys
	mon_cry CRY_EKANS,       $7d8,  $190 ; HAXORUS AzureKeys
	mon_cry CRY_WEEPINBELL,   170,   383 ; PORYGON
	mon_cry CRY_GIRAFARIG,    115,   576 ; PORYGON2
	mon_cry CRY_RHYDON,      $050,  $180 ; PORYGON-Z
	mon_cry CRY_GROWLITHE,    240,   129 ; OMANYTE
	mon_cry CRY_GROWLITHE,    255,   192 ; OMASTAR
	mon_cry CRY_RATTATA,     $1fd,  $170 ; LILEEP SourApple
	mon_cry CRY_VILEPLUME,   $eea,  $200 ; CRADILY SourApple
	mon_cry CRY_VILEPLUME,     32,  368  ; AERODACTYL
	mon_cry CRY_ROTOM,         32,  556  ; ROTOM PiaCRT
	mon_cry CRY_SPEAROW,     $795,  $0a7 ; ABSOL SourApple
	mon_cry CRY_VULPIX,     -$107,  $0ca ; DURALUDON Ax6
	mon_cry CRY_CHARMANDER,  $160,  $160 ; GHOLDENGO
	mon_cry CRY_RAICHU,     -$1f8,  $0e8 ; DARKRAI Ax6
	mon_cry CRY_TEDDIURSA,   $58e,  $0c8 ; REGIROCK SourApple
	mon_cry CRY_MAGCARGO,    $f1c,  $20a ; REGICE SourApple
	mon_cry CRY_WOOPER,      $e82,  $480 ; REGISTEEL SourApple
	mon_cry CRY_TEDDIURSA,   $5bf,  $188 ; REGIGIGAS SourApple
	mon_cry CRY_RAICHU,       128,  192  ; ARTICUNO
	mon_cry CRY_FEAROW,       255,  256  ; ZAPDOS
	mon_cry CRY_RAICHU,       248,  192  ; MOLTRES
	mon_cry CRY_TYPHLOSION,     0,  256  ; LUGIA
	mon_cry CRY_RAIKOU,       558,  288  ; RAIKOU
	mon_cry CRY_ENTEI,          0,  416  ; ENTEI
	mon_cry CRY_MAGCARGO,       0,  384  ; SUICUNE
	mon_cry CRY_AIPOM,          0,  384  ; HO_OH
	mon_cry CRY_HOOTHOOT,     354,  256  ; UNOWN
	mon_cry CRY_HOOTHOOT,    $172,  $190 ; NOWN
	mon_cry CRY_AIPOM,       $041,  $0ae ; VICTINI SourApple
	mon_cry CRY_ENTEI,        330,  273  ; CELEBI
	mon_cry CRY_PIDGEY,       255,  383  ; DITTO
	mon_cry CRY_PARAS,        238,  383  ; MEW
	mon_cry CRY_PARAS,        153,  383  ; MEWTWO
	assert_table_length NUM_POKEMON
	mon_cry CRY_NIDORAN_M,     0,    0 ; 253
	mon_cry CRY_NIDORAN_M,     0,    0 ; 254
	mon_cry CRY_NIDORAN_M,     0,    0 ; 255
	assert_table_length $ff
