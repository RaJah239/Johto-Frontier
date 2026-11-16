; The ball thrown in battle for each ball item (LoadBattleAnimGFX). Its colors
; are the item's icon colors in the Bag (ItemIconPalettes); anything else
; (like a stale wCurItem when a ball isn't being thrown) shows a Poke Ball.

BattleBallGFX:
	db POKE_BALL
	dba AnimObjPokeBallGFX
	db GREAT_BALL
	dba AnimObjGreatBallGFX
	db ULTRA_BALL
	dba AnimObjUltraBallGFX
	db MASTER_BALL
	dba AnimObjMasterBallGFX
	db HEAVY_BALL
	dba AnimObjHeavyBallGFX
	db LEVEL_BALL
	dba AnimObjLevelBallGFX
	db LURE_BALL
	dba AnimObjLureBallGFX
	db FAST_BALL
	dba AnimObjFastBallGFX
	db FRIEND_BALL
	dba AnimObjFriendBallGFX
	db MOON_BALL
	dba AnimObjMoonBallGFX
	db LOVE_BALL
	dba AnimObjLoveBallGFX
	db PARK_BALL
	dba AnimObjParkBallGFX
	db SHINY_BALL
	dba AnimObjShinyBallGFX
	db -1 ; end

WhitePalette:
	RGB 31, 31, 31
