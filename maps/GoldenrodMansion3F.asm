GoldenrodMansion3F_MapEvents:
	def_warp_events
	warp_event  0,  0, GOLDENROD_MANSION_ROOF, 1
	warp_event  1,  0, GOLDENROD_MANSION_2F, 2
	warp_event  6,  0, GOLDENROD_MANSION_2F, 3
	warp_event  7,  0, GOLDENROD_MANSION_ROOF, 2

	def_coord_events

	def_bg_events
	bg_event  5,  8, BGEVENT_UP, GoldenrodMansion3FDevRoomSign
	bg_event  4,  3, BGEVENT_UP, GoldenrodMansion3FDrawing
	bg_event  1,  6, BGEVENT_UP, GoldenrodMansion3FGameProgram
	bg_event  1,  3, BGEVENT_UP, GoldenrodMansion3FReferenceMaterial

	def_object_events
	object_event  3,  6, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, GameFreakGameDesignerScript, -1
	object_event  3,  4, SPRITE_GYM_GUIDE, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, GameFreakGraphicArtistScript, -1
	object_event  0,  7, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, GameFreakProgrammerScript, -1
	object_event  0,  4, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_UP, 2, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, GameFreakCharacterDesignerScript, -1

	object_const_def
	const GoldenrodMansion3F_COOLTRAINER_M
	const GoldenrodMansion3F_GYM_GUIDE
	const GoldenrodMansion3F_SUPER_NERD
	const GoldenrodMansion3F_FISHER

GoldenrodMansion3F_MapScripts:
	def_scene_scripts

	def_callbacks

GameFreakGameDesignerScript:
	faceplayer
	opentext
	writetext GameFreakGameDesignerText
	readvar VAR_DEXCAUGHT
	ifgreater NUM_POKEMON - 2 - 1, .CompletedPokedex ; ignore Mew and Celebi
	waitbutton
	closetext
	end

.CompletedPokedex:
	promptbutton
	writetext GameFreakGameDesignerCompletedPokedexText
	playsound SFX_DEX_FANFARE_230_PLUS
	waitsfx
	writetext GameFreakGameDesignerPauseForDiplomaText
	promptbutton
	special Diploma
	writetext GameFreakGameDesignerAfterDiplomaText
	waitbutton
	closetext
	setevent EVENT_ENABLE_DIPLOMA_PRINTING
	end

GameFreakGraphicArtistScript:
	faceplayer
	opentext
	checkevent EVENT_ENABLE_DIPLOMA_PRINTING
	iftrue .CanPrintDiploma
	writetext GameFreakGraphicArtistText
	waitbutton
	closetext
	end

.CanPrintDiploma:
	writetext GameFreakGraphicArtistPrintDiplomaText
	yesorno
	iffalse .Refused
	special PrintDiploma
	closetext
	end

.Refused:
	writetext GameFreakGraphicArtistRefusedText
	waitbutton
	closetext
	end

GameFreakProgrammerScript:
	jumptextfaceplayer GameFreakProgrammerText

GameFreakCharacterDesignerScript:
	jumptextfaceplayer GameFreakCharacterDesignerText







GameFreakGameDesignerText:
	text "Is that right?"

	para "I'm the GAME"
	line "DESIGNER!"

	para "Filling up your"
	line "#DEX is tough,"
	cont "but don't give up!"
	done

GameFreakGameDesignerCompletedPokedexText:
	text "Wow! Excellent!"
	line "You completed your"
	cont "#DEX!"

	para "Congratulations!"
	done

GameFreakGameDesignerPauseForDiplomaText:
	text "…"
	done

GameFreakGameDesignerAfterDiplomaText:
	text "The GRAPHIC ARTIST"
	line "will print out a"
	cont "DIPLOMA for you."

	para "You should go show"
	line "it off."
	done

GameFreakGraphicArtistText:
	text "I'm the GRAPHIC"
	line "ARTIST."

	para "I drew you!"
	done

GameFreakGraphicArtistPrintDiplomaText:
	text "I'm the GRAPHIC"
	line "ARTIST."

	para "Oh, you completed"
	line "your #DEX?"

	para "Want me to print"
	line "out your DIPLOMA?"
	done

GameFreakGraphicArtistRefusedText:
	text "Give me a shout if"
	line "you want your"
	cont "DIPLOMA printed."
	done

GameFreakGraphicArtistErrorText:
	text "Something's wrong."
	line "I'll have to can-"
	cont "cel printing."
	done

GameFreakProgrammerText:
	text "Who, me? I'm the"
	line "PROGRAMMER."

	para "Play the slot"
	line "machines!"
	done

GameFreakCharacterDesignerText:
	text "Aren't the TWINS"
	line "adorable?"

	para "JASMINE's pretty"
	line "too."

	para "Oh, I love them!"
	done



GoldenrodMansion3FReferenceMaterial:
	jumpthistext
		text "It's crammed with"
		line "reference materi-"
		cont "als. There's even"
		cont "a # Doll."
		done

GoldenrodMansion3FDevRoomSign:
	jumpthistext
		text "Game Freak"
		line "Development Room"
		done

GoldenrodMansion3FDrawing:
	jumpthistext
		text "It's a detailed"
		line "drawing of a"
		cont "pretty girl."
		done

GoldenrodMansion3FGameProgram:
	jumpthistext
		text "It's the game's"
		line "program."

		para "Messing with it"
		line "could put another"
		cont "bug in the game!"
		done
