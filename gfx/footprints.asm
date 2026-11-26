; Footprints are 2x2 tiles each, but are stored as a 16x64-tile image
; (32 rows of 8 footprints per row).
; That means there's a row of the top two tiles for eight footprints,
; then a row of the bottom two tiles for those eight footprints.
Footprints:
; Entries correspond to Pokémon species, two apiece, 8 tops then 8 bottoms
	table_width LEN_1BPP_TILE * 4, Footprints

 INCBIN "gfx/footprints/quilava.1bpp"
 INCBIN "gfx/footprints/typhlosion.1bpp"
 INCBIN "gfx/footprints/croconaw.1bpp" 
 INCBIN "gfx/footprints/feraligatr.1bpp"
 INCBIN "gfx/footprints/bayleef.1bpp"
 INCBIN "gfx/footprints/meganium.1bpp"
 INCBIN "gfx/footprints/togetic.1bpp"
 INCBIN "gfx/footprints/togekiss.1bpp"
 INCBIN "gfx/footprints/charmeleon.1bpp"
 INCBIN "gfx/footprints/charizard.1bpp"
 INCBIN "gfx/footprints/wartortle.1bpp"
 INCBIN "gfx/footprints/blastoise.1bpp"
 INCBIN "gfx/footprints/torterra.1bpp"
 INCBIN "gfx/footprints/pikachu.1bpp" 
 INCBIN "gfx/footprints/raichu.1bpp"
 INCBIN "gfx/footprints/eevee.1bpp"
 INCBIN "gfx/footprints/espeon.1bpp"
 INCBIN "gfx/footprints/flareon.1bpp"
 INCBIN "gfx/footprints/jolteon.1bpp"
 INCBIN "gfx/footprints/sylveon.1bpp"
 INCBIN "gfx/footprints/umbreon.1bpp"
 INCBIN "gfx/footprints/vaporeon.1bpp"
 INCBIN "gfx/footprints/combusken.1bpp"
 INCBIN "gfx/footprints/blaziken.1bpp"
 INCBIN "gfx/footprints/glaceon.1bpp"
 INCBIN "gfx/footprints/leafeon.1bpp"
 INCBIN "gfx/footprints/poliwhirl.1bpp"
 INCBIN "gfx/footprints/poliwrath.1bpp"
 INCBIN "gfx/footprints/politoed.1bpp"
 INCBIN "gfx/footprints/mawile.1bpp"
 INCBIN "gfx/footprints/duosion.1bpp"
 INCBIN "gfx/footprints/reuniclus.1bpp"
 INCBIN "gfx/footprints/cottonee.1bpp"
 INCBIN "gfx/footprints/whimsicott.1bpp"
 INCBIN "gfx/footprints/machoke.1bpp"
 INCBIN "gfx/footprints/machamp.1bpp"
 INCBIN "gfx/footprints/slowking.1bpp"
 INCBIN "gfx/footprints/foongus.1bpp"
 INCBIN "gfx/footprints/amoonguss.1bpp"
 INCBIN "gfx/footprints/dipplin.1bpp"
 INCBIN "gfx/footprints/hydrapple.1bpp"
 INCBIN "gfx/footprints/roselia.1bpp"
 INCBIN "gfx/footprints/roserade.1bpp"
 INCBIN "gfx/footprints/kadabra.1bpp"
 INCBIN "gfx/footprints/alakazam.1bpp"
 INCBIN "gfx/footprints/vulpix.1bpp"
 INCBIN "gfx/footprints/ninetales.1bpp"
 INCBIN "gfx/footprints/ninetales.1bpp" ; shared Ninetales footprint
 INCBIN "gfx/footprints/ivysaur.1bpp"
 INCBIN "gfx/footprints/blank.1bpp" ; FEEBAS
 INCBIN "gfx/footprints/blank.1bpp" ; MILOTIC
 INCBIN "gfx/footprints/kirlia.1bpp"
 INCBIN "gfx/footprints/gardevoir.1bpp"
 INCBIN "gfx/footprints/gallade.1bpp"
 INCBIN "gfx/footprints/wurmple.1bpp"
 INCBIN "gfx/footprints/blank.1bpp" ; SILCOON
 INCBIN "gfx/footprints/beautifly.1bpp"
 INCBIN "gfx/footprints/blank.1bpp" ; CASCOON
 INCBIN "gfx/footprints/dustox.1bpp"  
 INCBIN "gfx/footprints/yanma.1bpp"  
 INCBIN "gfx/footprints/yanmega.1bpp"
 INCBIN "gfx/footprints/buneary.1bpp"
 INCBIN "gfx/footprints/lopunny.1bpp"
 INCBIN "gfx/footprints/pidgeotto.1bpp"
 INCBIN "gfx/footprints/pidgeot.1bpp" 
 INCBIN "gfx/footprints/hoothoot.1bpp"
 INCBIN "gfx/footprints/noctowl.1bpp"
 INCBIN "gfx/footprints/golbat.1bpp" 
 INCBIN "gfx/footprints/blank.1bpp" ; CROBAT
 INCBIN "gfx/footprints/ursaring.1bpp" 
 INCBIN "gfx/footprints/ursaluna.1bpp" ; URSALUNA
 INCBIN "gfx/footprints/ursaluna.1bpp" ; URSALUNA_B
 INCBIN "gfx/footprints/phanpy.1bpp"  
 INCBIN "gfx/footprints/donphan.1bpp"  
 INCBIN "gfx/footprints/bellsprout.1bpp"
 INCBIN "gfx/footprints/blank.1bpp" ; WEEPINBELL
 INCBIN "gfx/footprints/blank.1bpp" ; VICTREEBEL
 INCBIN "gfx/footprints/flaaffy.1bpp"
 INCBIN "gfx/footprints/ampharos.1bpp"
 INCBIN "gfx/footprints/marill.1bpp"
 INCBIN "gfx/footprints/azumarill.1bpp" 
 INCBIN "gfx/footprints/rhydon.1bpp"
 INCBIN "gfx/footprints/drilbur.1bpp"
 INCBIN "gfx/footprints/excadrill.1bpp"
 INCBIN "gfx/footprints/blank.1bpp" ; ONIX
 INCBIN "gfx/footprints/blank.1bpp" ; STEELIX
 INCBIN "gfx/footprints/blank.1bpp" ; MAGIKARP
 INCBIN "gfx/footprints/blank.1bpp" ; GYARADOS
 INCBIN "gfx/footprints/blank.1bpp" ; HAUNTER
 INCBIN "gfx/footprints/gengar.1bpp"
 INCBIN "gfx/footprints/swablu.1bpp" 
 INCBIN "gfx/footprints/altaria.1bpp" 
 INCBIN "gfx/footprints/smeargle.1bpp" 
 INCBIN "gfx/footprints/houndour.1bpp"
 INCBIN "gfx/footprints/houndoom.1bpp"
 INCBIN "gfx/footprints/wooper.1bpp"  
 INCBIN "gfx/footprints/quagsire.1bpp"  
 INCBIN "gfx/footprints/gligar.1bpp"  
 INCBIN "gfx/footprints/gliscor.1bpp"
 INCBIN "gfx/footprints/gabite.1bpp"
 INCBIN "gfx/footprints/garchomp.1bpp"
 INCBIN "gfx/footprints/doduo.1bpp"
 INCBIN "gfx/footprints/dodrio.1bpp"
 INCBIN "gfx/footprints/ponyta.1bpp"
 INCBIN "gfx/footprints/rapidash.1bpp"  
 INCBIN "gfx/footprints/slowpoke.1bpp"
 INCBIN "gfx/footprints/slowbro.1bpp" 
 INCBIN "gfx/footprints/shroomish.1bpp"
 INCBIN "gfx/footprints/breloom.1bpp" 
 INCBIN "gfx/footprints/spinarak.1bpp"
 INCBIN "gfx/footprints/ariados.1bpp" 
 INCBIN "gfx/footprints/venipede.1bpp"
 INCBIN "gfx/footprints/blank.1bpp" ; WHIRLIPEDE
 INCBIN "gfx/footprints/scolipede.1bpp"
 INCBIN "gfx/footprints/joltik.1bpp" 
 INCBIN "gfx/footprints/galvantula.1bpp"
 INCBIN "gfx/footprints/skorupi_line.1bpp" 
 INCBIN "gfx/footprints/skorupi_line.1bpp" ; DRAPION
 INCBIN "gfx/footprints/larvesta.1bpp" 
 INCBIN "gfx/footprints/blank.1bpp" ; VOLCARONA
 INCBIN "gfx/footprints/mankey.1bpp"
 INCBIN "gfx/footprints/primeape.1bpp"
 INCBIN "gfx/footprints/annihilape.1bpp"  
 INCBIN "gfx/footprints/blank.1bpp" ; FERROSEED
 INCBIN "gfx/footprints/ferrothorn.1bpp"
 INCBIN "gfx/footprints/scyther.1bpp"
 INCBIN "gfx/footprints/scizor.1bpp"
 INCBIN "gfx/footprints/kleavor.1bpp" 
 INCBIN "gfx/footprints/heracross.1bpp" 
 INCBIN "gfx/footprints/meowth.1bpp"
 INCBIN "gfx/footprints/persian.1bpp"
 INCBIN "gfx/footprints/snubbull.1bpp" 
 INCBIN "gfx/footprints/granbull.1bpp"
 INCBIN "gfx/footprints/drowzee.1bpp"  
 INCBIN "gfx/footprints/hypno.1bpp"
 INCBIN "gfx/footprints/mr_mime.1bpp" 
 INCBIN "gfx/footprints/sudowoodo.1bpp"  
 INCBIN "gfx/footprints/blank.1bpp" ; KOFFING
 INCBIN "gfx/footprints/blank.1bpp" ; WEEZING
 INCBIN "gfx/footprints/blank.1bpp" ; GRIMER
 INCBIN "gfx/footprints/blank.1bpp" ; MUK
 INCBIN "gfx/footprints/blank.1bpp" ; CHANDELURE
 INCBIN "gfx/footprints/miltank.1bpp"  
 INCBIN "gfx/footprints/tauros.1bpp" 
 INCBIN "gfx/footprints/electabuzz.1bpp"
 INCBIN "gfx/footprints/magneton.1bpp" 
 INCBIN "gfx/footprints/magneton.1bpp" ; MAGNEZONE
 INCBIN "gfx/footprints/shuckle.1bpp"
 INCBIN "gfx/footprints/corsola.1bpp"  
 INCBIN "gfx/footprints/dot.1bpp"  
 INCBIN "gfx/footprints/dot.1bpp" ; STARMIE
 INCBIN "gfx/footprints/blank.1bpp" ; CHINCHOU
 INCBIN "gfx/footprints/blank.1bpp" ; LANTURN
 INCBIN "gfx/footprints/blank.1bpp" ; TENTACOOL
 INCBIN "gfx/footprints/blank.1bpp" ; TENTACRUEL
 INCBIN "gfx/footprints/blank.1bpp" ; SEADRA
 INCBIN "gfx/footprints/blank.1bpp" ; KINGDRA
 INCBIN "gfx/footprints/blank.1bpp" ; LAPRAS
 INCBIN "gfx/footprints/clefairy.1bpp" 
 INCBIN "gfx/footprints/clefable.1bpp"
 INCBIN "gfx/footprints/blank.1bpp" ; SOLROCK
 INCBIN "gfx/footprints/blank.1bpp" ; LUNATONE
 INCBIN "gfx/footprints/delibird.1bpp"
 INCBIN "gfx/footprints/blank.1bpp" ; JYNX
 INCBIN "gfx/footprints/snorunt.1bpp"  
 INCBIN "gfx/footprints/blank.1bpp" ; GLALIE
 INCBIN "gfx/footprints/blank.1bpp" ; FROSLASS
 INCBIN "gfx/footprints/piloswine.1bpp"
 INCBIN "gfx/footprints/mamoswine.1bpp"
 INCBIN "gfx/footprints/sneasel.1bpp" 
 INCBIN "gfx/footprints/weavile.1bpp" 
 INCBIN "gfx/footprints/sneasler.1bpp"
 INCBIN "gfx/footprints/snover.1bpp"  
 INCBIN "gfx/footprints/abomasnow.1bpp"
 INCBIN "gfx/footprints/dot.1bpp" ; BALTOY
 INCBIN "gfx/footprints/claydol.1bpp"
 INCBIN "gfx/footprints/lucario.1bpp"
 INCBIN "gfx/footprints/blank.1bpp" ; BRONZOR
 INCBIN "gfx/footprints/blank.1bpp" ; BRONZONG
 INCBIN "gfx/footprints/skarmory.1bpp"
 INCBIN "gfx/footprints/aggron.1bpp"
 INCBIN "gfx/footprints/blank.1bpp" ; AEGISLASH
 INCBIN "gfx/footprints/blank.1bpp" ; MISDREAVUS
 INCBIN "gfx/footprints/blank.1bpp" ; MISMAGIUS
 INCBIN "gfx/footprints/chansey.1bpp"  
 INCBIN "gfx/footprints/blissey.1bpp" 
 INCBIN "gfx/footprints/snorlax.1bpp" 
 INCBIN "gfx/footprints/tyranitar.1bpp"
 INCBIN "gfx/footprints/salamence.1bpp"
 INCBIN "gfx/footprints/metagross.1bpp"
 INCBIN "gfx/footprints/haxorus.1bpp"
 INCBIN "gfx/footprints/porygon.1bpp" 
 INCBIN "gfx/footprints/porygon2.1bpp"
 INCBIN "gfx/footprints/porygonz.1bpp"
 INCBIN "gfx/footprints/omanyte.1bpp"
 INCBIN "gfx/footprints/omastar.1bpp"
 INCBIN "gfx/footprints/lileep.1bpp"
 INCBIN "gfx/footprints/cradily.1bpp"
 INCBIN "gfx/footprints/aerodactyl.1bpp"
 INCBIN "gfx/footprints/blank.1bpp" ; ROTOM
 INCBIN "gfx/footprints/absol.1bpp" 
 INCBIN "gfx/footprints/duraludon.1bpp"
 INCBIN "gfx/footprints/gholdengo.1bpp"
 INCBIN "gfx/footprints/darkrai.1bpp"
 INCBIN "gfx/footprints/registeel.1bpp"
 INCBIN "gfx/footprints/articuno.1bpp"
 INCBIN "gfx/footprints/zapdos.1bpp"  
 INCBIN "gfx/footprints/moltres.1bpp"
 INCBIN "gfx/footprints/lugia.1bpp"  
 INCBIN "gfx/footprints/raikou.1bpp" 
 INCBIN "gfx/footprints/entei.1bpp"
 INCBIN "gfx/footprints/suicune.1bpp"
 INCBIN "gfx/footprints/ho_oh.1bpp"  
 INCBIN "gfx/footprints/blank.1bpp" ; UNOWN
 INCBIN "gfx/footprints/blank.1bpp" ; NOWN 
 INCBIN "gfx/footprints/jirachi.1bpp"
 INCBIN "gfx/footprints/celebi.1bpp"  
 INCBIN "gfx/footprints/blank.1bpp" ; DITTO
 INCBIN "gfx/footprints/mew.1bpp"  
 INCBIN "gfx/footprints/mewtwo.1bpp" 
 INCBIN "gfx/footprints/blank.1bpp" ; 250
 INCBIN "gfx/footprints/blank.1bpp" ; 251
 INCBIN "gfx/footprints/blank.1bpp" ; 252
 INCBIN "gfx/footprints/blank.1bpp" ; 253
 INCBIN "gfx/footprints/blank.1bpp" ; 254
 INCBIN "gfx/footprints/blank.1bpp" ; 255
 INCBIN "gfx/footprints/blank.1bpp" ; 256
	 INCBIN "gfx/footprints/blank.1bpp" ; 257
	 INCBIN "gfx/footprints/blank.1bpp" ; 258
	 INCBIN "gfx/footprints/blank.1bpp" ; 259
	 INCBIN "gfx/footprints/blank.1bpp" ; 260
	 INCBIN "gfx/footprints/blank.1bpp" ; 261
	 INCBIN "gfx/footprints/blank.1bpp" ; 262
	 INCBIN "gfx/footprints/blank.1bpp" ; 263
	 INCBIN "gfx/footprints/blank.1bpp" ; 264
	 INCBIN "gfx/footprints/blank.1bpp" ; 265
	 INCBIN "gfx/footprints/blank.1bpp" ; 266
	 INCBIN "gfx/footprints/blank.1bpp" ; 267
	 INCBIN "gfx/footprints/blank.1bpp" ; 268
	 INCBIN "gfx/footprints/blank.1bpp" ; 269
	 INCBIN "gfx/footprints/blank.1bpp" ; 270
	 INCBIN "gfx/footprints/blank.1bpp" ; 271
	 INCBIN "gfx/footprints/blank.1bpp" ; 272
	 INCBIN "gfx/footprints/blank.1bpp" ; 273
	 INCBIN "gfx/footprints/blank.1bpp" ; 274
	 INCBIN "gfx/footprints/blank.1bpp" ; 275
	 INCBIN "gfx/footprints/blank.1bpp" ; 276
	 INCBIN "gfx/footprints/blank.1bpp" ; 277
	 INCBIN "gfx/footprints/blank.1bpp" ; 278
	 INCBIN "gfx/footprints/blank.1bpp" ; 279
	 INCBIN "gfx/footprints/blank.1bpp" ; 280
	 INCBIN "gfx/footprints/blank.1bpp" ; 281
	 INCBIN "gfx/footprints/blank.1bpp" ; 282
	 INCBIN "gfx/footprints/blank.1bpp" ; 283
	 INCBIN "gfx/footprints/blank.1bpp" ; 284
	 INCBIN "gfx/footprints/blank.1bpp" ; 285
	assert_table_length $100
