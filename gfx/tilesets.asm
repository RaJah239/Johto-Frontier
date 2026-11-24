MACRO tilecoll
; used in data/tilesets/*_collision.asm
	db COLL_\1, COLL_\2, COLL_\3, COLL_\4
ENDM


SECTION "Tileset Data 1", ROMX

Tileset0GFX::
TilesetJohtoGFX::
INCBIN "gfx/tilesets/johto.2bpp.lz"

Tileset0Coll::
TilesetJohtoColl::
INCLUDE "data/tilesets/johto_collision.asm"

TilesetIcePathGFX::
INCBIN "gfx/tilesets/ice_path.2bpp.lz"

TilesetIcePathColl::
INCLUDE "data/tilesets/ice_path_collision.asm"

TilesetPlayersRoomGFX::
INCBIN "gfx/tilesets/players_room.2bpp.lz"

TilesetPlayersRoomColl::
INCLUDE "data/tilesets/players_room_collision.asm"


SECTION "Tileset Data 2", ROMX

TilesetPokecenterGFX::
INCBIN "gfx/tilesets/pokecenter.2bpp.lz"

TilesetPokecenterColl::
INCLUDE "data/tilesets/pokecenter_collision.asm"

TilesetPortGFX::
INCBIN "gfx/tilesets/port.2bpp.lz"

TilesetPortColl::
INCLUDE "data/tilesets/port_collision.asm"

TilesetPlayersHouseGFX::
INCBIN "gfx/tilesets/players_house.2bpp.lz"

TilesetPlayersHouseColl::
INCLUDE "data/tilesets/players_house_collision.asm"

TilesetMansionGFX::
INCBIN "gfx/tilesets/mansion.2bpp.lz"

TilesetMansionColl::
INCLUDE "data/tilesets/mansion_collision.asm"

TilesetCaveGFX::
INCBIN "gfx/tilesets/cave.2bpp.lz"

TilesetCaveColl::
INCLUDE "data/tilesets/cave_collision.asm"

TilesetDarkCaveColl::
INCLUDE "data/tilesets/dark_cave_collision.asm"

SECTION "Tileset Data 3", ROMX

TilesetTowerGFX::
INCBIN "gfx/tilesets/tower.2bpp.lz"

TilesetTowerColl::
INCLUDE "data/tilesets/tower_collision.asm"

TilesetLabGFX::
INCBIN "gfx/tilesets/lab.2bpp.lz"

TilesetLabColl::
INCLUDE "data/tilesets/lab_collision.asm"

TilesetMartGFX::
INCBIN "gfx/tilesets/mart.2bpp.lz"

TilesetMartColl::
INCLUDE "data/tilesets/mart_collision.asm"

TilesetGameCornerGFX::
INCBIN "gfx/tilesets/game_corner.2bpp.lz"

TilesetGameCornerColl::
INCLUDE "data/tilesets/game_corner_collision.asm"

TilesetTrainStationGFX::
INCBIN "gfx/tilesets/train_station.2bpp.lz"

TilesetTrainStationColl::
INCLUDE "data/tilesets/train_station_collision.asm"


SECTION "Tileset Data 4", ROMX

TilesetEliteFourRoomGFX::
INCBIN "gfx/tilesets/elite_four_room.2bpp.lz"

TilesetEliteFourRoomColl::
INCLUDE "data/tilesets/elite_four_room_collision.asm"

TilesetParkGFX::
INCBIN "gfx/tilesets/park.2bpp.lz"

TilesetParkColl::
INCLUDE "data/tilesets/park_collision.asm"

TilesetRadioTowerGFX::
INCBIN "gfx/tilesets/radio_tower.2bpp.lz"

TilesetRadioTowerColl::
INCLUDE "data/tilesets/radio_tower_collision.asm"

TilesetUndergroundGFX::
INCBIN "gfx/tilesets/underground.2bpp.lz"

TilesetUndergroundColl::
INCLUDE "data/tilesets/underground_collision.asm"

TilesetDarkCaveGFX::
INCBIN "gfx/tilesets/dark_cave.2bpp.lz"


SECTION "Tileset Data 5", ROMX


TilesetBattleTowerInsideGFX::
INCBIN "gfx/tilesets/battle_tower_inside.2bpp.lz"

TilesetBattleTowerInsideColl::
INCLUDE "data/tilesets/battle_tower_inside_collision.asm"

TilesetGateGFX::
INCBIN "gfx/tilesets/gate.2bpp.lz"

TilesetGateColl::
INCLUDE "data/tilesets/gate_collision.asm"

TilesetJohtoModernGFX::
TilesetBattleTowerOutsideGFX::
INCBIN "gfx/tilesets/johto_modern.2bpp.lz"

TilesetJohtoModernColl::
INCLUDE "data/tilesets/johto_modern_collision.asm"

TilesetTraditionalHouseColl::
INCLUDE "data/tilesets/traditional_house_collision.asm"


SECTION "Tileset Data 6", ROMX

TilesetForestGFX::
INCBIN "gfx/tilesets/forest.2bpp.lz"

TilesetChampionsRoomGFX::
INCBIN "gfx/tilesets/champions_room.2bpp.lz"

TilesetChampionsRoomColl::
INCLUDE "data/tilesets/champions_room_collision.asm"

TilesetHouseGFX::
INCBIN "gfx/tilesets/house.2bpp.lz"

TilesetHouseColl::
INCLUDE "data/tilesets/house_collision.asm"

TilesetLighthouseGFX::
INCBIN "gfx/tilesets/lighthouse.2bpp.lz"

TilesetLighthouseColl::
INCLUDE "data/tilesets/lighthouse_collision.asm"

TilesetForestColl::
INCLUDE "data/tilesets/forest_collision.asm"

TilesetFacilityGFX::
INCBIN "gfx/tilesets/facility.2bpp.lz"

TilesetFacilityColl::
INCLUDE "data/tilesets/facility_collision.asm"

TilesetBattleTowerOutsideColl::
INCLUDE "data/tilesets/battle_tower_outside_collision.asm"

TilesetHoOhWordRoomColl::
TilesetLileepWordRoomColl::
TilesetOmanyteWordRoomColl::
TilesetAerodactylWordRoomColl::
INCLUDE "data/tilesets/word_room_collision.asm"


SECTION "Tileset Data 7", ROMX

TilesetRuinsOfAlphGFX::
TilesetHoOhWordRoomGFX::
TilesetLileepWordRoomGFX::
TilesetOmanyteWordRoomGFX::
TilesetAerodactylWordRoomGFX::
INCBIN "gfx/tilesets/ruins_of_alph.2bpp.lz"

TilesetRuinsOfAlphColl::
INCLUDE "data/tilesets/ruins_of_alph_collision.asm"


SECTION "Tileset Data 8", ROMX

TilesetTraditionalHouseGFX::
INCBIN "gfx/tilesets/traditional_house.2bpp.lz"


SECTION "Tileset Data 9", ROMX

TilesetKantoGFX::
INCBIN "gfx/tilesets/kanto.2bpp.lz"

TilesetKantoColl::
INCLUDE "data/tilesets/kanto_collision.asm"


SECTION "Tileset Data 12", ROMX

SECTION "Tileset Tables 1", ROMX

; The metatile and attribute tables, uncompressed and each prefixed with its
; length, so DecompressMetatiles copies them straight into WRAM. Decompressing
; them instead cost over two frames on every map entry, which showed as a
; stutter walking into a map whose tileset differs (a building, or one of the
; few map connections that change tileset).

Tileset0Meta::
TilesetJohtoMeta::
	dw TilesetJohtoMetaEnd - TilesetJohtoMeta - 2
INCBIN "data/tilesets/johto_metatiles.bin"
TilesetJohtoMetaEnd::

TilesetIcePathMeta::
	dw TilesetIcePathMetaEnd - TilesetIcePathMeta - 2
INCBIN "data/tilesets/ice_path_metatiles.bin"
TilesetIcePathMetaEnd::

TilesetPlayersRoomMeta::
	dw TilesetPlayersRoomMetaEnd - TilesetPlayersRoomMeta - 2
INCBIN "data/tilesets/players_room_metatiles.bin"
TilesetPlayersRoomMetaEnd::

TilesetPokecenterMeta::
	dw TilesetPokecenterMetaEnd - TilesetPokecenterMeta - 2
INCBIN "data/tilesets/pokecenter_metatiles.bin"
TilesetPokecenterMetaEnd::

TilesetPortMeta::
	dw TilesetPortMetaEnd - TilesetPortMeta - 2
INCBIN "data/tilesets/port_metatiles.bin"
TilesetPortMetaEnd::

TilesetPlayersHouseMeta::
	dw TilesetPlayersHouseMetaEnd - TilesetPlayersHouseMeta - 2
INCBIN "data/tilesets/players_house_metatiles.bin"
TilesetPlayersHouseMetaEnd::

TilesetMansionMeta::
	dw TilesetMansionMetaEnd - TilesetMansionMeta - 2
INCBIN "data/tilesets/mansion_metatiles.bin"
TilesetMansionMetaEnd::

TilesetCaveMeta::
	dw TilesetCaveMetaEnd - TilesetCaveMeta - 2
INCBIN "data/tilesets/cave_metatiles.bin"
TilesetCaveMetaEnd::

TilesetDarkCaveMeta::
	dw TilesetDarkCaveMetaEnd - TilesetDarkCaveMeta - 2
INCBIN "data/tilesets/dark_cave_metatiles.bin"
TilesetDarkCaveMetaEnd::

TilesetTowerMeta::
	dw TilesetTowerMetaEnd - TilesetTowerMeta - 2
INCBIN "data/tilesets/tower_metatiles.bin"
TilesetTowerMetaEnd::

TilesetLabMeta::
	dw TilesetLabMetaEnd - TilesetLabMeta - 2
INCBIN "data/tilesets/lab_metatiles.bin"
TilesetLabMetaEnd::

TilesetMartMeta::
	dw TilesetMartMetaEnd - TilesetMartMeta - 2
INCBIN "data/tilesets/mart_metatiles.bin"
TilesetMartMetaEnd::

TilesetGameCornerMeta::
	dw TilesetGameCornerMetaEnd - TilesetGameCornerMeta - 2
INCBIN "data/tilesets/game_corner_metatiles.bin"
TilesetGameCornerMetaEnd::

TilesetTrainStationMeta::
	dw TilesetTrainStationMetaEnd - TilesetTrainStationMeta - 2
INCBIN "data/tilesets/train_station_metatiles.bin"
TilesetTrainStationMetaEnd::

TilesetForestMeta::
	dw TilesetForestMetaEnd - TilesetForestMeta - 2
INCBIN "data/tilesets/forest_metatiles.bin"
TilesetForestMetaEnd::

TilesetEliteFourRoomMeta::
	dw TilesetEliteFourRoomMetaEnd - TilesetEliteFourRoomMeta - 2
INCBIN "data/tilesets/elite_four_room_metatiles.bin"
TilesetEliteFourRoomMetaEnd::

TilesetParkMeta::
	dw TilesetParkMetaEnd - TilesetParkMeta - 2
INCBIN "data/tilesets/park_metatiles.bin"
TilesetParkMetaEnd::

SECTION "Tileset Tables 2", ROMX

TilesetRadioTowerMeta::
	dw TilesetRadioTowerMetaEnd - TilesetRadioTowerMeta - 2
INCBIN "data/tilesets/radio_tower_metatiles.bin"
TilesetRadioTowerMetaEnd::

TilesetUndergroundMeta::
	dw TilesetUndergroundMetaEnd - TilesetUndergroundMeta - 2
INCBIN "data/tilesets/underground_metatiles.bin"
TilesetUndergroundMetaEnd::

TilesetBattleTowerInsideMeta::
	dw TilesetBattleTowerInsideMetaEnd - TilesetBattleTowerInsideMeta - 2
INCBIN "data/tilesets/battle_tower_inside_metatiles.bin"
TilesetBattleTowerInsideMetaEnd::

TilesetGateMeta::
	dw TilesetGateMetaEnd - TilesetGateMeta - 2
INCBIN "data/tilesets/gate_metatiles.bin"
TilesetGateMetaEnd::

TilesetJohtoModernMeta::
	dw TilesetJohtoModernMetaEnd - TilesetJohtoModernMeta - 2
INCBIN "data/tilesets/johto_modern_metatiles.bin"
TilesetJohtoModernMetaEnd::

TilesetTraditionalHouseMeta::
	dw TilesetTraditionalHouseMetaEnd - TilesetTraditionalHouseMeta - 2
INCBIN "data/tilesets/traditional_house_metatiles.bin"
TilesetTraditionalHouseMetaEnd::

TilesetChampionsRoomMeta::
	dw TilesetChampionsRoomMetaEnd - TilesetChampionsRoomMeta - 2
INCBIN "data/tilesets/champions_room_metatiles.bin"
TilesetChampionsRoomMetaEnd::

TilesetHouseMeta::
	dw TilesetHouseMetaEnd - TilesetHouseMeta - 2
INCBIN "data/tilesets/house_metatiles.bin"
TilesetHouseMetaEnd::

TilesetLighthouseMeta::
	dw TilesetLighthouseMetaEnd - TilesetLighthouseMeta - 2
INCBIN "data/tilesets/lighthouse_metatiles.bin"
TilesetLighthouseMetaEnd::

TilesetFacilityMeta::
	dw TilesetFacilityMetaEnd - TilesetFacilityMeta - 2
INCBIN "data/tilesets/facility_metatiles.bin"
TilesetFacilityMetaEnd::

TilesetBattleTowerOutsideMeta::
	dw TilesetBattleTowerOutsideMetaEnd - TilesetBattleTowerOutsideMeta - 2
INCBIN "data/tilesets/battle_tower_outside_metatiles.bin"
TilesetBattleTowerOutsideMetaEnd::

TilesetRuinsOfAlphMeta::
	dw TilesetRuinsOfAlphMetaEnd - TilesetRuinsOfAlphMeta - 2
INCBIN "data/tilesets/ruins_of_alph_metatiles.bin"
TilesetRuinsOfAlphMetaEnd::

TilesetHoOhWordRoomMeta::
	dw TilesetHoOhWordRoomMetaEnd - TilesetHoOhWordRoomMeta - 2
INCBIN "data/tilesets/ho_oh_word_room_metatiles.bin"
TilesetHoOhWordRoomMetaEnd::

TilesetLileepWordRoomMeta::
	dw TilesetLileepWordRoomMetaEnd - TilesetLileepWordRoomMeta - 2
INCBIN "data/tilesets/lileep_word_room_metatiles.bin"
TilesetLileepWordRoomMetaEnd::

TilesetOmanyteWordRoomMeta::
	dw TilesetOmanyteWordRoomMetaEnd - TilesetOmanyteWordRoomMeta - 2
INCBIN "data/tilesets/omanyte_word_room_metatiles.bin"
TilesetOmanyteWordRoomMetaEnd::

SECTION "Tileset Tables 3", ROMX

TilesetAerodactylWordRoomMeta::
	dw TilesetAerodactylWordRoomMetaEnd - TilesetAerodactylWordRoomMeta - 2
INCBIN "data/tilesets/aerodactyl_word_room_metatiles.bin"
TilesetAerodactylWordRoomMetaEnd::

TilesetKantoMeta::
	dw TilesetKantoMetaEnd - TilesetKantoMeta - 2
INCBIN "data/tilesets/kanto_metatiles.bin"
TilesetKantoMetaEnd::

Tileset0Attr::
TilesetJohtoAttr::
	dw TilesetJohtoAttrEnd - TilesetJohtoAttr - 2
INCBIN "data/tilesets/johto_attributes.bin"
TilesetJohtoAttrEnd::

TilesetJohtoModernAttr::
	dw TilesetJohtoModernAttrEnd - TilesetJohtoModernAttr - 2
INCBIN "data/tilesets/johto_modern_attributes.bin"
TilesetJohtoModernAttrEnd::

TilesetKantoAttr::
	dw TilesetKantoAttrEnd - TilesetKantoAttr - 2
INCBIN "data/tilesets/kanto_attributes.bin"
TilesetKantoAttrEnd::

TilesetBattleTowerOutsideAttr::
	dw TilesetBattleTowerOutsideAttrEnd - TilesetBattleTowerOutsideAttr - 2
INCBIN "data/tilesets/battle_tower_outside_attributes.bin"
TilesetBattleTowerOutsideAttrEnd::

TilesetHouseAttr::
	dw TilesetHouseAttrEnd - TilesetHouseAttr - 2
INCBIN "data/tilesets/house_attributes.bin"
TilesetHouseAttrEnd::

TilesetPlayersHouseAttr::
	dw TilesetPlayersHouseAttrEnd - TilesetPlayersHouseAttr - 2
INCBIN "data/tilesets/players_house_attributes.bin"
TilesetPlayersHouseAttrEnd::

TilesetPokecenterAttr::
	dw TilesetPokecenterAttrEnd - TilesetPokecenterAttr - 2
INCBIN "data/tilesets/pokecenter_attributes.bin"
TilesetPokecenterAttrEnd::

TilesetGateAttr::
	dw TilesetGateAttrEnd - TilesetGateAttr - 2
INCBIN "data/tilesets/gate_attributes.bin"
TilesetGateAttrEnd::

TilesetPortAttr::
	dw TilesetPortAttrEnd - TilesetPortAttr - 2
INCBIN "data/tilesets/port_attributes.bin"
TilesetPortAttrEnd::

TilesetLabAttr::
	dw TilesetLabAttrEnd - TilesetLabAttr - 2
INCBIN "data/tilesets/lab_attributes.bin"
TilesetLabAttrEnd::

TilesetFacilityAttr::
	dw TilesetFacilityAttrEnd - TilesetFacilityAttr - 2
INCBIN "data/tilesets/facility_attributes.bin"
TilesetFacilityAttrEnd::

TilesetMartAttr::
	dw TilesetMartAttrEnd - TilesetMartAttr - 2
INCBIN "data/tilesets/mart_attributes.bin"
TilesetMartAttrEnd::

SECTION "Tileset Tables 4", ROMX

TilesetMansionAttr::
	dw TilesetMansionAttrEnd - TilesetMansionAttr - 2
INCBIN "data/tilesets/mansion_attributes.bin"
TilesetMansionAttrEnd::

TilesetGameCornerAttr::
	dw TilesetGameCornerAttrEnd - TilesetGameCornerAttr - 2
INCBIN "data/tilesets/game_corner_attributes.bin"
TilesetGameCornerAttrEnd::

TilesetEliteFourRoomAttr::
	dw TilesetEliteFourRoomAttrEnd - TilesetEliteFourRoomAttr - 2
INCBIN "data/tilesets/elite_four_room_attributes.bin"
TilesetEliteFourRoomAttrEnd::

TilesetTraditionalHouseAttr::
	dw TilesetTraditionalHouseAttrEnd - TilesetTraditionalHouseAttr - 2
INCBIN "data/tilesets/traditional_house_attributes.bin"
TilesetTraditionalHouseAttrEnd::

TilesetTrainStationAttr::
	dw TilesetTrainStationAttrEnd - TilesetTrainStationAttr - 2
INCBIN "data/tilesets/train_station_attributes.bin"
TilesetTrainStationAttrEnd::

TilesetChampionsRoomAttr::
	dw TilesetChampionsRoomAttrEnd - TilesetChampionsRoomAttr - 2
INCBIN "data/tilesets/champions_room_attributes.bin"
TilesetChampionsRoomAttrEnd::

TilesetLighthouseAttr::
	dw TilesetLighthouseAttrEnd - TilesetLighthouseAttr - 2
INCBIN "data/tilesets/lighthouse_attributes.bin"
TilesetLighthouseAttrEnd::

TilesetPlayersRoomAttr::
	dw TilesetPlayersRoomAttrEnd - TilesetPlayersRoomAttr - 2
INCBIN "data/tilesets/players_room_attributes.bin"
TilesetPlayersRoomAttrEnd::

TilesetBattleTowerInsideAttr::
	dw TilesetBattleTowerInsideAttrEnd - TilesetBattleTowerInsideAttr - 2
INCBIN "data/tilesets/battle_tower_inside_attributes.bin"
TilesetBattleTowerInsideAttrEnd::

TilesetTowerAttr::
	dw TilesetTowerAttrEnd - TilesetTowerAttr - 2
INCBIN "data/tilesets/tower_attributes.bin"
TilesetTowerAttrEnd::

TilesetCaveAttr::
TilesetDarkCaveAttr::
	dw TilesetDarkCaveAttrEnd - TilesetDarkCaveAttr - 2
INCBIN "data/tilesets/cave_attributes.bin"
TilesetDarkCaveAttrEnd::

TilesetParkAttr::
	dw TilesetParkAttrEnd - TilesetParkAttr - 2
INCBIN "data/tilesets/park_attributes.bin"
TilesetParkAttrEnd::

TilesetRuinsOfAlphAttr::
	dw TilesetRuinsOfAlphAttrEnd - TilesetRuinsOfAlphAttr - 2
INCBIN "data/tilesets/ruins_of_alph_attributes.bin"
TilesetRuinsOfAlphAttrEnd::

TilesetRadioTowerAttr::
	dw TilesetRadioTowerAttrEnd - TilesetRadioTowerAttr - 2
INCBIN "data/tilesets/radio_tower_attributes.bin"
TilesetRadioTowerAttrEnd::

TilesetUndergroundAttr::
	dw TilesetUndergroundAttrEnd - TilesetUndergroundAttr - 2
INCBIN "data/tilesets/underground_attributes.bin"
TilesetUndergroundAttrEnd::

TilesetIcePathAttr::
	dw TilesetIcePathAttrEnd - TilesetIcePathAttr - 2
INCBIN "data/tilesets/ice_path_attributes.bin"
TilesetIcePathAttrEnd::

TilesetForestAttr::
	dw TilesetForestAttrEnd - TilesetForestAttr - 2
INCBIN "data/tilesets/forest_attributes.bin"
TilesetForestAttrEnd::

TilesetHoOhWordRoomAttr::
	dw TilesetHoOhWordRoomAttrEnd - TilesetHoOhWordRoomAttr - 2
INCBIN "data/tilesets/ho_oh_word_room_attributes.bin"
TilesetHoOhWordRoomAttrEnd::

SECTION "Tileset Tables 5", ROMX

TilesetLileepWordRoomAttr::
	dw TilesetLileepWordRoomAttrEnd - TilesetLileepWordRoomAttr - 2
INCBIN "data/tilesets/lileep_word_room_attributes.bin"
TilesetLileepWordRoomAttrEnd::

TilesetOmanyteWordRoomAttr::
	dw TilesetOmanyteWordRoomAttrEnd - TilesetOmanyteWordRoomAttr - 2
INCBIN "data/tilesets/omanyte_word_room_attributes.bin"
TilesetOmanyteWordRoomAttrEnd::

TilesetAerodactylWordRoomAttr::
	dw TilesetAerodactylWordRoomAttrEnd - TilesetAerodactylWordRoomAttr - 2
INCBIN "data/tilesets/aerodactyl_word_room_attributes.bin"
TilesetAerodactylWordRoomAttrEnd::
