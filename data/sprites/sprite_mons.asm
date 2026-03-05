SpriteMons:
; entries correspond to SPRITE_* constants past SPRITE_POKEMON
	table_width 1, SpriteMons
	db UNOWN
	db TURTWIG
	db GROWLITHE
	db TURTWIG ; was WEEDLE
	db RAIKOU
	db ENTEI
	db GENGAR
	db ZUBAT
	db MAGIKARP
	db SQUIRTLE
	db CHANSEY
	db DITTO
	db FEEBAS
	db PIKACHU
	db CLEFAIRY
	db CHARMANDER
	db NATU
	db STARMIE
	db DITTO
	db RAIKOU
	db GRIMER
	db BLISSEY
	db AMPHAROS
	db TENTACOOL
	db TAUROS
	db DITTO
	db VOLTORB
	db LAPRAS
	db URSALUNA
	db MOLTRES
	db SNORLAX
	db GYARADOS
	db LUGIA
	db HO_OH
	db GHOLDENGO

; in use
	db PIDGEY
	db SLOWPOKE
	db SCYTHER
	assert_table_length NUM_POKEMON_SPRITES
