MACRO add_stdscript
\1StdScript::
	dba \1
ENDM

StdScripts::
	add_stdscript DifficultBookshelfScript
	add_stdscript PictureBookshelfScript
	add_stdscript MagazineBookshelfScript
	add_stdscript Radio1Script
	add_stdscript Radio2Script
	add_stdscript NoBerryOrFruitScript
	add_stdscript PokecenterSignScript
	add_stdscript MartSignScript
	add_stdscript SmashRockScript
	add_stdscript ChanseyPokeCenterScript
	add_stdscript PokecenterNurseScript
	add_stdscript ChanseyHealsOWScript
	add_stdscript VariableMartScript
	add_stdscript PorygonPCScript
	add_stdscript TeamRocketOathScript
	add_stdscript IncenseBurnerScript
	add_stdscript MerchandiseShelfScript
	add_stdscript TownMapScript
	add_stdscript WindowScript
	add_stdscript TVScript
	add_stdscript TrashCanScript
	add_stdscript StrengthBoulderScript
	add_stdscript GoldenrodRocketsScript
	add_stdscript RadioTowerRocketsScript
	add_stdscript ElevatorButtonScript
	add_stdscript DayToTextScript
	add_stdscript BugContestResultsWarpScript
	add_stdscript BugContestResultsScript
	add_stdscript AskNumberMScript
	add_stdscript RegisteredNumberMScript
	add_stdscript NumberAcceptedMScript
	add_stdscript NumberDeclinedMScript
	add_stdscript RematchMScript
	add_stdscript GiftMScript
	add_stdscript PackFullMScript
	add_stdscript AskNumberFScript
	add_stdscript RegisteredNumberFScript
	add_stdscript NumberAcceptedFScript
	add_stdscript NumberDeclinedFScript
	add_stdscript RematchFScript
	add_stdscript GiftFScript
	add_stdscript PackFullFScript
	add_stdscript RematchGiftFScript
	add_stdscript GymStatue1Script
	add_stdscript GymStatue2Script
	add_stdscript ReceiveItemScript
	add_stdscript ReceiveTogepiEggScript
	add_stdscript PCScript
	add_stdscript GameCornerCoinVendorScript
	add_stdscript HappinessCheckScript
	add_stdscript MysteryGiftCarrieScript
	add_stdscript WanderingOddEggNPCScript
	add_stdscript BerryOrFruitScript

VariableMartScript:
	opentext
	readvar VAR_BADGES
	ifgreater 7, .EightBadgesMart
	ifgreater 6, .SevenBadgesMart
	ifgreater 4, .FiveBadgesMart
	ifgreater 2, .ThreeBadgesMart
	ifgreater 0, .OneBadgeMart
	pokemart MARTTYPE_STANDARD, MART_NO_BADGES
	endtext

.OneBadgeMart:
	pokemart MARTTYPE_STANDARD, MART_ONE_BADGE
	endtext
.ThreeBadgesMart:
	pokemart MARTTYPE_STANDARD, MART_THREE_BADGES
	endtext
.FiveBadgesMart:
	pokemart MARTTYPE_STANDARD, MART_FIVE_BADGES
	endtext
.SevenBadgesMart:
	pokemart MARTTYPE_STANDARD, MART_SEVEN_BADGES
	endtext
.EightBadgesMart:
	pokemart MARTTYPE_STANDARD, MART_EIGHT_BADGES
	endtext

BerryOrFruitScript:
	opentext
	getitemname STRING_BUFFER_3, USE_SCRIPT_VAR
	farwritetext _FruitBearingTreeText
	promptbutton
	farwritetext _HeyItsFruitText
	verbosegiveitem ITEM_FROM_MEM
	iffalse_endtext
	disappear LAST_TALKED
	endtext

NoBerryOrFruitScript:
	opentext
	farwritetext _FruitBearingTreeText
	promptbutton
	farwritetext _NothingHereText
	waitendtext

WanderingOddEggNPCScript:
	faceplayer
	opentext
	checkevent EVENT_MET_OTIS
	iftrue .WeMetAgain
	farwritetext OtisIntroText
	setevent EVENT_MET_OTIS
	sjump .WouldYouLikeAnEgg

.WeMetAgain:
	farwritetext OtisWeMetAgainText
.WouldYouLikeAnEgg:
	special DisplayCoinCaseBalance
	yesorno
	iffalse .Refused
	checkcoins 7777
	ifequal HAVE_LESS, .NotEnoughCoins

	readvar VAR_PARTYCOUNT
	ifequal PARTY_LENGTH, .PartyFull

	special DisplayCoinCaseBalance
	special GiveOddEgg
	farwritetext OtisGaveARareEggText
	playsound SFX_CAUGHT_MON
	waitsfx
	promptbutton

	takecoins 7777
	waitsfx
	playsound SFX_TRANSACTION
	special DisplayCoinCaseBalance

	farwritetext OtisThanksText
	waitbutton
	closetext
	end

.Refused:
	farwritetext RefusedOtisText
	waitbutton
	closetext
	end

.NotEnoughCoins:
    farwritetext OtisNotEnoughCoinsText
	waitbutton
	closetext
	end

.PartyFull:
	farwritetext OtisPartyFullText
	waitbutton
	closetext
	end

MysteryGiftCarrieScript:
	callasm MysteryGiftNPC
	verbosegiveitem ITEM_FROM_MEM
	end

ChanseyPokeCenterScript:
	faceplayer
	reanchormap
	pokepic CHANSEY
	cry CHANSEY
	waitsfx
	closepokepic
	refreshmap
	opentext
	farwritetext ChanseyCryText
	pause 20
	closetext
	end

ChanseyHealsOWScript:
	scall ChanseyPokeCenterScript
	special FadeOutPalettes
	special LoadMapPalettes
	playsound SFX_FULL_HEAL
	special HealParty
	special FadeInPalettes_EnableDynNoApply
	end

PokecenterNurseScript:
; EVENT_WELCOMED_TO_POKECOM_CENTER is never set

	opentext
	isquicknurseset
	iffalse .QuickNurse
	checktime MORN
	iftrue .morn
	checktime DAY
	iftrue .day
	checktime EVE
	iftrue .eve
	checktime NITE
	iftrue .nite
	sjump .ok

.morn
	checkevent EVENT_WELCOMED_TO_POKECOM_CENTER
	iftrue .morn_comcenter
	farwritetext NurseMornText
	promptbutton
	sjump .ok
.morn_comcenter
	farwritetext PokeComNurseMornText
	promptbutton
	sjump .ok

.day
	checkevent EVENT_WELCOMED_TO_POKECOM_CENTER
	iftrue .day_comcenter
	farwritetext NurseDayText
	promptbutton
	sjump .ok
.day_comcenter
	farwritetext PokeComNurseDayText
	promptbutton
	sjump .ok

.eve
	checkevent EVENT_WELCOMED_TO_POKECOM_CENTER
	iftrue .eve_comcenter
	farwritetext NurseEveText
	promptbutton
	sjump .ok
.eve_comcenter
	farwritetext PokeComNurseEveText
	promptbutton
	sjump .ok

.nite
	checkevent EVENT_WELCOMED_TO_POKECOM_CENTER
	iftrue .nite_comcenter
	farwritetext NurseNiteText
	promptbutton
	sjump .ok
.nite_comcenter
	farwritetext PokeComNurseNiteText
	promptbutton
	sjump .ok

.ok
	; only do this once
	clearevent EVENT_WELCOMED_TO_POKECOM_CENTER

	farwritetext NurseAskHealText
	yesorno
	iffalse .done
.QuickNurse
	farwritetext NurseTakePokemonText
	pause 20
	turnobject LAST_TALKED, LEFT
	pause 10
	special HealParty
	special SaveMusic
	playmusic MUSIC_NONE
	setval HEALMACHINE_POKECENTER
	special HealMachineAnim
	pause 10
	special RestoreMusic
	turnobject LAST_TALKED, DOWN
	pause 10

	checkphonecall ; elm already called about pokerus
	iftrue .no
	checkflag ENGINE_CAUGHT_POKERUS
	iftrue .no
	special CheckPokerus
	iftrue .pokerus
.no
	isquicknurseset
	iffalse .done

	farwritetext NurseReturnPokemonText
	pause 20

.done
	farwritetext NurseGoodbyeText

	turnobject LAST_TALKED, UP
	pause 10
	turnobject LAST_TALKED, DOWN
	pause 10

	waitbutton
	closetext
	end

.pokerus
	; already cleared earlier in the script
	checkevent EVENT_WELCOMED_TO_POKECOM_CENTER
	iftrue .pokerus_comcenter
	farwritetext NursePokerusText
	waitbutton
	closetext
	sjump .pokerus_done

.pokerus_comcenter
	farwritetext PokeComNursePokerusText
	waitbutton
	closetext

.pokerus_done
	setflag ENGINE_CAUGHT_POKERUS
	specialphonecall SPECIALCALL_POKERUS
	end

DifficultBookshelfScript:
	farjumptext DifficultBookshelfText

PictureBookshelfScript:
	farjumptext PictureBookshelfText

MagazineBookshelfScript:
	farjumptext MagazineBookshelfText

TeamRocketOathScript:
	farjumptext TeamRocketOathText

IncenseBurnerScript:
	farjumptext IncenseBurnerText

MerchandiseShelfScript:
	farjumptext MerchandiseShelfText

TownMapScript:
	opentext
	farwritetext LookTownMapText
	waitbutton
	special OverworldTownMap
	closetext
	end

WindowScript:
	farjumptext WindowText

TVScript:
	opentext
	farwritetext TVText
	waitbutton
	closetext
	end

Radio1Script:
	opentext
	setval MAPRADIO_POKEMON_CHANNEL
	special MapRadio
	closetext
	end

Radio2Script:
; Lucky Channel
	opentext
	setval MAPRADIO_LUCKY_CHANNEL
	special MapRadio
	closetext
	end

TrashCanScript:
	farjumptext TrashCanText

PorygonPCScript:
	faceplayer
	reanchormap
	pokepic PORYGON
	cry PORYGON
	waitsfx
	closepokepic
	refreshmap
	; fallthrough

PCScript:
	opentext
	special PokemonCenterPC
	closetext
	end

ElevatorButtonScript:
	playsound SFX_READ_TEXT_2
	pause 15
	playsound SFX_ELEVATOR_END
	end

StrengthBoulderScript:
	farsjump AskStrengthScript

SmashRockScript:
	farsjump AskRockSmashScript

PokecenterSignScript:
	farjumptext PokecenterSignText

MartSignScript:
	farjumptext MartSignText

DayToTextScript:
	readvar VAR_WEEKDAY
	ifequal MONDAY, .Monday
	ifequal TUESDAY, .Tuesday
	ifequal WEDNESDAY, .Wednesday
	ifequal THURSDAY, .Thursday
	ifequal FRIDAY, .Friday
	ifequal SATURDAY, .Saturday
	getstring STRING_BUFFER_3, .SundayText
	end
.Monday:
	getstring STRING_BUFFER_3, .MondayText
	end
.Tuesday:
	getstring STRING_BUFFER_3, .TuesdayText
	end
.Wednesday:
	getstring STRING_BUFFER_3, .WednesdayText
	end
.Thursday:
	getstring STRING_BUFFER_3, .ThursdayText
	end
.Friday:
	getstring STRING_BUFFER_3, .FridayText
	end
.Saturday:
	getstring STRING_BUFFER_3, .SaturdayText
	end
.SundayText:
	db "Sunday@"
.MondayText:
	db "Monday@"
.TuesdayText:
	db "Tuesday@"
.WednesdayText:
	db "Wednesday@"
.ThursdayText:
	db "Thursday@"
.FridayText:
	db "Friday@"
.SaturdayText:
	db "Saturday@"

GoldenrodRocketsScript:
	clearevent EVENT_GOLDENROD_CITY_ROCKET_TAKEOVER
	end

RadioTowerRocketsScript:
	setflag ENGINE_ROCKETS_IN_RADIO_TOWER
	setevent EVENT_GOLDENROD_CITY_CIVILIANS
	setevent EVENT_RADIO_TOWER_BLACKBELT_BLOCKS_STAIRS
	clearevent EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	clearevent EVENT_USED_THE_CARD_KEY_IN_THE_RADIO_TOWER
	specialphonecall SPECIALCALL_WEIRDBROADCAST
	end

BugContestResultsWarpScript:
	special ClearBGPalettes
	scall BugContestResults_CopyContestantsToResults
	setevent EVENT_ROUTE_8_NATIONAL_PARK_GATE_OFFICER_CONTEST_DAY
	clearevent EVENT_ROUTE_8_NATIONAL_PARK_GATE_OFFICER_NOT_CONTEST_DAY
	setevent EVENT_WARPED_FROM_ROUTE_7_NATIONAL_PARK_GATE
	warp ROUTE_8_NATIONAL_PARK_GATE, 0, 4
	applymovement PLAYER, Movement_ContestResults_WalkAfterWarp

BugContestResultsScript:
	clearflag ENGINE_BUG_CONTEST_TIMER
	clearevent EVENT_WARPED_FROM_ROUTE_7_NATIONAL_PARK_GATE
	clearevent EVENT_CONTEST_OFFICER_HAS_SUN_STONE
	clearevent EVENT_CONTEST_OFFICER_HAS_MOON_STONE
	clearevent EVENT_CONTEST_OFFICER_HAS_GOLD_BERRY
	clearevent EVENT_CONTEST_OFFICER_HAS_BERRY
	opentext
	farwritetext ContestResults_ReadyToJudgeText
	waitbutton
	special BugContestJudging
	getnum STRING_BUFFER_3
	ifequal 1, BugContestResults_FirstPlace
	ifequal 2, BugContestResults_SecondPlace
	ifequal 3, BugContestResults_ThirdPlace
	farwritetext ContestResults_ConsolationPrizeText
	promptbutton
	waitsfx
	verbosegiveitem BERRY
	iffalse BugContestResults_NoRoomForBerry

BugContestResults_DidNotWin:
	farwritetext ContestResults_DidNotWinText
	promptbutton
	sjump BugContestResults_FinishUp

BugContestResults_ReturnAfterWinnersPrize:
	farwritetext ContestResults_JoinUsNextTimeText
	promptbutton

BugContestResults_FinishUp:
	checkevent EVENT_LEFT_MONS_WITH_CONTEST_OFFICER
	iffalse BugContestResults_DidNotLeaveMons
	farwritetext ContestResults_ReturnPartyText
	waitbutton
	special ContestReturnMons
BugContestResults_DidNotLeaveMons:
	special CheckPartyFullAfterContest
	ifequal BUGCONTEST_CAUGHT_MON, BugContestResults_CleanUp
	ifequal BUGCONTEST_NO_CATCH, BugContestResults_CleanUp
	; BUGCONTEST_BOXED_MON
	farwritetext ContestResults_PartyFullText
	waitbutton
BugContestResults_CleanUp:
	closetext
	setscene SCENE_ROUTE8NATIONALPARKGATE_NOOP
	setmapscene ROUTE_7_NATIONAL_PARK_GATE, SCENE_ROUTE7NATIONALPARKGATE_NOOP
	setevent EVENT_BUG_CATCHING_CONTESTANT_1A
	setevent EVENT_BUG_CATCHING_CONTESTANT_2A
	setevent EVENT_BUG_CATCHING_CONTESTANT_3A
	setevent EVENT_BUG_CATCHING_CONTESTANT_4A
	setevent EVENT_BUG_CATCHING_CONTESTANT_5A
	setevent EVENT_BUG_CATCHING_CONTESTANT_6A
	setevent EVENT_BUG_CATCHING_CONTESTANT_7A
	setevent EVENT_BUG_CATCHING_CONTESTANT_8A
	setevent EVENT_BUG_CATCHING_CONTESTANT_9A
	setevent EVENT_BUG_CATCHING_CONTESTANT_10A
	setevent EVENT_BUG_CATCHING_CONTESTANT_1B
	setevent EVENT_BUG_CATCHING_CONTESTANT_2B
	setevent EVENT_BUG_CATCHING_CONTESTANT_3B
	setevent EVENT_BUG_CATCHING_CONTESTANT_4B
	setevent EVENT_BUG_CATCHING_CONTESTANT_5B
	setevent EVENT_BUG_CATCHING_CONTESTANT_6B
	setevent EVENT_BUG_CATCHING_CONTESTANT_7B
	setevent EVENT_BUG_CATCHING_CONTESTANT_8B
	setevent EVENT_BUG_CATCHING_CONTESTANT_9B
	setevent EVENT_BUG_CATCHING_CONTESTANT_10B
	setflag ENGINE_DAILY_BUG_CONTEST
	special PlayMapMusic
	end

BugContestResults_FirstPlace:
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	getitemname STRING_BUFFER_4, SUN_STONE
	farwritetext ContestResults_PlayerWonAPrizeText
	waitbutton
	verbosegiveitem SUN_STONE
	iffalse BugContestResults_NoRoomForSunStone
	sjump BugContestResults_ReturnAfterWinnersPrize

BugContestResults_SecondPlace:
	getitemname STRING_BUFFER_4, MOON_STONE
	farwritetext ContestResults_PlayerWonAPrizeText
	waitbutton
	verbosegiveitem MOON_STONE
	iffalse BugContestResults_NoRoomForMoonstone
	sjump BugContestResults_ReturnAfterWinnersPrize

BugContestResults_ThirdPlace:
	getitemname STRING_BUFFER_4, GOLD_BERRY
	farwritetext ContestResults_PlayerWonAPrizeText
	waitbutton
	verbosegiveitem GOLD_BERRY
	iffalse BugContestResults_NoRoomForGoldBerry
	sjump BugContestResults_ReturnAfterWinnersPrize

BugContestResults_NoRoomForSunStone:
	farwritetext BugContestPrizeNoRoomText
	promptbutton
	setevent EVENT_CONTEST_OFFICER_HAS_SUN_STONE
	sjump BugContestResults_ReturnAfterWinnersPrize

BugContestResults_NoRoomForMoonstone:
	farwritetext BugContestPrizeNoRoomText
	promptbutton
	setevent EVENT_CONTEST_OFFICER_HAS_MOON_STONE
	sjump BugContestResults_ReturnAfterWinnersPrize

BugContestResults_NoRoomForGoldBerry:
	farwritetext BugContestPrizeNoRoomText
	promptbutton
	setevent EVENT_CONTEST_OFFICER_HAS_GOLD_BERRY
	sjump BugContestResults_ReturnAfterWinnersPrize

BugContestResults_NoRoomForBerry:
	farwritetext BugContestPrizeNoRoomText
	promptbutton
	setevent EVENT_CONTEST_OFFICER_HAS_BERRY
	sjump BugContestResults_DidNotWin

BugContestResults_CopyContestantsToResults:
	checkevent EVENT_BUG_CATCHING_CONTESTANT_1A
	iftrue .skip1
	clearevent EVENT_BUG_CATCHING_CONTESTANT_1B
.skip1
	checkevent EVENT_BUG_CATCHING_CONTESTANT_2A
	iftrue .skip2
	clearevent EVENT_BUG_CATCHING_CONTESTANT_2B
.skip2
	checkevent EVENT_BUG_CATCHING_CONTESTANT_3A
	iftrue .skip3
	clearevent EVENT_BUG_CATCHING_CONTESTANT_3B
.skip3
	checkevent EVENT_BUG_CATCHING_CONTESTANT_4A
	iftrue .skip4
	clearevent EVENT_BUG_CATCHING_CONTESTANT_4B
.skip4
	checkevent EVENT_BUG_CATCHING_CONTESTANT_5A
	iftrue .skip5
	clearevent EVENT_BUG_CATCHING_CONTESTANT_5B
.skip5
	checkevent EVENT_BUG_CATCHING_CONTESTANT_6A
	iftrue .skip6
	clearevent EVENT_BUG_CATCHING_CONTESTANT_6B
.skip6
	checkevent EVENT_BUG_CATCHING_CONTESTANT_7A
	iftrue .skip7
	clearevent EVENT_BUG_CATCHING_CONTESTANT_7B
.skip7
	checkevent EVENT_BUG_CATCHING_CONTESTANT_8A
	iftrue .skip8
	clearevent EVENT_BUG_CATCHING_CONTESTANT_8B
.skip8
	checkevent EVENT_BUG_CATCHING_CONTESTANT_9A
	iftrue .skip9
	clearevent EVENT_BUG_CATCHING_CONTESTANT_9B
.skip9
	checkevent EVENT_BUG_CATCHING_CONTESTANT_10A
	iftrue .skip10
	clearevent EVENT_BUG_CATCHING_CONTESTANT_10B
.skip10
	end

AskNumberMScript:
	readvar VAR_CALLERID
	ifequal PHONE_SCHOOLBOY_JACK, .Jack
	ifequal PHONE_SAILOR_HUEY, .Huey
	ifequal PHONE_COOLTRAINERM_GAVEN, .Gaven
	ifequal PHONE_BIRDKEEPER_JOSE, .Jose
	ifequal PHONE_BUG_CATCHER_WADE, .Wade
	ifequal PHONE_HIKER_ANTHONY, .Anthony
	ifequal PHONE_CAMPER_TODD, .Todd
	ifequal PHONE_BUG_CATCHER_ARNIE, .Arnie
	ifequal PHONE_SCHOOLBOY_ALAN, .Alan
	ifequal PHONE_SCHOOLBOY_CHAD, .Chad
	ifequal PHONE_POKEFANM_DEREK, .Derek
	ifequal PHONE_FISHER_TULLY, .Tully
	ifequal PHONE_POKEMANIAC_BRENT, .Brent
	ifequal PHONE_BIRDKEEPER_VANCE, .Vance
	ifequal PHONE_FISHER_WILTON, .Wilton
	ifequal PHONE_HIKER_PARRY, .Parry

.Jack:
	farwritetext JackAskNumberText
	end
.Huey:
	farwritetext HueyAskNumberText
	end
.Gaven:
	farwritetext GavenAskNumberText
	end
.Jose:
	farwritetext JoseAskNumberText
	end
.Wade:
	farwritetext WadeAskNumberText
	end
.Anthony:
	farwritetext AnthonyAskNumberText
	end
.Todd:
	farwritetext ToddAskNumberText
	end
.Arnie:
	farwritetext ArnieAskNumberText
	end
.Alan:
	farwritetext AlanAskNumberText
	end
.Chad:
	farwritetext ChadAskNumberText
	end
.Derek:
	farwritetext DerekAskNumberText
	end
.Tully:
	farwritetext TullyAskNumberText
	end
.Brent:
	farwritetext BrentAskNumberText
	end
.Vance:
	farwritetext VanceAskNumberText
	end
.Wilton:
	farwritetext WiltonAskNumber1Text
	end

.Parry:
	farwritetext ParryAskNumberText
	end

RegisteredNumberMScript:
	farwritetext RegisteredNumber1Text
	playsound SFX_REGISTER_PHONE_NUMBER
	waitsfx
	promptbutton
	end

NumberAcceptedMScript:
	readvar VAR_CALLERID
	ifequal PHONE_SCHOOLBOY_JACK, .Jack
	ifequal PHONE_SAILOR_HUEY, .Huey
	ifequal PHONE_COOLTRAINERM_GAVEN, .Gaven
	ifequal PHONE_BIRDKEEPER_JOSE, .Jose
	ifequal PHONE_BUG_CATCHER_WADE, .Wade
	ifequal PHONE_HIKER_ANTHONY, .Anthony
	ifequal PHONE_CAMPER_TODD, .Todd
	ifequal PHONE_BUG_CATCHER_ARNIE, .Arnie
	ifequal PHONE_SCHOOLBOY_ALAN, .Alan
	ifequal PHONE_SCHOOLBOY_CHAD, .Chad
	ifequal PHONE_POKEFANM_DEREK, .Derek
	ifequal PHONE_FISHER_TULLY, .Tully
	ifequal PHONE_POKEMANIAC_BRENT, .Brent
	ifequal PHONE_BIRDKEEPER_VANCE, .Vance
	ifequal PHONE_FISHER_WILTON, .Wilton
	ifequal PHONE_HIKER_PARRY, .Parry

.Jack:
	farwritetext JackNumberAcceptedText
	waitbutton
	closetext
	end
.Huey:
	farwritetext HueyNumberAcceptedText
	waitbutton
	closetext
	end
.Gaven:
	farwritetext GavenNumberAcceptedText
	waitbutton
	closetext
	end
.Jose:
	farwritetext JoseNumberAcceptedText
	waitbutton
	closetext
	end
.Wade:
	farwritetext WadeNumberAcceptedText
	waitbutton
	end
.Anthony:
	farwritetext AnthonyNumberAcceptedText
	waitbutton
	closetext
	end
.Todd:
	farwritetext ToddNumberAcceptedText
	waitbutton
	closetext
	end
.Arnie:
	farwritetext ArnieNumberAcceptedText
	waitbutton
	closetext
	end
.Alan:
	farwritetext AlanNumberAcceptedText
	waitbutton
	end
.Chad:
	farwritetext ChadNumberAcceptedText
	waitbutton
	closetext
	end
.Derek:
	farwritetext DerekNumberAcceptedText
	waitbutton
	closetext
	end
.Tully:
	farwritetext TullyNumberAcceptedText
	waitbutton
	closetext
	end
.Brent:
	farwritetext BrentNumberAcceptedText
	waitbutton
	closetext
	end
.Vance:
	farwritetext VanceNumberAcceptedText
	waitbutton
	closetext
	end
.Wilton:
	farwritetext WiltonNumberAcceptedText
	waitbutton
	closetext
	end
.Parry:
	farwritetext ParryNumberAcceptedText
	waitbutton
	closetext
	end

NumberDeclinedMScript:
	readvar VAR_CALLERID
	ifequal PHONE_SCHOOLBOY_JACK, .Jack
	ifequal PHONE_SAILOR_HUEY, .Huey
	ifequal PHONE_COOLTRAINERM_GAVEN, .Gaven
	ifequal PHONE_BIRDKEEPER_JOSE, .Jose
	ifequal PHONE_BUG_CATCHER_WADE, .Wade
	ifequal PHONE_HIKER_ANTHONY, .Anthony
	ifequal PHONE_CAMPER_TODD, .Todd
	ifequal PHONE_BUG_CATCHER_ARNIE, .Arnie
	ifequal PHONE_SCHOOLBOY_ALAN, .Alan
	ifequal PHONE_SCHOOLBOY_CHAD, .Chad
	ifequal PHONE_POKEFANM_DEREK, .Derek
	ifequal PHONE_FISHER_TULLY, .Tully
	ifequal PHONE_POKEMANIAC_BRENT, .Brent
	ifequal PHONE_BIRDKEEPER_VANCE, .Vance
	ifequal PHONE_FISHER_WILTON, .Wilton
	ifequal PHONE_HIKER_PARRY, .Parry

.Jack:
	farwritetext JackNumberDeclinedText
	waitbutton
	closetext
	end
.Huey:
	farwritetext HueyNumberDeclinedText
	waitbutton
	closetext
	end
.Gaven:
	farwritetext GavenNumberDeclinedText
	waitbutton
	closetext
	end
.Jose:
	farwritetext JoseNumberDeclinedText
	waitbutton
	closetext
	end
.Wade:
	farwritetext WadeNumberDeclinedText
	waitbutton
	end
.Anthony:
	farwritetext AnthonyNumberDeclinedText
	waitbutton
	closetext
	end
.Todd:
	farwritetext ToddNumberDeclinedText
	waitbutton
	closetext
	end
.Arnie:
	farwritetext ArnieNumberDeclinedText
	waitbutton
	closetext
	end
.Alan:
	farwritetext AlanNumberDeclinedText
	waitbutton
	end
.Chad:
	farwritetext ChadNumberDeclinedText
	waitbutton
	closetext
	end
.Derek:
	farwritetext DerekNumberDeclinedText
	waitbutton
	closetext
	end
.Tully:
	farwritetext TullyNumberDeclinedText
	waitbutton
	closetext
	end
.Brent:
	farwritetext BrentNumberDeclinedText
	waitbutton
	closetext
	end
.Vance:
	farwritetext VanceNumberDeclinedText
	waitbutton
	closetext
	end
.Wilton:
	farwritetext WiltonNumberDeclinedText
	waitbutton
	closetext
	end
.Parry:
	farwritetext ParryNumberDeclinedText
	waitbutton
	closetext
	end

RematchMScript:
	readvar VAR_CALLERID
	ifequal PHONE_SCHOOLBOY_JACK, .Jack
	ifequal PHONE_SAILOR_HUEY, .Huey
	ifequal PHONE_COOLTRAINERM_GAVEN, .Gaven
	ifequal PHONE_BIRDKEEPER_JOSE, .Jose
	ifequal PHONE_HIKER_ANTHONY, .Anthony
	ifequal PHONE_CAMPER_TODD, .Todd
	ifequal PHONE_BUG_CATCHER_ARNIE, .Arnie
	ifequal PHONE_SCHOOLBOY_CHAD, .Chad
	ifequal PHONE_FISHER_TULLY, .Tully
	ifequal PHONE_POKEMANIAC_BRENT, .Brent
	ifequal PHONE_BIRDKEEPER_VANCE, .Vance
	ifequal PHONE_FISHER_WILTON, .Wilton
	ifequal PHONE_HIKER_PARRY, .Parry

.Jack:
	farwritetext JackRematchText
	waitbutton
	closetext
	end
.Huey:
	farwritetext HueyRematchText
	waitbutton
	closetext
	end
.Gaven:
	farwritetext GavenRematchText
	waitbutton
	closetext
	end
.Jose:
	farwritetext JoseRematchText
	waitbutton
	closetext
	end
.Anthony:
	farwritetext AnthonyRematchText
	waitbutton
	closetext
	end
.Todd:
	farwritetext ToddRematchText
	waitbutton
	closetext
	end
.Arnie:
	farwritetext ArnieRematchText
	waitbutton
	closetext
	end
.Chad:
	farwritetext ChadRematchText
	waitbutton
	closetext
	end
.Tully:
	farwritetext TullyRematchText
	waitbutton
	closetext
	end
.Brent:
	farwritetext BrentRematchText
	waitbutton
	closetext
	end
.Vance:
	farwritetext VanceRematchText
	waitbutton
	closetext
	end
.Wilton:
	farwritetext WiltonRematchText
	waitbutton
	closetext
	end
.Parry:
	farwritetext ParryRematchText
	waitbutton
	closetext
	end

GiftMScript:
	readvar VAR_CALLERID
	ifequal PHONE_BIRDKEEPER_JOSE, .Jose
	ifequal PHONE_BUG_CATCHER_WADE, .Wade
	ifequal PHONE_SCHOOLBOY_ALAN, .Alan
	ifequal PHONE_POKEFANM_DEREK, .Derek
	ifequal PHONE_FISHER_TULLY, .Tully
	ifequal PHONE_FISHER_WILTON, .Wilton

.Jose:
	farwritetext JoseGiftText
	promptbutton
	end
.Wade:
	farwritetext WadeGiftText
	promptbutton
	end
.Alan:
	farwritetext AlanGiftText
	promptbutton
	end
.Derek:
	farwritetext DerekGiftText
	promptbutton
	end
.Tully:
	farwritetext TullyGiftText
	promptbutton
	end
.Wilton:
	farwritetext WiltonGiftText
	promptbutton
	end

PackFullMScript:
	readvar VAR_CALLERID
	ifequal PHONE_SCHOOLBOY_JACK, .Jack
	ifequal PHONE_SAILOR_HUEY, .Huey
	ifequal PHONE_COOLTRAINERM_GAVEN, .Gaven
	ifequal PHONE_BIRDKEEPER_JOSE, .Jose
	ifequal PHONE_HIKER_ANTHONY, .Anthony
	ifequal PHONE_CAMPER_TODD, .Todd
	ifequal PHONE_BUG_CATCHER_ARNIE, .Arnie
	ifequal PHONE_SCHOOLBOY_CHAD, .Chad
	ifequal PHONE_POKEFANM_DEREK, .Derek
	ifequal PHONE_FISHER_TULLY, .Tully
	ifequal PHONE_POKEMANIAC_BRENT, .Brent
	ifequal PHONE_BIRDKEEPER_VANCE, .Vance
	ifequal PHONE_FISHER_WILTON, .Wilton
	ifequal PHONE_HIKER_PARRY, .Parry

.Jack:
	farwritetext JackPackFullText
	waitbutton
	closetext
	end

.Huey:
	farwritetext HueyPackFullText
	waitbutton
	closetext
	end

.Gaven
	farwritetext GavenPackFullText
	waitbutton
	closetext
	end

.Jose:
	farwritetext JosePackFullText
	waitbutton
	closetext
	end
.Anthony
	farwritetext AnthonyPackFullText
	waitbutton
	closetext
	end

.Todd
	farwritetext ToddPackFullText
	waitbutton
	closetext
	end

.Arnie
	farwritetext ArniePackFullText
	waitbutton
	closetext
	end

.Chad
	farwritetext AlanPackFullText
	waitbutton
	closetext
	end

.Derek:
	farwritetext ChadPackFullText
	waitbutton
	closetext
	end
.Tully:
	farwritetext TullyPackFullText
	waitbutton
	closetext
	end

.Brent
	farwritetext BrentPackFullText
	waitbutton
	closetext
	end

.Vance:
	farwritetext VancePackFullText
	waitbutton
	closetext
	end
.Wilton:
	farwritetext WiltonPackFullText
	waitbutton
	closetext
	end
.Parry:
	farwritetext ParryPackFullText
	waitbutton
	closetext
	end

AskNumberFScript:
	readvar VAR_CALLERID
	ifequal PHONE_POKEFAN_BEVERLY, .Beverly
	ifequal PHONE_COOLTRAINERF_BETH, .Beth
	ifequal PHONE_COOLTRAINERF_REENA, .Reena
	ifequal PHONE_PICNICKER_LIZ, .Liz
	ifequal PHONE_PICNICKER_GINA, .Gina
	ifequal PHONE_LASS_DANA, .Dana
	ifequal PHONE_PICNICKER_TIFFANY, .Tiffany
	ifequal PHONE_PICNICKER_ERIN, .Erin

.Beverly:
	farwritetext BeverlyAskNumberText
	end
.Beth:
	farwritetext BethAskNumberText
	end
.Reena:
	farwritetext ReenaAskNumberText
	end
.Liz:
	farwritetext LizAskNumberText
	end
.Gina:
	farwritetext GinaAskNumberText
	end
.Dana:
	farwritetext DanaAskNumberText
	end
.Tiffany:
	farwritetext TiffanyAskNumberText
	end
.Erin:
	farwritetext ErinAskNumberText
	end

RegisteredNumberFScript:
	farwritetext RegisteredNumber2Text
	playsound SFX_REGISTER_PHONE_NUMBER
	waitsfx
	promptbutton
	end

NumberAcceptedFScript:
	readvar VAR_CALLERID
	ifequal PHONE_POKEFAN_BEVERLY, .Beverly
	ifequal PHONE_COOLTRAINERF_BETH, .Beth
	ifequal PHONE_COOLTRAINERF_REENA, .Reena
	ifequal PHONE_PICNICKER_LIZ, .Liz
	ifequal PHONE_PICNICKER_GINA, .Gina
	ifequal PHONE_LASS_DANA, .Dana
	ifequal PHONE_PICNICKER_TIFFANY, .Tiffany
	ifequal PHONE_PICNICKER_ERIN, .Erin

.Beverly:
	farwritetext BeverlyNumberAcceptedText
	waitbutton
	closetext
	end
.Beth:
	farwritetext BethNumberAcceptedText
	waitbutton
	closetext
	end
.Reena:
	farwritetext ReenaNumberAcceptedText
	waitbutton
	closetext
	end
.Liz:
	farwritetext LizNumberAcceptedText
	waitbutton
	closetext
	end
.Gina:
	farwritetext GinaNumberAcceptedText
	waitbutton
	closetext
	end
.Dana:
	farwritetext DanaNumberAcceptedText
	waitbutton
	closetext
	end
.Tiffany:
	farwritetext TiffanyNumberAcceptedText
	waitbutton
	closetext
	end
.Erin:
	farwritetext ErinNumberAcceptedText
	waitbutton
	closetext
	end

NumberDeclinedFScript:
	readvar VAR_CALLERID
	ifequal PHONE_POKEFAN_BEVERLY, .Beverly
	ifequal PHONE_COOLTRAINERF_BETH, .Beth
	ifequal PHONE_COOLTRAINERF_REENA, .Reena
	ifequal PHONE_PICNICKER_LIZ, .Liz
	ifequal PHONE_PICNICKER_GINA, .Gina
	ifequal PHONE_LASS_DANA, .Dana
	ifequal PHONE_PICNICKER_TIFFANY, .Tiffany
	ifequal PHONE_PICNICKER_ERIN, .Erin

.Beverly:
	farwritetext BeverlyNumberDeclinedText
	waitbutton
	closetext
	end
.Beth:
	farwritetext BethNumberDeclinedText
	waitbutton
	closetext
	end
.Reena:
	farwritetext ReenaNumberDeclinedText
	waitbutton
	closetext
	end
.Liz:
	farwritetext LizNumberDeclinedText
	waitbutton
	closetext
	end
.Gina:
	farwritetext GinaNumberDeclinedText
	waitbutton
	closetext
	end
.Dana:
	farwritetext DanaNumberDeclinedText
	waitbutton
	closetext
	end
.Tiffany:
	farwritetext TiffanyNumberDeclinedText
	waitbutton
	closetext
	end
.Erin:
	farwritetext ErinNumberDeclinedText
	waitbutton
	closetext
	end

RematchFScript:
	readvar VAR_CALLERID
	ifequal PHONE_COOLTRAINERF_BETH, .Beth
	ifequal PHONE_COOLTRAINERF_REENA, .Reena
	ifequal PHONE_PICNICKER_LIZ, .Liz
	ifequal PHONE_PICNICKER_GINA, .Gina
	ifequal PHONE_LASS_DANA, .Dana
	ifequal PHONE_PICNICKER_TIFFANY, .Tiffany
	ifequal PHONE_PICNICKER_ERIN, .Erin

.Beth:
	farwritetext BethRematchText
	waitbutton
	closetext
	end
.Reena:
	farwritetext ReenaRematchText
	waitbutton
	closetext
	end
.Liz:
	farwritetext LizRematchText
	waitbutton
	closetext
	end
.Gina:
	farwritetext GinaRematchText
	waitbutton
	closetext
	end
.Dana:
	farwritetext DanaRematchText
	waitbutton
	closetext
	end
.Tiffany:
	farwritetext TiffanyRematchText
	waitbutton
	closetext
	end
.Erin:
	farwritetext ErinRematchText
	waitbutton
	closetext
	end

GiftFScript:
	readvar VAR_CALLERID
	ifequal PHONE_POKEFAN_BEVERLY, .Beverly
	ifequal PHONE_PICNICKER_GINA, .Gina
	ifequal PHONE_LASS_DANA, .Dana
	ifequal PHONE_PICNICKER_TIFFANY, .Tiffany

.Beverly:
	farwritetext BeverlyGiftText
	promptbutton
	end
.Gina:
	farwritetext GinaGiftText
	promptbutton
	end
.Dana:
	farwritetext DanaGiftText
	promptbutton
	end
.Tiffany:
	farwritetext TiffanyGiftText
	promptbutton
	end

PackFullFScript:
	readvar VAR_CALLERID
	ifequal PHONE_POKEFAN_BEVERLY, .Beverly
	ifequal PHONE_COOLTRAINERF_BETH, .Beth
	ifequal PHONE_COOLTRAINERF_REENA, .Reena
	ifequal PHONE_PICNICKER_LIZ, .Liz
	ifequal PHONE_PICNICKER_GINA, .Gina
	ifequal PHONE_LASS_DANA, .Dana
	ifequal PHONE_PICNICKER_TIFFANY, .Tiffany
	ifequal PHONE_PICNICKER_ERIN, .Erin

.Beverly:
	farwritetext BeverlyPackFullText
	waitbutton
	closetext
	end

.Beth
	farwritetext BethPackFullText
	waitbutton
	closetext
	end

.Reena
	farwritetext ReenaPackFullText
	waitbutton
	closetext
	end

.Liz
	farwritetext LizPackFullText
	waitbutton
	closetext
	end

.Gina:
	farwritetext GinaPackFullText
	waitbutton
	closetext
	end
.Dana:
	farwritetext DanaPackFullText
	waitbutton
	closetext
	end
.Tiffany:
	farwritetext TiffanyPackFullText
	waitbutton
	closetext
	end
.Erin:
	farwritetext ErinPackFullText
	waitbutton
	closetext
	end

RematchGiftFScript:
	readvar VAR_CALLERID
	ifequal PHONE_PICNICKER_ERIN, .Erin

.Erin:
	opentext
	farwritetext ErinRematchGiftText
	promptbutton
	end

GymStatue1Script:
	getcurlandmarkname STRING_BUFFER_3
	opentext
	farwritetext GymStatue_CityGymText
	waitbutton
	closetext
	end

GymStatue2Script:
	getcurlandmarkname STRING_BUFFER_3
	opentext
	farwritetext GymStatue_CityGymText
	promptbutton
	farwritetext GymStatue_WinningTrainersText
	waitbutton
	closetext
	end

ReceiveItemScript:
	waitsfx
	farwritetext ReceivedItemText
	playsound SFX_ITEM
	waitsfx
	end

ReceiveTogepiEggScript:
	waitsfx
	farwritetext ReceivedItemText
	playsound SFX_GET_EGG
	waitsfx
	end

GameCornerCoinVendorScript:
	faceplayer
	opentext
	farwritetext CoinVendor_WelcomeText
	promptbutton
	checkitem COIN_CASE
	iftrue CoinVendor_IntroScript
	farwritetext CoinVendor_NoCoinCaseText
	waitbutton
	closetext
	end

CoinVendor_IntroScript:
	farwritetext CoinVendor_IntroText

.loop
	special DisplayMoneyAndCoinBalance
	loadmenu .MenuHeader
	verticalmenu
	closewindow
	ifequal 1, .Buy50
	sjump .Cancel

.Buy50:
	checkcoins MAX_COINS - 10
	ifequal HAVE_MORE, .CoinCaseFull
	checkmoney YOUR_MONEY, 10000
	ifequal HAVE_LESS, .NotEnoughMoney
	givecoins 10
	takemoney YOUR_MONEY, 10000
	waitsfx
	playsound SFX_TRANSACTION
	farwritetext CoinVendor_Buy50CoinsText
	waitbutton
	sjump .loop

.NotEnoughMoney:
	farwritetext CoinVendor_NotEnoughMoneyText
	waitbutton
	closetext
	end

.CoinCaseFull:
	farwritetext CoinVendor_CoinCaseFullText
	waitbutton
	closetext
	end

.Cancel:
	farwritetext CoinVendor_CancelText
	waitbutton
	closetext
	end

.MenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 0, 4, 15, TEXTBOX_Y - 1
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR | STATICMENU_WRAP ; flags
	db 2 ; items
	db " 10 : ¥10000@"
	db "Cancel@"

HappinessCheckScript:
	faceplayer
	opentext
	special GetFirstPokemonHappiness
	ifless 50, .Unhappy
	ifless 150, .KindaHappy
	farwritetext HappinessText3
	waitbutton
	closetext
	end

.KindaHappy:
	farwritetext HappinessText2
	waitbutton
	closetext
	end

.Unhappy:
	farwritetext HappinessText1
	waitbutton
	closetext
	end

Movement_ContestResults_WalkAfterWarp:
	step RIGHT
	step DOWN
	turn_head UP
	step_end
