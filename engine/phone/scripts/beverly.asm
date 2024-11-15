BeverlyPhoneCalleeScript:
	gettrainername STRING_BUFFER_3, POKEFANF, BEVERLY1
	farscall PhoneScript_AnswerPhone_Female
	checkflag ENGINE_BEVERLY_HAS_NUGGET
	iftrue .HasNugget
	farsjump BeverlyHangUpScript

.HasNugget:
	getlandmarkname STRING_BUFFER_5, LANDMARK_NATIONAL_PARK
	farsjump BeverlyComePickUpScript

BeverlyPhoneCallerScript:
	gettrainername STRING_BUFFER_3, POKEFANF, BEVERLY1
	farscall PhoneScript_GreetPhone_Female
	setflag ENGINE_BEVERLY_HAS_NUGGET
	getlandmarkname STRING_BUFFER_5, LANDMARK_NATIONAL_PARK
	farsjump PhoneScript_FoundItem_Female
