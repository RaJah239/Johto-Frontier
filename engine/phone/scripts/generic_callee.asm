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

.Beth:
	farwritetext BethAnswerPhoneText
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

.Beth:
	farwritetext BethGreetText
	promptbutton
	end
