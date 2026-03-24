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

CyndaquilEvosAttacks:
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

TotodileEvosAttacks:
CroconawEvosAttacks:
FeraligatrEvosAttacks:
ChikoritaEvosAttacks:
BayleefEvosAttacks:
MeganiumEvosAttacks:
TogepiEvosAttacks:
TogeticEvosAttacks:
TogekissEvosAttacks:
CharmanderEvosAttacks:
CharmeleonEvosAttacks:
CharizardEvosAttacks:
SquirtleEvosAttacks:
WartortleEvosAttacks:
BlastoiseEvosAttacks:
TurtwigEvosAttacks:
GrotleEvosAttacks:
TorterraEvosAttacks:
PikachuEvosAttacks:
RaichuEvosAttacks:
EeveeEvosAttacks:
SylveonEvosAttacks:
TorchicEvosAttacks:
CombuskenEvosAttacks:
BlazikenEvosAttacks:
FeebasEvosAttacks:
MiloticEvosAttacks:
RowletEvosAttacks:
DartrixEvosAttacks:
DecidueyeEvosAttacks:
RaltsEvosAttacks:
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
SunkernEvosAttacks:
SunfloraEvosAttacks:
BunearyEvosAttacks:
LopunnyEvosAttacks:
PidgeyEvosAttacks:
PidgeottoEvosAttacks:
PidgeotEvosAttacks:
HoothootEvosAttacks:
NoctowlEvosAttacks:
ZubatEvosAttacks: ; lv 25 evo
GolbatEvosAttacks:
CrobatEvosAttacks:
TeddiursaEvosAttacks: ; lv 30 evo
UrsaringEvosAttacks:
UrsalunaEvosAttacks:
PhanpyEvosAttacks:
BellsproutEvosAttacks:
WeepinbellEvosAttacks:
VictreebelEvosAttacks:
MareepEvosAttacks:
FlaaffyEvosAttacks:
AmpharosEvosAttacks:
NidoranFEvosAttacks: ; lv 25 evo
NidorinaEvosAttacks:
NidoqueenEvosAttacks:
NidoranMEvosAttacks: ; lv 25 evo
NidorinoEvosAttacks:
NidokingEvosAttacks:
WimpodEvosAttacks:
GolisopodEvosAttacks:
MarillEvosAttacks:
AzumarillEvosAttacks:
RhyhornEvosAttacks: ; lv 30 evo
RhydonEvosAttacks:
DrilburEvosAttacks: ; lv 25 evo
ExcadrillEvosAttacks:
OnixEvosAttacks:
SteelixEvosAttacks:
MagikarpEvosAttacks:
GyaradosEvosAttacks:
GastlyEvosAttacks:
HaunterEvosAttacks:
GengarEvosAttacks:
SwabluEvosAttacks:
AltariaEvosAttacks:
NatuEvosAttacks:
KatuEvosAttacks:
XatuEvosAttacks:
SmeargleEvosAttacks:
GrowlitheEvosAttacks:
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
VoltorbEvosAttacks:
ElectrodeEvosAttacks:
ElekidEvosAttacks:
ElectabuzzEvosAttacks:
MagnemiteEvosAttacks:
MagnetonEvosAttacks:
MagnezoneEvosAttacks:
ShuckleEvosAttacks:
CorsolaEvosAttacks:
StaryuEvosAttacks:
StarmieEvosAttacks:
RemoraidEvosAttacks:
OctilleryEvosAttacks:
ChinchouEvosAttacks:
LanturnEvosAttacks:
MantineEvosAttacks:
TentacoolEvosAttacks:
TentacruelEvosAttacks:
SeelEvosAttacks:
DewgongEvosAttacks:
HorseaEvosAttacks:
SeadraEvosAttacks:
KingdraEvosAttacks:
LaprasEvosAttacks:
ClefairyEvosAttacks:
ClefableEvosAttacks:
SolrockEvosAttacks:
LunatoneEvosAttacks:
StantlerEvosAttacks:
WyrdeerEvosAttacks:
DelibirdEvosAttacks:
SmoochumEvosAttacks:
JynxEvosAttacks:
SnoruntEvosAttacks:
GlalieEvosAttacks:
FroslassEvosAttacks:
SwinubEvosAttacks:
PiloswineEvosAttacks:
MamoswineEvosAttacks:
SneaselEvosAttacks:
WeavileEvosAttacks:
SneaslerEvosAttacks:
SnoverEvosAttacks:
AbomasnowEvosAttacks:
BaltoyEvosAttacks:
ClaydolEvosAttacks:
RioluEvosAttacks:
LucarioEvosAttacks:
BronzorEvosAttacks:
BronzongEvosAttacks:
SkarmoryEvosAttacks:
MisdreavusEvosAttacks:
MismagiusEvosAttacks:
ChanseyEvosAttacks:
BlisseyEvosAttacks:
SnorlaxEvosAttacks:
LarvitarEvosAttacks:
PupitarEvosAttacks:
TyranitarEvosAttacks:
BagonEvosAttacks:
ShelgonEvosAttacks:
SalamenceEvosAttacks:
AxewEvosAttacks:
FraxureEvosAttacks:
HaxorusEvosAttacks:
PorygonEvosAttacks:
Porygon2EvosAttacks:
PorygonZEvosAttacks:
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
RegirockEvosAttacks:
RegiceEvosAttacks:
RegisteelEvosAttacks:
RegigigasEvosAttacks:
ArticunoEvosAttacks:
ZapdosEvosAttacks:
MoltresEvosAttacks:
LugiaEvosAttacks:
RaikouEvosAttacks:
EnteiEvosAttacks:
SuicuneEvosAttacks:
HoOhEvosAttacks:
UnownEvosAttacks:
VictiniEvosAttacks:
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
	db 1, CROSS_CHOP
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