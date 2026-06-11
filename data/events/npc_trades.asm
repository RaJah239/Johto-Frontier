MACRO npctrade
; dialog set, requested mon, offered mon, nickname, dvs, item, OT ID, OT name, gender requested
	db \1, \2, \3, \4, \5, \6, \7
	dw \8
	db \9, \<10>, 0
ENDM

NPCTrades:
; entries correspond to NPCTRADE_* constants and locations at data\wild\non_wildmon_locations.asm
	table_width NPCTRADE_STRUCT_LENGTH, NPCTrades
	npctrade TRADE_DIALOGSET_COLLECTOR, DITTO,       DITTO,     "Muscle@@@@@", $37, $66, GOLD_BERRY,   37460, "Mike@@@@@@@", TRADE_GENDER_EITHER
	npctrade TRADE_DIALOGSET_COLLECTOR, BELLSPROUT, ONIX,       "Rocky@@@@@@", $96, $66, BITTER_BERRY, 48926, "Kyle@@@@@@@", TRADE_GENDER_EITHER
	npctrade TRADE_DIALOGSET_HAPPY,     FEEBAS,     VOLTORB,    "Volty@@@@@@", $98, $88, PRZCUREBERRY, 29189, "Tim@@@@@@@@", TRADE_GENDER_EITHER
	npctrade TRADE_DIALOGSET_GIRL,      FEEBAS,     DODRIO,     "Doris@@@@@@", $77, $66, SMOKE_BALL,   00283, "Emy@@@@@@@@", TRADE_GENDER_FEMALE
	assert_table_length NUM_NPC_TRADES
