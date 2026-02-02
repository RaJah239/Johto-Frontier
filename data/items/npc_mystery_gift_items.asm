; these numbers must between 0-255
NPC_MysteryGiftItems:
	; recovery items
	db 10, MOOMOO_MILK
	db 10, ETHER
	db 7, MAX_ETHER
	db 5, ELIXER
	db 3, MAX_ELIXER
	db 5, REVIVE
	db 3, MAX_REVIVE
	db 1, SACRED_ASH

	; pokeballs
	db 12, POKE_BALL
	db 8, GREAT_BALL
	db 5, ULTRA_BALL
	db 1, MASTER_BALL

	; evolution stones
	db 5, MOON_STONE
	db 5, SUN_STONE
	db 5, FIRE_STONE
	db 5, THUNDERSTONE
	db 5, WATER_STONE
	db 5, LEAF_STONE
	db 5, EVERSTONE

	; vitamins
	db 5, HP_UP
	db 5, PROTEIN
	db 5, IRON
	db 5, CALCIUM
	db 5, ZINC
	db 5, CARBOS
	db -1 ; end
