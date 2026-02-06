BattleTowerMons:
	table_width NICKNAMED_MON_STRUCT_LENGTH, BattleTowerMons

; ============
; === Note ===
; ============
; 136 pokemon in total
; last Trainer picks from top 40 Pokemon
; first 16 Pokemon are ubers

; nothing here should use hidden power
; as the dv player copy mechanic doesn't work here
; nor should shiny pokemon be put here
; set all effort values to zero due to same as above and only stats matter

	db MEWTWO
	db MIRACLEBERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "SANDA-SU@@@"

	db MEW
	db LEFTOVERS
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "E-HUi@@@@@@"

	db CELEBI
	db FOCUS_BAND
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "SO-NANSU@@@"

	db VICTINI
	db MIRACLEBERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "GARU-RA@@@@"

	db NOWN
	db SCOPE_LENS
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "SANI-GO@@@@"

	db HO_OH
	db GOLD_BERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "MIRUTANKU@@"

	db LUGIA
	db LEFTOVERS
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "PUTERA@@@@@"

	db REGIGIGAS
	db MIRACLEBERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "RAPURASU@@@"

	db DARKRAI
	db GOLD_BERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "NIyu-RA@@@@"

	db GHOLDENGO
	db BRIGHTPOWDER
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "PORIGON2@@@"

	db DURALUDON
	db FOCUS_BAND
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "MUUMA@@@@@@"

	db SMEARGLE
	db GOLD_BERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "BURAtuKI-@@"

	db FERROTHORN
	db BERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 174, 174, 174, 174, 174, 174 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 15, 0, 0, 0 ; PP
	db 0 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 10 ; Level
	db 0, 0 ; Status
	bigdw 36 ; HP
	bigdw 36 ; Max HP
	bigdw 26 ; Atk
	bigdw 21 ; Def
	bigdw 21 ; Spd
	bigdw 26 ; SAtk
	bigdw 21 ; SDef
	db "ANNO-N@@@@@"

	db VOLCARONA
	db BERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 174, 174, 174, 174, 174, 174 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 15, 0, 0, 0 ; PP
	db 0 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 10 ; Level
	db 0, 0 ; Status
	bigdw 36 ; HP
	bigdw 36 ; Max HP
	bigdw 26 ; Atk
	bigdw 21 ; Def
	bigdw 21 ; Spd
	bigdw 26 ; SAtk
	bigdw 21 ; SDef
	db "ANNO-N@@@@@"

	db GARCHOMP
	db GOLD_BERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "HERAKUROSU@"

	db TYRANITAR
	db BRIGHTPOWDER
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "PORIGON2@@@"

; ============
; === Note ===
; ============
; above 16 are ubers

	db DITTO
	db GOLD_BERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "DERUBIRU@@@"

	db RAIKOU
	db QUICK_CLAW
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "HAPINASU@@@"

	db ENTEI
	db MIRACLEBERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "KABIGON@@@@"

	db SUICUNE
	db KINGS_ROCK
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "NAtuSI-@@@@"

	db ARTICUNO
	db GOLD_BERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "HERAKUROSU@"

	db MOLTRES
	db BERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 174, 174, 174, 174, 174, 174 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 15, 0, 0, 0 ; PP
	db 0 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 10 ; Level
	db 0, 0 ; Status
	bigdw 36 ; HP
	bigdw 36 ; Max HP
	bigdw 26 ; Atk
	bigdw 21 ; Def
	bigdw 21 ; Spd
	bigdw 26 ; SAtk
	bigdw 21 ; SDef
	db "ANNO-N@@@@@"

	db ZAPDOS
	db KINGS_ROCK
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "KENTAROSU@@"

	db REGIROCK
	db QUICK_CLAW
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "BARIYA-DO@@"

	db REGICE
	db MIRACLEBERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "SANDA-SU@@@"

	db REGISTEEL
	db LEFTOVERS
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "E-HUi@@@@@@"

	db ABSOL
	db GOLD_BERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "BURAtuKI-@@"

	db ROTOM
	db FOCUS_BAND
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "SO-NANSU@@@"

	db AERODACTYL
	db MIRACLEBERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "GARU-RA@@@@"

	db CRADILY
	db SCOPE_LENS
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "SANI-GO@@@@"

	db OMASTAR
	db GOLD_BERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "MIRUTANKU@@"

	db PORYGONZ
	db LEFTOVERS
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "PUTERA@@@@@"

	db HAXORUS
	db MIRACLEBERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "RAPURASU@@@"

	db SALAMENCE
	db GOLD_BERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "NIyu-RA@@@@"

	db SNORLAX
	db FOCUS_BAND
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "MUUMA@@@@@@"

	db BLISSEY
	db KINGS_ROCK
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "KIRINRIKI@@"

	db MISMAGIUS
	db QUICK_CLAW
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "HAPINASU@@@"

	db SKARMORY
	db MIRACLEBERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "KABIGON@@@@"

	db BRONZONG
	db KINGS_ROCK
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "NAtuSI-@@@@"

	db LUCARIO
	db GOLD_BERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "HERAKUROSU@"

	db CLAYDOL
	db BERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 174, 174, 174, 174, 174, 174 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 15, 0, 0, 0 ; PP
	db 0 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 10 ; Level
	db 0, 0 ; Status
	bigdw 36 ; HP
	bigdw 36 ; Max HP
	bigdw 26 ; Atk
	bigdw 21 ; Def
	bigdw 21 ; Spd
	bigdw 26 ; SAtk
	bigdw 21 ; SDef
	db "ANNO-N@@@@@"

; =========== Last Trainer picks from above 40 Pokemon =============

	db CHANSEY
	db GOLD_BERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "DERUBIRU@@@"

	db ABOMASNOW
	db MIRACLEBERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "SANDA-SU@@@"

	db WEAVILE
	db LEFTOVERS
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "E-HUi@@@@@@"

	db SNEASLER
	db GOLD_BERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "BURAtuKI-@@"

	db MAMOSWINE
	db FOCUS_BAND
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "SO-NANSU@@@"

	db GLALIE
	db MIRACLEBERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "GARU-RA@@@@"

	db FROSLASS
	db SCOPE_LENS
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "SANI-GO@@@@"

	db JYNX
	db GOLD_BERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "MIRUTANKU@@"

	db DELIBIRD
	db LEFTOVERS
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "PUTERA@@@@@"

	db WYRDEER
	db MIRACLEBERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "RAPURASU@@@"

	db LUNATONE
	db GOLD_BERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "NIyu-RA@@@@"

	db SOLROCK
	db BRIGHTPOWDER
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "PORIGON2@@@"

	db CLEFABLE
	db FOCUS_BAND
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "MUUMA@@@@@@"

	db LAPRAS
	db GOLD_BERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "DERUBIRU@@@"

	db KINGDRA
	db KINGS_ROCK
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "KIRINRIKI@@"

	db DEWGONG
	db QUICK_CLAW
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "HAPINASU@@@"

	db TENTACRUEL
	db MIRACLEBERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "KABIGON@@@@"

	db MANTINE
	db KINGS_ROCK
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "NAtuSI-@@@@"

	db LANTURN
	db GOLD_BERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "HERAKUROSU@"

	db OCTILLERY
	db BERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 174, 174, 174, 174, 174, 174 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 15, 0, 0, 0 ; PP
	db 0 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 10 ; Level
	db 0, 0 ; Status
	bigdw 36 ; HP
	bigdw 36 ; Max HP
	bigdw 26 ; Atk
	bigdw 21 ; Def
	bigdw 21 ; Spd
	bigdw 26 ; SAtk
	bigdw 21 ; SDef
	db "ANNO-N@@@@@"

	db STARMIE
	db KINGS_ROCK
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "KENTAROSU@@"

	db CORSOLA
	db QUICK_CLAW
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "BARIYA-DO@@"

	db SHUCKLE
	db MIRACLEBERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "SANDA-SU@@@"

	db MAGNEZONE
	db LEFTOVERS
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "E-HUi@@@@@@"

	db ELECTABUZZ
	db GOLD_BERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "BURAtuKI-@@"

	db ELECTRODE
	db FOCUS_BAND
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "SO-NANSU@@@"

	db TAUROS
	db MIRACLEBERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "GARU-RA@@@@"

	db MILTANK
	db SCOPE_LENS
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "SANI-GO@@@@"

	db CHANDELURE
	db GOLD_BERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "MIRUTANKU@@"

	db MUK
	db LEFTOVERS
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "PUTERA@@@@@"

	db SUDOWOODO
	db GOLD_BERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "NIyu-RA@@@@"

	db HYPNO
	db BRIGHTPOWDER
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "PORIGON2@@@"

	db GRANBULL
	db FOCUS_BAND
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "MUUMA@@@@@@"

	db PERSIAN
	db GOLD_BERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "DERUBIRU@@@"

	db HERACROSS
	db QUICK_CLAW
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "HAPINASU@@@"

	db KLEAVOR
	db MIRACLEBERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "KABIGON@@@@"

	db SCIZOR
	db KINGS_ROCK
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "NAtuSI-@@@@"

; === 80 pokemon ===

	db WEEZING
	db MIRACLEBERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "RAPURASU@@@"

	db TANGROWTH
	db KINGS_ROCK
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "KIRINRIKI@@"

	db SCYTHER
	db GOLD_BERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "HERAKUROSU@"

	db ANNIHILAPE
	db GOLD_BERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "HERAKUROSU@"

	db PRIMEAPE
	db GOLD_BERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "HERAKUROSU@"

	db TROPIUS
	db GOLD_BERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "HERAKUROSU@"

	db DRAPION
	db GOLD_BERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "HERAKUROSU@"

	db GALVANTULA
	db GOLD_BERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "HERAKUROSU@"

	db SCOLIPEDE
	db GOLD_BERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "HERAKUROSU@"

	db ARIADOS
	db GOLD_BERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "HERAKUROSU@"

	db BRELOOM
	db GOLD_BERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "HERAKUROSU@"

	db SLOWBRO
	db GOLD_BERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "HERAKUROSU@"

	db RAPIDASH
	db GOLD_BERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "HERAKUROSU@"

	db DODRIO
	db GOLD_BERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "HERAKUROSU@"

	db HARIYAMA
	db GOLD_BERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "HERAKUROSU@"

	db GLISCOR
	db GOLD_BERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "HERAKUROSU@"

	db QUAGSIRE
	db GOLD_BERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "HERAKUROSU@"

	db HOUNDOOM
	db GOLD_BERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "HERAKUROSU@"

	db ARCANINE
	db GOLD_BERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "HERAKUROSU@"

	db XATU
	db GOLD_BERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "HERAKUROSU@"

	db ALTARIA
	db GOLD_BERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "HERAKUROSU@"

	db GENGAR
	db GOLD_BERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "HERAKUROSU@"

	db GYARADOS
	db GOLD_BERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "HERAKUROSU@"

; === 100 pokemon ===

	db ONIX
	db GOLD_BERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "HERAKUROSU@"

	db STEELIX
	db GOLD_BERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "HERAKUROSU@"

	db RHYDON
	db GOLD_BERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "HERAKUROSU@"

	db AZUMARILL
	db GOLD_BERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "HERAKUROSU@"

	db GOLISOPOD
	db GOLD_BERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "HERAKUROSU@"

	db NIDOKING
	db GOLD_BERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "HERAKUROSU@"

	db NIDOQUEEN
	db GOLD_BERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "HERAKUROSU@"

	db AMPHAROS
	db GOLD_BERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "HERAKUROSU@"

	db VICTREEBEL
	db GOLD_BERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "HERAKUROSU@"

	db DONPHAN
	db GOLD_BERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "HERAKUROSU@"

	db URSALUNA
	db GOLD_BERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "HERAKUROSU@"

	db CROBAT
	db GOLD_BERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "HERAKUROSU@"

	db NOCTOWL
	db GOLD_BERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "HERAKUROSU@"

	db PIDGEOT
	db GOLD_BERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "HERAKUROSU@"

	db LOPUNNY
	db GOLD_BERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "HERAKUROSU@"

	db SUNFLORA
	db GOLD_BERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "HERAKUROSU@"

	db YANMEGA
	db GOLD_BERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "HERAKUROSU@"

	db DUSTOX
	db GOLD_BERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "HERAKUROSU@"

	db BEAUTIFLY
	db GOLD_BERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "HERAKUROSU@"

; === 120 pokemon ===

	db GALLADE
	db GOLD_BERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "HERAKUROSU@"

	db GARDEVOIR
	db GOLD_BERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "HERAKUROSU@"

	db DECIDUEYE
	db GOLD_BERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "HERAKUROSU@"

	db MILOTIC
	db GOLD_BERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "HERAKUROSU@"

	db BLAZIKEN
	db GOLD_BERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "HERAKUROSU@"

	db SYLVEON
	db GOLD_BERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "HERAKUROSU@"

	db UMBREON
	db GOLD_BERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "HERAKUROSU@"

	db RAICHU
	db GOLD_BERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "HERAKUROSU@"

	db PIKACHU
	db GOLD_BERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "HERAKUROSU@"

	db TORTERRA
	db GOLD_BERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "HERAKUROSU@"

	db BLASTOISE
	db GOLD_BERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "HERAKUROSU@"

	db CHARIZARD
	db GOLD_BERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "HERAKUROSU@"

	db TOGEKISS
	db GOLD_BERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "HERAKUROSU@"

	db MEGANIUM
	db GOLD_BERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "HERAKUROSU@"

	db FERALIGATR
	db GOLD_BERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "HERAKUROSU@"

	db TYPHLOSION
	db GOLD_BERRY
	db EXTREMESPEED, CRUNCH, FLAMETHROWER, SCALD
	dw 0 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db 0, 0, 0, 0 ; padding
	dn 0, 0, 0, 0 ; DVs
	db 24, 24, 24, 24 ; PP
	db 100 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db 50 ; Level
	db 0, 0 ; Status
	bigdw 8 ; HP
	bigdw 8 ; Max HP
	bigdw 8 ; Atk
	bigdw 8 ; Def
	bigdw 8 ; Spd
	bigdw 8 ; SAtk
	bigdw 8 ; SDef
	db "HERAKUROSU@"

; === 136 pokemon ===
