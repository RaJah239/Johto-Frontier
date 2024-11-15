DanaPhoneCalleeScript:
	gettrainername STRING_BUFFER_3, LASS, DANA1
	checkflag ENGINE_DANA_READY_FOR_REMATCH
	iftrue .WantsBattle
	farscall PhoneScript_AnswerPhone_Female
	checkflag ENGINE_DANA_HAS_THUNDERSTONE
	iftrue .HasThunderstone
	farsjump DanaHangUpScript

.WantsBattle:
	getlandmarkname STRING_BUFFER_5, LANDMARK_ROUTE_38
	farsjump DanaReminderScript

.HasThunderstone:
	getlandmarkname STRING_BUFFER_5, LANDMARK_ROUTE_38
	farsjump DanaComePickUpScript

DanaPhoneCallerScript:
	gettrainername STRING_BUFFER_3, LASS, DANA1
	farscall PhoneScript_GreetPhone_Female
	farscall PhoneScript_Random2
	ifequal 0, .DanaWantsBattle
	farscall PhoneScript_Random2
	ifequal 1, .DanaHasThunderstone

.DanaWantsBattle:
	getlandmarkname STRING_BUFFER_5, LANDMARK_ROUTE_38
	setflag ENGINE_DANA_READY_FOR_REMATCH
	farsjump PhoneScript_WantsToBattle_Female

.DanaHasThunderstone:
	setflag ENGINE_DANA_HAS_THUNDERSTONE
	getlandmarkname STRING_BUFFER_5, LANDMARK_ROUTE_38
	farsjump PhoneScript_FoundItem_Female
