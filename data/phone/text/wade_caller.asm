WadeHangUpText:
	text "See you later!"
	done

WadeFoundItemText:
	text "I found an awesome"
	line "Berry. If you want"
	cont "it, drop on by."

	para "I'll be waiting on"
	line "@"
	text_ram wStringBuffer5
	text "."
	done

WadeNoBerriesText:
	text "Huh? Berries?"

	para "Sorry, I haven't"
	line "found any yet."

	para "I'll call you if I"
	line "find any. Will you"
	cont "please wait?"
	done

WadeComeQuickText:
	text "How come you're"
	line "not here yet?"

	para "@"
	text_ram wStringBuffer5
	text " is"
	line "where I am."

	para "Please get here as"
	line "soon as you can!"
	done
