	object_const_def
	const MRPOKEMONSHOUSE_GENTLEMAN

MrPokemonsHouse_MapScripts:
	def_scene_scripts

	def_callbacks

MrPokemonsHouse_ForeignMagazines:
	jumptext MrPokemonsHouse_ForeignMagazinesText

MrPokemonsHouse_BrokenComputer:
	jumptext MrPokemonsHouse_BrokenComputerText

MrPokemonsHouse_StrangeCoins:
	jumptext MrPokemonsHouse_StrangeCoinsText

MrPokemonsHouse_MrPokemonScript:
	faceplayer
	opentext
	checkevent EVENT_MR_POKEMON_TOGEPI_EGG
	iffalse .CollectThisEggFirst
	writetextcheckdialogue MrPokemonTradesSilverLeafText, MrPokemonTradesSilverLeafTextMin
	yesorno
	iffalse .LifeIsDelightful
	checkitem SILVER_LEAF, 10
	iftrue .TradeForGoldLeaf
	writetextend NotEnoughSilverLeafText

.CollectThisEggFirst
	writetext MrPokemonTogepiEggText
	promptbutton
	readvar VAR_PARTYCOUNT
	ifequal PARTY_LENGTH, .PartyFull
	giveegg TOGEPI, EGG_LEVEL
	getstring STRING_BUFFER_4, .eggname
	callstd ReceiveTogepiEggScript
	setevent EVENT_MR_POKEMON_TOGEPI_EGG
.LifeIsDelightful
	writetextend MrPokemonText_GoodLifeText

.TradeForGoldLeaf:
	verbosegiveitem GOLD_LEAF
	iffalse .NotEnoughSpace
	takeitem SILVER_LEAF, 10
	writetextend MrPokemonThanksForTheTradeText

.NotEnoughSpace:
	writetextend NotEnoughSpaceText

.eggname:
	db "Egg@"

.PartyFull:
	writetextend MrPokemonFullPartyText

MrPokemonTogepiEggText:
	text "The owners of a"
	line "Day Care gave me"
	cont "this Egg but it"
	cont "needs to be in a"
	cont "party to hatch."

	para "You can have it,"
	line "young trainer."
	done

MrPokemonTradesSilverLeafText:
	text "I collect the rare"
	line "Silver Leaf."

	para "I'm up for trading"
	line "10× Silver Leaf"
	cont "for 1× Gold Leaf."

	para "How about it?"
	done

MrPokemonTradesSilverLeafTextMin:
	text "Up for a trade?"

	para "10× Silver Leaf"
	line "for 1× Gold Leaf?"
	done

NotEnoughSpaceText:
	text "Your bag needs"
	line "more room to take"
	cont "this."
	done


NotEnoughSilverLeafText:
	text "You don't have the"
	line "required amount…"
	done

MrPokemonThanksForTheTradeText:
	text "Thanks! Swing by"
	line "any time!"
	done

MrPokemonFullPartyText:
	text "Oh, no. You can't"
	line "carry any more"
	cont "#mon with you."

	para "You'll have to make"
	line "room for this Egg."
	done

MrPokemonText_GoodLifeText:
	text "It's a good life!"
	line "Lots to enjoy!"
	done

MrPokemonsHouse_ForeignMagazinesText:
	text "It's packed with"
	line "foreign magazines."

	para "Can't even read"
	line "their titles…"
	done

MrPokemonsHouse_BrokenComputerText:
	text "It's a big com-"
	line "puter. Hmm. It's"
	cont "broken."
	
	para "Maybe he was a"
	line "researcher before…"
	done

MrPokemonsHouse_StrangeCoinsText:
	text "A whole pile of"
	line "strange coins!"

	para "Maybe they're from"
	line "another country…"
	done

MrPokemonsHouse_MapEvents:
	def_warp_events
	warp_event  2,  7, ROUTE_30, 2
	warp_event  3,  7, ROUTE_30, 2

	def_coord_events

	def_bg_events
	bg_event  0,  1, BGEVENT_READ, MrPokemonsHouse_ForeignMagazines
	bg_event  1,  1, BGEVENT_READ, MrPokemonsHouse_ForeignMagazines
	bg_event  6,  1, BGEVENT_READ, MrPokemonsHouse_BrokenComputer
	bg_event  7,  1, BGEVENT_READ, MrPokemonsHouse_BrokenComputer
	bg_event  6,  4, BGEVENT_READ, MrPokemonsHouse_StrangeCoins

	def_object_events
	object_event  3,  5, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, MrPokemonsHouse_MrPokemonScript, -1
