GetFinalPkmnTextPointer::
; Does [wOtherTrainerClass] have a quote for their final Pokemon?
; -> hl: the text, carry set if there is one
	ld a, [wOtherTrainerClass]
	ld hl, FinalPkmnTexts
	ld de, 3
	call IsInArray
	ret nc
	inc hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	scf
	ret

PrintFinalPkmnText::
; Print the quote at de. The text is read from this bank, so it needn't
; be in BattleText's.
	ld h, d
	ld l, e
	jmp BattleTextbox

FinalPkmnTexts:
; trainer class, text (any bank works: it is printed from this bank)
	dbw FALKNER, FalknerFinalPkmnText
	dbw WHITNEY, WhitneyFinalPkmnText
	dbw BUGSY, BugsyFinalPkmnText
	dbw MORTY, MortyFinalPkmnText
	dbw PRYCE, PryceFinalPkmnText
	dbw JASMINE, JasmineFinalPkmnText
	dbw CHUCK, ChuckFinalPkmnText
	dbw CLAIR, ClairFinalPkmnText
	dbw WILL, WillFinalPkmnText
	dbw KOGA, KogaFinalPkmnText
	dbw BRUNO, BrunoFinalPkmnText
	dbw KAREN, KarenFinalPkmnText
	dbw CHAMPION, ChampionFinalPkmnText
	dbw BROCK, BrockFinalPkmnText
	dbw MISTY, MistyFinalPkmnText
	dbw LT_SURGE, LtSurgeFinalPkmnText
	dbw ERIKA, ErikaFinalPkmnText
	dbw JANINE, JanineFinalPkmnText
	dbw SABRINA, SabrinaFinalPkmnText
	dbw BLAINE, BlaineFinalPkmnText
	dbw BLUE, BlueFinalPkmnText
	dbw RED, RedFinalPkmnText
	dbw GIOVANNI, GiovanniFinalPkmnText
	dbw LORELEI, LoreleiFinalPkmnText
	dbw AGATHA, AgathaFinalPkmnText
	dbw MAXIMA, MaximaFinalPkmnText
	db -1 ; end

FalknerFinalPkmnText:
	text "The wind is"
	line "finally with us!"
	prompt

WhitneyFinalPkmnText:
	text "H-hey! Just one"
	line "left? But…"

	para "I ain't losin',"
	line "you hear?"
	prompt

BugsyFinalPkmnText:
	text "Even though it's"
	line "my last #mon,"

	para "Bug #mon are"
	line "tough!"
	prompt

MortyFinalPkmnText:
	text "I still believe"
	line "we can do it!"
	prompt

PryceFinalPkmnText:
	text "Humph… You are"
	line "quite the Trainer."
	prompt

JasmineFinalPkmnText:
	text "Well-tempered"
	line "steel will hang on"
	cont "to the very last!"
	prompt

ChuckFinalPkmnText:
	text "We haven't lost"
	line "yet!"
	prompt

ClairFinalPkmnText:
	text "One last #mon?"
	line "This is where the"
	cont "real fight begins!"
	prompt

WillFinalPkmnText:
	text "We Psychics don't"
	line "give up until we"
	cont "reach zero!"
	prompt

KogaFinalPkmnText:
	text "Fwahaha! I've been"
	line "counting on this"

	para "one from the very"
	line "beginning!"
	prompt

BrunoFinalPkmnText:
	text "Fight as hard as"
	line "you can 'til you"
	cont "faint!"
	prompt

KarenFinalPkmnText:
	text "This is far from"
	line "being backed into"
	cont "a corner!"
	prompt

ChampionFinalPkmnText:
	text "All right! I"
	line "thought this would"
	cont "never happen!"
	prompt

BrockFinalPkmnText:
	text "Ah ha ha!"
	line "It itches!"
	prompt

MistyFinalPkmnText:
	text "Hmm… You're"
	line "pretty good…"
	prompt

LtSurgeFinalPkmnText:
	text "It's not over yet."
	line "It's just getting"
	cont "started!"
	prompt

ErikaFinalPkmnText:
	text "Don't go easy on"
	line "me. Give me every-"
	cont "thing you've got!"
	prompt

JanineFinalPkmnText:
	text "You've got a great"
	line "battle technique!"
	prompt

SabrinaFinalPkmnText:
	text "What will happen"
	line "after this?"
	cont "I already know."
	prompt

BlaineFinalPkmnText:
	text "I'll show you the"
	line "spirit of my cave"
	cont "Gym!"
	prompt

BlueFinalPkmnText:
	text "Heh heh heh…"
	line "You're unprepared"

	para "for this. We'll"
	line "knock you down!"
	prompt

RedFinalPkmnText:
	text "………………"
	prompt

GiovanniFinalPkmnText:
	text "My #mon is"
	line "invincible!"
	prompt

LoreleiFinalPkmnText:
	text "You only got a"
	line "taste of my power!"
	prompt

AgathaFinalPkmnText:
	text "Don't assume that"
	line "you've won, child!"
	prompt

MaximaFinalPkmnText:
	text "This last one's my"
	line "strongest. Ready?"
	prompt

