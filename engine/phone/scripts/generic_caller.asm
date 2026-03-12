PhoneScript_WantsToBattle_Male:
	farscall PhoneScript_RematchText_Male
	farsjump PhoneScript_HangUpText_Male

PhoneScript_WantsToBattle_Female:
	farscall PhoneScript_RematchText_Female
	farsjump PhoneScript_HangUpText_Female

PhoneScript_RematchText_Male:
	readvar VAR_CALLERID
	ifequal PHONE_COOLTRAINERM_GAVEN, .Gaven

.Gaven:
	farwritetext GavenBattleRematchText
	promptbutton
	end

PhoneScript_RematchText_Female:
	readvar VAR_CALLERID
	ifequal PHONE_COOLTRAINERF_BETH, .Beth
	ifequal PHONE_COOLTRAINERF_REENA, .Reena

.Beth:
	farwritetext BethBattleRematchText
	promptbutton
	end

.Reena:
	farwritetext ReenaBattleRematchText
	promptbutton
	end

PhoneScript_HangUpText_Male:
	readvar VAR_CALLERID
	ifequal PHONE_COOLTRAINERM_GAVEN, .Gaven

.Gaven:
	farwritetext GavenHangUpText
	end

PhoneScript_HangUpText_Female:
	readvar VAR_CALLERID
	ifequal PHONE_COOLTRAINERF_BETH, .Beth
	ifequal PHONE_COOLTRAINERF_REENA, .Reena

.Beth:
	farwritetext BethHangUpText
	end

.Reena:
	farwritetext ReenaHangUpText
	end

PhoneScript_FoundItem_Male:
	readvar VAR_CALLERID
	end

PhoneScript_FoundItem_Female:
	readvar VAR_CALLERID
	end
