WiltonPhoneCalleeScript:
	gettrainername STRING_BUFFER_3, FISHER, WILTON1
	checkflag ENGINE_WILTON_READY_FOR_REMATCH
	iftrue .WantsBattle
	farscall PhoneScript_AnswerPhone_Male
	checkflag ENGINE_WILTON_HAS_ITEM
	iftrue .HasItem
	farsjump WiltonHaventFoundAnythingScript

.WantsBattle:
	getlandmarkname STRING_BUFFER_5, LANDMARK_ROUTE_44
	farsjump WiltonNotBitingScript

.HasItem:
	getlandmarkname STRING_BUFFER_5, LANDMARK_ROUTE_44
	farsjump WiltonWantThisScript

WiltonPhoneCallerScript:
	gettrainername STRING_BUFFER_3, FISHER, WILTON1
	farscall PhoneScript_GreetPhone_Male
	farscall PhoneScript_Random2
	ifequal 0, WiltonWantsBattle
	farscall PhoneScript_Random2
	ifequal 1, WiltonHasItem

WiltonWantsBattle:
	getlandmarkname STRING_BUFFER_5, LANDMARK_ROUTE_44
	setflag ENGINE_WILTON_READY_FOR_REMATCH
	farsjump PhoneScript_WantsToBattle_Male

WiltonHasItem:
	setflag ENGINE_WILTON_HAS_ITEM
	getlandmarkname STRING_BUFFER_5, LANDMARK_ROUTE_44
	farsjump PhoneScript_FoundItem_Male
