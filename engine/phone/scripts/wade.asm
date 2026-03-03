WadePhoneCalleeScript:
	gettrainername STRING_BUFFER_3, BUG_CATCHER, WADE1
	farscall PhoneScript_AnswerPhone_Male
	checkflag ENGINE_WADE_HAS_ITEM
	iftrue .HasItem
	farsjump WadeHangUpScript

.HasItem:
	getlandmarkname STRING_BUFFER_5, LANDMARK_ROUTE_3
	farsjump WadeComeQuickScript

WadePhoneCallerScript:
	gettrainername STRING_BUFFER_3, BUG_CATCHER, WADE1
	farscall PhoneScript_GreetPhone_Male
	setflag ENGINE_WADE_HAS_ITEM
	getlandmarkname STRING_BUFFER_5, LANDMARK_ROUTE_3
	farsjump PhoneScript_FoundItem_Male
