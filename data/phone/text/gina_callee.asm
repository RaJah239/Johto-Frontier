GinaAnswerPhoneText:
	text "Hello? This is"
	line "@"
	text_ram wStringBuffer3
	text "…"

	para "Oh, <PLAY_G>!"
	line "Hi, how are you?"
	done

GinaGreetText:
	text "<PLAY_G>?"

	para "It's @"
	text_ram wStringBuffer3
	text ". Is"
	line "this a bad time?"
	done
