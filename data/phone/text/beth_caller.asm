BethBattleRematchText:
	text "Do you want to"
	line "battle? I'm going"
	cont "to win this time!"

	para "I'll be waiting"
	line "for you around"

	para "@"
	text_ram wStringBuffer5
	text "."
	line "Look for me, OK?"
	done

BethHangUpText:
	text "OK, bye-bye!"
	done

BethLetsBattleAgainSometimeText:
	text "Let's battle again"
	line "sometime!"
	done

BethReminderText:
	text "Um… <PLAY_G>?"
	line "What's wrong?"

	para "Did you forget our"
	line "deal?"

	para "@"
	text_ram wStringBuffer5
	text "."

	para "That's where I'm"
	line "waiting."
	done
