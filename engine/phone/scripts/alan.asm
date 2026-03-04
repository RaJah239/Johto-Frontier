AlanPhoneCalleeScript:
	gettrainername STRING_BUFFER_3, SCHOOLBOY, ALAN1
	farscall PhoneScript_AnswerPhone_Male
	checkflag ENGINE_ALAN_HAS_FIRE_STONE
	iftrue .FireStone
	farsjump AlanHangUpScript

.FireStone:
	getlandmarkname STRING_BUFFER_5, LANDMARK_ROUTE_8
	farsjump AlanComePickUpScript

AlanPhoneCallerScript:
	gettrainername STRING_BUFFER_3, SCHOOLBOY, ALAN1
	farscall PhoneScript_GreetPhone_Male
	setflag ENGINE_ALAN_HAS_FIRE_STONE
	getlandmarkname STRING_BUFFER_5, LANDMARK_ROUTE_8
	farsjump PhoneScript_FoundItem_Male
