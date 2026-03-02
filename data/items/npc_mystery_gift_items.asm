; these numbers must between 0-255
; 10/256 chance to get a berry

NPC_MysteryGiftItems:
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

	; berries
	db 6, MIRACLEBERRY
	db 6, SILVER_BERRY
	db 6, GOLD_BERRY

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
	db 6, HP_UP
	db 6, PROTEIN
	db 6, IRON
	db 6, CALCIUM
	db 6, ZINC
	db 6, CARBOS
	db 2, HYPER_EV_UP
	db -1 ; end
