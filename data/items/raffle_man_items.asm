; these numbers must between 0-255
; 10/256 chance to get a nugget

RaffleManItems:
	; eon mail
	db 1, EON_MAIL

	; recovery items
	db 9, MOOMOO_MILK
	db 9, ETHER
	db 8, MAX_ETHER
	db 6, ELIXER
	db 4, MAX_ELIXER
	db 4, REVIVE
	db 4, MAX_REVIVE
	db 2, SACRED_ASH

	; treasure items
	db 6, SILVER_LEAF
	db 6, GOLD_LEAF
	db 6, TINYMUSHROOM
	db 6, BIG_MUSHROOM
	db 6, NUGGET
	db 2, CRYSTAL

	; pokeballs
	db 8, POKE_BALL
	db 6, GREAT_BALL
	db 4, ULTRA_BALL
	db 2, SHINY_BALL
	db 2, MASTER_BALL

	; evolution stones
	db 6, MOON_STONE
	db 6, SUN_STONE
	db 6, FIRE_STONE
	db 6, THUNDERSTONE
	db 6, WATER_STONE
	db 6, LEAF_STONE
	db 6, EVERSTONE

	; vitamins
	db 40, RARE_CANDY
	db 9, HP_UP
	db 9, PROTEIN
	db 9, IRON
	db 9, CALCIUM
	db 9, ZINC
	db 9, CARBOS
	db 2, HYPER_EV_UP

	db -1 ; end
