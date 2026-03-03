Route3_MapEvents:
	def_warp_events
	warp_event  4,  6, ROUTE_3_VIOLET_GATE, 3
	warp_event  4,  7, ROUTE_3_VIOLET_GATE, 4
	warp_event 34,  5, DARK_CAVE_VIOLET_ENTRANCE, 1

	def_coord_events

	def_bg_events
	bg_event  7,  5, BGEVENT_JUMPTEXT, Route3SignText
	bg_event 31,  5, BGEVENT_JUMPTEXT, DarkCaveSignText
	bg_event 16,  7, BGEVENT_JUMPSTD, NO_BERRY_OR_FRUIT_SCRIPT
	bg_event 29,  7, BGEVENT_JUMPSTD, NO_BERRY_OR_FRUIT_SCRIPT

	def_object_events
	object_event 17,  7, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route3MailRecipientScript, -1
	object_event  9,  5, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route3YoungsterText, -1
	object_event 21, 13, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 5, TrainerRoute3BugCatcher1, -1
	object_event 27,  8, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_RIGHT, 1, 1, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route3CooltrainerMText, -1
	object_event 30,  4, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, Route3Potion, EVENT_ROUTE_3_POTION
	object_event 19, 15, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, Route3PokeBall, EVENT_ROUTE_3_POKE_BALL
	object_event 16,  7, SPRITE_BERRY, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_YELLOW, OBJECTTYPE_SCRIPT, 0, Route3BerryTree, EVENT_ROUTE_3_BERRY
	object_event 29,  7, SPRITE_APRICORN, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_BLACK, OBJECTTYPE_SCRIPT, 0, Route3ApricornTree, EVENT_ROUTE_3_APRICORN

	object_const_def
	const ROUTE3_FISHER
	const ROUTE3_YOUNGSTER
	const ROUTE3_BUG_CATCHER
	const ROUTE3_COOLTRAINER_M
	const ROUTE3_POKE_BALL1
	const ROUTE3_POKE_BALL2
	const ROUTE3_BERRY_TREE
	const ROUTE3_APRICORN_TREE

Route3_MapScripts:
	def_scene_scripts

	def_callbacks

Route3MailRecipientScript:
	faceplayeropentext
	checkevent EVENT_GOT_TM_DARK_PULSE
	iftrue .DescribeDarkPulse
	checkevent EVENT_GOT_KENYA
	iftrue .TryGiveKenya
	jumpthisopenedtext
		text "… Hnuurg… Huh?"

		para "I walked too far"
		line "today looking for"
		cont "#mon."

		para "My feet hurt and"
		line "I'm sleepy…"

		para "If I were a wild"
		line "#mon, I'd be"
		cont "easy to catch…"

		para "…Zzzz…"
		done

.TryGiveKenya:
	writethistext
		text "…Zzzz… Huh?"

		para "What's that? You"
		line "have mail for me?"
		done
	promptbutton
	checkpokemail ReceivedSpearowMailText
	ifequal POKEMAIL_WRONG_MAIL, .WrongMail
	ifequal POKEMAIL_REFUSED, .Refused
	ifequal POKEMAIL_NO_MAIL, .NoMail
	ifequal POKEMAIL_LAST_MON, .LastMon
	; POKEMAIL_CORRECT
	writethistext
		text "<PLAYER> handed"
		line "over the #mon"
		cont "holding the mail."
		done
	promptbutton
	writethistext
		text "Let's see…"

		para "…Dark Cave leads"
		line "to another road…"

		para "That's good to"
		line "know."

		para "Thanks for bring-"
		line "ing this to me."

		para "My friend's a good"
		line "guy, and you're"
		cont "swell too!"

		para "I'd like to do"
		line "something good in"
		cont "return too!"

		para "I know! I want you"
		line "to have this!"
		done
	promptbutton
	setevent EVENT_GAVE_KENYA
	verbosegiveitem TM_TRICK
	iffalse_endtext
	setevent EVENT_GOT_TM_DARK_PULSE
.DescribeDarkPulse:
	writethistext
	text "It's Dark Pulse."

	para "A wicked move! May"
	line "cause flinching!"

	para "One single extra"
	line "turn can swing the"
	cont "tide of battle!"

	line "Scary…"
	done

.WrongMail:
	jumpthisopenedtext
		text "This mail isn't"
		line "for me."
		done

.Refused:
	jumpthisopenedtext
		text "What? You don't"
		line "want anything?"
		done

.NoMail:
	jumpthisopenedtext
		text "Why is this #-"
		line "mon so special?"

		para "It doesn't have"
		line "any mail."
		done

.LastMon:
	jumpthisopenedtext
		text "If I take that"
		line "#mon from you,"
		cont "what are you going"
		cont "to use in battle?"
		done

ReceivedSpearowMailText:
	db   "Dark Cave leads"
	next "to another road@"

TrainerRoute3BugCatcher1:
	trainer BUG_CATCHER, WADE1, EVENT_BEAT_BUG_CATCHER_WADE, .SeenText, .BeatenText, 0, .Script

.SeenText
	text "I caught a bunch"
	line "of #mon. Let me"
	cont "battle with you!"
	done

.BeatenText
	text "Awwwww…"
	done

.Script:
	endifjustbattled
	loadvar VAR_CALLERID, PHONE_BUG_CATCHER_WADE
	opentext
	checkflag ENGINE_WADE_HAS_ITEM
	iftrue .WadeItem
	checkcellnum PHONE_BUG_CATCHER_WADE
	iftrue .AcceptedNumber
	checkevent EVENT_WADE_ASKED_FOR_PHONE_NUMBER
	iftrue .AskAgain
	writethistext
.AfterText
		text "You can catch"
		line "#mon even if"
		para "you have six with"
		line "you."

		para "If you catch one,"
		line "it'll go to your PC"
		cont "Box automatically."
		done
	waitbutton
	setevent EVENT_WADE_ASKED_FOR_PHONE_NUMBER
.AskAgain:
	callstd AskNumberMScript
	askforphonenumber PHONE_BUG_CATCHER_WADE
	ifequal PHONE_CONTACT_REFUSED, .DeclinedNumber
	gettrainername STRING_BUFFER_3, BUG_CATCHER, WADE1
	callstd RegisteredNumberMScript
	sjump .AcceptedNumber

.WadeItem:
	callstd GiftMScript
	random 3
	ifequal 1, .SilverBerry
	ifequal 2, .GoldBerry
	verbosegiveitem MIRACLEBERRY
.finish:
	iffalse .done
	clearflag ENGINE_WADE_HAS_ITEM
.done:
	end

.SilverBerry:
	verbosegiveitem SILVER_BERRY
	sjump .finish

.GoldBerry:
	verbosegiveitem GOLD_BERRY
	sjump .finish

.AcceptedNumber:
	jumpstd NumberAcceptedMScript

.DeclinedNumber:
	jumpstd NumberDeclinedMScript

Route3CooltrainerMText:
	text "Dark Cave…"

	para "If #mon could"
	line "light it up, I'd"
	cont "explore it."
	done

Route3YoungsterText:
	text "I found a good"
	line "#mon in Dark"
	cont "Cave."

	para "I'm going to raise"
	line "it to take on"
	cont "Falkner."

	para "He's the leader of"
	line "Violet City's Gym."
	done

Route3SignText:
	text "Route 3"

	para "Violet City -"
	line "Cherrygrove City"
	done

DarkCaveSignText:
	text "Dark Cave"
	done

Route3Potion:
	itemball POTION

Route3PokeBall:
	itemball POKE_BALL

Route3BerryTree:
	setval BITTER_BERRY
	setlasttalked ROUTE3_BERRY_TREE
	jumpstd BerryOrFruitScript


Route3ApricornTree:
	setval BLK_APRICORN
	setlasttalked ROUTE3_APRICORN_TREE
	jumpstd BerryOrFruitScript
