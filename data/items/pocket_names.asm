ItemPocketNames:
; entries correspond to item type constants
	table_width 2, ItemPocketNames
	dw .Item
	dw .Key
	dw .Ball
	dw .TM
	dw .Fruit
	dw .Battle
	assert_table_length NUM_ITEM_TYPES

.Item: db "Item Pocket@"
.Key:  db "Key Pocket@"
.Ball: db "Ball Pocket@"
.TM:   db "TM Pocket@"
.Fruit: db "Fruit Pocket@"
.Battle: db "Battle Pocket@"
