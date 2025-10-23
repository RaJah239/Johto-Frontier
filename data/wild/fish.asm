DEF time_group EQUS "0," ; use the nth TimeFishGroups entry

MACRO fishgroup
; chance, old rod, good rod, super rod
	db \1
	dw \2, \3, \4
ENDM

FishGroups:
; entries correspond to FISHGROUP_* constants
	table_width FISHGROUP_DATA_LENGTH, FishGroups
	fishgroup 50 percent + 1, .Shore_Old,            .Shore_Good,            .Shore_Super
	fishgroup 50 percent + 1, .Ocean_Old,            .Ocean_Good,            .Ocean_Super
	fishgroup 50 percent + 1, .Lake_Old,             .Lake_Good,             .Lake_Super
	fishgroup 50 percent + 1, .Pond_Old,             .Pond_Good,             .Pond_Super
	fishgroup 50 percent + 1, .FEEBAS_Old,          .FEEBAS_Good,          .FEEBAS_Super
	fishgroup 50 percent + 1, .FEEBAS_Swarm_Old,     .Feebas_Swarm_Good,     .Feebas_Swarm_Super
	fishgroup 50 percent + 1, .Remoraid_Swarm_Old,   .Remoraid_Swarm_Good,   .Remoraid_Swarm_Super
	fishgroup 50 percent + 1, .Gyarados_Old,         .Gyarados_Good,         .Gyarados_Super
	fishgroup 50 percent + 1, .FEEBAS_2_Old,        .FEEBAS_2_Good,        .FEEBAS_2_Super
	fishgroup 50 percent + 1, .WhirlIslands_Old,     .WhirlIslands_Good,     .WhirlIslands_Super
	fishgroup 50 percent + 1, .FEEBAS_Old,           .Feebas_Good,           .Feebas_Super
	fishgroup 50 percent + 1, .Remoraid_Old,         .Remoraid_Good,         .Remoraid_Super
	fishgroup 50 percent + 1, .FEEBAS_NoSwarm_Old,   .Feebas_NoSwarm_Good,   .Feebas_NoSwarm_Super
	assert_table_length NUM_FISHGROUPS

.Shore_Old:
	db  70 percent + 1, MAGIKARP,   10
	db  85 percent + 1, MAGIKARP,   10
	db 100 percent,     FEEBAS,     10
.Shore_Good:
	db  35 percent,     MAGIKARP,   20
	db  70 percent,     FEEBAS,     20
	db  90 percent + 1, FEEBAS,     20
	db 100 percent,     time_group 0
.Shore_Super:
	db  40 percent,     FEEBAS,     40
	db  70 percent,     time_group 1
	db  90 percent + 1, FEEBAS,     40
	db 100 percent,     MAGIKARP,   40

.Ocean_Old:
	db  70 percent + 1, MAGIKARP,   10
	db  85 percent + 1, MAGIKARP,   10
	db 100 percent,     TENTACOOL,  10
.Ocean_Good:
	db  35 percent,     MAGIKARP,   20
	db  70 percent,     TENTACOOL,  20
	db  90 percent + 1, CHINCHOU,   20
	db 100 percent,     time_group 2
.Ocean_Super:
	db  40 percent,     CHINCHOU,   40
	db  70 percent,     time_group 3
	db  90 percent + 1, TENTACRUEL, 40
	db 100 percent,     LANTURN,    40

.Lake_Old:
	db  70 percent + 1, MAGIKARP,   10
	db  85 percent + 1, MAGIKARP,   10
	db 100 percent,     FEEBAS,    10
.Lake_Good:
	db  35 percent,     MAGIKARP,   20
	db  70 percent,     FEEBAS,    20
	db  90 percent + 1, FEEBAS,    20
	db 100 percent,     time_group 4
.Lake_Super:
	db  40 percent,     FEEBAS,    40
	db  70 percent,     time_group 5
	db  90 percent + 1, MAGIKARP,   40
	db 100 percent,     FEEBAS,    40

.Pond_Old:
	db  70 percent + 1, MAGIKARP,   10
	db  85 percent + 1, MAGIKARP,   10
	db 100 percent,     FEEBAS,    10
.Pond_Good:
	db  35 percent,     MAGIKARP,   20
	db  70 percent,     FEEBAS,    20
	db  90 percent + 1, FEEBAS,    20
	db 100 percent,     time_group 6
.Pond_Super:
	db  40 percent,     FEEBAS,    40
	db  70 percent,     time_group 7
	db  90 percent + 1, MAGIKARP,   40
	db 100 percent,     FEEBAS,    40

.FEEBAS_Old:
	db  70 percent + 1, MAGIKARP,   10
	db  85 percent + 1, MAGIKARP,   10
	db 100 percent,     MAGIKARP,   10
.FEEBAS_Good:
	db  35 percent,     MAGIKARP,   20
	db  70 percent,     MAGIKARP,   20
	db  90 percent + 1, MAGIKARP,   20
	db 100 percent,     time_group 8
.FEEBAS_Super:
	db  40 percent,     MAGIKARP,   40
	db  70 percent,     time_group 9
	db  90 percent + 1, MAGIKARP,   40
	db 100 percent,     FEEBAS,  40

.FEEBAS_Swarm_Old:
	db  70 percent + 1, MAGIKARP,   5
	db  85 percent + 1, MAGIKARP,   5
	db 100 percent,     FEEBAS,     5
.Feebas_Swarm_Good:
	db  35 percent,     MAGIKARP,   20
	db  70 percent,     FEEBAS,     20
	db  90 percent + 1, FEEBAS,     20
	db 100 percent,     time_group 10
.Feebas_Swarm_Super:
	db  40 percent,     FEEBAS,     40
	db  70 percent,     time_group 11
	db  90 percent + 1, FEEBAS,     40
	db 100 percent,     FEEBAS,     40

.Remoraid_Swarm_Old:
	db  70 percent + 1, MAGIKARP,   10
	db  85 percent + 1, MAGIKARP,   10
	db 100 percent,     REMORAID,   10
.Remoraid_Swarm_Good:
	db  35 percent,     MAGIKARP,   20
	db  70 percent,     REMORAID,   20
	db  90 percent + 1, REMORAID,   20
	db 100 percent,     time_group 12
.Remoraid_Swarm_Super:
	db  40 percent,     REMORAID,   40
	db  70 percent,     time_group 13
	db  90 percent + 1, REMORAID,   40
	db 100 percent,     REMORAID,   40

.Gyarados_Old:
	db  70 percent + 1, MAGIKARP,   10
	db  85 percent + 1, MAGIKARP,   10
	db 100 percent,     MAGIKARP,   10
.Gyarados_Good:
	db  35 percent,     MAGIKARP,   20
	db  70 percent,     MAGIKARP,   20
	db  90 percent + 1, MAGIKARP,   20
	db 100 percent,     time_group 14
.Gyarados_Super:
	db  40 percent,     MAGIKARP,   40
	db  70 percent,     time_group 15
	db  90 percent + 1, MAGIKARP,   40
	db 100 percent,     MAGIKARP,   40

.FEEBAS_2_Old:
	db  70 percent + 1, MAGIKARP,   10
	db  85 percent + 1, MAGIKARP,   10
	db 100 percent,     MAGIKARP,   10
.FEEBAS_2_Good:
	db  35 percent,     MAGIKARP,   10
	db  70 percent,     MAGIKARP,   10
	db  90 percent + 1, MAGIKARP,   10
	db 100 percent,     time_group 16
.FEEBAS_2_Super:
	db  40 percent,     MAGIKARP,   10
	db  70 percent,     time_group 17
	db  90 percent + 1, MAGIKARP,   10
	db 100 percent,     FEEBAS,  10

.WhirlIslands_Old:
	db  70 percent + 1, MAGIKARP,   10
	db  85 percent + 1, MAGIKARP,   10
	db 100 percent,     FEEBAS,     10
.WhirlIslands_Good:
	db  35 percent,     MAGIKARP,   20
	db  70 percent,     FEEBAS,     20
	db  90 percent + 1, FEEBAS,     20
	db 100 percent,     time_group 18
.WhirlIslands_Super:
	db  40 percent,     FEEBAS,     40
	db  70 percent,     time_group 19
	db  90 percent + 1, MAGIKARP,   40
	db 100 percent,     SEADRA,     40

.FEEBAS_NoSwarm_Old:
	db  70 percent + 1, MAGIKARP,   10
	db  85 percent + 1, MAGIKARP,   10
	db 100 percent,     TENTACOOL,  10
.Feebas_NoSwarm_Good:
.Feebas_Good:
	db  35 percent,     MAGIKARP,   20
	db  70 percent,     TENTACOOL,  20
	db  90 percent + 1, TENTACOOL,  20
	db 100 percent,     time_group 20
.Feebas_NoSwarm_Super:
.Feebas_Super:
	db  40 percent,     TENTACOOL,  40
	db  70 percent,     time_group 21
	db  90 percent + 1, MAGIKARP,   40
	db 100 percent,     FEEBAS,     40

.Remoraid_Old:
	db  70 percent + 1, MAGIKARP,   10
	db  85 percent + 1, MAGIKARP,   10
	db 100 percent,     FEEBAS,    10
.Remoraid_Good:
	db  35 percent,     MAGIKARP,   20
	db  70 percent,     FEEBAS,    20
	db  90 percent + 1, FEEBAS,    20
	db 100 percent,     time_group 6
.Remoraid_Super:
	db  40 percent,     FEEBAS,    40
	db  70 percent,     time_group 7
	db  90 percent + 1, MAGIKARP,   40
	db 100 percent,     REMORAID,   40

TimeFishGroups:
	;  day              nite
	db CORSOLA,    20,  STARYU,     20 ; 0
	db CORSOLA,    40,  STARYU,     40 ; 1
	db FEEBAS,    20,  FEEBAS,    20 ; 2
	db FEEBAS,    40,  FEEBAS,    40 ; 3
	db FEEBAS,    20,  FEEBAS,    20 ; 4
	db FEEBAS,    40,  FEEBAS,    40 ; 5
	db FEEBAS,     20,   FEEBAS,    20 ; 6
	db FEEBAS,     40,   FEEBAS,    40 ; 7
	db FEEBAS,    20,  FEEBAS,    20 ; 8
	db FEEBAS,    40,  FEEBAS,    40 ; 9
	db FEEBAS,     20,  FEEBAS,     20 ; 10
	db FEEBAS,     40,  FEEBAS,     40 ; 11
	db REMORAID,   20,  REMORAID,   20 ; 12
	db REMORAID,   40,  REMORAID,   40 ; 13
	db GYARADOS,   20,  GYARADOS,   20 ; 14
	db GYARADOS,   40,  GYARADOS,   40 ; 15
	db FEEBAS,    10,  FEEBAS,    10 ; 16
	db FEEBAS,    10,  FEEBAS,    10 ; 17
	db HORSEA,     20,  HORSEA,     20 ; 18
	db HORSEA,     40,  HORSEA,     40 ; 19
	db TENTACOOL,  20,  TENTACOOL,  20 ; 20
	db TENTACOOL,  40,  TENTACOOL,  40 ; 21

FishGroups_Names::
 	table_width 2, FishGroups_Names
 	dw Group1_Name
 	dw Group2_Name
 	dw Group3_Name
 	dw Group4_Name
 	dw Group5_Name
 	dw Group6_Name
 	dw Group7_Name
 	dw Group8_Name
 	dw Group9_Name
 	dw Group10_Name
 	dw Group11_Name
 	dw Group12_Name
 	dw Group13_Name
 	assert_table_length NUM_FISHGROUPS ; (13, NONE is not included in the count)
 
 Group1_Name:
 	db " SHORE@"
 Group2_Name:
 	db " OCEAN@"
 Group3_Name:
 	db " LAKE@"
 Group4_Name:
 	db " POND@"
 Group5_Name:
 	db " FEEBAS@"
 Group6_Name:
 	db " SWARM 1@"
 Group7_Name:
 	db " SWARM 2@"
 Group8_Name:
 	db " GYARADOS@"
 Group9_Name:
 	db " ROUTE 45@"
 	; db " FEEBAS 2@"
 Group10_Name:
 	db " WHIRL@"
 Group11_Name:
 	db " FEEBAS@"
 Group12_Name:
 	db " REMORAID@"
 Group13_Name:
 	db " ROUTE 12@"
 	; db " FEEBAS 2@"
 
 GetFishGroupName:
 ; given fishing group num in 'a'
 ; return str ptr in 'de'
 	dec a
 	add a ; doubles the index since ptrs are 2 bytes
 	ld hl, FishGroups_Names
 	ld d, 0
 	ld e, a
 	add hl, de
 	ld e, [hl]
 	inc hl
 	ld d, [hl]
 	ret
 
 GetMapsFishGroup::
 	dec d ; map num
 	dec e ; map group
 	push de
 	ld d, 0
 	; 'e' is the map group
 	ld hl, MapGroupPointers
 	add hl, de ; since ptrs are 2 bytes, double the index
 	add hl, de
 	ld a, BANK(MapGroupPointers)
 	call GetFarWord
 	pop de
 	ld a, d ; map num becomes the index, do the same as map group
 	ld bc, MAP_LENGTH
 	; hl is pointing to map group ptr
 	call AddNTimes ;  Add bc * a to hl.
 	; fish group is the very last byte in the entry
 	ld bc, MAP_LENGTH - 1
 	add hl, bc
 	ld a, BANK(MapGroupPointers)
 	call GetFarByte
 	; ld a, [hl] ; fishing group
 	cp FISHGROUP_NONE
 	jr z, .fishgroup_none
 	call GetFishGroupName
 	; ptr to fishgroup name is in de
 	ret
 .fishgroup_none
 	xor a
 	ld d, a
 	ld e, a
 	ret
 
 ; GetNextMapName_FishGroup:
 ; given: Fish group
 ; given: page number + num already printed
 ; calculate the map number of next map entry with that fishing group
 ; get map name based on map index
 ; return: map name ptr in 'de'
