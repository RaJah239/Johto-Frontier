; AI_FINAL_ATTACK discourages these moves when the player can KO the AI Pokemon
; (repo A's list). This does not include most stat increasing moves as they
; are handled in AI_Smart

StallMoves:
	db LEER
	db GROWL
	db DISABLE
	db COUNTER
	db LEECH_SEED
	db GROWTH
	db AGILITY
	db SCREECH
	db HARDEN
	db DEFENSE_CURL
	db LIGHT_SCREEN
	db HAZE
	db REFLECT
	db FOCUS_ENERGY
	db AMNESIA
	db TRANSFORM
	db SPLASH
	db SUBSTITUTE
	db -1 ; end
