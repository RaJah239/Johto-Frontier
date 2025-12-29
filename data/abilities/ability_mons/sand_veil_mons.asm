; List of all Pokemon that when in sandstorm
; increase evasion by 1 stage

Sandveil:
	cp GARCHOMP
	call z, IncrementC
	cp GLIGAR
	call z, IncrementC
	cp GLISCOR
	call z, IncrementC
	ret

IncrementC:
	inc c
	ret
