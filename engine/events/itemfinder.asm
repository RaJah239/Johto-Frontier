ItemFinder:
	farcall CheckForHiddenItems
	jr c, .found_something
	ld hl, .Script_FoundNothing
	jr .resume

.found_something
	ld hl, .Script_FoundSomething

.resume
	call QueueScript
	ld a, $1
	ld [wItemEffectSucceeded], a
	ret

.ItemfinderFacing:
; wItemFinderDistance = distance (low nibble) + direction (high nibble), see
; CheckForHiddenItems. Leave the distance in it and the direction in
; wScriptVar: 0 down, 1 up, 2 left, 3 right, 4 standing on the item.
	ld a, [wItemFinderDistance]
	ld b, a
	and $0f
	ld [wItemFinderDistance], a
	ld a, b
	swap a
	and $0f
	ld [wScriptVar], a
	ret

.ItemfinderSound:
	ld a, [wItemFinderDistance]
	cp 2
	jr nc, .convert_distance_to_delay
	
	ld a, 1 ; Distances of 1 and 0 are set to 1. Because DelayFrames doesn't work properly with C=0.
.convert_distance_to_delay
	add a
	ld c, a
	add a
	add a
	add c
	inc a
	inc a
	ld [wItemFinderDistance], a ; Delay between beeps.
	ld de, SFX_SECOND_PART_OF_ITEMFINDER
	call PlaySFX
	ld de, SFX_TRANSACTION
	call WaitPlaySFX

	ld c, 2 ; Numbers of beeps after the first one.
.sfx_loop
	push bc
	ld a, [wItemFinderDistance]
	ld c, a
	call DelayFrames

	ld de, SFX_SECOND_PART_OF_ITEMFINDER
	call PlaySFX
	ld de, SFX_TRANSACTION
	call WaitPlaySFX
	pop bc
	dec c
	jr nz, .sfx_loop

	jmp WaitSFX

.Script_FoundSomething:
	refreshmap
	special UpdateTimePals
	callasm .ItemfinderFacing
	callasm .ItemfinderSound
	writetext .ItemfinderItemNearbyText
	closetext
	; turn towards the item, or spin if standing on it
	ifequal 0, .face_down
	ifequal 1, .face_up
	ifequal 2, .face_left
	ifequal 3, .face_right
	applymovement PLAYER, Movement_SpinWhenYouWin
	end

.face_down
	turnobject PLAYER, DOWN
	end
.face_up
	turnobject PLAYER, UP
	end
.face_left
	turnobject PLAYER, LEFT
	end
.face_right
	turnobject PLAYER, RIGHT
	end

.Script_FoundNothing:
	refreshmap
	special UpdateTimePals
	writetext .ItemfinderNopeText
	closetext
	end

.ItemfinderItemNearbyText:
	text_far _ItemfinderItemNearbyText
	text_end

.ItemfinderNopeText:
	text_far _ItemfinderNopeText
	text_end

Movement_SpinWhenYouWin:
	turn_head DOWN
	turn_head LEFT
	turn_head UP
	turn_head RIGHT
	turn_head DOWN
	turn_head LEFT
	turn_head UP
	turn_head RIGHT
	turn_head DOWN
	turn_head LEFT
	turn_head UP
	turn_head RIGHT
	turn_head DOWN
	step_end
