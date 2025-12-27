BattleCommand_Splash:
	farcall AnimateCurrentMove
	call GetCurrentMon
	cp MAGIKARP
	jr z, .vigor
	cp FEEBAS
	jr z, .vigor
	farjp PrintNothingHappened

.vigor
	ld hl, VigorousSplashText
	jmp StdBattleTextbox
