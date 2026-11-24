CalculateMaximumQuantity:
; limit [wItemQuantity] so that the discounted price of [wItemQuantity]
; items (see GetDiscountedPrice) <= Money
; 0 <= [wItemQuantity] <= 99
; The discounted price never drops as the quantity goes up (checked for every
; price), so a binary search finds the largest quantity that can be afforded
; in 7 steps. b = a quantity that can be afforded, c = one that can't.
	ld b, 0
	ld c, MAX_ITEM_STACK + 1
.loop
	ld a, b
	add c
	srl a
	cp b
	jr z, .done
	ld e, a
	call GetDiscountedPrice
	push de
	push bc
	ld bc, hMoneyTemp
	ld de, wMoney
	farcall CompareMoney
	pop bc
	pop de
	jr c, .too_much
	ld b, e
	jr .loop

.too_much
	ld c, e
	jr .loop

.done
	ld a, b
	ld [wItemQuantity], a
	ret

GetBulkDiscount:
; Return in a the percentage taken off the whole purchase when buying
; quantity a (0-100) of one item:
;  1-3: 0%, 4-9: 5%, 10-14: 8%, then 1% more for every 5 more items up to
;  65-69: 19%, and 70+: 20%
; Clobbers c.
	cp 4
	jr c, .none
	cp 10
	jr c, .five
	cp 70
	jr nc, .max
	sub 10
	ld c, 8
.loop
	sub 5
	jr c, .done
	inc c
	jr .loop

.done
	ld a, c
	ret

.none
	xor a
	ret

.five
	ld a, 5
	ret

.max
	ld a, 20
	ret

GetDiscountedPrice:
; Return in hMoneyTemp (3 bytes, big endian) the price of a items costing
; wBuySellItemPrice each, with the bulk discount of GetBulkDiscount:
; price * a * (100 - discount) / 100, rounded down.
; price * a <= 65535 * 100 and that * 100 is under 2^32, so nothing overflows.
; With a discount a >= 4 and the result is at least 3 * price: a priced item
; is never free.
; hMultiplicand, hProduct and hDividend share their memory: the product of
; the first Multiply is already the multiplicand of the second one, and the
; second product is already the dividend.
; Preserves bc, de, hl.
	push bc
	ld b, a
	xor a
	ldh [hMultiplicand + 0], a
	ld a, [wBuySellItemPrice + 0]
	ldh [hMultiplicand + 1], a
	ld a, [wBuySellItemPrice + 1]
	ldh [hMultiplicand + 2], a
	ld a, b
	ldh [hMultiplier], a
	call Multiply
	ld a, b
	call GetBulkDiscount
	ld c, a
	ld a, 100
	sub c
	ldh [hMultiplier], a
	call Multiply
	ld a, 100
	ldh [hDivisor], a
	ld b, 4
	call Divide
	ldh a, [hQuotient + 1]
	ldh [hMoneyTemp + 0], a
	ldh a, [hQuotient + 2]
	ldh [hMoneyTemp + 1], a
	ldh a, [hQuotient + 3]
	ldh [hMoneyTemp + 2], a
	pop bc
	ret

CalculateMaximumSellQuantity:
; Like CalculateMaximumQuantity for buying: limit [wItemQuantity] (the stack)
; to what can be sold before the money would pass MAX_MONEY. Selling q pays
; half of price * q (rounded down), so q fits while
; price * q <= 2 * (MAX_MONEY - Money) + 1. At least 1 (with the money
; already full, one can still be sold).
	; hDividend + 1..3 = 2 * (MAX_MONEY - Money) + 1 (big-endian)
	ld a, [wMoney + 2]
	ld b, a
	ld a, LOW(MAX_MONEY)
	sub b
	ldh [hDividend + 3], a
	ld a, [wMoney + 1]
	ld b, a
	ld a, HIGH(MAX_MONEY)
	sbc b
	ldh [hDividend + 2], a
	ld a, [wMoney + 0]
	ld b, a
	ld a, HIGH(MAX_MONEY >> 8)
	sbc b
	ldh [hDividend + 1], a
	jr nc, .got_room
	xor a ; (more money than MAX_MONEY: no room)
	ldh [hDividend + 1], a
	ldh [hDividend + 2], a
	ldh [hDividend + 3], a
.got_room
	ld hl, hDividend + 3
	sla [hl]
	set 0, [hl]
	dec hl
	rl [hl]
	dec hl
	rl [hl]

	; count how many fit: hMoneyTemp = price * b
	xor a
	ldh [hMoneyTemp + 0], a
	ldh [hMoneyTemp + 1], a
	ldh [hMoneyTemp + 2], a
	ld b, a
.loop
	ld a, [wItemQuantity]
	cp b
	jr z, .done ; the whole stack fits
	ldh a, [hMoneyTemp + 2]
	ld hl, wBuySellItemPrice + 1
	add [hl]
	ldh [hMoneyTemp + 2], a
	ldh a, [hMoneyTemp + 1]
	dec hl
	adc [hl]
	ldh [hMoneyTemp + 1], a
	ldh a, [hMoneyTemp + 0]
	adc 0
	ldh [hMoneyTemp + 0], a
	push bc
	ld bc, hMoneyTemp
	ld de, hDividend + 1
	farcall CompareMoney ; (carry if price * (b + 1) is over the limit)
	pop bc
	jr c, .done
	inc b
	jr .loop

.done
	ld a, b
	and a
	jr nz, .got_max
	inc a ; at least 1
.got_max
	ld [wItemQuantity], a
	ret

SelectQuantityToToss:
	ld hl, TossItem_MenuHeader
	call LoadMenuHeader
	jr Toss_Sell_Loop

SelectQuantityToBuy:
	farcall GetItemPrice
RooftopSale_SelectQuantityToBuy:
	ld a, d
	ld [wBuySellItemPrice + 0], a
	ld a, e
	ld [wBuySellItemPrice + 1], a
	call CalculateMaximumQuantity
	ld hl, BuyItem_MenuHeader
	call LoadMenuHeader
	jr Toss_Sell_Loop

SelectQuantityToSell:
	farcall GetItemPrice
	ld a, d
	ld [wBuySellItemPrice + 0], a
	ld a, e
	ld [wBuySellItemPrice + 1], a
	call CalculateMaximumSellQuantity
	ld hl, SellItem_MenuHeader
	call LoadMenuHeader
	; fallthrough

Toss_Sell_Loop:
	ld a, 1
	ld [wItemQuantityChange], a
.loop
	call BuySellToss_UpdateQuantityDisplay ; update display
	call BuySellToss_InterpretJoypad       ; joy action
	jr nc, .loop
	cp -1
	jr nz, .nope ; pressed B
	scf
	ret

.nope
	and a
	ret

BuySellToss_InterpretJoypad:
	call JoyTextDelay_ForcehJoyDown ; get joypad
	bit B_BUTTON_F, c
	jr nz, .b
	bit A_BUTTON_F, c
	jr nz, .a
	bit D_DOWN_F, c
	jr nz, .down
	bit D_UP_F, c
	jr nz, .up
	bit D_LEFT_F, c
	jr nz, .left
	bit D_RIGHT_F, c
	jr nz, .right
	and a
	ret

.b
	ld a, -1
	scf
	ret

.a
	ld a, 0
	scf
	ret

.down
	ld hl, wItemQuantityChange
	dec [hl]
	jr nz, .finish_down
	ld a, [wItemQuantity]
	ld [hl], a

.finish_down
	and a
	ret

.up
	ld hl, wItemQuantityChange
	inc [hl]
	ld a, [wItemQuantity]
	cp [hl]
	jr nc, .finish_up
	ld [hl], 1

.finish_up
	and a
	ret

.left
	ld a, [wItemQuantityChange]
	sub 10
	jr c, .load_1
	jr nz, .finish_left

.load_1
	ld a, 1

.finish_left
	ld [wItemQuantityChange], a
	and a
	ret

.right
	ld a, [wItemQuantityChange]
	add 10
	ld b, a
	ld a, [wItemQuantity]
	cp b
	jr nc, .finish_right
	ld b, a

.finish_right
	ld a, b
	ld [wItemQuantityChange], a
	and a
	ret

BuySellToss_UpdateQuantityDisplay:
	call MenuBox
	call MenuBoxCoord2Tile
	ld de, SCREEN_WIDTH + 1
	add hl, de
	ld [hl], "×"
	inc hl
	ld de, wItemQuantityChange
	lb bc, PRINTNUM_LEADINGZEROS | 1, 2
	call PrintNum
	ld a, [wMenuDataPointer]
	ld e, a
	ld a, [wMenuDataPointer + 1]
	ld d, a
	ld a, [wMenuDataBank]
	jmp FarCall_de

NoPriceToDisplay:
; Does nothing.
	ret

DisplayPurchasePrice:
	push hl
	ld a, [wItemQuantityChange]
	call GetBulkDiscount
	call PlaceBulkDiscount
	ld a, [wItemQuantityChange]
	call GetDiscountedPrice
	pop hl
	jr BuySell_PrintSubtotal

DisplaySellingPrice:
	call BuySell_MultiplyPrice
	call Sell_HalvePrice
	jr BuySell_DisplaySubtotal

BuySell_MultiplyPrice:
	xor a
	ldh [hMultiplicand + 0], a
	ld a, [wBuySellItemPrice + 0]
	ldh [hMultiplicand + 1], a
	ld a, [wBuySellItemPrice + 1]
	ldh [hMultiplicand + 2], a
	ld a, [wItemQuantityChange]
	ldh [hMultiplier], a
	push hl
	call Multiply
	pop hl
	ret

Sell_HalvePrice:
	push hl
	ld hl, hProduct + 1
	ld a, [hl]
	srl a
	ld [hli], a
	ld a, [hl]
	rra
	ld [hli], a
	ld a, [hl]
	rra
	ld [hl], a
	pop hl
	ret

BuySell_DisplaySubtotal:
	push hl
	ld hl, hMoneyTemp
	ldh a, [hProduct + 1]
	ld [hli], a
	ldh a, [hProduct + 2]
	ld [hli], a
	ldh a, [hProduct + 3]
	ld [hl], a
	pop hl
BuySell_PrintSubtotal:
	inc hl
	ld de, hMoneyTemp
	lb bc, PRINTNUM_MONEY | 3, 6
	call PrintNum
	jmp WaitBGMap

PlaceBulkDiscount:
; Place "Discount: nn%" in the speech box above the quantity box, or clear
; that line when there is no discount. a = the discount.
; hMoneyTemp is the scratch byte: the price is worked out after this.
	hlcoord 6, 13
	and a
	jr z, .clear
	ldh [hMoneyTemp + 2], a
	ld de, .DiscountString
	call PlaceString
	ld h, b
	ld l, c
	ld de, hMoneyTemp + 2
	lb bc, 1, 2
	call PrintNum
	ld [hl], "<%>"
	ret

.clear
	lb bc, 1, 13
	jmp ClearBox

.DiscountString:
	db "Discount: @"

TossItem_MenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 15, 9, SCREEN_WIDTH - 1, TEXTBOX_Y - 1
	dw NoPriceToDisplay
	db 0 ; default option

BuyItem_MenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 7, 15, SCREEN_WIDTH - 1, SCREEN_HEIGHT - 1
	dw DisplayPurchasePrice
	db -1 ; default option

SellItem_MenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 7, 15, SCREEN_WIDTH - 1, SCREEN_HEIGHT - 1
	dw DisplaySellingPrice
	db 0 ; default option
