TullyPhoneCalleeScript:
	gettrainername STRING_BUFFER_3, FISHER, TULLY1
	checkflag ENGINE_TULLY_READY_FOR_REMATCH
	iftrue .WantsBattle
	farscall PhoneScript_AnswerPhone_Male
	checkflag ENGINE_TULLY_HAS_WATER_STONE
	iftrue .WaterStone
	farsjump TullyNoItemScript

.WantsBattle:
	getlandmarkname STRING_BUFFER_5, LANDMARK_ROUTE_42
	farsjump TullyForwardScript

.WaterStone:
	getlandmarkname STRING_BUFFER_5, LANDMARK_ROUTE_42
	farsjump TullyHurryScript

TullyPhoneCallerScript:
	gettrainername STRING_BUFFER_3, FISHER, TULLY1
	farscall PhoneScript_GreetPhone_Male
	farscall PhoneScript_Random2
	ifequal 0, .TullyWantsBattle
	farscall PhoneScript_Random2
	ifequal 1, .TullyFoundWaterStone

.TullyWantsBattle:
	getlandmarkname STRING_BUFFER_5, LANDMARK_ROUTE_42
	setflag ENGINE_TULLY_READY_FOR_REMATCH
	farsjump PhoneScript_WantsToBattle_Male

.TullyFoundWaterStone:
	setflag ENGINE_TULLY_HAS_WATER_STONE
	getlandmarkname STRING_BUFFER_5, LANDMARK_ROUTE_42
	farsjump PhoneScript_FoundItem_Male
