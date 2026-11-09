; Notes:
; NO_ITEM exist
; NO_MOVE exist

ScarletGroup:
	; Scarlet (1)
	next_list_item
	db "Scarlet@", TRAINERTYPE_ITEM_MOVES
	db 1
	dw MAGIKARP
	db NO_ITEM
	dw DOUBLE_TEAM, NO_MOVE, NO_MOVE, NO_MOVE
	db -1 ; end
	end_list_items
