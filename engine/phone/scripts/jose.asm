JosePhoneCalleeScript:
	gettrainername STRING_BUFFER_3, BIRD_KEEPER, JOSE2
	checkflag ENGINE_JOSE_READY_FOR_REMATCH
	iftrue .WantsBattle
	farscall PhoneScript_AnswerPhone_Male
	checkflag ENGINE_JOSE_HAS_STAR_PIECE
	iftrue .HasItem
	farsjump JoseHangUpScript

.WantsBattle:
	getlandmarkname STRING_BUFFER_5, LANDMARK_ROUTE_27
	farsjump JoseReminderScript

.HasItem:
	getlandmarkname STRING_BUFFER_5, LANDMARK_ROUTE_27
	farsjump JoseReminderScript

JosePhoneCallerScript:
	gettrainername STRING_BUFFER_3, BIRD_KEEPER, JOSE2
	farscall PhoneScript_GreetPhone_Male
	farscall PhoneScript_Random2
	ifequal 0, JoseWantsBattle
	farscall PhoneScript_Random2
	ifequal 1, JoseHasStarPiece

JoseWantsBattle:
	getlandmarkname STRING_BUFFER_5, LANDMARK_ROUTE_27
	setflag ENGINE_JOSE_READY_FOR_REMATCH
	farsjump PhoneScript_WantsToBattle_Male


JoseHasStarPiece:
	setflag ENGINE_JOSE_HAS_STAR_PIECE
	getlandmarkname STRING_BUFFER_5, LANDMARK_ROUTE_27
	farsjump PhoneScript_FoundItem_Male
