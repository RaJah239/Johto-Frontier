TypeNames:
; entries correspond to types (see constants/type_constants.asm)
	table_width 2, TypeNames

	dw Normal
	dw Fighting
	dw Flying
	dw Poison
	dw Ground
	dw Rock
	dw Bird
	dw Bug
	dw Ghost
	dw Steel
	assert_table_length UNUSED_TYPES

rept UNUSED_TYPES_END - UNUSED_TYPES - 1 ; discount CURSE_TYPE
	dw Normal
endr
	dw CurseType
	assert_table_length UNUSED_TYPES_END

	dw Fire
	dw Water
	dw Grass
	dw Electric
	dw Psychic
	dw Ice
	dw Dragon
	dw Dark
	dw Fairy
	assert_table_length TYPES_END

Normal:    db "Normal@"
Fighting:  db "Fighting@"
Flying:    db "Flying@"
Poison:    db "Poison@"
CurseType: db "???@"
Fire:      db "Fire@"
Water:     db "Water@"
Grass:     db "Grass@"
Electric:  db "Electric@"
Psychic:   db "Psychic@"
Ice:       db "Ice@"
Ground:    db "Ground@"
Rock:      db "Rock@"
Bird:      db "Bird@"
Bug:       db "Bug@"
Ghost:     db "Ghost@"
Steel:     db "Steel@"
Dragon:    db "Dragon@"
Dark:      db "Dark@"
Fairy:     db "Fairy@"

TypeNamesShort:
; entries correspond to types (see constants/type_constants.asm)
; 3-letter abbreviations used in the battle moves menu info box.
	table_width 2, TypeNamesShort

	dw NormalShort
	dw FightingShort
	dw FlyingShort
	dw PoisonShort
	dw GroundShort
	dw RockShort
	dw BirdShort
	dw BugShort
	dw GhostShort
	dw SteelShort
	assert_table_length UNUSED_TYPES

rept UNUSED_TYPES_END - UNUSED_TYPES - 1 ; discount CURSE_TYPE
	dw NormalShort
endr
	dw CurseTypeShort
	assert_table_length UNUSED_TYPES_END

	dw FireShort
	dw WaterShort
	dw GrassShort
	dw ElectricShort
	dw PsychicShort
	dw IceShort
	dw DragonShort
	dw DarkShort
	dw FairyShort
	assert_table_length TYPES_END

NormalShort:    db "Nrm@"
FightingShort:  db "Fgt@"
FlyingShort:    db "Fly@"
PoisonShort:    db "Psn@"
GroundShort:    db "Grn@"
RockShort:      db "Rck@"
BirdShort:      db "Brd@"
BugShort:       db "Bug@"
GhostShort:     db "Gho@"
SteelShort:     db "Stl@"
CurseTypeShort: db "???@"
FireShort:      db "Fir@"
WaterShort:     db "Wtr@"
GrassShort:     db "Grs@"
ElectricShort:  db "Ele@"
PsychicShort:   db "Psy@"
IceShort:       db "Ice@"
DragonShort:    db "Dra@"
DarkShort:      db "Drk@"
FairyShort:     db "Fry@"
