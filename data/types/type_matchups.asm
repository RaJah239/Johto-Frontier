; Type charts. Each list is read in order by the fallback scan (and by the
; Foresight section); type_matchup also records every entry so that the
; matrices at the end of this file can be built: for each chart, one 32x32
; table of multipliers (EFFECTIVE where the chart has no entry) and one of
; the entries' positions in the list ($ff where none), which
; StabTypeScan needs to apply two matchups in the list's order (the order
; changes how the damage rounds).

MACRO type_matchup
; attacker, defender, multiplier
	db \1, \2, \3
	if _tm_regular
		assert !DEF(_TM{d:_tm_chart}_{d:\1}_{d:\2}), "duplicate type matchup \1 vs \2"
		assert _tm_index < $ff, "too many type matchups in one chart"
		DEF _TM{d:_tm_chart}_{d:\1}_{d:\2} EQU (\3) | (_tm_index << 8)
		DEF _tm_index += 1
	endc
ENDM

MACRO type_matrices
; chart number: multipliers, then list positions, 32 x 32 each
	for _ta, 32
		for _td, 32
			if DEF(_TM\1_{d:_ta}_{d:_td})
				db LOW(_TM\1_{d:_ta}_{d:_td})
			else
				db EFFECTIVE
			endc
		endr
	endr
	for _ta, 32
		for _td, 32
			if DEF(_TM\1_{d:_ta}_{d:_td})
				db HIGH(_TM\1_{d:_ta}_{d:_td})
			else
				db $ff
			endc
		endr
	endr
ENDM

; Chart descriptors (see GetTypeChart): the high byte of the multiplier
; matrix (0 = no entries; the position matrix follows it 4 pages later),
; the Foresight list (Ghost immunities, read only when they apply), and
; the whole list for the fallback scan.
TypeChart_Normal::
	db HIGH(TypeMatrix_Normal)
	dw TypeMatchupsForesight, TypeMatchups
TypeChart_Inverse::
	db HIGH(TypeMatrix_Inverse)
	dw NoTypeMatchups, InverseTypeMatchups
TypeChart_None::
	db 0
	dw NoTypeMatchups, NoTypeMatchups

DEF _tm_chart = 0
DEF _tm_index = 0
DEF _tm_regular = 1

TypeMatchups:
	;  attacker,     defender,     *=
	type_matchup NORMAL,       ROCK,         NOT_VERY_EFFECTIVE
	type_matchup NORMAL,       STEEL,        NOT_VERY_EFFECTIVE
	type_matchup FIRE,         FIRE,         NOT_VERY_EFFECTIVE
	type_matchup FIRE,         WATER,        NOT_VERY_EFFECTIVE
	type_matchup FIRE,         GRASS,        SUPER_EFFECTIVE
	type_matchup FIRE,         ICE,          SUPER_EFFECTIVE
	type_matchup FIRE,         BUG,          SUPER_EFFECTIVE
	type_matchup FIRE,         ROCK,         NOT_VERY_EFFECTIVE
	type_matchup FIRE,         DRAGON,       NOT_VERY_EFFECTIVE
	type_matchup FIRE,         STEEL,        SUPER_EFFECTIVE
	type_matchup WATER,        FIRE,         SUPER_EFFECTIVE
	type_matchup WATER,        WATER,        NOT_VERY_EFFECTIVE
	type_matchup WATER,        ICE,          NOT_VERY_EFFECTIVE
	type_matchup WATER,        GRASS,        NOT_VERY_EFFECTIVE
	type_matchup WATER,        GROUND,       SUPER_EFFECTIVE
	type_matchup WATER,        ROCK,         SUPER_EFFECTIVE
	type_matchup WATER,        DRAGON,       NOT_VERY_EFFECTIVE
	type_matchup ELECTRIC,     WATER,        SUPER_EFFECTIVE
	type_matchup ELECTRIC,     ELECTRIC,     NOT_VERY_EFFECTIVE
	type_matchup ELECTRIC,     GRASS,        NOT_VERY_EFFECTIVE
	type_matchup ELECTRIC,     ICE,          NOT_VERY_EFFECTIVE
	type_matchup ELECTRIC,     GROUND,       NO_EFFECT
	type_matchup ELECTRIC,     FLYING,       SUPER_EFFECTIVE
	type_matchup ELECTRIC,     DRAGON,       NOT_VERY_EFFECTIVE
	type_matchup GRASS,        FIRE,         NOT_VERY_EFFECTIVE
	type_matchup GRASS,        WATER,        SUPER_EFFECTIVE
	type_matchup GRASS,        GRASS,        NOT_VERY_EFFECTIVE
	type_matchup GRASS,        POISON,       NOT_VERY_EFFECTIVE
	type_matchup GRASS,        GROUND,       SUPER_EFFECTIVE
	type_matchup GRASS,        FLYING,       NOT_VERY_EFFECTIVE
	type_matchup GRASS,        BUG,          NOT_VERY_EFFECTIVE
	type_matchup GRASS,        ROCK,         SUPER_EFFECTIVE
	type_matchup GRASS,        DRAGON,       NOT_VERY_EFFECTIVE
	type_matchup GRASS,        STEEL,        NOT_VERY_EFFECTIVE
	type_matchup ICE,          WATER,        NOT_VERY_EFFECTIVE
	type_matchup ICE,          GRASS,        SUPER_EFFECTIVE
	type_matchup ICE,          ICE,          NOT_VERY_EFFECTIVE
	type_matchup ICE,          GROUND,       SUPER_EFFECTIVE
	type_matchup ICE,          FLYING,       SUPER_EFFECTIVE
	type_matchup ICE,          DRAGON,       SUPER_EFFECTIVE
	type_matchup ICE,          STEEL,        NOT_VERY_EFFECTIVE
	type_matchup ICE,          FIRE,         NOT_VERY_EFFECTIVE
	type_matchup FIGHTING,     NORMAL,       SUPER_EFFECTIVE
	type_matchup FIGHTING,     ICE,          SUPER_EFFECTIVE
	type_matchup FIGHTING,     POISON,       NOT_VERY_EFFECTIVE
	type_matchup FIGHTING,     FLYING,       NOT_VERY_EFFECTIVE
	type_matchup FIGHTING,     PSYCHIC_TYPE, NOT_VERY_EFFECTIVE
	type_matchup FIGHTING,     BUG,          NOT_VERY_EFFECTIVE
	type_matchup FIGHTING,     ROCK,         SUPER_EFFECTIVE
	type_matchup FIGHTING,     DARK,         SUPER_EFFECTIVE
	type_matchup FIGHTING,     STEEL,        SUPER_EFFECTIVE
	type_matchup FIGHTING,     FAIRY,        NOT_VERY_EFFECTIVE
	type_matchup POISON,       GRASS,        SUPER_EFFECTIVE
	type_matchup POISON,       POISON,       NOT_VERY_EFFECTIVE
	type_matchup POISON,       GROUND,       NOT_VERY_EFFECTIVE
	type_matchup POISON,       ROCK,         NOT_VERY_EFFECTIVE
	type_matchup POISON,       GHOST,        NOT_VERY_EFFECTIVE
	type_matchup POISON,       STEEL,        NO_EFFECT
	type_matchup POISON,       FAIRY,        SUPER_EFFECTIVE
	type_matchup GROUND,       FIRE,         SUPER_EFFECTIVE
	type_matchup GROUND,       ELECTRIC,     SUPER_EFFECTIVE
	type_matchup GROUND,       GRASS,        NOT_VERY_EFFECTIVE
	type_matchup GROUND,       POISON,       SUPER_EFFECTIVE
	type_matchup GROUND,       FLYING,       NO_EFFECT
	type_matchup GROUND,       BUG,          NOT_VERY_EFFECTIVE
	type_matchup GROUND,       ROCK,         SUPER_EFFECTIVE
	type_matchup GROUND,       STEEL,        SUPER_EFFECTIVE
	type_matchup FLYING,       ELECTRIC,     NOT_VERY_EFFECTIVE
	type_matchup FLYING,       GRASS,        SUPER_EFFECTIVE
	type_matchup FLYING,       FIGHTING,     SUPER_EFFECTIVE
	type_matchup FLYING,       BUG,          SUPER_EFFECTIVE
	type_matchup FLYING,       ROCK,         NOT_VERY_EFFECTIVE
	type_matchup FLYING,       STEEL,        NOT_VERY_EFFECTIVE
	type_matchup PSYCHIC_TYPE, FIGHTING,     SUPER_EFFECTIVE
	type_matchup PSYCHIC_TYPE, POISON,       SUPER_EFFECTIVE
	type_matchup PSYCHIC_TYPE, PSYCHIC_TYPE, NOT_VERY_EFFECTIVE
	type_matchup PSYCHIC_TYPE, DARK,         NO_EFFECT
	type_matchup PSYCHIC_TYPE, STEEL,        NOT_VERY_EFFECTIVE
	type_matchup BUG,          FIRE,         NOT_VERY_EFFECTIVE
	type_matchup BUG,          GRASS,        SUPER_EFFECTIVE
	type_matchup BUG,          FIGHTING,     NOT_VERY_EFFECTIVE
	type_matchup BUG,          POISON,       NOT_VERY_EFFECTIVE
	type_matchup BUG,          FLYING,       NOT_VERY_EFFECTIVE
	type_matchup BUG,          PSYCHIC_TYPE, SUPER_EFFECTIVE
	type_matchup BUG,          GHOST,        NOT_VERY_EFFECTIVE
	type_matchup BUG,          DARK,         SUPER_EFFECTIVE
	type_matchup BUG,          STEEL,        NOT_VERY_EFFECTIVE
	type_matchup BUG,          FAIRY,        SUPER_EFFECTIVE
	type_matchup ROCK,         FIRE,         SUPER_EFFECTIVE
	type_matchup ROCK,         ICE,          SUPER_EFFECTIVE
	type_matchup ROCK,         FIGHTING,     NOT_VERY_EFFECTIVE
	type_matchup ROCK,         GROUND,       NOT_VERY_EFFECTIVE
	type_matchup ROCK,         FLYING,       SUPER_EFFECTIVE
	type_matchup ROCK,         BUG,          SUPER_EFFECTIVE
	type_matchup ROCK,         STEEL,        NOT_VERY_EFFECTIVE
	type_matchup GHOST,        NORMAL,       NO_EFFECT
	type_matchup GHOST,        PSYCHIC_TYPE, SUPER_EFFECTIVE
	type_matchup GHOST,        DARK,         NOT_VERY_EFFECTIVE
	type_matchup GHOST,        GHOST,        SUPER_EFFECTIVE
	type_matchup DRAGON,       DRAGON,       SUPER_EFFECTIVE
	type_matchup DRAGON,       STEEL,        NOT_VERY_EFFECTIVE
	type_matchup DRAGON,       FAIRY,        NO_EFFECT
	type_matchup DARK,         FIGHTING,     NOT_VERY_EFFECTIVE
	type_matchup DARK,         PSYCHIC_TYPE, SUPER_EFFECTIVE
	type_matchup DARK,         GHOST,        SUPER_EFFECTIVE
	type_matchup DARK,         DARK,         NOT_VERY_EFFECTIVE
	type_matchup DARK,         FAIRY,        NOT_VERY_EFFECTIVE
	type_matchup STEEL,        FIRE,         NOT_VERY_EFFECTIVE
	type_matchup STEEL,        WATER,        NOT_VERY_EFFECTIVE
	type_matchup STEEL,        ELECTRIC,     NOT_VERY_EFFECTIVE
	type_matchup STEEL,        ICE,          SUPER_EFFECTIVE
	type_matchup STEEL,        ROCK,         SUPER_EFFECTIVE
	type_matchup STEEL,        STEEL,        NOT_VERY_EFFECTIVE
	type_matchup STEEL,        FAIRY,        SUPER_EFFECTIVE
	type_matchup FAIRY,        FIGHTING,     SUPER_EFFECTIVE
	type_matchup FAIRY,        POISON,       NOT_VERY_EFFECTIVE
	type_matchup FAIRY,        BUG,          NOT_VERY_EFFECTIVE
	type_matchup FAIRY,        DRAGON,       SUPER_EFFECTIVE
	type_matchup FAIRY,        DARK,         SUPER_EFFECTIVE
	type_matchup FAIRY,        STEEL,        NOT_VERY_EFFECTIVE
	type_matchup ICE2,         WATER,        SUPER_EFFECTIVE
	type_matchup ICE2,         GRASS,        SUPER_EFFECTIVE
	type_matchup ICE2,         ICE,          NOT_VERY_EFFECTIVE
	type_matchup ICE2,         GROUND,       SUPER_EFFECTIVE
	type_matchup ICE2,         FLYING,       SUPER_EFFECTIVE
	type_matchup ICE2,         DRAGON,       SUPER_EFFECTIVE
	type_matchup ICE2,         STEEL,        NOT_VERY_EFFECTIVE
	type_matchup ICE2,         FIRE,         NOT_VERY_EFFECTIVE

	db -2 ; end (with Foresight)

DEF _tm_regular = 0
TypeMatchupsForesight:
; Foresight removes Ghost's immunities.
	type_matchup NORMAL,       GHOST,        NO_EFFECT
	type_matchup FIGHTING,     GHOST,        NO_EFFECT

	db -1 ; end

DEF _tm_chart = 1
DEF _tm_index = 0
DEF _tm_regular = 1
InverseTypeMatchups:
   ;  attacker,     defender,     *=
	type_matchup NORMAL,       ROCK,         SUPER_EFFECTIVE
	type_matchup NORMAL,       STEEL,        SUPER_EFFECTIVE
	type_matchup FIRE,         FIRE,         SUPER_EFFECTIVE
	type_matchup FIRE,         WATER,        SUPER_EFFECTIVE
	type_matchup FIRE,         GRASS,        NOT_VERY_EFFECTIVE
	type_matchup FIRE,         ICE,          NOT_VERY_EFFECTIVE
	type_matchup FIRE,         BUG,          NOT_VERY_EFFECTIVE
	type_matchup FIRE,         ROCK,         SUPER_EFFECTIVE
	type_matchup FIRE,         DRAGON,       SUPER_EFFECTIVE
	type_matchup FIRE,         STEEL,        NOT_VERY_EFFECTIVE
	type_matchup WATER,        FIRE,         NOT_VERY_EFFECTIVE
	type_matchup WATER,        WATER,        SUPER_EFFECTIVE
	type_matchup WATER,        ICE,          SUPER_EFFECTIVE
	type_matchup WATER,        GRASS,        SUPER_EFFECTIVE
	type_matchup WATER,        GROUND,       NOT_VERY_EFFECTIVE
	type_matchup WATER,        ROCK,         NOT_VERY_EFFECTIVE
	type_matchup WATER,        DRAGON,       SUPER_EFFECTIVE
	type_matchup ELECTRIC,     WATER,        NOT_VERY_EFFECTIVE
	type_matchup ELECTRIC,     ELECTRIC,     SUPER_EFFECTIVE
	type_matchup ELECTRIC,     GRASS,        SUPER_EFFECTIVE
	type_matchup ELECTRIC,     GROUND,       SUPER_EFFECTIVE
	type_matchup ELECTRIC,     ICE,          SUPER_EFFECTIVE
	type_matchup ELECTRIC,     FLYING,       NOT_VERY_EFFECTIVE
	type_matchup ELECTRIC,     DRAGON,       SUPER_EFFECTIVE
	type_matchup GRASS,        FIRE,         SUPER_EFFECTIVE
	type_matchup GRASS,        WATER,        NOT_VERY_EFFECTIVE
	type_matchup GRASS,        GRASS,        SUPER_EFFECTIVE
	type_matchup GRASS,        POISON,       SUPER_EFFECTIVE
	type_matchup GRASS,        ICE,          SUPER_EFFECTIVE
	type_matchup GRASS,        GROUND,       NOT_VERY_EFFECTIVE
	type_matchup GRASS,        FLYING,       SUPER_EFFECTIVE
	type_matchup GRASS,        BUG,          SUPER_EFFECTIVE
	type_matchup GRASS,        ROCK,         NOT_VERY_EFFECTIVE
	type_matchup GRASS,        DRAGON,       SUPER_EFFECTIVE
	type_matchup GRASS,        STEEL,        SUPER_EFFECTIVE
	type_matchup ICE,          WATER,        SUPER_EFFECTIVE
	type_matchup ICE,          GRASS,        NOT_VERY_EFFECTIVE
	type_matchup ICE,          ICE,          SUPER_EFFECTIVE
	type_matchup ICE,          GROUND,       NOT_VERY_EFFECTIVE
	type_matchup ICE,          FLYING,       NOT_VERY_EFFECTIVE
	type_matchup ICE,          DRAGON,       NOT_VERY_EFFECTIVE
	type_matchup ICE,          STEEL,        SUPER_EFFECTIVE
	type_matchup ICE,          FIRE,         SUPER_EFFECTIVE
	type_matchup FIGHTING,     NORMAL,       NOT_VERY_EFFECTIVE
	type_matchup FIGHTING,     ICE,          NOT_VERY_EFFECTIVE
	type_matchup FIGHTING,     POISON,       SUPER_EFFECTIVE
	type_matchup FIGHTING,     FLYING,       SUPER_EFFECTIVE
	type_matchup FIGHTING,     PSYCHIC_TYPE, SUPER_EFFECTIVE
	type_matchup FIGHTING,     BUG,          SUPER_EFFECTIVE
	type_matchup FIGHTING,     ROCK,         NOT_VERY_EFFECTIVE
	type_matchup FIGHTING,     DARK,         NOT_VERY_EFFECTIVE
	type_matchup FIGHTING,     STEEL,        NOT_VERY_EFFECTIVE
	type_matchup POISON,       GRASS,        NOT_VERY_EFFECTIVE
	type_matchup POISON,       POISON,       SUPER_EFFECTIVE
	type_matchup POISON,       GROUND,       SUPER_EFFECTIVE
	type_matchup POISON,       ROCK,         SUPER_EFFECTIVE
	type_matchup POISON,       GHOST,        SUPER_EFFECTIVE
	type_matchup POISON,       STEEL,        SUPER_EFFECTIVE
	type_matchup GROUND,       FIRE,         NOT_VERY_EFFECTIVE
	type_matchup GROUND,       ELECTRIC,     NOT_VERY_EFFECTIVE
	type_matchup GROUND,       GRASS,        SUPER_EFFECTIVE
	type_matchup GROUND,       POISON,       NOT_VERY_EFFECTIVE
	type_matchup GROUND,       FLYING,       SUPER_EFFECTIVE
	type_matchup GROUND,       BUG,          SUPER_EFFECTIVE
	type_matchup GROUND,       ROCK,         NOT_VERY_EFFECTIVE
	type_matchup GROUND,       STEEL,        NOT_VERY_EFFECTIVE
	type_matchup FLYING,       ELECTRIC,     SUPER_EFFECTIVE
	type_matchup FLYING,       GRASS,        NOT_VERY_EFFECTIVE
	type_matchup FLYING,       FIGHTING,     NOT_VERY_EFFECTIVE
	type_matchup FLYING,       BUG,          NOT_VERY_EFFECTIVE
	type_matchup FLYING,       ROCK,         SUPER_EFFECTIVE
	type_matchup FLYING,       STEEL,        SUPER_EFFECTIVE
	type_matchup PSYCHIC_TYPE, FIGHTING,     NOT_VERY_EFFECTIVE
	type_matchup PSYCHIC_TYPE, POISON,       NOT_VERY_EFFECTIVE
	type_matchup PSYCHIC_TYPE, PSYCHIC_TYPE, SUPER_EFFECTIVE
	type_matchup PSYCHIC_TYPE, DARK,         SUPER_EFFECTIVE
	type_matchup PSYCHIC_TYPE, STEEL,        SUPER_EFFECTIVE
	type_matchup BUG,          FIRE,         SUPER_EFFECTIVE
	type_matchup BUG,          GRASS,        NOT_VERY_EFFECTIVE
	type_matchup BUG,          FIGHTING,     SUPER_EFFECTIVE
	type_matchup BUG,          POISON,       SUPER_EFFECTIVE
	type_matchup BUG,          FLYING,       SUPER_EFFECTIVE
	type_matchup BUG,          PSYCHIC_TYPE, NOT_VERY_EFFECTIVE
	type_matchup BUG,          GHOST,        SUPER_EFFECTIVE
	type_matchup BUG,          DARK,         NOT_VERY_EFFECTIVE
	type_matchup BUG,          STEEL,        SUPER_EFFECTIVE
	type_matchup ROCK,         FIRE,         NOT_VERY_EFFECTIVE
	type_matchup ROCK,         ICE,          NOT_VERY_EFFECTIVE
	type_matchup ROCK,         FIGHTING,     SUPER_EFFECTIVE
	type_matchup ROCK,         GROUND,       SUPER_EFFECTIVE
	type_matchup ROCK,         FLYING,       NOT_VERY_EFFECTIVE
	type_matchup ROCK,         BUG,          NOT_VERY_EFFECTIVE
	type_matchup ROCK,         STEEL,        SUPER_EFFECTIVE
	type_matchup GHOST,        NORMAL,       SUPER_EFFECTIVE
	type_matchup GHOST,        PSYCHIC_TYPE, NOT_VERY_EFFECTIVE
	type_matchup GHOST,        DARK,         SUPER_EFFECTIVE
	type_matchup GHOST,        STEEL,        SUPER_EFFECTIVE
	type_matchup GHOST,        GHOST,        NOT_VERY_EFFECTIVE
	type_matchup DRAGON,       DRAGON,       NOT_VERY_EFFECTIVE
	type_matchup DRAGON,       STEEL,        SUPER_EFFECTIVE
	type_matchup DARK,         FIGHTING,     SUPER_EFFECTIVE
	type_matchup DARK,         PSYCHIC_TYPE, NOT_VERY_EFFECTIVE
	type_matchup DARK,         GHOST,        NOT_VERY_EFFECTIVE
	type_matchup DARK,         DARK,         SUPER_EFFECTIVE
	type_matchup DARK,         STEEL,        SUPER_EFFECTIVE
	type_matchup STEEL,        FIRE,         SUPER_EFFECTIVE
	type_matchup STEEL,        WATER,        SUPER_EFFECTIVE
	type_matchup STEEL,        ELECTRIC,     SUPER_EFFECTIVE
	type_matchup STEEL,        ICE,          NOT_VERY_EFFECTIVE
	type_matchup STEEL,        ROCK,         NOT_VERY_EFFECTIVE
	type_matchup STEEL,        STEEL,        SUPER_EFFECTIVE
	type_matchup NORMAL,       GHOST,        SUPER_EFFECTIVE
	type_matchup FIGHTING,     GHOST,        SUPER_EFFECTIVE
	type_matchup FIGHTING,     FAIRY,        SUPER_EFFECTIVE
	type_matchup POISON,       FAIRY,        NOT_VERY_EFFECTIVE
	type_matchup BUG,          FAIRY,        NOT_VERY_EFFECTIVE
	type_matchup DRAGON,       FAIRY,        SUPER_EFFECTIVE
	type_matchup DARK,         FAIRY,        SUPER_EFFECTIVE
	type_matchup STEEL,        FAIRY,        NOT_VERY_EFFECTIVE
	type_matchup FAIRY,        FIGHTING,     NOT_VERY_EFFECTIVE
	type_matchup FAIRY,        POISON,       SUPER_EFFECTIVE
	type_matchup FAIRY,        BUG,          SUPER_EFFECTIVE
	type_matchup FAIRY,        DRAGON,       NOT_VERY_EFFECTIVE
	type_matchup FAIRY,        DARK,         NOT_VERY_EFFECTIVE
	type_matchup FAIRY,        STEEL,        SUPER_EFFECTIVE
	type_matchup ICE2,         WATER,        NOT_VERY_EFFECTIVE
	type_matchup ICE2,         GRASS,        NOT_VERY_EFFECTIVE
	type_matchup ICE2,         ICE,          SUPER_EFFECTIVE
	type_matchup ICE2,         GROUND,       NOT_VERY_EFFECTIVE
	type_matchup ICE2,         FLYING,       NOT_VERY_EFFECTIVE
	type_matchup ICE2,         DRAGON,       NOT_VERY_EFFECTIVE
	type_matchup ICE2,         STEEL,        SUPER_EFFECTIVE
	type_matchup ICE2,         FIRE,         SUPER_EFFECTIVE
NoTypeMatchups:
   db -1 ; end

	align 8
TypeMatrix_Normal:
	type_matrices 0
TypeMatrix_Inverse:
	type_matrices 1
