AlanPhoneCalleeScript:
	gettrainername STRING_BUFFER_3, SCHOOLBOY, ALAN1
	checkflag ENGINE_ALAN_READY_FOR_REMATCH
	iftrue .WantsBattle
	farscall PhoneScript_AnswerPhone_Male
	checkflag ENGINE_ALAN_HAS_FIRE_STONE
	iftrue .FireStone
	farsjump AlanHangUpScript

.WantsBattle:
	getlandmarkname STRING_BUFFER_5, LANDMARK_ROUTE_36
	farsjump AlanReminderScript

.FireStone:
	getlandmarkname STRING_BUFFER_5, LANDMARK_ROUTE_36
	farsjump AlanComePickUpScript

AlanPhoneCallerScript:
	gettrainername STRING_BUFFER_3, SCHOOLBOY, ALAN1
	farscall PhoneScript_GreetPhone_Male
	farscall PhoneScript_Random2
	ifequal 0, .AlanWantsBattle
	farscall PhoneScript_Random2
	ifequal 1, .AlanHasFireStone

.AlanWantsBattle:
	getlandmarkname STRING_BUFFER_5, LANDMARK_ROUTE_36
	setflag ENGINE_ALAN_READY_FOR_REMATCH
	farsjump PhoneScript_WantsToBattle_Male

.AlanHasFireStone:
	setflag ENGINE_ALAN_HAS_FIRE_STONE
	getlandmarkname STRING_BUFFER_5, LANDMARK_ROUTE_36
	farsjump PhoneScript_FoundItem_Male
