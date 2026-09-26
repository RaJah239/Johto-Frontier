DEF NUM_OPTIONS EQU 20
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
	table_width 2, .Labels
	dw .TextSpeed
	dw .BattleScene
	dw .Sound
	dw .RunningShoes
	dw .AutoBicycle
	dw .ScaledExp
	dw .QuickNurse
	dw .FieldActions
	dw .FasterBattles
	dw .TurboA
	dw .TurboB
	dw .ExpShare
	dw .MinimalDialogue
	dw .FastBoot
	dw .HardMode
	dw .Frame
	dw .BagSort
	dw .EncounterRate
	dw .RematchPrompt
	dw .Done
	assert_table_length NUM_OPTIONS

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
.TurboA:          db "Turbo A@"
.TurboB:          db "Turbo B@"
.ExpShare:        db "Exp.Share@"
.MinimalDialogue: db "Dialogue/Text@"
.FastBoot:        db "Booting Options@"
.HardMode:        db "Hard Mode@"
.BagSort:         db "Sorting Order@"
.EncounterRate:   db "Encounter Rate@"
.RematchPrompt:   db "Rematch Prompt@"
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
	table_width 2, .Pointers
	dw Options_TextSpeed
	dw Options_BattleScene
	dw Options_Sound
	dw Options_RunningShoes
	dw Options_AutoBicycle
	dw Options_Scaled_Exp
	dw Options_QuickNurse
	dw Options_FieldActions
	dw Options_FasterBattles
	dw Options_TurboA
	dw Options_TurboB
	dw Options_ExpShare
	dw Options_MinimalDialogue
	dw Options_FastBoot
	dw Options_HardMode
	dw Options_Frame
	dw Options_BagSort
	dw Options_EncounterRate
	dw Options_RematchPrompt
	dw Options_Done
	assert_table_length NUM_OPTIONS

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

Options_TurboA:
	ld hl, wOptions3
	ldh a, [hJoyPressed]
	bit D_LEFT_F, a
	jr nz, .LeftPressed
	bit D_RIGHT_F, a
	jr z, .NonePressed
	bit TURBO_A_BUTTON, [hl]
	jr nz, .ToggleOff
	jr .ToggleOn

.LeftPressed:
	bit TURBO_A_BUTTON, [hl]
	jr z, .ToggleOn
	jr .ToggleOff

.NonePressed:
	bit TURBO_A_BUTTON, [hl]
	jr nz, .ToggleOn

.ToggleOff:
	res TURBO_A_BUTTON, [hl]
	ld de, .Off
	jr .Display

.ToggleOn:
	set TURBO_A_BUTTON, [hl]
	ld de, .On

.Display:
	call OptionsMenu_PlaceValue
	call PlaceString
	and a
	ret

.Off: db "Off@"
.On:  db "On @"

Options_TurboB:
	ld hl, wOptions3
	ldh a, [hJoyPressed]
	bit D_LEFT_F, a
	jr nz, .LeftPressed
	bit D_RIGHT_F, a
	jr z, .NonePressed
	bit TURBO_B_BUTTON, [hl]
	jr nz, .ToggleOff
	jr .ToggleOn

.LeftPressed:
	bit TURBO_B_BUTTON, [hl]
	jr z, .ToggleOn
	jr .ToggleOff

.NonePressed:
	bit TURBO_B_BUTTON, [hl]
	jr nz, .ToggleOn

.ToggleOff:
	res TURBO_B_BUTTON, [hl]
	ld de, .Off
	jr .Display

.ToggleOn:
	set TURBO_B_BUTTON, [hl]
	ld de, .On

.Display:
	call OptionsMenu_PlaceValue
	call PlaceString
	and a
	ret

.Off: db "Off@"
.On:  db "On @"

Options_Sound:
	ldh a, [hJoyPressed]
	bit D_RIGHT_F, a
	jr nz, .RightPressed
	bit D_LEFT_F, a
	jr nz, .LeftPressed
	jr .NonePressed

.RightPressed:
; Mono -> Stereo -> No -> Mono
	ld a, [wOptions3]
	bit NO_MUSIC, a
	jr nz, .SetMono
	ld a, [wOptions]
	bit STEREO, a
	jr nz, .SetNoMusic
	jr .SetStereo

.LeftPressed:
; Mono -> No -> Stereo -> Mono
	ld a, [wOptions3]
	bit NO_MUSIC, a
	jr nz, .SetStereo
	ld a, [wOptions]
	bit STEREO, a
	jr nz, .SetMono
	jr .SetNoMusic

.NonePressed:
; No direction pressed: just show whatever is currently selected.
	ld a, [wOptions3]
	bit NO_MUSIC, a
	jr nz, .ShowNoMusic
	ld a, [wOptions]
	bit STEREO, a
	jr nz, .ShowStereo
.ShowMono:
	ld de, .Mono
	jr .Display

.ShowStereo:
	ld de, .Stereo
	jr .Display

.ShowNoMusic:
	ld de, .No
	jr .Display

.SetMono:
	ld a, [wOptions]
	res STEREO, a
	ld [wOptions], a
	ld a, [wOptions3]
	res NO_MUSIC, a
	ld [wOptions3], a
	jr .Restart

.SetStereo:
	ld a, [wOptions]
	set STEREO, a
	ld [wOptions], a
	ld a, [wOptions3]
	res NO_MUSIC, a
	ld [wOptions3], a
	jr .Restart

.SetNoMusic:
	ld a, [wOptions3]
	set NO_MUSIC, a
	ld [wOptions3], a
; Restarting with the flag set stops the current track, and the gate
; in _PlayMusic keeps everything after it silent.
.Restart:
	call RestartMapMusic
	jr .NonePressed

.Display:
	call OptionsMenu_PlaceValue
	call PlaceString
	and a
	ret

.Mono:   db "Mono  @"
.Stereo: db "Stereo@"
.No:     db "No    @"

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
; Three modes packed across two bytes: SCALED_EXP (wOptions2) is the
; low bit and ZERO_EXP_F (wTextboxFlags) the high one, so 0 = Normal,
; 1 = Scaled, 2 = Zero. SCALED_EXP stays where it was so a save that
; was already on Scaled still reads as Scaled. Both bits set cannot
; come from the menu; .Strings has a fourth entry so the index stays
; in bounds, and it shows Zero, which is what the battle code does
; with that value too.
	call .GetCurrent
	ldh a, [hJoyPressed]
	bit D_RIGHT_F, a
	jr nz, .RightPressed
	bit D_LEFT_F, a
	jr z, .ShowCurrent
; Left: Normal -> Zero -> Scaled -> Normal
	ld a, c
	and a
	jr nz, .Decrease
	ld a, 2
	jr .Save
.Decrease:
	dec a
	jr .Save
.RightPressed:
; Right: Normal -> Scaled -> Zero -> Normal
	ld a, c
	cp 2
	jr c, .Increase
	xor a
	jr .Save
.Increase:
	inc a
.Save:
	ld c, a
; low bit -> wOptions2 SCALED_EXP
	ld a, [wOptions2]
	res SCALED_EXP, a
	ld b, a
	ld a, c
	and 1
	jr z, .ScaledOff
	set SCALED_EXP, b
.ScaledOff:
	ld a, b
	ld [wOptions2], a
; high bit -> wTextboxFlags ZERO_EXP_F
	ld a, [wTextboxFlags]
	res ZERO_EXP_F, a
	ld b, a
	ld a, c
	and 2
	jr z, .ZeroOff
	set ZERO_EXP_F, b
.ZeroOff:
	ld a, b
	ld [wTextboxFlags], a

.ShowCurrent:
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

; c = the current mode, 0-3, built from the two bits.
.GetCurrent:
	ld c, 0
	ld a, [wOptions2]
	bit SCALED_EXP, a
	jr z, .ReadZero
	inc c
.ReadZero:
	ld a, [wTextboxFlags]
	bit ZERO_EXP_F, a
	jr z, .GotCurrent
	inc c
	inc c
.GotCurrent:
	ret

.Strings:
	table_width 2, .Strings
	dw .Normal
	dw .Scaled
	dw .Zero
	dw .Zero
	assert_table_length 4

.Normal: db "Normal@"
.Scaled: db "Scaled@"
.Zero:   db "Zero  @"

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
; Three boot targets packed across two bytes. FAST_BOOT (wOptions2)
; is the low bit and MAIN_MENU_BOOT_F (wTextboxFlags) the high one,
; but the bit values are deliberately not the display order: the old
; FAST_BOOT toggle has always meant "In Game", so it keeps meaning
; exactly that and an existing save does not silently change what it
; does. The stored pair therefore reads 0 = Intro, 1 (high) = Main
; Menu, 2 (low) = In Game, and .Save writes them back the same way.
; Both bits set cannot come from the menu; only other code setting
; FAST_BOOT on top of a saved Main Menu produces it, and low wins
; there too so it still reads In Game.
	call .GetCurrent
	ldh a, [hJoyPressed]
	bit D_RIGHT_F, a
	jr nz, .RightPressed
	bit D_LEFT_F, a
	jr z, .ShowCurrent
; Left: Intro -> In Game -> Main Menu -> Intro
	ld a, c
	and a
	jr nz, .Decrease
	ld a, 2
	jr .Save
.Decrease:
	dec a
	jr .Save
.RightPressed:
; Right: Intro -> Main Menu -> In Game -> Intro
	ld a, c
	cp 2
	jr c, .Increase
	xor a
	jr .Save
.Increase:
	inc a
.Save:
	ld c, a
; high bit: Main Menu
	ld a, [wTextboxFlags]
	res MAIN_MENU_BOOT_F, a
	ld b, a
	ld a, c
	and 1
	jr z, .HighDone
	set MAIN_MENU_BOOT_F, b
.HighDone:
	ld a, b
	ld [wTextboxFlags], a
; low bit: In Game
	ld a, [wOptions2]
	res FAST_BOOT, a
	ld b, a
	ld a, c
	and 2
	jr z, .LowDone
	set FAST_BOOT, b
.LowDone:
	ld a, b
	ld [wOptions2], a
.ShowCurrent:
	ld b, 0
	ld hl, .Strings
	add hl, bc
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
; One column left of the usual value column: "Main Menu" is nine
; characters and column 11 only leaves room for eight before the
; textbox border.
	call OptionsMenu_PlaceValue
	dec hl
	call PlaceString
	and a
	ret

; c = the current boot target, 0-2. FAST_BOOT is tested first so a
; save that only carries the old toggle still reads as In Game.
.GetCurrent:
	ld a, [wOptions2]
	bit FAST_BOOT, a
	ld c, 2
	ret nz
	ld c, 0
	ld a, [wTextboxFlags]
	bit MAIN_MENU_BOOT_F, a
	ret z
	inc c
	ret

.Strings:
	table_width 2, .Strings
	dw .Intro
	dw .MainMenu
	dw .InGame
	dw .InGame
	assert_table_length 4

.Intro:    db "Intro    @"
.MainMenu: db "Main Menu@"
.InGame:   db "In Game  @"

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

Options_BagSort:
; Two orders behind Start's bag sort: usefulness (the hand-curated
; ItemNameOrder list, and the default) to the left, A-Z to the right.
	ld hl, wOptions3
	ldh a, [hJoyPressed]
	bit D_LEFT_F, a
	jr nz, .LeftPressed
	bit D_RIGHT_F, a
	jr z, .ShowCurrent
	set BAG_SORT_ALPHA, [hl]
	jr .ShowCurrent

.LeftPressed:
	res BAG_SORT_ALPHA, [hl]

.ShowCurrent:
	bit BAG_SORT_ALPHA, [hl]
	ld de, .Alpha
	jr nz, .Display
	ld de, .Useful
.Display:
	call OptionsMenu_PlaceValue
	call PlaceString
	and a
	ret

.Useful: db "Useful @"
.Alpha:  db "A-Z    @"

Options_EncounterRate:
; Three rates packed into wOptions3: ENCOUNTER_RATE is the low bit and
; ENCOUNTER_RATE_HI the high one, so 0 = Normal, 1 = Double,
; 2 = Quadruple. Both bits set cannot come from the menu, but .Strings
; has a fourth entry so it stays in bounds regardless.
	ld hl, wOptions3
	ld a, [hl]
	and ((1 << ENCOUNTER_RATE) | (1 << ENCOUNTER_RATE_HI))
; The pair still sits in bits 6-7, so the mask leaves $00/$40/$80/$c0.
; Rotate it down into bits 0-1 first: c has to be a 0/1/2 index, not
; the raw field.
	rlca
	rlca
	ld c, a
	ldh a, [hJoyPressed]
	bit D_RIGHT_F, a
	jr nz, .RightPressed
	bit D_LEFT_F, a
	jr z, .ShowCurrent
; Left: Normal -> Quadruple -> Double -> Normal
	ld a, c
	and a
	jr nz, .Decrease
	ld a, 2
	jr .Save
.Decrease:
	dec a
	jr .Save
.RightPressed:
; Right: Normal -> Double -> Quadruple -> Normal
	ld a, c
	cp 2
	jr c, .Increase
	xor a
	jr .Save
.Increase:
	inc a
.Save:
	ld c, a
	ld a, c
	and 1
	jr z, .ClearDouble
	set ENCOUNTER_RATE, [hl]
	jr .CheckQuadruple
.ClearDouble:
	res ENCOUNTER_RATE, [hl]
.CheckQuadruple:
	ld a, c
	and 2
	jr z, .ClearQuadruple
	set ENCOUNTER_RATE_HI, [hl]
	jr .ShowCurrent
.ClearQuadruple:
	res ENCOUNTER_RATE_HI, [hl]
.ShowCurrent:
	ld a, [hl]
	and ((1 << ENCOUNTER_RATE) | (1 << ENCOUNTER_RATE_HI))
	rlca
	rlca
	ld c, a
	ld b, 0
	ld hl, .Strings
	add hl, bc
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
; One column left of the usual value column: "Quadruple" is nine
; characters and column 11 only leaves room for eight before the
; textbox border.
	call OptionsMenu_PlaceValue
	dec hl
	call PlaceString
	and a
	ret

.Strings:
; The field is two bits wide, so the index can only ever be 0-3 and
; this table must have exactly four entries.
	table_width 2, .Strings
	dw .Normal
	dw .Double
	dw .Quadruple
	dw .Quadruple
	assert_table_length 4

.Normal:    db "Normal   @"
.Double:    db "Double   @"
.Quadruple: db "Quadruple@"

Options_RematchPrompt:
; Which answer the rematch question lists first, stored in wTextboxFlags
; REMATCH_NOYES_F. RematchScript reads the bit and runs either the
; yesorno or the nooryes script command, so the value shown here is the
; order the player actually sees.
	ld hl, wTextboxFlags
	ldh a, [hJoyPressed]
	bit D_LEFT_F, a
	jr nz, .LeftPressed
	bit D_RIGHT_F, a
	jr z, .NonePressed
	bit REMATCH_NOYES_F, [hl]
	jr nz, .ToggleOff
	jr .ToggleOn

.LeftPressed:
	bit REMATCH_NOYES_F, [hl]
	jr z, .ToggleOn
	jr .ToggleOff

.NonePressed:
	bit REMATCH_NOYES_F, [hl]
	jr nz, .ToggleOn

.ToggleOff:
	res REMATCH_NOYES_F, [hl]
	ld de, .YesOrNo
	jr .Display

.ToggleOn:
	set REMATCH_NOYES_F, [hl]
	ld de, .NoOrYes
.Display:
	call OptionsMenu_PlaceValue
	call PlaceString
	and a
	ret

.YesOrNo: db "YesOrNo@"
.NoOrYes: db "NoOrYes@"

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
	table_width 2, .Descriptions
	dw .DescTextSpeed
	dw .DescBattleScene
	dw .DescSound
	dw .DescRunningShoes
	dw .DescAutoBicycle
	dw .DescScaledExp
	dw .DescQuickNurse
	dw .DescFieldActions
	dw .DescFasterBattles
	dw .DescTurboA
	dw .DescTurboB
	dw .DescExpShare
	dw .DescMinimalDialogue
	dw .DescFastBoot
	dw .DescHardMode
	dw .DescFrame
	dw .DescBagSort
	dw .DescEncounterRate
	dw .DescRematchPrompt
	dw .DescDone
	assert_table_length NUM_OPTIONS

.DescTextSpeed: db "Adjust your text<LF>speed.@"
.DescBattleScene: db "Turn On or Off<LF>Battle Animations.@"
.DescSound: db "Play music in<LF>Mono, Stereo or Off.@"
.DescRunningShoes: db "Set default to<LF>walk or run.@"
.DescAutoBicycle: db "Get on the Bicycle<LF>outdoors.@"
.DescScaledExp: db "Normal, Scaled or<LF>Zero experience.@"
.DescQuickNurse: db "#mon Center<LF>fast or slow heal.@"
.DescFieldActions: db "Normal or Fast<LF>Field Actions.@"
.DescFasterBattles: db "Reduce the text<LF>in battles.@"
.DescTurboA: db "Hold 'A' briefly<LF>to turbo press A.@"
.DescTurboB: db "Hold 'B' briefly<LF>to turbo press B.@"
.DescExpShare: db "Share Experience<LF>with the party.@"
.DescMinimalDialogue: db "Reduce all NPC<LF>text or not.@"
.DescFastBoot: db "Intro, Main Menu,<LF>or In Game.@"
.DescHardMode: db "Choose your mode<LF>to play in.@"
.DescFrame: db "Select your border<LF>of textboxes.@"
.DescBagSort: db "Sort the bag by<LF>Usefulness or A-Z.@"
.DescEncounterRate: db "Wild encounters at<LF>1x, 2x or 4x rate.@"
.DescRematchPrompt: db "Which comes first:<LF>'Yes' or 'No'.@"
.DescDone: db "Save and Exit<LF>@"
