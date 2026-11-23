BattlePlazaMart_MapEvents:
    def_warp_events
    warp_event  4,  9, BATTLE_PLAZA, 10
    warp_event 12,  9, BATTLE_PLAZA, 11
    warp_event  3,  9, BATTLE_PLAZA, 10
    warp_event 11,  9, BATTLE_PLAZA, 11
    def_coord_events

    def_bg_events

    def_object_events
    object_event 10,  1, SPRITE_PORYGON_OW, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_PURPLE, OBJECTTYPE_SCRIPT, 0, BattlePlazaMartPorygonPCScript, -1
    object_event 12,  1, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, BattlePlazaMartTMCoinTraderScript, -1
    object_event 13,  1, SPRITE_LINK_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_TEAL, OBJECTTYPE_SCRIPT, 0, BattlePlazaMartTutorScript, -1

    object_const_def
    const BATTLEPLAZAMART_PORYGON_PC
    const BATTLEPLAZAMART_CLERK_ALL_TMS
    const BATTLEPLAZAMART_TUTOR

BattlePlazaMart_MapScripts:
    def_scene_scripts

    def_callbacks

BattlePlazaMartPorygonPCScript:
    jumpstd PorygonPCScript

BattlePlazaMartTMCoinTraderScript:
    faceplayeropentext
    special DisplayCoinCaseBalance
    checkevent EVENT_BATTLE_PLAZA_TM_MART_INTRO
    iftrue .WantToBuyATM
    writethistext
        text "Greetings, welcome"
        line "to the TM counter."

        para "Every TM has its"
        line "own price, paid"
        cont "in coins."

        para "Are you in need of"
        line "anything?"
        done
    setevent EVENT_BATTLE_PLAZA_TM_MART_INTRO
    sjump .WantToBuyATMAfterIntro
.WantToBuyATM:
    writethistext
        text "Welcome! Care to"
        line "buy a TM? Each is"
        cont "priced in coins."
        done
.WantToBuyATMAfterIntro:
    yesorno
    iffalse .Refused
    callasm .ResetTMCursor
.WantToBuyADifferentTM:
    special BattlePlazaTMCoinTrader
    ifequal 51, .NotEnoughCoins
    ifequal 52, .NoRoom
    ifequal 53, .Unavailable
    iffalse .CancelBuyingTMsScript
    ; give the TM the menu showed (its row, price and unlock all match)
    callasm BattlePlazaTMSelectionToItem
    verbosegiveitem ITEM_FROM_MEM
    iffalse .NoRoom
    sjump .ConcludeTransaction

.NoRoom:
    writethistext
        text "You already have"
        line "99! Pick another?"
        done
    waitbutton
    sjump .WantToBuyADifferentTM

.Unavailable:
    jumpthisopenedtext
        text "This TM is not"
        line "available yet."
        done

.ConcludeTransaction:
    waitsfx
    playsound SFX_TRANSACTION
    special DisplayCoinCaseBalance
    waitbutton
    sjump .WantToBuyADifferentTM

.Refused:
    jumpthisopenedtext
        text "We are open 24/7."
        done

.NotEnoughCoins:
    writethistext
        text "You don't have"
        line "enough coins…"
        done
    waitbutton
    sjump .WantToBuyADifferentTM

.CancelBuyingTMsScript:
    jumpthisopenedtext
        text "Please come again!"
        done

; A fresh conversation starts on TM1; the loop-backs jump over the
; yesorno above, so the menu keeps its cursor across transactions.
.ResetTMCursor:
    xor a
    ld [wMenuScrollPosition], a
    inc a
    ld [wMenuCursorPosition], a
    ret

BattlePlazaMartTutorScript:
    faceplayeropentext
    special CrystalCountInBag
    checkevent EVENT_MET_BATTLE_PLAZA_MOVE_TUTOR
    iftrue .WelcomeBackWantMeToTeach
    writethistext
        text "Welcome! I'm am"
        line "the Battle Plaza's"
        cont "Move Tutor."

        para "I can teach your"
        line "precious #mon"
        cont "special moves for"
        cont "a varied amount"
        cont "of Crystals each."

        para "Want me to teach"
        line "your #mon some"
        cont "moves?"
        done
    setevent EVENT_MET_BATTLE_PLAZA_MOVE_TUTOR
    sjump .TeachAnotherMove
.WelcomeBackWantMeToTeach:
    writethistext
        text "Welcome once more"
        line "esteemed trainer!"
        
        para "Shall I tutor a"
        line "move onto your"
        cont "#mon for a set"
        cont "sum of Crystals?"
        done
.TeachAnotherMove:
    yesorno
    iffalse .Refused
    writethistext
        text "Which move shall"
        line "I teach?"
        done
    callasm .LoadMovesMenu
    callasm PlazaMoveIcons_Close
    writetext BattlePlazaMartTutorMoveText
    ifequal 2, .NotEnough
    ifequal 3, .LockedMove
    iffalse .Refused
    special MoveTutor2
    iffalse .TeachMove
    sjump .Refused

; Left/Right jump a whole window (page) at a time. The scroll position is
; clamped like InitScrollingMenuCursor does, and the next ScrollingMenu
; call redraws the list, so the highlight keeps its row on screen.
.page_down
    ld b, 1
    jr .page

.page_up
    ld b, -1
.page
    ld a, [wMenuData_ScrollingMenuHeight]
    ld c, a
    ld a, [wMenuScrollPosition]
    bit 7, b
    jr nz, .page_back
    add c
    ld c, a
    ; max = (listSize + 1) - height, floored at 0
    ld a, [wScrollingMenuListSize]
    inc a
    ld d, a
    ld a, [wMenuData_ScrollingMenuHeight]
    ld e, a
    ld a, d
    sub e
    jr nc, .have_max
    xor a
.have_max
    cp c
    jr nc, .use_new
    ; newScroll exceeds maxScroll: keep the max
    ld c, a
.use_new
    ld a, c
    ld [wMenuScrollPosition], a
    jr .input_loop

.page_back
    sub c
    jr nc, .back_ok
    xor a
.back_ok
    ld [wMenuScrollPosition], a
    jr .input_loop

.LoadMovesMenu:
    call ClearSprites
    call LoadStandardMenuHeader
    ld hl, .MovesMenu
    call LoadMenuHeader
    xor a
    ld [wMenuCursorPosition], a
    ld [wMenuScrollPosition], a
    farcall PlazaMoveIcons_PrepareMenu
    call InitScrollingMenu
.input_loop
    call ScrollingMenu
; Keep wMenuCursorPosition on the highlighted row: the menu reopens
; from it, and the loop reenters whenever the menu hands back a key it
; is not confirming with (D_LEFT/D_RIGHT, now that the list wraps).
    ld a, [wMenuCursorY]
    ld [wMenuCursorPosition], a
    ld a, [wMenuJoypad]
    cp D_RIGHT
    jr z, .page_down
    cp D_LEFT
    jr z, .page_up
    cp B_BUTTON
    jr z, .cancel_selection
    cp A_BUTTON
    jr nz, .input_loop
    ld a, [wMenuSelection]
    cp -1 ; CANCEL
    jr z, .cancel_selection
; selection confirmed
    assert wMenuSelectionQuantity == wMenuSelection + 1
    ld a, [wMenuSelection]
    ; Check if this move is unlocked
    ld c, a  ; c = move ID
    ld hl, .FullMoveList
    inc hl  ; skip count byte
    ld b, 0  ; index counter
; (the move is always in the list: CANCEL was handled above)
.find_move_index:
    ld a, [hl]
    cp c
    jr z, .move_found
    inc hl
    inc hl
    inc b
    jr .find_move_index
.move_found:
    ; b = index, look up event flag
    ld c, b
    ld b, 0
    ld hl, TutorUnlockEvents
    add hl, bc
    add hl, bc
    ld a, [hli]
    ld e, a
    ld a, [hl]
    ld d, a
    ld b, CHECK_FLAG
    call EventFlagAction
    jr nz, .move_unlocked
    ; locked: return 3
    ld a, 3
    ld [wScriptVar], a
    ret

.move_unlocked:
    ld hl, wMenuSelection
    ld a, [hli]
    ld [wNamedObjectIndex], a
    ld a, [hl]
    ld [wBattlePlazaCrystalMoveTutor], a ; not used for menus anymore at this point
    ld b, a
    call .GetAmountOfCrystals
    cp b
    jr c, .not_enough_crystals
    ld a, TRUE
    ld [wScriptVar], a
    ret

.cancel_selection:
    ld a, FALSE
    ld [wScriptVar], a
    ret

.not_enough_crystals:
    ld a, 2
    ld [wScriptVar], a
    ret

.MovesMenu:
    db MENU_BACKUP_TILES
    menu_coords 1, 4, 18, 10
    dw .MovesMenuData
    db 1

.MovesMenuData:
    ; ENABLE_LEFT | ENABLE_RIGHT are the pair ScrollingMenu_CanWrap
    ; requires for the list to loop (plus ENABLE_FUNCTION3, whose bit
    ; doubles as STATICMENU_WRAP). They also hand D_LEFT/D_RIGHT back
    ; to the caller, which .LoadMovesMenu's input loop ignores.
    db SCROLLINGMENU_DISPLAY_ARROWS | SCROLLINGMENU_ENABLE_LEFT | SCROLLINGMENU_ENABLE_RIGHT | SCROLLINGMENU_ENABLE_FUNCTION3 ; flags
    db 3 ; height
    db 1 ; width ("1" triggers Function 2 to run)
    db SCROLLINGMENU_ITEMS_QUANTITY ; item format
    dba .FullMoveList
    dba .DisplayMoveName
    dba .DisplayAmountOkNotReally
    dba .UpdateNeededCrystalIndicator

.UpdateNeededCrystalIndicator:
; update quantity
    hlcoord 0, 0
    lb bc, 1, 7
    call Textbox
    ld a, [wMenuSelection]
    cp -1 ; CANCEL
    hlcoord 1, 1 ; text starting position
    jr nz, .display_needed_amount

    ld de, .ExitString
    call PlaceString
    jr .show_move_info

.display_needed_amount
    ld de, .CrystalText
    call PlaceString
    hlcoord 6, 1
    ld de, wMenuSelectionQuantity
    lb bc, PRINTNUM_LEADINGZEROS | 1, 2
    call PrintNum

.show_move_info
; And the hovered move's own stats, in the same box below the list
; that the TM counter uses, so both menus read alike.
    ld a, [wMenuSelection]
    cp -1 ; CANCEL
    jr z, .clear_move_info
    ld [wCurSpecies], a
    farcall DrawMoveInfoBox
    farjp MoveIcons_CommitPage

.clear_move_info
; Nothing hovered: redraw the box empty so the last move's stats do
; not linger once Cancel is highlighted. Keep the icon resources until
; the shop closes, so returning to a move retains its palette ownership.
    hlcoord 0, 12
	lb bc, 4, SCREEN_WIDTH - 2
    call Textbox
    farjp MoveIcons_CommitPage

.CrystalText: db "Cost×@"
.ExitString: db "@"

.DisplayAmountOkNotReally:
; this is usually for displaying something on the right
; hand side of the menu, but we don't need that here
    ret

.DisplayMoveName:
    push de
    ld a, [wMenuSelection]
    ; Find the index of this move in the move list
    ld c, a  ; c = move ID to find
    ld hl, .FullMoveList
    inc hl  ; skip count byte
    ld b, 0  ; index counter
.find_index:
    ld a, [hl]
    cp c
    jr z, .found
    inc hl  ; skip move ID
    inc hl  ; skip cost
    inc b
    jr .find_index
.found:
    ; b = index, save it
    push bc
    ld c, b
    ld b, 0
    ld hl, TutorUnlockEvents
    add hl, bc
    add hl, bc  ; 2 bytes per entry
    ld a, [hli]
    ld e, a
    ld a, [hl]
    ld d, a  ; de = event flag
    ld b, CHECK_FLAG
    call EventFlagAction
    pop bc  ; restore index (b)
    jr nz, .show_name  ; unlocked
    ; locked: show "Unavailable XX" where XX = index + 1
    ; Calculate tens and ones digits
    ld a, b  ; a = index (0-29)
    inc a  ; 1-30 (move number)
    ld b, 0  ; tens counter
.tens_loop:
    cp 10
    jr c, .tens_done
    sub 10
    inc b
    jr .tens_loop

.tens_done:
    ; b = tens digit, a = ones digit
    push af  ; save ones digit
    push bc  ; save tens digit
    ; Copy "Unavailable " to wStringBuffer4
    ld hl, .UnavailablePrefix
    ld de, wStringBuffer4
    ld bc, 12
    call CopyBytes
    ; de now points to position 12
    pop bc  ; restore tens digit (b)
    pop af  ; restore ones digit (a)
    ; Write tens digit
    push af  ; save ones digit again
    ld a, b
    add $f6
    ld [de], a
    inc de
    ; Write ones digit
    pop af  ; restore ones digit
    add $f6
    ld [de], a
    inc de
    ; Null terminator
    ld a, $50
    ld [de], a
    ; Set de to point to the string
    ld de, wStringBuffer4
    pop hl  ; hl = destination (from initial push de)
    jmp PlaceString

.show_name:
    ld a, [wMenuSelection]
    ld [wNamedObjectIndex], a
    call GetMoveName
    pop hl
    jmp PlaceString

.UnavailablePrefix: db "Unavailable @"

.GetAmountOfCrystals:
; returns: a = qty. of Crystals
    ld hl, wItems ; pocket of CRYSTAL, see attributes.asm
    ld c, MAX_ITEMS ; search bound
.keep_looking
    ld a, [hli]
    cp -1
    jr z, .no_crystal
    dec c
    jr z, .no_crystal
    cp CRYSTAL
    jr z, .found_crystal
    inc hl ; skip quantity
    jr .keep_looking
.found_crystal
    ld a, [hl] ; get quantity
    jr .write_result
.no_crystal
    xor a
.write_result
    ld [wMenuSelectionQuantity], a
    ret

.FullMoveList:
; Read straight from ROM by the scrolling menu (the entry after the
; last move, -1, is the CANCEL row). Entry N is unlocked by the Nth
; event of TutorUnlockEvents.
    db (.FullMoveListEnd - .FullMoveList - 2) / 2 ; list length
; list items: move, cost in Crystals
; All 30 tutor moves (MT01-MT30 in constants/item_constants.asm), in that
; order, still unavailable: each waits for a placeholder event
; (TutorUnlockEvents: EVENT_ROUTE_17_BERRY_3, which nothing in the game ever
; sets) and costs a placeholder 10 Crystals (Double-Edge keeps its old 24).
    db FIRE_BLAST, 10
    db THUNDER, 10
    db BLIZZARD, 10
    db REST, 10
    db SLEEP_TALK, 10
    db THUNDERPUNCH, 10
    db FIRE_PUNCH, 10
    db ICE_PUNCH, 10
    db THUNDER_FANG, 10
    db ICE_FANG, 10
    db FIRE_FANG, 10
    db SURF, 10
    db ICY_WIND, 10
    db SKY_ATTACK, 10
    db DOUBLE_EDGE, 24
    db FLARE_BLITZ, 10
    db WILD_CHARGE, 10
    db GIGA_IMPACT, 10
    db HYPER_BEAM, 10
    db SWIFT, 10
    db HIDDEN_FORCE, 10
    db HIDDEN_POWER, 10
    db SUNNY_DAY, 10
    db RAIN_DANCE, 10
    db SANDSTORM, 10
    db HAIL, 10
    db FALSE_SWIPE, 10
    db BULLDOZE, 10
    db ROCK_TOMB, 10
    db POUNCE, 10
    db -1 ; end
.FullMoveListEnd:


.LockedMove:
    jumpthisopenedtext
        text "This move is not"
        line "available yet."
        done

.NotEnough:
    writethistext
        text "You've not enough"
        line "Crystals…"
        done
    sjump .EndingOffBattlePlazaMartMoveTutor

.Refused:
    writethistext
        text "Drop by anytime!"
        done
    sjump .EndingOffBattlePlazaMartMoveTutor

.TeachMove:
    callasm .PayTutorInCrystals
    writethistext
        text "Do visit again!"
        line "We're always open!"
        done
    playsound SFX_TRANSACTION
    waitsfx
    special CrystalCountInBag
.EndingOffBattlePlazaMartMoveTutor:
    waitclosetext
    turnobject BATTLEPLAZAMART_TUTOR, DOWN
    end

.PayTutorInCrystals:
; this is a variable `takeitem`, and idk what the script equivalent of this
; is soooo...
    ld a, CRYSTAL
    ld [wCurItem], a
    ld a, [wBattlePlazaCrystalMoveTutor] ; should have been set back in .LoadMovesMenu
    ld [wItemQuantityChange], a
    ld a, -1
    ld [wCurItemQuantity], a
    ld hl, wNumItems
    jmp TossItem

BattlePlazaMartTutorMoveText:
    text_start
    done

TutorUnlockEvents:
    dw EVENT_ROUTE_17_BERRY_3 ; Move 1 (MT01, FIRE_BLAST)
    dw EVENT_ROUTE_17_BERRY_3 ; Move 2 (MT02, THUNDER)
    dw EVENT_ROUTE_17_BERRY_3 ; Move 3 (MT03, BLIZZARD)
    dw EVENT_ROUTE_17_BERRY_3 ; Move 4 (MT04, REST)
    dw EVENT_ROUTE_17_BERRY_3 ; Move 5 (MT05, SLEEP_TALK)
    dw EVENT_ROUTE_17_BERRY_3 ; Move 6 (MT06, THUNDERPUNCH)
    dw EVENT_ROUTE_17_BERRY_3 ; Move 7 (MT07, FIRE_PUNCH)
    dw EVENT_ROUTE_17_BERRY_3 ; Move 8 (MT08, ICE_PUNCH)
    dw EVENT_ROUTE_17_BERRY_3 ; Move 9 (MT09, THUNDER_FANG)
    dw EVENT_ROUTE_17_BERRY_3 ; Move 10 (MT10, ICE_FANG)
    dw EVENT_ROUTE_17_BERRY_3 ; Move 11 (MT11, FIRE_FANG)
    dw EVENT_ROUTE_17_BERRY_3 ; Move 12 (MT12, SURF)
    dw EVENT_ROUTE_17_BERRY_3 ; Move 13 (MT13, ICY_WIND)
    dw EVENT_ROUTE_17_BERRY_3 ; Move 14 (MT14, SKY_ATTACK)
    dw EVENT_ROUTE_17_BERRY_3 ; Move 15 (MT15, DOUBLE_EDGE)
    dw EVENT_ROUTE_17_BERRY_3 ; Move 16 (MT16, FLARE_BLITZ)
    dw EVENT_ROUTE_17_BERRY_3 ; Move 17 (MT17, WILD_CHARGE)
    dw EVENT_ROUTE_17_BERRY_3 ; Move 18 (MT18, GIGA_IMPACT)
    dw EVENT_ROUTE_17_BERRY_3 ; Move 19 (MT19, HYPER_BEAM)
    dw EVENT_ROUTE_17_BERRY_3 ; Move 20 (MT20, SWIFT)
    dw EVENT_ROUTE_17_BERRY_3 ; Move 21 (MT21, HIDDEN_FORCE)
    dw EVENT_ROUTE_17_BERRY_3 ; Move 22 (MT22, HIDDEN_POWER)
    dw EVENT_ROUTE_17_BERRY_3 ; Move 23 (MT23, SUNNY_DAY)
    dw EVENT_ROUTE_17_BERRY_3 ; Move 24 (MT24, RAIN_DANCE)
    dw EVENT_ROUTE_17_BERRY_3 ; Move 25 (MT25, SANDSTORM)
    dw EVENT_ROUTE_17_BERRY_3 ; Move 26 (MT26, HAIL)
    dw EVENT_ROUTE_17_BERRY_3 ; Move 27 (MT27, FALSE_SWIPE)
    dw EVENT_ROUTE_17_BERRY_3 ; Move 28 (MT28, BULLDOZE)
    dw EVENT_ROUTE_17_BERRY_3 ; Move 29 (MT29, ROCK_TOMB)
    dw EVENT_ROUTE_17_BERRY_3 ; Move 30 (MT30, POUNCE)
TutorUnlockEventsEnd:

    assert (TutorUnlockEventsEnd - TutorUnlockEvents) / 2 == 30, \
        "TutorUnlockEvents needs one event per move of the Battle Plaza tutor's list"
