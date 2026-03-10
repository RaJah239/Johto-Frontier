BugContestantPointers:
	table_width 2
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
	dbw ENTEI,      285
	dbw SUICUNE,    226

BugContestant_BugCatcherEd:
	db BUG_CATCHER, JOSH
	dbw RAIKOU,     300
	dbw ENTEI,      285
	dbw SUICUNE,    226

BugContestant_CooltrainerMNick:
	db COOLTRAINERM, NICK
	dbw RAIKOU,     300
	dbw ENTEI,      285
	dbw SUICUNE,    226

BugContestant_PokefanMWilliam:
	db POKEFANM, WILLIAM
	dbw RAIKOU,     300
	dbw ENTEI,      285
	dbw SUICUNE,    226

BugContestant_BugCatcherBenny:
	db BUG_CATCHER, BUG_CATCHER_BENNY
	dbw RAIKOU,     300
	dbw ENTEI,      285
	dbw SUICUNE,    226

BugContestant_CamperBarry:
	db CAMPER, ROLAND
	dbw RAIKOU,     300
	dbw ENTEI,      285
	dbw SUICUNE,    226

BugContestant_PicnickerCindy:
	db PICNICKER, KIM
	dbw RAIKOU,     300
	dbw ENTEI,      285
	dbw SUICUNE,    226

BugContestant_BugCatcherJosh:
	db BUG_CATCHER, ARNIE
	dbw RAIKOU,     300
	dbw ENTEI,      285
	dbw SUICUNE,    226

BugContestant_YoungsterSamuel:
	db YOUNGSTER, SAMUEL
	dbw RAIKOU,     300
	dbw ENTEI,      285
	dbw SUICUNE,    226

BugContestant_SchoolboyKipp:
	db SCHOOLBOY, CHAD
	dbw RAIKOU,     300
	dbw ENTEI,      285
	dbw SUICUNE,    226
