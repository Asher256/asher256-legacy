'###########################################################################
'#                          FM-Lib Version 1.5
'#                      Par Asher256, 2001-2002
'#
'# DerniŠre Mise … jour: Mai 2002
'# Email: 
'#
'# Librairie FM-LIB jouer les fichiers *.fms  dans vos jeux vid‚os QBasic.
'# Pour l'utiliser c'est simple, faites "Fichier --> Nouveau" puis
'# "Fichier --> Fusionner".
'# AprŠs cela choisissez le fichier source de la librairie pour le fusionner avec
'# votre programme en mettant toutes les SUB'S dans votre programme et
'# utiliser FM-LIB reportez Vous … la documentation "fmlib_fr.doc" pour
'# en savoir plus...
'#
'# Pour t‚l‚charger le derniere version de FM-Lib allez sur le site
'# officiel: https://qbworld.asher256.com/fmsong.php
'#
'#                                                      - Asher256 -
'############################################################################

REM $INCLUDE: 'fmlib.bi'

a% = fmsonginit
IF a% THEN PRINT "Erreur de chargement de FmLib...": END

'------------------[ VOTRE PROGRAMME ICI ]--------------------------

a% = loadfms("karia.fms")
playfms
DO: loopfms: LOOP UNTIL INKEY$ = CHR$(27)
stopfms
fmsongclose

REM $DYNAMIC
SUB clearins (buffer AS instrument)
	buffer.attack1 = 0
	buffer.attack2 = 0

	buffer.decay1 = 0
	buffer.decay2 = 0

	buffer.sustain1 = 0
	buffer.sustain2 = 0

	buffer.released1 = 0
	buffer.released2 = 0

	buffer.outp1 = 0
	buffer.outp2 = 0

	buffer.scalling1 = 0
	buffer.scalling2 = 0

	buffer.amplitudevibrato1 = 0
	buffer.amplitudevibrato2 = 0

	'buffer.levelscalling1 = 0
	'buffer.levelscalling2 = 0

	buffer.pitchvibrato1 = 0
	buffer.pitchvibrato2 = 0

	buffer.frequencymultipler1 = 0
	buffer.frequencymultipler2 = 0

	buffer.enveloppescalling1 = 0
	buffer.enveloppescalling2 = 0

	buffer.waveselect1 = 0
	buffer.waveselect2 = 0

	buffer.feedback = 0
	buffer.connection = 0

	buffer.sustaininglevel1 = 0
	buffer.sustaininglevel2 = 0
	buffer.iname = ""
END SUB

REM $STATIC
FUNCTION eofms
IF NOT ispause THEN eofms = -1: EXIT FUNCTION
IF loopnote = maxnotes(trackactuel + 1) - 1 AND trackactuel + 1 = maxtrack THEN eofms = -1
END FUNCTION

SUB fmsongclose
	stopfms         'Stoppe le fms en cours
	resetallchannel 'enleve tout les channels
	FOR n% = 0 TO 224: writereg n%, 0: NEXT n%
	baseport = 0
END SUB

FUNCTION fmsonginit
	'D‚tection du Sound Blaster
	DIM port, count, stat, detected  AS INTEGER
	FOR port = &H200 TO &H280 STEP &H10
		OUT port + &H6, 1
		FOR count = 1 TO 100
			OUT port + &H6, 0
			stat = INP(port + &HE)
			stat = INP(port + &HA)
		NEXT
		' Si d‚tect‚
		IF stat = &HAA THEN
			detected = -1
			baseport = port
			EXIT FOR
		END IF
	NEXT
    
	'D‚tection d'adlib
	 IF detected = 0 THEN
		 baseport = &H380
		 writereg 4, &H60
		 writereg 4, &H80
		 data1% = INP(&H388)
		 writereg 2, &HFF
		 writereg 4, &H21
		 FOR d% = 1 TO 150: x% = INP(&H388): NEXT d%
		 data2% = INP(&H388)
		 writereg 4, &H60
		 writereg 4, &H80
		 IF (data1% AND &HE0) = 0 AND (data2% AND &HE0) = &HC0 THEN
			detectfm% = -1
			baseport = &H380  'il met le port de base
		 END IF
		 IF NOT detectfm% THEN
			fmsonginit = -1: baseport = 0: EXIT FUNCTION
		 END IF
	 END IF

	'initialisation du FM
	 FOR n% = 0 TO &HF5: writereg n%, 0: NEXT n%
      
'--------------{ Nouveau }-----------------------
FOR i = 1 TO 8: clearins ins(i): NEXT
FOR j = 0 TO maxnotes(1) - 1
	FOR k = 1 TO 8: setvaleur 1, k, j, 0, 0, 0: NEXT
NEXT
pname = ""
commentaire = ""
auteur = ""

'maxtrack = 1
resizetrack 1

trackactuel = 0
position = 0
positioncurseur = 0
editactuel = 0


END FUNCTION

'###############################################################
' Retourne le maximum de notes de la musique actuelle
'###############################################################
FUNCTION getmaxnotes
	FOR i = 1 TO maxtrack: maxn = maxn + maxnotes(i): NEXT
	getmaxnotes = maxn
END FUNCTION

FUNCTION getnote (track, chan, num AS INTEGER)
	offs = VARPTR(notes(track, chan, num))
	DEF SEG = VARSEG(notes(track, chan, 1))
		getnote = PEEK(offs)
	DEF SEG
END FUNCTION

SUB getnoteinfo (track, chan, num, diese, octave, note)
	var = getnote(track, chan, num)
	octave = (var AND 56) / 8
	note = var AND 7
	diese = (var AND 64) / 64
	no = (var AND 128) / 128
	IF no = 1 THEN note = -1
END SUB

FUNCTION getpositionnote

FOR i = 1 TO trackactuel + 1 - 1        'on enlŠve 1 parceque c'est loop note
	maxs = maxs + maxnotes(i)
NEXT
maxs = maxs + loopnote + 1
getpositionnote = maxs

END FUNCTION

FUNCTION loadfms (a$)

stopfms
f$ = a$
IF INSTR(a$, ".") = 0 THEN f$ = f$ + ".fms"

'--------------{ Nouveau }-----------------------
FOR i = 1 TO 8: clearins ins(i): NEXT
FOR j = 0 TO maxnotes(1) - 1
	FOR k = 1 TO 8: setvaleur 1, k, j, 0, 0, 0: NEXT
NEXT
pname = ""
commentaire = ""
auteur = ""

'maxtrack = 1
resizetrack 1

trackactuel = 0
position = 0
positioncurseur = 0
editactuel = 0
'--------------------------------------------------


filenum = FREEFILE

OPEN f$ FOR BINARY AS filenum
IF LOF(1) = 0 THEN loadfms = -1: CLOSE filenum: KILL f$: EXIT FUNCTION

'l'entˆte
SEEK filenum, 1
var$ = "               "
GET filenum, , var$
IF var$ <> "fm-song-project" THEN loadfms = -1: PCOPY 2, 1: CLOSE filenum: EXIT FUNCTION


'l'auteur
GET filenum, , pname$
GET filenum, , auteur
GET filenum, , commentaire
GET filenum, , maxtrack

resizetrack maxtrack

'les instruments
FOR k = 1 TO 8        'les channels
	GET filenum, , ins(k).iname
	i1$ = " "
	i2$ = " "
	GET filenum, , i1$
	GET filenum, , i2$
		   ins(k).attack1 = ASC(i1$)
		   ins(k).attack2 = ASC(i2$)
	    
		   i1$ = " "
		   i2$ = " "
		   GET filenum, , i1$
		   GET filenum, , i2$
		   ins(k).decay1 = ASC(i1$)
		   ins(k).decay2 = ASC(i2$)
	   
		   i1$ = " "
		   i2$ = " "
		   GET filenum, , i1$
		   GET filenum, , i2$
		   ins(k).sustain1 = ASC(i1$)
		   ins(k).sustain2 = ASC(i2$)
	    
		   i1$ = " "
		   i2$ = " "
		   GET filenum, , i1$
		   GET filenum, , i2$
		   ins(k).released1 = ASC(i1$)
		   ins(k).released2 = ASC(i2$)
	    
	    
		   i1$ = " "
		   i2$ = " "
		   GET filenum, , i1$
		   GET filenum, , i2$
		   ins(k).outp1 = ASC(i1$)
		   ins(k).outp2 = ASC(i2$)
	    
	    
		   i1$ = " "
		   i2$ = " "
		   GET filenum, , i1$
		   GET filenum, , i2$
		   ins(k).scalling1 = ASC(i1$)
		   ins(k).scalling2 = ASC(i2$)

	    
	    
		   i1$ = " "
		   i2$ = " "
		   GET filenum, , i1$
		   GET filenum, , i2$
		   ins(k).amplitudevibrato1 = ASC(i1$)
		   ins(k).amplitudevibrato2 = ASC(i2$)

		   i1$ = " "
		   i2$ = " "
		   GET filenum, , i1$
		   GET filenum, , i2$
		   ins(k).pitchvibrato1 = ASC(i1$)
		   ins(k).pitchvibrato2 = ASC(i2$)
	    
		   i1$ = " "
		   i2$ = " "
		   GET filenum, , i1$
		   GET filenum, , i2$
		   ins(k).frequencymultipler1 = ASC(i1$)
		   ins(k).frequencymultipler2 = ASC(i2$)
	    
		   i1$ = " "
		   i2$ = " "
		   GET filenum, , i1$
		   GET filenum, , i2$
		   ins(k).enveloppescalling1 = ASC(i1$)
		   ins(k).enveloppescalling2 = ASC(i2$)
	    
		   i1$ = " "
		   i2$ = " "
		   GET filenum, , i1$
		   GET filenum, , i2$
		   ins(k).waveselect1 = ASC(i1$)
		   ins(k).waveselect2 = ASC(i2$)
	    
	    
		   i1$ = " "
		   i2$ = " "
		   GET filenum, , i1$
		   GET filenum, , i2$
		   ins(k).feedback = ASC(i1$)
		   ins(k).connection = ASC(i2$)
		  
		   i1$ = " "
		   i2$ = " "
		   GET filenum, , i1$
		   GET filenum, , i2$
		   ins(k).sustaininglevel1 = ASC(i1$)
		   ins(k).sustaininglevel2 = ASC(i2$)


'------- fin du chargement de l'instrument
NEXT



'la track
FOR i = 1 TO maxtrack
	GET filenum, , maxnotes(i)       'les max notes
	    'il put l'instrument
	GET filenum, , trackdelay(i)
	    'find de put instrument
    
	'put les channels dans le fichier
      
	FOR cn = 1 TO 8
		sc$ = " ": GET filenum, , sc$
		num = ASC(sc$)
		IF num = 1 THEN ch.enabled(i, cn) = -1
       
	NEXT
	
		FOR k = 1 TO 8
		   FOR j = 0 TO maxnotes(i) - 1     'les notes
			n1$ = " "
			GET filenum, , n1$
			notes(i, k, j) = ASC(n1$)
		   
		    NEXT
		NEXT
NEXT

CLOSE filenum
trackactuel = 0
FOR i = 1 TO 8
	channel = i
	sendinstrument ins(i)
	channel = i
	setinstrument
NEXT


fmssec! = trackdelay(1) / 20       'charge le seconde

maxno = getmaxnotes             'le maximum de notes
trackactuel = 0
loopnote = 0

END FUNCTION

SUB loopfms
	IF NOT isplay OR ispause THEN EXIT SUB
      
      '-------------------[ Sinon il joue la musique ]------------------
	IF TIMER - looptime! >= fmssec! THEN
       
			looptime! = TIMER
			IF loopnote = maxnotes(trackactuel + 1) - 1 THEN
				trackactuel = (trackactuel + 1) MOD maxtrack
				fmssec! = trackdelay(trackactuel + 1) / 20
				loopnote = -1
			END IF

		    
			loopnote = (loopnote + 1) MOD maxnotes(trackactuel + 1)

			'----- il joue la note dans les 8 channels
			FOR j = 1 TO 8
				IF NOT ch.enabled(trackactuel + 1, j) THEN
					getnoteinfo trackactuel + 1, j, loopnote, di, oc%, Freq%
					myplay j, Freq%, oc%, di
				END IF
			NEXT
     END IF
    '----------------------------------------------------------------

END SUB

SUB myplay (chan, Freq, oct, di)

IF Freq = 0 THEN EXIT SUB
's'il est disabled alors quitter la sub

SELECT CASE Freq
	CASE -1: e$ = "x"
	CASE 1: e$ = "c"
	CASE 2: e$ = "d"
	CASE 3: e$ = "e"
	CASE 4: e$ = "f"
	CASE 5: e$ = "g"
	CASE 6: e$ = "a"
	CASE 7: e$ = "b"
END SELECT
IF di = 1 AND e$ <> "x" THEN e$ = e$ + "#"

playnote chan, e$, oct

END SUB

SUB pausefms
      FOR i = 0 TO 7
	writereg &HA0 + i, 0
	writereg &HB0 + i, 0
      NEXT
      ispause = -1
END SUB

SUB playfms
     IF isplay <> -1 THEN
	loopnote = -1
	trackactuel = 0
	isplay = -1
	ispause = 0
     END IF
END SUB

SUB playnote (chan, note$, octave)

writereg &HA0 + chan - 1, 0
writereg &HB0 + chan - 1, 0

SELECT CASE LCASE$(note$)
	CASE "c": note% = 0
	CASE "c#": note% = 1
	CASE "d": note% = 2
	CASE "d#": note% = 3
	CASE "e": note% = 4
	CASE "f": note% = 5
	CASE "f#": note% = 6
	CASE "g": note% = 7
	CASE "g#": note% = 8
	CASE "a": note% = 9
	CASE "a#": note% = 10
	CASE "b": note% = 11
	CASE "x": EXIT SUB      'il stoppe le sustain

END SELECT

Octv% = octave
Freq% = notef(note% MOD 12)
writereg &HA0 + chan - 1, Freq% AND &HFF
writereg &HB0 + chan - 1, INT(Freq% / 256) OR 32 OR (Octv% * 4)

END SUB

SUB resetallchannel
FOR i = 1 TO 8
	resetchannel i
NEXT


END SUB

SUB resetchannel (chan)

SELECT CASE chan
	CASE 1:
		carplus = 0
		modplus = 3
	CASE 2:
		carplus = 1
		modplus = 4
	CASE 3:
		carplus = 2
		modplus = &H5
	CASE 4:
		carplus = 8
		modplus = &HB
	CASE 5:
		carplus = 9
		modplus = &HC
	CASE 6:
		carplus = 10
		modplus = &HD
	CASE 7:
		carplus = &H10
		modplus = &H13
	CASE 8:
		carplus = &H11
		modplus = &H14
	CASE 9:
		carplus = &H12
		modplus = &H15

END SELECT

r1 = &H20 + modplus       'le carrier
r2 = &H20 + carplus
r3 = &H40 + modplus
r4 = &H40 + carplus
r5 = &H60 + modplus
r6 = &H60 + carplus
r7 = &H80 + modplus
r8 = &H80 + carplus
r9 = 224 + carplus
r10 = 227 + carplus
r11 = 192 + chan - 1


writereg r1, 0
writereg r2, 0
writereg r3, 0
writereg r4, 0
writereg r5, 0
writereg r6, 0
writereg r7, 0
writereg r8, 0
writereg r9, 0
writereg r10, 0
writereg r11, 0


END SUB

REM $DYNAMIC
SUB resizetrack (max)
	REDIM notes(1 TO max, 1 TO 8, 0 TO lesnotes) AS INTEGER   ' les notes des channels
	REDIM maxnotes(1 TO max) AS INTEGER          'le max de notes dans chaque track
	REDIM trackdelay(1 TO max) AS INTEGER
	REDIM ch.enabled(1 TO max, 8) AS INTEGER

	FOR i = 1 TO max
		trackdelay(i) = 4
		maxnotes(i) = 64
	NEXT
	maxtrack = max
END SUB

REM $STATIC
SUB resumefms
	ispause = 0
END SUB

SUB sendinstrument (buffer AS instrument)
	attack(1) = buffer.attack1
	attack(2) = buffer.attack2

	decay(1) = buffer.decay1
	decay(2) = buffer.decay2

	sustain(1) = buffer.sustain1
	sustain(2) = buffer.sustain2

	released(1) = buffer.released1
	released(2) = buffer.released2

	outp(1) = buffer.outp1
	outp(2) = buffer.outp2

	scalling(1) = buffer.scalling1
	scalling(2) = buffer.scalling2

	amplitudevibrato(1) = buffer.amplitudevibrato1

	amplitudevibrato(2) = buffer.amplitudevibrato2

	pitchvibrato(1) = buffer.pitchvibrato1
	pitchvibrato(2) = buffer.pitchvibrato2

	frequencymultipler(1) = buffer.frequencymultipler1
	frequencymultipler(2) = buffer.frequencymultipler2


	enveloppescalling(1) = buffer.enveloppescalling1
	enveloppescalling(2) = buffer.enveloppescalling2

	waveselect(1) = buffer.waveselect1
	waveselect(2) = buffer.waveselect2

	feedback = buffer.feedback
	connection = buffer.connection

	sustaininglevel(1) = buffer.sustaininglevel1
	sustaininglevel(2) = buffer.sustaininglevel2
END SUB

SUB setinstrument
chan = channel
SELECT CASE chan
	CASE IS = 1
		carplus = 0
		modplus = 3
	CASE 2
		carplus = 1
		modplus = 4
     
	CASE 3
		carplus = 2
		modplus = &H5
     
	CASE 4
		carplus = 8
		modplus = &HB
     
	CASE 5
		carplus = 9
		modplus = &HC
     
	CASE 6
		carplus = 10
		modplus = &HD
     
	CASE 7
		carplus = &H10
		modplus = &H13
     
	CASE 8
		carplus = &H11
		modplus = &H14
     
	CASE 9
		carplus = &H12
		modplus = &H15

END SELECT


r1 = &H20 + carplus       'le carrier
r2 = &H20 + modplus
r3 = &H40 + carplus
r4 = &H40 + modplus
r5 = &H60 + carplus
r6 = &H60 + modplus
r7 = &H80 + carplus
r8 = &H80 + modplus

r9 = 224 + carplus
r10 = 227 + carplus
r11 = 192 + chan - 1

'-------LA VAR 1
IF pitchvibrato(1) = 1 THEN var1 = 128
IF amplitudevibrato(1) = 1 THEN var1 = var1 + 64
IF sustaininglevel(1) = 1 THEN var1 = var1 + 32
IF enveloppescalling(1) = 1 THEN var1 = var1 + 16
var1 = var1 + frequencymultipler(1)

'-------LA VAR 2
IF pitchvibrato(2) = 1 THEN var2 = 128
IF amplitudevibrato(2) = 1 THEN var2 = var2 + 64
IF sustaininglevel(2) = 1 THEN var2 = var2 + 32
IF enveloppescalling(2) = 1 THEN var2 = var2 + 16
var2 = var2 + frequencymultipler(2)

'-------LA VAR 3
var3 = (scalling(1) * 64) + outp(1)

'-------LA VAR 4
var4 = (scalling(2) * 64) + outp(2)

'------- La var 5
var5 = (attack(1) * 16) + decay(1)

'------- La var 5
var6 = (attack(2) * 16) + decay(2)

'--------La var 7
var7 = (sustain(1) * 16) + released(1)

'--------La var 8
var8 = (sustain(2) * 16) + released(2)

'--------La var 9
var9 = waveselect(1)

'--------La var 10
var10 = waveselect(2)

'--------La var 11
var11 = (feedback * 2) + connection

writereg r1, var1
writereg r2, var2
writereg r3, var3
writereg r4, var4
writereg r5, var5

writereg r6, var6
writereg r7, var7

writereg r8, var8

writereg r9, var9
writereg r10, var10
writereg r11, var11



END SUB

REM $DYNAMIC
SUB setnote (track AS INTEGER, chan AS INTEGER, num AS INTEGER, valeur AS INTEGER)

offs = VARPTR(notes(track, chan, num))
   
DEF SEG = VARSEG(notes(track, chan, 1))
POKE offs, valeur
DEF SEG

END SUB

SUB setvaleur (track, chan, num, diese, octave, note)
var = 0
var = (var AND 191) + (diese * 64)
var = (var AND 199) + (octave * 8)

IF note >= 0 THEN
  var = (var AND 248) + (note)
ELSE
  var = (var AND 127) + 128
END IF

setnote track, chan, num, var

END SUB

REM $STATIC
SUB stopfms
	FOR i = 0 TO 7
		'resetchannel i
		writereg &HA0 + i, 0
		writereg &HB0 + i, 0
	NEXT
       
	loopnote = -1
	trackactuel = 0
	isplay = 0
	loopnote = 0
	
END SUB

SUB writereg (Reg%, info%)
	IF baseport = 0 THEN EXIT SUB  'si pas de base port alors pas de son
	OUT baseport + 8, Reg%
	FOR d% = 1 TO 6: x% = INP(baseport + 8): NEXT d%
	OUT baseport + 9, info%
	FOR d% = 1 TO 35: x% = INP(baseport + 8): NEXT d%
	EXIT SUB
END SUB

