BattleCommand_Splash:
	farcall AnimateCurrentMove
	call GetCurrentMon
	cp_species MAGIKARP
	jr z, .vigor
	cp_species FEEBAS
	jr z, .vigor
	farjp PrintNothingHappened

.vigor
	ld hl, VigorousSplashText
	jmp StdBattleTextbox
