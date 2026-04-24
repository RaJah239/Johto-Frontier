; These functions seem to be related to the selection of preset phrases
; for use in mobile communications.  Annoyingly, they separate the
; Battle Tower function above from the data it references.
Function11c05d:
	ld a, e
	or d
	jr z, .error
	ld a, e
	and d
	cp $ff
	jr z, .error
	push hl
	call CopyMobileEZChatToC608
	pop hl
	call PlaceString
	and a
	ret

.error
	ld c, l
	ld b, h
	scf
	ret

Function11c08f:
	ld l, e
	ld h, d
	push hl
	ld a, 3
.loop
	push af
	ld a, [bc]
	ld e, a
	inc bc
	ld a, [bc]
	ld d, a
	inc bc
	push bc
	call Function11c05d
	jr c, .okay
	inc bc

.okay
	ld l, c
	ld h, b
	pop bc
	pop af
	dec a
	jr nz, .loop
	pop hl
	ld de, 2 * SCREEN_WIDTH
	add hl, de
	ld a, $3
.loop2
	push af
	ld a, [bc]
	ld e, a
	inc bc
	ld a, [bc]
	ld d, a
	inc bc
	push bc
	call Function11c05d
	jr c, .okay2
	inc bc

.okay2
	ld l, c
	ld h, b
	pop bc
	pop af
	dec a
	jr nz, .loop2
	ret

CopyMobileEZChatToC608:
	ldh a, [rSVBK]
	push af
	ld a, $1
	ldh [rSVBK], a
	ld a, "@"
	ld hl, wc608
	ld bc, NAME_LENGTH
	call ByteFill
	ld a, d
	and a
	jr z, .get_name
	ld hl, MobileEZChatCategoryPointers
	dec d
	sla d
	ld c, d
	ld b, $0
	add hl, bc
	ld a, [hli]
	ld c, a
	ld a, [hl]
	ld b, a
	push bc
	pop hl
	ld c, e
	ld b, $0
	sla c
	rl b
	sla c
	rl b
	sla c
	rl b
	add hl, bc
	ld bc, NAME_LENGTH_JAPANESE - 1
.copy_string
	ld de, wc608
	call CopyBytes
	ld de, wc608
	pop af
	ldh [rSVBK], a
	ret

.get_name
	ld a, e
	ld [wNamedObjectIndex], a
	call GetPokemonName
	ld hl, wStringBuffer1
	ld bc, MON_NAME_LENGTH - 1
	jr .copy_string

AnimateEZChatCursor:
	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	jumptable .Jumptable, hl

.Jumptable:
	dw .zero
	dw .one
	dw .two
	dw .three
	dw .four
	dw .five
	dw .six
	dw .seven
	dw .eight
	dw .nine
	dw .ten

.zero
	ld a, [wcd20]
	add a
	ld hl, .Coords_Zero
	ld e, $1
	jr .load

.one
	ld a, [wcd21]
	add a
	ld hl, .Coords_One
	ld e, $2
	jr .load

.two
	ld hl, .FramesetsIDs_Two
	ld a, [wcd22]
	ld e, a
	ld d, 0
	add hl, de
	ld a, [hl]
	call ReinitSpriteAnimFrame

	ld a, [wcd22]
	add a
	ld hl, .Coords_Two
	ld e, $4
	jr .load

.three
	ld a, SPRITE_ANIM_FRAMESET_EZCHAT_CURSOR_2
	call ReinitSpriteAnimFrame
	ld a, [wMobileCommsJumptableIndex]
	add a
	ld hl, .Coords_Three
	ld e, $8
.load
	push de
	ld e, a
	ld d, 0
	add hl, de
	push hl
	pop de
	ld hl, SPRITEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [de]
	inc de
	ld [hli], a
	ld a, [de]
	ld [hl], a
	pop de
	ld a, e
	call .UpdateObjectFlags
	ret

.four
	ld a, SPRITE_ANIM_FRAMESET_EZCHAT_CURSOR_2
	call ReinitSpriteAnimFrame
	ld a, [wcd2a]
	add a
	ld hl, .Coords_Four
	ld e, $10
	jr .load

.five
	ld a, SPRITE_ANIM_FRAMESET_EZCHAT_CURSOR_2
	call ReinitSpriteAnimFrame
	ld a, [wcd2c]
	add a
	ld hl, .Coords_Five
	ld e, $20
	jr .load

.six
	ld a, SPRITE_ANIM_FRAMESET_EZCHAT_CURSOR_5
	call ReinitSpriteAnimFrame
	; X = [wcd4a] * 8 + 24
	ld a, [wcd4a]
	add a
	add a
	add a
	add $18
	ld hl, SPRITEANIMSTRUCT_XCOORD
	add hl, bc
	ld [hli], a
	; Y = 48
	ld a, $30
	ld [hl], a

	ld a, $1
	ld e, a
	call .UpdateObjectFlags
	ret

.seven
	ld a, [wEZChatCursorYCoord]
	cp $4
	jr z, .cursor0
	ld a, SPRITE_ANIM_FRAMESET_EZCHAT_CURSOR_3
	jr .got_frameset

.cursor0
	ld a, SPRITE_ANIM_FRAMESET_EZCHAT_CURSOR_1
.got_frameset
	call ReinitSpriteAnimFrame
	ld a, [wEZChatCursorYCoord]
	cp $4
	jr z, .asm_11d1b1
	; X = [wEZChatCursorXCoord] * 8 + 32
	ld a, [wEZChatCursorXCoord]
	add a
	add a
	add a
	add $20
	ld hl, SPRITEANIMSTRUCT_XCOORD
	add hl, bc
	ld [hli], a
	; Y = [wEZChatCursorYCoord] * 16 + 72
	ld a, [wEZChatCursorYCoord]
	add a
	add a
	add a
	add a
	add $48
	ld [hl], a
	ld a, $2
	ld e, a
	call .UpdateObjectFlags
	ret

.asm_11d1b1
	; X = [wEZChatCursorXCoord] * 40 + 24
	ld a, [wEZChatCursorXCoord]
	add a
	add a
	add a
	ld e, a
	add a
	add a
	add e
	add $18
	ld hl, SPRITEANIMSTRUCT_XCOORD
	add hl, bc
	ld [hli], a
	; Y = 138
	ld a, $8a
	ld [hl], a
	ld a, $2
	ld e, a
	call .UpdateObjectFlags
	ret

.nine
	ld d, -13 * TILE_WIDTH
	ld a, SPRITE_ANIM_FRAMESET_EZCHAT_CURSOR_7
	jr .eight_nine_load

.eight
	ld d, 2 * TILE_WIDTH
	ld a, SPRITE_ANIM_FRAMESET_EZCHAT_CURSOR_6
.eight_nine_load
	push de
	call ReinitSpriteAnimFrame
	ld a, [wcd4a]
	add a
	add a
	add a
	ld e, a
	add a
	add e
	add 8 * TILE_WIDTH
	ld hl, SPRITEANIMSTRUCT_YCOORD
	add hl, bc
	ld [hld], a
	pop af
	ld [hl], a
	ld a, $4
	ld e, a
	call .UpdateObjectFlags
	ret

.ten
	ld a, SPRITE_ANIM_FRAMESET_EZCHAT_CURSOR_1
	call ReinitSpriteAnimFrame
	ld a, $8
	ld e, a
	call .UpdateObjectFlags
	ret

.Coords_Zero:
	dbpixel  1,  3, 5, 2
	dbpixel  7,  3, 5, 2
	dbpixel 13,  3, 5, 2
	dbpixel  1,  5, 5, 2
	dbpixel  7,  5, 5, 2
	dbpixel 13,  5, 5, 2
	dbpixel  1, 17, 5, 2
	dbpixel  7, 17, 5, 2
	dbpixel 13, 17, 5, 2

.Coords_One:
	dbpixel  1,  8, 5, 2
	dbpixel  7,  8, 5, 2
	dbpixel 13,  8, 5, 2
	dbpixel  1, 10, 5, 2
	dbpixel  7, 10, 5, 2
	dbpixel 13, 10, 5, 2
	dbpixel  1, 12, 5, 2
	dbpixel  7, 12, 5, 2
	dbpixel 13, 12, 5, 2
	dbpixel  1, 14, 5, 2
	dbpixel  7, 14, 5, 2
	dbpixel 13, 14, 5, 2
	dbpixel  1, 16, 5, 2
	dbpixel  7, 16, 5, 2
	dbpixel 13, 16, 5, 2
	dbpixel  1, 18, 5, 2
	dbpixel  7, 18, 5, 2
	dbpixel 13, 18, 5, 2

.Coords_Two:
	dbpixel  2,  9       ; 00
	dbpixel  3,  9       ; 01
	dbpixel  4,  9       ; 02
	dbpixel  5,  9       ; 03
	dbpixel  6,  9       ; 04
	dbpixel  2, 11       ; 05
	dbpixel  3, 11       ; 06
	dbpixel  4, 11       ; 07
	dbpixel  5, 11       ; 08
	dbpixel  6, 11       ; 09
	dbpixel  2, 13       ; 0a
	dbpixel  3, 13       ; 0b
	dbpixel  4, 13       ; 0c
	dbpixel  5, 13       ; 0d
	dbpixel  6, 13       ; 0e
	dbpixel  2, 15       ; 0f
	dbpixel  3, 15       ; 10
	dbpixel  4, 15       ; 11
	dbpixel  5, 15       ; 12
	dbpixel  6, 15       ; 13
	dbpixel  8,  9       ; 14
	dbpixel  9,  9       ; 15
	dbpixel 10,  9       ; 16
	dbpixel 11,  9       ; 17
	dbpixel 12,  9       ; 18
	dbpixel  8, 11       ; 19
	dbpixel  9, 11       ; 1a
	dbpixel 10, 11       ; 1b
	dbpixel 11, 11       ; 1c
	dbpixel 12, 11       ; 1d
	dbpixel  8, 13       ; 1e
	dbpixel  9, 13       ; 1f
	dbpixel 10, 13       ; 20
	dbpixel 11, 13       ; 21
	dbpixel 12, 13       ; 22
	dbpixel 14,  9       ; 23
	dbpixel 16,  9       ; 24
	dbpixel 18,  9       ; 25
	dbpixel  8, 15       ; 26
	dbpixel  9, 15       ; 27
	dbpixel 10, 15       ; 28
	dbpixel 11, 15       ; 29
	dbpixel 12, 15       ; 2a
	dbpixel 14, 11       ; 2b
	dbpixel 14, 13       ; 2c
	dbpixel  1, 18, 5, 2 ; 2d
	dbpixel  7, 18, 5, 2 ; 2e
	dbpixel 13, 18, 5, 2 ; 2f

.Coords_Three:
	dbpixel  2, 10
	dbpixel  8, 10
	dbpixel 14, 10
	dbpixel  2, 12
	dbpixel  8, 12
	dbpixel 14, 12
	dbpixel  2, 14
	dbpixel  8, 14
	dbpixel 14, 14
	dbpixel  2, 16
	dbpixel  8, 16
	dbpixel 14, 16

.Coords_Four:
	dbpixel 16, 10
	dbpixel 16, 12

.Coords_Five:
	dbpixel  4, 10
	dbpixel  4, 12

.FramesetsIDs_Two:
	db SPRITE_ANIM_FRAMESET_EZCHAT_CURSOR_3 ; 00
	db SPRITE_ANIM_FRAMESET_EZCHAT_CURSOR_3 ; 01
	db SPRITE_ANIM_FRAMESET_EZCHAT_CURSOR_3 ; 02
	db SPRITE_ANIM_FRAMESET_EZCHAT_CURSOR_3 ; 03
	db SPRITE_ANIM_FRAMESET_EZCHAT_CURSOR_3 ; 04
	db SPRITE_ANIM_FRAMESET_EZCHAT_CURSOR_3 ; 05
	db SPRITE_ANIM_FRAMESET_EZCHAT_CURSOR_3 ; 06
	db SPRITE_ANIM_FRAMESET_EZCHAT_CURSOR_3 ; 07
	db SPRITE_ANIM_FRAMESET_EZCHAT_CURSOR_3 ; 08
	db SPRITE_ANIM_FRAMESET_EZCHAT_CURSOR_3 ; 09
	db SPRITE_ANIM_FRAMESET_EZCHAT_CURSOR_3 ; 0a
	db SPRITE_ANIM_FRAMESET_EZCHAT_CURSOR_3 ; 0b
	db SPRITE_ANIM_FRAMESET_EZCHAT_CURSOR_3 ; 0c
	db SPRITE_ANIM_FRAMESET_EZCHAT_CURSOR_3 ; 0d
	db SPRITE_ANIM_FRAMESET_EZCHAT_CURSOR_3 ; 0e
	db SPRITE_ANIM_FRAMESET_EZCHAT_CURSOR_3 ; 0f
	db SPRITE_ANIM_FRAMESET_EZCHAT_CURSOR_3 ; 10
	db SPRITE_ANIM_FRAMESET_EZCHAT_CURSOR_3 ; 11
	db SPRITE_ANIM_FRAMESET_EZCHAT_CURSOR_3 ; 12
	db SPRITE_ANIM_FRAMESET_EZCHAT_CURSOR_3 ; 13
	db SPRITE_ANIM_FRAMESET_EZCHAT_CURSOR_3 ; 14
	db SPRITE_ANIM_FRAMESET_EZCHAT_CURSOR_3 ; 15
	db SPRITE_ANIM_FRAMESET_EZCHAT_CURSOR_3 ; 16
	db SPRITE_ANIM_FRAMESET_EZCHAT_CURSOR_3 ; 17
	db SPRITE_ANIM_FRAMESET_EZCHAT_CURSOR_3 ; 18
	db SPRITE_ANIM_FRAMESET_EZCHAT_CURSOR_3 ; 19
	db SPRITE_ANIM_FRAMESET_EZCHAT_CURSOR_3 ; 1a
	db SPRITE_ANIM_FRAMESET_EZCHAT_CURSOR_3 ; 1b
	db SPRITE_ANIM_FRAMESET_EZCHAT_CURSOR_3 ; 1c
	db SPRITE_ANIM_FRAMESET_EZCHAT_CURSOR_3 ; 1d
	db SPRITE_ANIM_FRAMESET_EZCHAT_CURSOR_3 ; 1e
	db SPRITE_ANIM_FRAMESET_EZCHAT_CURSOR_3 ; 1f
	db SPRITE_ANIM_FRAMESET_EZCHAT_CURSOR_3 ; 20
	db SPRITE_ANIM_FRAMESET_EZCHAT_CURSOR_3 ; 21
	db SPRITE_ANIM_FRAMESET_EZCHAT_CURSOR_3 ; 22
	db SPRITE_ANIM_FRAMESET_EZCHAT_CURSOR_3 ; 23
	db SPRITE_ANIM_FRAMESET_EZCHAT_CURSOR_3 ; 24
	db SPRITE_ANIM_FRAMESET_EZCHAT_CURSOR_3 ; 25
	db SPRITE_ANIM_FRAMESET_EZCHAT_CURSOR_3 ; 26
	db SPRITE_ANIM_FRAMESET_EZCHAT_CURSOR_3 ; 27
	db SPRITE_ANIM_FRAMESET_EZCHAT_CURSOR_3 ; 28
	db SPRITE_ANIM_FRAMESET_EZCHAT_CURSOR_3 ; 29
	db SPRITE_ANIM_FRAMESET_EZCHAT_CURSOR_3 ; 2a
	db SPRITE_ANIM_FRAMESET_EZCHAT_CURSOR_3 ; 2b
	db SPRITE_ANIM_FRAMESET_EZCHAT_CURSOR_4 ; 2c
	db SPRITE_ANIM_FRAMESET_EZCHAT_CURSOR_1 ; 2d
	db SPRITE_ANIM_FRAMESET_EZCHAT_CURSOR_1 ; 2e
	db SPRITE_ANIM_FRAMESET_EZCHAT_CURSOR_1 ; 2f

.UpdateObjectFlags:
	ld hl, wcd24
	and [hl]
	jr nz, .update_y_offset
	ld a, e
	ld hl, wcd23
	and [hl]
	jr z, .reset_y_offset
	ld hl, SPRITEANIMSTRUCT_VAR3
	add hl, bc
	ld a, [hl]
	and a
	jr z, .flip_bit_0
	dec [hl]
	ret

.flip_bit_0
	ld a, $0
	ld [hld], a
	ld a, $1
	xor [hl]
	ld [hl], a
	and a
	jr nz, .update_y_offset
.reset_y_offset
	ld hl, SPRITEANIMSTRUCT_YOFFSET
	add hl, bc
	xor a
	ld [hl], a
	ret

.update_y_offset
	ld hl, SPRITEANIMSTRUCT_YCOORD
	add hl, bc
	ld a, $b0
	sub [hl]
	ld hl, SPRITEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	ret

INCLUDE "data/pokemon/ezchat_order.asm"

MobileEZChatCategoryPointers:
; entries correspond to EZCHAT_* constants
	dw .Types          ; 01
	dw .Greetings      ; 02
	dw .People         ; 03
	dw .Battle         ; 04
	dw .Exclamations   ; 05
	dw .Conversation   ; 06
	dw .Feelings       ; 07
	dw .Conditions     ; 08
	dw .Life           ; 09
	dw .Hobbies        ; 0a
	dw .Actions        ; 0b
	dw .Time           ; 0c
	dw .Farewells      ; 0d
	dw .ThisAndThat    ; 0e

.Types:
	db "あく@@@", $26, $0, $0
	db "いわ@@@", $aa, $0, $0
	db "エスパー@", $da, $0, $0
	db "かくとう@", $4e, $1, $0
	db "くさ@@@", $ba, $1, $0
	db "ゴースト@", $e4, $1, $0
	db "こおり@@", $e6, $1, $0
	db "じめん@@", $68, $2, $0
	db "タイプ@@", $e8, $2, $0
	db "でんき@@", $8e, $3, $0
	db "どく@@@", $ae, $3, $0
	db "ドラゴン@", $bc, $3, $0
	db "ノーマル@", $22, $4, $0
	db "はがね@@", $36, $4, $0
	db "ひこう@@", $5e, $4, $0
	db "ほのお@@", $b2, $4, $0
	db "みず@@@", $f4, $4, $0
	db "むし@@@", $12, $5, $0

.Greetings:
	db "ありがと@", $58, $0, $0
	db "ありがとう", $5a, $0, $0
	db "いくぜ！@", $80, $0, $0
	db "いくよ！@", $82, $0, $0
	db "いくわよ！", $84, $0, $0
	db "いやー@@", $a6, $0, $0
	db "おっす@@", $a, $1, $0
	db "おはつです", $22, $1, $0
	db "おめでとう", $2a, $1, $0
	db "ごめん@@", $f8, $1, $0
	db "ごめんよ@", $fa, $1, $0
	db "こらっ@@", $fc, $1, $0
	db "こんちは！", $a, $2, $0
	db "こんにちは", $10, $2, $0
	db "さようなら", $28, $2, $0
	db "サンキュー", $2e, $2, $0
	db "さんじょう", $30, $2, $0
	db "しっけい@", $48, $2, $0
	db "しつれい@", $4c, $2, $0
	db "じゃーね@", $6c, $2, $0
	db "すいません", $8c, $2, $0
	db "それじゃ@", $ca, $2, $0
	db "どうも@@", $a6, $3, $0
	db "なんじゃ@", $ee, $3, $0
	db "ハーイ@@", $2c, $4, $0
	db "はいはい@", $32, $4, $0
	db "バイバイ@", $34, $4, $0
	db "へイ@@@", $8a, $4, $0
	db "またね@@", $de, $4, $0
	db "もしもし@", $32, $5, $0
	db "やあ@@@", $3e, $5, $0
	db "やっほー@", $4e, $5, $0
	db "よう@@@", $62, $5, $0
	db "ようこそ@", $64, $5, $0
	db "よろしく@", $80, $5, $0
	db "らっしゃい", $94, $5, $0

.People:
	db "あいて@@", $1c, $0, $0
	db "あたし@@", $36, $0, $0
	db "あなた@@", $40, $0, $0
	db "あなたが@", $42, $0, $0
	db "あなたに@", $44, $0, $0
	db "あなたの@", $46, $0, $0
	db "あなたは@", $48, $0, $0
	db "あなたを@", $4a, $0, $0
	db "おかあさん", $e8, $0, $0
	db "おじいさん", $fc, $0, $0
	db "おじさん@", $2, $1, $0
	db "おとうさん", $e, $1, $0
	db "おとこのこ", $10, $1, $0
	db "おとな@@", $14, $1, $0
	db "おにいさん", $16, $1, $0
	db "おねえさん", $18, $1, $0
	db "おばあさん", $1c, $1, $0
	db "おばさん@", $20, $1, $0
	db "おれさま@", $34, $1, $0
	db "おんなのこ", $3a, $1, $0
	db "ガール@@", $40, $1, $0
	db "かぞく@@", $52, $1, $0
	db "かのじょ@", $72, $1, $0
	db "かれ@@@", $7c, $1, $0
	db "きみ@@@", $9a, $1, $0
	db "きみが@@", $9c, $1, $0
	db "きみに@@", $9e, $1, $0
	db "きみの@@", $a0, $1, $0
	db "きみは@@", $a2, $1, $0
	db "きみを@@", $a4, $1, $0
	db "ギャル@@", $ae, $1, $0
	db "きょうだい", $b2, $1, $0
	db "こども@@", $f0, $1, $0
	db "じぶん@@", $54, $2, $0
	db "じぶんが@", $56, $2, $0
	db "じぶんに@", $58, $2, $0
	db "じぶんの@", $5a, $2, $0
	db "じぶんは@", $5c, $2, $0
	db "じぶんを@", $5e, $2, $0
	db "だれ@@@", $18, $3, $0
	db "だれか@@", $1a, $3, $0
	db "だれが@@", $1c, $3, $0
	db "だれに@@", $1e, $3, $0
	db "だれの@@", $20, $3, $0
	db "だれも@@", $22, $3, $0
	db "だれを@@", $24, $3, $0
	db "ちゃん@@", $38, $3, $0
	db "ともだち@", $b8, $3, $0
	db "なかま@@", $d4, $3, $0
	db "ひと@@@", $62, $4, $0
	db "ボーイ@@", $98, $4, $0
	db "ボク@@@", $a0, $4, $0
	db "ボクが@@", $a2, $4, $0
	db "ボクに@@", $a4, $4, $0
	db "ボクの@@", $a6, $4, $0
	db "ボクは@@", $a8, $4, $0
	db "ボクを@@", $aa, $4, $0
	db "みんな@@", $4, $5, $0
	db "みんなが@", $6, $5, $0
	db "みんなに@", $8, $5, $0
	db "みんなの@", $a, $5, $0
	db "みんなは@", $c, $5, $0
	db "ライバル@", $8a, $5, $0
	db "わたし@@", $c2, $5, $0
	db "わたしが@", $c4, $5, $0
	db "わたしに@", $c6, $5, $0
	db "わたしの@", $c8, $5, $0
	db "わたしは@", $ca, $5, $0
	db "わたしを@", $cc, $5, $0

.Battle:
	db "あいしょう", $18, $0, $0
	db "いけ！@@", $88, $0, $0
	db "いちばん@", $96, $0, $0
	db "かくご@@", $4c, $1, $0
	db "かたせて@", $54, $1, $0
	db "かち@@@", $56, $1, $0
	db "かつ@@@", $58, $1, $0
	db "かった@@", $60, $1, $0
	db "かったら@", $62, $1, $0
	db "かって@@", $64, $1, $0
	db "かてない@", $66, $1, $0
	db "かてる@@", $68, $1, $0
	db "かなわない", $70, $1, $0
	db "きあい@@", $84, $1, $0
	db "きめた@@", $a8, $1, $0
	db "きりふだ@", $b6, $1, $0
	db "くらえ@@", $c2, $1, $0
	db "こい！@@", $da, $1, $0
	db "こうげき@", $e0, $1, $0
	db "こうさん@", $e2, $1, $0
	db "こんじょう", $8, $2, $0
	db "さいのう@", $16, $2, $0
	db "さくせん@", $1a, $2, $0
	db "さばき@@", $22, $2, $0
	db "しょうぶ@", $7e, $2, $0
	db "しょうり@", $80, $2, $0
	db "せめ@@@", $b4, $2, $0
	db "センス@@", $b6, $2, $0
	db "たいせん@", $e6, $2, $0
	db "たたかい@", $f6, $2, $0
	db "ちから@@", $32, $3, $0
	db "チャレンジ", $36, $3, $0
	db "つよい@@", $58, $3, $0
	db "つよすぎ@", $5a, $3, $0
	db "つらい@@", $5c, $3, $0
	db "つらかった", $5e, $3, $0
	db "てかげん@", $6c, $3, $0
	db "てき@@@", $6e, $3, $0
	db "てんさい@", $90, $3, $0
	db "でんせつ@", $94, $3, $0
	db "トレーナー", $c6, $3, $0
	db "にげ@@@", $4, $4, $0
	db "ぬるい@@", $10, $4, $0
	db "ねらう@@", $16, $4, $0
	db "バトル@@", $4a, $4, $0
	db "ファイト@", $72, $4, $0
	db "ふっかつ@", $78, $4, $0
	db "ポイント@", $94, $4, $0
	db "ポケモン@", $ac, $4, $0
	db "ほんき@@", $bc, $4, $0
	db "まいった！", $c4, $4, $0
	db "まけ@@@", $c8, $4, $0
	db "まけたら@", $ca, $4, $0
	db "まけて@@", $cc, $4, $0
	db "まける@@", $ce, $4, $0
	db "まもり@@", $ea, $4, $0
	db "みかた@@", $f2, $4, $0
	db "みとめない", $fe, $4, $0
	db "みとめる@", $0, $5, $0
	db "むてき@@", $16, $5, $0
	db "もらった！", $3c, $5, $0
	db "よゆう@@", $7a, $5, $0
	db "よわい@@", $82, $5, $0
	db "よわすぎ@", $84, $5, $0
	db "らくしょう", $8e, $5, $0
	db "りーダー@", $9e, $5, $0
	db "ルール@@", $a0, $5, $0
	db "レべル@@", $a6, $5, $0
	db "わざ@@@", $be, $5, $0

.Exclamations:
	db "！@@@@", $0, $0, $0
	db "！！@@@", $2, $0, $0
	db "！？@@@", $4, $0, $0
	db "？@@@@", $6, $0, $0
	db "⋯@@@@", $8, $0, $0
	db "⋯！@@@", $a, $0, $0
	db "⋯⋯⋯@@", $c, $0, $0
	db "ー@@@@", $e, $0, $0
	db "ーーー@@", $10, $0, $0
	db "あーあ@@", $14, $0, $0
	db "あーん@@", $16, $0, $0
	db "あははー@", $52, $0, $0
	db "あら@@@", $54, $0, $0
	db "いえ@@@", $72, $0, $0
	db "イエス@@", $74, $0, $0
	db "うう@@@", $ac, $0, $0
	db "うーん@@", $ae, $0, $0
	db "うおー！@", $b0, $0, $0
	db "うおりゃー", $b2, $0, $0
	db "うひょー@", $bc, $0, $0
	db "うふふ@@", $be, $0, $0
	db "うわー@@", $ca, $0, $0
	db "うわーん@", $cc, $0, $0
	db "ええ@@@", $d2, $0, $0
	db "えー@@@", $d4, $0, $0
	db "えーん@@", $d6, $0, $0
	db "えへへ@@", $dc, $0, $0
	db "おいおい@", $e0, $0, $0
	db "おお@@@", $e2, $0, $0
	db "おっと@@", $c, $1, $0
	db "がーん@@", $42, $1, $0
	db "キャー@@", $aa, $1, $0
	db "ギャー@@", $ac, $1, $0
	db "ぐふふふふ", $bc, $1, $0
	db "げっ@@@", $ce, $1, $0
	db "しくしく@", $3e, $2, $0
	db "ちえっ@@", $2e, $3, $0
	db "てへ@@@", $86, $3, $0
	db "ノー@@@", $20, $4, $0
	db "はあー@@", $2a, $4, $0
	db "はい@@@", $30, $4, $0
	db "はっはっは", $48, $4, $0
	db "ひいー@@", $56, $4, $0
	db "ひゃあ@@", $6a, $4, $0
	db "ふっふっふ", $7c, $4, $0
	db "ふにゃ@@", $7e, $4, $0
	db "ププ@@@", $80, $4, $0
	db "ふふん@@", $82, $4, $0
	db "ふん@@@", $88, $4, $0
	db "へっへっへ", $8e, $4, $0
	db "へへー@@", $90, $4, $0
	db "ほーほほほ", $9c, $4, $0
	db "ほら@@@", $b6, $4, $0
	db "まあ@@@", $c0, $4, $0
	db "むきー！！", $10, $5, $0
	db "むふー@@", $18, $5, $0
	db "むふふ@@", $1a, $5, $0
	db "むむ@@@", $1c, $5, $0
	db "よーし@@", $6a, $5, $0
	db "よし！@@", $72, $5, $0
	db "ラララ@@", $98, $5, $0
	db "わーい@@", $ac, $5, $0
	db "わーん！！", $b0, $5, $0
	db "ワオ@@@", $b2, $5, $0
	db "わっ！！@", $ce, $5, $0
	db "わははは！", $d0, $5, $0

.Conversation:
	db "あのね@@", $50, $0, $0
	db "あんまり@", $6e, $0, $0
	db "いじわる@", $8e, $0, $0
	db "うそ@@@", $b6, $0, $0
	db "うむ@@@", $c4, $0, $0
	db "おーい@@", $e4, $0, $0
	db "おすすめ@", $6, $1, $0
	db "おばかさん", $1e, $1, $0
	db "かなり@@", $6e, $1, $0
	db "から@@@", $7a, $1, $0
	db "きぶん@@", $98, $1, $0
	db "けど@@@", $d6, $1, $0
	db "こそ@@@", $ea, $1, $0
	db "こと@@@", $ee, $1, $0
	db "さあ@@@", $12, $2, $0
	db "さっぱり@", $1e, $2, $0
	db "さて@@@", $20, $2, $0
	db "じゅうぶん", $72, $2, $0
	db "すぐ@@@", $94, $2, $0
	db "すごく@@", $98, $2, $0
	db "すこしは@", $9a, $2, $0
	db "すっっごい", $a0, $2, $0
	db "ぜーんぜん", $b0, $2, $0
	db "ぜったい@", $b2, $2, $0
	db "それで@@", $ce, $2, $0
	db "だけ@@@", $f2, $2, $0
	db "だって@@", $fc, $2, $0
	db "たぶん@@", $6, $3, $0
	db "たら@@@", $14, $3, $0
	db "ちょー@@", $3a, $3, $0
	db "ちょっと@", $3c, $3, $0
	db "ったら@@", $4e, $3, $0
	db "って@@@", $50, $3, $0
	db "ていうか@", $62, $3, $0
	db "でも@@@", $88, $3, $0
	db "どうしても", $9c, $3, $0
	db "とうぜん@", $a0, $3, $0
	db "どうぞ@@", $a2, $3, $0
	db "とりあえず", $be, $3, $0
	db "なあ@@@", $cc, $3, $0
	db "なんて@@", $f4, $3, $0
	db "なんでも@", $fc, $3, $0
	db "なんとか@", $fe, $3, $0
	db "には@@@", $8, $4, $0
	db "バッチり@", $46, $4, $0
	db "ばりばり@", $52, $4, $0
	db "ほど@@@", $b0, $4, $0
	db "ほんと@@", $be, $4, $0
	db "まさに@@", $d0, $4, $0
	db "マジ@@@", $d2, $4, $0
	db "マジで@@", $d4, $4, $0
	db "まったく@", $e4, $4, $0
	db "まで@@@", $e6, $4, $0
	db "まるで@@", $ec, $4, $0
	db "ムード@@", $e, $5, $0
	db "むしろ@@", $14, $5, $0
	db "めちゃ@@", $24, $5, $0
	db "めっぽう@", $28, $5, $0
	db "もう@@@", $2c, $5, $0
	db "モード@@", $2e, $5, $0
	db "もっと@@", $36, $5, $0
	db "もはや@@", $38, $5, $0
	db "やっと@@", $4a, $5, $0
	db "やっぱり@", $4c, $5, $0
	db "より@@@", $7c, $5, $0
	db "れば@@@", $a4, $5, $0

.Feelings:
	db "あいたい@", $1a, $0, $0
	db "あそびたい", $32, $0, $0
	db "いきたい@", $7c, $0, $0
	db "うかれて@", $b4, $0, $0
	db "うれしい@", $c6, $0, $0
	db "うれしさ@", $c8, $0, $0
	db "エキサイト", $d8, $0, $0
	db "えらい@@", $de, $0, $0
	db "おかしい@", $ec, $0, $0
	db "オッケー@", $8, $1, $0
	db "かえりたい", $48, $1, $0
	db "がっくし@", $5a, $1, $0
	db "かなしい@", $6c, $1, $0
	db "がんばって", $80, $1, $0
	db "きがしない", $86, $1, $0
	db "きがする@", $88, $1, $0
	db "ききたい@", $8a, $1, $0
	db "きになる@", $90, $1, $0
	db "きのせい@", $96, $1, $0
	db "きらい@@", $b4, $1, $0
	db "くやしい@", $be, $1, $0
	db "くやしさ@", $c0, $1, $0
	db "さみしい@", $24, $2, $0
	db "ざんねん@", $32, $2, $0
	db "しあわせ@", $36, $2, $0
	db "したい@@", $44, $2, $0
	db "したくない", $46, $2, $0
	db "しまった@", $64, $2, $0
	db "しょんぼり", $82, $2, $0
	db "すき@@@", $92, $2, $0
	db "だいきらい", $da, $2, $0
	db "たいくつ@", $dc, $2, $0
	db "だいじ@@", $de, $2, $0
	db "だいすき@", $e4, $2, $0
	db "たいへん@", $ea, $2, $0
	db "たのしい@", $0, $3, $0
	db "たのしすぎ", $2, $3, $0
	db "たべたい@", $8, $3, $0
	db "ダメダメ@", $e, $3, $0
	db "たりない@", $16, $3, $0
	db "ちくしょー", $34, $3, $0
	db "どうしよう", $9e, $3, $0
	db "ドキドキ@", $ac, $3, $0
	db "ナイス@@", $d0, $3, $0
	db "のみたい@", $26, $4, $0
	db "びっくり@", $60, $4, $0
	db "ふあん@@", $74, $4, $0
	db "ふらふら@", $86, $4, $0
	db "ほしい@@", $ae, $4, $0
	db "ボロボロ@", $b8, $4, $0
	db "まだまだ@", $e0, $4, $0
	db "まてない@", $e8, $4, $0
	db "まんぞく@", $f0, $4, $0
	db "みたい@@", $f8, $4, $0
	db "めずらしい", $22, $5, $0
	db "メラメラ@", $2a, $5, $0
	db "やだ@@@", $46, $5, $0
	db "やったー@", $48, $5, $0
	db "やばい@@", $50, $5, $0
	db "やばすぎる", $52, $5, $0
	db "やられた@", $54, $5, $0
	db "やられて@", $56, $5, $0
	db "よかった@", $6e, $5, $0
	db "ラブラブ@", $96, $5, $0
	db "ロマン@@", $a8, $5, $0
	db "ろんがい@", $aa, $5, $0
	db "わから@@", $b4, $5, $0
	db "わかり@@", $b6, $5, $0
	db "わくわく@", $ba, $5, $0

.Conditions:
	db "あつい@@", $38, $0, $0
	db "あった@@", $3a, $0, $0
	db "あり@@@", $56, $0, $0
	db "ある@@@", $5e, $0, $0
	db "あわてて@", $6a, $0, $0
	db "いい@@@", $70, $0, $0
	db "いか@@@", $76, $0, $0
	db "イカス@@", $78, $0, $0
	db "いきおい@", $7a, $0, $0
	db "いける@@", $8a, $0, $0
	db "いじょう@", $8c, $0, $0
	db "いそがしい", $90, $0, $0
	db "いっしょに", $9a, $0, $0
	db "いっぱい@", $9c, $0, $0
	db "いない@@", $a0, $0, $0
	db "いや@@@", $a4, $0, $0
	db "いる@@@", $a8, $0, $0
	db "うまい@@", $c0, $0, $0
	db "うまく@@", $c2, $0, $0
	db "おおきい@", $e6, $0, $0
	db "おくれ@@", $f2, $0, $0
	db "おしい@@", $fa, $0, $0
	db "おもしろい", $2c, $1, $0
	db "おもしろく", $2e, $1, $0
	db "かっこいい", $5c, $1, $0
	db "かわいい@", $7e, $1, $0
	db "かんぺき@", $82, $1, $0
	db "けっこう@", $d0, $1, $0
	db "げんき@@", $d8, $1, $0
	db "こわい@@", $6, $2, $0
	db "さいこう@", $14, $2, $0
	db "さむい@@", $26, $2, $0
	db "さわやか@", $2c, $2, $0
	db "しかたない", $38, $2, $0
	db "すごい@@", $96, $2, $0
	db "すごすぎ@", $9c, $2, $0
	db "すてき@@", $a4, $2, $0
	db "たいした@", $e0, $2, $0
	db "だいじょぶ", $e2, $2, $0
	db "たかい@@", $ec, $2, $0
	db "ただしい@", $f8, $2, $0
	db "だめ@@@", $c, $3, $0
	db "ちいさい@", $2c, $3, $0
	db "ちがう@@", $30, $3, $0
	db "つかれ@@", $48, $3, $0
	db "とくい@@", $b0, $3, $0
	db "とまらない", $b6, $3, $0
	db "ない@@@", $ce, $3, $0
	db "なかった@", $d2, $3, $0
	db "なし@@@", $d8, $3, $0
	db "なって@@", $dc, $3, $0
	db "はやい@@", $50, $4, $0
	db "ひかる@@", $5a, $4, $0
	db "ひくい@@", $5c, $4, $0
	db "ひどい@@", $64, $4, $0
	db "ひとりで@", $66, $4, $0
	db "ひま@@@", $68, $4, $0
	db "ふそく@@", $76, $4, $0
	db "へた@@@", $8c, $4, $0
	db "まちがって", $e2, $4, $0
	db "やさしい@", $42, $5, $0
	db "よく@@@", $70, $5, $0
	db "よわって@", $86, $5, $0
	db "らく@@@", $8c, $5, $0
	db "らしい@@", $90, $5, $0
	db "わるい@@", $d4, $5, $0

.Life:
	db "アルバイト", $64, $0, $0
	db "うち@@@", $ba, $0, $0
	db "おかね@@", $ee, $0, $0
	db "おこづかい", $f4, $0, $0
	db "おふろ@@", $24, $1, $0
	db "がっこう@", $5e, $1, $0
	db "きねん@@", $92, $1, $0
	db "グループ@", $c6, $1, $0
	db "ゲット@@", $d2, $1, $0
	db "こうかん@", $de, $1, $0
	db "しごと@@", $40, $2, $0
	db "しゅぎょう", $74, $2, $0
	db "じゅぎょう", $76, $2, $0
	db "じゅく@@", $78, $2, $0
	db "しんか@@", $88, $2, $0
	db "ずかん@@", $90, $2, $0
	db "せいかつ@", $ae, $2, $0
	db "せんせい@", $b8, $2, $0
	db "センター@", $ba, $2, $0
	db "タワー@@", $28, $3, $0
	db "つうしん@", $40, $3, $0
	db "テスト@@", $7e, $3, $0
	db "テレビ@@", $8c, $3, $0
	db "でんわ@@", $96, $3, $0
	db "どうぐ@@", $9a, $3, $0
	db "トレード@", $c4, $3, $0
	db "なまえ@@", $e8, $3, $0
	db "ニュース@", $a, $4, $0
	db "にんき@@", $c, $4, $0
	db "パーティー", $2e, $4, $0
	db "べんきょう", $92, $4, $0
	db "マシン@@", $d6, $4, $0
	db "めいし@@", $1e, $5, $0
	db "メッセージ", $26, $5, $0
	db "もようがえ", $3a, $5, $0
	db "ゆめ@@@", $5a, $5, $0
	db "ようちえん", $66, $5, $0
	db "ラジオ@@", $92, $5, $0
	db "ワールド@", $ae, $5, $0

.Hobbies:
	db "アイドル@", $1e, $0, $0
	db "アニメ@@", $4c, $0, $0
	db "うた@@@", $b8, $0, $0
	db "えいが@@", $d0, $0, $0
	db "おかし@@", $ea, $0, $0
	db "おしゃべり", $4, $1, $0
	db "おままごと", $28, $1, $0
	db "おもちゃ@", $30, $1, $0
	db "おんがく@", $38, $1, $0
	db "カード@@", $3e, $1, $0
	db "かいもの@", $46, $1, $0
	db "グルメ@@", $c8, $1, $0
	db "ゲーム@@", $cc, $1, $0
	db "ざっし@@", $1c, $2, $0
	db "さんぽ@@", $34, $2, $0
	db "じてんしゃ", $50, $2, $0
	db "しゅみ@@", $7a, $2, $0
	db "スポーツ@", $a8, $2, $0
	db "ダイエット", $d8, $2, $0
	db "たからもの", $f0, $2, $0
	db "たび@@@", $4, $3, $0
	db "ダンス@@", $2a, $3, $0
	db "つり@@@", $60, $3, $0
	db "デート@@", $6a, $3, $0
	db "でんしゃ@", $92, $3, $0
	db "ぬいぐるみ", $e, $4, $0
	db "パソコン@", $3e, $4, $0
	db "はな@@@", $4c, $4, $0
	db "ヒーロー@", $58, $4, $0
	db "ひるね@@", $6e, $4, $0
	db "ヒロイン@", $70, $4, $0
	db "ぼうけん@", $96, $4, $0
	db "ボード@@", $9a, $4, $0
	db "ボール@@", $9e, $4, $0
	db "ほん@@@", $ba, $4, $0
	db "マンガ@@", $ee, $4, $0
	db "やくそく@", $40, $5, $0
	db "やすみ@@", $44, $5, $0
	db "よてい@@", $74, $5, $0

.Actions:
	db "あう@@@", $20, $0, $0
	db "あきらめ@", $24, $0, $0
	db "あげる@@", $28, $0, $0
	db "あせる@@", $2e, $0, $0
	db "あそび@@", $30, $0, $0
	db "あそぶ@@", $34, $0, $0
	db "あつめ@@", $3e, $0, $0
	db "あるき@@", $60, $0, $0
	db "あるく@@", $62, $0, $0
	db "いく@@@", $7e, $0, $0
	db "いけ@@@", $86, $0, $0
	db "おき@@@", $f0, $0, $0
	db "おこり@@", $f6, $0, $0
	db "おこる@@", $f8, $0, $0
	db "おしえ@@", $fe, $0, $0
	db "おしえて@", $0, $1, $0
	db "おねがい@", $1a, $1, $0
	db "おぼえ@@", $26, $1, $0
	db "かえる@@", $4a, $1, $0
	db "がまん@@", $74, $1, $0
	db "きく@@@", $8c, $1, $0
	db "きたえ@@", $8e, $1, $0
	db "きめ@@@", $a6, $1, $0
	db "くる@@@", $c4, $1, $0
	db "さがし@@", $18, $2, $0
	db "さわぎ@@", $2a, $2, $0
	db "した@@@", $42, $2, $0
	db "しって@@", $4a, $2, $0
	db "して@@@", $4e, $2, $0
	db "しない@@", $52, $2, $0
	db "しまう@@", $60, $2, $0
	db "じまん@@", $66, $2, $0
	db "しらない@", $84, $2, $0
	db "しる@@@", $86, $2, $0
	db "しんじて@", $8a, $2, $0
	db "する@@@", $aa, $2, $0
	db "たべる@@", $a, $3, $0
	db "つかう@@", $42, $3, $0
	db "つかえ@@", $44, $3, $0
	db "つかって@", $46, $3, $0
	db "できない@", $70, $3, $0
	db "できる@@", $72, $3, $0
	db "でない@@", $84, $3, $0
	db "でる@@@", $8a, $3, $0
	db "なげる@@", $d6, $3, $0
	db "なやみ@@", $ea, $3, $0
	db "ねられ@@", $18, $4, $0
	db "ねる@@@", $1a, $4, $0
	db "のがし@@", $24, $4, $0
	db "のむ@@@", $28, $4, $0
	db "はしり@@", $3a, $4, $0
	db "はしる@@", $3c, $4, $0
	db "はたらき@", $40, $4, $0
	db "はたらく@", $42, $4, $0
	db "はまって@", $4e, $4, $0
	db "ぶつけ@@", $7a, $4, $0
	db "ほめ@@@", $b4, $4, $0
	db "みせて@@", $f6, $4, $0
	db "みて@@@", $fc, $4, $0
	db "みる@@@", $2, $5, $0
	db "めざす@@", $20, $5, $0
	db "もって@@", $34, $5, $0
	db "ゆずる@@", $58, $5, $0
	db "ゆるす@@", $5c, $5, $0
	db "ゆるせ@@", $5e, $5, $0
	db "られない@", $9a, $5, $0
	db "られる@@", $9c, $5, $0
	db "わかる@@", $b8, $5, $0
	db "わすれ@@", $c0, $5, $0

.Time:
	db "あき@@@", $22, $0, $0
	db "あさ@@@", $2a, $0, $0
	db "あした@@", $2c, $0, $0
	db "いちにち@", $94, $0, $0
	db "いつか@@", $98, $0, $0
	db "いつも@@", $9e, $0, $0
	db "いま@@@", $a2, $0, $0
	db "えいえん@", $ce, $0, $0
	db "おととい@", $12, $1, $0
	db "おわり@@", $36, $1, $0
	db "かようび@", $78, $1, $0
	db "きのう@@", $94, $1, $0
	db "きょう@@", $b0, $1, $0
	db "きんようび", $b8, $1, $0
	db "げつようび", $d4, $1, $0
	db "このあと@", $f4, $1, $0
	db "このまえ@", $f6, $1, $0
	db "こんど@@", $c, $2, $0
	db "じかん@@", $3c, $2, $0
	db "じゅうねん", $70, $2, $0
	db "すいようび", $8e, $2, $0
	db "スタート@", $9e, $2, $0
	db "ずっと@@", $a2, $2, $0
	db "ストップ@", $a6, $2, $0
	db "そのうち@", $c4, $2, $0
	db "ついに@@", $3e, $3, $0
	db "つぎ@@@", $4a, $3, $0
	db "どようび@", $ba, $3, $0
	db "なつ@@@", $da, $3, $0
	db "にちようび", $6, $4, $0
	db "はじめ@@", $38, $4, $0
	db "はる@@@", $54, $4, $0
	db "ひる@@@", $6c, $4, $0
	db "ふゆ@@@", $84, $4, $0
	db "まいにち@", $c6, $4, $0
	db "もくようび", $30, $5, $0
	db "よなか@@", $76, $5, $0
	db "よる@@@", $7e, $5, $0
	db "らいしゅう", $88, $5, $0

.Farewells:
	db "いたします", $92, $0, $0
	db "おります@", $32, $1, $0
	db "か！？@@", $3c, $1, $0
	db "かい？@@", $44, $1, $0
	db "かしら？@", $50, $1, $0
	db "かな？@@", $6a, $1, $0
	db "かも@@@", $76, $1, $0
	db "くれ@@@", $ca, $1, $0
	db "ございます", $e8, $1, $0
	db "しがち@@", $3a, $2, $0
	db "します@@", $62, $2, $0
	db "じゃ@@@", $6a, $2, $0
	db "じゃん@@", $6e, $2, $0
	db "しよう@@", $7c, $2, $0
	db "ぜ！@@@", $ac, $2, $0
	db "ぞ！@@@", $bc, $2, $0
	db "た@@@@", $d4, $2, $0
	db "だ@@@@", $d6, $2, $0
	db "だからね@", $ee, $2, $0
	db "だぜ@@@", $f4, $2, $0
	db "だった@@", $fa, $2, $0
	db "だね@@@", $fe, $2, $0
	db "だよ@@@", $10, $3, $0
	db "だよねー！", $12, $3, $0
	db "だわ@@@", $26, $3, $0
	db "ッス@@@", $4c, $3, $0
	db "ってかんじ", $52, $3, $0
	db "っぱなし@", $54, $3, $0
	db "つもり@@", $56, $3, $0
	db "ていない@", $64, $3, $0
	db "ている@@", $66, $3, $0
	db "でーす！@", $68, $3, $0
	db "でした@@", $74, $3, $0
	db "でしょ？@", $76, $3, $0
	db "でしょー！", $78, $3, $0
	db "です@@@", $7a, $3, $0
	db "ですか？@", $7c, $3, $0
	db "ですよ@@", $80, $3, $0
	db "ですわ@@", $82, $3, $0
	db "どうなの？", $a4, $3, $0
	db "どうよ？@", $a8, $3, $0
	db "とかいって", $aa, $3, $0
	db "なの@@@", $e0, $3, $0
	db "なのか@@", $e2, $3, $0
	db "なのだ@@", $e4, $3, $0
	db "なのよ@@", $e6, $3, $0
	db "なんだね@", $f2, $3, $0
	db "なんです@", $f8, $3, $0
	db "なんてね@", $fa, $3, $0
	db "ね@@@@", $12, $4, $0
	db "ねー@@@", $14, $4, $0
	db "の@@@@", $1c, $4, $0
	db "の？@@@", $1e, $4, $0
	db "ばっかり@", $44, $4, $0
	db "まーす！@", $c2, $4, $0
	db "ます@@@", $d8, $4, $0
	db "ますわ@@", $da, $4, $0
	db "ません@@", $dc, $4, $0
	db "みたいな@", $fa, $4, $0
	db "よ！@@@", $60, $5, $0
	db "よー@@@", $68, $5, $0
	db "よーん@@", $6c, $5, $0
	db "よね@@@", $78, $5, $0
	db "るよ@@@", $a2, $5, $0
	db "わけ@@@", $bc, $5, $0
	db "わよ！@@", $d2, $5, $0

.ThisAndThat:
	db "ああ@@@", $12, $0, $0
	db "あっち@@", $3c, $0, $0
	db "あの@@@", $4e, $0, $0
	db "ありゃ@@", $5c, $0, $0
	db "あれ@@@", $66, $0, $0
	db "あれは@@", $68, $0, $0
	db "あんな@@", $6c, $0, $0
	db "こう@@@", $dc, $1, $0
	db "こっち@@", $ec, $1, $0
	db "この@@@", $f2, $1, $0
	db "こりゃ@@", $fe, $1, $0
	db "これ@@@", $0, $2, $0
	db "これだ！@", $2, $2, $0
	db "これは@@", $4, $2, $0
	db "こんな@@", $e, $2, $0
	db "そう@@@", $be, $2, $0
	db "そっち@@", $c0, $2, $0
	db "その@@@", $c2, $2, $0
	db "そりゃ@@", $c6, $2, $0
	db "それ@@@", $c8, $2, $0
	db "それだ！@", $cc, $2, $0
	db "それは@@", $d0, $2, $0
	db "そんな@@", $d2, $2, $0
	db "どう@@@", $98, $3, $0
	db "どっち@@", $b2, $3, $0
	db "どの@@@", $b4, $3, $0
	db "どりゃ@@", $c0, $3, $0
	db "どれ@@@", $c2, $3, $0
	db "どれを@@", $c8, $3, $0
	db "どんな@@", $ca, $3, $0
	db "なに@@@", $de, $3, $0
	db "なんか@@", $ec, $3, $0
	db "なんだ@@", $f0, $3, $0
	db "なんで@@", $f6, $3, $0
	db "なんなんだ", $0, $4, $0
	db "なんの@@", $2, $4, $0
