HeldStatUpItems:
	dbw HELD_SPEED_UP,        BattleCommand_SpeedUp
	db -1 ; end

HeldWeatherItems:
	dbw HELD_SET_RAIN,		BattleCommand_ItemRain
	dbw HELD_SET_SUN,       BattleCommand_ItemSun
	dbw HELD_SET_SAND, 		BattleCommand_ItemSandstorm
	dbw HELD_SET_HAIL, 		BattleCommand_ItemHail
	db -1 ; end
