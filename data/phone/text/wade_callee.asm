WadeAnswerPhoneText:
	text "Hello? This is"
	line "@"
	text_ram wStringBuffer3
	text " speaking."

	para "Oh, hi, <PLAY_G>!"
	done

WadeGreetText:
	text "<PLAY_G>, howdy!"

	para "It's me, @"
	text_ram wStringBuffer3
	text "."
	line "Isn't it nice out?"
	done
