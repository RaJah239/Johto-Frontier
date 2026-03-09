ElmPhoneCalleeScript:
	readvar VAR_SPECIALPHONECALL
	ifequal SPECIALCALL_POKERUS, .pokerus
	farwritetext ElmPhoneHealYourMonText
	end

.pokerus
	farwritetext ElmPhoneDiscoveredPokerusText
	specialphonecall SPECIALCALL_NONE
	end

ElmPhoneCallerScript:
	readvar VAR_SPECIALPHONECALL
	ifequal SPECIALCALL_MASTERBALL, .gift
	farwritetext ElmPhoneDiscoveredPokerusText
	specialphonecall SPECIALCALL_NONE
	end

.gift
	farwritetext ElmPhoneGiftText
	specialphonecall SPECIALCALL_NONE
	end
