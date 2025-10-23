; Footprints are 2x2 tiles each, but are stored as a 16x64-tile image
; (32 rows of 8 footprints per row).
; That means there's a row of the top two tiles for eight footprints,
; then a row of the bottom two tiles for those eight footprints.
Footprints:
; Entries correspond to Pokémon species, two apiece, 8 tops then 8 bottoms
	table_width LEN_1BPP_TILE * 4, Footprints

; Note:
; Repeated footprints : staryu, skorupi, 

; 001-008  
 INCBIN "gfx/footprints/cyndaquil.1bpp" 
 INCBIN "gfx/footprints/quilava.1bpp"
 INCBIN "gfx/footprints/typhlosion.1bpp"
 INCBIN "gfx/footprints/totodile.1bpp"
 INCBIN "gfx/footprints/croconaw.1bpp" 
 INCBIN "gfx/footprints/feraligatr.1bpp"
 INCBIN "gfx/footprints/chikorita.1bpp"
 INCBIN "gfx/footprints/bayleef.1bpp"
 INCBIN "gfx/footprints/meganium.1bpp"
 INCBIN "gfx/footprints/togepi.1bpp"  
 INCBIN "gfx/footprints/togetic.1bpp"
 INCBIN "gfx/footprints/togekiss.1bpp"
 INCBIN "gfx/footprints/charmander.1bpp"
 INCBIN "gfx/footprints/charmeleon.1bpp"
 INCBIN "gfx/footprints/charizard.1bpp"
 INCBIN "gfx/footprints/squirtle.1bpp"
 INCBIN "gfx/footprints/wartortle.1bpp"
 INCBIN "gfx/footprints/blastoise.1bpp"
 INCBIN "gfx/footprints/turtwig.1bpp"
 INCBIN "gfx/footprints/grotle.1bpp"
 INCBIN "gfx/footprints/torterra.1bpp"
 INCBIN "gfx/footprints/pikachu.1bpp" 
 INCBIN "gfx/footprints/raichu.1bpp"
 INCBIN "gfx/footprints/eevee.1bpp"
 INCBIN "gfx/footprints/umbreon.1bpp"
 INCBIN "gfx/footprints/sylveon.1bpp"
 INCBIN "gfx/footprints/torchic.1bpp"
 INCBIN "gfx/footprints/combusken.1bpp"
 INCBIN "gfx/footprints/blaziken.1bpp"
 INCBIN "gfx/footprints/blank.1bpp" ; FEEBAS
 INCBIN "gfx/footprints/blank.1bpp" ; MILOTIC
 INCBIN "gfx/footprints/rowlet_line.1bpp" ; ROWLET
 INCBIN "gfx/footprints/rowlet_line.1bpp"  ; DARTRIX
 INCBIN "gfx/footprints/rowlet_line.1bpp" ; DECIDUEYE
 INCBIN "gfx/footprints/ralts.1bpp" 
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
 INCBIN "gfx/footprints/blank.1bpp" ; SUNKERN
 INCBIN "gfx/footprints/sunflora.1bpp" 
 INCBIN "gfx/footprints/buneary.1bpp"
 INCBIN "gfx/footprints/lopunny.1bpp"
 INCBIN "gfx/footprints/pidgey.1bpp"
 INCBIN "gfx/footprints/pidgeotto.1bpp"
 INCBIN "gfx/footprints/pidgeot.1bpp" 
 INCBIN "gfx/footprints/hoothoot.1bpp"
 INCBIN "gfx/footprints/noctowl.1bpp"
 INCBIN "gfx/footprints/blank.1bpp" ; ZUBAT
 INCBIN "gfx/footprints/golbat.1bpp" 
 INCBIN "gfx/footprints/blank.1bpp" ; CROBAT
 INCBIN "gfx/footprints/teddiursa.1bpp"
 INCBIN "gfx/footprints/ursaring.1bpp" 
 INCBIN "gfx/footprints/ursaluna.1bpp"  
 INCBIN "gfx/footprints/phanpy.1bpp"  
 INCBIN "gfx/footprints/donphan.1bpp"  
 INCBIN "gfx/footprints/bellsprout.1bpp"
 INCBIN "gfx/footprints/blank.1bpp" ; WEEPINBELL
 INCBIN "gfx/footprints/blank.1bpp" ; VICTREEBEL
 INCBIN "gfx/footprints/mareep.1bpp"  
 INCBIN "gfx/footprints/flaaffy.1bpp"
 INCBIN "gfx/footprints/ampharos.1bpp"
 INCBIN "gfx/footprints/nidoran_f.1bpp"
 INCBIN "gfx/footprints/nidorina.1bpp"
 INCBIN "gfx/footprints/nidoqueen.1bpp"
 INCBIN "gfx/footprints/nidoran_m.1bpp" 
 INCBIN "gfx/footprints/nidorino.1bpp" 
 INCBIN "gfx/footprints/nidoking.1bpp" 
 INCBIN "gfx/footprints/wimpod.1bpp"
 INCBIN "gfx/footprints/golisopod.1bpp"
 INCBIN "gfx/footprints/marill.1bpp"
 INCBIN "gfx/footprints/azumarill.1bpp" 
 INCBIN "gfx/footprints/rhyhorn.1bpp"
 INCBIN "gfx/footprints/rhydon.1bpp"
 INCBIN "gfx/footprints/drilbur.1bpp"
 INCBIN "gfx/footprints/excadrill.1bpp"
 INCBIN "gfx/footprints/blank.1bpp" ; ONIX
 INCBIN "gfx/footprints/blank.1bpp" ; STEELIX
 INCBIN "gfx/footprints/blank.1bpp" ; MAGIKARP
 INCBIN "gfx/footprints/blank.1bpp" ; GYARADOS
 INCBIN "gfx/footprints/blank.1bpp" ; GASTLY
 INCBIN "gfx/footprints/blank.1bpp" ; HAUNTER
 INCBIN "gfx/footprints/gengar.1bpp"
 INCBIN "gfx/footprints/swablu.1bpp" 
 INCBIN "gfx/footprints/altaria.1bpp" 
 INCBIN "gfx/footprints/natu.1bpp" 
 INCBIN "gfx/footprints/xatu.1bpp"  
 INCBIN "gfx/footprints/katu.1bpp"  
 INCBIN "gfx/footprints/smeargle.1bpp" 
 INCBIN "gfx/footprints/growlithe.1bpp"
 INCBIN "gfx/footprints/arcanine.1bpp"
 INCBIN "gfx/footprints/houndour.1bpp"
 INCBIN "gfx/footprints/houndoom.1bpp"
 INCBIN "gfx/footprints/wooper.1bpp"  
 INCBIN "gfx/footprints/quagsire.1bpp"  
 INCBIN "gfx/footprints/gligar.1bpp"  
 INCBIN "gfx/footprints/gliscor.1bpp"
 INCBIN "gfx/footprints/gible.1bpp"
 INCBIN "gfx/footprints/gabite.1bpp"
 INCBIN "gfx/footprints/garchomp.1bpp"
 INCBIN "gfx/footprints/makuhita.1bpp"
 INCBIN "gfx/footprints/hariyama.1bpp"
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
 INCBIN "gfx/footprints/skorupi.1bpp" 
 INCBIN "gfx/footprints/skorupi.1bpp" ; DRAPION
 INCBIN "gfx/footprints/larvesta.1bpp" 
 INCBIN "gfx/footprints/blank.1bpp" ; VOLCARONA
 INCBIN "gfx/footprints/tropius.1bpp"
 INCBIN "gfx/footprints/mankey.1bpp"
 INCBIN "gfx/footprints/primeape.1bpp"
 INCBIN "gfx/footprints/annihilape.1bpp"  
 INCBIN "gfx/footprints/blank.1bpp" ; FERROSEED
 INCBIN "gfx/footprints/ferrothorn.1bpp"
 INCBIN "gfx/footprints/scyther.1bpp"
 INCBIN "gfx/footprints/scizor.1bpp"
 INCBIN "gfx/footprints/kleavor.1bpp" 
 INCBIN "gfx/footprints/heracross.1bpp" 
 INCBIN "gfx/footprints/tangela.1bpp"
 INCBIN "gfx/footprints/tangrowth.1bpp" 
 INCBIN "gfx/footprints/meowth.1bpp"
 INCBIN "gfx/footprints/persian.1bpp"
 INCBIN "gfx/footprints/snubbull.1bpp" 
 INCBIN "gfx/footprints/granbull.1bpp"
 INCBIN "gfx/footprints/drowzee.1bpp"  
 INCBIN "gfx/footprints/hypno.1bpp"  
 INCBIN "gfx/footprints/sudowoodo.1bpp"  
 INCBIN "gfx/footprints/blank.1bpp" ; KOFFING
 INCBIN "gfx/footprints/blank.1bpp" ; WEEZING
 INCBIN "gfx/footprints/blank.1bpp" ; GRIMER
 INCBIN "gfx/footprints/blank.1bpp" ; MUK
 INCBIN "gfx/footprints/blank.1bpp" ; LITWICK
 INCBIN "gfx/footprints/blank.1bpp" ; LAMPENT  
 INCBIN "gfx/footprints/blank.1bpp" ; CHANDELURE
 INCBIN "gfx/footprints/miltank.1bpp"  
 INCBIN "gfx/footprints/tauros.1bpp" 
 INCBIN "gfx/footprints/blank.1bpp" ; VOLTORB
 INCBIN "gfx/footprints/blank.1bpp" ; ELECTRODE
 INCBIN "gfx/footprints/elekid.1bpp"
 INCBIN "gfx/footprints/electabuzz.1bpp"
 INCBIN "gfx/footprints/magnemite.1bpp"
 INCBIN "gfx/footprints/magneton.1bpp" 
 INCBIN "gfx/footprints/magneton.1bpp" ; MAGNEZONE
 INCBIN "gfx/footprints/shuckle.1bpp"
 INCBIN "gfx/footprints/corsola.1bpp"  
 INCBIN "gfx/footprints/staryu.1bpp"  
 INCBIN "gfx/footprints/staryu.1bpp" ; STARMIE
 INCBIN "gfx/footprints/blank.1bpp" ; REMORAID
 INCBIN "gfx/footprints/octillery.1bpp" 
 INCBIN "gfx/footprints/blank.1bpp" ; CHINCHOU
 INCBIN "gfx/footprints/blank.1bpp" ; LANTURN
 INCBIN "gfx/footprints/blank.1bpp" ; MANTINE
 INCBIN "gfx/footprints/blank.1bpp" ; TENTACOOL
 INCBIN "gfx/footprints/blank.1bpp" ; TENTACRUEL
 INCBIN "gfx/footprints/blank.1bpp" ; SEEL
 INCBIN "gfx/footprints/blank.1bpp" ; DEWGONG
 INCBIN "gfx/footprints/blank.1bpp" ; HORSEA
 INCBIN "gfx/footprints/blank.1bpp" ; SEADRA
 INCBIN "gfx/footprints/blank.1bpp" ; KINGDRA
 INCBIN "gfx/footprints/blank.1bpp" ; LAPRAS
 INCBIN "gfx/footprints/clefairy.1bpp" 
 INCBIN "gfx/footprints/clefable.1bpp"
 INCBIN "gfx/footprints/blank.1bpp" ; SOLROCK
 INCBIN "gfx/footprints/blank.1bpp" ; LUNATONE
 INCBIN "gfx/footprints/stantler.1bpp"
 INCBIN "gfx/footprints/wyrdeer.1bpp"
 INCBIN "gfx/footprints/delibird.1bpp"
 INCBIN "gfx/footprints/smoochum.1bpp"
 INCBIN "gfx/footprints/blank.1bpp" ; JYNX
 INCBIN "gfx/footprints/snorunt.1bpp"  
 INCBIN "gfx/footprints/blank.1bpp" ; GLALIE
 INCBIN "gfx/footprints/blank.1bpp" ; FROSLASS
 INCBIN "gfx/footprints/swinub.1bpp"
 INCBIN "gfx/footprints/piloswine.1bpp"
 INCBIN "gfx/footprints/mamoswine.1bpp"
 INCBIN "gfx/footprints/sneasel.1bpp" 
 INCBIN "gfx/footprints/weavile.1bpp" 
 INCBIN "gfx/footprints/sneasler.1bpp"
 INCBIN "gfx/footprints/snover.1bpp"  
 INCBIN "gfx/footprints/abomasnow.1bpp"
 INCBIN "gfx/footprints/staryu.1bpp" ; BALTOY
 INCBIN "gfx/footprints/claydol.1bpp"
 INCBIN "gfx/footprints/riolu.1bpp"
 INCBIN "gfx/footprints/lucario.1bpp"
 INCBIN "gfx/footprints/blank.1bpp" ; BRONZOR
 INCBIN "gfx/footprints/blank.1bpp" ; BRONZONG
 INCBIN "gfx/footprints/skarmory.1bpp"  
 INCBIN "gfx/footprints/blank.1bpp" ; MISDREAVUS
 INCBIN "gfx/footprints/blank.1bpp" ; MISMAGIUS
 INCBIN "gfx/footprints/chansey.1bpp"  
 INCBIN "gfx/footprints/blissey.1bpp" 
 INCBIN "gfx/footprints/snorlax.1bpp" 
 INCBIN "gfx/footprints/larvitar.1bpp" 
 INCBIN "gfx/footprints/blank.1bpp" ; PUPITAR
 INCBIN "gfx/footprints/tyranitar.1bpp"
 INCBIN "gfx/footprints/bagon.1bpp"  
 INCBIN "gfx/footprints/shelgon.1bpp"
 INCBIN "gfx/footprints/salamence.1bpp"
 INCBIN "gfx/footprints/axew.1bpp"
 INCBIN "gfx/footprints/fraxure.1bpp"
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
 INCBIN "gfx/footprints/regirock.1bpp"
 INCBIN "gfx/footprints/staryu.1bpp" ; REGICE
 INCBIN "gfx/footprints/registeel.1bpp"
 INCBIN "gfx/footprints/regigigas.1bpp"  
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
 INCBIN "gfx/footprints/victini.1bpp"
 INCBIN "gfx/footprints/celebi.1bpp"  
 INCBIN "gfx/footprints/blank.1bpp" ; DITTO
 INCBIN "gfx/footprints/mew.1bpp"  
 INCBIN "gfx/footprints/mewtwo.1bpp" 
 INCBIN "gfx/footprints/blank.1bpp" ; 253
 INCBIN "gfx/footprints/blank.1bpp" ; 254
 INCBIN "gfx/footprints/blank.1bpp" ; 255
 INCBIN "gfx/footprints/blank.1bpp" ; 256 


 
 ; 009-016  
 ; 017-024  
 ; 025-032   
 ; 033-040   
 ; 041-048   
 ; 049-056   
 ; 057-064   
 ; 065-072   
 ; 073-080    
 ; 081-088    
 ; 089-096    
 ; 097-104    
 ; 105-112    
 ; 113-120    
 ; 121-128    
 ; 129-136    
 ; 137-144    
 ; 145-152    
 ; 153-160    
 ; 161-168       
 ; 169-176    
 ; 177-184    
 ; 185-192    
 ; 193-200    
 ; 201-208    
 ; 209-216    
 ; 217-224    
 ; 225-232    
 ; 233-240    
 ; 241-248    
 ; 249-256    
   
 	assert_table_length $100