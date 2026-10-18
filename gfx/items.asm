; item icons (3x3 tiles each), displayed in marts (and the bag)
; ported from timkun55 (icons by polishedcrystal)

UpdateItemIconAndBagQuantity::
	farcall MartPlaceInBagQuantity
	ld a, [wCurItem]
	ld c, a
	ld de, vTiles2 tile $1d ; mart icon window
	jr _LoadItemIcon

UpdateItemIconAndDescription::
	farcall UpdateItemDescription
	ld a, [wCurItem]
	ld c, a
	ld de, vTiles2 tile $06 ; pack icon window
	jr _LoadItemIcon

LoadTMHMIcon::
; blit the TM/HM icon; its colors come from LoadTMHMIconPalette
	ld hl, TMHMIcon
	ld de, vTiles2 tile $06 ; pack icon window
	lb bc, BANK(TMHMIcon), $9
	jp DecompressRequest2bpp

ClearTMHMIcon::
	ld c, NO_ITEM
	ld de, vTiles2 tile $06 ; pack icon window
	jr _LoadItemIcon

_LoadItemIcon:
; c = item id, de = VRAM destination
	call DecompressItemIcon
	farcall LoadItemIconPalette
	call SetDefaultBGPAndOBP
	call WaitBGMap
	ret

DecompressItemIcon:
; c = item id; ids of NUM_ITEMS + 1 and up (TMs, and the bag's
; Cancel row, which reports $ff, ...) have no icon, so they get
; the blank one, like in timkun55
	ld a, c
	cp NUM_ITEMS + 1
	jr c, .ok_id
	xor a
.ok_id
	ld hl, ItemIconPointers
	ld c, a
	ld b, 0
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	lb bc, BANK(BlankItemIcon), $9
	jp DecompressRequest2bpp

LoadItemIconPalette::
; load the item's 2 icon colors into BG palette 7, colors 1-2
	ld a, [wCurItem]
	cp NUM_ITEMS + 1
	jr c, .ok
	ld a, NUM_ITEMS + 1 ; TMs use the last palette entry
.ok
	ld hl, ItemIconPalettes
	ld c, a
	ld b, 0
	add hl, bc
	add hl, bc
	add hl, bc
	add hl, bc
	ld de, wBGPals1 palette 7 + 2
	ld bc, 4
	call FarCopyColorWRAM
	ld hl, .BlackColor
	ld bc, 2
	call FarCopyColorWRAM
	ret

.BlackColor:
	RGB 00, 00, 00

ItemIconPointers:
	dw BlankItemIcon ; NO_ITEM
	dw MasterBallIcon ; MASTER_BALL
	dw UltraBallIcon ; ULTRA_BALL
	dw BrightpowderIcon ; BRIGHTPOWDER
	dw GreatBallIcon ; GREAT_BALL
	dw PokeBallIcon ; POKE_BALL
	dw BlankItemIcon ; SCYTHER_CALL
	dw BicycleIcon ; BICYCLE
	dw MoonStoneIcon ; MOON_STONE
	dw AntidoteIcon ; ANTIDOTE
	dw AntidoteIcon ; BURN_HEAL
	dw AntidoteIcon ; ICE_HEAL
	dw AntidoteIcon ; AWAKENING
	dw AntidoteIcon ; PARLYZ_HEAL
	dw FullRestoreIcon ; FULL_RESTORE
	dw FullRestoreIcon ; MAX_POTION
	dw HyperPotionIcon ; HYPER_POTION
	dw HyperPotionIcon ; SUPER_POTION
	dw HyperPotionIcon ; POTION
	dw EscapeRopeIcon ; ESCAPE_ROPE
	dw RepelIcon ; REPEL
	dw MaxElixerIcon ; MAX_ELIXER
	dw FireStoneIcon ; FIRE_STONE
	dw ThunderStoneIcon ; THUNDERSTONE
	dw WaterStoneIcon ; WATER_STONE
	dw BlankItemIcon ; LANTURN_CALL
	dw HPUpIcon ; HP_UP
	dw ProteinIcon ; PROTEIN
	dw ProteinIcon ; IRON
	dw ProteinIcon ; CARBOS
	dw LuckyPunchIcon ; LUCKY_PUNCH
	dw ProteinIcon ; CALCIUM
	dw RareCandyIcon ; RARE_CANDY
	dw XAccuracyIcon ; X_ACCURACY
	dw LeafStoneIcon ; LEAF_STONE
	dw ChoiceSpecsIcon ; CHOICE_SPECS
	dw NuggetIcon ; NUGGET
	dw PokeDollIcon ; POKE_DOLL
	dw FullHealIcon ; FULL_HEAL
	dw ReviveIcon ; REVIVE
	dw MaxReviveIcon ; MAX_REVIVE
	dw BlankItemIcon ; ZOOM_LENS
	dw RepelIcon ; SUPER_REPEL
	dw RepelIcon ; MAX_REPEL
	dw BlankItemIcon ; FROST_SHARD
	dw BlankItemIcon ; SILVER_BERRY
	dw FreshWaterIcon ; FRESH_WATER
	dw SodaPopIcon ; SODA_POP
	dw LemonadeIcon ; LEMONADE
	dw BlankItemIcon ; RAIN_SHARD
	dw BlankItemIcon ; DONPHAN_CALL
	dw BlankItemIcon ; SUN_SHARD
	dw BlankItemIcon ; HASTE_HERB
	dw BlankItemIcon ; SAND_SHARD
	dw CoinCaseIcon ; COIN_CASE
	dw ItemfinderIcon ; ITEMFINDER
	dw BlankItemIcon ; LIGHT_CLAY
	dw BlankItemIcon ; FOCUS_SASH
	dw OldRodIcon ; OLD_ROD
	dw GoodRodIcon ; GOOD_ROD
	dw SilverLeafIcon ; SILVER_LEAF
	dw SuperRodIcon ; SUPER_ROD
	dw PPUpIcon ; PP_UP
	dw MaxElixerIcon ; ETHER
	dw MaxElixerIcon ; MAX_ETHER
	dw MaxElixerIcon ; ELIXER
	dw BlankItemIcon ; POCKET_PC
	dw BlankItemIcon ; MOVE_DEX
	dw BlankItemIcon ; MAREEP_CALL
	dw BlankItemIcon ; AMBROSIA
	dw ClearBellIcon ; CLEAR_BELL
	dw SilverWingIcon ; SILVER_WING
	dw MoomooMilkIcon ; MOOMOO_MILK
	dw QuickClawIcon ; QUICK_CLAW
	dw PechaBerryIcon ; PSNCUREBERRY
	dw SilverLeafIcon ; GOLD_LEAF
	dw BrightpowderIcon ; SOFT_SAND
	dw SharpBeakIcon ; SHARP_BEAK
	dw CheriBerryIcon ; PRZCUREBERRY
	dw AspearBerryIcon ; BURNT_BERRY
	dw RawstBerryIcon ; ICE_BERRY
	dw PoisonBarbIcon ; POISON_BARB
	dw KingsRockIcon ; KINGS_ROCK
	dw PersimBerryIcon ; BITTER_BERRY
	dw ChestoBerryIcon ; MINT_BERRY
	dw RedApricornIcon ; RED_APRICORN
	dw TinyMushroomIcon ; TINYMUSHROOM
	dw BigMushroomIcon ; BIG_MUSHROOM
	dw SilverPowderIcon ; SILVERPOWDER
	dw RedApricornIcon ; BLU_APRICORN
	dw BlankItemIcon ; KINGDRA_CALL
	dw AmuletCoinIcon ; AMULET_COIN
	dw RedApricornIcon ; YLW_APRICORN
	dw RedApricornIcon ; GRN_APRICORN
	dw CleanseTagIcon ; CLEANSE_TAG
	dw MysticWaterIcon ; MYSTIC_WATER
	dw TwistedSpoonIcon ; TWISTEDSPOON
	dw RedApricornIcon ; WHT_APRICORN
	dw BlackbeltIcon ; BLACKBELT_I
	dw RedApricornIcon ; BLK_APRICORN
	dw BlankItemIcon ; MILOTIC_CALL
	dw RedApricornIcon ; PNK_APRICORN
	dw BlackGlassesIcon ; BLACKGLASSES
	dw BlankItemIcon ; WIDE_LENS
	dw PinkBowIcon ; PINK_BOW
	dw LeekIcon ; STICK
	dw SmokeBallIcon ; SMOKE_BALL
	dw NeverMeltIceIcon ; NEVERMELTICE
	dw MagnetIcon ; MAGNET
	dw LumBerryIcon ; MIRACLEBERRY
	dw PearlIcon ; PEARL
	dw BigPearlIcon ; BIG_PEARL
	dw EverstoneIcon ; EVERSTONE
	dw SpellTagIcon ; SPELL_TAG
	dw RageCandyBarIcon ; RAGECANDYBAR
	dw GSBallIcon ; GS_BALL
	dw BlueCardIcon ; BLUE_CARD
	dw MiracleSeedIcon ; MIRACLE_SEED
	dw BlankItemIcon ; METEOR_MITTS
	dw FocusBandIcon ; FOCUS_BAND
	dw BlankItemIcon ; CRYSTAL
	dw SilverPowderIcon ; ENERGYPOWDER
	dw EnergyRootIcon ; ENERGY_ROOT
	dw SilverPowderIcon ; HEAL_POWDER
	dw RevivalHerbIcon ; REVIVAL_HERB
	dw HardStoneIcon ; HARD_STONE
	dw LuckyEggIcon ; LUCKY_EGG
	dw BlankItemIcon ; AEGIS_GEM
	dw BlankItemIcon ; HEAVY_BOOTS
	dw EggTicketIcon ; EGG_TICKET
	dw BlankItemIcon ; TANGELA_CALL
	dw BrightpowderIcon ; STARDUST
	dw StarPieceIcon ; STAR_PIECE
	dw BasementKeyIcon ; BASEMENT_KEY
	dw BlankItemIcon ; SHINY_BALL
	dw BlankItemIcon ; EXPERT_BELT
	dw BlankItemIcon ; SHINY_CHARM
	dw ProteinIcon ; ZINC
	dw CharcoalIcon ; CHARCOAL
	dw BerryJuiceIcon ; BERRY_JUICE
	dw ScopeLensIcon ; SCOPE_LENS
	dw LifeOrbIcon ; LIFE_ORB
	dw ChoiceBandIcon ; CHOICE_BAND
	dw MetalCoatIcon ; METAL_COAT
	dw DragonFangIcon ; DRAGON_FANG
	dw BlankItemIcon ; FLAME_ORB
	dw LeftoversIcon ; LEFTOVERS
	dw OldAmberIcon ; OLD_AMBER
	dw BlankItemIcon ; ROOT_FOSSIL
	dw HelixFossilIcon ; HELIX_FOSSIL
	dw LeppaBerryIcon ; MYSTERYBERRY
	dw DragonScaleIcon ; DRAGON_SCALE
	dw BlankItemIcon ; TOXIC_ORB
	dw MuscleBandIcon ; MUSCLE_BAND
	dw WiseGlassesIcon ; WISE_GLASSES
	dw BlankItemIcon ; TRICK_STICK
	dw BrightpowderIcon ; SACRED_ASH
	dw HeavyBallIcon ; HEAVY_BALL
	dw FlowerMailIcon ; FLOWER_MAIL
	dw LevelBallIcon ; LEVEL_BALL
	dw LureBallIcon ; LURE_BALL
	dw FastBallIcon ; FAST_BALL
	dw BlankItemIcon ; WEATHER_ROCK
	dw LightBallIcon ; LIGHT_BALL
	dw FriendBallIcon ; FRIEND_BALL
	dw MoonBallIcon ; MOON_BALL
	dw LoveBallIcon ; LOVE_BALL
	dw BlankItemIcon ; NORMAL_BOX
	dw BlankItemIcon ; GORGEOUS_BOX
	dw SunStoneIcon ; SUN_STONE
	dw PolkadotBowIcon ; POLKADOT_BOW
	dw BlankItemIcon ; ITEM_PLACEHOLDER
	dw UpGradeIcon ; UP_GRADE
	dw OranBerryIcon ; BERRY
	dw SitrusBerryIcon ; GOLD_BERRY
	dw SquirtBottleIcon ; SQUIRTBOTTLE
	dw BlankItemIcon ; HYPER_EV_UP
	dw ParkBallIcon ; PARK_BALL
	dw RainbowWingIcon ; RAINBOW_WING
	dw BlankItemIcon ; ASSAULT_VEST
	dw BlankItemIcon ; BRICK_PIECE
	dw TypeChartIcon ; TYPE_CHART
	dw BlankItemIcon ; GRIP_CLAW
	dw BlankItemIcon ; CATCH_CHARM
	dw BlankItemIcon ; MEMBERS_CARD
	dw BlankItemIcon ; NOMAD_SIGIL
	dw BlankItemIcon ; SCORE_CARD
	dw MusicPlayerIcon ; MUSIC_PLAYER
	dw BlankItemIcon ; CHOICE_SCARF
	dw BlankItemIcon ; ITEM_E3
	dw BlankItemIcon ; ITEM_E4
	dw BlankItemIcon ; ITEM_E5
	dw BlankItemIcon ; ITEM_E6
	dw BlankItemIcon ; ITEM_E7
	dw BlankItemIcon ; ITEM_E8
	dw BlankItemIcon ; ITEM_E9
	dw SurfMailIcon ; SURF_MAIL
	dw SurfMailIcon ; LITEBLUEMAIL
	dw PortraitMailIcon ; PORTRAITMAIL
	dw LovelyMailIcon ; LOVELY_MAIL
	dw EonMailIcon ; EON_MAIL
	dw MorphMailIcon ; MORPH_MAIL
	dw BlueSkyMailIcon ; BLUESKY_MAIL
	dw MusicMailIcon ; MUSIC_MAIL
	dw MirageMailIcon ; MIRAGE_MAIL
	dw TMHMIcon ; TMs

ItemIconPalettes:
INCLUDE "gfx/items/items.pal"

SECTION "Item Icons 1", ROMX
BlankItemIcon:	INCBIN "gfx/items/blank.2bpp.lz"
MasterBallIcon:	INCBIN "gfx/items/master_ball.2bpp.lz"
UltraBallIcon:	INCBIN "gfx/items/ultra_ball.2bpp.lz"
BrightpowderIcon:	INCBIN "gfx/items/sand.2bpp.lz"
GreatBallIcon:	INCBIN "gfx/items/great_ball.2bpp.lz"
PokeBallIcon:	INCBIN "gfx/items/poke_ball.2bpp.lz"
BicycleIcon:	INCBIN "gfx/items/bicycle.2bpp.lz"
MoonStoneIcon:	INCBIN "gfx/items/moon_stone.2bpp.lz"
AntidoteIcon:	INCBIN "gfx/items/antidote.2bpp.lz"
FullRestoreIcon:	INCBIN "gfx/items/max_potion.2bpp.lz"
HyperPotionIcon:	INCBIN "gfx/items/potion.2bpp.lz"
EscapeRopeIcon:	INCBIN "gfx/items/escape_rope.2bpp.lz"
RepelIcon:	INCBIN "gfx/items/repel.2bpp.lz"
MaxElixerIcon:	INCBIN "gfx/items/ether.2bpp.lz"
FireStoneIcon:	INCBIN "gfx/items/fire_stone.2bpp.lz"
ThunderStoneIcon:	INCBIN "gfx/items/thunderstone.2bpp.lz"
WaterStoneIcon:	INCBIN "gfx/items/water_stone.2bpp.lz"
HPUpIcon:	INCBIN "gfx/items/hp_up.2bpp.lz"
ProteinIcon:	INCBIN "gfx/items/vitamin.2bpp.lz"
LuckyPunchIcon:	INCBIN "gfx/items/lucky_punch.2bpp.lz"
RareCandyIcon:	INCBIN "gfx/items/rare_candy.2bpp.lz"
XAccuracyIcon:	INCBIN "gfx/items/battle_item.2bpp.lz"
LeafStoneIcon:	INCBIN "gfx/items/leaf_stone.2bpp.lz"
ChoiceSpecsIcon:	INCBIN "gfx/items/choice_specs.2bpp.lz"
NuggetIcon:	INCBIN "gfx/items/nugget.2bpp.lz"
PokeDollIcon:	INCBIN "gfx/items/poke_doll.2bpp.lz"
FullHealIcon:	INCBIN "gfx/items/full_heal.2bpp.lz"
ReviveIcon:	INCBIN "gfx/items/revive.2bpp.lz"
MaxReviveIcon:	INCBIN "gfx/items/max_revive.2bpp.lz"
FreshWaterIcon:	INCBIN "gfx/items/fresh_water.2bpp.lz"
SodaPopIcon:	INCBIN "gfx/items/soda_pop.2bpp.lz"
LemonadeIcon:	INCBIN "gfx/items/lemonade.2bpp.lz"
CoinCaseIcon:	INCBIN "gfx/items/coin_case.2bpp.lz"
ItemfinderIcon:	INCBIN "gfx/items/itemfinder.2bpp.lz"
OldRodIcon:	INCBIN "gfx/items/old_rod.2bpp.lz"
GoodRodIcon:	INCBIN "gfx/items/good_rod.2bpp.lz"
SilverLeafIcon:	INCBIN "gfx/items/leaf.2bpp.lz"
SuperRodIcon:	INCBIN "gfx/items/super_rod.2bpp.lz"
PPUpIcon:	INCBIN "gfx/items/pp_up.2bpp.lz"
ClearBellIcon:	INCBIN "gfx/items/clear_bell.2bpp.lz"
SilverWingIcon:	INCBIN "gfx/items/silver_wing.2bpp.lz"
MoomooMilkIcon:	INCBIN "gfx/items/moomoo_milk.2bpp.lz"
QuickClawIcon:	INCBIN "gfx/items/quick_claw.2bpp.lz"
PechaBerryIcon:	INCBIN "gfx/items/pecha_berry.2bpp.lz"
SharpBeakIcon:	INCBIN "gfx/items/sharp_beak.2bpp.lz"
CheriBerryIcon:	INCBIN "gfx/items/cheri_berry.2bpp.lz"
AspearBerryIcon:	INCBIN "gfx/items/aspear_berry.2bpp.lz"
RawstBerryIcon:	INCBIN "gfx/items/rawst_berry.2bpp.lz"
PoisonBarbIcon:	INCBIN "gfx/items/poison_barb.2bpp.lz"
KingsRockIcon:	INCBIN "gfx/items/kings_rock.2bpp.lz"
PersimBerryIcon:	INCBIN "gfx/items/persim_berry.2bpp.lz"
ChestoBerryIcon:	INCBIN "gfx/items/chesto_berry.2bpp.lz"
RedApricornIcon:	INCBIN "gfx/items/apricorn.2bpp.lz"
TinyMushroomIcon:	INCBIN "gfx/items/tinymushroom.2bpp.lz"
BigMushroomIcon:	INCBIN "gfx/items/big_mushroom.2bpp.lz"
SilverPowderIcon:	INCBIN "gfx/items/powder.2bpp.lz"
AmuletCoinIcon:	INCBIN "gfx/items/amulet_coin.2bpp.lz"
CleanseTagIcon:	INCBIN "gfx/items/cleanse_tag.2bpp.lz"
MysticWaterIcon:	INCBIN "gfx/items/mystic_water.2bpp.lz"
TwistedSpoonIcon:	INCBIN "gfx/items/twistedspoon.2bpp.lz"
BlackbeltIcon:	INCBIN "gfx/items/black_belt.2bpp.lz"
BlackGlassesIcon:	INCBIN "gfx/items/blackglasses.2bpp.lz"
PinkBowIcon:	INCBIN "gfx/items/pink_bow.2bpp.lz"
LeekIcon:	INCBIN "gfx/items/leek.2bpp.lz"
SmokeBallIcon:	INCBIN "gfx/items/smoke_ball.2bpp.lz"
NeverMeltIceIcon:	INCBIN "gfx/items/nevermeltice.2bpp.lz"
MagnetIcon:	INCBIN "gfx/items/magnet.2bpp.lz"
LumBerryIcon:	INCBIN "gfx/items/lum_berry.2bpp.lz"
PearlIcon:	INCBIN "gfx/items/pearl.2bpp.lz"
BigPearlIcon:	INCBIN "gfx/items/big_pearl.2bpp.lz"
EverstoneIcon:	INCBIN "gfx/items/everstone.2bpp.lz"
SpellTagIcon:	INCBIN "gfx/items/spell_tag.2bpp.lz"
RageCandyBarIcon:	INCBIN "gfx/items/ragecandybar.2bpp.lz"
GSBallIcon:	INCBIN "gfx/items/gs_ball.2bpp.lz"
BlueCardIcon:	INCBIN "gfx/items/blue_card.2bpp.lz"
MiracleSeedIcon:	INCBIN "gfx/items/miracle_seed.2bpp.lz"
FocusBandIcon:	INCBIN "gfx/items/focus_band.2bpp.lz"
EnergyRootIcon:	INCBIN "gfx/items/energy_root.2bpp.lz"
RevivalHerbIcon:	INCBIN "gfx/items/revival_herb.2bpp.lz"
HardStoneIcon:	INCBIN "gfx/items/hard_stone.2bpp.lz"
LuckyEggIcon:	INCBIN "gfx/items/lucky_egg.2bpp.lz"
EggTicketIcon:	INCBIN "gfx/items/eggticket.2bpp.lz"
StarPieceIcon:	INCBIN "gfx/items/star_piece.2bpp.lz"
BasementKeyIcon:	INCBIN "gfx/items/basement_key.2bpp.lz"
CharcoalIcon:	INCBIN "gfx/items/charcoal.2bpp.lz"
BerryJuiceIcon:	INCBIN "gfx/items/berry_juice.2bpp.lz"
ScopeLensIcon:	INCBIN "gfx/items/scope_lens.2bpp.lz"
LifeOrbIcon:	INCBIN "gfx/items/life_orb.2bpp.lz"
ChoiceBandIcon:	INCBIN "gfx/items/choice_band.2bpp.lz"
MetalCoatIcon:	INCBIN "gfx/items/metal_coat.2bpp.lz"
DragonFangIcon:	INCBIN "gfx/items/dragon_fang.2bpp.lz"
LeftoversIcon:	INCBIN "gfx/items/leftovers.2bpp.lz"
OldAmberIcon:	INCBIN "gfx/items/old_amber.2bpp.lz"
HelixFossilIcon:	INCBIN "gfx/items/helix_fossil.2bpp.lz"
LeppaBerryIcon:	INCBIN "gfx/items/leppa_berry.2bpp.lz"
DragonScaleIcon:	INCBIN "gfx/items/dragon_scale.2bpp.lz"
MuscleBandIcon:	INCBIN "gfx/items/muscle_band.2bpp.lz"
WiseGlassesIcon:	INCBIN "gfx/items/wise_glasses.2bpp.lz"
HeavyBallIcon:	INCBIN "gfx/items/heavy_ball.2bpp.lz"
FlowerMailIcon:	INCBIN "gfx/items/flower_mail.2bpp.lz"
LevelBallIcon:	INCBIN "gfx/items/level_ball.2bpp.lz"
LureBallIcon:	INCBIN "gfx/items/lure_ball.2bpp.lz"
FastBallIcon:	INCBIN "gfx/items/fast_ball.2bpp.lz"
LightBallIcon:	INCBIN "gfx/items/light_ball.2bpp.lz"
FriendBallIcon:	INCBIN "gfx/items/friend_ball.2bpp.lz"
MoonBallIcon:	INCBIN "gfx/items/moon_ball.2bpp.lz"
LoveBallIcon:	INCBIN "gfx/items/love_ball.2bpp.lz"
SunStoneIcon:	INCBIN "gfx/items/sun_stone.2bpp.lz"
PolkadotBowIcon:	INCBIN "gfx/items/polkadot_bow.2bpp.lz"
UpGradeIcon:	INCBIN "gfx/items/upgrade.2bpp.lz"
OranBerryIcon:	INCBIN "gfx/items/oran_berry.2bpp.lz"
SitrusBerryIcon:	INCBIN "gfx/items/sitrus_berry.2bpp.lz"
SquirtBottleIcon:	INCBIN "gfx/items/squirtbottle.2bpp.lz"
ParkBallIcon:	INCBIN "gfx/items/park_ball.2bpp.lz"
RainbowWingIcon:	INCBIN "gfx/items/rainbow_wing.2bpp.lz"
TypeChartIcon:	INCBIN "gfx/items/type_chart.2bpp.lz"
MusicPlayerIcon:	INCBIN "gfx/items/music_player.2bpp.lz"
SurfMailIcon:	INCBIN "gfx/items/mail.2bpp.lz"
PortraitMailIcon:	INCBIN "gfx/items/portraitmail.2bpp.lz"
LovelyMailIcon:	INCBIN "gfx/items/lovely_mail.2bpp.lz"
EonMailIcon:	INCBIN "gfx/items/eon_mail.2bpp.lz"
MorphMailIcon:	INCBIN "gfx/items/morph_mail.2bpp.lz"
BlueSkyMailIcon:	INCBIN "gfx/items/bluesky_mail.2bpp.lz"
MusicMailIcon:	INCBIN "gfx/items/music_mail.2bpp.lz"
MirageMailIcon:	INCBIN "gfx/items/mirage_mail.2bpp.lz"
TMHMIcon:	INCBIN "gfx/items/tm_hm.2bpp.lz"
