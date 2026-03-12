PhoneScript_Random2:
	random 2
	end

PhoneScript_AnswerPhone_Male:
	readvar VAR_CALLERID
	ifequal PHONE_COOLTRAINERM_GAVEN, .Gaven

.Gaven:
	farwritetext GavenAnswerPhoneText
	promptbutton
	end

PhoneScript_AnswerPhone_Female:
	readvar VAR_CALLERID
	ifequal PHONE_COOLTRAINERF_BETH, .Beth
	ifequal PHONE_COOLTRAINERF_REENA, .Reena

.Beth:
	farwritetext BethAnswerPhoneText
	promptbutton
	end

.Reena:
	farwritetext ReenaAnswerPhoneText
	promptbutton
	end

PhoneScript_GreetPhone_Male:
	readvar VAR_CALLERID
	ifequal PHONE_COOLTRAINERM_GAVEN, .Gaven

.Gaven:
	farwritetext GavenGreetText
	promptbutton
	end

PhoneScript_GreetPhone_Female:
	readvar VAR_CALLERID
	ifequal PHONE_COOLTRAINERF_BETH, .Beth
	ifequal PHONE_COOLTRAINERF_REENA, .Reena

.Beth:
	farwritetext BethGreetText
	promptbutton
	end

.Reena:
	farwritetext ReenaGreetText
	promptbutton
	end
