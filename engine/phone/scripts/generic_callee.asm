PhoneScript_Random2:
	random 2
	end

PhoneScript_AnswerPhone_Male:
	readvar VAR_CALLERID
	ifequal PHONE_COOLTRAINERM_GAVEN, .Gaven
	ifequal PHONE_BIRDKEEPER_JOSE, .Jose

.Gaven:
	farwritetext GavenAnswerPhoneText
	promptbutton
	end
.Jose:
	farwritetext JoseAnswerPhoneText
	promptbutton
	end

PhoneScript_AnswerPhone_Female:
	readvar VAR_CALLERID
	ifequal PHONE_COOLTRAINERF_BETH, .Beth
	ifequal PHONE_COOLTRAINERF_REENA, .Reena
	ifequal PHONE_PICNICKER_ERIN, .Erin

.Beth:
	farwritetext BethAnswerPhoneText
	promptbutton
	end

.Reena:
	farwritetext ReenaAnswerPhoneText
	promptbutton
	end

.Erin:
	farwritetext ErinAnswerPhoneText
	promptbutton
	end

PhoneScript_GreetPhone_Male:
	readvar VAR_CALLERID
	ifequal PHONE_COOLTRAINERM_GAVEN, .Gaven
	ifequal PHONE_BIRDKEEPER_JOSE, .Jose

.Gaven:
	farwritetext GavenGreetText
	promptbutton
	end
.Jose:
	farwritetext JoseGreetText
	promptbutton
	end

PhoneScript_GreetPhone_Female:
	readvar VAR_CALLERID
	ifequal PHONE_COOLTRAINERF_BETH, .Beth
	ifequal PHONE_COOLTRAINERF_REENA, .Reena
	ifequal PHONE_PICNICKER_ERIN, .Erin

.Beth:
	farwritetext BethGreetText
	promptbutton
	end

.Reena:
	farwritetext ReenaGreetText
	promptbutton
	end

.Erin:
	farwritetext ErinGreetText
	promptbutton
	end
