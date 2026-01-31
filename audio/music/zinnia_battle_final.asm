Music_ZinniaBattle:
	musicheader 4, 1, Music_ZinniaBattle_Ch1
	musicheader 1, 2, Music_ZinniaBattle_Ch2
	musicheader 1, 3, Music_ZinniaBattle_Ch3
	musicheader 1, 4, Music_ZinniaBattle_Ch4

Music_ZinniaBattle_Ch1:
	volume $77
	tone $0000
	dutycycle $1
	notetype 12, $a7
	tempo 107
;Bar 1
	octave 3
	callchannel Music_ZinniaBattle_Ch1_Intro1
	;continue octave 3
	octave 3
	note C#, 2
	notetype 8, $97
	note D_, 1
	note E_, 1
	note F#, 1
	notetype 12, $88
;Bar 2
	vibrato $08, $14
	note G#, 16
	vibrato 0, 0
;Bar 3
	intensity $95
	dutycycle $3
	octave 2
	callchannel Music_ZinniaBattle_Ch1_Type1
;Bar 4
	callchannel Music_ZinniaBattle_Ch1_Type2
;Bar 5
	callchannel Music_ZinniaBattle_Ch1_Type3
;Bar 6
	callchannel Music_ZinniaBattle_Ch1_Type2
;Bar 7
	callchannel Music_ZinniaBattle_Ch1_Type1
;Bar 8
	callchannel Music_ZinniaBattle_Ch1_Type2
;Bar 9
	callchannel Music_ZinniaBattle_Ch1_Type3
;Bar 10
	callchannel Music_ZinniaBattle_Ch1_Type2
;Bar 11
Music_ZinniaBattle_Ch1_loop:
	intensity $95
	callchannel Music_ZinniaBattle_Ch1_Type1
;Bar 12
	callchannel Music_ZinniaBattle_Ch1_Type2
;Bar 13
	callchannel Music_ZinniaBattle_Ch1_Type3
;Bar 14
	callchannel Music_ZinniaBattle_Ch1_Type2
;Bar 15
	callchannel Music_ZinniaBattle_Ch1_Type3
;Bar 16
	callchannel Music_ZinniaBattle_Ch1_Type2
;Bar 17
	callchannel Music_ZinniaBattle_Ch1_Type3
;Bar 18
	callchannel Music_ZinniaBattle_Ch1_Type2
;Bar 19
	callchannel Music_ZinniaBattle_Ch1_Type4
;Bar 20
;Bar 21
	callchannel Music_ZinniaBattle_Ch1_Type4
;Bar 22
;Bar 23
	callchannel Music_ZinniaBattle_Ch1_Type4
;Bar 24
;Bar 25
	callchannel Music_ZinniaBattle_Ch1_Type4
;Bar 26
;Bar 27
	callchannel Music_ZinniaBattle_Ch1_Type4
;Bar 28
;Bar 29
	callchannel Music_ZinniaBattle_Ch1_Type4
;Bar 30
;Bar 31
	callchannel Music_ZinniaBattle_Ch1_Type4
;Bar 32
;Bar 33
	callchannel Music_ZinniaBattle_Ch1_Type4
;Bar 34
;Bar 35
	callchannel Music_ZinniaBattle_Ch1_Type4
;Bar 36
;Bar 37
	callchannel Music_ZinniaBattle_Ch1_Type4
;Bar 38
;Bar 39
	callchannel Music_ZinniaBattle_Ch1_Type4
;Bar 40
;Bar 41
	octave 2
	callchannel Music_ZinniaBattle_Ch1_Type6
;Bar 42
	callchannel Music_ZinniaBattle_Ch1_Type6
;Bar 43
	intensity $88
	note D_, 16
;Bar 44
	note E_, 16
;Bar 45
	note F#, 16
;Bar 46
	note G_, 16
;Bar 47
	note D_, 8
	note F#, 8
;Bar 48
	octave 1
	note B_, 8
	note G#, 8
;Bar 49
	note B_, 8
	note B_, 8
	intensity $a5
;Bar 50
Music_ZinniaBattle_Ch1_Bar50:
	note G#, 4
	loopchannel 4, Music_ZinniaBattle_Ch1_Bar50
;Bar 51
	octave 2
	callchannel Music_ZinniaBattle_Ch1_Type6
;Bar 52
	callchannel Music_ZinniaBattle_Ch1_Type7
;Bar 53
	callchannel Music_ZinniaBattle_Ch1_Type8
;Bar 54
	note F#, 4
	note G_, 4
	note G_, 4
	note G_, 4
;Bar 55
	callchannel Music_ZinniaBattle_Ch1_Type6
;Bar 56
	callchannel Music_ZinniaBattle_Ch1_Type9
;Bar 57
	octave 1
Music_ZinniaBattle_Ch1_Bar57:
	note B_, 4
	loopchannel 4, Music_ZinniaBattle_Ch1_Bar57
;Bar 58
	octave 2
	callchannel Music_ZinniaBattle_Ch1_Type9
;Bar 59
	callchannel Music_ZinniaBattle_Ch1_Type6
;Bar 60
	callchannel Music_ZinniaBattle_Ch1_Type7
;Bar 61
	callchannel Music_ZinniaBattle_Ch1_Type8
;Bar 62
	callchannel Music_ZinniaBattle_Ch1_Type8
;Bar 63
Music_ZinniaBattle_Ch1_Bar63:
	note F#, 2
	loopchannel 16, Music_ZinniaBattle_Ch1_Bar63
;Bar 65
	octave 2
	intensity $a5
	callchannel Music_ZinniaBattle_Ch1_Type1
;Bar 66
	callchannel Music_ZinniaBattle_Ch1_Type2
;Bar 67
	callchannel Music_ZinniaBattle_Ch1_Type3
;Bar 68
	callchannel Music_ZinniaBattle_Ch1_Type2
;Bar 69
	callchannel Music_ZinniaBattle_Ch1_Type1
;Bar 70
	callchannel Music_ZinniaBattle_Ch1_Type2
	loopchannel 0, Music_ZinniaBattle_Ch1_loop

Music_ZinniaBattle_Ch1_Type1:
	note C#, 2;
	note E_, 2
	note B_, 2
	note A_, 2
	note G#, 2
	note A_, 2
	note G#, 2
	note C#, 4
	endchannel

Music_ZinniaBattle_Ch1_Type2:
	note C#, 2;
	note F#, 2
	note B_, 2
	note A_, 1
	note G#, 1
	note F#, 2
	note G#, 2
	note E_, 2
	endchannel

Music_ZinniaBattle_Ch1_Type3:
	note C#, 2;
	note E_, 2
	note B_, 2
	note A_, 2
	note G#, 2
	note A_, 2
	note F#, 2
	note C#, 4
	endchannel

Music_ZinniaBattle_Ch1_Type4:
	note D_, 2;
	note F_, 2
	octave 3
	note C_, 2
	octave 2
	note A#, 2
	note A_, 2
	note A#, 2
	note G_, 2
	note D_, 4
;Bar 20
	note D_, 2;
	note G_, 2
	octave 3
	note C_, 2
	octave 2
	note A#, 1
	note A_, 1
	note G_, 2
	note A_, 2
	note F_, 2
	endchannel

Music_ZinniaBattle_Ch1_Intro1:
	note G#, 1;
	note B_, 1
	note A_, 1
	note G#, 1
	note F_, 1
	note G#, 1
	note D#, 1
	note D_, 1
	note C#, 1
	note F#, 1
	note E_, 1
	note D_, 1
	endchannel

Music_ZinniaBattle_Ch1_Type6:
	note D_, 4
	loopchannel 4, Music_ZinniaBattle_Ch1_Type6
	endchannel

Music_ZinniaBattle_Ch1_Type7:
	note E_, 4
	loopchannel 4, Music_ZinniaBattle_Ch1_Type7
	endchannel

Music_ZinniaBattle_Ch1_Type8:
	note F#, 4
	loopchannel 4, Music_ZinniaBattle_Ch1_Type8
	endchannel

Music_ZinniaBattle_Ch1_Type9:
	note C#, 4
	loopchannel 4, Music_ZinniaBattle_Ch1_Type9
	endchannel

; ============================================================================================================

Music_ZinniaBattle_Ch2:
	dutycycle $1
	notetype 12, $97
;Bar 1
	octave 4
	callchannel Music_ZinniaBattle_Ch1_Intro1
	note C#, 1
	note E_, 1
	note D#, 1
	note C#, 1
;Bar 2
	octave 3
	note B_, 1
	octave 4
	note D_, 1
	note C#, 1
	octave 3
	note B_, 1
	note A_, 1
	octave 4
	note C#, 1
	octave 3
	note B_, 1
	note A_, 1
	note G#, 1
	note B_, 1
	note A_, 1
	note G#, 1
	note F#, 1
	note A_, 1
	note G#, 1
	note E_, 1
;Bar 3
	intensity $78
	vibrato $00, $44
Music_ZinniaBattle_Ch2_Bar4_5:
	note F#, 16
;Bar 4
	note E_, 16
	loopchannel 3, Music_ZinniaBattle_Ch2_Bar4_5
;Bar 9
	note F#, 16
;Bar 10
	note E_, 12
Music_ZinniaBattle_Ch2_loop:
	tone $0001
	dutycycle $1
	octave 2
	intensity $c7
	note B_, 2
	octave 3
	notetype 8, $c7
	note C#, 1
	note D_, 1
	note E_, 1
	notetype 12, $c7
;Bar 11
	octave 4
	intensity $67
	vibrato $00, $14
	callchannel Music_ZinniaBattle_Ch2_Type1
;Bar 12
	callchannel Music_ZinniaBattle_Ch2_Type2
;Bar 13
	callchannel Music_ZinniaBattle_Ch2_Type1
;Bar 14
	callchannel Music_ZinniaBattle_Ch2_Type2
;Bar 15
	callchannel Music_ZinniaBattle_Ch2_Type1
;Bar 16
	callchannel Music_ZinniaBattle_Ch2_Type2
;Bar 17
	callchannel Music_ZinniaBattle_Ch2_Type1
;Bar 18
	callchannel Music_ZinniaBattle_Ch2_Type2
;Bar 19
	callchannel Music_ZinniaBattle_Ch2_Type4
;Bar 20
	callchannel Music_ZinniaBattle_Ch2_Type5
;Bar 21
	callchannel Music_ZinniaBattle_Ch2_Type4
;Bar 22
	callchannel Music_ZinniaBattle_Ch2_Type5
;Bar 23
	callchannel Music_ZinniaBattle_Ch2_Type4
;Bar 24
	callchannel Music_ZinniaBattle_Ch2_Type5
;Bar 25
	callchannel Music_ZinniaBattle_Ch2_Type4
;Bar 26
	note F_, 2;
	note __, 4
	note E_, 2
	note __, 2
	note D#, 2
	note G_, 1
	note A_, 1
;Bar 27
	octave 3
	callchannel Music_ZinniaBattle_Ch2_Type6
;Bar 28
	callchannel Music_ZinniaBattle_Ch2_Type7
;Bar 29
	callchannel Music_ZinniaBattle_Ch2_Type6
;Bar 30
	callchannel Music_ZinniaBattle_Ch2_Type7
;Bar 31
	callchannel Music_ZinniaBattle_Ch2_Type6
;Bar 32
	callchannel Music_ZinniaBattle_Ch2_Type7
;Bar 33
	callchannel Music_ZinniaBattle_Ch2_Type6
;Bar 34
	callchannel Music_ZinniaBattle_Ch2_Type7
;Bar 35
	callchannel Music_ZinniaBattle_Ch2_Type8
;Bar 36
	callchannel Music_ZinniaBattle_Ch2_Type9
;Bar 37
	callchannel Music_ZinniaBattle_Ch2_Type8
;Bar 38
	callchannel Music_ZinniaBattle_Ch2_Type9
;Bar 39
	callchannel Music_ZinniaBattle_Ch2_Type8
;Bar 40
	note D#, 2
	note __, 4
	note D#, 2
	note __, 2
	note D#, 4
;Bar 41
	note F#, 2
	note __, 4
	note G_, 2
	note __, 4
	note G_, 2
	note __, 4
;Bar 42
	note F#, 2
	note __, 4
	note F#, 2
	note __, 2
	note F#, 4
;Bar 43
	intensity $78
	tone $0000
	note D_, 16
;Bar 44
	note E_, 16
;Bar 45
	note C#, 16
;Bar 46
	octave 2
	note B_, 16
;Bar 47
	octave 3
	note F#, 16
;Bar 48
	note E_, 8
	note C#, 8
;Bar 49
	note D_, 8
	note E_, 4
	note F#, 4
;Bar 50
	note A_, 6
	note G#, 10
	intensity $95
;Bar 51
	callchannel Music_ZinniaBattle_Ch2_Type6
;Bar 52
	callchannel Music_ZinniaBattle_Ch2_Type10
;Bar 53
	callchannel Music_ZinniaBattle_Ch2_Type1
;Bar 54
	note G_, 2
	note __, 4
	note G_, 2
	note __, 2
	note G_, 2
	note __, 2
;Bar 55
	callchannel Music_ZinniaBattle_Ch2_Type1
;Bar 56
	callchannel Music_ZinniaBattle_Ch2_Type10
;Bar 57
	callchannel Music_ZinniaBattle_Ch2_Type6
;Bar 58
	callchannel Music_ZinniaBattle_Ch2_Type10
;Bar 59
	callchannel Music_ZinniaBattle_Ch2_Type11
;Bar 60
	note G#, 2
	note __, 4
	note G#, 2
	note __, 2
	note G#, 2
	note __, 2
;Bar 61
	callchannel Music_ZinniaBattle_Ch2_Type11
;Bar 62
	callchannel Music_ZinniaBattle_Ch2_Type12
;Bar 63
	callchannel Music_ZinniaBattle_Ch2_Type11
;Bar 64
	callchannel Music_ZinniaBattle_Ch2_Type12
;Bar 65
	intensity $87
	octave 1
Music_ZinniaBattle_Ch2_Bar65:
	note F#, 6
	note F#, 6
	note F#, 6
;Bar 66
	note F#, 6
	note F#, 4
	note F#, 4
	loopchannel 2, Music_ZinniaBattle_Ch2_Bar65
;Bar 69
	note F#, 6
	note F#, 6
	note F#, 6
;Bar 70
	note F#, 6
	note F#, 4
	loopchannel 0, Music_ZinniaBattle_Ch2_loop

Music_ZinniaBattle_Ch2_Type1:
	note C#, 2;
	note __, 4
	note C#, 2
	note __, 4
	note C#, 2
	note __, 4
	endchannel

Music_ZinniaBattle_Ch2_Type2:
	note E_, 2;
	note __, 4
	note D#, 2
	note __, 2
	note D_, 4
	endchannel

Music_ZinniaBattle_Ch2_Type4:
	note D_, 2;
	note __, 4
	note D_, 2
	note __, 4
	note D_, 2
	note __, 4
	endchannel

Music_ZinniaBattle_Ch2_Type5:
	note F_, 2;
	note __, 4
	note E_, 2
	note __, 2
	note D#, 4
	endchannel

Music_ZinniaBattle_Ch2_Type6:
	note D_, 2;
	note __, 4
	note D_, 2
	note __, 4
	note D_, 2
	note __, 4
	endchannel


Music_ZinniaBattle_Ch2_Type7:
	note F_, 2;
	note __, 4
	note E_, 2
	note __, 2
	note D#, 4
	endchannel

Music_ZinniaBattle_Ch2_Type8:
	note D#, 2;
	note __, 4
	note D#, 2
	note __, 4
	note D#, 2
	note __, 4
	endchannel

Music_ZinniaBattle_Ch2_Type9:
	note D#, 2;
	note __, 4
	note D#, 2
	note __, 2
	note F_, 4
	endchannel

Music_ZinniaBattle_Ch2_Type10:
	note E_, 2;
	note __, 4
	note E_, 2
	note __, 2
	note E_, 2
	note __, 2
	endchannel
	
Music_ZinniaBattle_Ch2_Type11:
	note F#, 2;
	note __, 4
	loopchannel 3, Music_ZinniaBattle_Ch2_Type11
	endchannel
	
Music_ZinniaBattle_Ch2_Type12:
	note F#, 2
	note __, 4
	note F#, 2
	note __, 2
	note F#, 2
	note __, 2
	endchannel

; ============================================================================================================

Music_ZinniaBattle_Ch3:
	notetype 12, $25
	vibrato $08, $14
;Bar 1
	note __, 12
	octave 4
	note F#, 2
	notetype 8, $25
	note G#, 1
	note A_, 1
	note B_, 1
	notetype 12, $25
;Bar 2
	octave 5
	vibrato $08, $14
	note C#, 16
	vibrato 0, 0
;Bar 3
	octave 5
	vibrato $00, $12
	intensity $26
	note F#, 14
	note F_, 1
	note F#, 1
;Bar 4
	note G#, 14
	note F#, 1
	note G#, 1
;Bar 5
	note A_, 14
	note G#, 1
	note A_, 1
;Bar 6
	note B_, 16
;Bar 7
	vibrato $08, $14
	intensity $25
	note C#, 12
	note E_, 4
;Bar 8
	note C#, 12
	note G#, 4
;Bar 9
	note A_, 14
	note E_, 1
	note F#, 1
;Bar 10
	note B_, 8
	octave 6
	note C#, 8
Music_ZinniaBattle_Ch3_loop:
	intensity $14
	octave 4
;Bar 11
	pitchoffset 1, B_
	callchannel Music_ZinniaBattle_Ch3_main
	pitchoffset 0, C_
;Bar 18
	note __, 4
	note C_, 2
	notetype 8, $14
	note D_, 1
	note E_, 1
	note F#, 1
	notetype 12, $14
;Bar 19
	callchannel Music_ZinniaBattle_Ch3_main
;Bar 26
	note __, 8
;Bar 27
	intensity $16
	octave 5
	note A#, 16
;Bar 28
	note A_, 8
	octave 6
	note C_, 8
;Bar 29
	octave 5
	note B_, 8
	note E_, 8
;Bar 30
	note D#, 8
	note G#, 8
;Bar 31
	note G_, 14
	note F_, 1
	note D#, 1
;Bar 32
	note D_, 8
	notetype 8, $16
	note F_, 10
	note E_, 1
	note D#, 1
	notetype 12, $16
;Bar 33
	note D_, 16
	note D_, 11
;Bar 34
	note __, 3
	note G_, 1
	note A_, 1
;Bar 35
	note A#, 16
;Bar 36
	note A_, 8
	note A#, 4
	octave 6
	note C_, 4
;Bar 37
	octave 5
	note A_, 1
	note A#, 13
	note A_, 1
	note G_, 1
;Bar 38
	note D#, 16
;Bar 39
	note D_, 1
	note D#, 15
;Bar 40
	notetype 8, $16
	note C_, 2
	note G_, 2
	note C_, 2
	note D_, 2
	note G_, 2
	note D_, 2
	note D#, 2
	note C_, 2
	note D_, 2
	note D#, 2
	note F_, 2
	note G_, 2
	notetype 12, $16
;Bar 41
	note A#, 14
	octave 6
	note C_, 1
	octave 5
	note A#, 1
;Bar 42
	note A_, 12
	note D_, 4
;Bar 43
	note F#, 14
	note E_, 1
	note F#, 1
;Bar 44
	notetype 8, $16
	note G#, 2
	note C#, 2
	note G#, 2
	note A_, 2
	note C#, 2
	note A_, 2
	note B_, 2
	note C#, 2
	note B_, 2
	octave 6
	note E_, 2
	octave 5
	note E_, 2
	note D_, 2
	notetype 12, $16
;Bar 45
	note E_, 14
	note D_, 1
	note C#, 1
;Bar 46
	note D_, 16
;Bar 47
	note F#, 16
;Bar 48
	note E_, 8
	note C#, 8
;Bar 49
	note D_, 8
	octave 4
	note A_, 1
	octave 5
	note D_, 1
	note E_, 1
	note F#, 1
	note D_, 1
	note F#, 1
	note D_, 1
	octave 4
	note B_, 1
;Bar 50
	octave 5
	note C#, 12
	octave 4
	intensity $14
	note A_, 1
	octave 5
	note C#, 1
	note D_, 1
	note E_, 1
;Bar 51
	note F#, 12
	note A_, 4
;Bar 52
	note G#, 6
	note E_, 6
	note F#, 4
;Bar 53
	note C#, 12
	octave 4
	note B_, 4
;Bar 54
	octave 5
	note C#, 8
	octave 4
	note B_, 6
	octave 5
	note C#, 1
	octave 4
	note B_, 1
;Bar 55
	note F#, 12
	octave 5
	note C#, 4
;Bar 56
	octave 4
	note B_, 6
	note A_, 6
	note G#, 4
;Bar 57
	note F#, 12
	octave 5
	note C#, 4
;Bar 58
	octave 4
	note B_, 4
	octave 5
	note C#, 4
	note D_, 4
	note E_, 4
;Bar 59
	note F#, 12
	note A_, 4
;Bar 60
	note G#, 4
	note E_, 4
	note C#, 4
	note F#, 1
	note G#, 3
;Bar 61
	note F#, 16
	note F#, 14
;Bar 62
	note __, 4
;Bar 63
	octave 4
	note A_, 1
	note __, 1
	note B_, 1
	note __, 1
	note A_, 1
	note __, 1
	note G#, 2
	note A_, 1
	note __, 1
	note G#, 1
	note __, 1
	note E_, 2
;Bar 64
	note F#, 1
	note __, 1
	note A_, 2
	note G#, 1
	note __, 1
	note E_, 1
	note __, 1
	note F#, 1
	note __, 1
	note E_, 1
	note __, 1
	note C#, 4
;Bar 65
	note __, 2
	note C#, 1
	note __, 1
	note E_, 1
	note __, 1
	note F#, 1
	note __, 1
	note A_, 2
	note G_, 1
	note __, 3
	note F#, 1
	note __, 1
;Bar 66
	note E_, 1
	note __, 1
	note G_, 1
	note __, 1
	note F#, 1
	note __, 1
	note E_, 1
	note __, 1
	note F#, 1
	note __, 1
	note F#, 1
	note __, 1
	note E_, 4
;Bar 67
	callchannel Music_ZinniaBattle_Ch3_Bar67
;Bar 68
	note E_, 1
	note __, 1
	note G_, 1
	note __, 1
	note F#, 1
	note __, 1
	note E_, 1
	note __, 1
	note F#, 1
	note __, 1
	note B_, 1
	note __, 1
	note E_, 4
;Bar 69
	callchannel Music_ZinniaBattle_Ch3_Bar67
;Bar 70
	note F#, 1
	note __, 1
	note A_, 1
	note __, 1
	note G#, 1
	note __, 1
	note E_, 1
	note __, 1
	note F#, 1
	note __, 1
	note E_, 1
	note __, 5
	loopchannel 0, Music_ZinniaBattle_Ch3_loop

Music_ZinniaBattle_Ch3_main:
;Bar 19
	note G_, 16
	note G_, 1
;Bar 20
	note __, 1
	note A_, 6
	note A#, 4
	octave 5
	notetype 8, $14
	note F_, 4
	note E_, 1
	note D#, 1
	notetype 12, $14
;Bar 21
	note D_, 16
	note D_, 1
;Bar 22
	note __, 1
	note C_, 1
	note __, 1
	note D_, 1
	note __, 1
	note C_, 1
	note __, 1
	octave 4
	note A#, 2
	octave 5
	note C_, 1
	note __, 1
	octave 4
	note A#, 1
	note __, 1
	note A_, 1
	note __, 1
;Bar 23
	note G_, 16
	note G_, 1
;Bar 24
	note __, 1
	note A_, 6
	note G_, 4
	note F_, 4
;Bar 25
	note D_, 16
	note D_, 8
	endchannel

Music_ZinniaBattle_Ch3_Bar67:
	note __, 2;
	note C#, 1
	note __, 1
	note E_, 1
	note __, 1
	note F#, 1
	note __, 1
	note A_, 3
	note G_, 1
	note __, 2
	note F#, 1
	note __, 1
	endchannel

; ============================================================================================================

Music_ZinniaBattle_Ch4:
	togglenoise 3
	notetype 12
;Bar 1
	note B_, 8
	note A#, 8
;Bar 2
	note B_, 4
	note A#, 4
	note A#, 2
	note A#, 2
	note D_, 1
	note D_, 1
	note D_, 1
	note D_, 1
;Bar 3
	note A#, 4
	note __, 16
	note __, 16
	note __, 16
	note __, 12
;Bar 7
	callchannel Music_ZinniaBattle_Ch4_Bar7
;Bar 8
	callchannel Music_ZinniaBattle_Ch4_Bar14
;Bar 9
	callchannel Music_ZinniaBattle_Ch4_Bar7
;Bar 10
	callchannel Music_ZinniaBattle_Ch4_Bar10
Music_ZinniaBattle_Ch4_loop:
;Bar 11
	callchannel Music_ZinniaBattle_Ch4_Bar11
;Bar 12
	callchannel Music_ZinniaBattle_Ch4_Bar12
;Bar 13
	callchannel Music_ZinniaBattle_Ch4_Bar7
;Bar 14
	callchannel Music_ZinniaBattle_Ch4_Bar14
;Bar 15
	callchannel Music_ZinniaBattle_Ch4_Bar7
;Bar 16
	callchannel Music_ZinniaBattle_Ch4_Bar12
;Bar 17
	callchannel Music_ZinniaBattle_Ch4_Bar7
;Bar 18
	note A#, 2;
	note C_, 4
	callchannel Music_ZinniaBattle_Ch4_Type1
;Bar 19
	callchannel Music_ZinniaBattle_Ch4_Bar11
;Bar 20
	callchannel Music_ZinniaBattle_Ch4_Bar12
;Bar 21
	callchannel Music_ZinniaBattle_Ch4_Bar7
;Bar 22
	callchannel Music_ZinniaBattle_Ch4_Bar14
;Bar 23
	callchannel Music_ZinniaBattle_Ch4_Bar7
;Bar 24
	callchannel Music_ZinniaBattle_Ch4_Bar12
;Bar 25
	callchannel Music_ZinniaBattle_Ch4_Bar7
;Bar 26
	callchannel Music_ZinniaBattle_Ch4_Bar10
;Bar 27
	callchannel Music_ZinniaBattle_Ch4_Bar11
;Bar 28
	callchannel Music_ZinniaBattle_Ch4_Bar12
;Bar 29
	callchannel Music_ZinniaBattle_Ch4_Bar7
;Bar 30
	callchannel Music_ZinniaBattle_Ch4_Bar12
;Bar 31
	callchannel Music_ZinniaBattle_Ch4_Bar7
;Bar 32
	callchannel Music_ZinniaBattle_Ch4_Bar12
;Bar 33
	callchannel Music_ZinniaBattle_Ch4_Bar7
;Bar 34
	callchannel Music_ZinniaBattle_Ch4_Bar12
;Bar 35
	callchannel Music_ZinniaBattle_Ch4_Bar11
;Bar 36
	callchannel Music_ZinniaBattle_Ch4_Bar12
;Bar 37
	callchannel Music_ZinniaBattle_Ch4_Bar7
;Bar 38
	callchannel Music_ZinniaBattle_Ch4_Bar12
;Bar 39
	callchannel Music_ZinniaBattle_Ch4_Bar7
;Bar 40
	callchannel Music_ZinniaBattle_Ch4_Bar12
;Bar 41
	callchannel Music_ZinniaBattle_Ch4_Bar7
;Bar 42
	note A#, 2;
	note C_, 4
	callchannel Music_ZinniaBattle_Ch4_Type1
;Bar 43
	note B_, 16
;Bar 44
	note __, 16
;Bar 45
Music_ZinniaBattle_Ch4_Bar45:
	note A#, 4
	note __, 16
	note __, 8
;Bar 46
	note A#, 4
	loopchannel 2, Music_ZinniaBattle_Ch4_Bar45
;Bar 49
	note A#, 8
	note A#, 8
;Bar 50
	note A#, 4
	note A#, 4
	callchannel Music_ZinniaBattle_Ch4_Type1
;Bar 51
	callchannel Music_ZinniaBattle_Ch4_Bar11
;Bar 52
	callchannel Music_ZinniaBattle_Ch4_Bar12
;Bar 53
	callchannel Music_ZinniaBattle_Ch4_Bar7
;Bar 54
	callchannel Music_ZinniaBattle_Ch4_Bar12
;Bar 55
	callchannel Music_ZinniaBattle_Ch4_Bar11
;Bar 56
	callchannel Music_ZinniaBattle_Ch4_Bar12
;Bar 57
	callchannel Music_ZinniaBattle_Ch4_Bar11
;Bar 58
	callchannel Music_ZinniaBattle_Ch4_Bar12
;Bar 59
	callchannel Music_ZinniaBattle_Ch4_Bar11
;Bar 60
	note A#, 2
	note C_, 4
	note A#, 4
	note D_, 4
;Bar 61
	callchannel Music_ZinniaBattle_Ch4_Bar11
;Bar 62
	callchannel Music_ZinniaBattle_Ch4_Bar12
;Bar 63
	callchannel Music_ZinniaBattle_Ch4_Bar7
;Bar 64
	callchannel Music_ZinniaBattle_Ch4_Bar12
;Bar 65
	callchannel Music_ZinniaBattle_Ch4_Bar7
;Bar 66
	callchannel Music_ZinniaBattle_Ch4_Bar12
;Bar 67
	callchannel Music_ZinniaBattle_Ch4_Bar7
;Bar 68
	callchannel Music_ZinniaBattle_Ch4_Bar12
;Bar 69
	callchannel Music_ZinniaBattle_Ch4_Bar7
;Bar 70
	note A#, 2;
	note C_, 4
	callchannel Music_ZinniaBattle_Ch4_Type1
	loopchannel 0, Music_ZinniaBattle_Ch4_loop

Music_ZinniaBattle_Ch4_Bar7:
	note A#, 4;
	note C_, 2
	note A#, 6
	note C_, 6
	endchannel

Music_ZinniaBattle_Ch4_Bar10:
	note A#, 2;
	note C_, 4
	note A#, 2
	note A#, 2
	note C_, 1
	note C_, 1
	note C_, 1
	note C_, 1
	endchannel

Music_ZinniaBattle_Ch4_Bar11:
	note B_, 4;
	note C_, 2
	note A#, 6
	note C_, 6
	endchannel

Music_ZinniaBattle_Ch4_Bar12:
	note A#, 2;
	note C_, 4
	note A#, 4
	note C_, 4
	endchannel

Music_ZinniaBattle_Ch4_Bar14:
	note A#, 2;
	note C_, 4
	note A#, 4
	note C_, 2
	note A#, 2
	endchannel

Music_ZinniaBattle_Ch4_Type1:
	note C_, 1
	loopchannel 8, Music_ZinniaBattle_Ch4_Type1
	endchannel