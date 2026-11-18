LoadQuestionMarkPic:
	ld hl, .QuestionMarkLZ
	ld de, sScratch
	jmp Decompress

.QuestionMarkLZ:
INCBIN "gfx/pokedex/question_mark.2bpp.lzp"

DrawPokedexSearchResultsWindow:
	ld a, $34
	hlcoord 0, 0
	ld bc, 11
	call ByteFill
	ld a, $39
	hlcoord 0, 10
	ld bc, 11
	call ByteFill
	hlcoord 5, 0
	ld [hl], $3f
	hlcoord 5, 10
	ld [hl], $40
	hlcoord 11, 0
	ld [hl], $66
	ld a, $67
	hlcoord 11, 1
	ld b, SCREEN_HEIGHT / 2
	call Pokedex_FillColumn2
	ld [hl], $68
	ld a, $34
	hlcoord 0, 11
	ld bc, 11
	call ByteFill
	ld a, $39
	hlcoord 0, 17
	ld bc, 11
	call ByteFill
	hlcoord 11, 11
	ld [hl], $66
	ld a, $67
	hlcoord 11, 12
	ld b, 5
	call Pokedex_FillColumn2
	ld [hl], $68
	hlcoord 0, 12
	lb bc, 5, 11
	call ClearBox
	ld a, [wDexConvertedMonType]
	cp $ff
	ld de, .ResultsSuffix
	jr nz, .got_title_suffix
	ld de, wStringBuffer3
.got_title_suffix
	hlcoord 0, 12
	call PlaceString
	ld de, .FoundSuffix
	hlcoord 0, 16
	jmp PlaceString

.ResultsSuffix
	db "esults@"

.FoundSuffix
	db "d@"

DrawDexEntryScreenRightEdge:
	ldh a, [hBGMapAddress]
	ld l, a
	ldh a, [hBGMapAddress + 1]
	ld h, a
	push hl
	inc hl
	ld a, l
	ldh [hBGMapAddress], a
	ld a, h
	ldh [hBGMapAddress + 1], a
	hlcoord 19, 0
	ld [hl], $66
	hlcoord 19, 1
	ld a, $67
	ld b, 15
	call Pokedex_FillColumn2
	ld [hl], $68
	hlcoord 19, 17
	ld [hl], $3c
	xor a
	ld b, SCREEN_HEIGHT
	hlcoord 19, 0, wAttrmap
	call Pokedex_FillColumn2
	ld b, 3 ; tiles and attributes at once
	farcall _SafeCopyTilemapAtOnce
	pop hl
	ld a, l
	ldh [hBGMapAddress], a
	ld a, h
	ldh [hBGMapAddress + 1], a
	ret

DrawDexEntryScreenRightEdge_Evo:
 	ldh a, [hBGMapAddress]
 	ld l, a
 	ldh a, [hBGMapAddress + 1]
 	ld h, a
 	push hl
 	inc hl
 	ld a, l
 	ldh [hBGMapAddress], a
 	ld a, h
 	ldh [hBGMapAddress + 1], a
 	hlcoord 19, 0
 	ld [hl], $66
 	hlcoord 19, 1
 	ld a, $67
 	ld b, 16
 	call Pokedex_FillColumn2
 	; ld [hl], $68
 	hlcoord 19, 17
 	ld [hl], $68
 	xor a
 	ld b, SCREEN_HEIGHT
 	hlcoord 19, 0, wAttrmap
 	call Pokedex_FillColumn2
 
 	; ld b, SCGB_POKEDEX_EVO
 	; call GetSGBLayout
 
 	ld b, 3 ; tiles and attributes at once
	farcall _SafeCopyTilemapAtOnce
 	pop hl
 	ld a, l
 	ldh [hBGMapAddress], a
 	ld a, h
 	ldh [hBGMapAddress + 1], a
 	ret

Pokedex_FillColumn2:
; A local duplicate of Pokedex_FillColumn.
	push de
	ld de, SCREEN_WIDTH
.loop
	ld [hl], a
	add hl, de
	dec b
	jr nz, .loop
	pop de
	ret
