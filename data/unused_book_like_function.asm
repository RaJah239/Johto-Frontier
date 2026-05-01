TypeChart: ; unreferenced
	ret

;TypeChart:
;	push hl
;	push de
;	push bc
;	xor a
;	ld [wTypeChartInBattle], a
;	call UpdateChartPageText
;	call BugTypeChart
;	call WaitButtonChartInfoBox
;	jmp PopBCDEHL
;
;; ========================
;; Update text for each page
;; ========================
;UpdateChartPageText:
;	hlcoord 4, 17
;	ld a, [wTypeChartInBattle]
;
;	cp 1
;	jr z, .page_2
;	cp 2
;	jr z, .page_3
;	cp 3
;	jr z, .page_4
;	cp 4
;	jr z, .page_5
;	cp 5
;	jr z, .page_6
;	cp 6
;	jr z, .page_7
;	cp 7
;	jmp z, .page_8
;	cp 8
;	jmp z, .page_9
;	cp 9
;	jmp z, .page_10
;	cp 10
;	jmp z, .page_11
;	cp 11
;	jmp z, .page_12
;	cp 12
;	jmp z, .page_13
;	cp 13
;	jmp z, .page_14
;	cp 14
;	jmp z, .page_15
;	cp 15
;	jmp z, .page_16
;	cp 16
;	jmp z, .page_17
;	cp 17
;	jmp z, .page_18
;; Default: page 1
;	ld de, TypeChartMainText.page1
;	call PlaceString
;	ld de, TypeChartMainText.page1_content
;	jmp .done
;
;.page_2
;	ld de, TypeChartMainText.page2
;	call PlaceString
;	ld de, TypeChartMainText.page2_content
;	jmp .done
;
;.page_3
;	ld de, TypeChartMainText.page3
;	call PlaceString
;	ld de, TypeChartMainText.page3_content
;	jmp .done
;
;.page_4
;	ld de, TypeChartMainText.page4
;	call PlaceString
;	ld de, TypeChartMainText.page4_content
;	jmp .done
;
;.page_5
;	ld de, TypeChartMainText.page5
;	call PlaceString
;	ld de, TypeChartMainText.page5_content
;	jmp .done
;
;.page_6
;	ld de, TypeChartMainText.page6
;	call PlaceString
;	ld de, TypeChartMainText.page6_content
;	jmp .done
;
;.page_7
;	ld de, TypeChartMainText.page7
;	call PlaceString
;	ld de, TypeChartMainText.page7_content
;	jr .done
;
;.page_8
;	ld de, TypeChartMainText.page8
;	call PlaceString
;	ld de, TypeChartMainText.page8_content
;	jr .done
;
;.page_9
;	ld de, TypeChartMainText.page9
;	call PlaceString
;	ld de, TypeChartMainText.page9_content
;	jr .done
;
;.page_10
;	ld de, TypeChartMainText.page10
;	call PlaceString
;	ld de, TypeChartMainText.page10_content
;	jr .done
;
;.page_11
;	ld de, TypeChartMainText.page11
;	call PlaceString
;	ld de, TypeChartMainText.page11_content
;	jr .done
;
;.page_12
;	ld de, TypeChartMainText.page12
;	call PlaceString
;	ld de, TypeChartMainText.page12_content
;	jr .done
;
;.page_13
;	ld de, TypeChartMainText.page13
;	call PlaceString
;	ld de, TypeChartMainText.page13_content
;	jr .done
;
;.page_14
;	ld de, TypeChartMainText.page14
;	call PlaceString
;	ld de, TypeChartMainText.page14_content
;	jr .done
;
;.page_15
;	ld de, TypeChartMainText.page15
;	call PlaceString
;	ld de, TypeChartMainText.page15_content
;	jr .done
;
;.page_16
;	ld de, TypeChartMainText.page16
;	call PlaceString
;	ld de, TypeChartMainText.page16_content
;	jr .done
;
;.page_17
;	ld de, TypeChartMainText.page17
;	call PlaceString
;	ld de, TypeChartMainText.page17_content
;	jr .done
;
;.page_18
;	ld de, TypeChartMainText.page18
;	call PlaceString
;	ld de, TypeChartMainText.page18_content
;.done
;	hlcoord 4, 16
;	jmp PlaceString
;
;TypeChartMainText:
;.page1:
;	db "◀ Page 01/18 ▶@"
;.page1_content:
;	db "   Bug Type   @"
;
;.page2:
;	db "◀ Page 02/18 ▶@"
;.page2_content:
;	db "  Dark Type   @"
;
;.page3:
;	db "◀ Page 03/18 ▶@"
;.page3_content:
;	db "  Dragon Type @"
;
;.page4:
;	db "◀ Page 04/18 ▶@"
;.page4_content:
;	db " Electric Type@"
;
;.page5:
;	db "◀ Page 05/18 ▶@"
;.page5_content:
;	db "  Fairy Type  @"
;
;.page6:
;	db "◀ Page 06/18 ▶@"
;.page6_content:
;	db " Fighting Type@"
;
;.page7:
;	db "◀ Page 07/18 ▶@"
;.page7_content:
;	db "  Fire Type   @"
;
;.page8:
;	db "◀ Page 08/18 ▶@"
;.page8_content:
;	db "  Flying Type @"
;
;.page9:
;	db "◀ Page 09/18 ▶@"
;.page9_content:
;	db "  Ghost Type  @"
;
;.page10:
;	db "◀ Page 10/18 ▶@"
;.page10_content:
;	db "  Grass Type  @"
;
;.page11:
;	db "◀ Page 11/18 ▶@"
;.page11_content:
;	db "  Ground Type @"
;
;.page12:
;	db "◀ Page 12/18 ▶@"
;.page12_content:
;	db "   Ice Type   @"
;
;.page13:
;	db "◀ Page 13/18 ▶@"
;.page13_content:
;	db "  Normal Type @"
;
;.page14:
;	db "◀ Page 14/18 ▶@"
;.page14_content:
;	db "  Poison Type @"
;
;.page15:
;	db "◀ Page 15/18 ▶@"
;.page15_content:
;	db " Psychic Type @"
;
;.page16:
;	db "◀ Page 16/18 ▶@"
;.page16_content:
;	db "  Rock Type   @"
;
;.page17:
;	db "◀ Page 17/18 ▶@"
;.page17_content:
;	db "  Steel Type  @"
;
;.page18:
;	db "◀ Page 18/18 ▶@"
;.page18_content:
;	db "  Water Type  @"
;
;WaitButtonChartInfoBox:
;	ldh a, [hOAMUpdate]
;	push af
;	ld a, 1
;	ldh [hOAMUpdate], a
;	call WaitBGMap
;	call JoyWaitAorBorDPADChartInfo
;	pop af
;	ldh [hOAMUpdate], a
;	ret
;
;JoyWaitAorBorDPADChartInfo:
;.loop
;    call DelayFrame
;    call GetJoypad
;
;    ; A / B = exit
;    ldh a, [hJoyPressed]
;    and A_BUTTON | B_BUTTON
;    ret nz
;
;    ; single presses on left and right to switch pages
;	ldh a, [hJoyPressed]
;	and D_RIGHT
;	call nz, ChartBoxRightPress
;	ldh a, [hJoyPressed]
;	and D_LEFT
;	call nz, ChartBoxLeftPress
;
;    ; if up/down is not held, reset delay
;    ldh a, [hJoyDown]
;    and D_UP | D_DOWN
;    jr z, .reset_delay
;
;    ; countdown delay
;    ld hl, wChartScrollDelay
;    ld a, [hl]
;    and a
;    jr z, .check_dirs
;    dec [hl]
;    jr .after_dirs
;
;.check_dirs
;    ; reset delay (this is in terms of fps)
;    ld a, 5          ; switch pages every 5 frames
;    ld [hl], a
;
;    ; UP -> go right
;    ldh a, [hJoyDown]
;    bit D_UP_F, a
;    call nz, ChartBoxRightPress
;
;    ; DOWN -> go left
;    ldh a, [hJoyDown]
;    bit D_DOWN_F, a
;    call nz, ChartBoxLeftPress
;
;.after_dirs
;    call UpdateTimeAndPals
;    jr .loop
;
;.reset_delay
;    xor a
;    ld [wChartScrollDelay], a
;    jr .after_dirs
;
;; ========================
;; Left button navigation
;; ========================
;ChartBoxLeftPress:
;	; play switching pockets SFX	
;	ld de, SFX_SWITCH_POCKETS
;	call PlaySFX
;
;	ld a, [wTypeChartInBattle]
;	and a
;	jr z, .jump_to_page_18
;	cp 1
;	jr z, .jump_to_page_1
;	cp 2
;	jr z, .jump_to_page_2
;	cp 3
;	jr z, .jump_to_page_3
;	cp 4
;	jr z, .jump_to_page_4
;	cp 5
;	jr z, .jump_to_page_5
;	cp 6
;	jr z, .jump_to_page_6
;	cp 7
;	jr z, .jump_to_page_7
;	cp 8
;	jr z, .jump_to_page_8
;	cp 9
;	jr z, .jump_to_page_9
;	cp 10
;	jmp z, .jump_to_page_10
;	cp 11
;	jmp z, .jump_to_page_11
;	cp 12
;	jmp z, .jump_to_page_12
;	cp 13
;	jmp z, .jump_to_page_13
;	cp 14
;	jmp z, .jump_to_page_14
;	cp 15
;	jmp z, .jump_to_page_15
;	cp 16
;	jmp z, .jump_to_page_16
;	cp 17
;	jmp z, .jump_to_page_17
;	cp 18
;	ret nz
;.jump_to_page_18:
;	call DecreaseTypeChartPage
;	call UpdateChartPageText
;	jmp WaterTypeChart
;
;.jump_to_page_1
;	call DecreaseTypeChartPage
;	call UpdateChartPageText
;	jmp BugTypeChart
;
;.jump_to_page_2
;	call DecreaseTypeChartPage
;	call UpdateChartPageText
;	jmp DarkTypeChart
;
;.jump_to_page_3
;	call DecreaseTypeChartPage
;	call UpdateChartPageText
;	jmp DragonTypeChart
;
;.jump_to_page_4
;	call DecreaseTypeChartPage
;	call UpdateChartPageText
;	jmp ElectricTypeChart
;
;.jump_to_page_5
;	call DecreaseTypeChartPage
;	call UpdateChartPageText
;	jmp FairyTypeChart
;
;.jump_to_page_6
;	call DecreaseTypeChartPage
;	call UpdateChartPageText
;	jmp FightingTypeChart
;
;.jump_to_page_7
;	call DecreaseTypeChartPage
;	call UpdateChartPageText
;	jmp FireTypeChart
;
;.jump_to_page_8
;	call DecreaseTypeChartPage
;	call UpdateChartPageText
;	jmp FlyingTypeChart
;
;.jump_to_page_9
;	call DecreaseTypeChartPage
;	call UpdateChartPageText
;	jmp GhostTypeChart
;
;.jump_to_page_10
;	call DecreaseTypeChartPage
;	call UpdateChartPageText
;	jmp GrassTypeChart
;
;.jump_to_page_11
;	call DecreaseTypeChartPage
;	call UpdateChartPageText
;	jmp GroundTypeChart
;
;.jump_to_page_12
;	call DecreaseTypeChartPage
;	call UpdateChartPageText
;	jmp IceTypeChart
;
;.jump_to_page_13
;	call DecreaseTypeChartPage
;	call UpdateChartPageText
;	jmp NormalTypeChart
;
;.jump_to_page_14
;	call DecreaseTypeChartPage
;	call UpdateChartPageText
;	jmp PoisonTypeChart
;
;.jump_to_page_15
;	call DecreaseTypeChartPage
;	call UpdateChartPageText
;	jmp PsychicTypeChart
;
;.jump_to_page_16
;	call DecreaseTypeChartPage
;	call UpdateChartPageText
;	jmp RockTypeChart
;
;.jump_to_page_17
;	call DecreaseTypeChartPage
;	call UpdateChartPageText
;	jmp SteelTypeChart
;
;; ========================
;; Right button navigation
;; ========================
;ChartBoxRightPress:
;	; play switching pockets SFX	
;	ld de, SFX_SWITCH_POCKETS
;	call PlaySFX
;
;	ld a, [wTypeChartInBattle]
;	and a
;	jr z, .jump_to_page_2
;	cp 1
;	jr z, .jump_to_page_3
;	cp 2
;	jr z, .jump_to_page_4
;	cp 3
;	jr z, .jump_to_page_5
;	cp 4
;	jr z, .jump_to_page_6
;	cp 5
;	jr z, .jump_to_page_7
;	cp 6
;	jr z, .jump_to_page_8
;	cp 7
;	jr z, .jump_to_page_9
;	cp 8
;	jr z, .jump_to_page_10
;	cp 9
;	jmp z, .jump_to_page_11
;	cp 10
;	jmp z, .jump_to_page_12
;	cp 11
;	jmp z, .jump_to_page_13
;	cp 12
;	jmp z, .jump_to_page_14
;	cp 13
;	jmp z, .jump_to_page_15
;	cp 14
;	jmp z, .jump_to_page_16
;	cp 15
;	jmp z, .jump_to_page_17
;	cp 16
;	jmp z, .jump_to_page_18
;	cp 17
;	ret nz
;.jump_to_page_1:
;	call IncreaseTypeChartPage
;	call UpdateChartPageText
;	jmp BugTypeChart
;
;.jump_to_page_2
;	call IncreaseTypeChartPage
;	call UpdateChartPageText
;	jmp DarkTypeChart
;
;.jump_to_page_3
;	call IncreaseTypeChartPage
;	call UpdateChartPageText
;	jmp DragonTypeChart
;
;.jump_to_page_4
;	call IncreaseTypeChartPage
;	call UpdateChartPageText
;	jmp ElectricTypeChart
;
;.jump_to_page_5
;	call IncreaseTypeChartPage
;	call UpdateChartPageText
;	jmp FairyTypeChart
;
;.jump_to_page_6
;	call IncreaseTypeChartPage
;	call UpdateChartPageText
;	jmp FightingTypeChart
;
;.jump_to_page_7
;	call IncreaseTypeChartPage
;	call UpdateChartPageText
;	jmp FireTypeChart
;
;.jump_to_page_8
;	call IncreaseTypeChartPage
;	call UpdateChartPageText
;	jmp FlyingTypeChart
;
;.jump_to_page_9
;	call IncreaseTypeChartPage
;	call UpdateChartPageText
;	jmp GhostTypeChart
;
;.jump_to_page_10
;	call IncreaseTypeChartPage
;	call UpdateChartPageText
;	jmp GrassTypeChart
;
;.jump_to_page_11
;	call IncreaseTypeChartPage
;	call UpdateChartPageText
;	jmp GroundTypeChart
;
;.jump_to_page_12
;	call IncreaseTypeChartPage
;	call UpdateChartPageText
;	jmp IceTypeChart
;
;.jump_to_page_13
;	call IncreaseTypeChartPage
;	call UpdateChartPageText
;	jmp NormalTypeChart
;
;.jump_to_page_14
;	call IncreaseTypeChartPage
;	call UpdateChartPageText
;	jmp PoisonTypeChart
;
;.jump_to_page_15
;	call IncreaseTypeChartPage
;	call UpdateChartPageText
;	jmp PsychicTypeChart
;
;.jump_to_page_16
;	call IncreaseTypeChartPage
;	call UpdateChartPageText
;	jmp RockTypeChart
;
;.jump_to_page_17
;	call IncreaseTypeChartPage
;	call UpdateChartPageText
;	jmp SteelTypeChart
;
;.jump_to_page_18
;	call IncreaseTypeChartPage
;	call UpdateChartPageText
;	jmp WaterTypeChart
;	
;; ========================
;; Page counter functions
;; ========================
;IncreaseTypeChartPage:
;	ld a, [wTypeChartInBattle]
;	inc a
;	cp 18                     ; Pages 0 to 18 (inclusive)
;	jr c, .store
;	xor a                    ; Wrap to page 0
;.store
;	ld [wTypeChartInBattle], a
;	ret
;
;DecreaseTypeChartPage:
;	ld a, [wTypeChartInBattle]
;	or a
;	jr nz, .dec
;	ld a, 18                 ; Wrap to last page
;.dec
;	dec a
;	ld [wTypeChartInBattle], a
;	ret
;
;BugTypeChart:
;	hlcoord 0, 0
;	lb bc, 14, 18
;	call Textbox
;
;	ld de, .TypeString
;	hlcoord 1, 1
;	call PlaceString
;
;	ld de, .AttackerString
;	hlcoord 1, 3
;	call PlaceString
;
;	ld de, .AttackerStringHalfDamage1
;	hlcoord 1, 4
;	call PlaceString
;
;	ld de, .AttackerStringHalfDamage2
;	hlcoord 1, 5
;	call PlaceString
;
;	ld de, .AttackerStringDoubleDamage1
;	hlcoord 1, 6
;	call PlaceString
;
;	ld de, .AttackerStringDoubleDamage2
;	hlcoord 1, 7
;	call PlaceString
;
;	ld de, .DefenderString
;	hlcoord 1, 9
;	call PlaceString
;
;	ld de, .DefenderStringHalfDamage
;	hlcoord 1, 10
;	call PlaceString
;
;	ld de, .DefenderStringDoubleDamage
;	hlcoord 1, 11
;	jmp PlaceString
;
;.TypeString:
;	db "Bug Type@"
;.AttackerString:
;	db "Attacker:@"
;.AttackerStringHalfDamage1:
;	db "<half>× Steel/Poison/@"
;.AttackerStringHalfDamage2:
;	db "   Fly/Fire@"
;.AttackerStringDoubleDamage1:
;	db "2× Grass/Dark/@"
;.AttackerStringDoubleDamage2:
;	db "   Fairy/Psychic@"
;
;.DefenderString:
;	db "Defender:@"
;.DefenderStringHalfDamage:
;	db "<half>× Grass/Ground@"
;.DefenderStringDoubleDamage:
;	db "2× Fire/Rock/Fly@"
;
;DarkTypeChart:
;	hlcoord 0, 0
;	lb bc, 14, 18
;	call Textbox
;
;	ld de, .TypeString
;	hlcoord 1, 1
;	call PlaceString
;
;	ld de, .AttackerString
;	hlcoord 1, 3
;	call PlaceString
;
;	ld de, .AttackerStringHalfDamage1
;	hlcoord 1, 4
;	call PlaceString
;
;	ld de, .AttackerStringHalfDamage2
;	hlcoord 1, 5
;	call PlaceString
;
;	ld de, .AttackerStringDoubleDamage
;	hlcoord 1, 6
;	call PlaceString
;
;	ld de, .DefenderString
;	hlcoord 1, 8
;	call PlaceString
;
;	ld de, .DefenderStringZeroDamage
;	hlcoord 1, 9
;	call PlaceString
;
;	ld de, .DefenderStringHalfDamage
;	hlcoord 1, 10
;	call PlaceString
;
;	ld de, .DefenderStringDoubleDamage
;	hlcoord 1, 11
;	jmp PlaceString
;
;.TypeString:
;	db "Dark Type@"
;.AttackerString:
;	db "Attacker:@"
;.AttackerStringHalfDamage1:
;	db "<half>× Dark/Fairy/@"
;.AttackerStringHalfDamage2:
;	db "   Fight@"
;.AttackerStringDoubleDamage:
;	db "2× Ghost/Psychic@"
;
;.DefenderString:
;	db "Defender:@"
;.DefenderStringZeroDamage:
;	db "0× Psychic@"
;.DefenderStringHalfDamage:
;	db "<half>× Ghost/Dark@"
;.DefenderStringDoubleDamage:
;	db "2× Bug/Fairy/Fight@"
;
;
;DragonTypeChart:
;	hlcoord 0, 0
;	lb bc, 14, 18
;	call Textbox
;
;	ld de, .TypeString
;	hlcoord 1, 1
;	call PlaceString
;
;	ld de, .AttackerString
;	hlcoord 1, 3
;	call PlaceString
;
;	ld de, .AttackerStringZeroDamage
;	hlcoord 1, 4
;	call PlaceString
;
;	ld de, .AttackerStringHalfDamage
;	hlcoord 1, 5
;	call PlaceString
;
;	ld de, .AttackerStringDoubleDamage
;	hlcoord 1, 6
;	call PlaceString
;
;	ld de, .DefenderString
;	hlcoord 1, 8
;	call PlaceString
;
;	ld de, .DefenderStringHalfDamage1
;	hlcoord 1, 9
;	call PlaceString
;
;	ld de, .DefenderStringHalfDamage2
;	hlcoord 1, 10
;	call PlaceString
;
;	ld de, .DefenderStringDoubleDamage1
;	hlcoord 1, 11
;	call PlaceString
;
;	ld de, .DefenderStringDoubleDamage2
;	hlcoord 1, 12
;	jmp PlaceString
;
;.TypeString:
;	db "Dragon Type@"
;.AttackerString:
;	db "Attacker:@"
;.AttackerStringZeroDamage:
;	db "0× Fairy@"
;.AttackerStringHalfDamage:
;	db "<half>× Steel@"
;.AttackerStringDoubleDamage:
;	db "2× Dragon@"
;
;.DefenderString:
;	db "Defender:@"
;.DefenderStringHalfDamage1:
;	db "<half>× Fire/Electric/@"
;.DefenderStringHalfDamage2:
;	db "   Water/Grass@"
;.DefenderStringDoubleDamage1:
;	db "2× Ice/Fiary/@"
;.DefenderStringDoubleDamage2:
;	db "   Dragon@"
;
;ElectricTypeChart:
;	hlcoord 0, 0
;	lb bc, 14, 18
;	call Textbox
;
;	ld de, .TypeString
;	hlcoord 1, 1
;	call PlaceString
;
;	ld de, .AttackerString
;	hlcoord 1, 3
;	call PlaceString
;
;	ld de, .AttackerStringZeroDamage
;	hlcoord 1, 4
;	call PlaceString
;
;	ld de, .AttackerStringHalfDamage1
;	hlcoord 1, 5
;	call PlaceString
;
;	ld de, .AttackerStringHalfDamage2
;	hlcoord 1, 6
;	call PlaceString
;
;	ld de, .AttackerStringDoubleDamage
;	hlcoord 1, 7
;	call PlaceString
;
;	ld de, .DefenderString
;	hlcoord 1, 9
;	call PlaceString
;
;	ld de, .DefenderStringHalfDamage1
;	hlcoord 1, 10
;	call PlaceString
;
;	ld de, .DefenderStringHalfDamage2
;	hlcoord 1, 11
;	call PlaceString
;
;	ld de, .DefenderStringDoubleDamage
;	hlcoord 1, 12
;	jmp PlaceString
;
;.TypeString:
;	db "Electric Type@"
;.AttackerString:
;	db "Attacker:@"
;.AttackerStringHalfDamage1:
;	db "<half>× Grass/Dragon/@"
;.AttackerStringHalfDamage2:
;	db "   Electric@"
;.AttackerStringZeroDamage:
;	db "0× Ground@"
;.AttackerStringDoubleDamage:
;	db "2× Water/Flying@"
;
;.DefenderString:
;	db "Defender:@"
;.DefenderStringHalfDamage1:
;	db "<half>× Flying/Steel/@"
;.DefenderStringHalfDamage2:
;	db "   Electric@"
;.DefenderStringDoubleDamage:
;	db "2× Ground@"
;
;FairyTypeChart:
;	hlcoord 0, 0
;	lb bc, 14, 18
;	call Textbox
;
;	ld de, .TypeString
;	hlcoord 1, 1
;	call PlaceString
;
;	ld de, .AttackerString
;	hlcoord 1, 3
;	call PlaceString
;
;	ld de, .AttackerStringHalfDamage1
;	hlcoord 1, 4
;	call PlaceString
;
;	ld de, .AttackerStringHalfDamage2
;	hlcoord 1, 5
;	call PlaceString
;
;	ld de, .AttackerStringDoubleDamage1
;	hlcoord 1, 6
;	call PlaceString
;
;	ld de, .AttackerStringDoubleDamage2
;	hlcoord 1, 7
;	call PlaceString
;
;	ld de, .DefenderString
;	hlcoord 1, 9
;	call PlaceString
;
;	ld de, .DefenderStringZeroDamage
;	hlcoord 1, 10
;	call PlaceString
;
;	ld de, .DefenderStringHalfDamage
;	hlcoord 1, 11
;	call PlaceString
;
;	ld de, .DefenderStringDoubleDamage1
;	hlcoord 1, 12
;	call PlaceString
;
;	ld de, .DefenderStringDoubleDamage2
;	hlcoord 1, 13
;	call PlaceString
;	jmp PlaceString
;
;.TypeString:
;	db "Fairy Type@"
;.AttackerString:
;	db "Attacker:@"
;.AttackerStringHalfDamage1:
;	db "<half>× Poison/Steel/@"
;.AttackerStringHalfDamage2:
;	db "   Bug@"
;.AttackerStringDoubleDamage1:
;	db "2× Dark/Dragon/@"
;.AttackerStringDoubleDamage2:
;	db "   Fight@"
;
;.DefenderString:
;	db "Defender:@"
;.DefenderStringZeroDamage:
;	db "0× Dragon@"
;.DefenderStringHalfDamage:
;	db "<half>× Fight/Dark@"
;.DefenderStringDoubleDamage1:
;	db "2× Poison/Steel/@"
;.DefenderStringDoubleDamage2:
;	db "   Bug@"
;
;FightingTypeChart:
;	hlcoord 0, 0
;	lb bc, 14, 18
;	call Textbox
;
;	ld de, .TypeString
;	hlcoord 1, 1
;	call PlaceString
;
;	ld de, .AttackerString
;	hlcoord 1, 3
;	call PlaceString
;
;	ld de, .AttackerStringZeroDamage
;	hlcoord 1, 4
;	call PlaceString
;
;	ld de, .AttackerStringHalfDamage1
;	hlcoord 1, 5
;	call PlaceString
;
;	ld de, .AttackerStringHalfDamage2
;	hlcoord 1, 6
;	call PlaceString
;
;	ld de, .AttackerStringDoubleDamage1
;	hlcoord 1, 7
;	call PlaceString
;
;	ld de, .AttackerStringDoubleDamage2
;	hlcoord 1, 8
;	call PlaceString
;
;	ld de, .DefenderString
;	hlcoord 1, 10
;	call PlaceString
;
;	ld de, .DefenderStringHalfDamage
;	hlcoord 1, 11
;	call PlaceString
;
;	ld de, .DefenderStringDoubleDamage1
;	hlcoord 1, 12
;	call PlaceString
;
;	ld de, .DefenderStringDoubleDamage2
;	hlcoord 1, 13
;	jmp PlaceString
;
;.TypeString:
;	db "Fighting Type@"
;.AttackerString:
;	db "Attacker:@"
;.AttackerStringZeroDamage:
;	db "0× Ghost@"
;.AttackerStringHalfDamage1:
;	db "<half>× Poison/Psychic/@"
;.AttackerStringHalfDamage2:
;	db "   Flying/Fairy@"
;.AttackerStringDoubleDamage1:
;	db "2× Ice/Rock/Dark/@"
;.AttackerStringDoubleDamage2:
;	db "   Normal/Steel@"
;
;.DefenderString:
;	db "Defender:@"
;.DefenderStringHalfDamage:
;	db "<half>× Rock/Dark@"
;.DefenderStringDoubleDamage1:
;	db "2× Fly/Psychic/@"
;.DefenderStringDoubleDamage2:
;	db "   Fairy@"
;
;FireTypeChart:
;	hlcoord 0, 0
;	lb bc, 14, 18
;	call Textbox
;
;	ld de, .TypeString
;	hlcoord 1, 1
;	call PlaceString
;
;	ld de, .AttackerString
;	hlcoord 1, 3
;	call PlaceString
;
;	ld de, .AttackerStringHalfDamage1
;	hlcoord 1, 4
;	call PlaceString
;
;	ld de, .AttackerStringHalfDamage2
;	hlcoord 1, 5
;	call PlaceString
;
;	ld de, .AttackerStringDoubleDamage1
;	hlcoord 1, 6
;	call PlaceString
;
;	ld de, .AttackerStringDoubleDamage2
;	hlcoord 1, 7
;	call PlaceString
;
;	ld de, .DefenderString
;	hlcoord 1, 9
;	call PlaceString
;
;	ld de, .DefenderStringHalfDamage1
;	hlcoord 1, 10
;	call PlaceString
;
;	ld de, .DefenderStringHalfDamage2
;	hlcoord 1, 11
;	call PlaceString
;
;	ld de, .DefenderStringDoubleDamage1
;	hlcoord 1, 12
;	call PlaceString
;
;	ld de, .DefenderStringDoubleDamage2
;	hlcoord 1, 13
;	jmp PlaceString
;
;.TypeString:
;	db "Fire Type@"
;.AttackerString:
;	db "Attacker:@"
;.AttackerStringHalfDamage1:
;	db "<half>× Water/Fire/@"
;.AttackerStringHalfDamage2:
;	db "   Dragon/Rock@"
;.AttackerStringDoubleDamage1:
;	db "2× Grass/Ice/Bug/@"
;.AttackerStringDoubleDamage2:
;	db "   Steel@"
;
;.DefenderString:
;	db "Defender:@"
;.DefenderStringHalfDamage1:
;	db "<half>× Grass/Steel/@"
;.DefenderStringHalfDamage2:
;	db "   Fire/Ice/Bug@"
;.DefenderStringDoubleDamage1:
;	db "2× Water/Rock/@"
;.DefenderStringDoubleDamage2:
;	db "   Ground@"
;
;FlyingTypeChart:
;	hlcoord 0, 0
;	lb bc, 14, 18
;	call Textbox
;
;	ld de, .TypeString
;	hlcoord 1, 1
;	call PlaceString
;
;	ld de, .AttackerString
;	hlcoord 1, 3
;	call PlaceString
;
;	ld de, .AttackerStringHalfDamage1
;	hlcoord 1, 4
;	call PlaceString
;
;	ld de, .AttackerStringHalfDamage2
;	hlcoord 1, 5
;	call PlaceString
;
;	ld de, .AttackerStringDoubleDamage1
;	hlcoord 1, 6
;	call PlaceString
;
;	ld de, .AttackerStringDoubleDamage2
;	hlcoord 1, 7
;	call PlaceString
;
;	ld de, .DefenderString
;	hlcoord 1, 9
;	call PlaceString
;
;	ld de, .DefenderStringZeroDamage
;	hlcoord 1, 10
;	call PlaceString
;
;	ld de, .DefenderStringHalfDamage1
;	hlcoord 1, 11
;	call PlaceString
;
;	ld de, .DefenderStringHalfDamage2
;	hlcoord 1, 12
;	call PlaceString
;
;	ld de, .DefenderStringDoubleDamage1
;	hlcoord 1, 13
;	call PlaceString
;
;	ld de, .DefenderStringDoubleDamage2
;	hlcoord 1, 14
;	jmp PlaceString
;
;.TypeString:
;	db "Flying Type@"
;.AttackerString:
;	db "Attacker:@"
;.AttackerStringHalfDamage1:
;	db "<half>× Steel, Rock &@"
;.AttackerStringHalfDamage2:
;	db "   Electric@"
;.AttackerStringDoubleDamage1:
;	db "2× Grass, Bug &@"
;.AttackerStringDoubleDamage2:
;	db "   Fighting@"
;
;.DefenderString:
;	db "Defender:@"
;.DefenderStringZeroDamage:
;	db "0× Ground@"
;.DefenderStringHalfDamage1:
;	db "<half>× Grass, Bug &@"
;.DefenderStringHalfDamage2:
;	db "   Fighting@"
;.DefenderStringDoubleDamage1:
;	db "2× Electric/Ice/@"
;.DefenderStringDoubleDamage2:
;	db "   Rock@"
;
;GhostTypeChart:
;	hlcoord 0, 0
;	lb bc, 14, 18
;	call Textbox
;
;	ld de, .TypeString
;	hlcoord 1, 1
;	call PlaceString
;
;	ld de, .AttackerString
;	hlcoord 1, 3
;	call PlaceString
;
;	ld de, .AttackerStringZeroDamage
;	hlcoord 1, 4
;	call PlaceString
;
;	ld de, .AttackerStringHalfDamage
;	hlcoord 1, 5
;	call PlaceString
;
;	ld de, .AttackerStringDoubleDamage
;	hlcoord 1, 6
;	call PlaceString
;
;	ld de, .DefenderString
;	hlcoord 1, 8
;	call PlaceString
;
;	ld de, .DefenderStringZeroDamage
;	hlcoord 1, 9
;	call PlaceString
;
;	ld de, .DefenderStringHalfDamage
;	hlcoord 1, 10
;	call PlaceString
;
;	ld de, .DefenderStringDoubleDamage
;	hlcoord 1, 11
;	jmp PlaceString
;
;.TypeString:
;	db "Ghost Type@"
;.AttackerString:
;	db "Attacker:@"
;.AttackerStringZeroDamage:
;	db "0× Normal @"
;.AttackerStringHalfDamage:
;	db "<half>× Dark@"
;.AttackerStringDoubleDamage:
;	db "2× Psychic/Ghost@"
;
;.DefenderString:
;	db "Defender:@"
;.DefenderStringZeroDamage:
;	db "0× Normal/Fight@"
;.DefenderStringHalfDamage:
;	db "<half>× Poison/Psychic@"
;.DefenderStringDoubleDamage:
;	db "2× Ghost/Dark@"
;
;GrassTypeChart:
;	hlcoord 0, 0
;	lb bc, 14, 18
;	call Textbox
;
;	ld de, .TypeString
;	hlcoord 1, 1
;	call PlaceString
;
;	ld de, .AttackerString
;	hlcoord 1, 3
;	call PlaceString
;
;	ld de, .AttackerStringHalfDamage1
;	hlcoord 1, 4
;	call PlaceString
;
;	ld de, .AttackerStringHalfDamage2
;	hlcoord 1, 5
;	call PlaceString
;
;	ld de, .AttackerStringHalfDamage3
;	hlcoord 1, 6
;	call PlaceString
;
;	ld de, .AttackerStringDoubleDamage1
;	hlcoord 1, 7
;	call PlaceString
;
;	ld de, .AttackerStringDoubleDamage2
;	hlcoord 1, 8
;	call PlaceString
;
;	ld de, .DefenderString
;	hlcoord 1, 10
;	call PlaceString
;
;	ld de, .DefenderStringHalfDamage1
;	hlcoord 1, 11
;	call PlaceString
;
;	ld de, .DefenderStringHalfDamage2
;	hlcoord 1, 12
;	call PlaceString
;
;	ld de, .DefenderStringDoubleDamage1
;	hlcoord 1, 13
;	call PlaceString
;
;	ld de, .DefenderStringDoubleDamage2
;	hlcoord 1, 14
;	jmp PlaceString
;
;.TypeString:
;	db "Grass Type@"
;.AttackerString:
;	db "Attacker:@"
;.AttackerStringHalfDamage1:
;	db "<half>× Grass/Poison/@"
;.AttackerStringHalfDamage2:
;	db "   Fire/Bug/Fly/@"
;.AttackerStringHalfDamage3:
;	db "   Dragon/Steel@"
;.AttackerStringDoubleDamage1:
;	db "2× Water/Ground/@"
;.AttackerStringDoubleDamage2:
;	db "   Rock@"
;
;.DefenderString:
;	db "Defender:@"
;.DefenderStringHalfDamage1:
;	db "<half>× Water/Electric/@"
;.DefenderStringHalfDamage2:
;	db "   Grass/Ground@"
;.DefenderStringDoubleDamage1:
;	db "2× Flying/Poison/@"
;.DefenderStringDoubleDamage2:
;	db "   Bug/Fire/Ice@"
;
;GroundTypeChart:
;	hlcoord 0, 0
;	lb bc, 14, 18
;	call Textbox
;
;	ld de, .TypeString
;	hlcoord 1, 1
;	call PlaceString
;
;	ld de, .AttackerString
;	hlcoord 1, 3
;	call PlaceString
;
;	ld de, .AttackerStringHalfDamage
;	hlcoord 1, 4
;	call PlaceString
;
;	ld de, .AttackerStringZeroDamage
;	hlcoord 1, 5
;	call PlaceString
;
;	ld de, .AttackerStringDoubleDamage1
;	hlcoord 1, 6
;	call PlaceString
;
;	ld de, .AttackerStringDoubleDamage2
;	hlcoord 1, 7
;	call PlaceString
;
;	ld de, .AttackerStringDoubleDamage3
;	hlcoord 1, 8
;	call PlaceString
;
;	ld de, .DefenderString
;	hlcoord 1, 10
;	call PlaceString
;
;	ld de, .DefenderStringZeroDamage
;	hlcoord 1, 11
;	call PlaceString
;
;	ld de, .DefenderStringHalfDamage
;	hlcoord 1, 12
;	call PlaceString
;
;	ld de, .DefenderStringDoubleDamage
;	hlcoord 1, 13
;	jmp PlaceString
;
;.TypeString:
;	db "Ground Type@"
;.AttackerString:
;	db "Attacker:@"
;.AttackerStringHalfDamage:
;	db "<half>× Grass/Bug@"
;.AttackerStringZeroDamage:
;	db "0× Flying@"
;.AttackerStringDoubleDamage1:
;	db "2× Electric/Steel/@"
;.AttackerStringDoubleDamage2:
;	db "   Poison/Fire/@"
;.AttackerStringDoubleDamage3:
;	db "   Rock@"
;
;.DefenderString:
;	db "Defender:@"
;.DefenderStringZeroDamage:
;	db "0× Electric@"
;.DefenderStringHalfDamage:
;	db "<half>× Poison & Rock@"
;.DefenderStringDoubleDamage:
;	db "2× Water/Grass/Ice@"
;
;IceTypeChart:
;	hlcoord 0, 0
;	lb bc, 14, 18
;	call Textbox
;
;	ld de, .TypeString
;	hlcoord 1, 1
;	call PlaceString
;
;	ld de, .AttackerString
;	hlcoord 1, 3
;	call PlaceString
;
;	ld de, .AttackerStringHalfDamage1
;	hlcoord 1, 4
;	call PlaceString
;
;	ld de, .AttackerStringHalfDamage2
;	hlcoord 1, 5
;	call PlaceString
;
;	ld de, .AttackerStringDoubleDamage1
;	hlcoord 1, 6
;	call PlaceString
;
;	ld de, .AttackerStringDoubleDamage2
;	hlcoord 1, 7
;	call PlaceString
;
;	ld de, .DefenderString
;	hlcoord 1, 9
;	call PlaceString
;
;	ld de, .DefenderStringHalfDamage1
;	hlcoord 1, 10
;	call PlaceString
;
;	ld de, .DefenderStringHalfDamage2
;	hlcoord 1, 11
;	call PlaceString
;
;	ld de, .DefenderStringDoubleDamage1
;	hlcoord 1, 12
;	call PlaceString
;
;	ld de, .DefenderStringDoubleDamage2
;	hlcoord 1, 13
;	jmp PlaceString
;
;.TypeString:
;	db "Ice Type@"
;.AttackerString:
;	db "Attacker:@"
;.AttackerStringHalfDamage1:
;	db "<half>× Fire/Water/Ice@"
;.AttackerStringHalfDamage2:
;	db "   Steel@"
;.AttackerStringDoubleDamage1:
;	db "2× Grass, Ground@"
;.AttackerStringDoubleDamage2:
;	db "   Flying & Dragon@"
;
;.DefenderString:
;	db "Defender:@"
;.DefenderStringHalfDamage1:
;	db "<half>× Ice/Water/@"
;.DefenderStringHalfDamage2:
;	db "   Grass/Electric@"
;.DefenderStringDoubleDamage1:
;	db "2× Fire/Fight/@"
;.DefenderStringDoubleDamage2:
;	db "   Steel/Rock@"
;
;NormalTypeChart:
;	hlcoord 0, 0
;	lb bc, 14, 18
;	call Textbox
;
;	ld de, .TypeString
;	hlcoord 1, 1
;	call PlaceString
;
;	ld de, .AttackerString
;	hlcoord 1, 3
;	call PlaceString
;
;	ld de, .AttackerStringZeroDamage
;	hlcoord 1, 4
;	call PlaceString
;
;	ld de, .AttackerStringHalfDamage
;	hlcoord 1, 5
;	call PlaceString
;
;	ld de, .DefenderString
;	hlcoord 1, 7
;	call PlaceString
;
;	ld de, .DefenderStringZeroDamage
;	hlcoord 1, 8
;	call PlaceString
;
;	ld de, .DefenderStringDoubleDamage
;	hlcoord 1, 9
;	jmp PlaceString
;
;.TypeString:
;	db "Normal Type@"
;.AttackerString:
;	db "Attacker:@"
;.AttackerStringZeroDamage:
;	db "0× Ghost@"
;.AttackerStringHalfDamage:
;	db "<half>× Rock/Steel@"
;
;.DefenderString:
;	db "Defender:@"
;.DefenderStringZeroDamage:
;	db "0× Ghost@"
;.DefenderStringDoubleDamage:
;	db "2× Poison/Fight@"
;
;PoisonTypeChart:
;	hlcoord 0, 0
;	lb bc, 14, 18
;	call Textbox
;
;	ld de, .TypeString
;	hlcoord 1, 1
;	call PlaceString
;
;	ld de, .AttackerString
;	hlcoord 1, 3
;	call PlaceString
;
;	ld de, .AttackerStringHalfDamage1
;	hlcoord 1, 4
;	call PlaceString
;
;	ld de, .AttackerStringHalfDamage2
;	hlcoord 1, 5
;	call PlaceString
;
;	ld de, .AttackerStringZeroDamage
;	hlcoord 1, 6
;	call PlaceString
;
;	ld de, .AttackerStringDoubleDamage1
;	hlcoord 1, 7
;	call PlaceString
;
;	ld de, .AttackerStringDoubleDamage2
;	hlcoord 1, 8
;	call PlaceString
;
;
;	ld de, .DefenderString
;	hlcoord 1, 10
;	call PlaceString
;
;	ld de, .DefenderStringZeroDamage
;	hlcoord 1, 11
;	call PlaceString
;
;	ld de, .DefenderStringHalfoDamage1
;	hlcoord 1, 12
;	call PlaceString
;
;	ld de, .DefenderStringHalfoDamage2
;	hlcoord 1, 13
;	call PlaceString
;
;	ld de, .DefenderStringDoubleDamage
;	hlcoord 1, 14
;	jmp PlaceString
;
;.TypeString:
;	db "Poison Type@"
;.AttackerString:
;	db "Attacker:@"
;.AttackerStringHalfDamage1:
;	db "<half>× Poison/Ground/@"
;.AttackerStringHalfDamage2:
;	db "   Rock@"
;.AttackerStringZeroDamage:
;	db "0× Steel@"
;.AttackerStringDoubleDamage1:
;	db "2× Grass/Fairy/@"
;.AttackerStringDoubleDamage2:
;	db "   Normal@"
;
;.DefenderString:
;	db "Defender:@"
;.DefenderStringZeroDamage:
;	db "0× Steel@"
;.DefenderStringHalfoDamage1:
;	db "<half>× Grass/Poison/@"
;.DefenderStringHalfoDamage2:
;	db "   Bug/Fighting@"
;.DefenderStringDoubleDamage:
;	db "2× Ground/Psychic@"
;
;PsychicTypeChart:
;	hlcoord 0, 0
;	lb bc, 14, 18
;	call Textbox
;
;	ld de, .TypeString
;	hlcoord 1, 1
;	call PlaceString
;
;	ld de, .AttackerString
;	hlcoord 1, 3
;	call PlaceString
;
;	ld de, .AttackerStringZeroDamage
;	hlcoord 1, 4
;	call PlaceString
;
;	ld de, .AttackerStringHalfDamage1
;	hlcoord 1, 5
;	call PlaceString
;
;	ld de, .AttackerStringHalfDamage2
;	hlcoord 1, 6
;	call PlaceString
;
;	ld de, .AttackerStringDoubleDamage
;	hlcoord 1, 7
;	call PlaceString
;
;	ld de, .DefenderString
;	hlcoord 1, 9
;	call PlaceString
;
;	ld de, .DefenderStringHalfDamage
;	hlcoord 1, 10
;	call PlaceString
;
;	ld de, .DefenderStringDoubleDamage
;	hlcoord 1, 11
;	jmp PlaceString
;
;.TypeString:
;	db "Psychic Type@"
;.AttackerString:
;	db "Attacker:@"
;.AttackerStringZeroDamage:
;	db "0× Dark@"
;.AttackerStringHalfDamage1:
;	db "<half>× Ghost/Steel/@"
;.AttackerStringHalfDamage2:
;	db "   Psychic@"
;.AttackerStringDoubleDamage:
;	db "2× Poison/Fight@"
;
;.DefenderString:
;	db "Defender:@"
;.DefenderStringHalfDamage:
;	db "<half>× Psychic/Fight@"
;.DefenderStringDoubleDamage:
;	db "2× Bug/Dark/Ghost@"
;
;RockTypeChart:
;	hlcoord 0, 0
;	lb bc, 14, 18
;	call Textbox
;
;	ld de, .TypeString
;	hlcoord 1, 1
;	call PlaceString
;
;	ld de, .AttackerString
;	hlcoord 1, 3
;	call PlaceString
;
;	ld de, .AttackerStringHalfDamage1
;	hlcoord 1, 4
;	call PlaceString
;
;	ld de, .AttackerStringHalfDamage2
;	hlcoord 1, 5
;	call PlaceString
;
;	ld de, .AttackerStringDoubleDamage1
;	hlcoord 1, 6
;	call PlaceString
;
;	ld de, .AttackerStringDoubleDamage2
;	hlcoord 1, 7
;	call PlaceString
;
;	ld de, .DefenderString
;	hlcoord 1, 9
;	call PlaceString
;
;	ld de, .DefenderStringHalfDamage1
;	hlcoord 1, 10
;	call PlaceString
;
;	ld de, .DefenderStringHalfDamage2
;	hlcoord 1, 11
;	call PlaceString
;
;	ld de, .DefenderStringDoubleDamage1
;	hlcoord 1, 12
;	call PlaceString
;
;	ld de, .DefenderStringDoubleDamage2
;	hlcoord 1, 13
;	call PlaceString
;
;	ld de, .DefenderStringDoubleDamage3
;	hlcoord 1, 14
;	jmp PlaceString
;
;.TypeString:
;	db "Rock Type@"
;.AttackerString:
;	db "Attacker:@"
;.AttackerStringHalfDamage1:
;	db "<half>× Ground/Steel/@"
;.AttackerStringHalfDamage2:
;	db "   Fight@"
;.AttackerStringDoubleDamage1:
;	db "2× Fire/Fly/Ice/@"
;.AttackerStringDoubleDamage2:
;	db "   Bug@"
;
;.DefenderString:
;	db "Defender:@"
;.DefenderStringHalfDamage1:
;	db "<half>× Normal/Fly/@"
;.DefenderStringHalfDamage2:
;	db "   Fire/Poison@"
;.DefenderStringDoubleDamage1:
;	db "2× Water/Grass/@"
;.DefenderStringDoubleDamage2:
;	db "   Steel/Ground/@"
;.DefenderStringDoubleDamage3:
;	db "   Fight@"
;
;SteelTypeChart:
;	hlcoord 0, 0
;	lb bc, 14, 18
;	call Textbox
;
;	ld de, .TypeString
;	hlcoord 1, 1
;	call PlaceString
;
;	ld de, .AttackerString
;	hlcoord 1, 2
;	call PlaceString
;
;	ld de, .AttackerStringHalfDamage1
;	hlcoord 1, 3
;	call PlaceString
;
;	ld de, .AttackerStringHalfDamage2
;	hlcoord 1, 4
;	call PlaceString
;
;	ld de, .AttackerStringDoubleDamage
;	hlcoord 1, 5
;	call PlaceString
;
;	ld de, .DefenderString
;	hlcoord 1, 7
;	call PlaceString
;
;	ld de, .DefenderStringZeroDamage
;	hlcoord 1, 8
;	call PlaceString
;
;	ld de, .DefenderStringHalfDamage1
;	hlcoord 1, 9
;	call PlaceString
;
;	ld de, .DefenderStringHalfDamage2
;	hlcoord 1, 10
;	call PlaceString
;
;	ld de, .DefenderStringHalfDamage3
;	hlcoord 1, 11
;	call PlaceString
;
;	ld de, .DefenderStringHalfDamage4
;	hlcoord 1, 12
;	call PlaceString
;
;	ld de, .DefenderStringDoubleDamage1
;	hlcoord 1, 13
;	call PlaceString
;
;	ld de, .DefenderStringDoubleDamage2
;	hlcoord 1, 14
;	jmp PlaceString
;
;.TypeString:
;	db "Steel Type@"
;.AttackerString:
;	db "Attacker:@"
;.AttackerStringHalfDamage1:
;	db "<half>× Fire/Electric/@"
;.AttackerStringHalfDamage2:
;	db "   Steel/Water@"
;.AttackerStringDoubleDamage:
;	db "2× Ice/Fairy/Rock@"
;
;.DefenderString:
;	db "Defender:@"
;.DefenderStringZeroDamage:
;	db "0× Poison@"
;.DefenderStringHalfDamage1:
;	db "<half>× Normal/Psychic/@"
;.DefenderStringHalfDamage2:
;	db "   Ice/Bug,/Steel/@"
;.DefenderStringHalfDamage3:
;	db "   Rock/Grass/Fly/@"
;.DefenderStringHalfDamage4:
;	db "   Dragon/Fairy@"
;.DefenderStringDoubleDamage1:
;	db "2× Fire/Fight/@"
;.DefenderStringDoubleDamage2:
;	db "   Ground@"
;
;WaterTypeChart:
;	hlcoord 0, 0
;	lb bc, 14, 18
;	call Textbox
;
;	ld de, .TypeString
;	hlcoord 1, 1
;	call PlaceString
;
;	ld de, .AttackerString
;	hlcoord 1, 3
;	call PlaceString
;
;	ld de, .AttackerStringHalfDamage1
;	hlcoord 1, 4
;	call PlaceString
;
;	ld de, .AttackerStringHalfDamage2
;	hlcoord 1, 5
;	call PlaceString
;
;	ld de, .AttackerStringDoubleDamage1
;	hlcoord 1, 6
;	call PlaceString
;
;	ld de, .AttackerStringDoubleDamage2
;	hlcoord 1, 7
;	call PlaceString
;
;	ld de, .DefenderString
;	hlcoord 1, 9
;	call PlaceString
;
;	ld de, .DefenderStringHalfDamage1
;	hlcoord 1, 10
;	call PlaceString
;
;	ld de, .DefenderStringHalfDamage2
;	hlcoord 1, 11
;	call PlaceString
;
;	ld de, .DefenderStringDoubleDamage
;	hlcoord 1, 12
;	jmp PlaceString
;
;.TypeString:
;	db "Water Type@"
;.AttackerString:
;	db "Attacker:@"
;.AttackerStringHalfDamage1:
;	db "<half>× Water/Grass/@"
;.AttackerStringHalfDamage2:
;	db "   Dragon/Ice@"
;.AttackerStringDoubleDamage1:
;	db "2× Fire/Ground/@"
;.AttackerStringDoubleDamage2:
;	db "   Rock@"
;
;.DefenderString:
;	db "Defender:@"
;.DefenderStringHalfDamage1:
;	db "<half>× Fire/Steel/Ice/@"
;.DefenderStringHalfDamage2:
;	db "   Water@"
;.DefenderStringDoubleDamage:
;	db "2× Grass/Electric@"
