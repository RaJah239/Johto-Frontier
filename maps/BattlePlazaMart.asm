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
    ifequal 1,  .TMMeteorMash
    ifequal 2,  .TMHeadbutt
    ifequal 3,  .TMCurse
    ifequal 4,  .TMRollout
    ifequal 5,  .TMRoar
    ifequal 6,  .TMToxic
    ifequal 7,  .TMCalmMind
    ifequal 8,  .TMBrickBreak
    ifequal 9,  .TMPsychUp
    ifequal 10, .TMHiddenPower
    ifequal 11, .TMSunnyDay
    ifequal 12, .TMSweetScent
    ifequal 13, .TMSnore
    ifequal 14, .TMBlizzard
    ifequal 15, .TMHyperBeam
    ifequal 16, .TMIcyWind
    ifequal 17, .TMProtect
    ifequal 18, .TMRainDance
    ifequal 19, .TMGigaDrain
    ifequal 20, .TMPowerGem
    ifequal 21, .TMFrustration
    ifequal 22, .TMSolarbeam
    ifequal 23, .TMIronTail
    ifequal 24, .TMDragonBreadth
    ifequal 25, .TMThunder
    ifequal 26, .TMEarthquake
    ifequal 27, .TMReturn
    ifequal 28, .TMDig
    ifequal 29, .TMPsychic
    ifequal 30, .TMShadowBall
    ifequal 31, .TMMudSlap
    ifequal 32, .TMGunkShot
    ifequal 33, .TMHiddenForce
    ifequal 34, .TMSwagger
    ifequal 35, .TMSleepTalk
    ifequal 36, .TMSludgeBomb
    ifequal 37, .TMSandStorm
    ifequal 38, .TMFireBlast
    ifequal 39, .TMSwift
    ifequal 40, .TMDefenseCurl
    ifequal 41, .TMThunderPunch
    ifequal 42, .TMDreamEater
    ifequal 43, .TMDetect
    ifequal 44, .TMRest
    ifequal 45, .TMAttract
    ifequal 46, .TMKnockOff
    ifequal 47, .TMStealWing
    ifequal 48, .TMFirePunch
    ifequal 49, .TMFuryCutter
    ifequal 50, .TMTrick
    sjump .CancelBuyingTMsScript

.NoRoom:
    writethistext
        text "You already have"
        line "99! Pick another?"
        done
    waitbutton
    sjump .WantToBuyADifferentTM

.TMMeteorMash:
    verbosegiveitem TM_METEOR_MASH
    iffalse .NoRoom
    sjump .ConcludeTransaction

.TMHeadbutt:
    verbosegiveitem TM_HEADBUTT
    iffalse .NoRoom
    sjump .ConcludeTransaction

.Unavailable:
    jumpthisopenedtext
        text "This TM is not"
        line "available yet."
        done

.TMCurse:
    verbosegiveitem TM_CURSE
    iffalse .NoRoom
    sjump .ConcludeTransaction

.TMRollout:
    verbosegiveitem TM_ROLLOUT
    iffalse .NoRoom
    sjump .ConcludeTransaction

.TMRoar:
    verbosegiveitem TM_ROAR
    iffalse .NoRoom
    sjump .ConcludeTransaction

.TMToxic:
    verbosegiveitem TM_TOXIC
    iffalse .NoRoom
    sjump .ConcludeTransaction

.TMCalmMind:
    verbosegiveitem TM_CALM_MIND
    iffalse .NoRoom
    sjump .ConcludeTransaction

.TMBrickBreak:
    verbosegiveitem TM_BRICK_BREAK
    iffalse .NoRoom
    sjump .ConcludeTransaction

.TMPsychUp:
    verbosegiveitem TM_TACKLE
    iffalse .NoRoom
    sjump .ConcludeTransaction

.TMHiddenPower:
    verbosegiveitem TM_HIDDEN_POWER
    iffalse .NoRoom
    sjump .ConcludeTransaction

.TMSunnyDay:
    verbosegiveitem TM_SUNNY_DAY
    iffalse .NoRoom
    sjump .ConcludeTransaction

.TMSweetScent:
    verbosegiveitem TM_BULK_UP
    iffalse .NoRoom
    sjump .ConcludeTransaction

.TMSnore:
    verbosegiveitem TM_SLACK_OFF
    iffalse .NoRoom
    sjump .ConcludeTransaction

.TMBlizzard:
    verbosegiveitem TM_BLIZZARD
    iffalse .NoRoom
    sjump .ConcludeTransaction

.TMHyperBeam:
    verbosegiveitem TM_HYPER_BEAM
    iffalse .NoRoom
    sjump .ConcludeTransaction

.TMIcyWind:
    verbosegiveitem TM_ICY_WIND
    iffalse .NoRoom
    sjump .ConcludeTransaction

.TMProtect:
    verbosegiveitem TM_PROTECT
    iffalse .NoRoom
    sjump .ConcludeTransaction

.TMRainDance:
    verbosegiveitem TM_RAIN_DANCE
    iffalse .NoRoom
    sjump .ConcludeTransaction

.TMGigaDrain:
    verbosegiveitem TM_GIGA_DRAIN
    iffalse .NoRoom
    sjump .ConcludeTransaction

.TMPowerGem:
    verbosegiveitem TM_POWER_GEM
    iffalse .NoRoom
    sjump .ConcludeTransaction

.TMFrustration:
    verbosegiveitem TM_AURA_SPHERE
    iffalse .NoRoom
    sjump .ConcludeTransaction

.TMSolarbeam:
    verbosegiveitem TM_SOLARBEAM
    iffalse .NoRoom
    sjump .ConcludeTransaction

.TMIronTail:
    verbosegiveitem TM_SILVER_WIND
    iffalse .NoRoom
    sjump .ConcludeTransaction

.TMDragonBreadth:
    verbosegiveitem TM_DRAGON_PULSE
    iffalse .NoRoom
    sjump .ConcludeTransaction

.TMThunder:
    verbosegiveitem TM_THUNDER
    iffalse .NoRoom
    sjump .ConcludeTransaction

.TMEarthquake:
    verbosegiveitem TM_EARTHQUAKE
    iffalse .NoRoom
    sjump .ConcludeTransaction

.TMReturn:
    verbosegiveitem TM_RETURN
    iffalse .NoRoom
    sjump .ConcludeTransaction

.TMDig:
    verbosegiveitem TM_DIG
    iffalse .NoRoom
    sjump .ConcludeTransaction

.TMPsychic:
    verbosegiveitem TM_PSYCHIC_M
    iffalse .NoRoom
    sjump .ConcludeTransaction

.TMShadowBall:
    verbosegiveitem TM_SHADOW_BALL
    iffalse .NoRoom
    sjump .ConcludeTransaction

.TMMudSlap:
    verbosegiveitem TM_MUD_SLAP
    iffalse .NoRoom
    sjump .ConcludeTransaction

.TMGunkShot:
    verbosegiveitem TM_GUNK_SHOT
    iffalse .NoRoom
    sjump .ConcludeTransaction

.TMHiddenForce:
    verbosegiveitem TM_HIDDEN_FORCE
    iffalse .NoRoom
    sjump .ConcludeTransaction

.TMSwagger:
    verbosegiveitem TM_SWAGGER
    iffalse .NoRoom
    sjump .ConcludeTransaction

.TMSleepTalk:
    verbosegiveitem TM_SLEEP_TALK
    iffalse .NoRoom
    sjump .ConcludeTransaction

.TMSludgeBomb:
    verbosegiveitem TM_SLUDGE_BOMB
    iffalse .NoRoom
    sjump .ConcludeTransaction

.TMSandStorm:
    verbosegiveitem TM_SANDSTORM
    iffalse .NoRoom
    sjump .ConcludeTransaction

.TMFireBlast:
    verbosegiveitem TM_FIRE_BLAST
    iffalse .NoRoom
    sjump .ConcludeTransaction

.TMSwift:
    verbosegiveitem TM_SWIFT
    iffalse .NoRoom
    sjump .ConcludeTransaction

.TMDefenseCurl:
    verbosegiveitem TM_DEFENSE_CURL
    iffalse .NoRoom
    sjump .ConcludeTransaction

.TMThunderPunch:
    verbosegiveitem TM_THUNDERPUNCH
    iffalse .NoRoom
    sjump .ConcludeTransaction

.TMDreamEater:
    verbosegiveitem TM_DREAM_EATER
    iffalse .NoRoom
    sjump .ConcludeTransaction

.TMDetect:
    verbosegiveitem TM_DISARM_VOICE
    iffalse .NoRoom
    sjump .ConcludeTransaction

.TMRest:
    verbosegiveitem TM_REST
    iffalse .NoRoom
    sjump .ConcludeTransaction

.TMAttract:
    verbosegiveitem TM_ATTRACT
    iffalse .NoRoom
    sjump .ConcludeTransaction

.TMKnockOff:
    verbosegiveitem TM_KNOCK_OFF
    iffalse .NoRoom
    sjump .ConcludeTransaction

.TMStealWing:
    verbosegiveitem TM_STEEL_WING
    iffalse .NoRoom
    sjump .ConcludeTransaction

.TMFirePunch:
    verbosegiveitem TM_FIRE_PUNCH
    iffalse .NoRoom
    sjump .ConcludeTransaction

.TMFuryCutter:
    verbosegiveitem TM_SHADOW_PUNCH
    iffalse .NoRoom
    sjump .ConcludeTransaction

.TMTrick:
    verbosegiveitem TM_TRICK
    iffalse .NoRoom
    ; fallthrough

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
    callasm .SetupMovesMenu
    callasm .LoadMovesMenu
    writetext BattlePlazaMartTutorMoveText
    ifequal 2, .NotEnough
    ifequal 3, .LockedMove
    iffalse .CloseTutor
    special MoveTutor2
    iffalse .TeachMove
.CloseTutor
    sjump .Refused

.LoadMovesMenu:
    call ClearSprites
    call LoadStandardMenuHeader
    ld hl, .MovesMenu
    call LoadMenuHeader
    xor a
    ld [wMenuCursorPosition], a
    ld [wMenuScrollPosition], a
    ldh [hBGMapMode], a
    call InitScrollingMenu
.input_loop
    call ScrollingMenu
; Keep wMenuCursorPosition on the highlighted row: the menu reopens
; from it, and the loop reenters whenever the menu hands back a key it
; is not confirming with (D_LEFT/D_RIGHT, now that the list wraps).
    ld a, [wMenuCursorY]
    ld [wMenuCursorPosition], a
    ld a, [wMenuJoypad]
    cp B_BUTTON
    jr z, .cancel_selection
    cp A_BUTTON
    jr nz, .input_loop
    ld a, [wMenuSelection]
    cp -1 ; CANCEL
    jr z, .cancel_selection
; selection confirmed
    assert wMenuSelectionQuantity == wMenuSelection + 1
    ld hl, wMenuSelection
    ld a, [hli]
    ld [wNamedObjectIndex], a
    ; Check if this move is unlocked
    ld c, a  ; c = move ID
    ld hl, wBattlePlazaCrystalMoveTutor
    inc hl  ; skip count byte
    ld b, 0  ; index counter
.find_move_index:
    ld a, [hl]
    cp -1
    jr z, .move_not_found
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
    push hl
    ld hl, TutorUnlockEvents
    add hl, bc
    add hl, bc
    ld a, [hli]
    ld e, a
    ld a, [hl]
    ld d, a
    ld b, CHECK_FLAG
    call EventFlagAction
    pop hl
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

.move_not_found:
    ld a, [wMenuSelection]
    ld [wNamedObjectIndex], a
    ld hl, wMenuSelection
    ld a, [hli]
    ld a, [hl]
    ld [wBattlePlazaCrystalMoveTutor], a
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
    dba wBattlePlazaCrystalMoveTutor
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
    farjp DrawMoveInfoBox

.clear_move_info
; Nothing hovered: redraw the box empty so the last move's stats do
; not linger once Cancel is highlighted.
    hlcoord 0, 11
    ld b, 5
    ld c, SCREEN_WIDTH - 2
    jmp Textbox

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
    ld hl, wBattlePlazaCrystalMoveTutor
    inc hl  ; skip count byte
    ld b, 0  ; index counter
.find_index:
    ld a, [hl]
    cp -1  ; terminator
    jr z, .not_found
    cp c
    jr z, .found
    inc hl  ; skip move ID
    inc hl  ; skip cost
    inc b
    jr .find_index
.found:
    ; b = index (0-13), save it
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
    ; Save index
    push bc
    ; Calculate tens and ones digits
    ld a, b  ; a = index (0-13)
    inc a  ; 1-14 (move number)
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
    pop bc  ; restore index (not needed, but balance stack)
    pop hl  ; hl = destination (from initial push de)
    jmp PlaceString

.show_name:
    ld a, [wMenuSelection]
    ld [wNamedObjectIndex], a
    call GetMoveName
    pop hl
    jmp PlaceString

.not_found:
    ld a, [wMenuSelection]
    ld [wNamedObjectIndex], a
    call GetMoveName
    pop hl
    jmp PlaceString

.UnavailablePrefix: db "Unavailable @"

.SetupMovesMenu:
; copy the whole move list
    ld hl, .FullMoveList
    ld de, wBattlePlazaCrystalMoveTutor
    ld bc, .FullMoveListEnd - .FullMoveList
    call CopyBytes

; move the CANCEL indicator
    add a ; a *= 2, because quantity is factored in
    add l
    ld l, a
    ld a, -1
    ld [hl], a
    ret

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
    db 14 ; list length
; list items
    db TELEPORT, 1
    db SEISMIC_TOSS, 6
    db BUBBLEBEAM, 6
    db REFLECT, 4
    db BODY_SLAM, 12
    db THUNDER_WAVE, 12
    db PHOTON_BLAST, 18
    db MEGA_DRAIN, 17
    db SUBSTITUTE, 20
    db METRONOME, 15
    db ROCK_SLIDE, 25
    db SWORDS_DANCE, 23
    db DOUBLE_EDGE, 24
    db EXPLOSION, 23
    db -1 ; terminator
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
    dw EVENT_BEAT_FALKNER ; Move 1
    dw EVENT_BEAT_BUGSY ; Move 2
    dw EVENT_BEAT_WHITNEY ; Move 3
    dw EVENT_BEAT_MORTY ; Move 4
    dw EVENT_BEAT_JASMINE ; Move 5
    dw EVENT_BEAT_CHUCK ; Move 6
    dw EVENT_BEAT_PRYCE ; Move 7
    dw EVENT_BEAT_CLAIR ; Move 8
    dw EVENT_BEAT_ELITE_4_WILL ; Move 9
    dw EVENT_BEAT_ELITE_4_KOGA ; Move 10
    dw EVENT_BEAT_ELITE_4_BRUNO ; Move 11
    dw EVENT_BEAT_ELITE_4_KAREN ; Move 12
    dw EVENT_BEAT_CHAMPION_LANCE ; Move 13
    dw EVENT_BEAT_ELITE_FOUR ; Move 14
