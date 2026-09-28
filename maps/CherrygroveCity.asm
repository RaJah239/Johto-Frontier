CherrygroveCity_MapEvents:
	def_warp_events
	warp_event 29,  3, CHERRYGROVE_POKECENTER_1F, 1
	warp_event 23,  3, CHERRYGROVE_MART, 2
	warp_event 17,  7, CHERRYGROVE_GYM_SPEECH_HOUSE, 1
	warp_event 25,  9, GUIDE_GENTS_HOUSE, 1
	warp_event 31, 11, CHERRYGROVE_EVOLUTION_SPEECH_HOUSE, 1

	def_coord_events

	def_bg_events
	bg_event 30,  8, BGEVENT_JUMPTEXT, CherrygroveCitySignText
	bg_event 23,  9, BGEVENT_JUMPTEXT, GuideGentsHouseSignText
	bg_event 24,  3, BGEVENT_JUMPSTD, MART_SIGN_SCRIPT
	bg_event 30,  3, BGEVENT_JUMPSTD, POKECENTER_SIGN_SCRIPT

	def_object_events
	object_event 32,  6, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CherrygroveCityGuideGent, EVENT_GUIDE_GENT_IN_HIS_HOUSE
	object_event 27, 12, SPRITE_TEACHER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, CherrygroveTeacherScript, -1
	object_event 23,  7, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, CherrygroveYoungsterText, -1
	object_event  7, 12, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, MysticWaterGuy, -1
	object_event 20, 10, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, CherrygrovePartyKeeperScript, -1

	object_const_def
	const CHERRYGROVECITY_GRAMPS
	const CHERRYGROVECITY_TEACHER
	const CHERRYGROVECITY_YOUNGSTER
	const CHERRYGROVECITY_FISHER
	const CHERRYGROVECITY_PARTY_KEEPER

CherrygroveCity_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, CherrygroveCityFlypointCallback

CherrygroveCityFlypointCallback:
	setflag ENGINE_FLYPOINT_CHERRYGROVE
	endcallback

CherrygroveCityGuideGent:
	faceplayeropentext
	writetextcheckdialogue GuideGentIntroText, GuideGentIntroTextMin
	yesorno
	iffalse .No
	writethistext
		text "OK, then!"
		line "Follow me!"
		done
	waitclosetext
	playmusic MUSIC_SHOW_ME_AROUND
	follow CHERRYGROVECITY_GRAMPS, PLAYER
	applymovement CHERRYGROVECITY_GRAMPS, GuideGentMovement1
	opentext
	writetextcheckdialogue GuideGentPokecenterText, GuideGentPokecenterTextMin
	waitclosetext
	applymovement CHERRYGROVECITY_GRAMPS, GuideGentMovement2
	turnobject PLAYER, UP
	opentext
	writetextcheckdialogue GuideGentMartText, GuideGentMartTextMin
	waitclosetext
	applymovement CHERRYGROVECITY_GRAMPS, GuideGentMovement3
	turnobject PLAYER, UP
	opentext
	writetextcheckdialogue GuideGentRoute2Text, GuideGentRoute2TextMin
	waitclosetext
	applymovement CHERRYGROVECITY_GRAMPS, GuideGentMovement4
	turnobject PLAYER, LEFT
	opentext
	writetextcheckdialogue GuideGentSeaText, GuideGentSeaTextMin
	waitclosetext
	applymovement CHERRYGROVECITY_GRAMPS, GuideGentMovement5
	turnobject PLAYER, UP
	pause 15
	turnobject CHERRYGROVECITY_GRAMPS, LEFT
	turnobject PLAYER, RIGHT
	opentext
	writetextcheckdialogue GuideGentGiftText, GuideGentGiftTextMin
	promptbutton
	getstring STRING_BUFFER_4, .mapcardname
	scall .JumpstdReceiveItem
	setflag ENGINE_MAP_CARD
	writethistext
		text "<PLAYER>'s #GEAR"
		line "now has a MAP!"
		done
	promptbutton
	writetextcheckdialogue GuideGentPokegearText, GuideGentPokegearTextMin
	waitclosetext
	stopfollow
	special RestartMapMusic
	turnobject PLAYER, UP
	applymovement CHERRYGROVECITY_GRAMPS, GuideGentMovement6
	playsound SFX_ENTER_DOOR
	disappear CHERRYGROVECITY_GRAMPS
	clearevent EVENT_GUIDE_GENT_VISIBLE_IN_CHERRYGROVE
	waitsfx
	end

.JumpstdReceiveItem:
	jumpstd ReceiveItemScript

.mapcardname
	db "Map Card@"

.No:
	jumpthisopenedtext
	text "Oh… It's something"
	line "I enjoy doing…"

	para "Fine. Come see me"
	line "when you like."
	done

GuideGentMovement1:
	step LEFT
	step LEFT
	step UP
	step LEFT
	turn_head UP
	step_end

GuideGentMovement2:
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	turn_head UP
	step_end

GuideGentMovement3:
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	turn_head UP
	step_end

GuideGentMovement4:
	step LEFT
	step LEFT
	step LEFT
	step DOWN
	step LEFT
	step LEFT
	step LEFT
	step DOWN
	turn_head LEFT
	step_end

GuideGentMovement5:
	step DOWN
	step DOWN
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step DOWN
	step DOWN
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	turn_head UP
	step_end

GuideGentMovement6:
	step UP
	step UP
	step_end

GuideGentIntroText:
	text "You're a rookie"
	line "trainer, aren't"
	cont "you? I can tell!"

	para "That's OK! Every-"
	line "one is a rookie"
	cont "at some point!"

	para "If you'd like, I"
	line "can teach you a"
	cont "few things."
	done

GuideGentIntroTextMin:
	text "Give the trainer"
	line "basics tour?"
	done

GuideGentPokecenterText:
	text "This is a #mon"
	line "Center. They heal"
	cont "your #mon in no"
	cont "time at all."

	para "You'll be relying"
	line "on them a lot, so"
	cont "you better learn"
	cont "about them."
	done

GuideGentPokecenterTextMin:
	text "Heal in #mon"
	line "Center."
	done

GuideGentMartText:
	text "This is a #mon"
	line "Mart."

	para "They sell balls"
	line "for catching wild"
	cont "#mon and other"
	cont "useful items."
	done

GuideGentMartTextMin:
	text "Buy items and more"
	line "in Marts."
	done

GuideGentRoute2Text:
	text "Route 2 is out"
	line "this way."

	para "Trainers will be"
	line "battling their"
	cont "prized #mon"
	cont "there."
	done

GuideGentRoute2TextMin:
	text "Exit this way."
	done

GuideGentSeaText:
	text "This is the sea,"
	line "as you can see."

	para "Some #mon are"
	line "found only in"
	cont "water."
	done

GuideGentSeaTextMin:
	text "#mon can be"
	line "found in the sea."
	done

GuideGentGiftText:
	text "Here…"

	para "It's my house!"
	line "Thanks for your"
	cont "company."

	para "Let me give you a"
	line "small gift."
	done

GuideGentGiftTextMin:
	text "A gift!"
	done

GuideGentPokegearText:
	text "#Gear can fit"
	line "a Radio Card too."

	para "I wish you luck on"
	line "your journey!"
	done

GuideGentPokegearTextMin:
	text "#Gear can fit"
	line "a Radio Card too."
	done

CherrygroveTeacherScript:
	checkflag ENGINE_MAP_CARD
	iftrue_jumptextfaceplayer .HaveMapCard
	jumpthistextfaceplayer
	text "Did you talk to"
	line "the old man by the"
	cont "#mon Center?"

	para "He'll put a map of"
	line "Johto on your"
	cont "#Gear."
	done

.HaveMapCard:
	text "When you're with"
	line "#mon, going"
	cont "anywhere is fun."
	done

MysticWaterGuy:
	checkevent EVENT_GOT_MYSTIC_WATER_IN_CHERRYGROVE
	iftrue_jumptextfaceplayer .GotMysticWater
	faceplayeropentext
	writethistext
		text "A #mon I caught"
		line "had an item."

		para "I think it's"
		line "Mystic Water."

		para "I don't need it,"
		line "so do you want it?"
		done
	promptbutton
	verbosegiveitem MYSTIC_WATER
	iffalse_endtext
	setevent EVENT_GOT_MYSTIC_WATER_IN_CHERRYGROVE
	jumpthisopenedtext
.GotMysticWater
		text "Back to fishing"
		line "for me, then."
		done

CherrygroveYoungsterText:
	text "I battled the"
	line "trainers on the"
	cont "road."

	para "My #mon lost."
	line "They're a mess! I"
	cont "must take them to"
	cont "a #mon Center."
	done

CherrygroveCitySignText:
	text "Cherrygrove City"

	para "The City of Cute,"
	line "Fragrant Flowers"
	done

GuideGentsHouseSignText:
	text "Guide Gent's House"
	done

CherrygrovePartyKeeperScript:
	faceplayeropentext
	callasm CheckPartyKeeperStash
	iftrue .ReturnYourParty
	writethistext
		text "Leave your whole"
		line "party with me, and"

		para "I'll give you six"
		line "random #mon in"
		cont "return."
		done
	yesorno
	iffalse .ChangeOfMind
	callasm CheckPartyKeeperCanDeposit
	iffalse .NoPokemon
	writethistext
		text "Are you sure?"
		line "I will take every"
		cont "#mon you have."

		para "Your new team will"
		line "be level 5."
		done
	yesorno
	iffalse .ChangeOfMind
	callasm DepositPartyForRandomTeam
	playsound SFX_DEX_FANFARE_20_49
	waitsfx
	writetext CherrygrovePartyKeeperDoneText
	promptbutton
.ReviewTeam:
	special PartyKeeperShowTeam
	writethistext
		text "Mix another set?"
		done
	nooryes
	iffalse .KeepTeam
	callasm RerollPartyKeeperTeam
	playsound SFX_DEX_FANFARE_20_49
	waitsfx
	sjump .ReviewTeam

.KeepTeam:
	callasm EquipPartyKeeperTeamItems
	jumpthisopenedtext
		text "Very well. Those"
		line "six are all yours."

		para "I also gave each"
		line "something to hold!"

		para "Come back any time"
		line "to get your old"
		cont "team back from me."
		done

.ReturnYourParty:
	writethistext
		text "I still have your"
		line "#mon safe and"
		cont "sound."

		para "Would you like"
		line "them back?"
		done
	yesorno
	iffalse .ChangeOfMind
	callasm TakeBackHeldParty
	playsound SFX_DEX_FANFARE_20_49
	waitsfx
	jumpthisopenedtext
		text "Here they are, all"
		line "just as you left"
		cont "them!"
		done

.ChangeOfMind:
	jumpthisopenedtext
		text "Return anytime you"
		line "change your mind."
		done

.NoPokemon:
	jumpthisopenedtext
		text "You don't have any"
		line "#mon."
		done

CherrygrovePartyKeeperDoneText:
	text "Done! Your party"
	line "is safe with me."

	para "Here is a new team"
	line "of six #mon."

	para "Have a look at"
	line "them."
	done

; =========================================================================
; Party Keeper species pool
; -------------------------------------------------------------------------
; EDIT THIS LIST to change which #mon the keeper can hand out: one
; SPECIES constant per line, and the list must finish with db -1.
; He picks six different species out of it at random, all at level 5.
; Keep at least six entries, otherwise the last slots may repeat.
; =========================================================================
PartyKeeperSpeciesList:
; starters
	db CYNDAQUIL
	db TOTODILE
	db CHIKORITA
; early-route finds
	db PIDGEY
	db ZUBAT
	db MAREEP
	db MARILL
	db WOOPER
	db NATU
	db TEDDIURSA
	db PHANPY
	db BELLSPROUT
	db SPINARAK
	db SLOWPOKE
	db PONYTA
	db DODUO
	db GROWLITHE
	db GASTLY
	db NIDORAN_F
	db NIDORAN_M
	db MEOWTH
	db CLEFAIRY
; cave and water
	db MAGNEMITE
	db VOLTORB
	db STARYU
	db HORSEA
	db TENTACOOL
	db CHINCHOU
	db REMORAID
	db SEEL
; later and rare
	db SMOOCHUM
	db SNORUNT
	db SWINUB
	db BALTOY
	db BRONZOR
	db RIOLU
	db GIBLE
	db MAKUHITA
	db FERROSEED
	db JOLTIK
	db SKORUPI
	db VENIPEDE
	db LITWICK
; tough picks
	db KOFFING
	db GRIMER
	db DROWZEE
	db SUDOWOODO
	db TANGELA
	db MANKEY
	db SNUBBULL
	db ONIX
	db RHYHORN
	db SCYTHER
	db HERACROSS
	db SHUCKLE
	db CORSOLA
	db DELIBIRD
	db SMEARGLE
	db STANTLER
	db MISDREAVUS
	db DITTO
	db PORYGON
	db ABSOL
	db LARVITAR
	db TAUROS
	db MILTANK
	db -1
PartyKeeperSpeciesListEnd:

DEF PARTY_KEEPER_SPECIES_COUNT EQU PartyKeeperSpeciesListEnd - PartyKeeperSpeciesList - 1

if PARTY_KEEPER_SPECIES_COUNT < 1
	fail "PartyKeeperSpeciesList has no species in it"
endc

; =========================================================================
; Party Keeper berry pool
; -------------------------------------------------------------------------
; EDIT THIS LIST to change which berries can be tucked into a new
; team member's hands: one item constant per line, and no terminator
; is needed - the count is just the distance between the labels.
; The battle half of the gift has no list of its own: it takes
; anything whose attributes put it in the Battle pocket.
; =========================================================================
PartyKeeperBerryList:
	db SILVER_BERRY
	db GOLD_BERRY
	db MIRACLEBERRY
PartyKeeperBerryListEnd:

DEF PARTY_KEEPER_BERRY_COUNT EQU PartyKeeperBerryListEnd - PartyKeeperBerryList

if PARTY_KEEPER_BERRY_COUNT < 1
	fail "PartyKeeperBerryList has no berries in it"
endc

; =========================================================================
; Party Keeper item ban list
; -------------------------------------------------------------------------
; EDIT THIS LIST to keep items out of the battle half of the gift:
; one item constant per line, no terminator needed - the count is
; the distance between the labels. An empty list is fine: it just
; means nothing is banned. The berry half is a whitelist of its
; own, so this list only ever filters the battle walk.
; =========================================================================
PartyKeeperBanList:
	db AMULET_COIN
	db DRAGON_SCALE
PartyKeeperBanListEnd:

DEF PARTY_KEEPER_BAN_COUNT EQU PartyKeeperBanListEnd - PartyKeeperBanList

; =========================================================================
; Party Keeper routines, called from the script with `callasm`.
; =========================================================================
DEF PARTY_KEEPER_LEVEL  EQU 5
DEF PARTY_KEEPER_RETRIES EQU 64

OpenPartyKeeperSRAM:
; Select the stash's SRAM bank. This tail-calls OpenSRAM, so it returns
; straight to our caller with SRAM open.
	ld a, BANK(sPartyStashCheck1)
	jmp OpenSRAM

CheckPartyKeeperStash:
; wScriptVar = 1 while the Keeper still has a party in his care.
; SRAM is never cleared on boot, so trust nothing without check values.
	call OpenPartyKeeperSRAM
	ld a, [sPartyStashCheck1]
	cp SAVE_CHECK_VALUE_1
	jr nz, .empty
	ld a, [sPartyStashCheck2]
	cp SAVE_CHECK_VALUE_2
	jr nz, .empty
	ld a, [sPartyStashHeld]
	and a
	jr z, .empty
	; A stashed party always holds 1 to PARTY_LENGTH mon, since we
	; refuse to take an empty one. Random SRAM that happens to carry
	; the check values above is vanishingly unlikely to carry a sane
	; count as well, and a false "held" would let the next deposit
	; overwrite the real stored party.
	ld a, [sPartyStashParty]
	and a
	jr z, .empty
	cp PARTY_LENGTH + 1
	jr nc, .empty
	call CloseSRAM
	ld a, 1
	ld [wScriptVar], a
	ret

.empty
	call CloseSRAM
	xor a
	ld [wScriptVar], a
	ret

CheckPartyKeeperCanDeposit:
; wScriptVar = 1 if there is at least one #mon to hand over.
; An empty party would be swapped for six, then swapped straight back,
; losing the random team for nothing.
	ld a, [wPartyCount]
	and a
	jr z, .nothing
	ld a, 1
	ld [wScriptVar], a
	ret

.nothing
	xor a
	ld [wScriptVar], a
	ret

DepositPartyForRandomTeam:
; Bank the whole party, then refill the party with six random Lv5 mon.
	; 1. copy wPartyCount..wPartyMonNicknamesEnd into the stash
	call OpenPartyKeeperSRAM
	ld hl, wPartyCount
	ld de, sPartyStashParty
	ld bc, wPartyMonNicknamesEnd - wPartyCount
	call CopyBytes
	ld a, 1
	ld [sPartyStashHeld], a
	ld a, SAVE_CHECK_VALUE_1
	ld [sPartyStashCheck1], a
	ld a, SAVE_CHECK_VALUE_2
	ld [sPartyStashCheck2], a
	call CloseSRAM
	; empty the party and fill it with a fresh team
	; fallthrough

RerollPartyKeeperTeam:
; Throw away whatever team is live and draw another one. The player's
; original party is already sitting in the stash, so unlike the deposit
; above this must not stash again - doing that would overwrite the very
; team it is supposed to be protecting.
	; 2. empty the live party
	call ResetPartyToEmpty

	; 3. fill it back up
	ld b, PARTY_LENGTH
.fill
	push bc
	call PickPartyKeeperSpecies
	ld [wCurPartySpecies], a
	ld a, PARTY_KEEPER_LEVEL
	ld [wCurPartyLevel], a
	xor a
	ld [wMonType], a ; our party, not an opposing one
	ld [wBattleMode], a ; no wild item, level-appropriate moves
	call AddPartyKeeperMon
	pop bc
	dec b
	jr nz, .fill
	ret

TakeBackHeldParty:
; Hand the stored party back, dropping the random team.
	call OpenPartyKeeperSRAM
	ld hl, sPartyStashParty
	ld de, wPartyCount
	ld bc, wPartyMonNicknamesEnd - wPartyCount
	call CopyBytes
	xor a
	ld [sPartyStashHeld], a
	jmp CloseSRAM

ResetPartyToEmpty:
; Leave wPartyCount..wPartyMonNicknamesEnd in the shape a fresh game
; leaves it: a zero count, -1 wherever a scanner expects a terminator,
; and zeroed mon, OT and nickname slots. TryAddMonToParty then appends
; to a clean slate instead of stacking onto the old party.
	xor a
	ld [wPartyCount], a
	ld hl, wPartySpecies
	ld bc, wPartyEnd - wPartySpecies
	ld a, -1
	call ByteFill
	ld a, -1
	ld [wPartyEnd], a
	xor a
	ld hl, wPartyMons
	ld bc, wPartyMonOTs - wPartyMons
	call ByteFill
	xor a
	ld hl, wPartyMonOTs
	ld bc, wPartyMonNicknames - wPartyMonOTs
	call ByteFill
	xor a
	ld hl, wPartyMonNicknames
	ld bc, wPartyMonNicknamesEnd - wPartyMonNicknames
	jmp ByteFill

PickPartyKeeperSpecies:
; -> a: an entry from PartyKeeperSpeciesList that is not already in the
;    party.
; Draws are rejected and retried while the budget lasts, so the pick
; stays uniform across the entries still unused. If the budget ever runs
; out, the whole list is swept instead and the first unused entry taken:
; with fewer than PARTY_LENGTH entries already placed there is always
; one left, so a repeat cannot happen for any list that holds at least
; PARTY_LENGTH species.
	ld c, PARTY_KEEPER_RETRIES
.try
	push bc
	call .RandomFromList
	ld [wCurPartySpecies], a
	call .AlreadyInParty
	pop bc ; pop does not touch the flags set above
	jr nc, .done
	dec c
	jr nz, .try

	; The rejection budget ran out. Sweep every entry from the front:
	; this finds an unused one whenever the list holds one, so the only
	; species it can hand back twice are in a list too short to fill a
	; team without repeating anyway.
	ld hl, PartyKeeperSpeciesList
	ld b, PARTY_KEEPER_SPECIES_COUNT
.sweep
	ld a, [hl]
	ld [wCurPartySpecies], a
	push hl
	push bc
	call .AlreadyInParty
	pop bc
	pop hl
	jr nc, .done
	inc hl
	dec b
	jr nz, .sweep
	; Every entry is already placed: the list is shorter than
	; PARTY_LENGTH, so a repeat was unavoidable here.
	ld a, [wCurPartySpecies]
	ret

.done
	ld a, [wCurPartySpecies]
	ret

.RandomFromList
; -> a: one entry of PartyKeeperSpeciesList
	ld a, PARTY_KEEPER_SPECIES_COUNT
	call RandomRange
	ld hl, PartyKeeperSpeciesList
	and a
	jr z, .found
.walk
	inc hl
	dec a
	jr nz, .walk
.found
	ld a, [hl]
	ret

.AlreadyInParty
; carry set if wCurPartySpecies already has a slot in the party
	ld a, [wPartyCount]
	and a
	jr z, .absent
	ld b, a
	ld hl, wPartySpecies
.scan
	ld a, [wCurPartySpecies]
	cp [hl]
	jr z, .duplicate
	inc hl
	dec b
	jr nz, .scan
.absent
	and a ; clear carry
	ret

.duplicate
	scf
	ret

AddPartyKeeperMon:
; Adds wCurPartySpecies at wCurPartyLevel to the party, then leaves the
; Pokédex exactly as it found it. TryAddMonToParty unconditionally runs
; SetSeenAndCaughtMon, which would book six new species into the player's
; Pokédex every time the random team is handed out. So both flags are
; looked up first, and any flag that call newly set is cleared again on
; the way out -- a species the player already owned keeps its flag.
	ld a, [wCurPartySpecies]
	dec a
	call CheckSeenMon
	ld a, c
	push af ; seen before we added it?
	ld a, [wCurPartySpecies]
	dec a
	call CheckCaughtMon
	ld a, c
	push af ; caught before we added it?

	predef TryAddMonToParty

	pop af
	and a ; already caught -> leave the flag alone
	call z, .unregisterCaught
	pop af
	and a ; already seen -> leave the flag alone
	call z, .unregisterSeen
	ret

.unregisterCaught
	ld a, [wCurPartySpecies]
	dec a
	ld c, a
	ld d, 0
	ld hl, wPokedexCaught
	ld b, RESET_FLAG
	predef_jump SmallFarFlagAction

.unregisterSeen
	ld a, [wCurPartySpecies]
	dec a
	ld c, a
	ld d, 0
	ld hl, wPokedexSeen
	ld b, RESET_FLAG
	predef_jump SmallFarFlagAction

PickPartyKeeperHeldItem:
; -> a: a random held item from the keeper's gift pool, chosen by
; the carry flag coming in: carry set draws one of the berries
; named in PartyKeeperBerryList, carry clear walks the
; Battle-pocket entries in ItemAttributes. The berry side draws
; only from its own short list, so no other Fruit-pocket berry
; can turn up; the battle side keeps walking the table and picks
; up new Battle-pocket items on its own, skipping anything named
; in PartyKeeperBanList. The pocket byte is read straight out of
; ItemAttributes with GetFarByte, one entry at a time, so this
; runs from any bank the same way GetItemAttr does from its own.
; NO_ITEM only comes back if the Battle pocket has run dry, which
; the shipped data cannot do. EquipPartyKeeperTeamItems hands out
; the flag per slot.
	jr c, .berry

	; 1. battle half: count the BATTLE entries that are not
	;    banned -> c
	ld e, BATTLE
	ld hl, ItemAttributes + ITEMATTR_POCKET
	ld a, BANK(ItemAttributes)
	ld d, a ; the table's bank
	ld b, NUM_ITEMS
	ld c, 0
.count
	ld a, NUM_ITEMS
	sub b
	inc a ; the item id under the cursor
	push hl
	call .IsBanned
	pop hl ; pop does not touch the flags set above
	jr c, .countNext
	ld a, d
	call GetFarByte
	and $f
	cp e
	jr nz, .countNext
	inc c
.countNext
	push de
	ld de, ITEMATTR_STRUCT_LENGTH
	add hl, de
	pop de
	dec b
	jr nz, .count

	; 2. land uniformly on one of the c matches
	ld a, c
	and a
	jr z, .none
	push de
	call RandomRange ; a -> [0, c)
	pop de
	ld b, a ; matches left to step over

	; 3. walk the table again, skipping banned entries the same
	;    way the count pass did, and stop on the chosen match
	ld hl, ItemAttributes + ITEMATTR_POCKET
	ld a, BANK(ItemAttributes)
	ld d, a
	ld c, 1 ; item id under the cursor
.walk
	ld a, c
	push hl
	call .IsBanned
	pop hl ; pop does not touch the flags set above
	jr c, .walkNext
	ld a, d
	call GetFarByte
	and $f
	cp e
	jr nz, .walkNext
	ld a, b
	and a
	jr z, .found
	dec b
.walkNext
	push de
	ld de, ITEMATTR_STRUCT_LENGTH
	add hl, de
	pop de
	inc c
	jr .walk
.found
	ld a, c
	ret

.none
	ld a, NO_ITEM
	ret

.berry
	; uniform pick from the keeper's berry list; no terminator byte
	; is needed because the count is the distance between the labels
	ld a, PARTY_KEEPER_BERRY_COUNT
	call RandomRange
	ld hl, PartyKeeperBerryList
	and a
	jr z, .berryFound
.berryWalk
	inc hl
	dec a
	jr nz, .berryWalk
.berryFound
	ld a, [hl]
	ret

.IsBanned:
; carry set if the item id in a is named in PartyKeeperBanList.
; Clobbers a and hl (the caller pushes its table cursor around the
; call); bc and de come back untouched, and carry is the result.
	push bc
	ld c, a ; the item id under test
	ld hl, PartyKeeperBanList
	ld b, PARTY_KEEPER_BAN_COUNT
.banScan
	ld a, b
	and a
	jr z, .notBanned ; the list ran out
	ld a, [hl]
	cp c
	jr z, .banned
	inc hl
	dec b
	jr .banScan
.banned
	scf
	jr .banRet
.notBanned
	and a ; clear carry
.banRet
	pop bc ; pop does not touch the flags
	ret

EquipPartyKeeperTeamItems:
; Give each of the six members of the fresh team a held item of its
; own, all six different from each other: the first slot always
; gets a berry from PartyKeeperBerryList and the remaining five
; always get Battle-pocket items (anything not on
; PartyKeeperBanList), re-rolled whenever an earlier slot already
; holds the same one. This runs at final keep only: the keeper
; reaches this point after
; DepositPartyForRandomTeam/RerollPartyKeeperTeam has refilled the
; party to PARTY_LENGTH, so all six slots are present. The item is
; written straight into MON_ITEM rather than routed through the
; bag, so no pocket-full case exists, and the stash still carries
; the old team's own held items across untouched.
	ld b, PARTY_LENGTH
	ld hl, wPartyMons + MON_ITEM
.slot
	push bc
	push hl
; b counts down from PARTY_LENGTH, so the first slot is the one
; still at PARTY_LENGTH: berry for it, battle item for the rest
	ld a, b
	cp PARTY_LENGTH
	ccf ; carry in = berry half
	call PickPartyKeeperHeldItem
	pop hl
	ld [hl], a ; equip it

; no two members may hold the same item: walk the slots filled so
; far (from the top of the party up to this one) and re-roll on a
; hit. The first slot has nothing before it, so its berry never
; comes back here - and berries live in a different pocket from
; the battle items, so it cannot collide with them either.
	ld b, a ; the item under test
	ld d, h
	ld e, l ; de = this slot, the end of the walk
	ld hl, wPartyMons + MON_ITEM
.dupeCheck
	ld a, h
	cp d
	jr nz, .scanSlot
	ld a, l
	cp e
	jr z, .slotDone ; every earlier slot passed
.scanSlot
	ld a, [hl]
	cp b
	jr z, .repick ; an earlier slot already holds it
	push de
	ld de, PARTYMON_STRUCT_LENGTH
	add hl, de
	pop de
	jr .dupeCheck

.repick
; the battle side again; the first slot cannot reach this, and
; the battle pool holds far more entries than the five draws
; need, so this terminates
	push de
	push bc
	and a ; carry clear = battle half
	call PickPartyKeeperHeldItem
	pop bc
	pop de
	ld h, d
	ld l, e ; back to this slot
	ld [hl], a ; replace it
	ld b, a
	ld hl, wPartyMons + MON_ITEM
	jr .dupeCheck

.slotDone
	ld de, PARTYMON_STRUCT_LENGTH
	add hl, de ; the next slot's item byte
	pop bc
	dec b
	jr nz, .slot
	ret
