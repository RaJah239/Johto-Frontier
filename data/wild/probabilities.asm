MACRO mon_prob
; percent, index
	db \1, \2 * 2
ENDM

GrassMonProbTable:
	table_width 2, GrassMonProbTable
	mon_prob 16,  0 ; 16% chance
	mon_prob 33,  1 ; 17% chance
	mon_prob 49,  2 ; 16% chance
	mon_prob 66,  3 ; 17% chance
	mon_prob 83,  4 ; 16% chance
	mon_prob 99,  5 ; 17% chance
	mon_prob 100, 6 ;  1% chance
	assert_table_length NUM_GRASSMON

WaterMonProbTable:
	table_width 2, WaterMonProbTable
	mon_prob 34,  0 ; 34% chance
	mon_prob 67,  1 ; 33% chance
	mon_prob 100, 2 ; 33% chance
	assert_table_length NUM_WATERMON
