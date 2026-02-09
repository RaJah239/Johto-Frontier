	object_const_def
	const BATTLEPLAZABATTLEARENA_RECPTIONIST
	const BATTLEPLAZABATTLEARENA_ENEMY

BattlePlazaDraftArena_MapScripts:
	def_scene_scripts

	def_callbacks

BattleArenaReceptionistScript:
	opentext
	checkevent EVENT_DID_NOT_GET_BATTLE_ARENA_PRIZE
	iftrue .GivePrize
	writetext BattleArenaIntroText
	special TryQuickSave
	writetext UseYourOwnTeamText
	nooryes
	iftrue .PlayerUsesOwnTeam
	sjump .ChoosePlayerCharacter

.PlayerUsesOwnTeam
	sjump .ChooseEnemyCharacter

.StartBattle
	writetext BattleLobbyReceptionistGoRightInText
	waitbutton
	closetext
	applymovement BATTLEPLAZABATTLEARENA_RECPTIONIST, BattleLobbyReceptionist_MoveOutTheWay
	applymovement PLAYER, BattleLobbyPlayer_EnterBattleRoom
	winlosstext BattleLobbyPlayerVictoryText, 0
	startbattle
	ifequal WIN, .win
	dontrestartmapmusic
	reloadmap
	pause 15
	special BattleTowerFade
	warpfacing UP, BATTLE_PLAZA_DRAFT_ARENA, 3, 11
	turnobject PLAYER, UP
	opentext
	writetext BattleLobbyBattleLoseText
	waitbutton
	closetext
	special LoadPokemonData
	special HealParty
	end

.win
	dontrestartmapmusic
	reloadmapafterbattle
	pause 15
	special BattleTowerFade
	warpfacing UP, BATTLE_PLAZA_DRAFT_ARENA, 3, 11
	turnobject PLAYER, UP
	opentext
	writetext BattleLobbyBattleWinText
	waitbutton
	special LoadPokemonData
	special HealParty
.GivePrize
	verbosegiveitem CRYSTAL
	iffalse BattleArenaPackFull
	clearevent EVENT_DID_NOT_GET_BATTLE_ARENA_PRIZE
	closetext
	end

.ChoosePlayerCharacter
    writetext PickYourPlayerText
    loadmenu .CharacterMenuHeader
    _2dmenu
	closewindow
	ifequal 1, .RandomPlayer
	ifequal 2, .FalknerPlayer
	ifequal 3, .BugsyPlayer
	ifequal 4, .WhitneyPlayer
	ifequal 5, .MortyPlayer
	ifequal 6, .ChuckPlayer
	ifequal 7, .JasminePlayer
	ifequal 8, .PrycePlayer
	ifequal 9, .ClairPlayer
	ifequal 10, .BrockPlayer
	ifequal 11, .MistyPlayer
	ifequal 12, .SurgePlayer
	ifequal 13, .ErikaPlayer
	ifequal 14, .JaninePlayer
	ifequal 15, .SabrinaPlayer
	ifequal 16, .BlainePlayer
	ifequal 17, .WillPlayer
	ifequal 18, .BrunoPlayer
	ifequal 19, .KarenPlayer
	ifequal 20, .LoreleiPlayer
	ifequal 21, .AgathaPlayer
	ifequal 22, .InsafPlayer
	ifequal 23, .SilverPlayer
	ifequal 24, .GiovanniPlayer
	ifequal 25, .OakPlayer
	ifequal 26, .LancePlayer
	ifequal 27, .GreenPlayer
	ifequal 28, .BluePlayer
	ifequal 29, .RedPlayer
	writetext AreYouSureText
	yesorno
	iffalse .ChoosePlayerCharacter
	writetextend BattleLobbyBattleLoseText

.ChooseEnemyCharacter
	writetext PickYourEnemyText
    loadmenu .CharacterMenuHeader
    _2dmenu
	closewindow
	ifequal 1, .RandomEnemy
	ifequal 2, .FalknerEnemy
	ifequal 3, .BugsyEnemy
	ifequal 4, .WhitneyEnemy
	ifequal 5, .MortyEnemy
	ifequal 6, .ChuckEnemy
	ifequal 7, .JasmineEnemy
	ifequal 8, .PryceEnemy
	ifequal 9, .ClairEnemy
	ifequal 10, .BrockEnemy
	ifequal 11, .MistyEnemy
	ifequal 12, .SurgeEnemy
	ifequal 13, .ErikaEnemy
	ifequal 14, .JanineEnemy
	ifequal 15, .SabrinaEnemy
	ifequal 16, .BlaineEnemy
	ifequal 17, .WillEnemy
	ifequal 18, .BrunoEnemy
	ifequal 19, .KarenEnemy
	ifequal 20, .LoreleiEnemy
	ifequal 21, .AgathaEnemy
	ifequal 22, .InsafEnemy
	ifequal 23, .SilverEnemy
	ifequal 24, .GiovanniEnemy
	ifequal 25, .OakEnemy
	ifequal 26, .LanceEnemy
	ifequal 27, .GreenEnemy
	ifequal 28, .BlueEnemy
	ifequal 29, .RedEnemy
	writetext AreYouSureText
	yesorno
	iffalse .ChooseEnemyCharacter
	writetextend BattleLobbyBattleLoseText

.RandomPlayer:
	writetext PlayUsingRandomPlayerText
	yesorno
	iffalse .ChoosePlayerCharacter

.SampleAgain
	random 28
	ifequal 0, .FalknerPlayer
	ifequal 1, .BugsyPlayer
	ifequal 2, .WhitneyPlayer
	ifequal 3, .MortyPlayer
	ifequal 4, .ChuckPlayer
	ifequal 5, .JasminePlayer
	ifequal 6, .PrycePlayer
	ifequal 7, .ClairPlayer
	ifequal 8, .BrockPlayer
	ifequal 9, .MistyPlayer
	ifequal 10, .SurgePlayer
	ifequal 11, .ErikaPlayer
	ifequal 12, .JaninePlayer
	ifequal 13, .SabrinaPlayer
	ifequal 14, .BlainePlayer
	ifequal 15, .WillPlayer
	ifequal 16, .BrunoPlayer
	ifequal 17, .KarenPlayer
	ifequal 18, .LoreleiPlayer
	ifequal 19, .AgathaPlayer
	ifequal 20, .InsafPlayer
	ifequal 21, .SilverPlayer
	ifequal 22, .GiovanniPlayer
	ifequal 23, .OakPlayer
	ifequal 24, .LancePlayer
	ifequal 25, .GreenPlayer
	ifequal 26, .BluePlayer
	ifequal 27, .RedPlayer
	sjump .SampleAgain

.RandomEnemy:
	writetext PlayAgainstRandomPlayerText
	yesorno
	iffalse .ChooseEnemyCharacter

.Resample
	random 28
	ifequal 0, .FalknerEnemy
	ifequal 1, .BugsyEnemy
	ifequal 2, .WhitneyEnemy
	ifequal 3, .MortyEnemy
	ifequal 4, .ChuckEnemy
	ifequal 5, .JasmineEnemy
	ifequal 6, .PryceEnemy
	ifequal 7, .ClairEnemy
	ifequal 8, .BrockEnemy
	ifequal 9, .MistyEnemy
	ifequal 10, .SurgeEnemy
	ifequal 11, .ErikaEnemy
	ifequal 12, .JanineEnemy
	ifequal 13, .SabrinaEnemy
	ifequal 14, .BlaineEnemy
	ifequal 15, .WillEnemy
	ifequal 16, .BrunoEnemy
	ifequal 17, .KarenEnemy
	ifequal 18, .LoreleiEnemy
	ifequal 19, .AgathaEnemy
	ifequal 20, .InsafEnemy
	ifequal 21, .SilverEnemy
	ifequal 22, .GiovanniEnemy
	ifequal 23, .OakEnemy
	ifequal 24, .LanceEnemy
	ifequal 25, .GreenEnemy
	ifequal 26, .BlueEnemy
	ifequal 27, .RedEnemy
	sjump .Resample

.FalknerPlayer:
	writetext PlayUsingFalknerText
	yesorno
	iffalse .ChoosePlayerCharacter
	setval FALKNER
	writemem wOtherTrainerClass
	setval FALKNER1
	writemem wOtherTrainerID
	special OverridePlayerParty
    sjump .ChooseEnemyCharacter
.FalknerEnemy:
	writetext PlayAgainstFalknerText
	yesorno
	iffalse .ChooseEnemyCharacter
	loadtrainer FALKNER, FALKNER1
	sjump .StartBattle

.BugsyPlayer:
	writetext PlayUsingBugsyText
	yesorno
	iffalse .ChoosePlayerCharacter
	setval FALKNER
	writemem wOtherTrainerClass
	setval FALKNER1
	writemem wOtherTrainerID
	special OverridePlayerParty
    sjump .ChooseEnemyCharacter
.BugsyEnemy:
	writetext PlayAgainstBugsyText
	yesorno
	iffalse .ChooseEnemyCharacter
	loadtrainer BUGSY, BUGSY1
	sjump .StartBattle

.WhitneyPlayer:
	writetext PlayUsingWhitneyText
	yesorno
	iffalse .ChoosePlayerCharacter
	setval WHITNEY
	writemem wOtherTrainerClass
	setval WHITNEY1
	writemem wOtherTrainerID
	special OverridePlayerParty
    sjump .ChooseEnemyCharacter
.WhitneyEnemy:
	writetext PlayAgainstWhitneyText
	yesorno
	iffalse .ChooseEnemyCharacter
	loadtrainer WHITNEY, WHITNEY1
	sjump .StartBattle

.MortyPlayer:
	writetext PlayUsingMortyText
	yesorno
	iffalse .ChoosePlayerCharacter
	setval MORTY
	writemem wOtherTrainerClass
	setval MORTY1
	writemem wOtherTrainerID
	special OverridePlayerParty
    sjump .ChooseEnemyCharacter
.MortyEnemy:
	writetext PlayAgainstMortyText
	yesorno
	iffalse .ChooseEnemyCharacter
	loadtrainer MORTY, MORTY1
	sjump .StartBattle

.ChuckPlayer:
	writetext PlayUsingChuckText
	yesorno
	iffalse .ChoosePlayerCharacter
	setval CHUCK
	writemem wOtherTrainerClass
	setval CHUCK1
	writemem wOtherTrainerID
	special OverridePlayerParty
    sjump .ChooseEnemyCharacter
.ChuckEnemy:
	writetext PlayAgainstChuckText
	yesorno
	iffalse .ChooseEnemyCharacter
	loadtrainer CHUCK, CHUCK1
	sjump .StartBattle

.JasminePlayer:
	writetext PlayUsingJasmineText
	yesorno
	iffalse .ChoosePlayerCharacter
	setval JASMINE
	writemem wOtherTrainerClass
	setval JASMINE1
	writemem wOtherTrainerID
	special OverridePlayerParty
    sjump .ChooseEnemyCharacter
.JasmineEnemy:
	writetext PlayAgainstJasmineText
	yesorno
	iffalse .ChooseEnemyCharacter
	loadtrainer JASMINE, JASMINE1
	sjump .StartBattle

.PrycePlayer:
	writetext PlayUsingPryceText
	yesorno
	iffalse .ChoosePlayerCharacter
	setval PRYCE
	writemem wOtherTrainerClass
	setval PRYCE1
	writemem wOtherTrainerID
	special OverridePlayerParty
    sjump .ChooseEnemyCharacter
.PryceEnemy:
	writetext PlayAgainstPryceText
	yesorno
	iffalse .ChooseEnemyCharacter
	loadtrainer PRYCE, PRYCE1
	sjump .StartBattle

.ClairPlayer:
	writetext PlayUsingClairText
	yesorno
	iffalse .ChoosePlayerCharacter
	setval CLAIR
	writemem wOtherTrainerClass
	setval CLAIR1
	writemem wOtherTrainerID
	special OverridePlayerParty
    sjump .ChooseEnemyCharacter
.ClairEnemy:
	writetext PlayAgainstClairText
	yesorno
	iffalse .ChooseEnemyCharacter
	loadtrainer CLAIR, CLAIR1
	sjump .StartBattle

.BrockPlayer:
	writetext PlayUsingBrockText
	yesorno
	iffalse .ChoosePlayerCharacter
	setval BROCK
	writemem wOtherTrainerClass
	setval BROCK1
	writemem wOtherTrainerID
	special OverridePlayerParty
    sjump .ChooseEnemyCharacter
.BrockEnemy:
	writetext PlayAgainstBrockText
	yesorno
	iffalse .ChooseEnemyCharacter
	loadtrainer BROCK, BROCK1
	sjump .StartBattle

.MistyPlayer:
	writetext PlayUsingMistyText
	yesorno
	iffalse .ChoosePlayerCharacter
	setval MISTY
	writemem wOtherTrainerClass
	setval MISTY1
	writemem wOtherTrainerID
	special OverridePlayerParty
    sjump .ChooseEnemyCharacter
.MistyEnemy:
	writetext PlayAgainstMistyText
	yesorno
	iffalse .ChooseEnemyCharacter
	loadtrainer MISTY, MISTY1
	sjump .StartBattle

.SurgePlayer:
	writetext PlayUsingSurgeText
	yesorno
	iffalse .ChoosePlayerCharacter
	setval LT_SURGE
	writemem wOtherTrainerClass
	setval LT_SURGE1
	writemem wOtherTrainerID
	special OverridePlayerParty
    sjump .ChooseEnemyCharacter
.SurgeEnemy:
	writetext PlayAgainstSurgeText
	yesorno
	iffalse .ChooseEnemyCharacter
	loadtrainer LT_SURGE, LT_SURGE1
	sjump .StartBattle

.ErikaPlayer:
	writetext PlayUsingErikaText
	yesorno
	iffalse .ChoosePlayerCharacter
	setval ERIKA
	writemem wOtherTrainerClass
	setval ERIKA1
	writemem wOtherTrainerID
	special OverridePlayerParty
    sjump .ChooseEnemyCharacter
.ErikaEnemy:
	writetext PlayAgainstErikaText
	yesorno
	iffalse .ChooseEnemyCharacter
	loadtrainer ERIKA, ERIKA1
	sjump .StartBattle

.JaninePlayer:
	writetext PlayUsingJanineText
	yesorno
	iffalse .ChoosePlayerCharacter
	setval JANINE
	writemem wOtherTrainerClass
	setval JANINE1
	writemem wOtherTrainerID
	special OverridePlayerParty
    sjump .ChooseEnemyCharacter
.JanineEnemy:
	writetext PlayAgainstJanineText
	yesorno
	iffalse .ChooseEnemyCharacter
	loadtrainer JANINE, JANINE1
	sjump .StartBattle

.SabrinaPlayer:
	writetext PlayUsingSabrinaText
	yesorno
	iffalse .ChoosePlayerCharacter
	setval SABRINA
	writemem wOtherTrainerClass
	setval SABRINA1
	writemem wOtherTrainerID
	special OverridePlayerParty
    sjump .ChooseEnemyCharacter
.SabrinaEnemy:
	writetext PlayAgainstSabrinaText
	yesorno
	iffalse .ChooseEnemyCharacter
	loadtrainer SABRINA, SABRINA1
	sjump .StartBattle

.BlainePlayer:
	writetext PlayUsingBlaineText
	yesorno
	iffalse .ChoosePlayerCharacter
	setval BLAINE
	writemem wOtherTrainerClass
	setval BLAINE1
	writemem wOtherTrainerID
	special OverridePlayerParty
    sjump .ChooseEnemyCharacter
.BlaineEnemy:
	writetext PlayAgainstBlaineText
	yesorno
	iffalse .ChooseEnemyCharacter
	loadtrainer BLAINE, BLAINE1
	sjump .StartBattle

.WillPlayer:
	writetext PlayUsingWillText
	yesorno
	iffalse .ChoosePlayerCharacter
	setval WILL
	writemem wOtherTrainerClass
	setval WILL1
	writemem wOtherTrainerID
	special OverridePlayerParty
    sjump .ChooseEnemyCharacter
.WillEnemy:
	writetext PlayAgainstWillText
	yesorno
	iffalse .ChooseEnemyCharacter
	loadtrainer WILL, WILL1
	sjump .StartBattle

.BrunoPlayer:
	writetext PlayUsingBrunoText
	yesorno
	iffalse .ChoosePlayerCharacter
	setval BRUNO
	writemem wOtherTrainerClass
	setval BRUNO1
	writemem wOtherTrainerID
	special OverridePlayerParty
    sjump .ChooseEnemyCharacter
.BrunoEnemy:
	writetext PlayAgainstBrunoText
	yesorno
	iffalse .ChooseEnemyCharacter
	loadtrainer BRUNO, BRUNO1
	sjump .StartBattle

.KarenPlayer:
	writetext PlayUsingKarenText
	yesorno
	iffalse .ChoosePlayerCharacter
	setval KAREN
	writemem wOtherTrainerClass
	setval KAREN1
	writemem wOtherTrainerID
	special OverridePlayerParty
    sjump .ChooseEnemyCharacter
.KarenEnemy:
	writetext PlayAgainstKarenText
	yesorno
	iffalse .ChooseEnemyCharacter
	loadtrainer KAREN, KAREN1
	sjump .StartBattle

.LoreleiPlayer:
	writetext PlayUsingLoreleiText
	yesorno
	iffalse .ChoosePlayerCharacter
	setval LORELEI
	writemem wOtherTrainerClass
	setval LORELEI1
	writemem wOtherTrainerID
	special OverridePlayerParty
    sjump .ChooseEnemyCharacter
.LoreleiEnemy:
	writetext PlayAgainstLoreleiText
	yesorno
	iffalse .ChooseEnemyCharacter
	loadtrainer LORELEI, LORELEI1
	sjump .StartBattle

.AgathaPlayer:
	writetext PlayUsingAgathaText
	yesorno
	iffalse .ChoosePlayerCharacter
	setval AGATHA
	writemem wOtherTrainerClass
	setval AGATHA1
	writemem wOtherTrainerID
	special OverridePlayerParty
    sjump .ChooseEnemyCharacter
.AgathaEnemy:
	writetext PlayAgainstAgathaText
	yesorno
	iffalse .ChooseEnemyCharacter
	loadtrainer AGATHA, AGATHA1
	sjump .StartBattle

.InsafPlayer:
	writetext PlayUsingInsafText
	yesorno
	iffalse .ChoosePlayerCharacter
	setval INSAF
	writemem wOtherTrainerClass
	setval INSAF1
	writemem wOtherTrainerID
	special OverridePlayerParty
    sjump .ChooseEnemyCharacter
.InsafEnemy:
	writetext PlayAgainstInsafText
	yesorno
	iffalse .ChooseEnemyCharacter
	loadtrainer INSAF, INSAF1
	sjump .StartBattle

.SilverPlayer:
	writetext PlayUsingSilverText
	yesorno
	iffalse .ChoosePlayerCharacter
	setval RIVAL1
	writemem wOtherTrainerClass
	setval RIVAL1_1_CHIKORITA
	writemem wOtherTrainerID
	special OverridePlayerParty
    sjump .ChooseEnemyCharacter
.SilverEnemy:
	writetext PlayAgainstSilverText
	yesorno
	iffalse .ChooseEnemyCharacter
	loadtrainer RIVAL1, RIVAL1_1_CHIKORITA
	sjump .StartBattle

.GiovanniPlayer:
	writetext PlayUsingGiovanniText
	yesorno
	iffalse .ChoosePlayerCharacter
	setval GIOVANNI
	writemem wOtherTrainerClass
	setval GIOVANNI1
	writemem wOtherTrainerID
	special OverridePlayerParty
    sjump .ChooseEnemyCharacter
.GiovanniEnemy:
	writetext PlayAgainstGiovanniText
	yesorno
	iffalse .ChooseEnemyCharacter
	loadtrainer GIOVANNI, GIOVANNI1
	sjump .StartBattle

.OakPlayer:
	writetext PlayUsingOakText
	yesorno
	iffalse .ChoosePlayerCharacter
	setval POKEMON_PROF
	writemem wOtherTrainerClass
	setval OAK1
	writemem wOtherTrainerID
	special OverridePlayerParty
    sjump .ChooseEnemyCharacter
.OakEnemy:
	writetext PlayAgainstOakText
	yesorno
	iffalse .ChooseEnemyCharacter
	loadtrainer POKEMON_PROF, OAK1
	sjump .StartBattle

.LancePlayer:
	writetext PlayUsingLanceText
	yesorno
	iffalse .ChoosePlayerCharacter
	setval CHAMPION
	writemem wOtherTrainerClass
	setval LANCE
	writemem wOtherTrainerID
	special OverridePlayerParty
    sjump .ChooseEnemyCharacter
.LanceEnemy:
	writetext PlayAgainstLanceText
	yesorno
	iffalse .ChooseEnemyCharacter
	loadtrainer CHAMPION, LANCE
	sjump .StartBattle

.GreenPlayer:
	writetext PlayUsingGreenText
	yesorno
	iffalse .ChoosePlayerCharacter
	setval FALKNER
	writemem wOtherTrainerClass
	setval FALKNER1
	writemem wOtherTrainerID
	special OverridePlayerParty
    sjump .ChooseEnemyCharacter
.GreenEnemy:
	writetext PlayAgainstGreenText
	yesorno
	iffalse .ChooseEnemyCharacter
	loadtrainer FALKNER, FALKNER1
	sjump .StartBattle

.BluePlayer:
	writetext PlayUsingBlueText
	yesorno
	iffalse .ChoosePlayerCharacter
	setval BLUE
	writemem wOtherTrainerClass
	setval BLUE1
	writemem wOtherTrainerID
	special OverridePlayerParty
    sjump .ChooseEnemyCharacter
.BlueEnemy:
	writetext PlayAgainstBlueText
	yesorno
	iffalse .ChooseEnemyCharacter
	loadtrainer BLUE, BLUE1
	sjump .StartBattle

.RedPlayer:
	writetext PlayUsingRedText
	yesorno
	iffalse .ChoosePlayerCharacter
	setval RED
	writemem wOtherTrainerClass
	setval RED1
	writemem wOtherTrainerID
	special OverridePlayerParty
    sjump .ChooseEnemyCharacter
.RedEnemy:
	writetext PlayAgainstRedText
	yesorno
	iffalse .ChooseEnemyCharacter
	loadtrainer RED, RED1
	sjump .StartBattle

.CharacterMenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 0, 0, 19, 11
	dw .CharacterMenuData
	db 1 ; default option
.CharacterMenuData:
	db STATICMENU_CURSOR | STATICMENU_DISABLE_B | STATICMENU_WRAP ; flags
	dn 5, 6 ; rows, columns
	db 3 ; spacing
	dba .CharacterText
	dbw BANK(@), NULL
.CharacterText:
	db "RN@"
	db "FK@"
	db "BG@"
	db "WH@"
	db "MT@"
	db "CH@"
	db "JS@"
	db "PY@"
	db "CL@"
	db "BK@"
	db "MS@"
	db "SU@"
	db "ER@"
	db "JA@"
	db "SB@"
	db "BL@"
	db "WL@"
	db "BN@"
	db "KN@"
	db "LO@"
	db "AG@"
	db "IN@"
	db "SL@"
	db "GV@"
	db "OK@"
	db "LN@"
	db "GR@"
	db "BU@"
	db "RD@"
	db "EX@"

BattleArenaPackFull:
	setevent EVENT_DID_NOT_GET_BATTLE_ARENA_PRIZE
	writetextend BattleLobbyFullPackText

BattleArenaIntroText:
	text "Battle Arena"
	line "welcomes you!"
	done

UseYourOwnTeamText:
	text "Would you use your"
	line "own #mon?"
	done

PickYourPlayerText:
	text "Choose whose team"
	line "to use."
	done

AreYouSureText:
	text "Cancel your"
	line "challenge?"
	done

PickYourEnemyText:
	text "Choose whose team"
	line "to battle against."
	done

PlayUsingRandomPlayerText:
	text "Use a random"
	line "trainer's team?"
	done

PlayAgainstRandomPlayerText:
	text "Battle a random"
	line "trainer's team?"
	done

PlayUsingFalknerText:
	text "Play using Leader"
	line "Falkner's team?"
	done

PlayAgainstFalknerText:
	text "Play against"
	line "Leader Falkner?"
	done

PlayUsingBugsyText:
	text "Play using Leader"
	line "Bugsy's team?"
	done

PlayAgainstBugsyText:
	text "Play against"
	line "Leader Bugsy?"
	done

PlayUsingWhitneyText:
	text "Play using Leader"
	line "Whitney's team?"
	done

PlayAgainstWhitneyText:
	text "Play against"
	line "Leader Whitney?"
	done

PlayUsingMortyText:
	text "Play using Leader"
	line "Morty's team?"
	done

PlayAgainstMortyText:
	text "Play against"
	line "Leader Morty?"
	done

PlayUsingChuckText:
	text "Play using Leader"
	line "Chuck's team?"
	done

PlayAgainstChuckText:
	text "Play against"
	line "Leader Chuck?"
	done

PlayUsingJasmineText:
	text "Play using Leader"
	line "Jasmine's team?"
	done

PlayAgainstJasmineText:
	text "Play against"
	line "Leader Jasmine?"
	done

PlayUsingPryceText:
	text "Play using Leader"
	line "Pryce's team?"
	done

PlayAgainstPryceText:
	text "Play against"
	line "Leader Pryce?"
	done

PlayUsingClairText:
	text "Play using Leader"
	line "Clair's team?"
	done

PlayAgainstClairText:
	text "Play against"
	line "Leader Clair?"
	done

PlayUsingBrockText:
	text "Play using Leader"
	line "Brock's team?"
	done

PlayAgainstBrockText:
	text "Play against"
	line "Leader Brock?"
	done

PlayUsingMistyText:
	text "Play using Leader"
	line "Misty's team?"
	done

PlayAgainstMistyText:
	text "Play against"
	line "Leader Misty?"
	done

PlayUsingSurgeText:
	text "Play using Leader"
	line "Surge's team?"
	done

PlayAgainstSurgeText:
	text "Play against"
	line "Leader Surge?"
	done

PlayUsingErikaText:
	text "Play using Leader"
	line "Erika's team?"
	done

PlayAgainstErikaText:
	text "Play against"
	line "Leader Erika?"
	done

PlayUsingJanineText:
	text "Play using Leader"
	line "Janine's team?"
	done

PlayAgainstJanineText:
	text "Play against"
	line "Leader Janine?"
	done

PlayUsingSabrinaText:
	text "Play using Leader"
	line "Sabrina's team?"
	done

PlayAgainstSabrinaText:
	text "Play against"
	line "Leader Sabrina?"
	done

PlayUsingBlaineText:
	text "Play using Leader"
	line "Blaine's team?"
	done

PlayAgainstBlaineText:
	text "Play against"
	line "Leader Blaine?"
	done

PlayUsingWillText:
	text "Play using Leader"
	line "Will's team?"
	done

PlayAgainstWillText:
	text "Play against"
	line "Leader Will?"
	done

PlayUsingBrunoText:
	text "Play using Leader"
	line "Bruno's team?"
	done

PlayAgainstBrunoText:
	text "Play against"
	line "Leader Bruno?"
	done

PlayUsingKarenText:
	text "Play using Leader"
	line "Karen's team?"
	done

PlayAgainstKarenText:
	text "Play against"
	line "Leader Karen?"
	done

PlayUsingLoreleiText:
	text "Play using Leader"
	line "Lorelei's team?"
	done

PlayAgainstLoreleiText:
	text "Play against"
	line "Leader Lorelei?"
	done

PlayUsingAgathaText:
	text "Play using Leader"
	line "Agatha's team?"
	done

PlayAgainstAgathaText:
	text "Play against"
	line "Leader Agatha?"
	done

PlayUsingInsafText:
	text "Play using"
	line "<PKMN> Trainer"
	cont "Insaf's team?"
	done

PlayAgainstInsafText:
	text "Play against"
	line "<PKMN> Trainer Insaf?"
	done

PlayUsingSilverText:
	text "Play using"
	line "<PKMN> Trainer"
	cont "Silver's team?"
	done

PlayAgainstSilverText:
	text "Play against"
	line "<PKMN> Trainer Silver?"
	done

PlayUsingGiovanniText:
	text "Play using"
	line "Boss Giovanni's"
	cont "team?"
	done

PlayAgainstGiovanniText:
	text "Play against"
	line "Boss Giovanni?"
	done

PlayUsingOakText:
	text "Play using"
	line "Professor Oak's"
	cont "team?"
	done

PlayAgainstOakText:
	text "Play against"
	line "Professor Oak?"
	done

PlayUsingLanceText:
	text "Play using"
	line "Champion Lance's"
	cont "team?"
	done

PlayAgainstLanceText:
	text "Play against"
	line "Champion Lance?"
	done

PlayUsingGreenText:
	text "Play using"
	line "<PKMN> Trainer"
	cont "Green's team?"
	done

PlayAgainstGreenText:
	text "Play against"
	line "<PKMN> Trainer Green?"
	done

PlayUsingBlueText:
	text "Play using"
	line "<PKMN> Trainer"
	cont "Blue's team?"
	done

PlayAgainstBlueText:
	text "Play against"
	line "<PKMN> Trainer Blue?"
	done

PlayUsingRedText:
	text "Play using"
	line "<PKMN> Trainer"
	cont "Red's team?"
	done

PlayAgainstRedText:
	text "Play against"
	line "<PKMN> Trainer Red?"
	done

DraftArenaNoteSign:
	jumptext DraftArenaNoteSignText

DraftArenaNoteSignText:
	text "You may battle us-"
	line "ing your own or"
	cont "other trainer's"
	cont "#mon team."

	para "Each victory will"
	line "net you a Crystal."
	done

BattlePlazaDraftArena_MapEvents:
	def_warp_events
	warp_event  4, 13, BATTLE_PLAZA, 9
	warp_event  3, 13, BATTLE_PLAZA, 8

	def_coord_events

	def_bg_events
	bg_event  2, 10, BGEVENT_READ, DraftArenaNoteSign

	def_object_events
	object_event  3, 10, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, BattleArenaReceptionistScript, -1
	object_event  4,  3, SPRITE_UNKNOWN, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, -1
