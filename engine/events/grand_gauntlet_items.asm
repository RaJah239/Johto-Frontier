; these numbers must between 0-255
; 4/256 chance to get a rare candy

GrandGauntletItemList:
	; evolution stones 42
	db 6, MOON_STONE
	db 6, SUN_STONE
	db 6, FIRE_STONE
	db 6, THUNDERSTONE
	db 6, WATER_STONE
	db 6, LEAF_STONE
	db 6, EVERSTONE

	; berries - 15
	db 5, SILVER_BERRY
	db 5, GOLD_BERRY
	db 5, MIRACLEBERRY

	; competitive battle items - 68
	db 8, CHOICE_BAND
	db 8, CHOICE_SPECS
	db 8, ASSAULT_VEST
	db 8, FOCUS_SASH
	db 8, LEFTOVERS
	db 8, LIFE_ORB
	db 5, MUSCLE_BAND
	db 5, WISE_GLASSES
	db 5, QUICK_CLAW
	db 5, HEAVY_BOOTS

	; battle items - 108
	db 3, BERRY_JUICE
	db 3, BLACK_SLUDGE
	db 3, BLACKBELT_I
	db 3, BLACKGLASSES
	db 3, BRIGHTPOWDER
	db 3, CHARCOAL
	db 3, DRAGON_FANG
	db 3, FLAME_ORB
	db 3, FOCUS_BAND
	db 3, GRIP_CLAW
	db 3, HARD_STONE
	db 3, HASTE_HERB
	db 3, KINGS_ROCK
	db 3, LIGHT_BALL
	db 3, LIGHT_CLAY
	db 3, LUCKY_EGG
	db 3, MAGNET
	db 3, METAL_COAT
	db 3, METEOR_MITTS
	db 3, MIRACLE_SEED
	db 3, MYSTIC_WATER
	db 3, NEVERMELTICE
	db 3, PINK_BOW
	db 3, POLKADOT_BOW
	db 3, POISON_BARB
	db 3, SCOPE_LENS
	db 3, SHARP_BEAK
	db 3, SILVERPOWDER
	db 3, SOFT_SAND
	db 3, SPELL_TAG
	db 3, TRICK_STICK
	db 3, TWISTEDSPOON
	db 3, WIDE_LENS
	db 3, X_ACCURACY
	db 3, X_EVADE
	db 3, ZOOM_LENS

	; weather items - 18
	db 2, WEATHER_ROCK
	db 4, FROST_SHARD
	db 4, SAND_SHARD
	db 4, SUN_SHARD
	db 4, RAIN_SHARD

	; max stats - 2
	db 2, HYPER_EV_UP
	db -1 ; end


GrandGauntletItem:
	ld hl, GrandGauntletItemList
	call Random
.loop
	sub [hl]
	jr c, .ok
	inc hl
	inc hl
	jr .loop

.ok
	ld a, [hli]
	inc a
	jr z, .failsafe
	ld a, [hli]
	jr .done

	; failsafe item if one from the list wasn't chosen
.failsafe
	ld a, RARE_CANDY
.done
	ld [wScriptVar], a
	ret
