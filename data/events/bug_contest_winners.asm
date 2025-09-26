BugContestantPointers:
	table_width 2, BugContestantPointers
	dw BugContestant_BugCatcherDon ; this reverts back to the player
	dw BugContestant_BugCatcherDon
	dw BugContestant_BugCatcherEd
	dw BugContestant_CooltrainerMNick
	dw BugContestant_PokefanMWilliam
	dw BugContestant_BugCatcherBenny
	dw BugContestant_CamperBarry
	dw BugContestant_PicnickerCindy
	dw BugContestant_BugCatcherJosh
	dw BugContestant_YoungsterSamuel
	dw BugContestant_SchoolboyKipp
	assert_table_length NUM_BUG_CONTESTANTS + 1

; contestant format:
;   db class, id
;   dbw 1st-place mon, score
;   dbw 2nd-place mon, score
;   dbw 3rd-place mon, score

BugContestant_BugCatcherDon:
	db BUG_CATCHER, DON
	dbw RAIKOU,     300
	dbw SUICUNE,    285
	dbw ENTEI,      226

BugContestant_BugCatcherEd:
	db BUG_CATCHER, ED
	dbw RAIKOU,     286
	dbw SUICUNE,    251
	dbw ENTEI,      237

BugContestant_CooltrainerMNick:
	db COOLTRAINERM, NICK
	dbw RAIKOU,     357
	dbw SUICUNE,    349
	dbw HERACROSS,  368

BugContestant_PokefanMWilliam:
	db POKEFANM, WILLIAM
	dbw RAIKOU,     332
	dbw SUICUNE,    324
	dbw HERACROSS,  321

BugContestant_BugCatcherBenny:
	db BUG_CATCHER, BUG_CATCHER_BENNY
	dbw RAIKOU,     318
	dbw SUICUNE,    295
	dbw ENTEI,      285

BugContestant_CamperBarry:
	db CAMPER, BARRY
	dbw RAIKOU,     366
	dbw SUICUNE,    329
	dbw HERACROSS,  314

BugContestant_PicnickerCindy:
	db PICNICKER, CINDY
	dbw RAIKOU, 341
	dbw SUICUNE,    301
	dbw ENTEI,      264

BugContestant_BugCatcherJosh:
	db BUG_CATCHER, JOSH
	dbw RAIKOU,     326
	dbw SUICUNE,    292
	dbw HERACROSS,  282

BugContestant_YoungsterSamuel:
	db YOUNGSTER, SAMUEL
	dbw RAIKOU,     270
	dbw SUICUNE,    282
	dbw ENTEI,      251

BugContestant_SchoolboyKipp:
	db SCHOOLBOY, KIPP
	dbw RAIKOU,     267
	dbw SUICUNE,    254
	dbw HERACROSS,  259
