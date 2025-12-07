EggMaster:
    farcall PlaceMoneyTopRight
    call YesNoBox
    jr c, .cancel

    ; Calls the "CalculateCostAgainstPlayerMoney" label. Relative jump
    ; to the ".not_enough_money" local jump if the player does
    ; not have enough money and continue if they do.
    call CalculateCostAgainstPlayerMoney
    jr c, .not_enough_money

    ld hl, EggReminderWhichMonText
    call PrintText
.loop_party_menu
    farcall SelectMonFromParty
    jr c, .cancel
    ld a, [wCurPartySpecies]
    cp EGG
    jr z, .is_an_egg
    call IsAPokemon
    jr c, .cancel
    call GetRemindableEggMoves
    jr z, .no_moves_to_learn
    ld hl, EggReminderWhichMoveText
    call PrintText

.loop_move_menu
    call ChooseEggMoveToLearn
    jr c, .loop_party_menu
    ld a, [wMenuSelection]
    ld [wNamedObjectIndex], a
    call GetMoveName
    call CopyName1
    predef LearnMove
    ld a, b
    dec a
    jr z, .move_learned

.recheck_for_moves
    call GetRemindableEggMoves
    jr z, .no_moves_to_learn
    jr .loop_move_menu

.cancel
    ld hl, EggReminderCancelText
    jmp PrintText

.is_an_egg
    ld hl, EggReminderEggText
    call PrintText
    jr .loop_party_menu

.no_moves_to_learn
    ld hl, EggReminderNoMovesText
    call PrintText
    jr .loop_party_menu

; Loads and prints the "EggReminderNotEnoughMoneyText" text.
; This will end the dialogue.
.not_enough_money
    ld hl, EggReminderNotEnoughMoneyText
    jmp PrintText

.move_learned
    call ReturnToMapWithSpeechTextbox
    ld hl, EggReminderMoveLearnedText
    call PrintText
 
; This code falls through into the ".pay_for_move" local jump.

; Places the player's current money at the top right corner of
; the screen, retrieves the amount of money defined in the
; "EggMoveCost" label, removes the defined amount of money from
; the player, plays the "SFX_TRANSACTION" sound effect and
; finally prints the "EggReminderPaymentReceivedText" text.
.pay_for_move
    farcall PlaceMoneyTopRight
    ld hl, EggMoveCost
    ld de, hMoneyTemp
    ld bc, 3
    call CopyBytes
    call ApplyTilemap
    call PromptButton
    call WaitSFX
    ld bc, hMoneyTemp
    ld de, wMoney
    farcall TakeMoney
    farcall PlaceMoneyTopRight
    ld de, SFX_TRANSACTION
    call PlaySFX
    call WaitSFX
    ld hl, EggReminderPaymentReceivedText
    call PrintText
    ret

    call CalculateCostAgainstPlayerMoney
    jr c, .not_enough_money
 
    jr .recheck_for_moves

; Compares the value of "EggMoveCost" to
; the amount of money the player has.
CalculateCostAgainstPlayerMoney:
    ld hl, EggMoveCost
    ld de, hMoneyTemp
    ld bc, 3
    call CopyBytes
    ld bc, hMoneyTemp
    ld de, wMoney
    farcall CompareMoney
    ret

; The cost for learning a move.
EggMoveCost:
    dt 500000

GetRemindableEggMoves:
    ld hl, wd002
    xor a
    ld [hli], a
    ld [hl], $ff
    ld a, MON_SPECIES
    call GetPartyParamLocation
    ld a, [hl]
    ld [wCurPartySpecies], a
    push af
    ld b, 0
    ld de, wd002 + 1
    ld a, [wCurPartySpecies]
    dec a
    push bc
    ld c, a
    ld hl, EggMovePointers
    add hl, bc
    add hl, bc
    ld a, BANK(EggMovePointers)
    call GetFarWord

.loop_moves
    ld a, BANK("Egg Moves")
    call GetFarByte
    inc hl
    cp -1
    jr z, .done
    ld c, a
    call CheckAlreadyInList
    jr c, .loop_moves
    call CheckPokemonAlreadyKnowsMove
    jr c, .loop_moves
    ld a, c
    ld [de], a
    inc de
    ld a, $ff
    ld [de], a
    pop bc
    inc b
    push bc
    jr .loop_moves

.done
    pop bc
    pop af
    ld [wCurPartySpecies], a
    ld a, b
    ld [wd002], a
    and a
    ret

CheckAlreadyInMoveList:
    push hl
    ld hl, wd002 + 1

.loop
    ld a, [hli]
    inc a
    jr z, .nope
    dec a
    cp c
    jr nz, .loop
    pop hl
    scf
    ret

.nope
    pop hl
    and a
    ret

CheckPokemonAlreadyKnowsEggMove:
    push hl
    push bc
    ld a, MON_MOVES
    call GetPartyParamLocation
    ld b, 4

.loop
    ld a, [hli]
    cp c
    jr z, .yes
    dec b
    jr nz, .loop
    pop bc
    pop hl
    and a
    ret

.yes
    pop bc
    pop hl
    scf
    ret

ChooseEggMoveToLearn:
    farcall FadeOutToWhite
    farcall BlankScreen
    ld hl, .MenuHeader
    call CopyMenuHeader
    xor a
    ld [wMenuCursorPosition], a
    ld [wMenuScrollPosition], a
    hlcoord 0,  0
    lb bc, 9, 18
    call TextboxBorder
    hlcoord 2, 0
    lb bc, 1, 16
    call ClearBox
    ld de, FontBattleExtra + 14 tiles
    ld hl, vTiles2 tile $6e
    lb bc, BANK(FontBattleExtra), 1
    call Get2bppViaHDMA
    farcall LoadStatsScreenPageTilesGFX
    xor a
    ld [wMonType], a
    ld hl, wPartyMonNicknames
    ld a, [wCurPartyMon]
    call GetNickname
    hlcoord  3, 0
    call PlaceString
    farcall CopyMonToTempMon
    hlcoord 14, 0
    call PrintLevel
    call ScrollingMenu
    ld a, [wMenuJoypad]
    cp B_BUTTON
    jr z, .carry
    ld a, [wMenuSelection]
    ld [wPutativeTMHMMove], a
    and a
    ret

.carry
    scf
    ret

.MenuHeader:
    db MENU_BACKUP_TILES
    menu_coords 1, 1, SCREEN_WIDTH - 2, 9
    dw .MenuData
    db 1

.MenuData:
    db SCROLLINGMENU_DISPLAY_ARROWS | SCROLLINGMENU_ENABLE_FUNCTION3
    db 4, SCREEN_WIDTH + 2
    db SCROLLINGMENU_ITEMS_NORMAL
    dba  wd002
    dba .print_move_name
    dba .print_pp
    dba .print_move_details

.print_move_name
    push de
    ld a, [wMenuSelection]
    ld [wNamedObjectIndex], a
    call GetMoveName
    pop hl
    jmp PlaceString

.print_pp
    ld hl, wStringBuffer1
    ld bc, wStringBuffer2 - wStringBuffer1
    ld a, " "
    call ByteFill
    ld a, [wMenuSelection]
    inc a
    ret z
    dec a
    push de
    ld a, [wMenuSelection]
    ld bc, MOVE_LENGTH
    ld hl, (Moves + MOVE_PP) - MOVE_LENGTH
    call AddNTimes
    ld a, BANK(Moves)
    call GetFarByte
    ld [wBuffer1], a
    ld hl, wStringBuffer1 + 9
    ld de, wBuffer1
    lb bc, 1, 2
    call PrintNum
    ld hl, wStringBuffer1 + 11
    ld [hl], "/"
    ld hl, wStringBuffer1 + 12
    call PrintNum
    
    ld hl, wStringBuffer1 + 14
    ld [hl], "@"
    pop hl
    ld de, wStringBuffer1
    call PlaceString
    ld bc, 6
    add hl, bc
    ld a, $3e
    ld [hli], a
    ld [hl], a
    ret

.cancel_border_fix
    hlcoord 0, 9
    ld [hl], "│"
    inc hl
    ret

.print_move_details
    hlcoord 0, 10
    lb bc, 6, 18
    call TextboxBorder
    ld a, [wMenuSelection]
    cp -1
    jr z, .cancel_border_fix

.print_move_desc
    push de
    ld a, [wMenuSelection]
    inc a
    pop de
    ret z
    dec a
    ld [wCurSpecies], a
    hlcoord 1, 14
    predef PrintMoveDescription

.print_move_type
    ld a, [wCurSpecies]
    ld b, a
    hlcoord 10, 11
    predef PrintMoveType

.print_move_stat_strings
    hlcoord 0, 9
    ld de, MoveTypeTopString
    call PlaceString

    hlcoord 0, 10
    ld de, MoveTypeBottomString
    call PlaceString

    ld a, [wCurSpecies]
    ld b, a
    farcall GetMoveCategoryName
    hlcoord 10, 12
    ld de, wStringBuffer1
    call PlaceString

    hlcoord 1, 10
    ld de, MoveAttackString
    call PlaceString
    hlcoord  1, 12
    ld de, MoveChanceString
    call PlaceString
    hlcoord 1, 11
    ld de, MoveAccuracyString
    call PlaceString

.print_move_chance
    ld a, [wMenuSelection]
    ld bc, MOVE_LENGTH
    ld hl, (Moves + MOVE_CHANCE) - MOVE_LENGTH
    call AddNTimes
    ld a, BANK(Moves)
    call GetFarByte
    cp 1
    jr c, .print_move_null_chance
    call ConvertPercentages
    ld [wBuffer1], a
    ld de, wBuffer1
    lb bc, 1, 3
    hlcoord  5, 12
    call PrintNum
    ld [hl], "<%>" ; displays percent symbol
    hlcoord 8, 8
    jr .print_move_accuracy

.print_move_null_chance
    ld de, MoveNullValueString
    ld bc, 3
    hlcoord  5, 12
    call PlaceString

.print_move_accuracy
    ld a, [wMenuSelection]
    ld bc, MOVE_LENGTH
    ld hl, (Moves + MOVE_EFFECT) - MOVE_LENGTH
    call AddNTimes
    ld a, BANK(Moves)
    call GetFarByte

    ld hl, PerfectAccuracyEffects
    call IsInByteArray
    jr c, .imperfect

    ld a, [wMenuSelection]
    ld bc, MOVE_LENGTH
    ld hl, (Moves + MOVE_ACC) - MOVE_LENGTH
    call AddNTimes
    ld a, BANK(Moves)
    call GetFarByte

    call ConvertPercentages
    ld [wBuffer1], a
    ld de, wBuffer1
    lb bc, 1, 3
    hlcoord 5, 11
    call PrintNum
    ld [hl], "<%>" ; displays percent symbol
    hlcoord 7, 8
    jr .print_move_attack
; This code falls through into the ".print_move_attack" local jump.

.imperfect:
    ld de, MoveNullValueString
    ld bc, 3
    hlcoord 5, 11
    call PlaceString

.print_move_attack:
    ld a, [wMenuSelection]
    ld bc, MOVE_LENGTH
    ld hl, (Moves + MOVE_POWER) - MOVE_LENGTH
    call AddNTimes
    ld a, BANK(Moves)
    call GetFarByte
    cp 2
    jr c, .print_move_null_attack
    ld [wBuffer1], a
    ld de, wBuffer1
    lb bc, 1, 3
    hlcoord 5, 10
    jmp PrintNum
 
.print_move_null_attack
    hlcoord 5, 10
    ld de, MoveNullValueString
    ld bc, 3
    jmp PlaceString

; This is the text that displays if the player
; does not have enough money to learn a move.
EggReminderNotEnoughMoneyText:
    text "Hm… You don't have"
    line "enough money."

    para "Please come back"
    line "when you do."
    done

EggReminderWhichMonText:
    text "Which #MON"
    line "needs tutoring?"
    prompt

EggReminderWhichMoveText:
    text "Which move should"
    line "it learn, then?"
    prompt

EggReminderCancelText:
    text "Do visit again."
    done

EggReminderEggText:
    text "EGGS needs to be"
    line "hatched first."
    prompt

EggReminderNoMovesText:
    text "Hmm… this #MON"
    line "has no EGG MOVES."
    prompt

EggReminderMoveLearnedText:
    text "Done! Your #MON"
    line "learned the move."
    done

EggReminderPaymentReceivedText:
    text "Pleasure doing"
    line "business!"

    para "Come again, any-"
    line "time!"
    done
