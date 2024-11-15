BeverlyHangUpText:
	text "Until then, bye!"
	done

BeverlyFoundItemText:
	text "I found a NUGGET."
	line "If you'd like, you"
	cont "could have it."

	para "I'll be at"
	line "@"
	text_ram wStringBuffer5
	text "."

	para "Please come see me"
	line "when you can."
	done

BeverlyLetsChatAboutMonAgainText:
	text "Are your #MON"
	line "in prime form?"

	para "I'll call you if I"
	line "find any items."
	done

BeverlyComePickUpText:
	text "Pardon?"
	line "Oh, the NUGGET?"

	para "There's no need to"
	line "hurry. Come see me"

	para "in @"
	text_ram wStringBuffer5
	text_start
	line "when you can."
	done
