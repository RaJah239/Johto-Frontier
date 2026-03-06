RooftopSaleMart:
	db 17 ; 17 max
	; pokeballs
	dbw POKE_BALL,          50
	dbw GREAT_BALL,        300
	dbw ULTRA_BALL,        600

	; good items
	dbw MAX_REPEL,          50	
	dbw ESCAPE_ROPE,        50
	dbw FULL_HEAL,          50
	dbw MAX_POTION,       1250
	dbw FULL_RESTORE,     1500
	dbw MAX_ELIXER,       2000
	dbw MAX_REVIVE,       2000

	; vitamins
	dbw HP_UP,            3000
	dbw PROTEIN,          3000
	dbw IRON,             3000
	dbw CALCIUM,          3000
	dbw ZINC,             3000
	dbw CARBOS,           3000

	; cannot purchase more than what present money can buy
	; perfect price because at max money, can only buy 49
	dbw RARE_CANDY,      20000
	db -1 ; end
