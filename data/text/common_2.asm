_NameRaterHelloText::
	text "Hello, hello! I'm"
	line "the Name Rater."

	para "I rate the names"
	line "of #mon."

	para "Would you like me"
	line "to rate names?"
	done

_TeamGainedExpText::
	text "Remaining team got"
	line "Exp via Exp.Share!"
	prompt

_NameRaterWhichMonText::
	text "Which #mon's"
	line "nickname should I"
	cont "rate for you?"
	prompt

_NameRaterBetterNameText::
	text "Hm… @"
	text_ram wStringBuffer1
	text "…"
	line "That's a fairly"
	cont "decent name."

	para "But, how about a"
	line "slightly better"
	cont "nickname?"

	para "Want me to give it"
	line "a better name?"
	done

_NameRaterWhatNameText::
	text "All right. What"
	line "name should we"
	cont "give it, then?"
	prompt

_NameRaterFinishedText::
	text "That's a better"
	line "name than before!"

	para "Well done!"
	prompt

_NameRaterComeAgainText::
	text "OK, then. Come"
	line "again sometime."
	done

_NameRaterEggText::
	text "Whoa… That's just"
	line "an Egg."
	prompt

_NameRaterSameNameText::
	text "It might look the"
	line "same as before,"

	para "but this new name"
	line "is much better!"

	para "Well done!"
	prompt

_NameRaterNamedText::
	text "All right. This"
	line "#mon is now"
	cont "named @"
	text_ram wStringBuffer1
	text "."
	prompt

Text_Gained::
	text_ram wStringBuffer1
	text " gained@"
	text_end

_BoostedExpPointsText::
	text_start
	line "a boosted"
	cont "@"
	text_decimal wStringBuffer2, 2, 5
	text " Exp. Points!"
	prompt

_ExpPointsText::
	text_start
	line "@"
	text_decimal wStringBuffer2, 2, 5
	text " Exp. Points!"
	prompt

_GoMonText::
	text "Go! @"
	text_end

_DoItMonText::
	text "Do it! @"
	text_end

_GoForItMonText::
	text "Go for it,"
	line "@"
	text_end

_YourFoesWeakGetmMonText::
	text "Your foe's weak!"
	line "Get'm, @"
	text_end

_BattleMonNicknameText::
	text_ram wBattleMonNickname
	text "!"
	done

_BattleMonNickCommaText::
	text_ram wBattleMonNickname
	text ",@"
	text_end

_ThatsEnoughComeBackText::
	text " that's"
	line "enough! Come back!@"
	text_end

_OKComeBackText::
	text " OK!"
	line "Come back!@"
	text_end

_GoodComeBackText::
	text " good!"
	line "Come back!@"
	text_end

_ComeBackText::
	text " come"
	line "back!"
	done

_ContainedMoveText::
	text "Teach @"
	text_ram wStringBuffer2
	text_start
	line "to a #mon?"
	done

_TMHMNotCompatibleText::
	text_ram wStringBuffer2
	text " is"
	line "not compatible"
	cont "with @"
	text_ram wStringBuffer1
	text "."

	para "It can't learn"
	line "@"
	text_ram wStringBuffer2
	text "."
	prompt

_NoRoomTMHMText::
	text "You have no room"
	line "for any more"
	cont "@"
	text_ram wStringBuffer1
	text "S."
	prompt

_ReceivedTMHMText::
	text "You received"
	line "@"
	text_ram wStringBuffer1
	text "!"
	prompt

_MysteryGiftCanceledText::
	text "The link has been"
	line "cancelled."
	prompt

_MysteryGiftCommErrorText::
	text "Communication"
	line "error."
	prompt

_RetrieveMysteryGiftText::
	text "Must retrieve Gift"
	line "at #mon Center."
	prompt

_YourFriendIsNotReadyText::
	text "Your friend isn't"
	line "ready."
	prompt

_MysteryGiftFiveADayText::
	text "Sorry--only five"
	line "Gifts a day."
	prompt

_MysteryGiftOneADayText::
	text "Sorry. One Gift"
	line "a day per person."
	prompt

_MysteryGiftSentText::
	text_ram wMysteryGiftPartnerName
	text " sent"
	line "@"
	text_ram wStringBuffer1
	text "."
	prompt

_MysteryGiftSentHomeText::
	text_ram wMysteryGiftPartnerName
	text " sent"
	line "@"
	text_ram wStringBuffer1
	text_start
	cont "to @"
	text_ram wMysteryGiftPlayerName
	text "'s home."
	prompt

_NameCardReceivedCardText::
	text "Received"
	line "@"
	text_ram wMysteryGiftCardHolderName
	text "'s Card."
	prompt

_NameCardListedCardText::
	text_ram wMysteryGiftCardHolderName
	text "'s Card was"
	line "listed as no.@"
	text_decimal wTextDecimalByte, 1, 2
	text "."
	prompt

_NameCardNotRegisteredCardText::
	text "The Card was not"
	line "registered."
	prompt

_NameCardLinkCancelledText::
	text "The link has been"
	line "cancelled."
	prompt

_NameCardLinkCommErrorText::
	text "Communication"
	line "error."
	prompt

_BadgeRequiredText::
	text "Sorry! A new Badge"
	line "is required."
	prompt

_CantUseItemText::
	text "Can't use that"
	line "here."
	prompt

_UseCutText::
	text "Scyther appeared"
	line "and cut!"
	prompt

_CutNothingText::
	text "There's nothing to"
	line "Cut here."
	prompt

_MareepLit::
	text "Mareep lit the"
	line "path ahead!@"
	text_promptbutton
	text_end

_UsedSurfText::
	text "Started traversing"
	line "the water."
	done

_CantSurfText::
	text "You can't use this"
	line "here."
	prompt

_AlreadySurfingText::
	text "You're already"
	line "traversing water!"
	prompt

_AskSurfText::
	text "The water is calm."
	line  "Call Lanturn?"
	done

_AskPikaSurfText::
	text "Want to traverse"
	line "the calm water?"
	done

_UseWaterfallText::
	text "Ascending the"
	line "waterfall!"
	done

_HugeWaterfallText::
	text "Wow, it's a huge"
	line "waterfall."
	done

_AskWaterfallText::
	text "Wow, it's a huge"
	line "waterfall."

	para "Call Milotic?"
	done

_UseDigText::
	text_ram wStringBuffer2
	text " used"
	line "Dig!"
	done

_UseEscapeRopeText::
	text "<PLAYER> used an"
	line "Escape Rope."
	done

_CantUseDigText::
	text "Can't use that"
	line "here."
	done

_TeleportReturnText::
	text "Return to the last"
	line "#mon Center."
	done

_CantUseTeleportText::
	text "Can't use that"
	line "here."

	para ""
	done

_UseStrengthText::
	text "Donphan used its"
	line "strength!"
	done

_MoveBoulderText::
	text "Boulders can now"
	line "be moved!"
	prompt

_AskStrengthText::
	text "This can be moved."
	line "Call Donphan?"
	done

_BouldersMoveText::
	text "Boulders may now"
	line "be moved!"
	done

_BouldersMayMoveText::
	text "An item is needed"
	line "to push this."
	done

_UseWhirlpoolText::
	text "Crossing…"
	prompt

_MayPassWhirlpoolText::
	text "It's a vicious"
	line "Whirlpool!"
	done

_AskWhirlpoolText::
	text "A Whirlpool is in"
	line "the way."

	para "Call Kingdra?"
	done

_UseHeadbuttText::
	text_ram wStringBuffer2
	text " did a"
	line "Headbutt!"
	prompt

_AskHeadbuttText::
	text "A #mon could be"
	line "in this tree."

	para "Want to Headbutt"
	line "it?"
	done

_UseRockSmashText::
	text_ram wStringBuffer2
	text " used"
	line "Brick Break!"
	prompt

_MaySmashText::
	text "Maybe a #mon"
	line "can break this."
	done

_AskRockSmashText::
	text "This rock looks"
	line "breakable."

	para "Want to use Brick"
	line "Break?"
	done

_RodBiteText::
	text "Oh!"
	line "A bite!"
	prompt

_RodNothingText::
	text "Not even a nibble!"
	prompt

_UnusedNothingHereText::
	text "Looks like there's"
	line "nothing here."
	prompt

_CantGetOffBikeText::
	text "You can't get off"
	line "here!"
	done

_GotOnBikeText::
	text "<PLAYER> got on the"
	line "@"
	text_ram wStringBuffer2
	text "."
	done

_GotOffBikeText::
	text "<PLAYER> got off"
	line "the @"
	text_ram wStringBuffer2
	text "."
	done

_AskCutText::
	text "This tree can be"
	line "Cut!"

	para "Want to call"
	line "Scyther?"
	done

_SycterUsedCutText::
	text "Scyther used Cut!"
	done

_CanCutText::
	text "This tree can be"
	line "Cut!"
	done

_FoundItemText::
	text "<PLAYER> found"
	line "@"
	text_ram wStringBuffer3
	text "!"
	done

_CantCarryItemText::
	text "But <PLAYER> can't"
	line "carry any more"
	cont "items."
	done

_WhitedOutText::
	text "<PLAYER> is out of"
	line "useable #mon!"

	para "<PLAYER> whited"
	line "out!"
	done

_WhitedOutToWildMonText::
	text "<PLAYER> is out of"
	line "useable #mon!"

	para "<PLAYER> panicked"
	line "and dropped"
	cont "¥@"
	text_decimal hMoneyTemp, 3, 6
	text "…"

	para "<……><……><……>"
	line "<……><……><……>"

	para "<PLAYER> whited"
	line "out!"
	done

_WhitedOutToTrainerText::
	text "<PLAYER> is out of"
	line "useable #mon!"

	para "<PLAYER> paid"
	line "¥@"
	text_decimal hMoneyTemp, 3, 6
	text " to the"
	cont "winner…"

	para "<……><……><……>"
	line "<……><……><……>"

	para "<PLAYER> whited"
	line "out!"
	done

_ItemfinderItemNearbyText::
	text "Yes! Item Finder"
	line "indicates there's"
	cont "an item nearby."
	prompt

_ItemfinderNopeText::
	text "Nope! Item Finder"
	line "isn't responding."
	prompt

_PoisonFaintText::
	text_ram wStringBuffer3
	text_start
	line "survived the"
	cont "poisoning!"
	prompt

_UseSweetScentText::
	text "Tangela sends out"
	line "a viney lure!"
	done

_SweetScentNothingText::
	text "Looks like there's"
	line "nothing here…"
	done

_SquirtbottleNothingText::
	text "<PLAYER> sprinkled"
	line "water."

	para "But nothing"
	line "happened…"
	done

_UseSacredAshText::
	text "<PLAYER>'s #mon"
	line "were all healed!"
	done

_AnEggCantHoldAnItemText::
	text "An Egg can't hold"
	line "an item."
	prompt

_AskThrowAwayText::
	text "Throw away how"
	line "many?"
	done

_AskQuantityThrowAwayText::
	text "Throw away @"
	text_decimal wItemQuantityChange, 1, 2
	text_start
	line "@"
	text_ram wStringBuffer2
	text "(S)?"
	done

_ThrewAwayText::
	text "Threw away"
	line "@"
	text_ram wStringBuffer2
	text "(S)."
	prompt

_OakThisIsntTheTimeText::
	text "Neither the time"
	line "nor place…"
	prompt

_YouDontHaveAMonText::
	text "You don't have a"
	line "#mon!"
	prompt

_RegisteredItemText::
	text "Registered the"
	line "@"
	text_ram wStringBuffer2
	text "."
	prompt

_CantRegisterText::
	text "You can't register"
	line "that item."
	prompt

_AskItemMoveText::
	text "Where should this"
	line "be moved to?"
	done

_PackEmptyText::
	text_start
	done

_YouCantUseItInABattleText::
	text "You can't use it"
	line "in a battle."
	prompt

_AreYouABoyOrAreYouAGirlText::
	text "Are you a boy?"
	line "Or are you a girl?"
	done

Text_BattleEffectActivate::
	text "<USER>'s"
	line "@"
	text_ram wStringBuffer2
	text_end

_BattleStatWentWayUpText::
	text " soared!"
	prompt

_BattleStatWentUpText::
	text " went up!"
	prompt

Text_BattleFoeEffectActivate::
	text "<TARGET>'s"
	line "@"
	text_ram wStringBuffer2
	text_end

_BattleStatSharplyFellText::
	text_pause
	text "<SCROLL>sharply fell!"
	prompt

_BattleStatFellText::
	text " fell!"
	prompt

Text_BattleUser::
	text "<USER>@"
	text_end

_BattleTookSunlightText::
	text_start
	line "took in sunlight!"
	prompt

_BattleFlewText::
	text_start
	line "flew up high!"
	prompt

_BattleDugText::
	text_start
	line "dug a hole!"
	prompt

_ActorNameText::
	text "<USER>@"
	text_end

_UsedMoveText::
	text_start
	line "used @"
	text_end

_MoveNameText::
	text_ram wStringBuffer2
	text "!"
	done

Text_BreedHuh::
	text "Huh?"

	para "@"
	text_end

_BreedClearboxText::
	text_start
	done

_BreedEggHatchText::
	text_ram wStringBuffer1
	text " came"
	line "out of its Egg!@"
	sound_caught_mon
	text_promptbutton
	text_end

_BreedAskNicknameText::
	text "Give a nickname to"
	line "@"
	text_ram wStringBuffer1
	text "?"
	done

	text "It's @"
	text_ram wBreedMon2Nickname
	text_start
	line "that was left with"
	cont "the Day-Care Lady."
	done

_LeftWithDayCareManText::
	text "It's my @"
	text_ram wBreedMon1Nickname
	text "."
	done

_LeftWithDayCareLadyText::
	text "It's my @"
	text_ram wBreedMon2Nickname
	text "."
	done

_BreedNoInterestText::
	text "Both #mon are"
	line "incompatible."
	prompt

_BreedShowsInterestText::
	text "Both #mon are"
	line "compatible."
	prompt

_EmptyMailboxText::
	text "There's no Mail"
	line "here."
	prompt

_MailClearedPutAwayText::
	text "The cleared Mail"
	line "was put away."
	prompt

_MailPackFullText::
	text "The Bag is full."
	prompt

_MailMessageLostText::
	text "The Mail's message"
	line "will be lost. OK?"
	done

_MailAlreadyHoldingItemText::
	text "It's already hold-"
	line "ing an item."
	prompt

_MailEggText::
	text "An Egg can't hold"
	line "any Mail."
	prompt

_MailMovedFromBoxText::
	text "The Mail was moved"
	line "from the Mailbox."
	prompt

_WasSentToBillsPCText::
	text_ram wStringBuffer1
	text " was"
	line "sent to Bill's PC."
	prompt

_PCGottaHavePokemonText::
	text "You gotta have"
	line "#mon to call!"
	prompt

_PCMonHoldingMailText::
	text "There is a #mon"
	line "holding Mail."

	para "Please remove the"
	line "Mail."
	prompt

_ContestCaughtMonText::
	text "Caught @"
	text_ram wStringBuffer1
	text "!"
	prompt

_ContestAskSwitchText::
	text "Switch #mon?"
	done

_ContestAlreadyCaughtText::
	text "You already caught"
	line "a @"
	text_ram wStringBuffer1
	text "."
	prompt

_ContestJudging_FirstPlaceText::
	text "This Bug-Catching"
	line "Contest winner is@"
	text_pause
	text "…"

	para "@"
	text_ram wBugContestWinnerName
	text ","
	line "who caught a"
	cont "@"
	text_ram wStringBuffer1
	text "!@"
	text_end

_ContestJudging_FirstPlaceScoreText::
	text_start

	para "The winning score"
	line "was @"
	text_decimal wBugContestFirstPlaceScore, 2, 3
	text " points!"
	prompt

_ContestJudging_SecondPlaceText::
	text "Placing second was"
	line "@"
	text_ram wBugContestWinnerName
	text ","

	para "who caught a"
	line "@"
	text_ram wStringBuffer1
	text "!@"
	text_end

_ContestJudging_SecondPlaceScoreText::
	text_start

	para "The score was"
	line "@"
	text_decimal wBugContestSecondPlaceScore, 2, 3
	text " points!"
	prompt

_ContestJudging_ThirdPlaceText::
	text "Placing third was"
	line "@"
	text_ram wBugContestWinnerName
	text ","

	para "who caught a"
	line "@"
	text_ram wStringBuffer1
	text "!@"
	text_end

_ContestJudging_ThirdPlaceScoreText::
	text_start

	para "The score was"
	line "@"
	text_decimal wBugContestThirdPlaceScore, 2, 3
	text " points!"
	prompt

_MagikarpGuruMeasureText::
	text "Let me measure"
	line "that Magikarp."

	para "…Hm, it measures"
	line "@"
	text_ram wStringBuffer1
	text "."
	prompt

_KarpGuruRecordText::
	text "Current Record"

	para "@"
	text_ram wStringBuffer1
	text " caught by"
	line "@"
	text_ram wMagikarpRecordHoldersName
	text_promptbutton
	text_end

_CaughtAskNicknameText::
	text "Give a nickname to"
	line "the @"
	text_ram wStringBuffer1
	text " you"
	cont "received?"
	done

_PokecenterPCCantUseText::
	text "Bzzzzt! You must"
	line "have a #mon to"
	cont "use this!"
	prompt

_PlayersPCAskWhatDoText::
	text "What do you want"
	line "to do?"
	done

_PlayersPCHowManyWithdrawText::
	text "How many do you"
	line "want to withdraw?"
	done

_PlayersPCWithdrewItemsText::
	text "Withdrew @"
	text_decimal wItemQuantityChange, 1, 2
	text_start
	line "@"
	text_ram wStringBuffer2
	text "(S)."
	prompt

_PlayersPCNoRoomWithdrawText::
	text "There's no room"
	line "for more items."
	prompt

_PlayersPCNoItemsText::
	text "No items here!"
	prompt

_CantDepositText::
	text "TM/HM or Key Items"
	line "can't be deposited."
	prompt

_PlayersPCHowManyDepositText::
	text "How many do you"
	line "want to deposit?"
	done

_PlayersPCDepositItemsText::
	text "Deposited @"
	text_decimal wItemQuantityChange, 1, 2
	text_start
	line "@"
	text_ram wStringBuffer2
	text "(S)."
	prompt

_PlayersPCNoRoomDepositText::
	text "There's no room to"
	line "store items."
	prompt

_PokecenterPCTurnOnText::
	text "<PLAYER> turned on"
	line "the PC."
	prompt

_PocketPCNoSignalText::
	text "Bzzzzt!"

	para "There is no"
	line "signal!"

	para "The PC cannot be"
	line "accessed!"
	done

_HealedPartyShuttingDownText::
	text "<PLAYER>'s Party"
	line "was fully healed!"
	roll "…shutting down…"
	done

_PokecenterPCWhoseText::
	text "Access whose PC?"
	done

_PokecenterOaksPCText::
	text "#dex Rating"
	line "System opened."
	prompt

_OakPCText1::
	text "Rate #dex?"
	done

_OakPCText2::
	text "Current #dex"
	line "completion level:"
	prompt

_OakPCText3::
	text_ram wStringBuffer3
	text " #mon seen"
	line "@"
	text_ram wStringBuffer4
	text " #mon owned"

	para "Prof.Oak's"
	line "Rating:"
	done

_OakRating01::
	text "Look for #mon"
	line "in grassy areas!"
	done

_OakRating02::
	text "Good. I see you"
	line "understand how to"
	cont "use # Balls."
	done

_OakRating03::
	text "You're getting"
	line "good at this."

	para "But you have a"
	line "long way to go."
	done

_OakRating04::
	text "You need to fill"
	line "up the #dex."

	para "Catch different"
	line "kinds of #mon!"
	done

_OakRating05::
	text "You're trying--I"
	line "can see that."

	para "Your #dex is"
	line "coming together."
	done

_OakRating06::
	text "To evolve, some"
	line "#mon grow,"

	para "others use the"
	line "effects of Stones."
	done

_OakRating07::
	text "Have you gotten a"
	line "fishing Rod? You"

	para "can catch #mon"
	line "by fishing."
	done

_OakRating08::
	text "Excellent! You"
	line "seem to like col-"
	cont "lecting things!"
	done

_OakRating09::
	text "Some #mon only"
	line "appear during"

	para "certain times of"
	line "the day."
	done

_OakRating10::
	text "Your #dex is"
	line "filling up. Keep"
	cont "up the good work!"
	done

_OakRating11::
	text "I'm impressed."
	line "You're evolving"

	para "#mon, not just"
	line "catching them."
	done

_OakRating12::
	text "Have you met Kurt?"
	line "His custom Balls"
	cont "should help."
	done

_OakRating13::
	text "Wow. You've found"
	line "more #mon than"

	para "the last #dex"
	line "research project."
	done

_OakRating14::
	text "Are you trading"
	line "your #mon?"

	para "It's tough to do"
	line "this alone!"
	done

_OakRating15::
	text "Wow! You've hit"
	line "200! Your #dex"
	cont "is looking great!"
	done

_OakRating16::
	text "You've found so"
	line "many #mon!"

	para "You've really"
	line "helped my studies!"
	done

_OakRating17::
	text "Magnificent! You"
	line "could become a"

	para "#mon professor"
	line "right now!"
	done

_OakRating18::
	text "Your #dex is"
	line "amazing! You're"

	para "ready to turn"
	line "professional!"
	done

_OakRating19::
	text "Whoa! A perfect"
	line "#dex! I've"

	para "dreamt about this!"
	line "Congratulations!"
	done

_MemoryGamePayoutText::
	text " ! @"
	text_decimal wStringBuffer2, 1, 2
	text " Coin(s)!"
	done

_MemoryGameDarnText::
	text "Darn…"
	done

_MemoryGameGameOverText::
	text "Game over!"
	done

_MemoryGameExtraTryText::
	text " ! An extra"
	line "try!"
	done

_StartMenuContestEndText::
	text "Would you like to"
	line "end the Contest?"
	done

_ItemsTossOutHowManyText::
	text "Toss out how many"
	line "@"
	text_ram wStringBuffer2
	text "(S)?"
	done

_ItemsThrowAwayText::
	text "Throw away @"
	text_decimal wItemQuantityChange, 1, 2
	text_start
	line "@"
	text_ram wStringBuffer2
	text "(S)?"
	done

_ItemsDiscardedText::
	text "Discarded"
	line "@"
	text_ram wStringBuffer1
	text "(S)."
	prompt

_ItemsTooImportantText::
	text "That's too impor-"
	line "tant to toss out!"
	prompt

_ItemsOakWarningText::
	text "Neither the time"
	line "nor place…"
	done

_PokemonSwapItemText::
	text "Took @"
	text_ram wMonOrItemNameBuffer
	text "'s"
	line "@"
	text_ram wStringBuffer1
	text " and"

	para "made it hold"
	line "@"
	text_ram wStringBuffer2
	text "."
	prompt

_PokemonHoldItemText::
	text "Made @"
	text_ram wMonOrItemNameBuffer
	text_start
	line "hold @"
	text_ram wStringBuffer2
	text "."
	prompt

_PokemonRemoveMailText::
	text "Please remove the"
	line "Mail first."
	prompt

_PokemonNotHoldingText::
	text_ram wMonOrItemNameBuffer
	text " isn't"
	line "holding anything."
	prompt

_ItemStorageFullText::
	text "Item storage space"
	line "full."
	prompt

_PokemonTookItemText::
	text "Took @"
	text_ram wStringBuffer1
	text_start
	line "from @"
	text_ram wMonOrItemNameBuffer
	text "."
	prompt

_PokemonAskSwapItemText::
	text_ram wMonOrItemNameBuffer
	text " is"
	line "already holding"

	para "@"
	text_ram wStringBuffer1
	text "."
	line "Switch items?"
	done

_ItemCantHeldText::
	text "This item can't be"
	line "held."
	prompt

_CantPlaceMailInStorageText::
	text "Can't place Mail in"
	line "storage."
	prompt

_MailLoseMessageText::
	text "The Mail will lose"
	line "its message. OK?"
	done

_MailDetachedText::
	text "Mail detached from"
	line "@"
	text_ram wStringBuffer1
	text "."
	prompt

_MailNoSpaceText::
	text "There's no space"
	line "for removing Mail."
	prompt

_MailAskSendToPCText::
	text "Send the removed"
	line "Mail to your PC?"
	done

_MailboxFullText::
	text "Your PC's Mailbox"
	line "is full."
	prompt

_MailSentToPCText::
	text "The Mail was sent"
	line "to your PC."
	prompt

_PokemonNotEnoughHPText::
	text "Not enough HP!"
	prompt

_MayRegisterItemText::
	text "An item in your"
	line "Bag may be"

	para "registered for use"
	line "on SELECT Button."
	done

_OakText1::
	text "Hello! Sorry to"
	line "keep you waiting!"

	para "Welcome to the"
	line "world of #mon!"

	para "My name is Oak."

	para "People call me the"
	line "#mon Prof."
	prompt

_OakText2::
	text "This world is in-"
	line "habited by crea-"
	cont "tures that we call"
	cont "#mon.@"
	text_end

_OakText3::
	text_promptbutton
	text_end

_OakText4::
	text "People and #mon"
	line "live together by"

	para "supporting each"
	line "other."

	para "Some people play"
	line "with #mon, some"
	cont "battle with them."
	prompt

_OakText4Min::
	text "We work and live"
	line "together…"
	prompt

_OakText5::
	text "But we don't know"
	line "everything about"
	cont "#mon yet."

	para "There are still"
	line "many mysteries to"
	cont "solve."

	para "That's why I study"
	line "#mon every day."
	prompt

_OakText5Min::
	text "Alright…"
	prompt

_AboutText::
	text "This is a Johto"
	line "only region game."

	para "You many do what-"
	line "ever you want,"

	para "whenever you want,"
	line "or nothing at all."

	para "A Generation Two"
	line "#mon experience"

	para "with QOL features,"
	line "collecting all"
	
	para "#mon infinitely"
	line "in one save file,"
	
	para "increased replay"
	line "value; especially"
	cont "in the post game."
	prompt
