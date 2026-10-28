; Level-bracket trainer parties.
; Each trainer can have 5+ teams depending on player level.
; Bracket lists may live in any ROMX bank (table stores the bank).
;
; Table entry:
;   db trainer class, trainer ID
;   db bracket list bank
;   dw bracket list address
;
; Level bracket list:
;   db max level
;   dba party entry  (bank + address)
;   ...
;   db -1
;
; "max level" is the highest player level that uses that party, so
;   db 5  -> levels 1-5
;   db 10 -> levels 6-10
; If the player's level is above every bracket, the last bracket's party is
; used. Party entries may live in any bank because dba stores the bank.

; The table itself is read directly, so it must stay in the same bank as
; ReadTrainerParty. The bracket lists may live in any bank because each
; entry stores its own bank.
ScaledTrainerPartyTable:
	; Example: Falkner's first fight uses one party per 5-level bracket.
	db FALKNER, FALKNER1
	db BANK(Falkner1LevelParties)
	dw Falkner1LevelParties
	; Bugsy's first fight gets a bug team that grows every 5 levels.
	db BUGSY, BUGSY1
	db BANK(Bugsy1LevelParties)
	dw Bugsy1LevelParties
	; Route 2 Joey gets a new team every 10 levels, capped at 50.
	db YOUNGSTER, JOEY
	db BANK(JoeyLevelParties)
	dw JoeyLevelParties
	db -1 ; end of table

SECTION "Scaled Trainer Party Lists", ROMX

Falkner1LevelParties:
	db 5          ; 1-5
	dba Falkner1TeamA
	db 10         ; 6-10
	dba Falkner1TeamB
	db 15         ; 11-15
	dba Falkner1TeamC
	db 20         ; 16-20
	dba Falkner1TeamD
	db -1         ; above 20 uses Team D

Bugsy1LevelParties:
	db 5          ; 1-5
	dba Bugsy1TeamA
	db 10         ; 6-10
	dba Bugsy1TeamB
	db 15         ; 11-15
	dba Bugsy1TeamC
	db 20         ; 16-20
	dba Bugsy1TeamD
	db 25         ; 21-25
	dba Bugsy1TeamE
	db 30         ; 26-30
	dba Bugsy1TeamF
	db 35         ; 31-35
	dba Bugsy1TeamG
	db 40         ; 36-40
	dba Bugsy1TeamH
	db 45         ; 41-45
	dba Bugsy1TeamI
	db 50         ; 46-50
	dba Bugsy1TeamJ
	db -1         ; above 50 uses Team J

JoeyLevelParties:
	db 10         ; 1-10
	dba Joey1TeamA
	db 20         ; 11-20
	dba Joey1TeamB
	db 30         ; 21-30
	dba Joey1TeamC
	db 40         ; 31-40
	dba Joey1TeamD
	db 50         ; 41-50
	dba Joey1TeamE
	db -1         ; above 50 uses Team E

; all includes must be down here
INCLUDE "data/trainers/scaled_teams/falkner1.asm"
INCLUDE "data/trainers/scaled_teams/bugsy1.asm"
INCLUDE "data/trainers/scaled_teams/joey1.asm"
