TiffanyPhoneCalleeScript:
	gettrainername STRING_BUFFER_3, PICNICKER, TIFFANY3
	checkflag ENGINE_TIFFANY_READY_FOR_REMATCH
	iftrue .WantsBattle
	farscall PhoneScript_AnswerPhone_Female
	checkflag ENGINE_TIFFANY_HAS_PINK_BOW
	iftrue .HasItem
	farsjump TiffanyNoItemScript

.WantsBattle:
	getlandmarkname STRING_BUFFER_5, LANDMARK_ROUTE_43
	farsjump TiffanyAsleepScript

.HasItem:
	getlandmarkname STRING_BUFFER_5, LANDMARK_ROUTE_43
	farsjump TiffanyHurryScript

TiffanyPhoneCallerScript:
	gettrainername STRING_BUFFER_3, PICNICKER, TIFFANY3
	farscall PhoneScript_GreetPhone_Female
	farscall PhoneScript_Random2
	ifequal 0, .TiffanyWantsBattle
	farscall PhoneScript_Random2
	ifequal 1, .TiffanyHasPinkBow

.TiffanyHasPinkBow:
	setflag ENGINE_TIFFANY_HAS_PINK_BOW
	getlandmarkname STRING_BUFFER_5, LANDMARK_ROUTE_43
	farsjump PhoneScript_FoundItem_Female

.TiffanyWantsBattle:
	getlandmarkname STRING_BUFFER_5, LANDMARK_ROUTE_43
	setflag ENGINE_TIFFANY_READY_FOR_REMATCH
	farsjump PhoneScript_WantsToBattle_Female
