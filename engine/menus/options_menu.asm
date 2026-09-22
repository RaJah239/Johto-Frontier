DEF NUM_OPTIONS EQU 15
DEF OPTIONS_VISIBLE_ROWS EQU 6
DEF DESCRIPTION_BOX_Y EQU SCREEN_HEIGHT - 4
DEF DESCRIPTION_TEXT_Y EQU DESCRIPTION_BOX_Y + 1

_Option:
	call ClearJoypad
	ld hl, hInMenu
	ld a, [hl]
	push af
	ld [hl], TRUE
	call ClearBGPalettes
	xor a
	ld [wOptionsScrollOffset], a
	ld [wJumptableIndex], a
	call OptionsMenu_Redraw
	call WaitBGMap
	ld b, SCGB_DIPLOMA
	call GetSGBLayout
	call SetDefaultBGPAndOBP

.joypad_loop
	xor a
	ldh [hBGMapMode], a
	call JoyTextDelay
	ldh a, [hJoyPressed]
	and START | B_BUTTON
	jr nz, .ExitOptions
	call OptionsControl
	jr c, .dpad
	call GetOptionPointer
	jr c, .ExitOptions
	jr .wait

.dpad
	and a
	jr z, .move_cursor
	call OptionsMenu_Redraw
	jr .wait

.move_cursor
	call Options_UpdateCursorPosition
.wait
	ld a, 1
	ldh [hBGMapMode], a
	ld c, 3
	call DelayFrames
	jr .joypad_loop

.ExitOptions:
	ld de, SFX_TRANSACTION
	call PlaySFX
	call DelayFrame
	pop af
	ldh [hInMenu], a
	ret

OptionsMenu_Redraw:
	xor a
	ldh [hBGMapMode], a
	hlcoord 0, 0
	lb bc, SCREEN_HEIGHT - 2, SCREEN_WIDTH - 2
	call Textbox
	call OptionsMenu_DrawLabels
	call OptionsMenu_LoadOptions
	call Options_UpdateCursorPosition
	ld a, 1
	ldh [hBGMapMode], a
	ret

OptionsMenu_DrawLabels:
	hlcoord 2, 2
	ld a, [wOptionsScrollOffset]
	ld b, a
	ld c, OPTIONS_VISIBLE_ROWS
.loop
	push bc
	push hl
	ld a, b
	ld hl, .Labels
	ld bc, 2
	call AddNTimes
	ld e, [hl]
	inc hl
	ld d, [hl]
	pop hl
	call PlaceString
	pop bc
	ld de, 2 * SCREEN_WIDTH
	add hl, de
	inc b
	dec c
	jr nz, .loop
	ret

.Labels:
	dw .TextSpeed
	dw .BattleScene
	dw .Sound
	dw .RunningShoes
	dw .AutoBicycle
	dw .ScaledExp
	dw .QuickNurse
	dw .FieldActions
	dw .FasterBattles
	dw .ExpShare
	dw .MinimalDialogue
	dw .FastBoot
	dw .HardMode
	dw .Frame
	dw .Done

.TextSpeed:       db "Text Speed@"
.BattleScene:     db "Battle Scene@"
.Sound:           db "Audio Mode@"
.RunningShoes:    db "Running Shoes@"
.AutoBicycle:     db "Auto Bicycle@"
.ScaledExp:       db "Experience Gain@"
.Frame:           db "Frame   :Type@"
.QuickNurse:      db "#mon Center@"
.FieldActions:    db "Field Actions@"
.FasterBattles:   db "Battles@"
.ExpShare:        db "Exp.Share@"
.MinimalDialogue: db "Dialogue/Text@"
.FastBoot:        db "Fast Boot@"
.HardMode:        db "Hard Mode@"
.Done:            db "Done@"

OptionsMenu_LoadOptions:
	ld a, [wJumptableIndex]
	push af
	ld a, [wOptionsScrollOffset]
	ld [wJumptableIndex], a
	xor a
	ldh [hJoyPressed], a
	ld c, OPTIONS_VISIBLE_ROWS
.print_text_loop
	push bc
	xor a
	ldh [hJoyLast], a
	call GetOptionPointer
	pop bc
	ld hl, wJumptableIndex
	inc [hl]
	dec c
	jr nz, .print_text_loop
	pop af
	ld [wJumptableIndex], a
	ret

GetOptionPointer:
	ld a, [wJumptableIndex]
	call StackJumpTable

.Pointers:
	dw Options_TextSpeed
	dw Options_BattleScene
	dw Options_Sound
	dw Options_RunningShoes
	dw Options_AutoBicycle
	dw Options_Scaled_Exp
	dw Options_QuickNurse
	dw Options_FieldActions
	dw Options_FasterBattles
	dw Options_ExpShare
	dw Options_MinimalDialogue
	dw Options_FastBoot
	dw Options_HardMode
	dw Options_Frame
	dw Options_Done

	const_def
	const OPT_TEXT_SPEED_FAST ; 1
	const OPT_TEXT_SPEED_NONE ; 2

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
	call OptionsMenu_PlaceValue
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
	call OptionsMenu_PlaceValue
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
	call OptionsMenu_PlaceValue
	call PlaceString
	and a
	ret

.Off: db "Off@"
.On:  db "On @"

Options_RunningShoes:
	ld hl, wOptions2
	ldh a, [hJoyPressed]
	bit D_LEFT_F, a
	jr nz, .LeftPressed
	bit D_RIGHT_F, a
	jr z, .NonePressed
	bit RUNNING_SHOES, [hl]
	jr nz, .ToggleOff
	jr .ToggleOn

.LeftPressed:
	bit RUNNING_SHOES, [hl]
	jr z, .ToggleOn
	jr .ToggleOff

.NonePressed:
	bit RUNNING_SHOES, [hl]
	jr nz, .ToggleOn

.ToggleOff:
	res RUNNING_SHOES, [hl]
	ld de, .Off
	jr .Display

.ToggleOn:
	set RUNNING_SHOES, [hl]
	ld de, .On
.Display:
	call OptionsMenu_PlaceValue
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
	call OptionsMenu_PlaceValue
	call PlaceString
	and a
	ret

.Off: db "Off@"
.On:  db "On @"

Options_FasterBattles:
 	ld hl, wOptions3
 	ldh a, [hJoyPressed]
 	bit D_LEFT_F, a
 	jr nz, .LeftPressed
 	bit D_RIGHT_F, a
 	jr z, .NonePressed
 	bit FAST_BATTLES, [hl]
 	jr nz, .ToggleOff
 	jr .ToggleOn
 
.LeftPressed:
 	bit FAST_BATTLES, [hl]
 	jr z, .ToggleOn
 	jr .ToggleOff
 
.NonePressed:
 	bit FAST_BATTLES, [hl]
 	jr nz, .ToggleOn
 .ToggleOff:
 	res FAST_BATTLES, [hl]
 	ld de, .Off
 	jr .Display
 
.ToggleOn:
 	set FAST_BATTLES, [hl]
 	ld de, .On
 
.Display:
	call OptionsMenu_PlaceValue
	call PlaceString
	and a
	ret

.On:  db "Quick @"
.Off: db "Normal@"

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
	call OptionsMenu_PlaceValue
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
	call OptionsMenu_PlaceValue
	call PlaceString
	and a
	ret

.Strings:
; entries correspond to OPT_DIALOGUE_* constants
	dw .Normal
	dw .Minimum

.Normal:   db "Normal @"
.Minimum:  db "Minimal@"

Options_Scaled_Exp:
 	ld hl, wOptions2
 	ldh a, [hJoyPressed]
 	bit D_LEFT_F, a
 	jr nz, .LeftPressed
 	bit D_RIGHT_F, a
 	jr z, .NonePressed
 	bit SCALED_EXP, [hl]
 	jr nz, .ToggleOff
 	jr .ToggleOn
 
 .LeftPressed:
 	bit SCALED_EXP, [hl]
 	jr z, .ToggleOn
 	jr .ToggleOff
 
 .NonePressed:
 	bit SCALED_EXP, [hl]
 	jr nz, .ToggleOn
 
 .ToggleOff:
 	res SCALED_EXP, [hl]
 	ld de, .Normal
 	jr .Display
 
 .ToggleOn:
 	set SCALED_EXP, [hl]
 	ld de, .Scaled
 
 .Display:
	call OptionsMenu_PlaceValue
	call PlaceString
 	and a
 	ret
 
.Scaled:  db "Scaled@"
.Normal:  db "Normal@"

Options_QuickNurse:
 	ld hl, wOptions2
 	ldh a, [hJoyPressed]
 	bit D_LEFT_F, a
 	jr nz, .LeftPressed
 	bit D_RIGHT_F, a
 	jr z, .NonePressed
 	bit NURSE_HEAL, [hl]
 	jr nz, .ToggleOff
 	jr .ToggleOn
 
 .LeftPressed:
 	bit NURSE_HEAL, [hl]
 	jr z, .ToggleOn
 	jr .ToggleOff
 
 .NonePressed:
 	bit NURSE_HEAL, [hl]
 	jr nz, .ToggleOn
 
 .ToggleOff:
 	res NURSE_HEAL, [hl]
 	ld de, .Off
 	jr .Display
 
 .ToggleOn:
 	set NURSE_HEAL, [hl]
 	ld de, .On
 .Display:
	call OptionsMenu_PlaceValue
	call PlaceString
	and a
	ret

.On:  db "Quick @"
.Off: db "Normal@"

Options_FastBoot:
 	ld hl, wOptions2
 	ldh a, [hJoyPressed]
 	bit D_LEFT_F, a
 	jr nz, .LeftPressed
 	bit D_RIGHT_F, a
 	jr z, .NonePressed
 	bit FAST_BOOT, [hl]
 	jr nz, .ToggleOff
 	jr .ToggleOn
 
 .LeftPressed:
 	bit FAST_BOOT, [hl]
 	jr z, .ToggleOn
 	jr .ToggleOff
 
 .NonePressed:
 	bit FAST_BOOT, [hl]
 	jr nz, .ToggleOn
 
 .ToggleOff:
 	res FAST_BOOT, [hl]
 	ld de, .Off
 	jr .Display
 
 .ToggleOn:
 	set FAST_BOOT, [hl]
 	ld de, .On
  .Display:
	call OptionsMenu_PlaceValue
	call PlaceString
 	and a
 	ret

.On:  db "On @"
.Off: db "Off@"

Options_FieldActions:
 	ld hl, wOptions3
 	ldh a, [hJoyPressed]
 	bit D_LEFT_F, a
 	jr nz, .LeftPressed
 	bit D_RIGHT_F, a
 	jr z, .NonePressed
 	bit FIELD_ACTIONS, [hl]
 	jr nz, .ToggleOff
 	jr .ToggleOn
 
 .LeftPressed:
 	bit FIELD_ACTIONS, [hl]
 	jr z, .ToggleOn
 	jr .ToggleOff
 
 .NonePressed:
 	bit FIELD_ACTIONS, [hl]
 	jr nz, .ToggleOn
 
 .ToggleOff:
 	res FIELD_ACTIONS, [hl]
 	ld de, .Normal
 	jr .Display
 
 .ToggleOn:
 	set FIELD_ACTIONS, [hl]
 	ld de, .Quick
  .Display:
	call OptionsMenu_PlaceValue
	call PlaceString
 	and a
 	ret

.Quick:  db "Quick @"
.Normal: db "Normal@"

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
	call OptionsMenu_PlaceValue
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
	jr UpdateFrame

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
; Place the digit on the label's own line (next to "Frame"), not on
; the value line below it: +5 columns reaches col 16, -1 row goes
; from the value row to the label row.
	call OptionsMenu_PlaceValue
	ld bc, 5 - SCREEN_WIDTH
	add hl, bc
	ld a, [wTextboxFrame]
	add "1"
	ld [hl], a
	call LoadFontsExtra
	and a
	ret

Options_Done:
	ldh a, [hJoyPressed]
	and A_BUTTON
	jr nz, .exit
; No value to show; blank the value column so stale text
; from the previous screen doesn't linger
	call OptionsMenu_PlaceValue
	ld de, .Blank
	call PlaceString
	and a
	ret

.exit
	scf
	ret

.Blank: db "       @"

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
	ld a, [hl]
	cp NUM_OPTIONS - 1
	jr nz, .Increase
	xor a
	ld [hl], a
	ld [wOptionsScrollOffset], a
	jr .Redraw

.Increase:
	inc [hl]
	ld a, [wOptionsScrollOffset]
	add OPTIONS_VISIBLE_ROWS
	ld b, a
	ld a, [hl]
	cp b
	jr c, .NoRedraw
	ld hl, wOptionsScrollOffset
	inc [hl]
.Redraw:
	ld a, 1
	scf
	ret
.NoRedraw:
	xor a
	scf
	ret

.UpPressed:
	ld a, [hl]
	and a
	jr nz, .Decrease
	ld a, NUM_OPTIONS - 1
	ld [hl], a
	ld a, NUM_OPTIONS - OPTIONS_VISIBLE_ROWS
	ld [wOptionsScrollOffset], a
	jr .Redraw
.Decrease:
	dec [hl]
	ld a, [wOptionsScrollOffset]
	ld b, a
	ld a, [hl]
	cp b
	jr nc, .NoRedraw
	ld hl, wOptionsScrollOffset
	dec [hl]
	jr .Redraw

OptionsMenu_PlaceValue:
	ld a, [wJumptableIndex]
	ld b, a
	ld a, [wOptionsScrollOffset]
	ld c, a
	ld a, b
	sub c
	hlcoord 11, 3
	ld bc, 2 * SCREEN_WIDTH
	jmp AddNTimes

Options_UpdateCursorPosition:
	hlcoord 1, 1
	ld de, SCREEN_WIDTH
; Blank only the option rows (rows 1 to 2 * OPTIONS_VISIBLE_ROWS).
; The rows below hold the description box, which must not be
; erased here.
	ld c, 2 * OPTIONS_VISIBLE_ROWS
.loop
	ld [hl], " "
	add hl, de
	dec c
	jr nz, .loop
	ld a, [wJumptableIndex]
	ld b, a
	ld a, [wOptionsScrollOffset]
	ld c, a
	ld a, b
	sub c
	hlcoord 1, 2
	ld bc, 2 * SCREEN_WIDTH
	call AddNTimes
	ld [hl], "▶"
	; fallthrough

OptionsMenu_DrawDescription:
	hlcoord 0, DESCRIPTION_BOX_Y
	lb bc, 2, SCREEN_WIDTH - 2
	call Textbox
	ld a, [wJumptableIndex]
	ld hl, .Descriptions
	ld bc, 2
	call AddNTimes
	ld e, [hl]
	inc hl
	ld d, [hl]
	hlcoord TEXTBOX_INNERX, DESCRIPTION_TEXT_Y
	jmp PlaceString

.Descriptions:
; One entry per option, in the same order as .Labels and .Pointers.
	dw .DescTextSpeed
	dw .DescBattleScene
	dw .DescSound
	dw .DescRunningShoes
	dw .DescAutoBicycle
	dw .DescScaledExp
	dw .DescQuickNurse
	dw .DescFieldActions
	dw .DescFasterBattles
	dw .DescExpShare
	dw .DescMinimalDialogue
	dw .DescFastBoot
	dw .DescHardMode
	dw .DescFrame
	dw .DescDone

.DescTextSpeed: db "Adjust your text<LF>speed.@"
.DescBattleScene: db "Turn On or Off<LF>Battle Animations.@"
.DescSound: db "Play music in<LF>Mono or Stereo.@"
.DescRunningShoes: db "Set default to<LF>walk or run.@"
.DescAutoBicycle: db "Get on the Bicycle<LF>outdoors.@"
.DescScaledExp: db "Regular or Scaled<LF>Experience.@"
.DescQuickNurse: db "#mon Center<LF>fast or slow heal.@"
.DescFieldActions: db "Normal or Fast<LF>Field Actions.@"
.DescFasterBattles: db "Reduce the text<LF>in battles.@"
.DescExpShare: db "Share Experience<LF>with the party.@"
.DescMinimalDialogue: db "Reduce all NPC<LF>text or not.@"
.DescFastBoot: db "Load your save<LF>file immediately.@"
.DescHardMode: db "Choose your mode<LF>to play in.@"
.DescFrame: db "Select your border<LF>of textboxes.@"
.DescDone: db "Save and Exit<LF>@"
