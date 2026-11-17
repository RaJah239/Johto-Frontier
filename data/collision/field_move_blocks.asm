; these blocks all use COLL_CUT_TREE in one quadrant
CutTreeBlockPointers:
; tileset, block list pointer
	dbw TILESET_JOHTO,        .johto
	dbw TILESET_JOHTO_MODERN, .johto_modern
	dbw TILESET_KANTO,        .kanto
	dbw TILESET_PARK,         .park
	dbw TILESET_FOREST,       .forest
	db -1 ; end

.johto:
; facing block, replacement block, animation
	db $03, $02, 1 ; grass
	db $59, $3b, 0 ; tree
	db $5d, $3c, 0 ; tree
	db $61, $3e, 0 ; tree
	db $65, $3d, 0 ; tree
	db -1 ; end

.johto_modern:
; facing block, replacement block, animation
	db $03, $02, $01 ; grass
	db -1 ; end

.kanto:
; facing block, replacement block, animation
	db $08, $07, 1 ; grass
	db $19, $39, 0 ; tree
	db $1a, $38, 0 ; tree
	db $1b, $3b, 0 ; tree
	db $1c, $25, 0 ; tree
	db $32, $3a, 0 ; tree
	db -1 ; end

.park:
; facing block, replacement block, animation
	db $10, $02, 1 ; grass
	db $02, $03, 1 ; grass
	db -1 ; end

.forest:
; facing block, replacement block, animation
	db $0f, $17, 0
	db -1 ; end


; these blocks all use COLL_WHIRLPOOL in one quadrant
WhirlpoolBlockPointers:
	dbw TILESET_JOHTO, .johto
	db -1 ; end

.johto:
; facing block, replacement block, animation
	db $07, $35, 0
	db -1 ; end
