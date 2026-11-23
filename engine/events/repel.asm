RepelWoreOffScript::
	opentext
	writetext .RepelWoreOffText
	waitendtext

.RepelWoreOffText:
	text_far _RepelWoreOffText
	text_end

UseAnotherRepelScript::
	opentext
	readmem wRepelType
	getitemname STRING_BUFFER_3, USE_SCRIPT_VAR
	writetext .text
	yesorno
	iffalse_endtext
	callasm DoItemEffect
	endtext

.text:
	text_far _UseAnotherRepelText
	text_end
