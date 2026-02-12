	; good party
	givepoke AERODACTYL, 50, LIFE_ORB
	givepoke SUICUNE, 50, LEFTOVERS
	givepoke GHOLDENGO, 50, LEFTOVERS
	givepoke MAGNEZONE, 50, LEFTOVERS
	givepoke BLISSEY, 50, LEFTOVERS
	givepoke URSALUNA, 50, QUICK_CLAW

	; first mon shiny
	loadmem wPartyMon1DVs+0, $ff
	loadmem wPartyMon1DVs+1, $ff

	; third mon shiny
	loadmem wPartyMon3DVs+0, $ff
	loadmem wPartyMon3DVs+1, $ff

	; 1st mon moves
	loadmem wPartyMon1Moves+0, STONE_EDGE
	loadmem wPartyMon1Moves+1, SKY_ATTACK
	loadmem wPartyMon1Moves+2, OUTRAGE
	loadmem wPartyMon1Moves+3, EARTHQUAKE

	; 2nd mon moves
	loadmem wPartyMon2Moves+0, SCALD
	loadmem wPartyMon2Moves+1, CALM_MIND
	loadmem wPartyMon2Moves+2, REST
	loadmem wPartyMon2Moves+3, ICE_BEAM

	; 3rd mon moves
	loadmem wPartyMon3Moves+0, FLASH_CANNON
	loadmem wPartyMon3Moves+1, SHADOW_BALL
	loadmem wPartyMon3Moves+2, POWER_GEM
	loadmem wPartyMon3Moves+3, THUNDER

	; 4th mon moves
	loadmem wPartyMon4Moves+0, THUNDERBOLT
	loadmem wPartyMon4Moves+1, FLASH_CANNON
	loadmem wPartyMon4Moves+2, EXPLOSION
	loadmem wPartyMon4Moves+3, PHOTON_BLAST

	; 5th mon moves
	loadmem wPartyMon5Moves+0, TOXIC
	loadmem wPartyMon5Moves+1, PROTECT
	loadmem wPartyMon5Moves+2, SOFTBOILED
	loadmem wPartyMon5Moves+3, SEISMIC_TOSS

	; 6th mon moves
	loadmem wPartyMon6Moves+0, HYPER_BEAM
	loadmem wPartyMon6Moves+1, EARTH_POWER
	loadmem wPartyMon6Moves+2, PLAY_ROUGH
	loadmem wPartyMon6Moves+3, ICE_PUNCH
