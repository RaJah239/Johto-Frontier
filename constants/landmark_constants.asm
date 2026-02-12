; Landmarks indexes (see data/maps/landmarks.asm)
	const_def
	const LANDMARK_SPECIAL           ; 00
; Johto landmarks
	const LANDMARK_NEW_BARK_TOWN     ; 01
	const LANDMARK_ROUTE_1           ; 02
	const LANDMARK_CHERRYGROVE_CITY  ; 03
	const LANDMARK_ROUTE_2           ; 04
	const LANDMARK_DARK_CAVE         ; 05
	const LANDMARK_ROUTE_3           ; 06
	const LANDMARK_VIOLET_CITY       ; 07
	const LANDMARK_SPROUT_TOWER      ; 08
	const LANDMARK_RUINS_OF_ALPH     ; 09
	const LANDMARK_ROUTE_4           ; 0a
	const LANDMARK_UNION_CAVE        ; 0b
	const LANDMARK_ROUTE_5           ; 0c
	const LANDMARK_AZALEA_TOWN       ; 0d
	const LANDMARK_SLOWPOKE_WELL     ; 0e
	const LANDMARK_ILEX_FOREST       ; 0f
	const LANDMARK_ROUTE_6           ; 10
	const LANDMARK_GOLDENROD_CITY    ; 11
	const LANDMARK_RADIO_TOWER       ; 12
	const LANDMARK_ROUTE_7           ; 13
	const LANDMARK_NATIONAL_PARK     ; 14
	const LANDMARK_ROUTE_8           ; 15
	const LANDMARK_ROUTE_9           ; 16
	const LANDMARK_ECRUTEAK_CITY     ; 17
	const LANDMARK_TIN_TOWER         ; 18
	const LANDMARK_BURNED_TOWER      ; 19
	const LANDMARK_ROUTE_10          ; 1a
	const LANDMARK_SILVER_CAVE       ; 1b
	const LANDMARK_ROUTE_11          ; 1c
	const LANDMARK_OLIVINE_CITY      ; 1d
	const LANDMARK_LIGHTHOUSE        ; 1e
	const LANDMARK_ROUTE_12          ; 1f
	const LANDMARK_POWER_PLANT       ; 20
	const LANDMARK_WHIRL_ISLANDS     ; 21
	const LANDMARK_ROUTE_13          ; 22
	const LANDMARK_CIANWOOD_CITY     ; 23
	const LANDMARK_MT_MORTAR         ; 24
	const LANDMARK_ROUTE_14          ; 25
	const LANDMARK_MAHOGANY_TOWN     ; 26
	const LANDMARK_ROUTE_15          ; 27
	const LANDMARK_LAKE_OF_RAGE      ; 28
	const LANDMARK_ROUTE_16          ; 29
	const LANDMARK_ICE_PATH          ; 2a
	const LANDMARK_BLACKTHORN_CITY   ; 2b
	const LANDMARK_DRAGONS_DEN       ; 2c
	const LANDMARK_ROUTE_17          ; 2d
	const LANDMARK_ROUTE_18          ; 2e
	const LANDMARK_TOHJO_FALLS       ; 2f
	const LANDMARK_ROUTE_19          ; 30
	const LANDMARK_ROUTE_20          ; 31
	const LANDMARK_VICTORY_ROAD      ; 32
	const LANDMARK_ROUTE_21          ; 33
	const LANDMARK_INDIGO_PLATEAU    ; 34
	const LANDMARK_BATTLE_PLAZA      ; 35
DEF KANTO_LANDMARK EQU const_value
	const LANDMARK_PALLET_TOWN       ; 36
	const LANDMARK_UNDERGROUND_PATH  ; 37
	const LANDMARK_FAST_SHIP         ; 38
DEF NUM_LANDMARKS EQU const_value

; used in CaughtData
	const_def $7f, -1
	const LANDMARK_EVENT             ; $7f
	const LANDMARK_GIFT              ; $7e

; Regions
	const_def
	const JOHTO_REGION ; 0
	const KANTO_REGION ; 1
DEF NUM_REGIONS EQU const_value
