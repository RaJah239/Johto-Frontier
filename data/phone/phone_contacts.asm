MACRO phone
; trainer class, trainer id, map, callee time, callee script, caller time, caller script
	db \1, \2
	map_id \3
	db \4
	dba \5
	db \6
	dba \7
ENDM

PhoneContacts:
; entries correspond to PHONE_* constants
	table_width PHONE_CONTACT_SIZE, PhoneContacts
	phone TRAINER_NONE, PHONE_00,              N_A,                       0,       UnusedPhoneScript,        0,       UnusedPhoneScript
	phone TRAINER_NONE, PHONECONTACT_MOM,      PLAYERS_HOUSE_1F,          ANYTIME, MomPhoneCalleeScript,     0,       UnusedPhoneScript
	phone TRAINER_NONE, PHONECONTACT_BIKESHOP, OAKS_LAB,                  0,       UnusedPhoneScript,        0,       UnusedPhoneScript
	phone TRAINER_NONE, PHONECONTACT_BILL,     N_A,                       0,       UnusedPhoneScript,        0,       BillPhoneCallerScript
	phone TRAINER_NONE, PHONECONTACT_ELM,      ELMS_LAB,                  ANYTIME, ElmPhoneCalleeScript,     0,       ElmPhoneCallerScript
	phone COOLTRAINERM, GAVEN3,                ROUTE_20,                  ANYTIME, GavenPhoneCalleeScript,   ANYTIME, GavenPhoneCallerScript
	phone COOLTRAINERF, BETH1,                 ROUTE_20,                  ANYTIME, BethPhoneCalleeScript,    ANYTIME, BethPhoneCallerScript
	phone BIRD_KEEPER,  JOSE2,                 ROUTE_19,                  ANYTIME, JosePhoneCalleeScript,    ANYTIME, JosePhoneCallerScript
	phone COOLTRAINERF, REENA1,                ROUTE_19,                  ANYTIME, ReenaPhoneCalleeScript,   ANYTIME, ReenaPhoneCallerScript
	phone FISHER,       TULLY1,                ROUTE_14,                  ANYTIME, TullyPhoneCalleeScript,   ANYTIME, TullyPhoneCallerScript
	phone POKEMANIAC,   BRENT1,                ROUTE_15,                  ANYTIME, BrentPhoneCalleeScript,   ANYTIME, BrentPhoneCallerScript
	phone PICNICKER,    TIFFANY3,              ROUTE_15,                  ANYTIME, TiffanyPhoneCalleeScript, ANYTIME, TiffanyPhoneCallerScript
	phone BIRD_KEEPER,  VANCE1,                ROUTE_16,                  ANYTIME, VancePhoneCalleeScript,   ANYTIME, VancePhoneCallerScript
	phone FISHER,       WILTON1,               ROUTE_16,                  ANYTIME, WiltonPhoneCalleeScript,  ANYTIME, WiltonPhoneCallerScript
	phone HIKER,        PARRY1,                ROUTE_17,                  ANYTIME, ParryPhoneCalleeScript,   ANYTIME, ParryPhoneCallerScript
	phone PICNICKER,    ERIN1,                 ROUTE_18,                  ANYTIME, ErinPhoneCalleeScript,    ANYTIME, ErinPhoneCallerScript
	assert_table_length NUM_PHONE_CONTACTS + 1
