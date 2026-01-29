; Total items: 193 (including unused items)
; All item_constants must be in this list

ItemNameOrder:
	table_width 1, ItemNameOrder

; No item
	db NO_ITEM      ; Must be included



; Item Pocket - 24 total
; Forever useful items
	db REPEL
	db SUPER_REPEL
	db MAX_REPEL
	db POKE_DOLL
	db ESCAPE_ROPE

; Evolution Items
	db FIRE_STONE
	db WATER_STONE
	db LEAF_STONE
	db THUNDERSTONE
	db DRAGON_SCALE
	db SUN_STONE
	db MOON_STONE

; Boxes
	db NORMAL_BOX
	db GORGEOUS_BOX

; Mail
	db BLUESKY_MAIL
	db EON_MAIL
	db FLOWER_MAIL
	db LITEBLUEMAIL
	db LOVELY_MAIL
	db MIRAGE_MAIL
	db MORPH_MAIL
	db MUSIC_MAIL
	db PORTRAITMAIL
	db SURF_MAIL



; NEXT POCKET
; Ball Pocket - 13 total
; Generic Pokéballs
	db POKE_BALL
	db GREAT_BALL
	db ULTRA_BALL
	db SHINY_BALL
	db MASTER_BALL 
	db PARK_BALL

; Kurt's Pokéballs
	db FAST_BALL
	db FRIEND_BALL
	db HEAVY_BALL
	db LEVEL_BALL
	db LOVE_BALL
	db LURE_BALL
	db MOON_BALL



; NEXT POCKET
; Medicine Pocket - 35 total
; Best restorative item in the game
	db SACRED_ASH   ; 38

; HP restoring items
	db POTION
	db SUPER_POTION
	db HYPER_POTION
	db MAX_POTION
	db FULL_RESTORE

; Vending Machine Drinks
	db FRESH_WATER
	db SODA_POP
	db LEMONADE

; Other healing related items
	db MOOMOO_MILK
	db RAGECANDYBAR

; Status recovery items
	db ANTIDOTE
	db AWAKENING
	db BURN_HEAL
	db ICE_HEAL
	db PARLYZ_HEAL
	db FULL_HEAL

; PP restoring and Revival items
	db ETHER
	db MAX_ETHER
	db ELIXER
	db MAX_ELIXER
	db REVIVE
	db MAX_REVIVE

; Bitter Medicine
	db ENERGYPOWDER
	db ENERGY_ROOT
	db HEAL_POWDER
	db REVIVAL_HERB

; Vitamins
	db RARE_CANDY
	db HYPER_EV_UP
	db PP_UP
	db HP_UP
	db PROTEIN
	db IRON
	db CALCIUM
	db ZINC 
	db CARBOS



; NEXT POCKET
; Fruit Pocket - 18 total
; Berries
	db BERRY
	db BITTER_BERRY
	db BURNT_BERRY
	db GOLD_BERRY
	db ICE_BERRY
	db MINT_BERRY
	db MIRACLEBERRY
	db MYSTERYBERRY
	db PRZCUREBERRY
	db PSNCUREBERRY
	db SILVER_BERRY

; Apricorns
	db BLU_APRICORN
	db BLK_APRICORN
	db GRN_APRICORN
	db PNK_APRICORN
	db RED_APRICORN
	db WHT_APRICORN
	db YLW_APRICORN



; NEXT POCKET
; Battle Pocket - 55 total

; Stat altering Battle Items
	db X_ACCURACY

; Battle related Held Items
	db AMULET_COIN
	db ASSAULT_VEST
	db BERRY_JUICE
	db BLACK_SLUDGE
	db BLACKBELT_I
	db BLACKGLASSES
	db BRIGHTPOWDER
	db CHARCOAL
	db CHOICE_BAND
	db CHOICE_SPECS
	db CLEANSE_TAG
	db DRAGON_FANG
	db EVERSTONE
	db FLAME_ORB
	db FOCUS_BAND
	db FOCUS_SASH
	db FROST_SHARD
	db HEAVY_BOOTS
	db HARD_STONE
	db HASTE_HERB
	db KINGS_ROCK
	db LEFTOVERS
	db LIFE_ORB
	db LIGHT_BALL
	db LIGHT_CLAY
	db LUCKY_EGG
	db LUCKY_PUNCH
	db MAGNET
	db METAL_COAT
	db MIRACLE_SEED
	db MUSCLE_BAND
	db MYSTIC_WATER
	db NEVERMELTICE
	db PINK_BOW
	db POLKADOT_BOW
	db POISON_BARB
	db QUICK_CLAW
	db RAIN_SHARD
	db SCOPE_LENS
	db SHARP_BEAK
	db SILVERPOWDER
	db SMOKE_BALL
	db SOFT_SAND
	db SPELL_TAG
	db STICK
	db SAND_SHARD
	db SUN_SHARD
	db THICK_CLUB
	db TOXIC_ORB
	db TWISTEDSPOON
	db UP_GRADE
	db WEATHER_ROCK
	db WIDE_LENS
	db WISE_GLASSES
	db ZOOM_LENS



; NEXT POCKET
; Loot Items Pocket - 13 total
; Crystal
	db CRYSTAL

; Leaves
	db SILVER_LEAF
	db GOLD_LEAF

; Other items
	db TINYMUSHROOM
	db BIG_MUSHROOM
	db PEARL
	db BIG_PEARL
	db STARDUST
	db STAR_PIECE
	db NUGGET
	db BRICK_PIECE

; Fossils
	db DOME_FOSSIL
	db HELIX_FOSSIL
	db OLD_AMBER

; NEXT POCKET
; Key Items Pocket - 26 total
; Permanent Key Items
; Items that are possibly frequently used
	db TYPE_CODEX
	db BICYCLE
	db COIN_CASE
	db ITEMFINDER
	db BLUE_CARD

; Rods
	db OLD_ROD
	db GOOD_ROD
	db SUPER_ROD

; HM items
	db MAREEP_CALL
	db SCYTHER_CALL
	db TANGELA_CALL
	db LANTURN_CALL
	db DONPHAN_CALL
	db KINGDRA_CALL
	db MILOTIC_CALL

; Key Items that are possibly seldom used
	db SHINY_CHARM
	db CLEAR_BELL
	db SILVER_WING
	db RAINBOW_WING

; Temporary Key Items
	db BASEMENT_KEY
	db CARD_KEY
	db GS_BALL
	db MYSTERY_EGG
	db RED_SCALE
	db SECRETPOTION
	db SQUIRTBOTTLE



; UNUSED ITEMS
; Unused Items - 16 total
	db EGG_TICKET
	db ITEM_9B
	db ITEM_AB
	db ITEM_C3
 	db ITEM_DC
 	db ITEM_DE
 	db ITEM_DF
 	db ITEM_E0
 	db ITEM_E1
 	db ITEM_E2
 	db ITEM_E3
 	db ITEM_E4
 	db ITEM_E5
 	db ITEM_E6
 	db ITEM_E7
 	db ITEM_E8


	assert_table_length NUM_ITEMS + 1
	db -1 ; end
