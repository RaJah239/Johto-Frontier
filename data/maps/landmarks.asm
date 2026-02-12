MACRO landmark
; x, y, name
	db \1 + 8, \2 + 16
	dw \3
ENDM

Landmarks:
; entries correspond to constants/landmark_constants.asm
	table_width 4, Landmarks
	landmark  -8, -16, SpecialMapName
	landmark 132, 100, NewBarkTownName
	landmark 116, 100, Route1Name
	landmark  92, 100, CherrygroveCityName
	landmark  92,  84, Route2Name
	landmark 100,  60, DarkCaveName
	landmark  88,  60, Route3Name
	landmark  76,  60, VioletCityName
	landmark  76,  56, SproutTowerName
	landmark  68,  76, RuinsOfAlphName
	landmark  76,  92, Route4Name
	landmark  76, 124, UnionCaveName
	landmark  72, 124, Route5Name
	landmark  60, 124, AzaleaTownName
	landmark  62, 122, SlowpokeWellName
	landmark  44, 124, IlexForestName
	landmark  44, 108, Route6Name
	landmark  44,  92, GoldenrodCityName
	landmark  42,  92, RadioTowerName
	landmark  44,  76, Route7Name
	landmark  44,  60, NationalParkName
	landmark  60,  60, Route8Name
	landmark  60,  52, Route9Name
	landmark  60,  44, EcruteakCityName
	landmark  62,  42, TinTowerName
	landmark  58,  42, BurnedTowerName
	landmark  44,  44, Route10Name
	landmark  36,  28, SilverCaveName
	landmark  28,  48, Route11Name
	landmark  28,  60, OlivineCityName
	landmark  30,  62, LighthouseName
	landmark  20,  60, Route12Name
	landmark  20,  52, PowerPlantName
	landmark  20,  92, WhirlIslandsName
	landmark  20, 100, Route41Name
	landmark  12, 100, CianwoodCityName
	landmark  76,  44, MtMortarName
	landmark  84,  44, Route42Name
	landmark 100,  44, MahoganyTownName
	landmark 100,  36, Route43Name
	landmark 100,  28, LakeOfRageName
	landmark 112,  44, Route44Name
	landmark 124,  36, IcePathName
	landmark 124,  44, BlackthornCityName
	landmark 124,  40, DragonsDenName
	landmark 124,  64, Route45Name
	landmark 116,  88, Route46Name
	landmark 140, 100, TohjoFallsName
	landmark 148, 100, Route27Name
	landmark 148,  84, Route26Name
	landmark 148,  52, VictoryRoadName
	landmark 148,  44, Route23Name
	landmark 148,  36, IndigoPlateauName	
	landmark 160, 160, BattlePlazaName
	assert_table_length KANTO_LANDMARK
	landmark  52, 108, PalletTownName
	landmark 108,  76, UndergroundName
	landmark 140, 116, FastShipName
	assert_table_length NUM_LANDMARKS

NewBarkTownName:     db "New Bark<BSP>Town@"
CherrygroveCityName: db "Cherrygrove<BSP>City@"
VioletCityName:      db "Violet City@"
AzaleaTownName:      db "Azalea Town@"
GoldenrodCityName:   db "Goldenrod<BSP>City@"
EcruteakCityName:    db "Ecruteak<BSP>City@"
OlivineCityName:     db "Olivine<BSP>City@"
CianwoodCityName:    db "Cianwood<BSP>City@"
MahoganyTownName:    db "Mahogany<BSP>Town@"
BlackthornCityName:  db "Blackthorn<BSP>City@"
LakeOfRageName:      db "Lake Of<BSP>Rage@"
SilverCaveName:      db "Mt. Silver@"
SproutTowerName:     db "Sprout<BSP>Tower@"
RuinsOfAlphName:     db "Ruins<BSP>Of Alph@"
UnionCaveName:       db "Union Cave@"
SlowpokeWellName:    db "Slowpoke<BSP>Well@"
RadioTowerName:      db "Radio Tower@"
NationalParkName:    db "National<BSP>Park@"
TinTowerName:        db "Tin Tower@"
LighthouseName:      db "Lighthouse@"
WhirlIslandsName:    db "Whirl<BSP>Islands@"
MtMortarName:        db "Mt.Mortar@"
DragonsDenName:      db "Dragon's<BSP>Den@"
IcePathName:         db "Ice Path@"
PalletTownName:      db "Pallet Town@"
IndigoPlateauName:   db "Indigo<BSP>Plateau@"
VictoryRoadName:     db "Victory<BSP>Road@"
Route23Name:         db "Route 23@"
Route26Name:         db "Route 26@"
Route27Name:         db "Route 27@"
Route1Name:          db "Route 1@"
Route2Name:          db "Route 2@"
Route3Name:          db "Route 3@"
Route4Name:          db "Route 4@"
Route5Name:          db "Route 5@"
Route6Name:          db "Route 6@"
Route7Name:          db "Route 7@"
Route8Name:          db "Route 8@"
Route9Name:          db "Route 9@"
Route10Name:         db "Route 10@"
Route11Name:         db "Route 11@"
Route12Name:         db "Route 12@"
Route41Name:         db "Route 41@"
Route42Name:         db "Route 42@"
Route43Name:         db "Route 43@"
Route44Name:         db "Route 44@"
Route45Name:         db "Route 45@"
Route46Name:         db "Route 46@"
DarkCaveName:        db "Dark Cave@"
IlexForestName:      db "Ilex<BSP>Forest@"
BurnedTowerName:     db "Burned<BSP>Tower@"
FastShipName:        db "Fast Ship@"
TohjoFallsName:      db "Tohjo Falls@"
UndergroundName:     db "Underground@"
PowerPlantName:      db "Power Plant@"
BattlePlazaName:     db "Battle<BSP>Plaza@"
SpecialMapName:      db "Special@"
