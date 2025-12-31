; List of all Pokemon that automatically
; increases accuracy by 1 stage

CompoundEyes:
	cp STARYU
	call z, IncrementB
	cp STARMIE
	call z, IncrementB
	cp HOOTHOOT
	call z, IncrementB
	cp NOCTOWL
	ret

IncrementB:
	inc b
	ret
