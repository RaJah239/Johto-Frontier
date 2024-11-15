GinaPhoneCalleeScript:
	gettrainername STRING_BUFFER_3, PICNICKER, GINA1
	checkflag ENGINE_GINA_READY_FOR_REMATCH
	iftrue .WantsBattle
	farscall PhoneScript_AnswerPhone_Female
	checkflag ENGINE_GINA_HAS_LEAF_STONE
	iftrue .HasLeafStone
	farsjump GinaHangUpScript

.WantsBattle:
	getlandmarkname STRING_BUFFER_5, LANDMARK_ROUTE_34
	farsjump GinaReminderScript

.HasLeafStone:
	getlandmarkname STRING_BUFFER_5, LANDMARK_ROUTE_34
	farsjump GinaComePickUpScript

GinaPhoneCallerScript:
	gettrainername STRING_BUFFER_3, PICNICKER, GINA1
	farscall PhoneScript_GreetPhone_Female
	farscall PhoneScript_Random2
	ifequal 0, .GinaWantsBattle
	farscall PhoneScript_Random2
	ifequal 1, .GinaHasLeafStone

.GinaWantsBattle:
	getlandmarkname STRING_BUFFER_5, LANDMARK_ROUTE_34
	setflag ENGINE_GINA_READY_FOR_REMATCH
	farsjump PhoneScript_WantsToBattle_Female

.GinaHasLeafStone:
	setflag ENGINE_GINA_HAS_LEAF_STONE
	getlandmarkname STRING_BUFFER_5, LANDMARK_ROUTE_34
	farsjump PhoneScript_FoundItem_Female
