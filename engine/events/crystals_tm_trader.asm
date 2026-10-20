DEF NUMBER_OF_TMS EQU 50

; Battle Plaza TM counter: sells all 50 TMs for Game Corner coins.
; Returns wScriptVar:
;   0     - cancelled
;   1-50  - TM selected; room checked, coins already deducted
;   51    - not enough coins
;   52    - no room in the TM/HM pocket
BattlePlazaTMCoinTrader:
	call LoadStandardMenuHeader
	call SelectTM
	ld a, c
	ld [wScriptVar], a
	and a
	ret z

; Refuse the TM if the pocket already holds a full stack, mirroring
; ReceiveTMHM's cap, so coins are never taken for nothing.
	dec a
	ld c, a
	ld b, 0
	ld hl, TMMenuItems
	add hl, bc
	ld a, [hl]
	sub TM01
	ld c, a
	ld b, 0
	ld hl, wTMsHMs
	add hl, bc
	ld a, [hl]
	cp MAX_ITEM_STACK
	jr nc, .no_room

; Load the TM's big-endian price into hMoneyTemp.
	ld a, [wScriptVar]
	dec a
	ld c, a
	ld b, 0
	ld hl, TMPrices
	add hl, bc
	add hl, bc
	ld a, [hli]
	ldh [hMoneyTemp], a
	ld a, [hl]
	ldh [hMoneyTemp + 1], a

; Load the TM's big-endian price into hMoneyTemp.
	ld a, [wScriptVar]
	dec a
	ld c, a
	ld b, 0
	ld hl, TMPrices
	add hl, bc
	add hl, bc
	ld a, [hli]
	ldh [hMoneyTemp], a
	ld a, [hl]
	ldh [hMoneyTemp + 1], a

; Check if the selected TM is unlocked (its event flag is set).
; TMUnlockEvents is a table of 50 event flags, one per TM.
	ld a, [wScriptVar]
	dec a  ; 0-based index
	ld c, a
	ld b, 0
	ld hl, TMUnlockEvents
	add hl, bc
	add hl, bc  ; 2 bytes per entry
	ld a, [hli]
	ld e, a
	ld a, [hl]
	ld d, a  ; de = event flag
	ld b, CHECK_FLAG
	call EventFlagAction
	jr nz, .charge_coins
; Event not set: return 53 (locked) without charging.
	ld a, 53
	ld [wScriptVar], a
	ret

.charge_coins:
; Charge the coins if the player can afford them.
	ld bc, hMoneyTemp
	farcall CheckCoins
	jr c, .not_enough_coins
	ld bc, hMoneyTemp
	farjp TakeCoins

.no_room
	ld a, 52
	ld [wScriptVar], a
	ret

.not_enough_coins
	ld a, 51
	ld [wScriptVar], a
	ret

SelectTM:
	ld hl, .MenuHeader
	call CopyMenuHeader
	xor a
	ldh [hBGMapMode], a
	call InitScrollingMenu
	; The menu's top border sits on row 2; redraw the coin box so its
	; bottom border closes over it, like the mart's money box.
	farcall DisplayCoinCaseBalance
	call UpdateSprites
.input_loop
	call ScrollingMenu
; Keep wMenuCursorPosition on the highlighted row: the script reopens
; this menu after a purchase or a refusal, and it resumes from
; wMenuCursorPosition and wMenuScrollPosition. Fresh conversations
; reset both beforehand through the script's .ResetTMCursor.
	ld a, [wMenuCursorY]
	ld [wMenuCursorPosition], a
	ld a, [wMenuJoypad]
	cp D_RIGHT
	jr z, .page_down
	cp D_LEFT
	jr z, .page_up
	cp B_BUTTON
	jr z, .nope
	cp A_BUTTON
	jr nz, .input_loop
	ld a, [wMenuSelection]
	cp -1
	jr nz, .done

.nope
	xor a ; FALSE

.done
	ld c, a
	ret

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

.MenuHeader
	db MENU_BACKUP_TILES ; flags
	; A padding row, three name/price pairs and a trailing padding row
	; fill the interior (rows 3-10); the box's bottom border lands on
	; row 11, the same divider row where the bag's TM pocket runs into
	; its description box.
	menu_coords 1, 3, SCREEN_WIDTH - 2, 10
	dw .MenuData
	db 1 ; default option

	db 0

.MenuData:
	; ENABLE_LEFT | ENABLE_RIGHT are the pair ScrollingMenu_CanWrap
	; requires for the list to loop (plus ENABLE_FUNCTION3, whose bit
	; doubles as STATICMENU_WRAP). They also hand D_LEFT/D_RIGHT back
	; to the caller, which the input loop above ignores. No
	; DISPLAY_ARROWS: the list wraps, so arrows would only suggest
	; limits that are not there.
	db SCROLLINGMENU_ENABLE_LEFT | SCROLLINGMENU_ENABLE_RIGHT | SCROLLINGMENU_ENABLE_FUNCTION3 ; flags
	db 3, 8 ; rows, columns
	db SCROLLINGMENU_ITEMS_NORMAL
	dba .tmnumber
	dba .tmname
	dba .PrintTMPrices
	dba .TMInBagQuantity

.tmnumber
	db NUMBER_OF_TMS
DEF x = 1
rept NUMBER_OF_TMS
	db x
DEF x = x + 1
endr
	db -1

.tmname
	; Check if this TM is unlocked (skip for cancel row)
	ld a, [wMenuSelection]
	cp -1
	jr z, .show_name
	and a
	jr z, .show_name

	; Save destination pointer
	push de

	; Look up event flag for this TM
	dec a
	ld c, a
	ld b, 0
	ld hl, TMUnlockEvents
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld e, a
	ld a, [hl]
	ld d, a  ; de = event flag
	ld b, CHECK_FLAG
	call EventFlagAction

	; Restore destination
	pop hl  ; hl = destination
	jr z, .locked  ; event not set

	; unlocked: restore de from hl and continue
	ld d, h
	ld e, l
.show_name:
	ld a, [wMenuSelection]
	call GetTMs
	ld a, [hl]
	push de
	ld [wNamedObjectIndex], a
	call GetItemName
	cp TM01
	jr c, .place_string
	ld hl, wStringBuffer1
	ld de, wStringBuffer4
	ld bc, STRING_BUFFER_LENGTH
	call CopyBytes
	ld de, wStringBuffer4 + STRLEN("TM##")
	callfar AppendTMHMMoveName
	ld de, wStringBuffer4
.place_string:
	pop hl
	jmp PlaceString

.locked:
	; Build "Unavailable XX" in wStringBuffer4
	; where XX is the TM number (1-50)
	push hl  ; save destination
	ld a, [wMenuSelection]
	; Calculate tens and ones digits
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
	pop hl  ; hl = destination
	jmp PlaceString

.UnavailablePrefix: db "Unavailable @"

.PrintTMPrices:
; de points right of the TM's name; print the price one row below,
; the same way the mart prints its prices. Copy the big-endian price
; through hMoneyTemp because PrintNum switches banks before reading it.
	push de
	ld a, [wScrollingMenuCursorPosition]
	ld c, a
	ld b, 0
	ld hl, TMPrices
	add hl, bc
	add hl, bc
	ld a, [hli]
	ldh [hMoneyTemp], a
	ld a, [hl]
	ldh [hMoneyTemp + 1], a
	pop hl
	ld bc, SCREEN_WIDTH
	add hl, bc
	ld de, hMoneyTemp
	lb bc, 2, 4 ; 2 bytes, 4 digits, no currency sign
	jmp PrintNum

.TMInBagQuantity:
; Show the hovered TM's stats in the description box below the list
; through DrawMoveInfoBox, and, like the mart, how many copies of the
; TM are in the bag. The list holds indexes (1-50), so map the
; selection to the real TM item id first.
	ld a, [wMenuSelection]
	cp -1
	jr z, .cancel_row
	call GetTMs
	ld a, [hl]
	ld [wCurItem], a
	farcall GetTMHMItemMove ; wTempTMHM <- this TM's move
	ld a, [wTempTMHM]
	ld [wCurSpecies], a
	call DrawMoveInfoBox

; How many copies of the hovered TM are in the bag.
	ld a, [wCurItem]
	sub TM01
	ld c, a
	ld b, 0
	ld hl, wTMsHMs
	add hl, bc
	ld a, [hl]
	cp MAX_ITEM_STACK + 1
	jr c, .stacked_ok
	ld a, MAX_ITEM_STACK
.stacked_ok
	ld [wMenuSelectionQuantity], a
	farjp PlaceItemInBagQuantity

.cancel_row
; Nothing to count on Cancel: redraw the description box empty so the
; last TM's stats do not linger, and keep the Bag box's frame open
; instead of blanking the area white.
	hlcoord 0, 11
	ld b, 5
	ld c, SCREEN_WIDTH - 2
	call Textbox
	hlcoord 0, 0
	ld b, 1
	ld c, 7
	call Textbox
	hlcoord 1, 1
	ld de, .BagString
	jmp PlaceString

.BagString db "Bag@"

DrawMoveInfoBox::
; Draw the move info box below a scrolling menu for the move in
; wCurSpecies: the bag TM/HM pocket's box and rows unchanged (see
; TMHM_ShowTMMoveDescription), so it reads exactly like the pocket.
; The Battle Plaza TM counter and the crystal Move Tutor both use it,
; so the two menus' bottom boxes match.
;
; The box's top border sits on row 11, closing over the list box's
; bottom border; its five interior rows run down to the screen edge,
; exactly the bag TM pocket's box.
	hlcoord 0, 11
	ld b, 5
	ld c, SCREEN_WIDTH - 2
	call Textbox

; Labels down the left...
	hlcoord 1, 12
	ld de, .PowString
	call PlaceString
	hlcoord 1, 13
	ld de, .HitString
	call PlaceString
	hlcoord 1, 14
	ld de, .EffString
	call PlaceString

; ...and the category under the type on the right. Status moves
; print /Other; the rest split physical/special by type, the same
; way the TM pocket does.
	ld a, [wCurSpecies]
	dec a
	ld hl, Moves + MOVE_POWER
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld a, BANK(Moves)
	call GetFarByte
	cp 2
	jr c, .status_move
	ld a, [wCurSpecies]
	dec a
	ld bc, MOVE_LENGTH
	ld hl, Moves
	call AddNTimes
	ld de, wStringBuffer1
	ld a, BANK(Moves)
	call FarCopyBytes
	ld a, [wStringBuffer1 + MOVE_TYPE]
	cp SPECIAL
	jr nc, .special_category
	ld de, .PhysicalString
	jr .place_category
.special_category
	ld de, .SpecialString
	jr .place_category
.status_move
	ld de, .OtherString
.place_category
	hlcoord 10, 13
	call PlaceString

; The move's type...
	ld a, [wCurSpecies]
	ld b, a
	hlcoord 10, 12
	predef PrintMoveType

; ...its effect chance...
	ld a, [wCurSpecies]
	ld bc, MOVE_LENGTH
	ld hl, (Moves + MOVE_CHANCE) - MOVE_LENGTH
	call AddNTimes
	ld a, BANK(Moves)
	call GetFarByte
	cp 1
	jr c, .null_chance
	call ConvertPercentages
	ld [wBuffer1], a
	ld de, wBuffer1
	lb bc, 1, 3
	hlcoord 5, 14
	call PrintNum
	ld [hl], "<%>" ; displays percent symbol
	jr .printed_chance
.null_chance
	ld de, .BlankString
	ld bc, 3
	hlcoord 5, 14
	call PlaceString
.printed_chance

; ...its accuracy, or --- for the perfect-accuracy effects...
	ld a, [wCurSpecies]
	ld bc, MOVE_LENGTH
	ld hl, (Moves + MOVE_EFFECT) - MOVE_LENGTH
	call AddNTimes
	ld a, BANK(Moves)
	call GetFarByte
	ld hl, PerfectAccuracyEffects
	call IsInByteArray
	jr nc, .imperfect
	ld de, .BlankString
	ld bc, 3
	hlcoord 5, 13
	call PlaceString
	jr .printed_accuracy

.imperfect
	ld a, [wCurSpecies]
	ld bc, MOVE_LENGTH
	ld hl, (Moves + MOVE_ACC) - MOVE_LENGTH
	call AddNTimes
	ld a, BANK(Moves)
	call GetFarByte
	call ConvertPercentages
	ld [wBuffer1], a
	ld de, wBuffer1
	lb bc, 1, 3
	hlcoord 5, 13
	call PrintNum
	ld [hl], "<%>" ; displays percent symbol

.printed_accuracy
; ...its power (status moves have none)...
	ld a, [wCurSpecies]
	dec a
	ld hl, Moves + MOVE_POWER
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld a, BANK(Moves)
	call GetFarByte
	hlcoord 5, 12
	cp 2
	jr c, .no_power
	ld [wTextDecimalByte], a
	ld de, wTextDecimalByte
	lb bc, 1, 3
	call PrintNum
	jr .printed_power
.no_power
	ld de, .BlankString
	call PlaceString
.printed_power

; ...and its description in the pocket's rows 15-16, flush against
; the bottom border with no spare interior row left over.
	hlcoord 1, 15
	predef_jump PrintMoveDescription

.PowString db "Pow/@"
.HitString db "Hit/@"
.EffString db "Eff/@"
.BlankString db "---@"
.PhysicalString db "/Physical@"
.SpecialString db "/Special @"
.OtherString db "/Other   @"

GetTMs:
	dec a
	ld hl, TMMenuItems
	ld b, 0
	ld c, a
	add hl, bc
	ret

TMMenuItems:
	db TM_METEOR_MASH
	db TM_HEADBUTT
	db TM_CURSE
	db TM_ROLLOUT
	db TM_ROAR
	db TM_TOXIC
	db TM_CALM_MIND
	db TM_BRICK_BREAK
	db TM_TACKLE
	db TM_HIDDEN_POWER
	db TM_SUNNY_DAY
	db TM_BULK_UP
	db TM_SLACK_OFF
	db TM_BLIZZARD
	db TM_HYPER_BEAM
	db TM_ICY_WIND
	db TM_PROTECT
	db TM_RAIN_DANCE
	db TM_GIGA_DRAIN
	db TM_POWER_GEM
	db TM_AURA_SPHERE
	db TM_SOLARBEAM
	db TM_SILVER_WIND
	db TM_DRAGON_PULSE
	db TM_THUNDER
	db TM_EARTHQUAKE
	db TM_RETURN
	db TM_DIG
	db TM_PSYCHIC_M
	db TM_SHADOW_BALL
	db TM_MUD_SLAP
	db TM_GUNK_SHOT
	db TM_HIDDEN_FORCE
	db TM_SWAGGER
	db TM_SLEEP_TALK
	db TM_SLUDGE_BOMB
	db TM_SANDSTORM
	db TM_FIRE_BLAST
	db TM_SWIFT
	db TM_DEFENSE_CURL
	db TM_THUNDERPUNCH
	db TM_DREAM_EATER
	db TM_DISARM_VOICE
	db TM_REST
	db TM_ATTRACT
	db TM_KNOCK_OFF
	db TM_STEEL_WING
	db TM_FIRE_PUNCH
	db TM_SHADOW_PUNCH
	db TM_TRICK

TMPrices:
; Big-endian coin prices (HI, LO), one per TMMenuItems entry,
; each a four-digit amount from 1000 to 9999.
	bigdw 8537 ; Meteor Mash
	bigdw 1500 ; Headbutt
	bigdw 4500 ; Curse
	bigdw 2200 ; Rollout
	bigdw 3000 ; Roar
	bigdw 6100 ; Toxic
	bigdw 7400 ; Calm Mind
	bigdw 5000 ; Brick Break
	bigdw 1000 ; Tackle
	bigdw 5400 ; Hidden Power
	bigdw 3500 ; Sunny Day
	bigdw 7000 ; Bulk Up
	bigdw 7800 ; Slack Off
	bigdw 7900 ; Blizzard
	bigdw 9000 ; Hyper Beam
	bigdw 2500 ; Icy Wind
	bigdw 4900 ; Protect
	bigdw 3300 ; Rain Dance
	bigdw 6500 ; Giga Drain
	bigdw 4000 ; Power Gem
	bigdw 7500 ; Aura Sphere
	bigdw 6900 ; SolarBeam
	bigdw 4200 ; Silver Wind
	bigdw 7200 ; Dragon Pulse
	bigdw 8200 ; Thunder
	bigdw 9500 ; Earthquake
	bigdw 4800 ; Return
	bigdw 3200 ; Dig
	bigdw 8800 ; Psychic
	bigdw 6800 ; Shadow Ball
	bigdw 1800 ; Mud-Slap
	bigdw 6200 ; Gunk Shot
	bigdw 5900 ; Hidden Force
	bigdw 2000 ; Swagger
	bigdw 4600 ; Sleep Talk
	bigdw 5800 ; Sludge Bomb
	bigdw 3100 ; Sandstorm
	bigdw 8100 ; Fire Blast
	bigdw 1200 ; Swift
	bigdw 1100 ; Defense Curl
	bigdw 5600 ; ThunderPunch
	bigdw 4100 ; Dream Eater
	bigdw 1600 ; Disarm Voice
	bigdw 6600 ; Rest
	bigdw 2800 ; Attract
	bigdw 6000 ; Knock Off
	bigdw 4400 ; Steel Wing
	bigdw 5500 ; Fire Punch
	bigdw 2400 ; Shadow Punch
	bigdw 7100 ; Trick

TMUnlockEvents:
; 50 event flags, one per TM (16-bit each).
; TM is only purchasable if the corresponding event is set.
	dw EVENT_BEAT_FALKNER ; TM 1
	dw EVENT_BEAT_BUGSY ; TM 2
	dw EVENT_BEAT_WHITNEY ; TM 3
	dw EVENT_BEAT_MORTY ; TM 4
	dw EVENT_BEAT_JASMINE ; TM 5
	dw EVENT_BEAT_CHUCK ; TM 6
	dw EVENT_BEAT_PRYCE ; TM 7
	dw EVENT_BEAT_CLAIR ; TM 8
	dw EVENT_BEAT_ELITE_4_WILL ; TM 9
	dw EVENT_BEAT_ELITE_4_KOGA ; TM 10
	dw EVENT_BEAT_ELITE_4_BRUNO ; TM 11
	dw EVENT_BEAT_ELITE_4_KAREN ; TM 12
	dw EVENT_BEAT_CHAMPION_LANCE ; TM 13
	dw EVENT_BEAT_ELITE_FOUR ; TM 14
	dw EVENT_BEAT_SWIMMERF_ELAINE ; TM 15
	dw EVENT_BEAT_SWIMMERF_PAULA ; TM 16
	dw EVENT_BEAT_SWIMMERF_KAYLEE ; TM 17
	dw EVENT_BEAT_SWIMMERF_SUSIE ; TM 18
	dw EVENT_BEAT_SWIMMERF_DENISE ; TM 19
	dw EVENT_BEAT_SWIMMERF_KARA ; TM 20
	dw EVENT_BEAT_SWIMMERF_WENDY ; TM 21
	dw EVENT_BEAT_BIRD_KEEPER_ROD ; TM 22
	dw EVENT_BEAT_BIRD_KEEPER_ABE ; TM 23
	dw EVENT_BEAT_BIRD_KEEPER_BRYAN ; TM 24
	dw EVENT_BEAT_BIRD_KEEPER_THEO ; TM 25
	dw EVENT_BEAT_BIRD_KEEPER_TOBY ; TM 26
	dw EVENT_BEAT_BIRD_KEEPER_DENIS ; TM 27
	dw EVENT_BEAT_BIRD_KEEPER_VANCE ; TM 28
	dw EVENT_BEAT_BIRD_KEEPER_JOSE ; TM 29
	dw EVENT_BEAT_BIRD_KEEPER_PETER ; TM 30
	dw EVENT_BEAT_BOARDER_RONALD ; TM 31
	dw EVENT_BEAT_BOARDER_DOUGLAS ; TM 32
	dw EVENT_BEAT_SAGE_CHOW ; TM 33
	dw EVENT_BEAT_SAGE_NICO ; TM 34
	dw EVENT_BEAT_SAGE_JIN ; TM 35
	dw EVENT_BEAT_SAGE_TROY ; TM 36
	dw EVENT_BEAT_SAGE_JEFFREY ; TM 37
	dw EVENT_BEAT_SAGE_PING ; TM 38
	dw EVENT_BEAT_SAGE_EDMOND ; TM 39
	dw EVENT_BEAT_SAGE_NEAL ; TM 40
	dw EVENT_BEAT_CAMPER_ROLAND ; TM 41
	dw EVENT_BEAT_CAMPER_TODD ; TM 42
	dw EVENT_BEAT_CAMPER_IVAN ; TM 43
	dw EVENT_BEAT_CAMPER_ELLIOT ; TM 44
	dw EVENT_BEAT_CAMPER_TED ; TM 45
	dw EVENT_BEAT_CAMPER_SPENCER ; TM 46
	dw EVENT_BEAT_BURGLAR_DUNCAN ; TM 47
	dw EVENT_BEAT_BURGLAR_EDDIE ; TM 48
	dw EVENT_BEAT_PSYCHIC_NATHAN ; TM 49
	dw EVENT_BEAT_PSYCHIC_GREG ; TM 50
