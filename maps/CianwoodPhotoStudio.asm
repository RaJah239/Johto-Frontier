CianwoodPhotoStudio_MapEvents:
	def_warp_events
	warp_event  2,  7, CIANWOOD_CITY, 5
	warp_event  3,  7, CIANWOOD_CITY, 5

	def_coord_events

	def_bg_events

	def_object_events
	object_event  2,  3, SPRITE_FISHING_GURU, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, CianwoodPhotoStudioFishingGuruScript, -1

	object_const_def
	const CIANWOODPHOTOSTUDIO_FISHING_GURU

CianwoodPhotoStudio_MapScripts:
	def_scene_scripts

	def_callbacks

CianwoodPhotoStudioFishingGuruScript:
	faceplayeropentext
	checkflag ENGINE_CIANWOOD_PHOTOGRAPH
	iftrue .AlreadyDone
	writethistext
		text "You have magnifi-"
		line "cent #mon with"
		cont "you."

		para "How about a photo"
		line "for a souvenir?"
		done
	yesorno
	iffalse .Refused
	writethistext
		text "OK! Big smile now!"

		para "Which #mon"
		line "should I photo-"
		cont "graph?"
		done
	promptbutton
	special CianwoodPhotograph
	ifequal $0, .NoPicture
	ifequal $1, .EggPicture
	setflag ENGINE_CIANWOOD_PHOTOGRAPH
	writethistext
		text "All righty. Hold"
		line "still for a bit."
		done
	waitclosetext
	special FadeOutPalettes
	special LoadMapPalettes
	pause 5
	playsound SFX_DOUBLESLAP
	waitsfx
	special FadeInPalettes_EnableDynNoApply
	reanchormap
	readmem wCurPartySpecies
	pokepic 0
	cry 0
	waitsfx
	closepokepic
	opentext
	writetext PhotoStudioPrestoText
	special PlayCurMonCry
	jumpthisopenedtext
		text "Come again, OK?"
		done

.Refused:
	jumpthisopenedtext
		text "Oh, that's too"
		line "bad. I thought it"
		cont "would be a great"
		cont "memento…"
		done

.AlreadyDone
	jumpthisopenedtext
		text "I've already taken"
		line "a photo for you"
		cont "today."

		para "Come back again"
		line "tomorrow."
		done

.NoPicture:
	jumpthisopenedtext
		text "Oh, no picture?"
		line "Come again, OK?"
		done

.EggPicture:
	jumpthisopenedtext
		text "An Egg? My talent"
		line "is worth more…"
		done

PhotoStudioPrestoText:
	text "Presto! All done."

	para "Your @"
	text_ram wStringBuffer3
	text ""
	line "looks happier!"
	done
