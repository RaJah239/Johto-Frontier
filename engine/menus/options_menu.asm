DEF NUM_OPTIONS EQU 7

_Option:
	call ClearJoypad
	ld hl, hInMenu
	ld a, [hl]
	push af
	ld [hl], TRUE
	call ClearBGPalettes
	hlcoord 0, 0
	lb bc, SCREEN_HEIGHT - 2, SCREEN_WIDTH - 2
	call Textbox
	hlcoord 2, 2
	ld de, StringOptions1
	call PlaceString
	xor a
	ld [wCurOptionsPage], a

	call OptionsMenu_LoadOptions

	xor a
	ld [wJumptableIndex], a
	call WaitBGMap
	ld b, SCGB_DIPLOMA
	call GetSGBLayout
	call SetDefaultBGPAndOBP

.joypad_loop
	call JoyTextDelay
	ldh a, [hJoyPressed]
	and START | B_BUTTON
	jr nz, .ExitOptions
	call OptionsControl
	jr c, .dpad
	call GetOptionPointer
	jr c, .ExitOptions

.dpad
	call Options_UpdateCursorPosition
	ld c, 3
	call DelayFrames
	jr .joypad_loop

.ExitOptions:
	ld de, SFX_SAVE
	call PlaySFX
	call WaitSFX
	pop af
	ldh [hInMenu], a
	ret

OptionsMenu_LoadOptions:
	xor a
	ld [wJumptableIndex], a
	ldh [hJoyPressed], a
	ld c, $7 ; number of items on the menu minus 1 (for done)
.print_text_loop ; this next will display the settings of each option when the menu is opened
	push bc
	xor a
	ldh [hJoyLast], a
	call GetOptionPointer
	pop bc
	ld hl, wJumptableIndex
	inc [hl]
	dec c
	jr nz, .print_text_loop
	ld a, [wCurOptionsPage]
	and a
	call z, UpdateFrame
	ld a, 1
	ldh [hBGMapMode], a
	ret

StringOptions1:
	db "Text Speed<LF>"
	db "        :<LF>"
	db "Battle Scene<LF>"
	db "        :<LF>"
	db "Audio Mode<LF>"
	db "        :<LF>"
	db "Running Shoes<LF>"
	db "        :<LF>"
	db "Auto Bicycle<LF>"
	db "        :<LF>"
	db "Casual Calls<LF>"
	db "        :<LF>"
	db "Frame<LF>"
	db "        :Type<LF>"
	db "Next Page@"

StringOptions2:
	db "#mon Center<LF>"
	db "        :<LF>"
	db "#mon Calls<LF>"
	db "        :<LF>"
	db "Battles<LF>"
	db "        :<LF>"
	db "Exp.Share<LF>"
	db "        :<LF>"
	db "Dialogue/Text<LF>"
	db "        :<LF>"
	db "Fast Boot<LF>"
	db "        :<LF>"
	db "Hard Mode<LF>"
	db "         <LF>"
	db "Previous Page@"

GetOptionPointer:
	ld a, [wCurOptionsPage]
	and a
	ld a, [wJumptableIndex]
	jr z, .page1
	add NUM_OPTIONS + 1
.page1
	call StackJumpTable

.Pointers:
	dw Options_TextSpeed
	dw Options_BattleScene
	dw Options_Sound
	dw Options_ExpShare
	dw Options_AutoBicycle
	dw Options_CasualCalls
	dw Options_Frame
	dw Options_NextPrevious

	dw Options_QuickNurse
	dw Options_QuickPokeCalls
	dw Options_FasterBattles
	dw Options_ExpShare
	dw Options_MinimalDialogue
	dw Options_FastBoot
	dw Options_HardMode
	dw Options_NextPrevious

	const_def
	const OPT_TEXT_SPEED_FAST ; 1
	const OPT_TEXT_SPEED_NONE ; 2

Options_QuickNurse:
Options_QuickPokeCalls:
Options_FasterBattles:
Options_FastBoot: ; place holder
	ret

Options_TextSpeed:
	call GetTextSpeed
	ldh a, [hJoyPressed]
	bit D_RIGHT_F, a
	jr nz, .LeftPressed
	bit D_LEFT_F, a
	jr z, .NonePressed
	ld a, c ; right pressed
	cp OPT_TEXT_SPEED_NONE
	jr c, .Increase
	ld c, OPT_TEXT_SPEED_FAST - 1

.Increase:
	inc c
	ld a, e
	jr .Save

.LeftPressed:
	ld a, c
	and a
	jr nz, .Decrease
	ld c, OPT_TEXT_SPEED_NONE + 1

.Decrease:
	dec c
	ld a, d

.Save:
	ld b, a
	ld a, [wOptions]
	and $f0
	or b
	ld [wOptions], a

.NonePressed:
	ld b, 0
	ld hl, .Strings
	add hl, bc
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	hlcoord 11, 3
	call PlaceString
	and a
	ret

.Strings:
; entries correspond to OPT_TEXT_SPEED_* constants
	dw .Fast
	dw .None

.Fast: db "Fast   @"
.None: db "Instant@"

GetTextSpeed:
; converts TEXT_DELAY_* value in a to OPT_TEXT_SPEED_* value in c,
; with previous/next TEXT_DELAY_* values in d/e
	ld a, [wOptions]
	and TEXT_DELAY_MASK
	cp TEXT_DELAY_FAST
	jr z, .fast
	cp TEXT_DELAY_NONE
	jr z, .none
.none
	ld c, OPT_TEXT_SPEED_NONE
	lb de, TEXT_DELAY_FAST, TEXT_DELAY_FAST
	ret

.fast
	ld c, OPT_TEXT_SPEED_FAST
	lb de, TEXT_DELAY_NONE, TEXT_DELAY_NONE
	ret

Options_BattleScene:
	ld hl, wOptions
	ldh a, [hJoyPressed]
	bit D_LEFT_F, a
	jr nz, .LeftPressed
	bit D_RIGHT_F, a
	jr z, .NonePressed
	bit BATTLE_SCENE, [hl]
	jr nz, .ToggleOn
	jr .ToggleOff

.LeftPressed:
	bit BATTLE_SCENE, [hl]
	jr z, .ToggleOff
	jr .ToggleOn

.NonePressed:
	bit BATTLE_SCENE, [hl]
	jr z, .ToggleOn
	jr .ToggleOff

.ToggleOn:
	res BATTLE_SCENE, [hl]
	ld de, .On
	jr .Display

.ToggleOff:
	set BATTLE_SCENE, [hl]
	ld de, .Off

.Display:
	hlcoord 11, 5
	call PlaceString
	and a
	ret

.On:  db "On @"
.Off: db "Off@"

Options_ExpShare:
	ld hl, wExpShareToggle
	ldh a, [hJoyPressed]
	bit D_LEFT_F, a
	jr nz, .LeftPressed
	bit D_RIGHT_F, a
	jr z, .NonePressed
	bit EXP_SHARE, [hl]
	jr nz, .ToggleOff
	jr .ToggleOn

.LeftPressed:
	bit EXP_SHARE, [hl]
	jr z, .ToggleOn
	jr .ToggleOff

.NonePressed:
	bit EXP_SHARE, [hl]
	jr nz, .ToggleOn

.ToggleOff:
	res EXP_SHARE, [hl]
	ld de, .Off
	jr .Display

.ToggleOn:
	set EXP_SHARE, [hl]
	ld de, .On

.Display:
	hlcoord 11, 9
	call PlaceString
	and a
	ret

.Off: db "Off@"
.On:  db "On @"

Options_HardMode:
	ld hl, wOptions2
	ldh a, [hJoyPressed]
	bit D_LEFT_F, a
	jr nz, .LeftPressed
	bit D_RIGHT_F, a
	jr z, .NonePressed
	bit HARD_MODE, [hl]
	jr nz, .ToggleOff
	jr .ToggleOn

.LeftPressed:
	bit HARD_MODE, [hl]
	jr z, .ToggleOn
	jr .ToggleOff

.NonePressed:
	bit HARD_MODE, [hl]
	jr nz, .ToggleOn

.ToggleOff:
	res HARD_MODE, [hl]
	ld de, .Off
	jr .Display

.ToggleOn:
	set HARD_MODE, [hl]
	ld de, .On

.Display:
	hlcoord 11, 15
	call PlaceString
	and a
	ret

.Off: db "Off@"
.On:  db "On @"

Options_Sound:
	ld hl, wOptions
	ldh a, [hJoyPressed]
	bit D_LEFT_F, a
	jr nz, .LeftPressed
	bit D_RIGHT_F, a
	jr z, .NonePressed
	bit STEREO, [hl]
	jr nz, .SetMono
	jr .SetStereo

.LeftPressed:
	bit STEREO, [hl]
	jr z, .SetStereo
	jr .SetMono

.NonePressed:
	bit STEREO, [hl]
	jr nz, .ToggleStereo
	jr .ToggleMono

.SetMono:
	res STEREO, [hl]
	call RestartMapMusic

.ToggleMono:
	ld de, .Mono
	jr .Display

.SetStereo:
	set STEREO, [hl]
	call RestartMapMusic

.ToggleStereo:
	ld de, .Stereo

.Display:
	hlcoord 11, 7
	call PlaceString
	and a
	ret

.Mono:   db "Mono  @"
.Stereo: db "Stereo@"

Options_MinimalDialogue:
	ld hl, wOptions2
	ldh a, [hJoyPressed]
	bit D_LEFT_F, a
	jr nz, .LeftPressed
	bit D_RIGHT_F, a
	jr z, .NonePressed
	bit MINIMAL_DIALOGUE, [hl]
	jr nz, .ToggleMinimum
	jr .ToggleNormal

.LeftPressed:
	bit MINIMAL_DIALOGUE, [hl]
	jr z, .ToggleNormal
	jr .ToggleMinimum

.NonePressed:
	bit MINIMAL_DIALOGUE, [hl]
	jr nz, .ToggleNormal

.ToggleMinimum:
	res MINIMAL_DIALOGUE, [hl]
	ld de, .Minimum
	jr .Display

.ToggleNormal:
	set MINIMAL_DIALOGUE, [hl]
	ld de, .Normal

.Display:
	hlcoord 11, 11
	call PlaceString
	and a
	ret

.Strings:
; entries correspond to OPT_DIALOGUE_* constants
	dw .Normal
	dw .Minimum

.Normal:   db "Normal @"
.Minimum:  db "Minimal@"

Options_CasualCalls:
 	ld hl, wOptions2
 	ldh a, [hJoyPressed]
 	bit D_LEFT_F, a
 	jr nz, .LeftPressed
 	bit D_RIGHT_F, a
 	jr z, .NonePressed
 	bit CASUAL_CALLS, [hl]
 	jr nz, .ToggleOff
 	jr .ToggleOn
 
 .LeftPressed:
 	bit CASUAL_CALLS, [hl]
 	jr z, .ToggleOn
 	jr .ToggleOff
 
 .NonePressed:
 	bit CASUAL_CALLS, [hl]
 	jr nz, .ToggleOn
 
 .ToggleOff:
 	res CASUAL_CALLS, [hl]
 	ld de, .On
 	jr .Display
 
 .ToggleOn:
 	set CASUAL_CALLS, [hl]
 	ld de, .Off
 
 .Display:
 	hlcoord 11, 13
 	call PlaceString
 	and a
 	ret
 
.On:  db "On @"
.Off: db "Off@"

Options_AutoBicycle:
 	ld hl, wOptions2
 	ldh a, [hJoyPressed]
 	bit D_LEFT_F, a
 	jr nz, .LeftPressed
 	bit D_RIGHT_F, a
 	jr z, .NonePressed
 	bit AUTO_BICYCLE, [hl]
 	jr nz, .ToggleOff
 	jr .ToggleOn
 
 .LeftPressed:
 	bit AUTO_BICYCLE, [hl]
 	jr z, .ToggleOn
 	jr .ToggleOff
 
 .NonePressed:
 	bit AUTO_BICYCLE, [hl]
 	jr nz, .ToggleOn
 
 .ToggleOff:
 	res AUTO_BICYCLE, [hl]
 	ld de, .Off
 	jr .Display
 
 .ToggleOn:
 	set AUTO_BICYCLE, [hl]
 	ld de, .On
 
 .Display:
 	hlcoord 11, 11
 	call PlaceString
 	and a
 	ret

.On:  db "On @"
.Off: db "Off@"

Options_Frame:
	ld hl, wTextboxFrame
	ldh a, [hJoyPressed]
	bit D_LEFT_F, a
	jr nz, .LeftPressed
	bit D_RIGHT_F, a
	jr nz, .RightPressed
	and a
	ret

.RightPressed:
	ld a, [hl]
	inc a
	jr .Save

.LeftPressed:
	ld a, [hl]
	dec a

.Save:
	maskbits NUM_FRAMES
	ld [hl], a
UpdateFrame:
	ld a, [wTextboxFrame]
	hlcoord 16, 15 ; where on the screen the number is drawn
	add "1"
	ld [hl], a
	call LoadFontsExtra
	and a
	ret

Options_NextPrevious:
	ld hl, wCurOptionsPage
	ldh a, [hJoyPressed]
	and A_BUTTON | D_LEFT | D_RIGHT
	jr z, .NonePressed
	bit 0, [hl]
	jr z, .Page2
;.Page1:
	res 0, [hl]
	ld de, StringOptions1
	jr .Display
.Page2:
	set 0, [hl]
	ld de, StringOptions2
.Display:
	push de
	hlcoord 0, 0
	lb bc, 16, 18
	call Textbox
	pop de
	hlcoord 2, 2
	call PlaceString
	call OptionsMenu_LoadOptions
	ld a, $7
	ld [wJumptableIndex], a
.NonePressed:
	and a
	ret

OptionsControl:
	ld hl, wJumptableIndex
	ldh a, [hJoyLast]
	cp D_DOWN
	jr z, .DownPressed
	cp D_UP
	jr z, .UpPressed
	and a
	ret

.DownPressed:
	ld a, [hl] ; load the cursor position to a
	cp NUM_OPTIONS ; maximum number of items in option menu
	jr nz, .Increase
	ld [hl], -1
	; fallthrough
.Increase:
	inc [hl]
	scf
	ret

.UpPressed:
	ld a, [hl]
	and a
	jr nz, .Decrease
	ld [hl], NUM_OPTIONS + 1 ; number of option items + 1
	; fallthrough
.Decrease:
	dec [hl]
	scf
	ret

Options_UpdateCursorPosition:
	hlcoord 1, 1
	ld de, SCREEN_WIDTH
	ld c, SCREEN_HEIGHT - 2
.loop
	ld [hl], " "
	add hl, de
	dec c
	jr nz, .loop
	hlcoord 1, 2
	ld bc, 2 * SCREEN_WIDTH
	ld a, [wJumptableIndex]
	call AddNTimes
	ld [hl], "▶"
	ret

StackJumpTable::
	pop hl
	push de
	ld e, a
	ld d, 0
	add hl, de
	add hl, de
	pop de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl
