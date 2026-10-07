SilverCavePokecenter1F_MapEvents:
	def_warp_events
	warp_event  3,  7, SILVER_CAVE_OUTSIDE, 1
	warp_event  4,  7, SILVER_CAVE_OUTSIDE, 1
	warp_event  0,  7, POKECENTER_2F, 1

	def_coord_events

	def_bg_events

	def_object_events
	heal_event  3,  1, PAL_NPC_PINK
	chansey_event  4,  1
	object_event  1,  5, SPRITE_GRANNY, SPRITEMOVEDATA_STANDING_LEFT, 2, 1, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, SilverCavePokecenter1FGrannyText, -1
	object_event  8,  5, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, SilverCavePokecenter1FPaletteNPC, -1

	object_const_def
	const SILVERCAVEPOKECENTER1F_NURSE
	const SILVERCAVEPOKECENTER1F_CHANSEY
	const SILVERCAVEPOKECENTER1F_GRANNY

SilverCavePokecenter1F_MapScripts:
	def_scene_scripts

	def_callbacks

SilverCavePokecenter1FGrannyText:
	text "Trainers who seek"
	line "power climb Mt."
	cont "Silver despite its"
	cont "many dangers…"

	para "With their trusted"
	line "#mon, they must"
	cont "feel they can go"
	cont "anywhere…"
	done

SilverCavePokecenter1FPaletteNPC:
	faceplayeropentext
	writethistext
		text "I mix #mon"
		line "paints as a hobby."

		para "I can edit 32"
		line "unique #mon"
		cont "and then you'd have"
		cont "default some to"
		cont "do more."

		para "Shall I change a"
		line "colour or return"
		cont "one to default?"
		done
	loadmenu SilverCavePokecenter1FPaletteNPCMenuHeader
	verticalmenu
	closewindow
	ifequal 1, .change
	ifequal 2, .restore
	jumpthisopenedtext
		text "No? That's a"
		line "shame. Come back"
		cont "anytime."
		done

.change
	special MonPaletteEditor
	ifequal 0, .NextTime
	ifequal 1, .NiceWork
	ifequal 3, .Egg
	jumpthisopenedtext
		text "Sorry, only 32 can"
		line "be adjusted."
		
		para "Set back another"
		line "to default so you"
		cont "can edit more."
		done

.restore
	special MonPaletteReset
	ifequal 1, .restored
	ifequal 2, .alreadyDefault
	ifequal 3, .Egg
	waitendtext

.restored
	jumpthisopenedtext
		text "Done! That's back"
		line "to its original"
		cont "colours."
		done

.alreadyDefault
	jumpthisopenedtext
		text "Hmm? That one"
		line "already has its"
		cont "original colours."
		done

.NiceWork
	jumpthisopenedtext
		text "Nice work!"
		done

.NextTime
	jumpthisopenedtext
		text "Next time, then!"
		done

.Egg
	jumpthisopenedtext
		text "Sorry, you can't"
		line "edit an Egg!"
		done

SilverCavePokecenter1FPaletteNPCMenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 0, 6, SCREEN_WIDTH - 1, TEXTBOX_Y - 1
	dw SilverCavePokecenter1FPaletteNPCMenuData
	db 1 ; default option

SilverCavePokecenter1FPaletteNPCMenuData:
	db STATICMENU_CURSOR | STATICMENU_WRAP ; flags
	db 2 ; items
	db "Change colours@"
	db "Return to default@"
