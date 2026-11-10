SpriteMons:
; entries correspond to SPRITE_* constants past SPRITE_POKEMON
	table_width 2, SpriteMons ; dw species (16-bit indexes)
	dw UNOWN
	dw TURTWIG
	dw GROWLITHE
	dw TURTWIG ; was WEEDLE
	dw RAIKOU
	dw ENTEI
	dw GENGAR
	dw ZUBAT
	dw MAGIKARP
	dw SQUIRTLE
	dw CHANSEY
	dw TANGELA
	dw FEEBAS
	dw PIKACHU
	dw CLEFAIRY
	dw CHARMANDER
	dw NATU
	dw STARMIE
	dw DITTO
	dw MARILL ; in use
	dw GRIMER
	dw BLISSEY
	dw AMPHAROS
	dw TENTACOOL
	dw MILTANK ; in use
	dw HARIYAMA ; in use
	dw ELECTRODE
	dw LAPRAS
	dw RHYDON ; in use
	dw MOLTRES ; in use
	dw SNORLAX
	dw GYARADOS ; in use
	dw LUGIA ; in use
	dw HO_OH ; in use
	dw GHOLDENGO ; in use
	dw PIDGEY ; in use
	dw SLOWPOKE ; in use
	dw SCYTHER ; in use
	dw MEOWTH ; in use
	assert_table_length NUM_POKEMON_SPRITES
