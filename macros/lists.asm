; Length-prefixed list items (from pokecrystal16): data that can hold any
; byte (16-bit species / move indexes can contain $fe / $ff) is skipped by
; length instead of by scanning for a terminator.
;
; usage:
;   SomeGroup:
;       next_list_item ; item 1: a length byte (from here to the next item)
;       ...
;       next_list_item ; item 2
;       ...
;       end_list_items

MACRO list_item
.__item\1
if _NARG > 1
	assert .__item\2 - .__item\1 < $100, "list item is too long for its length byte"
	db .__item\2 - .__item\1
endc
ENDM

DEF current_list_item = 0

MACRO next_list_item
	DEF next_list_item_index = current_list_item + 1
	list_item {d:current_list_item}, {d:next_list_item_index}
	DEF current_list_item = next_list_item_index
ENDM

MACRO end_list_items
	list_item {d:current_list_item}
	DEF current_list_item = 0
ENDM

; The same, for the Pokémon inside a random party list (which is itself a
; list item).

MACRO random_mon_item
.__rmon\1
if _NARG > 1
	assert .__rmon\2 - .__rmon\1 < $100, "random party mon is too long for its length byte"
	db .__rmon\2 - .__rmon\1
endc
ENDM

DEF current_random_mon = 0

MACRO next_random_mon
	DEF next_random_mon_index = current_random_mon + 1
	random_mon_item {d:current_random_mon}, {d:next_random_mon_index}
	DEF current_random_mon = next_random_mon_index
ENDM

MACRO end_random_mons
	random_mon_item {d:current_random_mon}
	DEF current_random_mon += 1 ; (the counter keeps going: labels stay unique)
ENDM
