DrawPlayerHP:
	ld a, $1
	jr DrawHP

DrawEnemyHP:
	ld a, $2

DrawHP:
	ld [wWhichHPBar], a
	push hl
	push bc
	; box mons have full HP
	ld a, [wMonType]
	cp BOXMON
	jr z, .at_least_1_hp

	ld a, [wTempMonHP]
	ld b, a
	ld a, [wTempMonHP + 1]
	ld c, a

; Any HP?
	or b
	jr nz, .at_least_1_hp

	xor a
	ld c, a
	ld e, a
	ld a, 6
	ld d, a
	jr .fainted

.at_least_1_hp
	ld a, [wTempMonMaxHP]
	ld d, a
	ld a, [wTempMonMaxHP + 1]
	ld e, a
	ld a, [wMonType]
	cp BOXMON
	jr nz, .not_boxmon

	ld b, d
	ld c, e

.not_boxmon
	predef ComputeHPBarPixels
	ld a, 6
	ld d, a
	ld c, a

.fainted
	ld a, c
	pop bc
	ld c, a
	pop hl
	push de
	push hl
	push hl
	call DrawBattleHPBar
	pop hl

; Print HP
	bccoord 1, 1, 0
	add hl, bc
	ld de, wTempMonHP
	ld a, [wMonType]
	cp BOXMON
	jr nz, .not_boxmon_2
	ld de, wTempMonMaxHP
.not_boxmon_2
	lb bc, 2, 3
	call PrintNum

	ld a, "/"
	ld [hli], a

; Print max HP
	ld de, wTempMonMaxHP
	lb bc, 2, 3
	call PrintNum
	pop hl
	pop de
	ret

SaveLevelUpOldStats::
; hl = a party mon's MON_MAXHP, before a level-up changes its stats. Keep
; the low byte of each stat (HP, Atk, Def, Spe, SpA, SpD) for
; PrintTempMonLevelUpStats: a level-up's gain fits in a byte.
; Preserves all registers.
	push hl
	push de
	push bc
	push af
	ld de, wLevelUpOldStats
	ld b, NUM_STATS
.loop
	inc hl
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .loop
	jmp PopAFBCDEHL

; scratch for PrintTempMonLevelUpStats
DEF LVUP_OLD_STAT  EQUS "wStringBuffer3"     ; dw, big-endian
DEF LVUP_GAIN      EQUS "wStringBuffer3 + 2" ; db
DEF LVUP_GAIN_LEN  EQUS "wStringBuffer3 + 3" ; db: "+" and its digits
DEF LVUP_SHOW_GAIN EQUS "wStringBuffer3 + 4" ; db

	assert wTempMonSpclDef - wTempMonMaxHP == (NUM_STATS - 1) * 2, \
		"wTempMon's stats must be MaxHP, Atk, Def, Spe, SpA, SpD"

PrintTempMonLevelUpStats:
; After a level-up (wTempMon = the mon now, wLevelUpOldStats from
; SaveLevelUpOldStats), as in Polished Crystal: a box with each stat's
; old value and its gain, then one with the new values. Each waits for
; A or B.
; The gain column is as wide as the largest gain needs.
	lb bc, 2, 0 ; b = width ("+" and 1 digit), c = stat
.width_loop
	call .GetGain
	ld d, 2
	cp 10
	jr c, .got_width
	inc d
	cp 100
	jr c, .got_width
	inc d
.got_width
	ld a, d
	cp b
	jr c, .not_wider
	ld b, a
.not_wider
	inc c
	ld a, c
	cp NUM_STATS
	jr nz, .width_loop
	ld a, b
	ld [LVUP_GAIN_LEN], a

	ld a, TRUE
	call .Page
	xor a ; FALSE
	; fallthrough

.Page:
; a: TRUE = old values and gains, FALSE = new values
	ld [LVUP_SHOW_GAIN], a
; the box: rows 4-11, from column 6 - width to the right edge
	hlcoord 6, 4
	call .LeftByGainLen
	ld b, 6
	ld a, [LVUP_GAIN_LEN]
	add 12
	ld c, a
	call Textbox
	hlcoord 7, 5
	call .LeftByGainLen
	ld de, .Names
	ld bc, .Order
.row
	push bc
	call PlaceString ; keeps hl, leaves de at the "@"
	inc de
	pop bc
	push de
	push hl
	push bc
	ld a, [bc]
	ld c, a
	call .GetGain
	ld de, 9
	add hl, de ; the value column
	ld a, [LVUP_SHOW_GAIN]
	and a
	jr z, .new_value
	push hl
	ld de, LVUP_OLD_STAT
	lb bc, 2, 3
	call PrintNum
	pop hl
	inc hl
	inc hl
	inc hl
	ld [hl], "<+>"
	inc hl
	ld a, [LVUP_GAIN_LEN]
	dec a
	ld c, a
	dec a
	jr z, .one_digit ; (PrintNum misplaces a lone digit)
	ld b, 1
	ld de, LVUP_GAIN
	call PrintNum
	jr .next_row

.one_digit
	ld a, [LVUP_GAIN]
	add "0"
	ld [hl], a
	jr .next_row

.new_value
	ld b, 0
	push hl
	ld hl, wTempMonMaxHP
	add hl, bc
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	lb bc, 2, 3
	call PrintNum

.next_row
	pop bc
	pop hl
	pop de
	inc bc
	push bc
	ld bc, SCREEN_WIDTH
	add hl, bc
	pop bc
	ld a, [bc]
	cp -1
	jr nz, .row
	jmp WaitPressAorB_BlinkCursor

.LeftByGainLen:
; hl -= [LVUP_GAIN_LEN]
	ld a, [LVUP_GAIN_LEN]
	cpl
	inc a
	add l
	ld l, a
	ret c
	dec h
	ret

.GetGain:
; c = stat (MaxHP, Atk, Def, Spe, SpA, SpD). Returns its gain in a and
; LVUP_GAIN, and its old value in LVUP_OLD_STAT. Preserves bc, de, hl.
	push hl
	push de
	push bc
	ld b, 0
	ld hl, wLevelUpOldStats
	add hl, bc
	ld e, [hl]
	ld hl, wTempMonMaxHP
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld d, a
	ld a, [hl]
	sub e
	ld b, a ; gain
	ld a, [hl]
	sub b
	ld [LVUP_OLD_STAT + 1], a
	ld a, d
	sbc 0
	ld [LVUP_OLD_STAT], a
	ld a, b
	ld [LVUP_GAIN], a
	pop bc
	pop de
	pop hl
	ret

.Order:
; shown in this order
	db 0, 1, 2, 4, 5, 3, -1

.Names:
	db "Health@"
	db "Attack@"
	db "Defense@"
	db "Sp.Atk@"
	db "Sp.Def@"
	db "Speed@"

PrintTempMonStats:
; Print wTempMon's stats at hl, with spacing bc.
	push bc
	push hl
	ld de, .StatNames
	call PlaceString
	pop hl
	pop bc
	add hl, bc
	ld bc, SCREEN_WIDTH
	add hl, bc
	ld de, wTempMonAttack
	lb bc, 2, 3
	call .PrintStat
	ld de, wTempMonDefense
	call .PrintStat
	ld de, wTempMonSpclAtk
	call .PrintStat
	ld de, wTempMonSpclDef
	call .PrintStat
	ld de, wTempMonSpeed
	jmp PrintNum

.PrintStat:
	push hl
	call PrintNum
	pop hl
	ld de, SCREEN_WIDTH * 2
	add hl, de
	ret

.StatNames:
	db   "Attack"
	next "Defense"
	next "Spcl.Atk"
	next "Spcl.Def"
	next "Speed"
	next "@"

GetGender:
; Return the gender of a given monster (wCurPartyMon/wCurOTMon/wCurWildMon).
; When calling this function, a should be set to an appropriate wMonType value.

; return values:
; a = 1: f = nc|nz; male
; a = 0: f = nc|z;  female
;        f = c:  genderless

; Gender comes from the top bit of the Attack DV. The species' gender
; ratio no longer skews the odds, so every gendered species has an even
; chance of being male or female.

; Figure out what type of monster struct we're looking at.

; 0: PartyMon
	ld hl, wPartyMon1DVs
	ld bc, PARTYMON_STRUCT_LENGTH
	ld a, [wMonType]
	and a
	jr z, .PartyMon

	ld hl, wBufferMonDVs
	cp BUFFERMON
	jr z, .DVs

; 1: OTPartyMon
	ld hl, wOTPartyMon1DVs
	dec a
	jr z, .PartyMon

; 2: sBoxMon
	dec a
	jr z, .sBoxMon

; 3: Unknown
	ld hl, wTempMonDVs
	dec a
	jr z, .DVs

; else: WildMon
	ld hl, wEnemyMonDVs
	jr .DVs

; Get our place in the party/box.

.sBoxMon:
	; old box code access; crash
	di
	jr @

.PartyMon:
	ld a, [wCurPartyMon]
	call AddNTimes

.DVs:
; Base data is only needed to tell genderless species apart; the ratio
; itself is ignored.
	push hl
	ld a, [wCurPartySpecies]
	dec a
	ld hl, BaseData + BASE_GENDER
	ld bc, BASE_DATA_SIZE
	call AddNTimes
	ld a, BANK(BaseData)
	call GetFarByte
	pop hl

	cp GENDER_UNKNOWN
	jr z, .Genderless

; Certain species are always one gender, regardless of the Attack DV bit.
	ld a, [wCurPartySpecies]
; always female
	cp MILTANK
	jr z, .AlwaysFemale
	cp CHANSEY
	jr z, .AlwaysFemale
	cp BLISSEY
	jr z, .AlwaysFemale
	cp JYNX
	jr z, .AlwaysFemale
; always male
	cp NIDOKING
	jr z, .AlwaysMale
	cp TAUROS
	jr z, .AlwaysMale
	cp MR__MIME
	jr z, .AlwaysMale

; The Attack DV's top bit picks the gender: clear = male, set = female.
; DVs are rolled at random when the mon is created, so this is an even
; chance either way, and it stays fixed for the life of that mon (and is
; inherited by its offspring through the usual DV halving).
	ld a, [hl]
	and $80
	jr z, .Male

.AlwaysFemale:
.Female:
	xor a
	ret

.AlwaysMale:
.Male:
	ld a, 1
	and a
	ret

.Genderless:
	scf
	ret

ListMovePP:
	ld a, [wNumMoves]
	inc a
	ld c, a
	ld a, NUM_MOVES
	sub c
	ld b, a
	push hl
	ld a, [wListMovesLineSpacing]
	ld e, a
	ld d, 0
	ld a, $3e ; P
	call .load_loop
	ld a, b
	and a
	jr z, .skip
	ld c, a
	ld a, "-"
	call .load_loop

.skip
	pop hl
	inc hl
	inc hl
	inc hl
	ld d, h
	ld e, l
	ld hl, wTempMonMoves
	ld b, 0
.loop
	ld a, [hli]
	and a
	jr z, .done
	push bc
	push hl
	push de
	ld hl, wMenuCursorY
	ld a, [hl]
	push af
	ld [hl], b
	push hl
	callfar GetMaxPPOfMove
	pop hl
	pop af
	ld [hl], a
	pop de
	pop hl
	push hl
	ld bc, wTempMonPP - (wTempMonMoves + 1)
	add hl, bc
	ld a, [hl]
	and $3f
	ld [wStringBuffer1 + 4], a
	ld h, d
	ld l, e
	push hl
	ld de, wStringBuffer1 + 4
	lb bc, 1, 2
	call PrintNum
	ld a, "/"
	ld [hli], a
	ld de, wTempPP
	lb bc, 1, 2
	call PrintNum
	pop hl
	ld a, [wListMovesLineSpacing]
	ld e, a
	ld d, 0
	add hl, de
	ld d, h
	ld e, l
	pop hl
	pop bc
	inc b
	ld a, b
	cp NUM_MOVES
	jr nz, .loop

.done
	ret

.load_loop
	ld [hli], a
	ld [hld], a
	add hl, de
	dec c
	jr nz, .load_loop
	ret

PlaceStatusString:
; Return nz if the status is not OK
	push de
	inc de
	inc de
	ld a, [de]
	ld b, a
	inc de
	ld a, [de]
	or b
	pop de
	ld bc, $00FF ; Should always be a 0
	jr nz, PlaceNonFaintStatus
	push de
	ld de, FntString
	call CopyStatusString
	pop de
	ld a, TRUE
	and a
	ret

FntString:
	db "FNT@"

CopyStatusString:
	ld a, [de]
	inc de
	ld [hli], a
	ld a, [de]
	inc de
	ld [hli], a
	ld a, [de]
	ld [hl], a
	ret

PlaceNonFaintStatus:
	push de
	ld a, [de]
	ld de, PsnString
	bit PSN, a
	jr nz, .placepsn
	ld de, BrnString
	bit BRN, a
	jr nz, .place
	ld de, FrbString
	bit FRZ, a
	jr nz, .place
	ld de, ParString
	bit PAR, a
	jr nz, .place
	ld de, SlpString
	and SLP_MASK
	jr z, .no_status

.place
	call CopyStatusString
	ld a, TRUE
	and a

.no_status
	pop de
	ret

.placepsn
	ld a, [bc]
	bit SUBSTATUS_TOXIC, a
	jr z, .place
	ld de, ToxString
	jr .place

SlpString: db "SLP@"
PsnString: db "PSN@"
BrnString: db "BRN@"
FrbString: db "FRB@"
ParString: db "PAR@"
ToxString: db "TOX@"

ListMoves:
; List moves at hl, spaced every [wListMovesLineSpacing] tiles.
	ld de, wListMoves_MoveIndicesBuffer
	ld b, 0
.moves_loop
	ld a, [de]
	inc de
	and a
	jr z, .no_more_moves
	push de
	push hl
	push hl
	ld [wCurSpecies], a
	ld a, MOVE_NAME
	ld [wNamedObjectType], a
	call GetName
	ld de, wStringBuffer1
	pop hl
	push bc
	call PlaceString
	pop bc
	ld a, b
	ld [wNumMoves], a
	inc b
	pop hl
	push bc
	ld a, [wListMovesLineSpacing]
	ld c, a
	ld b, 0
	add hl, bc
	pop bc
	pop de
	ld a, b
	cp NUM_MOVES
	jr z, .done
	jr .moves_loop

.no_more_moves
	ld a, b
.nonmove_loop
	push af
	ld [hl], "-"
	ld a, [wListMovesLineSpacing]
	ld c, a
	ld b, 0
	add hl, bc
	pop af
	inc a
	cp NUM_MOVES
	jr nz, .nonmove_loop

.done
	ret

GetMonTypeIndex:
 ; type in c, because farcall clobbers a
 	ld a, c
 	; Skip Bird
 	cp BIRD
 	jr c, .done
 	cp UNUSED_TYPES
 	dec a
 	jr c, .done
 	sub UNUSED_TYPES
 .done
 	ld c, a
 	ret
