BattlePlazaGrandGauntlet_MapEvents:
	def_warp_events
	warp_event  4, 13, BATTLE_PLAZA, 15
	warp_event  3, 13, BATTLE_PLAZA, 14

	def_coord_events

	def_bg_events
	bg_event  2, 10, BGEVENT_READ, GrandGauntletInfoSignScript

	def_object_events
	object_event  4,  3, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, -1
	object_event  3, 10, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_TEAL, OBJECTTYPE_SCRIPT, 0, BattlePlazaGrandGauntletReceptionistScript, -1
	object_event  1, 12, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 1, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, BattlePlazaGrandGauntletYoungsterText, -1
	object_event  7, 12, SPRITE_POKEFAN_M, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, FeebasSellerScript, -1

	object_const_def
	const BATTLEPLAZAGRANDGAUNTLET_QUEST_GIVER
	const BATTLEPLAZAGRANDGAUNTLET_RECEPTIONIST
	const BATTLEPLAZAGRANDGAUNTLET_BUGCATCHER

BattlePlazaGrandGauntlet_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, GrandGauntletGiveBackPartyCallback

GrandGauntletGiveBackPartyCallback:
	callasm ResetGrandGauntletEvents
	endcallback

GrandGauntletInfoSignScript:
	opentext
	writethistext
		text "Grand Gauntlet"
		line "info sign."
		done
	waitbutton
.ChooseOption:
	loadmenu .InfoMenuHeader
	verticalmenu
	closewindow
	ifequal 1, .Explanation
	ifequal 2, .Requirements
	ifequal 3, .BannedItems
	ifequal 4, .ForcedOptions
	ifequal 5, .Prizes
	endtext

.Explanation:
	writethistext
		text "The Grand Gauntlet"
		line "is a 50 floor"
		cont "challenge."

		para "We replace your"
		line "Lv 50 Feebas with"
		cont "a random party."

		para "They all come at"
		line "level 5 and will"
		cont "be equipped with"
		cont "an item each."
		done
	waitbutton
	sjump .ChooseOption

.Requirements:
	writethistext
		text "Grand Gauntlet"
		line "Requirements:"
	
		para "Party must only be"
		line "a single Lv 50"
		cont "Feebas."

		para "We employ a seller"
		line "on this floor."
		done
	waitbutton
	sjump .ChooseOption

.BannedItems:
	writethistext
		text "Certain items are"
		line "banned and can't be"
		cont "entered with."

		para "If in possession,"
		line "they'll be lost."

		para "Store them all via"
		line "your PC."

		para "Here's a complete"
		line "list:"

		para "All Berries,"
		line "All TMs,"
		cont "All Battle Items,"

		para "and specific ones"
		line "from your Item"
		cont "Pocket:"

		para "Vitamins:"
		line "Rare Candy,"
		cont "PP Up"
		cont "Hyper EV Up,"
		cont "HP Up,"
		cont "Protein,"
		cont "Iron,"
		cont "Calcium,"
		cont "Zinc and Carbos."

		para "Evolution Items:"
		line "Fire Stone,"
		cont "Water Stone,"
		cont "Leaf Stone,"
		cont "Thunderstone,"
		cont "Dragon Scale,"
		cont "Sun Stone and"
		cont "Moon Stone."
		done
	setevent EVENT_GRAND_GAUNTLET_WARNING
	waitbutton
	sjump .ChooseOption

.ForcedOptions:
	writethistext
		text "On entry to the"
		line "Battle Room, the"
		cont "following Options"
		cont "are enforced:"

		para "Exp. Gain: Scaled"
		line "Exp.Share: On"

		para "Exiting reverts"
		line "back to previous"
		cont "settings."
		done
	waitbutton
	sjump .ChooseOption

.Prizes:
	writethistext
		text "Completing all 50"
		line "floors nets you"
		cont "the team you over-"
		cont "came it with plus"
		cont "594× Rare Candy,"
		cont "6× Hyper EV Up and"
		cont "¥999,999."

		para "The items appear"
		line "near the exit."

		para "Claim all before"
		line "more attempts."

		para "Giving up will"
		line "send you back to"
		cont "this hall and give"
		cont "you a Feebas to"
		cont "replace the one"
		cont "you entered with."
		done
	waitbutton
	sjump .ChooseOption

.InfoMenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 0, 0, 16, 12
	dw .InfoMenuData
	db 1 ; default option

.InfoMenuData:
	db STATICMENU_CURSOR | STATICMENU_WRAP | STATICMENU_NO_TOP_SPACING ; flags
	db 6 ; items
	db "Explanation@"
	db "Requirements@"
	db "Banned Items@"
	db "Forced Options@"
	db "Prizes@"
	db "Cancel@"

GrandGauntletGiveUpScript::
	closetext
	callasm GrandGauntletGiveUpPenalty
	playsound SFX_WARP_TO
	special FadeOutPalettes
	waitsfx
	warp BATTLE_PLAZA_GRAND_GAUNTLET, 3, 13
	end

DEF GG_GIVE_UP_FEEBAS_LEVEL EQU 50

GrandGauntletGiveUpPenalty:
	; Giving up ends the run.
	xor a
	ld [wGrandGauntletRun], a

	; Put back the Experience Gain mode and Exp
	; Share setting from before the run.
	ld a, [wGrandGauntletPrevExpMode]
	call ApplyExpMode

	ld a, [wGrandGauntletPrevExpShare]
	call ApplyExpShare

; Abandoning a run costs the player the team they were loaned and
; everything they picked up along the way: the party is replaced by a
; single level-50 Feebas and the bag is stripped back to key items and
; balls - items, berries, battle items and TMs/HMs are all wiped.
; The PC keeps whatever was stored there; only carried pockets go.
	; 1. one level-50 Feebas in slot 1 and nothing else
	call ResetPartyToEmpty
	ld a, FEEBAS
	ld [wCurPartySpecies], a
	ld a, GG_GIVE_UP_FEEBAS_LEVEL
	ld [wCurPartyLevel], a
	xor a
	ld [wMonType], a ; our party, not an opposing one
	ld [wBattleMode], a ; no wild item, level-appropriate moves
	predef TryAddMonToParty
	; fallthrough

GrandGauntletEntryPenalty:
	; Preserve the current item selection.
	ld a, [wCurItem]
	push af

	; Clear Battle pocket.
	xor a
	ld [wNumBattles], a
	ld a, -1
	ld [wBattles], a

	; Clear all TM/HM ownership.
	ld hl, wTMsHMs
	ld bc, NUM_TMS + NUM_HMS
.clear_tms
	xor a
	ld [hli], a
	dec bc
	ld a, b
	or c
	jr nz, .clear_tms

	; remove all berries
	ld a, BERRY
	ld [wCurItem], a
	call .RemoveAllMatchingBerries

	ld a, BITTER_BERRY
	ld [wCurItem], a
	call .RemoveAllMatchingBerries

	ld a, BURNT_BERRY
	ld [wCurItem], a
	call .RemoveAllMatchingBerries

	ld a, GOLD_BERRY
	ld [wCurItem], a
	call .RemoveAllMatchingBerries

	ld a, ICE_BERRY
	ld [wCurItem], a
	call .RemoveAllMatchingBerries

	ld a, MINT_BERRY
	ld [wCurItem], a
	call .RemoveAllMatchingBerries

	ld a, MIRACLEBERRY
	ld [wCurItem], a
	call .RemoveAllMatchingBerries

	ld a, MYSTERYBERRY
	ld [wCurItem], a
	call .RemoveAllMatchingBerries

	ld a, PRZCUREBERRY
	ld [wCurItem], a
	call .RemoveAllMatchingBerries

	ld a, PSNCUREBERRY
	ld [wCurItem], a
	call .RemoveAllMatchingBerries

	ld a, SILVER_BERRY
	ld [wCurItem], a
	call .RemoveAllMatchingBerries

	; remove these specific items
	ld a, RARE_CANDY
	ld [wCurItem], a
	call .RemoveAllMatchingItems

	ld a, PP_UP
	ld [wCurItem], a
	call .RemoveAllMatchingItems

	ld a, HYPER_EV_UP
	ld [wCurItem], a
	call .RemoveAllMatchingItems

	ld a, HP_UP
	ld [wCurItem], a
	call .RemoveAllMatchingItems

	ld a, PROTEIN
	ld [wCurItem], a
	call .RemoveAllMatchingItems

	ld a, IRON
	ld [wCurItem], a
	call .RemoveAllMatchingItems

	ld a, CALCIUM
	ld [wCurItem], a
	call .RemoveAllMatchingItems

	ld a, ZINC
	ld [wCurItem], a
	call .RemoveAllMatchingItems

	ld a, CARBOS
	ld [wCurItem], a
	call .RemoveAllMatchingItems

	ld a, FIRE_STONE
	ld [wCurItem], a
	call .RemoveAllMatchingItems

	ld a, WATER_STONE
	ld [wCurItem], a
	call .RemoveAllMatchingItems

	ld a, LEAF_STONE
	ld [wCurItem], a
	call .RemoveAllMatchingItems

	ld a, THUNDERSTONE
	ld [wCurItem], a
	call .RemoveAllMatchingItems

	ld a, DRAGON_SCALE
	ld [wCurItem], a
	call .RemoveAllMatchingItems

	ld a, SUN_STONE
	ld [wCurItem], a
	call .RemoveAllMatchingItems

	ld a, MOON_STONE
	ld [wCurItem], a
	call .RemoveAllMatchingItems

	; Restore the previous item selection.
	pop af
	ld [wCurItem], a
	ret

.RemoveAllMatchingItems:
.restart
	ld hl, wItems
.search
	ld a, [hli]
	cp -1
	ret z
	ld c, a
	ld a, [wCurItem]
	cp c
	jr z, .found
	; Skip this item's quantity.
	inc hl
	jr .search

.found
	; HL points to the matching item's quantity.
	dec hl
	ld d, h
	ld e, l

	; Source is the next item pair.
	inc hl
	inc hl

	; Shift remaining entries left, including the terminator.
.copy
	ld a, [hli]
	ld [de], a
	inc de
	cp -1
	jr nz, .copy

	; One item entry has been removed.
	ld hl, wNumItems
	dec [hl]

	; Restart to remove any additional stacks.
	jr .restart

.RemoveAllMatchingBerries:
.restart2
	ld hl, wFruits
.search2
	ld a, [hli]
	cp -1
	ret z
	ld c, a
	ld a, [wCurItem]
	cp c
	jr z, .found2
	; Skip this item's quantity.
	inc hl
	jr .search2

.found2
	; HL points to the matching item's quantity.
	dec hl
	ld d, h
	ld e, l

	; Source is the next item pair.
	inc hl
	inc hl

	; Shift remaining entries left, including the terminator.
.copy2
	ld a, [hli]
	ld [de], a
	inc de
	cp -1
	jr nz, .copy2

	; One item entry has been removed.
	ld hl, wNumFruits
	dec [hl]

	; Restart to remove any additional stacks.
	jr .restart2

BattlePlazaGrandGauntletReceptionistScript:
	opentext
	checkevent EVENT_GRAND_GAUNTLET_WARNING
	iffalse .ReadTheSign
	writethistext
		text "The Grand Gauntlet"
		line "Welcomes you!"
	
		para "Store banned items"
		line "in your PC first,"
		cont "if you have not"
		cont "done so already."

		para "View the sign to"
		line "the left if a re-"
		cont "minder is needed."
		done
	promptbutton
.ChooseMode
	loadmenu .BattleLobbyModeTypeSelectionHeader
	verticalmenu
	closewindow
	ifequal 1, .Enter
	ifequal 3, .Cancel
.Cancel:
	closetext
	turnobject PLAYER, DOWN
	end

.ReadTheSign
	jumpthisopenedtext
		text "Welcome to the"
		line "Grand Gauntlet!"

		para "To the left has"
		line "informatin about"
		cont "this facility."

		para "It is of utmost"
		line "importance to read"
		cont "it, especially the"
		cont "section on banned"
		cont "items."

		para "Return once you"
		line "have."
		done

.Enter:
	readvar VAR_PARTYCOUNT
	ifgreater 1, .YouDontMeetRequirements
	checkpokelevel FEEBAS, 50
	iffalse .YouDontMeetRequirements
	writethistext
		text "Please go right"
		line "through."
		done
	waitclosetext
	applymovement BATTLEPLAZAGRANDGAUNTLET_RECEPTIONIST, Receptionist_MoveOutTheWay
	applymovement PLAYER, GrandGauntlet_WalkToQuestGiver

	opentext
	writethistext
		text "Let me take that"
		line "Feebas off your"
		cont "hands."

		para "I'll give you six"
		line "random #mon."
		done
	callasm RerollPartyKeeperTeam
	playsound SFX_DEX_FANFARE_20_49
	waitsfx
	writethistext
		text "Here is a new team"
		line "of six #mon."

		para "Have a look at"
		line "them."
		done
.ReviewTeam
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

.YouDontMeetRequirements:
	jumpthisopenedtext
		text "Sorry, you don't"
		line "meet the rules to"
		cont "enter."

		para "Your party must"
		line "only be a single"
		cont "Lv 50 Feebas."

		para "We employ a seller"
		line "on this floor."
		done

.KeepTeam:
	callasm EquipPartyKeeperTeamItems
	writethistext
		text "Very well. Those"
		line "six are all yours."

		para "I also gave each"
		line "something to hold!"

		para "Enjoy your run!"
		done
	waitclosetext
	callasm GrandGauntletEntryPenalty
	playsound SFX_WARP_TO
	special FadeOutPalettes
	waitsfx
	warp BATTLE_PLAZA_GRAND_GAUNTLET_BATTLE_ROOM_1, 2, 5
	end

.BattleLobbyModeTypeSelectionHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 0, 0, 8, 5
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR | STATICMENU_WRAP ; flags
	db 2 ; items
	db "Enter@"
	db "Cancel@"

Receptionist_MoveOutTheWay:
	step UP
    step RIGHT
    turn_head LEFT
    step_end

GrandGauntlet_WalkToQuestGiver:
	step UP
	step UP
	step UP
	step UP
	step UP
	step UP
	step UP
	step UP
	turn_head RIGHT
	step_end

; =========================================================================
; Party Keeper species pool
; -------------------------------------------------------------------------
; EDIT THIS LIST to change which #mon the keeper can hand out: one
; SPECIES constant per line, and the list must finish with db -1.
; He picks six different species out of it at random, all at level 5.
; Keep at least six entries, otherwise the last slots may repeat.
; =========================================================================
PartyKeeperSpeciesList:
	db CYNDAQUIL
	db TOTODILE
	db CHIKORITA
	db TOGEPI
	db CHARMANDER
	db SQUIRTLE
	db TURTWIG
	db PIKACHU
	db EEVEE
	db TORCHIC
	db FEEBAS
	db ROWLET
	db RALTS
	db WURMPLE
	db YANMA
	db SUNKERN
	db BUNEARY
	db PIDGEY
	db HOOTHOOT
	db ZUBAT
	db TEDDIURSA
	db PHANPY
	db BELLSPROUT
	db MAREEP
	db NIDORAN_F
	db NIDORAN_M
	db WIMPOD
	db MARILL
	db RHYHORN
	db DRILBUR
	db ONIX
	db MAGIKARP
	db GASTLY
	db SWABLU
	db NATU
	db SMEARGLE
	db GROWLITHE
	db HOUNDOUR
	db WOOPER
	db GLIGAR
	db GIBLE
	db MAKUHITA
	db DODUO
	db PONYTA
	db SLOWPOKE
	db SHROOMISH
	db SPINARAK
	db VENIPEDE
	db JOLTIK
	db SKORUPI
	db LARVESTA
	db TROPIUS
	db MANKEY
	db FERROSEED
	db SCYTHER
	db HERACROSS
	db TANGELA
	db MEOWTH
	db SNUBBULL
	db DROWZEE
	db SUDOWOODO
	db KOFFING
	db GRIMER
	db LITWICK
	db MILTANK
	db TAUROS
	db VOLTORB
	db ELEKID
	db MAGNEMITE
	db SHUCKLE
	db CORSOLA
	db STARYU
	db REMORAID
	db CHINCHOU
	db MANTINE
	db TENTACOOL
	db SEEL
	db HORSEA
	db LAPRAS
	db CLEFAIRY
	db SOLROCK
	db LUNATONE
	db STANTLER
	db DELIBIRD
	db SMOOCHUM
	db SNORUNT
	db SWINUB
	db SNEASEL
	db SNOVER
	db BALTOY
	db RIOLU
	db BRONZOR
	db SKARMORY
	db MISDREAVUS
	db CHANSEY
	db SNORLAX
	db LARVITAR
	db BAGON
	db AXEW
	db PORYGON
	db OMANYTE
	db LILEEP
	db AERODACTYL
	db -1 ; end
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

DEF PARTY_ROLLER_BAN_COUNT EQU PartyKeeperBanListEnd - PartyKeeperBanList

; =========================================================================
; Party Keeper routines, called from the script with `callasm`.
; =========================================================================
DEF PARTY_ROLLER_LEVEL  EQU 5
DEF PARTY_ROLLER_RETRIES EQU 64

RerollPartyKeeperTeam:
; Throw away whatever team is live and draw another one. The player's
; original party is already sitting in the stash, so unlike the deposit
; above this must not stash again - doing that would overwrite the very
; team it is supposed to be protecting.
	; 1. empty the live party
	call ResetPartyToEmpty

	; 2. fill it back up
	ld b, PARTY_LENGTH
.fill
	push bc
	call PickPartyKeeperSpecies
	ld [wCurPartySpecies], a
	ld a, PARTY_ROLLER_LEVEL
	ld [wCurPartyLevel], a
	xor a
	ld [wMonType], a ; our party, not an opposing one
	ld [wBattleMode], a ; no wild item, level-appropriate moves
	predef TryAddMonToParty
	pop bc
	dec b
	jr nz, .fill
	ret

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
	ld c, PARTY_ROLLER_RETRIES
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
	ld b, PARTY_ROLLER_BAN_COUNT
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

DEF FIRST_GG_EVENT EQU EVENT_FIRST_GG
DEF LAST_GG_RESET_EVENT  EQU EVENT_LAST_GG

ResetGrandGauntletEvents:
	; reset all sure hit event flags
    ld de, FIRST_GG_EVENT
    ld bc, LAST_GG_RESET_EVENT - FIRST_GG_EVENT + 1
; ResetEventRange
; Input:
;	DE = first event constant
;	BC = number of events to reset
; Destroys: AF
.loop
	push bc
	push de
	ld b, RESET_FLAG
	call EventFlagAction
	pop de
	pop bc

	inc de
	dec bc
	ld a, b
	or c
	jr nz, .loop
	ret

BattlePlazaGrandGauntletYoungsterText:
	text "The PC can store"
	line "up to 150 items."

	para "That's enough for"
	line "my entire invent-"
	cont "ory that can't be"
	cont "taken on the"
	cont "Grand Gauntlet."
	done

FeebasSellerScript:
	faceplayeropentext
	special PlaceMoneyTopRight
	writethistext
		text "Want a Feebas to"
		line "be able to enter?"

		para "It'll cost ¥50."
		line "What do you say?"
		done
	yesorno
	iffalse_endtext
	readvar VAR_PARTYCOUNT
	ifequal PARTY_LENGTH, .NoRoom
	checkmoney YOUR_MONEY, 50
	ifequal HAVE_LESS, .NotEnoughMoney
	takemoney YOUR_MONEY, 50
	special PlaceMoneyTopRight
	playsound SFX_TRANSACTION
	waitsfx
	playsound SFX_CAUGHT_MON
	waitsfx
	givepoke FEEBAS, 50
	endtext

.NoRoom:
	jumpthisopenedtext
		text "You have no room"
		line "in your party!"
		done

.NotEnoughMoney:
	jumpthisopenedtext
		text "You even have ¥50…"
		done
