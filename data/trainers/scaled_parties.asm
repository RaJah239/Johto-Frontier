; Level-bracket trainer parties.
; only 30 to 40 trainers can be added atm
; A trainer listed here uses a different party depending on the player's
; highest party level. The trainer's normal party is used only if there is
; no entry for that trainer (or the bracket list is empty).
;
; Table entry:
;   db trainer class, trainer ID
;   dw level bracket list
;
; Level bracket list (must stay in this bank):
;   db max level
;   dba party entry
;   ...
;   db -1
;
; "max level" is the highest player level that uses that party, so
;   db 5  -> levels 1-5
;   db 10 -> levels 6-10
;   db 15 -> levels 11-15
; If the player's level is above every bracket, the last bracket's party is
; used. Party entries are ordinary trainer entries (name, TRAINERTYPE_*,
; Pokemon and a terminating db -1), and may live in any bank because dba
; stores the bank along with the address.

ScaledTrainerPartyTable:
	; Example: Falkner's first fight uses one party per 5-level bracket.
	db FALKNER, FALKNER1
	dw Falkner1LevelParties
	; Bugsy's first fight gets a bug team that grows every 5 levels.
	db BUGSY, BUGSY1
	dw Bugsy1LevelParties
	db -1 ; end of table

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

; all includes must be down here
INCLUDE "data/trainers/scaled_teams/falkner1.asm"
INCLUDE "data/trainers/scaled_teams/bugsy1.asm"
