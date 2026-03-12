PhoneScript_WantsToBattle_Male:
	farscall PhoneScript_RematchText_Male
	farsjump PhoneScript_HangUpText_Male

PhoneScript_WantsToBattle_Female:
	farscall PhoneScript_RematchText_Female
	farsjump PhoneScript_HangUpText_Female

PhoneScript_RematchText_Male:
	readvar VAR_CALLERID
	ifequal PHONE_COOLTRAINERM_GAVEN, .Gaven
	ifequal PHONE_BIRDKEEPER_JOSE, .Jose

.Gaven:
	farwritetext GavenBattleRematchText
	promptbutton
	end
.Jose:
	farwritetext JoseBattleRematchText
	promptbutton
	end

PhoneScript_RematchText_Female:
	readvar VAR_CALLERID
	ifequal PHONE_COOLTRAINERF_BETH, .Beth
	ifequal PHONE_COOLTRAINERF_REENA, .Reena
	ifequal PHONE_PICNICKER_ERIN, .Erin

.Beth:
	farwritetext BethBattleRematchText
	promptbutton
	end

.Reena:
	farwritetext ReenaBattleRematchText
	promptbutton
	end

.Erin:
	farwritetext ErinBattleRematchText
	promptbutton
	end

PhoneScript_HangUpText_Male:
	readvar VAR_CALLERID
	ifequal PHONE_COOLTRAINERM_GAVEN, .Gaven
	ifequal PHONE_BIRDKEEPER_JOSE, .Jose

.Gaven:
	farwritetext GavenHangUpText
	end
.Jose:
	farwritetext JoseHangUpText
	end

PhoneScript_HangUpText_Female:
	readvar VAR_CALLERID
	ifequal PHONE_COOLTRAINERF_BETH, .Beth
	ifequal PHONE_COOLTRAINERF_REENA, .Reena
	ifequal PHONE_PICNICKER_ERIN, .Erin

.Beth:
	farwritetext BethHangUpText
	end

.Reena:
	farwritetext ReenaHangUpText
	end

.Erin:
	farwritetext ErinHangUpText
	end

PhoneScript_FoundItem_Male:
	readvar VAR_CALLERID
	ifequal PHONE_BIRDKEEPER_JOSE, .Jose

.Jose:
	farwritetext JoseFoundItemText
	end

PhoneScript_FoundItem_Female:
	readvar VAR_CALLERID
	end
