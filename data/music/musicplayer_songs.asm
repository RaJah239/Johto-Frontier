SECTION "MusicPlayer Songs", ROMX

MusicPlayerSongs::
	; Reorder this list to change the Music Player track order. TODOTEXT
	; The song count in front is derived from the list itself.
	db .SongsEnd - .SongsStart
.SongsStart
	db MUSIC_TITLE, MUSIC_CRYSTAL_OPENING
	db MUSIC_MAIN_MENU, MUSIC_SHOW_ME_AROUND, MUSIC_BICYCLE
	db MUSIC_SURF
	db MUSIC_ROUTE_29, MUSIC_ROUTE_30, MUSIC_ROUTE_36, MUSIC_ROUTE_37
	db MUSIC_NEW_BARK_TOWN, MUSIC_CHERRYGROVE_CITY, MUSIC_VIOLET_CITY, MUSIC_AZALEA_TOWN
	db MUSIC_GOLDENROD_CITY, MUSIC_ECRUTEAK_CITY
	db MUSIC_LAKE_OF_RAGE, MUSIC_BATTLE_TOWER_THEME, MUSIC_BATTLE_TOWER_LOBBY, MUSIC_DARK_CAVE
	db MUSIC_UNION_CAVE, MUSIC_NATIONAL_PARK, MUSIC_RUINS_OF_ALPH_INTERIOR, MUSIC_TIN_TOWER
	db MUSIC_SPROUT_TOWER, MUSIC_BURNED_TOWER, MUSIC_DANCING_HALL, MUSIC_LIGHTHOUSE
	db MUSIC_ROCKET_HIDEOUT, MUSIC_DRAGONS_DEN, MUSIC_BUG_CATCHING_CONTEST_RANKING, MUSIC_BUG_CATCHING_CONTEST
	db MUSIC_GAME_CORNER, MUSIC_GYM, MUSIC_POKEMON_CENTER
	db MUSIC_MAGNET_TRAIN
	db MUSIC_ROUTE_3
	db MUSIC_ROUTE_26
	db MUSIC_VIRIDIAN_CITY, MUSIC_VERMILION_CITY
	db MUSIC_CELADON_CITY
	db MUSIC_MT_MOON, MUSIC_MT_MOON_SQUARE
	db MUSIC_VICTORY_ROAD, MUSIC_INDIGO_PLATEAU, MUSIC_HALL_OF_FAME
	db MUSIC_PROF_OAK, MUSIC_PROF_ELM, MUSIC_MOM, MUSIC_CLAIR
	db MUSIC_ROCKET_OVERTURE, MUSIC_BUENAS_PASSWORD, MUSIC_HIKER_ENCOUNTER, MUSIC_LASS_ENCOUNTER
	db MUSIC_OFFICER_ENCOUNTER, MUSIC_KIMONO_ENCOUNTER, MUSIC_YOUNGSTER_ENCOUNTER, MUSIC_BEAUTY_ENCOUNTER
	db MUSIC_POKEMANIAC_ENCOUNTER, MUSIC_SAGE_ENCOUNTER, MUSIC_MYSTICALMAN_ENCOUNTER, MUSIC_ROCKET_ENCOUNTER
	db MUSIC_ROCKET_BATTLE, MUSIC_RIVAL_BATTLE
	db MUSIC_JOHTO_TRAINER_BATTLE
	db MUSIC_TRAINER_VICTORY, MUSIC_JOHTO_GYM_LEADER_BATTLE, MUSIC_KANTO_GYM_LEADER_BATTLE, MUSIC_GYM_VICTORY
	db MUSIC_CHAMPION_BATTLE, MUSIC_KANTO_WILD_BATTLE, MUSIC_JOHTO_WILD_BATTLE
	db MUSIC_SUICUNE_BATTLE
	db MUSIC_WILD_VICTORY, MUSIC_POKEMON_TALK, MUSIC_POKEMON_CHANNEL, MUSIC_POKE_FLUTE_CHANNEL
	db MUSIC_RUINS_OF_ALPH_RADIO, MUSIC_POKEMON_LULLABY, MUSIC_POKEMON_MARCH, MUSIC_LAKE_OF_RAGE_ROCKET_RADIO
	db MUSIC_CAPTURE, MUSIC_EVOLUTION, MUSIC_HEAL
	db MUSIC_CREDITS, MUSIC_POST_CREDITS
	; JTest originals
	db MUSIC_FINAL_BATTLE, MUSIC_MAXIE_ARCHIE_BATTLE, MUSIC_GYM_LEADER_BATTLE, MUSIC_HOENN_RIVAL_BATTLE
	db MUSIC_UNOVA_ELITE_FOUR_BATTLE, MUSIC_CAVE_OF_ORIGIN, MUSIC_SCARLET, MUSIC_SURFING_PIKACHU
	db MUSIC_SCARLET_FINAL_THEME, MUSIC_ZINNIA_BATTLE_THEME
.SongsEnd
	db -1

MusicPlayerSongNamePointers::
	; One far pointer per MUSIC_* constant (see constants/music_constants.asm),
	; in that file's order.
	table_width 3
	dba .None               ; MUSIC_NONE
	dba .Title              ; MUSIC_TITLE
	dba .Route3             ; MUSIC_ROUTE_3
	dba .MagnetTrain        ; MUSIC_MAGNET_TRAIN
	dba .KantoGymBattle     ; MUSIC_KANTO_GYM_LEADER_BATTLE
	dba .KantoWildBattle    ; MUSIC_KANTO_WILD_BATTLE
	dba .PokemonCenter      ; MUSIC_POKEMON_CENTER
	dba .HikerEncounter     ; MUSIC_HIKER_ENCOUNTER
	dba .LassEncounter      ; MUSIC_LASS_ENCOUNTER
	dba .OfficerEncounter   ; MUSIC_OFFICER_ENCOUNTER
	dba .HealPokemon        ; MUSIC_HEAL
	dba .MtMoon             ; MUSIC_MT_MOON
	dba .ShowMeAround       ; MUSIC_SHOW_ME_AROUND
	dba .GameCorner         ; MUSIC_GAME_CORNER
	dba .Bicycle            ; MUSIC_BICYCLE
	dba .HallOfFame         ; MUSIC_HALL_OF_FAME
	dba .ViridianCity       ; MUSIC_VIRIDIAN_CITY
	dba .CeladonCity        ; MUSIC_CELADON_CITY
	dba .TrainerVictory     ; MUSIC_TRAINER_VICTORY
	dba .WildVictory        ; MUSIC_WILD_VICTORY
	dba .GymVictory         ; MUSIC_GYM_VICTORY
	dba .MtMoonSquare       ; MUSIC_MT_MOON_SQUARE
	dba .Gym                ; MUSIC_GYM
	dba .OaksPokemonTalk    ; MUSIC_POKEMON_TALK
	dba .ProfOak            ; MUSIC_PROF_OAK
	dba .Surf               ; MUSIC_SURF
	dba .Evolution          ; MUSIC_EVOLUTION
	dba .NationalPark       ; MUSIC_NATIONAL_PARK
	dba .Credits            ; MUSIC_CREDITS
	dba .AzaleaTown         ; MUSIC_AZALEA_TOWN
	dba .CherrygroveCity    ; MUSIC_CHERRYGROVE_CITY
	dba .KimonoEncounter    ; MUSIC_KIMONO_ENCOUNTER
	dba .UnionCave          ; MUSIC_UNION_CAVE
	dba .JohtoWildBattle    ; MUSIC_JOHTO_WILD_BATTLE
	dba .JohtoTrainerBattle ; MUSIC_JOHTO_TRAINER_BATTLE
	dba .Route30            ; MUSIC_ROUTE_30
	dba .EcruteakCity       ; MUSIC_ECRUTEAK_CITY
	dba .VioletCity         ; MUSIC_VIOLET_CITY
	dba .JohtoGymBattle     ; MUSIC_JOHTO_GYM_LEADER_BATTLE
	dba .ChampionBattle     ; MUSIC_CHAMPION_BATTLE
	dba .RivalBattle        ; MUSIC_RIVAL_BATTLE
	dba .RocketBattle       ; MUSIC_ROCKET_BATTLE
	dba .ElmsLab            ; MUSIC_PROF_ELM
	dba .DarkCave           ; MUSIC_DARK_CAVE
	dba .Route29            ; MUSIC_ROUTE_29
	dba .Route36            ; MUSIC_ROUTE_36
	dba .YoungsterEncounter ; MUSIC_YOUNGSTER_ENCOUNTER
	dba .BeautyEncounter    ; MUSIC_BEAUTY_ENCOUNTER
	dba .RocketEncounter    ; MUSIC_ROCKET_ENCOUNTER
	dba .PokemaniacEncounter; MUSIC_POKEMANIAC_ENCOUNTER
	dba .SageEncounter      ; MUSIC_SAGE_ENCOUNTER
	dba .NewBarkTown        ; MUSIC_NEW_BARK_TOWN
	dba .GoldenrodCity      ; MUSIC_GOLDENROD_CITY
	dba .VermilionCity      ; MUSIC_VERMILION_CITY
	dba .PokemonChannel     ; MUSIC_POKEMON_CHANNEL
	dba .PokeFluteChannel   ; MUSIC_POKE_FLUTE_CHANNEL
	dba .TinTower           ; MUSIC_TIN_TOWER
	dba .SproutTower        ; MUSIC_SPROUT_TOWER
	dba .BurnedTower        ; MUSIC_BURNED_TOWER
	dba .Lighthouse         ; MUSIC_LIGHTHOUSE
	dba .LakeOfRage         ; MUSIC_LAKE_OF_RAGE
	dba .IndigoPlateau      ; MUSIC_INDIGO_PLATEAU
	dba .Route37            ; MUSIC_ROUTE_37
	dba .RocketHideout      ; MUSIC_ROCKET_HIDEOUT
	dba .DragonsDen         ; MUSIC_DRAGONS_DEN
	dba .RuinsOfAlphRadio   ; MUSIC_RUINS_OF_ALPH_RADIO
	dba .SuccessfulCapture  ; MUSIC_CAPTURE
	dba .Route26            ; MUSIC_ROUTE_26
	dba .Mom                ; MUSIC_MOM
	dba .VictoryRoad        ; MUSIC_VICTORY_ROAD
	dba .PokemonLullaby     ; MUSIC_POKEMON_LULLABY
	dba .PokemonMarch       ; MUSIC_POKEMON_MARCH
	dba .MainMenu           ; MUSIC_MAIN_MENU
	dba .RuinsOfAlphInterior; MUSIC_RUINS_OF_ALPH_INTERIOR
	dba .RocketOverture     ; MUSIC_ROCKET_OVERTURE
	dba .DancingHall        ; MUSIC_DANCING_HALL
	dba .BugContestRanking  ; MUSIC_BUG_CATCHING_CONTEST_RANKING
	dba .BugContest         ; MUSIC_BUG_CATCHING_CONTEST
	dba .RocketRadio        ; MUSIC_LAKE_OF_RAGE_ROCKET_RADIO
	dba .PostCredits        ; MUSIC_POST_CREDITS
	dba .Clair              ; MUSIC_CLAIR
	dba .BuenasPassword     ; MUSIC_BUENAS_PASSWORD
	dba .MysticalmanEncounter ; MUSIC_MYSTICALMAN_ENCOUNTER
	dba .CrystalOpening     ; MUSIC_CRYSTAL_OPENING
	dba .BattleTowerTheme   ; MUSIC_BATTLE_TOWER_THEME
	dba .SuicuneBattle      ; MUSIC_SUICUNE_BATTLE
	dba .BattleTowerLobby   ; MUSIC_BATTLE_TOWER_LOBBY
	dba .FinalBattle        ; MUSIC_FINAL_BATTLE
	dba .MaxieArchieBattle  ; MUSIC_MAXIE_ARCHIE_BATTLE
	dba .GymLeaderBattle    ; MUSIC_GYM_LEADER_BATTLE
	dba .HoennRivalBattle   ; MUSIC_HOENN_RIVAL_BATTLE
	dba .UnovaEliteFourBattle ; MUSIC_UNOVA_ELITE_FOUR_BATTLE
	dba .CaveOfOrigin       ; MUSIC_CAVE_OF_ORIGIN
	dba .Scarlet            ; MUSIC_SCARLET
	dba .SurfingPikachu     ; MUSIC_SURFING_PIKACHU
	dba .ScarletFinale      ; MUSIC_SCARLET_FINAL_THEME
	dba .ZinniaBattle       ; MUSIC_ZINNIA_BATTLE_THEME

	assert_table_length NUM_MUSIC_SONGS

.None:                db "       None@"
.Title:               db "       Title@"
.Route3:              db "     Route 3@"
.MagnetTrain:         db "   Magnet Train@"
.KantoGymBattle:      db " Kanto Gym Battle@"
.KantoWildBattle:     db "    Kanto Wild@"
.PokemonCenter:       db "  #mon Center@"
.HikerEncounter:      db "  Hiker Encounter@"
.LassEncounter:       db "  Lass Encounter@"
.OfficerEncounter:    db " Officer Encounter@"
.HealPokemon:         db "   Heal Pokemon@"
.MtMoon:              db "     Mt. Moon@"
.ShowMeAround:        db "  Show Me Around@"
.GameCorner:          db "    Game Corner@"
.Bicycle:             db "   Johto Bicycle@"
.HallOfFame:          db "   Hall of Fame@"
.ViridianCity:        db "   Viridian City@"
.CeladonCity:         db "   Celadon City@"
.TrainerVictory:      db "  Trainer Victory@"
.WildVictory:         db "   Wild Victory@"
.GymVictory:          db "   Gym Victory@"
.MtMoonSquare:        db "  Mt. Moon Square@"
.Gym:                 db "        Gym@"
.OaksPokemonTalk:     db "     Oak's Talk@"
.ProfOak:             db "     Prof. Oak@"
.Surf:                db "    Johto Surf@"
.Evolution:           db "     Evolution@"
.NationalPark:        db "   National Park@"
.Credits:             db "      Credits@"
.AzaleaTown:          db "    Azalea Town@"
.CherrygroveCity:     db " Cherrygrove City@"
.KimonoEncounter:     db " Kimono Encounter@"
.UnionCave:           db "    Union Cave@"
.JohtoWildBattle:     db "    Johto Wild@"
.JohtoTrainerBattle:  db "   Johto Trainer@"
.Route30:             db "     Route 30@"
.EcruteakCity:        db "   Ecruteak City@"
.VioletCity:          db "    Violet City@"
.JohtoGymBattle:      db " Johto Gym Battle@"
.ChampionBattle:      db "  Champion Battle@"
.RivalBattle:         db "   Rival Battle@"
.RocketBattle:        db "   Rocket Battle@"
.ElmsLab:             db "     Elm's Lab@"
.DarkCave:            db "     Dark Cave@"
.Route29:             db "     Route 29@"
.Route36:             db "     Route 36@"
.YoungsterEncounter:  db "  Youngster Enc.@"
.BeautyEncounter:     db " Beauty Encounter@"
.RocketEncounter:     db " Rocket Encounter@"
.PokemaniacEncounter: db "  #maniac Enc.@"
.SageEncounter:       db "  Sage Encounter@"
.NewBarkTown:         db "   New Bark Town@"
.GoldenrodCity:       db "  Goldenrod City@"
.VermilionCity:       db "  Vermilion City@"
.PokemonChannel:      db "  #mon Channel@"
.PokeFluteChannel:    db "    # Flute@"
.TinTower:            db "     Tin Tower@"
.SproutTower:         db "   Sprout Tower@"
.BurnedTower:         db "   Burned Tower@"
.Lighthouse:          db "    Lighthouse@"
.LakeOfRage:          db "   Lake of Rage@"
.IndigoPlateau:       db "  Indigo Plateau@"
.Route37:             db "     Route 37@"
.RocketHideout:       db "  Rocket Hideout@"
.DragonsDen:          db "    Dragon's Den@"
.RuinsOfAlphRadio:    db "    Alph Radio@"
.SuccessfulCapture:   db "  Caught #mon!@"
.Route26:             db "     Route 26@"
.Mom:                 db "        Mom@"
.VictoryRoad:         db "   Victory Road@"
.PokemonLullaby:      db "  #mon Lullaby@"
.PokemonMarch:        db "   #mon March@"
.MainMenu:            db "     Main Menu@"
.RuinsOfAlphInterior: db "   Alph Interior@"
.RocketOverture:      db "  Rocket Overture@"
.DancingHall:         db "   Dancing Hall@"
.BugContestRanking:   db "   Bug Contest 1@"
.BugContest:          db "   Bug Contest 2@"
.RocketRadio:         db "   Rocket Radio@"
.PostCredits:         db "   Post Credits@"
.Clair:               db "       Clair@"
.BuenasPassword:      db "  Buena's Password@"
.MysticalmanEncounter: db " Mystical Man@"
.CrystalOpening:      db "  Crystal Opening@"
.BattleTowerTheme:    db "   Battle Tower@"
.SuicuneBattle:       db "  Suicune Battle@"
.BattleTowerLobby:    db "    Tower Lobby@"
.FinalBattle:         db "   Final Battle@"
.MaxieArchieBattle:   db " Maxie & Archie@"
.GymLeaderBattle:     db "Gym Leader Battle@"
.HoennRivalBattle:    db "  Hoenn Rival@"
.UnovaEliteFourBattle: db "  Unova Elite 4@"
.CaveOfOrigin:        db "  Cave of Origin@"
.Scarlet:             db "     Scarlet@"
.SurfingPikachu:      db " Surfing Pikachu@"
.ScarletFinale:       db "  Scarlet Finale@"
.ZinniaBattle:        db "  Zinnia Battle@"
