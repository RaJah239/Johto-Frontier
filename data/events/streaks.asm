MembersStreakCard:
	push hl
	push de
	push bc
	xor a
	ld [wMemberCard], a
	call UpdateMemberCardPageText
	call BattleTowerStreakCard
	call WaitButtonMemberCardInfoBox
	jmp PopBCDEHL

; ========================
; Update text for each page
; ========================
UpdateMemberCardPageText:
	hlcoord 3, 17
	ld a, [wMemberCard]

	cp 1
	jr z, .page_2
	cp 2
	jr z, .page_3
	cp 3
	jr z, .page_4
; Default: page 1
	ld de, MemberCardMainText.page1
	call PlaceString
	ld de, MemberCardMainText.page1_content
	jr .done

.page_2
	ld de, MemberCardMainText.page2
	call PlaceString
	ld de, MemberCardMainText.page2_content
	jr .done

.page_3
	ld de, MemberCardMainText.page3
	call PlaceString
	ld de, MemberCardMainText.page3_content
	jr .done

.page_4
	ld de, MemberCardMainText.page4
	call PlaceString
	ld de, MemberCardMainText.page4_content
	; fallthrough

.done
	hlcoord 1, 16
	jmp PlaceString

MemberCardMainText:
.page1:
	db "◀ Page  1/4  ▶@"
.page1_content:
	db "   Battle Tower    @"

.page2:
	db "◀ Page  2/4  ▶@"
.page2_content:
	db "Battle Tower Mirror@"

.page3:
	db "◀ Page  3/4  ▶@"
.page3_content:
	db "   Battle Lobby     @"

.page4:
	db "◀ Page  4/4  ▶@"
.page4_content:
	db " Electric Type@"

WaitButtonMemberCardInfoBox:
	ldh a, [hOAMUpdate]
	push af
	ld a, 1
	ldh [hOAMUpdate], a
	call WaitBGMap
	call JoyWaitAorBorDPADMemberCardInfo
	pop af
	ldh [hOAMUpdate], a
	ret

JoyWaitAorBorDPADMemberCardInfo:
.loop
    call DelayFrame
    call GetJoypad

    ; A / B = exit
    ldh a, [hJoyPressed]
    and A_BUTTON | B_BUTTON
    ret nz

    ; single presses on left and right to switch pages
	ldh a, [hJoyPressed]
	and D_RIGHT
	call nz, MemberCardRightPress
	ldh a, [hJoyPressed]
	and D_LEFT
	call nz, MemberCardLeftPress

    ; if up/down is not held, reset delay
    ldh a, [hJoyDown]
    and D_UP | D_DOWN
    jr z, .reset_delay

    ; countdown delay
    ld hl, wMemberCardDelay
    ld a, [hl]
    and a
    jr z, .check_dirs
    dec [hl]
    jr .after_dirs

.check_dirs
    ; reset delay (this is in terms of fps)
    ld a, 5          ; switch pages every 5 frames
    ld [hl], a

    ; UP -> go right
    ldh a, [hJoyDown]
    bit D_UP_F, a
    call nz, MemberCardRightPress

    ; DOWN -> go left
    ldh a, [hJoyDown]
    bit D_DOWN_F, a
    call nz, MemberCardLeftPress

.after_dirs
    call UpdateTimeAndPals
    jr .loop

.reset_delay
    xor a
    ld [wMemberCardDelay], a
    jr .after_dirs

; ========================
; Left button navigation
; ========================
MemberCardLeftPress:
	; play switching pockets SFX	
	ld de, SFX_SWITCH_POCKETS
	call PlaySFX

	ld a, [wMemberCard]
	and a
	jr z, .jump_to_page_4
	cp 1
	jr z, .jump_to_page_1
	cp 2
	jr z, .jump_to_page_2
	cp 3
	ret nz

.jump_to_page_4:
	call DecreaseMemberCardPage
	call UpdateMemberCardPageText
	jmp BattleLobbyStreakCard

.jump_to_page_1:
	call DecreaseMemberCardPage
	call UpdateMemberCardPageText
	jr BattleTowerStreakCard

.jump_to_page_2:
	call DecreaseMemberCardPage
	call UpdateMemberCardPageText
	jmp BattleTowerMirrorModeStreakCard

.jump_to_page_3:
	call DecreaseMemberCardPage
	call UpdateMemberCardPageText
	jmp BattleLobbyStreakCard

; ========================
; Right button navigation
; ========================
MemberCardRightPress:
	; play switching pockets SFX	
	ld de, SFX_SWITCH_POCKETS
	call PlaySFX

	ld a, [wMemberCard]
	and a
	jr z, .jump_to_page_2
	cp 1
	jr z, .jump_to_page_3
	cp 2
	jr z, .jump_to_page_4
	cp 3
	ret nz
.jump_to_page_1:
	call IncreaseMemberCardPage
	call UpdateMemberCardPageText
	jr BattleTowerStreakCard

.jump_to_page_2:
	call IncreaseMemberCardPage
	call UpdateMemberCardPageText
	jmp BattleTowerMirrorModeStreakCard

.jump_to_page_3:
	call IncreaseMemberCardPage
	call UpdateMemberCardPageText
	jmp BattleLobbyStreakCard

.jump_to_page_4:
	call IncreaseMemberCardPage
	call UpdateMemberCardPageText
	jmp LastStreakCard
	
; ========================
; Page counter functions
; ========================
IncreaseMemberCardPage:
	ld a, [wMemberCard]
	inc a
	cp 4                     ; Number of Pages
	jr c, .store
	xor a                    ; Wrap to page 1
.store
	ld [wMemberCard], a
	ret

DecreaseMemberCardPage:
	ld a, [wMemberCard]
	or a
	jr nz, .dec
	ld a, 4                 ; Wrap to last page
.dec
	dec a
	ld [wMemberCard], a
	ret

BattleTowerStreakCard:
	hlcoord 0, 0
	lb bc, 14, 18
	call Textbox

	ld de, .FacilityString
	hlcoord 1, 1
	call PlaceString

	ld de, .RegularModeString
	hlcoord 1, 3
	call PlaceString

	ld de, .NormalModeString
	hlcoord 2, 5
	call PlaceString

	ld de, wBattleTowerNormalPoints
	hlcoord 14, 5
	lb bc, 1, 3
	call PrintNum

	ld de, .InverseModeString
	hlcoord 2, 6
	call PlaceString

	ld de, wBattleTowerInversePoints
	hlcoord 14, 6
	lb bc, 1, 3
	call PrintNum

	ld de, .NeutralModeString
	hlcoord 2, 7
	call PlaceString

	ld de, wBattleTowerTypelessPoints
	hlcoord 14, 7
	lb bc, 1, 3
	call PrintNum

	ld de, .HardModeString
	hlcoord 1, 9
	call PlaceString

	ld de, .NormalModeString
	hlcoord 2, 11
	call PlaceString

	ld de, wBattleTowerHardModeNormalPoints
	hlcoord 14, 11
	lb bc, 1, 3
	call PrintNum

	ld de, .InverseModeString
	hlcoord 2, 12
	call PlaceString

	ld de, wBattleTowerHardModeInversePoints
	hlcoord 14, 12
	lb bc, 1, 3
	call PrintNum


	ld de, .NeutralModeString
	hlcoord 2, 13
	call PlaceString

	ld de, wBattleTowerHardModeTypelessPoints
	hlcoord 14, 13
	lb bc, 1, 3
	jmp PrintNum

.FacilityString:
	db " <physical> Battle Tower <physical>@"
.RegularModeString:
	db " - Regular Mode -@"
.HardModeString:
	db "  - Hard Mode -@"
.NormalModeString:
	db "Normal Mode@"
.InverseModeString:
	db "Inverse Mode@"
.NeutralModeString:
	db "Neutral Mode@"

BattleTowerMirrorModeStreakCard:
	hlcoord 0, 0
	lb bc, 14, 18
	call Textbox

	ld de, .FacilityString1
	hlcoord 1, 1
	call PlaceString

	ld de, .FacilityString2
	hlcoord 4, 2
	call PlaceString

	ld de, .RegularModeString
	hlcoord 1, 3
	call PlaceString

	ld de, .NormalModeString
	hlcoord 2, 5
	call PlaceString

	ld de, wBattleTowerMirrorModeNormalPoints
	hlcoord 14, 5
	lb bc, 1, 3
	call PrintNum

	ld de, .InverseModeString
	hlcoord 2, 6
	call PlaceString

	ld de, wBattleTowerMirrorModeInversePoints
	hlcoord 14, 6
	lb bc, 1, 3
	call PrintNum

	ld de, .NeutralModeString
	hlcoord 2, 7
	call PlaceString

	ld de, wBattleTowerMirrorModeTypelessPoints
	hlcoord 14, 7
	lb bc, 1, 3
	call PrintNum

	ld de, .HardModeString
	hlcoord 1, 9
	call PlaceString

	ld de, .NormalModeString
	hlcoord 2, 11
	call PlaceString

	ld de, wBattleTowerMirrorModeHardModeNormalPoints
	hlcoord 14, 11
	lb bc, 1, 3
	call PrintNum

	ld de, .InverseModeString
	hlcoord 2, 12
	call PlaceString

	ld de, wBattleTowerMirrorModeHardModeInversePoints
	hlcoord 14, 12
	lb bc, 1, 3
	call PrintNum


	ld de, .NeutralModeString
	hlcoord 2, 13
	call PlaceString

	ld de, wBattleTowerMirrorModeHardModeTypelessPoints
	hlcoord 14, 13
	lb bc, 1, 3
	jmp PrintNum

.FacilityString1:
	db " <physical> Battle Tower <physical>@"
.FacilityString2:
	db " <physical> Mirror <physical>@"
.RegularModeString:
	db " - Regular Mode -@"
.HardModeString:
	db "  - Hard Mode -@"
.NormalModeString:
	db "Normal Mode@"
.InverseModeString:
	db "Inverse Mode@"
.NeutralModeString:
	db "Neutral Mode@"

BattleLobbyStreakCard:
	hlcoord 0, 0
	lb bc, 14, 18
	call Textbox

	ld de, .FacilityString
	hlcoord 1, 1
	call PlaceString

	ld de, .RegularModeString
	hlcoord 1, 3
	call PlaceString

	ld de, .NormalModeString
	hlcoord 2, 5
	call PlaceString

	ld de, wBattleLobbyNormalPoints
	hlcoord 14, 5
	lb bc, 1, 3
	call PrintNum

	ld de, .InverseModeString
	hlcoord 2, 6
	call PlaceString

	ld de, wBattleLobbyInversePoints
	hlcoord 14, 6
	lb bc, 1, 3
	call PrintNum

	ld de, .NeutralModeString
	hlcoord 2, 7
	call PlaceString

	ld de, wBattleLobbyTypelessPoints
	hlcoord 14, 7
	lb bc, 1, 3
	call PrintNum

	ld de, .HardModeString
	hlcoord 1, 9
	call PlaceString

	ld de, .NormalModeString
	hlcoord 2, 11
	call PlaceString

	ld de, wBattleLobbyHardModeNormalPoints
	hlcoord 14, 11
	lb bc, 1, 3
	call PrintNum

	ld de, .InverseModeString
	hlcoord 2, 12
	call PlaceString

	ld de, wBattleLobbyHardModeInversePoints
	hlcoord 14, 12
	lb bc, 1, 3
	call PrintNum


	ld de, .NeutralModeString
	hlcoord 2, 13
	call PlaceString

	ld de, wBattleLobbyHardModeTypelessPoints
	hlcoord 14, 13
	lb bc, 1, 3
	jmp PrintNum

.FacilityString:
	db " <physical> Battle Lobby <physical>@"
.RegularModeString:
	db " - Regular Mode -@"
.HardModeString:
	db "  - Hard Mode -@"
.NormalModeString:
	db "Normal Mode@"
.InverseModeString:
	db "Inverse Mode@"
.NeutralModeString:
	db "Neutral Mode@"

LastStreakCard:
	hlcoord 0, 0
	lb bc, 14, 18
	call Textbox

	ld de, .FacilityString
	hlcoord 1, 1
	call PlaceString

	ld de, .AttackerString
	hlcoord 1, 3
	call PlaceString

	ld de, .AttackerStringZeroDamage
	hlcoord 1, 4
	call PlaceString

	ld de, .AttackerStringHalfDamage1
	hlcoord 1, 5
	call PlaceString

	ld de, .AttackerStringHalfDamage2
	hlcoord 1, 6
	call PlaceString

	ld de, .AttackerStringDoubleDamage
	hlcoord 1, 7
	call PlaceString

	ld de, .DefenderString
	hlcoord 1, 9
	call PlaceString

	ld de, .DefenderStringHalfDamage1
	hlcoord 1, 10
	call PlaceString

	ld de, .DefenderStringHalfDamage2
	hlcoord 1, 11
	call PlaceString

	ld de, .DefenderStringDoubleDamage
	hlcoord 1, 12
	jmp PlaceString

.FacilityString:
	db "Electric Type@"
.AttackerString:
	db "Attacker:@"
.AttackerStringHalfDamage1:
	db "<half>× Grass/Dragon/@"
.AttackerStringHalfDamage2:
	db "   Electric@"
.AttackerStringZeroDamage:
	db "0× Ground@"
.AttackerStringDoubleDamage:
	db "2× Water/Flying@"

.DefenderString:
	db "Defender:@"
.DefenderStringHalfDamage1:
	db "<half>× Flying/Steel/@"
.DefenderStringHalfDamage2:
	db "   Electric@"
.DefenderStringDoubleDamage:
	db "2× Ground@"
