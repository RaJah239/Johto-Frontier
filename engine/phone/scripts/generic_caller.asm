PhoneScript_WantsToBattle_Male:
	farscall PhoneScript_RematchText_Male
	farsjump PhoneScript_HangUpText_Male

PhoneScript_WantsToBattle_Female:
	farscall PhoneScript_RematchText_Female
	farsjump PhoneScript_HangUpText_Female

PhoneScript_RematchText_Male:
	readvar VAR_CALLERID
	end

PhoneScript_RematchText_Female:
	readvar VAR_CALLERID
	ifequal PHONE_COOLTRAINERF_BETH, .Beth

.Beth:
	farwritetext BethBattleRematchText
	promptbutton
	end

PhoneScript_HangUpText_Male:
	readvar VAR_CALLERID
	end

PhoneScript_HangUpText_Female:
	readvar VAR_CALLERID
	ifequal PHONE_COOLTRAINERF_BETH, .Beth

.Beth:
	farwritetext BethHangUpText
	end

PhoneScript_FoundItem_Male:
	readvar VAR_CALLERID
	end

PhoneScript_FoundItem_Female:
	readvar VAR_CALLERID
	end
