AlanHangUpText:
	text "See you later!"
	done

AlanFoundItemText:
	text "Hehehe, I picked"
	line "up something nice!"

	para "You can have it!"
	line "Why don't you come"
	cont "to @"
	text_ram wStringBuffer5
	text_start
	cont "and pick it up?"
	done

AlanHaventPickedUpAnythingText:
	text "I haven't picked"
	line "up anything yet."

	para "I'll call you if I"
	line "find something."
	done

AlanComePickUpGiftText:
	text "I have to do my"
	line "homework, so can"
	cont "you come get your"
	cont "gift right away?"

	para "I'm waiting on"
	line "@"
	text_ram wStringBuffer5
	text "!"
	done
