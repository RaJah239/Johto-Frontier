SECTION "Evolutions and Attacks", ROMX

; Evos+attacks data structure:
; - Evolution methods:
;    * db EVOLVE_LEVEL, level, species
;    * db EVOLVE_ITEM, used item, species
;    * db EVOLVE_TRADE, held item (or -1 for none), species
;    * db EVOLVE_HAPPINESS, TR_* constant (ANYTIME, MORNDAY, EVENITE), species
;    * db EVOLVE_STAT, level, ATK_*_DEF constant (LT, GT, EQ), species
; - db 0 ; no more evolutions
; - Learnset (in increasing level order):
;    * db level, move
; - db 0 ; no more level-up moves

INCLUDE "data/pokemon/evolution_moves.asm"
INCLUDE "data/pokemon/evos_attacks_pointers.asm"

EvosAttacks::

	db EVOLVE_LEVEL, 16, QUILAVA
QuilavaEvosAttacks:
	db EVOLVE_LEVEL, 36, TYPHLOSION
TyphlosionEvosAttacks:
	db 0 ; no more evolutions
	db 1, TACKLE
	db 1, LEER
	db 6, EMBER
	db 6, MUD_SLAP
	db 9, SMOKESCREEN
	db 12, FURY_STRIKES
	db 16, SPARK
	db 20, QUICK_ATTACK
	db 24, FLAME_CHARGE
	db 27, ROLLOUT
	db 31, FLAMETHROWER
	db 31, EARTH_POWER
	db 36, DOUBLE_EDGE
	db 0 ; no more level-up moves

; (each of these ends its own evolution list, so it doesn't pick up the
; next family's evolutions; the learnset is the shared default below)
PorygonEvosAttacks:
	db EVOLVE_TRADE, UP_GRADE, PORYGON2
	db 0 ; no more evolutions
	db 1, SPLASH
	db 0 ; no more level-up moves

Porygon2EvosAttacks:
	db EVOLVE_HAPPINESS, TR_ANYTIME, PORYGONZ
	db 0 ; no more evolutions
	db 1, SPLASH
	db 0 ; no more level-up moves

ChanseyEvosAttacks:
	db EVOLVE_HAPPINESS, TR_ANYTIME, BLISSEY
	db 0 ; no more evolutions
	db 1, SPLASH
	db 0 ; no more level-up moves

MagikarpEvosAttacks:
	db EVOLVE_LEVEL, 20, GYARADOS
GyaradosEvosAttacks:

PorygonZEvosAttacks:
BlisseyEvosAttacks:
CroconawEvosAttacks:
FeraligatrEvosAttacks:
BayleefEvosAttacks:
MeganiumEvosAttacks:
TogeticEvosAttacks:
TogekissEvosAttacks:
CharmeleonEvosAttacks:
CharizardEvosAttacks:
WartortleEvosAttacks:
BlastoiseEvosAttacks:
TorterraEvosAttacks:
PikachuEvosAttacks:
RaichuEvosAttacks:
EeveeEvosAttacks:
EspeonEvosAttacks:
FlareonEvosAttacks:
JolteonEvosAttacks:
VaporeonEvosAttacks:
SylveonEvosAttacks:
CombuskenEvosAttacks:
BlazikenEvosAttacks:
FeebasEvosAttacks:
MiloticEvosAttacks:
KirliaEvosAttacks:
GardevoirEvosAttacks:
GalladeEvosAttacks:
WurmpleEvosAttacks:
SilcoonEvosAttacks:
BeautiflyEvosAttacks:
CascoonEvosAttacks:
DustoxEvosAttacks:
YanmaEvosAttacks:
YanmegaEvosAttacks:
BunearyEvosAttacks:
LopunnyEvosAttacks:
PidgeottoEvosAttacks:
PidgeotEvosAttacks:
HoothootEvosAttacks:
NoctowlEvosAttacks:
GolbatEvosAttacks:
CrobatEvosAttacks:
UrsaringEvosAttacks:
UrsalunaEvosAttacks:
UrsalunaBEvosAttacks:
PhanpyEvosAttacks:
BellsproutEvosAttacks:
WeepinbellEvosAttacks:
VictreebelEvosAttacks:
FlaaffyEvosAttacks:
AmpharosEvosAttacks:
MarillEvosAttacks:
AzumarillEvosAttacks:
RhydonEvosAttacks:
DrilburEvosAttacks: ; lv 25 evo
ExcadrillEvosAttacks:
OnixEvosAttacks:
SteelixEvosAttacks:
HaunterEvosAttacks:
GengarEvosAttacks:
SwabluEvosAttacks:
AltariaEvosAttacks:
SmeargleEvosAttacks:
ArcanineEvosAttacks:
HoundourEvosAttacks:
HoundoomEvosAttacks:
WooperEvosAttacks: ; lv 25 evo
QuagsireEvosAttacks:
GligarEvosAttacks:
GliscorEvosAttacks:
GibleEvosAttacks:
GabiteEvosAttacks:
GarchompEvosAttacks:
MakuhitaEvosAttacks:
HariyamaEvosAttacks:
DoduoEvosAttacks:
DodrioEvosAttacks:
PonytaEvosAttacks:
RapidashEvosAttacks:
SlowpokeEvosAttacks:
SlowbroEvosAttacks:
ShroomishEvosAttacks:
BreloomEvosAttacks:
SpinarakEvosAttacks:
AriadosEvosAttacks:
VenipedeEvosAttacks:
WhirlipedeEvosAttacks:
ScolipedeEvosAttacks:
JoltikEvosAttacks:
GalvantulaEvosAttacks:
SkorupiEvosAttacks:
DrapionEvosAttacks:
LarvestaEvosAttacks:
VolcaronaEvosAttacks:
IronMothEvosAttacks:
TropiusEvosAttacks:
MankeyEvosAttacks:
PrimeapeEvosAttacks:
AnnihilapeEvosAttacks:
FerroseedEvosAttacks:
FerrothornEvosAttacks:
ScytherEvosAttacks:
ScizorEvosAttacks:
KleavorEvosAttacks:
HeracrossEvosAttacks:
TangelaEvosAttacks:
TangrowthEvosAttacks:
MeowthEvosAttacks:
PersianEvosAttacks:
SnubbullEvosAttacks:
GranbullEvosAttacks:
DrowzeeEvosAttacks:
HypnoEvosAttacks:
MrMimeEvosAttacks:
SudowoodoEvosAttacks:
KoffingEvosAttacks:
WeezingEvosAttacks:
GrimerEvosAttacks:
MukEvosAttacks:
LitwickEvosAttacks:
LampentEvosAttacks:
ChandelureEvosAttacks:
MiltankEvosAttacks:
TaurosEvosAttacks:
ElectrodeEvosAttacks:
ElectabuzzEvosAttacks:
MagnetonEvosAttacks:
MagnezoneEvosAttacks:
ShuckleEvosAttacks:
CorsolaEvosAttacks:
StaryuEvosAttacks:
StarmieEvosAttacks:
ChinchouEvosAttacks:
LanturnEvosAttacks:
TentacoolEvosAttacks:
TentacruelEvosAttacks:
SeadraEvosAttacks:
KingdraEvosAttacks:
LaprasEvosAttacks:
ClefairyEvosAttacks:
ClefableEvosAttacks:
SolrockEvosAttacks:
LunatoneEvosAttacks:
DelibirdEvosAttacks:
JynxEvosAttacks:
SnoruntEvosAttacks:
GlalieEvosAttacks:
FroslassEvosAttacks:
PiloswineEvosAttacks:
MamoswineEvosAttacks:
SneaselEvosAttacks:
WeavileEvosAttacks:
SneaslerEvosAttacks:
SnoverEvosAttacks:
AbomasnowEvosAttacks:
BaltoyEvosAttacks:
ClaydolEvosAttacks:
LucarioEvosAttacks:
BronzorEvosAttacks:
BronzongEvosAttacks:
SkarmoryEvosAttacks:
AggronEvosAttacks:
AegislashEvosAttacks:
MisdreavusEvosAttacks:
MismagiusEvosAttacks:
SnorlaxEvosAttacks:
TyranitarEvosAttacks:
SalamenceEvosAttacks:
MetagrossEvosAttacks:
HaxorusEvosAttacks:
OmanyteEvosAttacks:
OmastarEvosAttacks:
LileepEvosAttacks:
CradilyEvosAttacks:
AerodactylEvosAttacks:
RotomEvosAttacks:
AbsolEvosAttacks:
DuraludonEvosAttacks:
GholdengoEvosAttacks:
DarkraiEvosAttacks:
ArticunoEvosAttacks:
ZapdosEvosAttacks:
MoltresEvosAttacks:
LugiaEvosAttacks:
RaikouEvosAttacks:
EnteiEvosAttacks:
SuicuneEvosAttacks:
HoOhEvosAttacks:
UnownEvosAttacks:
JirachiEvosAttacks:
CelebiEvosAttacks:
DittoEvosAttacks:
MewEvosAttacks:
MewtwoEvosAttacks:
	db 0 ; no more evolutions
	db 1, SPLASH
	db 0 ; no more level-up moves

; to redo
DonphanEvosAttacks:
	db 0 ; no more evolutions
	db 1, BRICK_BREAK
	db 1, BODY_PRESS
	db 1, BULK_UP
	db 1, COUNTER
	db 1, CLOSE_COMBAT
	db 0 ; no more level-up moves

NownEvosAttacks:
	db 0 ; no more evolutions
	db 1, HIDDEN_POWER
	db 1, HIDDEN_FORCE
	db 1, RUNIC_POWER
	db 0 ; no more level-up moves

UmbreonEvosAttacks:
	db 0 ; no more evolutions
	db 1, PAIN_SPLIT
	db 0 ; no more level-up moves