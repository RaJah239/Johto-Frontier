;Score Card player’s accomplishments:
;- became champ
;- caught all pokemon
;- got a streak of 100 in xxx
;- got 999,999 money
;- Shiny Hunter - obtained a shiny mon
;- Rare Egg Hunter - got all odd eggs
;- Treasure Hunter - found all hidden items
;- Have hints around the world of achievements
; etc.

_ScoreCard::
; Score Card: a 10-page book-style viewer for the score.
; Page 1 shows "Score:" and the current value; pages 2-10
; are blank. A/B exits; Left/Right (or Up/Down held) turns
; pages.
	push hl
	push de
	push bc
	call ScoreClamp
	xor a
	ld [wScoreCardPage], a
	ld [wScoreCardDelay], a
	call ScoreCardRedraw
	call WaitButtonScoreCardInfoBox
	jmp PopBCDEHL

; ========================
; Page counter text (row 17)
; ========================
UpdateScoreCardPageText:
	ld a, [wScoreCardPage]
	ld hl, ScoreCardPageTexts
	add a, a
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hli]
	ld e, a
	ld a, [hl]
	ld d, a
	hlcoord 3, 17
	jmp PlaceString

ScoreCardPageTexts:
	dw .page1
	dw .page2
	dw .page3
	dw .page4
	dw .page5
	dw .page6
	dw .page7
	dw .page8
	dw .page9
	dw .page10

.page1:
	db "◀ Page 01/10 ▶@"
.page2:
	db "◀ Page 02/10 ▶@"
.page3:
	db "◀ Page 03/10 ▶@"
.page4:
	db "◀ Page 04/10 ▶@"
.page5:
	db "◀ Page 05/10 ▶@"
.page6:
	db "◀ Page 06/10 ▶@"
.page7:
	db "◀ Page 07/10 ▶@"
.page8:
	db "◀ Page 08/10 ▶@"
.page9:
	db "◀ Page 09/10 ▶@"
.page10:
	db "◀ Page 10/10 ▶@"

; ========================
; Input loop
; ========================
WaitButtonScoreCardInfoBox:
	ldh a, [hOAMUpdate]
	push af
	ld a, 1
	ldh [hOAMUpdate], a
	call WaitBGMap
	call JoyWaitAorBorDPADScoreCardInfo
	pop af
	ldh [hOAMUpdate], a
	ret

JoyWaitAorBorDPADScoreCardInfo:
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
	call nz, ScoreCardRightPress
	ldh a, [hJoyPressed]
	and D_LEFT
	call nz, ScoreCardLeftPress

	; if up/down is not held, reset delay
	ldh a, [hJoyDown]
	and D_UP | D_DOWN
	jr z, .reset_delay

	; countdown delay
	ld hl, wScoreCardDelay
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
	call nz, ScoreCardRightPress

	; DOWN -> go left
	ldh a, [hJoyDown]
	bit D_DOWN_F, a
	call nz, ScoreCardLeftPress

.after_dirs
	call UpdateTimeAndPals
	jr .loop

.reset_delay
	xor a
	ld [wScoreCardDelay], a
	jr .after_dirs

; ========================
; Left / right navigation
; ========================
ScoreCardLeftPress:
	ld de, SFX_SWITCH_POCKETS
	call PlaySFX
	call DecreaseScoreCardPage
	jr ScoreCardRedraw

ScoreCardRightPress:
	ld de, SFX_SWITCH_POCKETS
	call PlaySFX
	call IncreaseScoreCardPage
	; fallthrough

ScoreCardRedraw:
	call UpdateScoreCardPageText
	ld a, [wScoreCardPage]
	and a
	jr z, ScoreCardPage1
	jr ScoreCardEmptyPage

; ========================
; Page 1: the score
; ========================
ScoreCardPage1:
	hlcoord 0, 0
	lb bc, 14, 18
	call Textbox
	hlcoord 1, 1
	ld de, .ScoreLabel
	call PlaceString
	hlcoord 1, 2
	jr PrintScoreWithCommas

.ScoreLabel:
	db "Score:@"

; ========================
; Pages 2-10: blank page
; ========================
ScoreCardEmptyPage:
	hlcoord 0, 0
	lb bc, 14, 18
	jmp Textbox

; ========================
; Page counter wrap-around
; ========================
IncreaseScoreCardPage:
	ld a, [wScoreCardPage]
	inc a
	cp 10
	jr c, .store
	xor a
.store
	ld [wScoreCardPage], a
	ret

DecreaseScoreCardPage:
	ld a, [wScoreCardPage]
	and a
	jr nz, .dec
	ld a, 10
.dec
	dec a
	ld [wScoreCardPage], a
	ret

; ========================
; Score printing (with commas)
; ========================
PrintScoreWithCommas:
; Prints wScore at hl as a decimal string with thousands
; separators (e.g. "9,999,999").
	push hl                     ; screen position

	; wScoreValue = wScore
	ld hl, wScore
	ld de, wScoreValue
	ld bc, 3
	call CopyBytes

	; Split into 7 decimal digits, most significant first
	ld de, .places
	ld hl, wScoreDigits
	ld b, 7
.split_loop
	push bc
	push hl
	; wScorePlace = next power of ten
	ld a, [de]
	inc de
	ld [wScorePlace], a
	ld a, [de]
	inc de
	ld [wScorePlace + 1], a
	ld a, [de]
	inc de
	ld [wScorePlace + 2], a

	; Count how many times the place fits into wScoreValue
	ld c, 0
.sub_loop
	ld a, [wScoreValue + 2]
	ld hl, wScorePlace + 2
	cp [hl]
	jr c, .next_digit
	jr nz, .subtract
	ld a, [wScoreValue + 1]
	ld hl, wScorePlace + 1
	cp [hl]
	jr c, .next_digit
	jr nz, .subtract
	ld a, [wScoreValue]
	ld hl, wScorePlace
	cp [hl]
	jr c, .next_digit
.subtract
	ld a, [wScoreValue]
	ld hl, wScorePlace
	sub [hl]
	ld [wScoreValue], a
	ld a, [wScoreValue + 1]
	ld hl, wScorePlace + 1
	sbc a, [hl]
	ld [wScoreValue + 1], a
	ld a, [wScoreValue + 2]
	ld hl, wScorePlace + 2
	sbc a, [hl]
	ld [wScoreValue + 2], a
	inc c
	jr .sub_loop
.next_digit
	pop hl
	ld a, c
	ld [hl], a
	inc hl
	pop bc
	dec b
	jr nz, .split_loop

	; Find the first nonzero digit, skipping leading zeros.
	; c = 7 means the score is zero.
	ld hl, wScoreDigits
	ld c, 0
.find_first
	ld a, [hl]
	and a
	jr nz, .found
	inc hl
	inc c
	ld a, c
	cp 7
	jr c, .find_first

	; The score is zero: print a single "0"
	pop hl
	ld a, "0"
	ld [hl], a
	ret

.found
	; hl -> first digit, c = its index
	ld a, 7
	sub c
	ld b, a                     ; digits left to print
	pop de                      ; screen position

	; The first digit never gets a separator
	ld a, [hli]
	add a, "0"
	ld [de], a
	inc de
	dec b
	ret z
	inc c                       ; index of the next digit
.emit_loop
	; Separator before digit c if (6 - c) % 3 == 2
	ld a, 6
	sub c
	cp 3
	jr c, .mod_ok
	sub 3
.mod_ok
	cp 2
	jr nz, .no_separator
	ld a, ","
	ld [de], a
	inc de
.no_separator
	ld a, [hli]
	add a, "0"
	ld [de], a
	inc de
	inc c
	dec b
	jr nz, .emit_loop
	ret

.places:
	db $40, $42, $0F ; 1000000
	db $A0, $86, $01 ; 100000
	db $10, $27, $00 ; 10000
	db $E8, $03, $00 ; 1000
	db $64, $00, $00 ; 100
	db $0A, $00, $00 ; 10
	db $01, $00, $00 ; 1

; ========================
; Score increment / decrement
; ========================
ScoreAddOne::
; Adds 1 to wScore, clamped at 9,999,999.
; Called from map scripts with callasm.
	ld a, [wScore + 2]
	cp $98
	jr c, .add
	jr nz, .clamp
	ld a, [wScore + 1]
	cp $96
	jr c, .add
	jr nz, .clamp
	ld a, [wScore]
	cp $7F
	jr nc, .clamp
.add
	ld hl, wScore
	inc [hl]
	ret nz
	inc hl
	inc [hl]
	ret nz
	inc hl
	inc [hl]
	ret
.clamp
	ld hl, wScore
	ld a, $7F
	ld [hli], a
	ld a, $96
	ld [hli], a
	ld [hl], $98
	ret

ScoreSubOne::
; Subtracts 1 from wScore, floored at 0.
; Called from map scripts with callasm.
	ld a, [wScore]
	or a
	jr nz, .low
	ld a, [wScore + 1]
	or a
	jr nz, .mid
	ld a, [wScore + 2]
	or a
	ret z
	dec a
	ld [wScore + 2], a
	ld a, $FF
	ld [wScore + 1], a
	ld [wScore], a
	ret
.low
	dec a
	ld [wScore], a
	ret
.mid
	dec a
	ld [wScore + 1], a
	ld a, $FF
	ld [wScore], a
	ret

ScoreClamp:
; Ensures wScore is at most 9,999,999 (guards against
; garbage left in an old save file's padding).
	ld a, [wScore + 2]
	cp $98
	ret c
	jr nz, .clamp
	ld a, [wScore + 1]
	cp $96
	ret c
	jr nz, .clamp
	ld a, [wScore]
	cp $7F
	ret c
.clamp
	ld hl, wScore
	ld a, $7F
	ld [hli], a
	ld a, $96
	ld [hli], a
	ld [hl], $98
	ret
