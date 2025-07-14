    object_const_def
    const BATTLETOWERMART_CLERK_ALL_TMS
    const BATTLETOWERMART_PORYGON_PC
    const BATTLETOWERMART_TUTOR

BattleTowerMart_MapScripts:
    def_scene_scripts

    def_callbacks

BattleTowerMartTMCoinTraderScript:
    faceplayer
    opentext
    special DisplayCoinCaseBalance
    checkevent EVENT_BATTLE_TOWER_TM_MART_INTRO
    iftrue .WantToBuyATM
    writetext BattleTowerTMMartIntroText
    setevent EVENT_BATTLE_TOWER_TM_MART_INTRO
    sjump .WantToBuyATMAfterIntro
.WantToBuyATM:
    writetext BattleTowerTMMartBuyTMText
.WantToBuyATMAfterIntro:
    yesorno
    iffalse .Refused
    checkcoins 9000
    ifequal HAVE_LESS, .NotEnoughCoins
.WantToBuyADifferentTM:
    special CoinsTMTrader
    ifequal 1,  .TMMeteorMash
    ifequal 2,  .TMHeadbutt
    ifequal 3,  .TMCurse
    ifequal 4,  .TMRollout
    ifequal 5,  .TMRoar
    ifequal 6,  .TMToxic
    ifequal 7,  .TMZapCannon
    ifequal 8,  .TMRockSmash
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
    ifequal 20, .TMEndure
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
    ifequal 32, .TMDoulbeTeam
    ifequal 33, .TMIcePunch
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
    ifequal 46, .TMTheif
    ifequal 47, .TMStealWing
    ifequal 48, .TMFirePunch
    ifequal 49, .TMFuryCutter
    ifequal 50, .TMNightmare
    sjump CancelBuyingTMsScript
    end

.NoRoom:
    writetext YoureACollectorText
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

.TMZapCannon:
    verbosegiveitem TM_ZAP_CANNON
    iffalse .NoRoom
    sjump .ConcludeTransaction

.TMRockSmash:
    verbosegiveitem TM_ROCK_SMASH
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
    verbosegiveitem TM_SNORE
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

.TMEndure:
    verbosegiveitem TM_ENDURE
    iffalse .NoRoom
    sjump .ConcludeTransaction

.TMFrustration:
    verbosegiveitem TM_FRUSTRATION
    iffalse .NoRoom
    sjump .ConcludeTransaction

.TMSolarbeam:
    verbosegiveitem TM_SOLARBEAM
    iffalse .NoRoom
    sjump .ConcludeTransaction

.TMIronTail:
    verbosegiveitem TM_IRON_TAIL
    iffalse .NoRoom
    sjump .ConcludeTransaction

.TMDragonBreadth:
    verbosegiveitem TM_DRAGONBREATH
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

.TMDoulbeTeam:
    verbosegiveitem TM_DOUBLE_TEAM
    iffalse .NoRoom
    sjump .ConcludeTransaction

.TMIcePunch:
    verbosegiveitem TM_ICE_PUNCH
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
    verbosegiveitem TM_DETECT
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

.TMTheif:
    verbosegiveitem TM_THIEF
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
    verbosegiveitem TM_FURY_CUTTER
    iffalse .NoRoom
    sjump .ConcludeTransaction

.TMNightmare:
    verbosegiveitem TM_NIGHTMARE
    iffalse .NoRoom
    sjump .ConcludeTransaction

.Refused:
    writetext WeAreOpenAlways
    waitbutton
    closetext
    end

.NotEnoughCoins:
    writetext NotEnoughCoinsText
    waitbutton
    closetext
    end

.ConcludeTransaction:
    special DisplayCoinCaseBalance
    takecoins 9000
    waitsfx
    playsound SFX_TRANSACTION
    special DisplayCoinCaseBalance
    writetext ReturnAnytimeText
    waitbutton
    closetext
    end 

CancelBuyingTMsScript:
    opentext
    writetext ComeAgainAgainText
    waitbutton
    closetext
    end

ComeAgainAgainText:
    text "Please come again!"
    done

BattleTowerTMMartIntroText:
    text "Greetings, welcome"
    line "to the TM counter."

    para "You can purchase"
    line "any TM here for"
    cont "9,000 coins."

    para "Are you in need of"
    line "anything?"
    done

BattleTowerTMMartBuyTMText:
    text "Welcome! Buy a TM"
    line "for 9,000 coins?"
    done

WeAreOpenAlways:
    text "We are open 24/7."
    done

NotEnoughCoinsText:
    text "You don't have"
    line "9,000 coins…"
    done

ReturnAnytimeText:
    text "Do pay us a visit"
    line "anytime!"
    done

YoureACollectorText:
    text "You already have"
    line "99! Pick another?"
    done

BattleTowerMartPorygonPCScript:
    jumpstd PorygonPCScript

BattleTowerMartTutorScientistScript:
    faceplayer
    opentext
    special CrystalCountInBag
    checkevent EVENT_MET_BATTLE_TOWER_MOVE_TUTOR
    iftrue .WelcomeBackWantMeToTeach
    writetext BattleTowerMartTutorWantMeToTeachText
    setevent EVENT_MET_BATTLE_TOWER_MOVE_TUTOR
    sjump .TeachAnotherMove
.WelcomeBackWantMeToTeach:
    writetext BattleTowerMartTutorWelcomeBackWantMeToTeachText
.TeachAnotherMove:
    yesorno
    iffalse .Refused
    writetext BattleTowerMartTutorShallITeachText
    callasm .SetupMovesMenu
    callasm .LoadMovesMenu
    writetext BattleTowerMartTutorMoveText
    ifequal 2, .NotEnough
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
    call ScrollingMenu
    ld a, [wMenuJoypad]
    cp B_BUTTON
    jr z, .cancel_selection
    ld a, [wMenuSelection]
    cp -1 ; CANCEL
    jr z, .cancel_selection
; selection confirmed
    assert wMenuSelectionQuantity == wMenuSelection + 1
    ld hl, wMenuSelection
    ld a, [hli]
    ld [wNamedObjectIndex], a
    ld a, [hl]
    ld [wBattleTowerCrystalMoveTutor], a ; not used for menus anymore at this point
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
    db SCROLLINGMENU_DISPLAY_ARROWS | SCROLLINGMENU_ENABLE_FUNCTION3
    db 3 ; height
    db 1 ; width ("1" triggers Function 2 to run)
    db SCROLLINGMENU_ITEMS_QUANTITY ; item format
    dba wBattleTowerCrystalMoveTutor
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
    jr .done

.display_needed_amount
    ld de, .CrystalText
    call PlaceString
    hlcoord 6, 1
    ld de, wMenuSelectionQuantity
    lb bc, PRINTNUM_LEADINGZEROS | 1, 2
    call PrintNum
.done
    ret

.CrystalText:
    db "Cost×@"

.ExitString:
    db "@"

.DisplayAmountOkNotReally:
; this is usually for displaying something on the right
; hand side of the menu, but we don't need that here
    ret

.DisplayMoveName:
    push de
    ld a, [wMenuSelection]
    ld [wNamedObjectIndex], a
    call GetMoveName
    pop hl
    jp PlaceString

.SetupMovesMenu:
; copy the whole move list
    ld hl, .FullMoveList
    ld de, wBattleTowerCrystalMoveTutor
    ld bc, .FullMoveListEnd - .FullMoveList
    call CopyBytes

; move the CANCEL indicator
    sla a ; a *= 2, because quantity is factored in
    add l
    ld l, a
    ld a, -1
    ld [hl], a
.got_menu
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
    db 19 ; list length
; list items
    db TELEPORT, 1
    db MEGA_PUNCH, 3
    db PSYWAVE, 2
    db SEISMIC_TOSS, 6
    db BUBBLEBEAM, 6
    db REFLECT, 4
    db MEGA_KICK, 5
    db BODY_SLAM, 12
    db MIMIC, 10
    db SELFDESTRUCT, 16
    db THUNDER_WAVE, 12
    db TRI_ATTACK, 18
    db MEGA_DRAIN, 17
    db SUBSTITUTE, 20
    db METRONOME, 15
    db ROCK_SLIDE, 25
    db SWORDS_DANCE, 23
    db DOUBLE_EDGE, 24
    db EXPLOSION, 23
    db -1 ; terminator
.FullMoveListEnd:

.NotEnough:
    writetext BattleTowerMartTutorNotEnoughCrystalsText
    sjump .EndingOffBattleTowerMartMoveTutor

.Refused:
    writetext BattleTowerMartTutorDropByAnytimeText
    sjump .EndingOffBattleTowerMartMoveTutor

.TeachMove:
    callasm .PayTutorInCrystals
    writetext BattleTowerMartTutorExcellentText
    playsound SFX_TRANSACTION
    waitsfx
    special CrystalCountInBag
.EndingOffBattleTowerMartMoveTutor:
    waitbutton
    closetext
    turnobject BATTLETOWERMART_TUTOR, DOWN
    end

.PayTutorInCrystals:
; this is a variable `takeitem`, and idk what the script equivalent of this
; is soooo...
    ld a, CRYSTAL
    ld [wCurItem], a
    ld a, [wBattleTowerCrystalMoveTutor] ; should have been set back in .LoadMovesMenu
    ld [wItemQuantityChange], a
    ld a, -1
    ld [wCurItemQuantity], a
    ld hl, wNumItems
    call TossItem
    ret

BattleTowerMartTutorWantMeToTeachText:
    text "Welcome! I'm am"
    line "the Battle Tower's"
    cont "Move Tutor."

    para "I can teach your"
    line "precious #MON"

    para "special moves for"
    line "a varied amount"
    cont "of Crystals each."

    para "Want me to teach"
    line "your #MON some"
    cont "moves?"
    done

BattleTowerMartTutorWelcomeBackWantMeToTeachText:
    text "Welcome once more"
    line "esteemed trainer!"
    
    para "Shall I tutor a"
    line "move onto your"

    para "#MON for a set"
    line "sum of Crystals?"
    done

BattleTowerMartTutorShallITeachText:
    text "Which move shall"
    line "I teach?"
    done

BattleTowerMartTutorNotEnoughCrystalsText:
    text "You've not enough"
    line "Crystals…"
    done

BattleTowerMartTutorDropByAnytimeText:
    text "Drop by anytime!"
    done

BattleTowerMartTutorExcellentText:
    text "Do visit again!"
    line "We're always open!"
    done

BattleTowerMartTutorMoveText:
    text_start
    done

BattleTowerMart_MapEvents:

    def_warp_events
    warp_event  4,  9, BATTLE_TOWER_1F, 4
    warp_event 12,  9, BATTLE_TOWER_1F, 5
    warp_event  3,  9, BATTLE_TOWER_1F, 4
    warp_event 11,  9, BATTLE_TOWER_1F, 5
    def_coord_events

    def_bg_events

    def_object_events
    object_event 12,  1, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, BattleTowerMartTMCoinTraderScript, -1
    object_event 10,  1, SPRITE_PORYGON_OW, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_PURPLE, OBJECTTYPE_SCRIPT, 0, BattleTowerMartPorygonPCScript, -1
    object_event 13,  1, SPRITE_LINK_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_TEAL, OBJECTTYPE_SCRIPT, 0, BattleTowerMartTutorScientistScript, -1
