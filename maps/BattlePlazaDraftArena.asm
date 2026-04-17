; TODOTEXT
; ============
; === Note ===
; ============
; in random mode here, add as many trainers as I have in game
; put a npc in the building that says there are more trainers
; in random mode that aren't available on the list of 29


BattlePlazaDraftArena_MapEvents:
	def_warp_events
	warp_event  4, 13, BATTLE_PLAZA, 9
	warp_event  3, 13, BATTLE_PLAZA, 8

	def_coord_events

	def_bg_events
	bg_event  2, 10, BGEVENT_JUMPTEXT, DraftArenaNoteSignText

	def_object_events
	object_event  3, 10, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, BattleArenaReceptionistScript, -1
	object_event  4,  3, SPRITE_UNKNOWN, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, -1

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
	writethistext
		text "Battle Arena"
		line "welcomes you!"
		done
	promptbutton
	special TryQuickSave
	iffalse_endtext
	writethistext
		text "Would you use your"
		line "own #mon?"
		done
	nooryes
	iftrue .PlayerUsesOwnTeam
	sjump .ChoosePlayerCharacter

.PlayerUsesOwnTeam
	sjump .ChooseEnemyCharacter

.StartBattle
	writetext BattlePlazasReceptionistGoRightInText
	waitclosetext
	applymovement BATTLEPLAZABATTLEARENA_RECPTIONIST, BattlePlazasReceptionist_MoveOutTheWay
	applymovement PLAYER, BattlePlazasPlayer_EnterBattleRoom
	winlosstext BattlePlazasPlayerVictoryText, 0
	startbattle
	ifequal WIN, .win
.lose
	dontrestartmapmusic
	reloadmap
	pause 15
	special BattleTowerFade
	warpfacing UP, BATTLE_PLAZA_DRAFT_ARENA, 3, 11
	turnobject PLAYER, UP
	opentext
	writetext BattlePlazasBattleLoseText
	waitbutton
	special LoadPokemonData
	special HealParty
	special TryQuickSave
	iffalse_endtext
	endtext

.win
	dontrestartmapmusic
	reloadmapafterbattle
	pause 15
	special BattleTowerFade
	warpfacing UP, BATTLE_PLAZA_DRAFT_ARENA, 3, 11
	turnobject PLAYER, UP
	opentext
	writetext BattlePlazasBattleWinText
	waitbutton
	special LoadPokemonData
	special HealParty
	special TryQuickSave
	iffalse_endtext
.GivePrize
	verbosegiveitem CRYSTAL
	iffalse BattleArenaPackFull
	clearevent EVENT_DID_NOT_GET_BATTLE_ARENA_PRIZE
	endtext

.ChoosePlayerCharacter
	writethistext
		text "Choose whose team"
		line "to use."
		done
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
	ifequal 18, .KogaPlayer
	ifequal 19, .BrunoPlayer
	ifequal 20, .KarenPlayer
	ifequal 21, .LoreleiPlayer
	ifequal 22, .AgathaPlayer
	ifequal 23, .InsafPlayer
	ifequal 24, .SilverPlayer
	ifequal 25, .GiovanniPlayer
	ifequal 26, .OakPlayer
	ifequal 27, .LancePlayer
	ifequal 28, .GreenPlayer
	ifequal 29, .BluePlayer
	ifequal 30, .RedPlayer
	writetext AreYouSureText
	yesorno
	iffalse .ChoosePlayerCharacter
	special LoadPokemonData
	writetext BattlePlazasBattleLoseText
	waitendtext

.ChooseEnemyCharacter
	writethistext
		text "Choose whose team"
		line "to battle against."
		done
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
	ifequal 18, .KogaEnemy
	ifequal 19, .BrunoEnemy
	ifequal 20, .KarenEnemy
	ifequal 21, .LoreleiEnemy
	ifequal 22, .AgathaEnemy
	ifequal 23, .InsafEnemy
	ifequal 24, .SilverEnemy
	ifequal 25, .GiovanniEnemy
	ifequal 26, .OakEnemy
	ifequal 27, .LanceEnemy
	ifequal 28, .GreenEnemy
	ifequal 29, .BlueEnemy
	ifequal 30, .RedEnemy
	writetext AreYouSureText
	yesorno
	iffalse .ChooseEnemyCharacter
	special LoadPokemonData
	writetext BattlePlazasBattleLoseText
	waitendtext

.RandomPlayer:
	writethistext
		text "Use a random"
		line "trainer's team?"
		done
	yesorno
	iffalse .ChoosePlayerCharacter

.SampleAgain
	random 29
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
	ifequal 16, .KogaPlayer
	ifequal 17, .BrunoPlayer
	ifequal 18, .KarenPlayer
	ifequal 19, .LoreleiPlayer
	ifequal 20, .AgathaPlayer
	ifequal 21, .InsafPlayer
	ifequal 22, .SilverPlayer
	ifequal 23, .GiovanniPlayer
	ifequal 24, .OakPlayer
	ifequal 25, .LancePlayer
	ifequal 26, .GreenPlayer
	ifequal 27, .BluePlayer
	ifequal 28, .RedPlayer
	sjump .SampleAgain

.RandomEnemy:
	writethistext
		text "Battle a random"
		line "trainer's team?"
		done
	yesorno
	iffalse .ChooseEnemyCharacter

.Resample
	random 29
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
	ifequal 16, .KogaEnemy
	ifequal 17, .BrunoEnemy
	ifequal 18, .KarenEnemy
	ifequal 19, .LoreleiEnemy
	ifequal 20, .AgathaEnemy
	ifequal 21, .InsafEnemy
	ifequal 22, .SilverEnemy
	ifequal 23, .GiovanniEnemy
	ifequal 24, .OakEnemy
	ifequal 25, .LanceEnemy
	ifequal 26, .GreenEnemy
	ifequal 27, .BlueEnemy
	ifequal 28, .RedEnemy
	sjump .Resample

.FalknerPlayer:
	writethistext
		text "Play using Leader"
		line "Falkner's team?"
		done
	yesorno
	iffalse .ChoosePlayerCharacter
	setval FALKNER
	writemem wOtherTrainerClass
	setval FALKNER1
	writemem wOtherTrainerID
	special OverridePlayerParty
    sjump .ChooseEnemyCharacter
.FalknerEnemy:
	writethistext
		text "Play against"
		line "Leader Falkner?"
		done
	yesorno
	iffalse .ChooseEnemyCharacter
	loadtrainer FALKNER, FALKNER1
	sjump .StartBattle

.BugsyPlayer:
	writethistext
	text "Play using Leader"
	line "Bugsy's team?"
	done
	yesorno
	iffalse .ChoosePlayerCharacter
	setval FALKNER
	writemem wOtherTrainerClass
	setval FALKNER1
	writemem wOtherTrainerID
	special OverridePlayerParty
    sjump .ChooseEnemyCharacter
.BugsyEnemy:
	writethistext
	text "Play against"
	line "Leader Bugsy?"
	done
	yesorno
	iffalse .ChooseEnemyCharacter
	loadtrainer BUGSY, BUGSY1
	sjump .StartBattle

.WhitneyPlayer:
	writethistext
		text "Play using Leader"
		line "Whitney's team?"
		done
	yesorno
	iffalse .ChoosePlayerCharacter
	setval WHITNEY
	writemem wOtherTrainerClass
	setval WHITNEY1
	writemem wOtherTrainerID
	special OverridePlayerParty
    sjump .ChooseEnemyCharacter
.WhitneyEnemy:
	writethistext
		text "Play against"
		line "Leader Whitney?"
		done
	yesorno
	iffalse .ChooseEnemyCharacter
	loadtrainer WHITNEY, WHITNEY1
	sjump .StartBattle

.MortyPlayer:
	writethistext
		text "Play using Leader"
		line "Morty's team?"
		done
	yesorno
	iffalse .ChoosePlayerCharacter
	setval MORTY
	writemem wOtherTrainerClass
	setval MORTY1
	writemem wOtherTrainerID
	special OverridePlayerParty
    sjump .ChooseEnemyCharacter
.MortyEnemy:
	writethistext
		text "Play against"
		line "Leader Morty?"
		done
	yesorno
	iffalse .ChooseEnemyCharacter
	loadtrainer MORTY, MORTY1
	sjump .StartBattle

.ChuckPlayer:
	writethistext PlayUsingChuckText
		text "Play using Leader"
		line "Chuck's team?"
		done
	yesorno
	iffalse .ChoosePlayerCharacter
	setval CHUCK
	writemem wOtherTrainerClass
	setval CHUCK1
	writemem wOtherTrainerID
	special OverridePlayerParty
    sjump .ChooseEnemyCharacter
.ChuckEnemy:
	writethistext
		text "Play against"
		line "Leader Chuck?"
		done
	yesorno
	iffalse .ChooseEnemyCharacter
	loadtrainer CHUCK, CHUCK1
	sjump .StartBattle

.JasminePlayer:
	writethistext
		text "Play using Leader"
		line "Jasmine's team?"
		done
	yesorno
	iffalse .ChoosePlayerCharacter
	setval JASMINE
	writemem wOtherTrainerClass
	setval JASMINE1
	writemem wOtherTrainerID
	special OverridePlayerParty
    sjump .ChooseEnemyCharacter
.JasmineEnemy:
	writethistext
		text "Play against"
		line "Leader Jasmine?"
		done
	yesorno
	iffalse .ChooseEnemyCharacter
	loadtrainer JASMINE, JASMINE1
	sjump .StartBattle

.PrycePlayer:
	writethistext
		text "Play using Leader"
		line "Pryce's team?"
		done
	yesorno
	iffalse .ChoosePlayerCharacter
	setval PRYCE
	writemem wOtherTrainerClass
	setval PRYCE1
	writemem wOtherTrainerID
	special OverridePlayerParty
    sjump .ChooseEnemyCharacter
.PryceEnemy:
	writethistext
		text "Play against"
		line "Leader Pryce?"
		done
	yesorno
	iffalse .ChooseEnemyCharacter
	loadtrainer PRYCE, PRYCE1
	sjump .StartBattle

.ClairPlayer:
	writethistext
		text "Play using Leader"
		line "Clair's team?"
		done
	yesorno
	iffalse .ChoosePlayerCharacter
	setval CLAIR
	writemem wOtherTrainerClass
	setval CLAIR1
	writemem wOtherTrainerID
	special OverridePlayerParty
    sjump .ChooseEnemyCharacter
.ClairEnemy:
	writethistext
		text "Play against"
		line "Leader Clair?"
		done
	yesorno
	iffalse .ChooseEnemyCharacter
	loadtrainer CLAIR, CLAIR1
	sjump .StartBattle

.BrockPlayer:
	writethistext
		text "Play using Leader"
		line "Brock's team?"
		done
	yesorno
	iffalse .ChoosePlayerCharacter
	setval BROCK
	writemem wOtherTrainerClass
	setval BROCK1
	writemem wOtherTrainerID
	special OverridePlayerParty
    sjump .ChooseEnemyCharacter
.BrockEnemy:
	writethistext
		text "Play against"
		line "Leader Brock?"
		done
	yesorno
	iffalse .ChooseEnemyCharacter
	loadtrainer BROCK, BROCK1
	sjump .StartBattle

.MistyPlayer:
	writethistext
		text "Play using Leader"
		line "Misty's team?"
		done
	yesorno
	iffalse .ChoosePlayerCharacter
	setval MISTY
	writemem wOtherTrainerClass
	setval MISTY1
	writemem wOtherTrainerID
	special OverridePlayerParty
    sjump .ChooseEnemyCharacter
.MistyEnemy:
	writethistext
		text "Play against"
		line "Leader Misty?"
		done
	yesorno
	iffalse .ChooseEnemyCharacter
	loadtrainer MISTY, MISTY1
	sjump .StartBattle

.SurgePlayer:
	writethistext
		text "Play using Leader"
		line "Surge's team?"
		done
	yesorno
	iffalse .ChoosePlayerCharacter
	setval LT_SURGE
	writemem wOtherTrainerClass
	setval LT_SURGE1
	writemem wOtherTrainerID
	special OverridePlayerParty
    sjump .ChooseEnemyCharacter
.SurgeEnemy:
	writethistext
		text "Play against"
		line "Leader Surge?"
		done
	yesorno
	iffalse .ChooseEnemyCharacter
	loadtrainer LT_SURGE, LT_SURGE1
	sjump .StartBattle

.ErikaPlayer:
	writethistext
		text "Play using Leader"
		line "Erika's team?"
		done
	yesorno
	iffalse .ChoosePlayerCharacter
	setval ERIKA
	writemem wOtherTrainerClass
	setval ERIKA1
	writemem wOtherTrainerID
	special OverridePlayerParty
    sjump .ChooseEnemyCharacter
.ErikaEnemy:
	writethistext
		text "Play against"
		line "Leader Erika?"
		done
	yesorno
	iffalse .ChooseEnemyCharacter
	loadtrainer ERIKA, ERIKA1
	sjump .StartBattle

.JaninePlayer:
	writethistext
		text "Play using Leader"
		line "Janine's team?"
		done
	yesorno
	iffalse .ChoosePlayerCharacter
	setval JANINE
	writemem wOtherTrainerClass
	setval JANINE1
	writemem wOtherTrainerID
	special OverridePlayerParty
    sjump .ChooseEnemyCharacter
.JanineEnemy:
	writethistext
		text "Play against"
		line "Leader Janine?"
		done
	yesorno
	iffalse .ChooseEnemyCharacter
	loadtrainer JANINE, JANINE1
	sjump .StartBattle

.SabrinaPlayer:
	writethistext
		text "Play using Leader"
		line "Sabrina's team?"
		done
	yesorno
	iffalse .ChoosePlayerCharacter
	setval SABRINA
	writemem wOtherTrainerClass
	setval SABRINA1
	writemem wOtherTrainerID
	special OverridePlayerParty
    sjump .ChooseEnemyCharacter
.SabrinaEnemy:
	writethistext
		text "Play against"
		line "Leader Sabrina?"
		done
	yesorno
	iffalse .ChooseEnemyCharacter
	loadtrainer SABRINA, SABRINA1
	sjump .StartBattle

.BlainePlayer:
	writethistext
		text "Play using Leader"
		line "Blaine's team?"
		done
	yesorno
	iffalse .ChoosePlayerCharacter
	setval BLAINE
	writemem wOtherTrainerClass
	setval BLAINE1
	writemem wOtherTrainerID
	special OverridePlayerParty
    sjump .ChooseEnemyCharacter
.BlaineEnemy:
	writethistext
		text "Play against"
		line "Leader Blaine?"
		done
	yesorno
	iffalse .ChooseEnemyCharacter
	loadtrainer BLAINE, BLAINE1
	sjump .StartBattle

.WillPlayer:
	writethistext
		text "Play using Elite"
		line "Four Will's team?"
		done
	yesorno
	iffalse .ChoosePlayerCharacter
	setval WILL
	writemem wOtherTrainerClass
	setval WILL1
	writemem wOtherTrainerID
	special OverridePlayerParty
    sjump .ChooseEnemyCharacter
.WillEnemy:
	writethistext
		text "Play against Elite"
		line "Four Will?"
		done
	yesorno
	iffalse .ChooseEnemyCharacter
	loadtrainer WILL, WILL1
	sjump .StartBattle

.KogaPlayer:
	writethistext
		text "Play using Elite"
		line "Four Koga's team?"
		done
	yesorno
	iffalse .ChoosePlayerCharacter
	setval KOGA
	writemem wOtherTrainerClass
	setval KOGA1
	writemem wOtherTrainerID
	special OverridePlayerParty
    sjump .ChooseEnemyCharacter
.KogaEnemy:
	writethistext
		text "Play against Elite"
		line "Four Koga?"
		done
	yesorno
	iffalse .ChooseEnemyCharacter
	loadtrainer KOGA, KOGA1
	sjump .StartBattle

.BrunoPlayer:
	writethistext
		text "Play using Elite"
		line "Four Bruno's team?"
		done
	yesorno
	iffalse .ChoosePlayerCharacter
	setval BRUNO
	writemem wOtherTrainerClass
	setval BRUNO1
	writemem wOtherTrainerID
	special OverridePlayerParty
    sjump .ChooseEnemyCharacter
.BrunoEnemy:
	writethistext
		text "Play against Elite"
		line "Four Bruno?"
		done
	yesorno
	iffalse .ChooseEnemyCharacter
	loadtrainer BRUNO, BRUNO1
	sjump .StartBattle

.KarenPlayer:
	writethistext
		text "Play using Elite"
		line "Four Karen's team?"
		done
	yesorno
	iffalse .ChoosePlayerCharacter
	setval KAREN
	writemem wOtherTrainerClass
	setval KAREN1
	writemem wOtherTrainerID
	special OverridePlayerParty
    sjump .ChooseEnemyCharacter
.KarenEnemy:
	writethistext
		text "Play against Elite"
		line "Four Karen?"
		done
	yesorno
	iffalse .ChooseEnemyCharacter
	loadtrainer KAREN, KAREN1
	sjump .StartBattle

.LoreleiPlayer:
	writethistext
		text "Play using <PKMN>"
		line "Trainer Lorelei's"
		cont "team?"
		done
	yesorno
	iffalse .ChoosePlayerCharacter
	setval LORELEI
	writemem wOtherTrainerClass
	setval LORELEI1
	writemem wOtherTrainerID
	special OverridePlayerParty
    sjump .ChooseEnemyCharacter
.LoreleiEnemy:
	writethistext
		text "Play against <PKMN>"
		line "Trainer Lorelei?"
		done
	yesorno
	iffalse .ChooseEnemyCharacter
	loadtrainer LORELEI, LORELEI1
	sjump .StartBattle

.AgathaPlayer:
	writethistext
		text "Play using <PKMN>"
		line "Trainer Agatha's"
		cont "team?"
		done
	yesorno
	iffalse .ChoosePlayerCharacter
	setval AGATHA
	writemem wOtherTrainerClass
	setval AGATHA1
	writemem wOtherTrainerID
	special OverridePlayerParty
    sjump .ChooseEnemyCharacter
.AgathaEnemy:
	writethistext
		text "Play against <PKMN>"
		line "Trainer Agatha?"
		done
	yesorno
	iffalse .ChooseEnemyCharacter
	loadtrainer AGATHA, AGATHA1
	sjump .StartBattle

.InsafPlayer:
	writethistext
		text "Play using <PKMN>"
		line "Trainer Insaf's"
		cont "team?"
		done
	yesorno
	iffalse .ChoosePlayerCharacter
	setval INSAF
	writemem wOtherTrainerClass
	setval INSAF1
	writemem wOtherTrainerID
	special OverridePlayerParty
    sjump .ChooseEnemyCharacter
.InsafEnemy:
	writethistext
		text "Play against"
		line "<PKMN> Trainer Insaf?"
		done
	yesorno
	iffalse .ChooseEnemyCharacter
	loadtrainer INSAF, INSAF1
	sjump .StartBattle

.SilverPlayer:
	writethistext
		text "Play using <PKMN>"
		line "Trainer Silver's"
		cont "team?"
		done
	yesorno
	iffalse .ChoosePlayerCharacter
	setval RIVAL1
	writemem wOtherTrainerClass
	setval RIVAL1_1_CHIKORITA
	writemem wOtherTrainerID
	special OverridePlayerParty
    sjump .ChooseEnemyCharacter
.SilverEnemy:
	writethistext
		text "Play against <PKMN>"
		line "Trainer Silver?"
		done
	yesorno
	iffalse .ChooseEnemyCharacter
	loadtrainer RIVAL1, RIVAL1_1_CHIKORITA
	sjump .StartBattle

.GiovanniPlayer:
	writethistext
		text "Play using Boss"
		line "Giovanni's team?"
		done
	yesorno
	iffalse .ChoosePlayerCharacter
	setval GIOVANNI
	writemem wOtherTrainerClass
	setval GIOVANNI1
	writemem wOtherTrainerID
	special OverridePlayerParty
    sjump .ChooseEnemyCharacter
.GiovanniEnemy:
	writethistext
		text "Play against"
		line "Boss Giovanni?"
		done
	yesorno
	iffalse .ChooseEnemyCharacter
	loadtrainer GIOVANNI, GIOVANNI1
	sjump .StartBattle

.OakPlayer:
	writethistext
		text "Play using"
		line "Professor Oak's"
		cont "team?"
		done
	yesorno
	iffalse .ChoosePlayerCharacter
	setval POKEMON_PROF
	writemem wOtherTrainerClass
	setval OAK1
	writemem wOtherTrainerID
	special OverridePlayerParty
    sjump .ChooseEnemyCharacter
.OakEnemy:
	writethistext
		text "Play against"
		line "Professor Oak?"
		done
	yesorno
	iffalse .ChooseEnemyCharacter
	loadtrainer POKEMON_PROF, OAK1
	sjump .StartBattle

.LancePlayer:
	writethistext
		text "Play using"
		line "Champion Lance's"
		cont "team?"
		done
	yesorno
	iffalse .ChoosePlayerCharacter
	setval CHAMPION
	writemem wOtherTrainerClass
	setval LANCE
	writemem wOtherTrainerID
	special OverridePlayerParty
    sjump .ChooseEnemyCharacter
.LanceEnemy:
	writethistext
		text "Play against"
		line "Champion Lance?"
		done
	yesorno
	iffalse .ChooseEnemyCharacter
	loadtrainer CHAMPION, LANCE
	sjump .StartBattle

.GreenPlayer:
	writethistext
		text "Play using <PKMN>"
		line "Trainer Green's"
		cont "team?"
		done
	yesorno
	iffalse .ChoosePlayerCharacter
	setval GREEN
	writemem wOtherTrainerClass
	setval GREEN1
	writemem wOtherTrainerID
	special OverridePlayerParty
    sjump .ChooseEnemyCharacter
.GreenEnemy:
	writethistext
		text "Play against <PKMN>"
		line "Trainer Green?"
		done
	yesorno
	iffalse .ChooseEnemyCharacter
	loadtrainer GREEN, GREEN1
	sjump .StartBattle

.BluePlayer:
	writethistext
		text "Play using <PKMN>"
		line "Trainer Blue's"
		cont "team?"
		done
	yesorno
	iffalse .ChoosePlayerCharacter
	setval BLUE
	writemem wOtherTrainerClass
	setval BLUE1
	writemem wOtherTrainerID
	special OverridePlayerParty
    sjump .ChooseEnemyCharacter
.BlueEnemy:
	writethistext
		text "Play against <PKMN>"
		line "Trainer Blue?"
		done
	yesorno
	iffalse .ChooseEnemyCharacter
	loadtrainer BLUE, BLUE1
	sjump .StartBattle

.RedPlayer:
	writethistext
		text "Play using <PKMN>"
		line "Trainer Red's"
		cont "team?"
		done
	yesorno
	iffalse .ChoosePlayerCharacter
	setval RED
	writemem wOtherTrainerClass
	setval RED1
	writemem wOtherTrainerID
	special OverridePlayerParty
    sjump .ChooseEnemyCharacter
.RedEnemy:
	writethistext
		text "Play against <PKMN>"
		line "Trainer Red?"
		done
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
	db STATICMENU_CURSOR | STATICMENU_WRAP ; flags
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
	db "KO@"
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

BattleArenaPackFull:
	setevent EVENT_DID_NOT_GET_BATTLE_ARENA_PRIZE
	writetext BattlePlazasFullPackText
	waitendtext

AreYouSureText:
	text "Cancel your"
	line "challenge?"
	done

DraftArenaNoteSignText:
	text "You may battle us-"
	line "ing your own or"
	cont "other trainer's"
	cont "#mon team."

	para "Each victory will"
	line "net you a Crystal."
	done
