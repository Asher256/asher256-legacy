'###########################################################################
'#                  Fm-Song instrument editor Version 1.0
'#                           Par Asher256, 2001
'#
'#
'# L'‚diteur d'instruments avec cet ‚diteur vous pourrez (si vous ˆtes un
'# connaisseur en FM faire toute sorte d'instrument comme les instruments dans
'# le r‚p‚rtoire ins.
'#
'# Si vous avez faits un instrument qui ne figure pas avec les 70 instrument
'# donn‚s avec FM-Song alors envoyez le moi il figurera dans la page officielle
'# avec votre nom dessu et votre page web (si vous en avez).
'#
'# Pour t‚l‚charger le d‚rniŠre version de FM-Song allez sur le site
'# officiel "https://qbworld.asher256.com/fmsong.php".
'#
'############################################################################
DECLARE SUB PLAYnote (chan%, note$, octave%)
DECLARE FUNCTION confirm% (titre AS STRING, desc1 AS STRING, desc2 AS STRING)
DECLARE SUB erreurouv (r$)
DECLARE SUB Msgbox (char AS STRING, xmax AS INTEGER, ymax AS INTEGER, col1 AS INTEGER, col2 AS INTEGER)
DECLARE SUB printat (str AS STRING, x AS INTEGER, y AS INTEGER, col AS INTEGER)
DECLARE SUB printna (char AS STRING, maxc AS INTEGER, px AS INTEGER, py AS INTEGER, col AS INTEGER)
DECLARE SUB enregistrer ()
DECLARE SUB ouvrir ()
DECLARE SUB nouveau ()
DECLARE SUB about ()
DECLARE SUB affiche (x%, y%)
DECLARE SUB tbox (x1%, y1%, x2%, y2%, col1%, col2%)
DECLARE FUNCTION acinput$ (chaine$, act AS STRING, maxchar AS INTEGER, x AS INTEGER, y AS INTEGER, col1 AS INTEGER, col2 AS INTEGER)
DECLARE SUB setinstrument ()
DECLARE SUB playit ()
DECLARE SUB testclique (x%, y%, b%)
DECLARE SUB son ()
DECLARE FUNCTION MouseActive% ()
DECLARE FUNCTION MBtn% ()
DECLARE SUB Mouse (M0%, M1%, M2%, M3%)
DECLARE FUNCTION DetectFM% ()
DECLARE SUB writereg (Reg%, info%)
DECLARE SUB getmxy (x%, y%)
DEFINT A-Z
'$INCLUDE: 'qb.bi'
'La table FM

DIM SHARED notef(11) AS INTEGER
notef(0) = &H16B: notef(1) = &H181: notef(2) = &H198
notef(3) = &H1B0: notef(4) = &H1CA: notef(5) = &H1E5
notef(6) = &H202: notef(7) = &H220: notef(8) = &H241
notef(9) = &H263: notef(10) = &H287: notef(11) = &H2AE

'les buffers
DIM SHARED attack(2) AS INTEGER
DIM SHARED decay(2) AS INTEGER
DIM SHARED sustain(2) AS INTEGER
DIM SHARED released(2) AS INTEGER
DIM SHARED outp(2) AS INTEGER
DIM SHARED scalling(2) AS INTEGER


DIM SHARED pitchvibrato(2) AS INTEGER
DIM SHARED amplitudevibrato(2) AS INTEGER
DIM SHARED frequencymultipler(2) AS INTEGER
DIM SHARED enveloppescalling(2) AS INTEGER
DIM SHARED waveselect(2) AS INTEGER
DIM SHARED sustaininglevel(2) AS INTEGER
DIM SHARED feedback AS INTEGER
DIM SHARED connection AS INTEGER
DIM SHARED fichier AS STRING
DIM SHARED iname AS STRING * 8


IF MouseActive% = 0 THEN PRINT "Pas de souris...": END
IF DetectFM% = 0 THEN PRINT "FM chip not found!": END


'DIM SHARED channel AS INTEGER
channel = 1     'channel 1

DIM SHARED curseur$
curseur$ = "Ü"
SCREEN 0, , 1, 0
CLS
affiche 1, 1
about





DO
	c$ = LCASE$(INKEY$)
	getmxy x, y
	b = MBtn%
	       
	IF LCASE$(c$) = "s" THEN
		writereg &HA0 + channel, 0
		writereg &HB0 + channel, 0
       
	END IF
	
       
	testclique x, y, b
       
	affiche x, y
       
       
	PCOPY 1, 0
       
	IF x >= 36 AND x <= 39 AND y = 2 AND b = 1 THEN
		playit     'jouer le son
	END IF

       
	IF c$ = "s" OR (x >= 41 AND x <= 44 AND y = 2 AND b = 1) THEN writereg &HA0, 0: writereg &HB0, 0 'stopper le son
	IF c$ = "a" OR (x >= 30 AND x <= 34 AND y = 2 AND b = 1) THEN about
	IF c$ = "n" OR (x >= 3 AND x <= 9 AND y = 2 AND b = 1) THEN nouveau
	IF c$ = "o" OR (x >= 11 AND x <= 16 AND y = 2 AND b = 1) THEN ouvrir
	IF c$ = "e" OR (x >= 18 AND x <= 28 AND y = 2 AND b = 1) THEN enregistrer

	IF c$ = "q" OR (x >= 41 AND x <= 47 AND b = 1 AND y = 2) THEN
		IF confirm(" Quitter le programme... ", "Vous ˆtes sures de ", "Quitter [O/N] ?") = 1 THEN
			EXIT DO
		END IF
	END IF


LOOP

FOR n% = 0 TO 224
	writereg n%, 0
NEXT n%


writereg &HA0, 0
writereg &HB0, 0
SCREEN 0, , 0, 0
CLS

SUB about

affiche 10, 10
PCOPY 1, 2




DO
c$ = INKEY$
PCOPY 2, 1

tbox 10, 5, 70, 22, 15, 1
COLOR 14
LOCATE 7, 33: PRINT "Fm-song v1.1"
COLOR 7
LOCATE 8, 28: PRINT "Version du 7 juin 2001"
COLOR 15
LOCATE 10, 12: PRINT "Par Asher256 de - THUNDER SOFTWARE -"
LOCATE 12, 12: PRINT "Fm-song instrument editor est un utilitaire    "
LOCATE 13, 12: PRINT "qui permet de cr‚er des instrument de musique pour"
LOCATE 14, 12: PRINT "les utiliser dans votre midi *.fms."

COLOR 15
LOCATE 18, 12: PRINT "Pour t‚l‚charger la derniŠre version:   ";
COLOR 7
LOCATE
LOCATE 19, 27: PRINT "http://qbworld.asher256.com/fmsong.php"
COLOR 15
LOCATE 21, 37: PRINT "<  OK  >"



	getmxy x, y
	b = MBtn%

LOCATE y, x: PRINT curseur$;

PCOPY 1, 0


LOOP UNTIL c$ = CHR$(13) OR (x >= 37 AND y = 21 AND x <= 37 + 8 AND b = 1)


PCOPY 2, 1
PCOPY 1, 0

END SUB

REM $DYNAMIC
'stat=1 MAJ
'COMMANDE INPUT AVEC UN PASSWORDCHAR:
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'AUTEUR: Asher256
'
'STAT= 0 normal 1 MAJUSCULE
'name$= est la var ou il va stocker la chaine de caractaire tap‚e
'char$= est le password char "" est normal "*" avec des etoiles
'chaine$= est la question qui va poser comme "DONNEZ LE PASSWORD"
'
'
FUNCTION acinput$ (chaine$, act AS STRING, maxchar AS INTEGER, x AS INTEGER, y AS INTEGER, col1 AS INTEGER, col2 AS INTEGER)
PCOPY 1, 3
t! = TIMER
name$ = act

DO
'-----------------------------------------------------------

  PCOPY 3, 1
  c$ = INKEY$

  'si c$ est <> "" est est <> de entr‚e alors ‚crire
  IF c$ > CHR$(27) AND c$ <= CHR$(255) AND LEN(name$) < maxchar THEN
	name$ = name$ + c$
  END IF

  IF c$ = CHR$(8) AND LEN(name$) > 0 THEN
	name$ = LEFT$(name$, LEN(name$) - 1)
  END IF
 
  LOCATE y, x
  PRINT name$ + "_"

  
  getmxy fx, fy
  LOCATE fy, fx: PRINT curseur$;
  
  PCOPY 1, 0
IF c$ = CHR$(27) THEN EXIT FUNCTION
'-----------------------------------------------------------
LOOP UNTIL c$ = CHR$(13) AND LEN(name$) >= 1

acinput$ = name$

END FUNCTION

SUB affiche (x, y)
CLS
tbox 1, 1, 80, 25, 15, 0
LOCATE 1, 18
PRINT "[ Utilitaire de cr‚ation d'instrument FM  ]"
COLOR 7
LOCATE 2, 70: PRINT TIME$;
COLOR 15

LOCATE 2
COLOR 15
LOCATE , 2: PRINT " N";
COLOR 7
PRINT "ouveau ";
COLOR 15
PRINT "O";
COLOR 7
PRINT "uvrir ";
COLOR 15
PRINT "E";
COLOR 7
PRINT "nregistrer ";
COLOR 15
PRINT "A";
COLOR 7
PRINT "bout ";
COLOR 15
PRINT "P";
COLOR 7
PRINT "lay ";
COLOR 15
PRINT "Q";
COLOR 7
PRINT "uitter ";


PRINT
PRINT
PRINT
COLOR 7
LOCATE , 4: PRINT "                          MODULATEUR                 CARRIER     "
LOCATE , 4: PRINT
LOCATE , 4: PRINT "Attaque:               <---------------->        <---------------->      "

LOCATE , 4: PRINT "Decay:                 <---------------->        <---------------->       "
LOCATE , 4: PRINT "sustain:               <---------------->        <---------------->      "
LOCATE , 4: PRINT "released time:         <---------------->        <---------------->       "
LOCATE , 4: PRINT
LOCATE , 4: PRINT "Output level:          <---------------->        <---------------->       "
LOCATE , 4: PRINT "Level scalling:               <---->                   <---->       "
LOCATE , 4: PRINT
LOCATE , 4: PRINT "Amplitude vibrato:              [ ]                      [ ]"
LOCATE , 4: PRINT "Pitch vibrato:                  [ ]                      [ ]"
LOCATE , 4: PRINT "Frequency multipler:   <---------------->        <---------------->      "
LOCATE , 4: PRINT "Enveloppe scalling:             [ ]                      [ ]"
LOCATE , 4: PRINT "Sustaining level:               [ ]                      [ ]"
LOCATE , 4: PRINT
LOCATE , 4: PRINT "Wave select:               [ ][ ][ ][ ]              [ ][ ][ ][ ]"
LOCATE , 4: PRINT "Freedback:    <-------->"
LOCATE , 4: PRINT "Connection:   [ ]";

LOCATE 22, 18 + feedback + 1
PRINT "O"


LOCATE 7, 27 + attack(1) + 1
PRINT "O"
LOCATE 7, 53 + attack(2) + 1
PRINT "O"

LOCATE 8, 27 + decay(1) + 1
PRINT "O"
LOCATE 8, 53 + decay(2) + 1
PRINT "O"

LOCATE 9, 27 + sustain(1) + 1
PRINT "O"
LOCATE 9, 53 + sustain(2) + 1
PRINT "O"

LOCATE 10, 27 + released(1) + 1
PRINT "O"
LOCATE 10, 53 + released(2) + 1
PRINT "O"

LOCATE 12, 27 + (outp(1) / 4) + 1
PRINT "O"
LOCATE 12, 53 + (outp(2) / 4) + 1
PRINT "O"

LOCATE 13, 34 + scalling(1) + 1
PRINT "O"
LOCATE 13, 59 + scalling(2) + 1
PRINT "O"


LOCATE 17, 27 + frequencymultipler(1) + 1
PRINT "O";
LOCATE 17, 53 + frequencymultipler(2) + 1
PRINT "O"



IF amplitudevibrato(1) = 1 THEN LOCATE 15, 37: PRINT "X"
IF amplitudevibrato(2) = 1 THEN LOCATE 15, 62: PRINT "X"

'IF levelscalling(1) = 1 THEN LOCATE 15, 37: PRINT "X"
'IF levelscalling(2) = 1 THEN LOCATE 15, 62: PRINT "X"

IF pitchvibrato(1) = 1 THEN LOCATE 16, 37: PRINT "X"
IF pitchvibrato(2) = 1 THEN LOCATE 16, 62: PRINT "X"




IF enveloppescalling(1) = 1 THEN LOCATE 18, 37: PRINT "X"
IF enveloppescalling(2) = 1 THEN LOCATE 18, 62: PRINT "X"

'34 36 38
' 0 1 2
'IF x = 31 AND y = 21 THEN waveselect(1) = 0: son

IF waveselect(1) = 0 THEN LOCATE 21, 32: PRINT "@"
IF waveselect(1) = 1 THEN LOCATE 21, 35: PRINT "@"
IF waveselect(1) = 2 THEN LOCATE 21, 38: PRINT "@"
IF waveselect(1) = 3 THEN LOCATE 21, 41: PRINT "@"

IF waveselect(2) = 0 THEN LOCATE 21, 58: PRINT "@"
IF waveselect(2) = 1 THEN LOCATE 21, 61: PRINT "@"
IF waveselect(2) = 2 THEN LOCATE 21, 64: PRINT "@"
IF waveselect(2) = 3 THEN LOCATE 21, 67: PRINT "@"

IF sustaininglevel(1) = 1 THEN LOCATE 19, 37: PRINT "X"
IF sustaininglevel(2) = 1 THEN LOCATE 19, 62: PRINT "X"


IF connection = 1 THEN LOCATE 23, 19: PRINT "X";

LOCATE y, x: PRINT curseur$;

END SUB

FUNCTION confirm (titre AS STRING, desc1 AS STRING, desc2 AS STRING)

PCOPY 1, 0
reprendre:

DO
	
	c$ = LCASE$(INKEY$)
	CLS
	getmxy fx, fy
	affiche fx, fy
	tbox 10, 4, 45, 8, 15, 0
	PCOPY 1, 2

	LOCATE 4, 12: PRINT titre
	COLOR 7
	LOCATE 5, 12: PRINT desc1
	LOCATE 6, 12: PRINT desc2
	COLOR 15

	LOCATE fy, fx: PRINT curseur$

	PCOPY 1, 0
LOOP UNTIL c$ <> ""
IF c$ = "o" THEN confirm = 1
IF c$ = "n" THEN confirm = 0
IF c$ <> "o" AND c$ <> "n" THEN GOTO reprendre

PCOPY 2, 1


END FUNCTION

DEFSNG A-Z
FUNCTION DetectFM%
'true si fm ok
FOR p = &H210 TO &H280 STEP &H10
	OUT p + &H6, 1
	FOR c = 1 TO 100
		OUT p + &H6, 0
		st = INP(p + &HE)
		st = INP(p + &HA)
		IF st = &HAA THEN EXIT FOR
	NEXT
	IF st = &HAA THEN
		sbdetect = -1
		baseport = p
		EXIT FOR
	END IF
NEXT

IF sbdetect THEN
	basep = baseport
	DetectFM% = -1
ELSE
	DetectFM = 0
	basep = 0
END IF



END FUNCTION

DEFINT A-Z
SUB enregistrer
tbox 10, 4, 40, 10, 15, 0
PCOPY 1, 2

LOCATE 4, 12: PRINT " Enregistrer "
COLOR 7
LOCATE 5, 12: PRINT "Nom de l'instrument"
LOCATE 6, 12: PRINT ""
COLOR 15
a$ = acinput$("", iname, 8, 12, 8, 15, 15)
IF a$ = "" THEN EXIT SUB

tbox 10, 4, 40, 10, 15, 0
PCOPY 1, 2

LOCATE 4, 12: PRINT " Enregistrer "
COLOR 7
LOCATE 5, 12: PRINT "Fichier *.fmi"
LOCATE 6, 12: PRINT "(sans l'extention)"
COLOR 15
b$ = acinput$("", fichier, 8, 12, 8, 15, 15)
IF b$ = "" THEN EXIT SUB
fichier = b$
iname = a$
PCOPY 2, 1
IF fichier = "" THEN EXIT SUB
IF INSTR(fichier, "*") THEN erreurouv "Erreur fichier...": EXIT SUB
IF INSTR(fichier, ";") THEN erreurouv "Erreur fichier...": EXIT SUB
IF INSTR(fichier, ",") THEN erreurouv "Erreur fichier...": EXIT SUB
IF INSTR(fichier, "/") THEN erreurouv "Erreur fichier...": EXIT SUB
IF INSTR(fichier, "\") THEN erreurouv "Erreur fichier...": EXIT SUB
IF INSTR(fichier, "<") THEN erreurouv "Erreur fichier...": EXIT SUB
IF INSTR(fichier, ">") THEN erreurouv "Erreur fichier...": EXIT SUB
IF INSTR(fichier, ".") THEN erreurouv "il ne faut pas mettre l'extention...": EXIT SUB



OPEN fichier + ".fmi" FOR OUTPUT AS #1
WRITE #1, "fm-song instrument"
WRITE #1, iname
WRITE #1, attack(1), attack(2)
WRITE #1, decay(1), decay(2)
WRITE #1, sustain(1), sustain(2)
WRITE #1, released(1), released(2)
WRITE #1, outp(1), outp(2)
WRITE #1, scalling(1), scalling(2)

WRITE #1, amplitudevibrato(1), amplitudevibrato(2)
WRITE #1, pitchvibrato(1), pitchvibrato(2)
WRITE #1, frequencymultipler(1), frequencymultipler(2)
WRITE #1, enveloppescalling(1), enveloppescalling(2)
WRITE #1, waveselect(1), waveselect(2)
WRITE #1, sustaininglevel(1), sustaininglevel(2)
WRITE #1, feedback, connection


CLOSE #1





END SUB

SUB erreurouv (r$)
	SOUND 1000, 2
	fichier = ""
	Msgbox r$, 25, 10, 15, 4

END SUB

DEFSNG A-Z
SUB getmxy (x%, y%) STATIC
Mouse 3, 0, x%, y%
x% = x% / 8
y% = y% / 8
x% = x% + 1
y% = y% + 1

END SUB

DEFINT A-Z
FUNCTION MBtn% STATIC
Mouse 3, Buttons%, 0, 0
MBtn% = Buttons%
END FUNCTION

DEFSNG A-Z
SUB Mouse (M0%, M1%, M2%, M3%) STATIC
DIM InRegs AS RegType, OutRegs AS RegType
InRegs.ax = M0%
InRegs.bx = M1%
InRegs.cx = M2%
InRegs.dx = M3%
CALL INTERRUPT(51, InRegs, OutRegs)
M0% = OutRegs.ax
M1% = OutRegs.bx
M2% = OutRegs.cx
M3% = OutRegs.dx
END SUB

DEFLNG A-Z
FUNCTION MouseActive% STATIC
DEF SEG = 0
mseg& = 256 * PEEK(51 * 4 + 3) + PEEK(51 * 4 + 2)
moff& = 256 * PEEK(51 * 4 + 1) + PEEK(51 * 4)
IF mseg& OR moff& THEN
DEF SEG = mseg&
IF PEEK(moff&) = 207 THEN
MouseActive% = 0
ELSE
MouseActive% = -1
END IF
ELSE
MouseActive% = 0
END IF
DEF SEG
END FUNCTION

DEFSNG A-Z
SUB MouseOff STATIC
Mouse 0, 0, 0, 0
END SUB

SUB MouseOn STATIC
Mouse 0, 0, 0, 0
Mouse 1, 0, 0, 0
END SUB

DEFINT A-Z
SUB Msgbox (char AS STRING, xmax AS INTEGER, ymax AS INTEGER, col1 AS INTEGER, col2 AS INTEGER)

'col 1 text
'SUB printat (str AS STRING, x AS INTEGER, y AS INTEGER, col AS INTEGER)
x = (80 - xmax) / 2
y = (25 - ymax) / 2

COLOR 0
PCOPY 1, 2
tbox x + 1, y + 1, x + 1 + xmax, y + 1 + ymax, 0, 0
tbox x, y, x + xmax, y + ymax, 15, col2
printna char, xmax - 5, x + 3, y + 3, col1

tbox x - 4 + ((xmax - 6) / 2), y - 1 + ymax - 2, 13 + x - 4 + ((xmax - 6) / 2), 2 + y - 1 + ymax - 2, 15, 1
printat "< ok >", x + ((xmax - 6) / 2), y + ymax - 2, 15
PCOPY 1, 3
ex = 0
DO
PCOPY 3, 1

getmxy fx, fy
LOCATE fy, fx: PRINT curseur$;
b = MBtn%
IF fy <= 2 + y - 1 + ymax - 2 AND fx <= 13 + x - 4 + ((xmax - 6) / 2) AND fx >= x - 4 + ((xmax - 6) / 2) AND fy >= y - 1 + ymax - 2 AND b = 1 THEN
	
	ex = 1
END IF



PCOPY 1, 0
LOOP UNTIL INKEY$ = CHR$(13) OR ex = 1
PCOPY 2, 1
PCOPY 1, 0


END SUB

SUB nouveau

IF confirm("Nouveau...", "Nouvel instrument?[O/N] ", "") = 0 THEN EXIT SUB
'tout ‡a commence par 0
attack(1) = 0
attack(2) = 0

decay(1) = 0
decay(2) = 0

sustain(1) = 0
sustain(2) = 0

released(1) = 0
released(2) = 0

outp(1) = 0
outp(2) = 0

scalling(1) = 0
scalling(2) = 0


amplitudevibrato(1) = 0
amplitudevibrato(2) = 0


'levelscalling(1) = 0
'levelscalling(2) = 0

pitchvibrato(1) = 0
pitchvibrato(2) = 0

frequencymultipler(1) = 0
frequencymultipler(2) = 0

enveloppescalling(1) = 0
enveloppescalling(2) = 0

waveselect(1) = 0
waveselect(2) = 0

sustaininglevel(1) = 0
sustaininglevel(2) = 0

feedback = 0
connection = 0
fichier = ""
iname = ""
END SUB

SUB ouvrir
tbox 10, 4, 40, 10, 15, 0
PCOPY 1, 2

LOCATE 4, 12: PRINT " Ouvrir "
COLOR 7
LOCATE 5, 12: PRINT "Fichier *.fmi"
LOCATE 6, 12: PRINT "(sans l'extention)"
COLOR 15
a$ = acinput$("", "", 8, 12, 8, 15, 15)
fichier = a$


'-------- LES ERREURS
IF fichier = "" THEN EXIT SUB
IF INSTR(fichier, "*") THEN erreurouv "Erreur fichier...": EXIT SUB
IF INSTR(fichier, ";") THEN erreurouv "Erreur fichier...": EXIT SUB
IF INSTR(fichier, ",") THEN erreurouv "Erreur fichier...": EXIT SUB
IF INSTR(fichier, "/") THEN erreurouv "Erreur fichier...": EXIT SUB
IF INSTR(fichier, "\") THEN erreurouv "Erreur fichier...": EXIT SUB
IF INSTR(fichier, "<") THEN erreurouv "Erreur fichier...": EXIT SUB
IF INSTR(fichier, ">") THEN erreurouv "Erreur fichier...": EXIT SUB
IF INSTR(fichier, ".") THEN erreurouv "il ne faut pas mettre l'extention...": EXIT SUB

OPEN fichier + ".fmi" FOR BINARY AS #1
	IF LOF(1) = 0 THEN
		CLOSE #1
		KILL fichier + ".fmi"
		erreurouv "Le fichier " + fichier + ".fmi n'existe pas"
		EXIT SUB
	END IF
CLOSE #1
'----------
OPEN fichier + ".fmi" FOR INPUT AS #1
INPUT #1, head$
'modifier avec un message BOX
IF head$ <> "fm-song instrument" THEN erreurouv "Fichier *.mst invalide...": EXIT SUB

INPUT #1, iname

INPUT #1, attack(1), attack(2)
INPUT #1, decay(1), decay(2)
INPUT #1, sustain(1), sustain(2)
INPUT #1, released(1), released(2)
INPUT #1, outp(1), outp(2)
INPUT #1, scalling(1), scalling(2)

INPUT #1, amplitudevibrato(1), amplitudevibrato(2)
'INPUT #1, levelscalling(1), levelscalling(2)
INPUT #1, pitchvibrato(1), pitchvibrato(2)
INPUT #1, frequencymultipler(1), frequencymultipler(2)
INPUT #1, enveloppescalling(1), enveloppescalling(2)
INPUT #1, waveselect(1), waveselect(2)
INPUT #1, sustaininglevel(1), sustaininglevel(2)
INPUT #1, feedback, connection


CLOSE #1

PCOPY 2, 1



END SUB

SUB playit

writereg &HA0 + channel, 0
writereg &HB0 + channel, 0
FOR n% = 0 TO &HF5
    writereg n%, 0
NEXT n%

setinstrument

'PLAYnote channel, "c", 3
no$ = "cdefgab"
o = 4
IF MBtn% = 1 THEN
	DO
	IF TIMER - t! > .5 THEN
		po = po + 1: IF po >= 8 THEN po = 1: o = o + 1
		IF o >= 6 THEN o = 2

		PLAYnote channel, MID$(no$, po, 1), o
		t! = TIMER
	END IF

		      
       
	LOOP UNTIL MBtn% = 0
END IF
writereg &HA0, 0
writereg &HB0, 0




END SUB

SUB PLAYnote (chan, note$, octave)

writereg &HA0 + chan, 0
writereg &HB0 + chan, 0

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
END SELECT

Octv% = octave
freq% = notef(note% MOD 12)
writereg &HA0 + chan, freq% AND &HFF
writereg &HB0 + chan, FIX(freq% / 256) OR 32 OR (Octv% * 4)





END SUB

SUB printat (str AS STRING, x AS INTEGER, y AS INTEGER, col AS INTEGER)
LOCATE y, x
COLOR col
PRINT str;
END SUB

DEFSNG A-Z
SUB printna (char AS STRING, maxc AS INTEGER, px AS INTEGER, py AS INTEGER, col AS INTEGER)

'print sans pcopy sans son et sans delay

DIM str AS STRING
DIM max AS INTEGER
DIM x AS INTEGER
DIM y AS INTEGER
str = char
max = maxc

'x = LEN(str)
y = 0

LOCATE py + y, px + x
COLOR col
FOR i = 1 TO LEN(str)
    
	d = d + 1
	IF d = max THEN
		x = 0
		d = 0
		y = y + 1
	     
		IF MID$(str, i, 1) <> " " THEN
			PRINT "-"
		END IF
		LOCATE py + y, px + x
	END IF
	IF NOT (d = 0 AND MID$(str, i, 1) = " ") THEN
		PRINT MID$(str, i, 1);
	END IF

NEXT


PRINT
END SUB

DEFINT A-Z
SUB setinstrument
chan = channel + 1
SELECT CASE chan
	CASE IS <= 1:
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
r11 = 192 + channel

'------- LA VAR 1
var1 = 0
IF pitchvibrato(1) = 1 THEN var1 = 128
IF amplitudevibrato(1) = 1 THEN var1 = var1 + 64
IF sustaininglevel(1) = 1 THEN var1 = var1 + 32
IF enveloppescalling(1) = 1 THEN var1 = var1 + 16
var1 = var1 + frequencymultipler(1)

'-------LA VAR 2
var2 = 0
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

DEFSNG A-Z
SUB SetMXY (x%, y%) STATIC
Mouse 4, 0, x%, y%
END SUB

SUB showmouse STATIC
Mouse 1, 0, 0, 0
END SUB

DEFINT A-Z
SUB son
		SOUND 1000, .25
		d! = TIMER: DO: LOOP UNTIL TIMER - d! >= .11

END SUB

SUB tbox (x1, y1, x2, y2, col1, col2)

'192   À
'196   Ä
'179   ³
'218   Ú
'217   Ù
'191   ¿
COLOR col1, col2
LOCATE y1, x1
PRINT "Ú"; STRING$((x2 - x1) - 1, "Ä"); "¿";


FOR i = y1 + 1 TO y2 - 1
	LOCATE i, x1
	PRINT "³" + STRING$((x2 - x1) - 1, " ") + "³";
NEXT

LOCATE i, x1
PRINT "À"; STRING$(x2 - x1 - 1, "Ä"); "Ù";








END SUB

SUB testclique (x, y, b)
IF b <> 1 THEN EXIT SUB
'------------[ FEED BACK ]-------------------
'augmenter l'attaque mod
IF x = 18 AND y = 22 AND feedback > 0 THEN feedback = feedback - 1: son
IF x = 27 AND y = 22 AND feedback < 7 THEN feedback = feedback + 1: son
'------------[ L'ATTAQUE ]-------------------
'------------[ L'ATTAQUE ]-------------------
'augmenter l'attaque mod
IF x = 27 AND y = 7 AND attack(1) > 0 THEN attack(1) = attack(1) - 1: son
IF x = 44 AND y = 7 AND attack(1) < 15 THEN attack(1) = attack(1) + 1: son
      
'augmenter l'attaque du carrier
IF x = 53 AND y = 7 AND attack(2) > 0 THEN attack(2) = attack(2) - 1: son
IF x = 70 AND y = 7 AND attack(2) < 15 THEN attack(2) = attack(2) + 1: son
'------------[ L'ATTAQUE ]-------------------
'------------[ LE DECAY ]-------------------
'augmenter l'attaque mod
IF x = 27 AND y = 8 AND decay(1) > 0 THEN decay(1) = decay(1) - 1: son
IF x = 44 AND y = 8 AND decay(1) < 15 THEN decay(1) = decay(1) + 1: son
      
'augmenter l'attaque du carrier
IF x = 53 AND y = 8 AND decay(2) > 0 THEN decay(2) = decay(2) - 1: son
IF x = 70 AND y = 8 AND decay(2) < 15 THEN decay(2) = decay(2) + 1: son
'------------[ LE DECAY ]-------------------
'------------[ LE SUSTAIN ]-------------------
'augmenter l'attaque mod
IF x = 27 AND y = 9 AND sustain(1) > 0 THEN sustain(1) = sustain(1) - 1: son
IF x = 44 AND y = 9 AND sustain(1) < 15 THEN sustain(1) = sustain(1) + 1: son
     
'augmenter l'attaque du carrier
IF x = 53 AND y = 9 AND sustain(2) > 0 THEN sustain(2) = sustain(2) - 1: son
IF x = 70 AND y = 9 AND sustain(2) < 15 THEN sustain(2) = sustain(2) + 1: son
'------------[ LE SUSTAIN ]-------------------
'------------[ RELEASED TIME ]-------------------
'augmenter l'attaque mod
IF x = 27 AND y = 10 AND released(1) > 0 THEN released(1) = released(1) - 1: son
IF x = 44 AND y = 10 AND released(1) < 15 THEN released(1) = released(1) + 1: son
    
'augmenter l'attaque du carrier
IF x = 53 AND y = 10 AND released(2) > 0 THEN released(2) = released(2) - 1: son
IF x = 70 AND y = 10 AND released(2) < 15 THEN released(2) = released(2) + 1: son
'------------[ RELEASED TIME ]-------------------
'------------[ OUTPUT ]-------------------
'augmenter l'attaque mod
IF x = 27 AND y = 12 AND outp(1) > 3 THEN outp(1) = outp(1) - 4: son
IF x = 44 AND y = 12 AND outp(1) < 60 THEN outp(1) = outp(1) + 4: son
   
'augmenter l'attaque du carrier
IF x = 53 AND y = 12 AND outp(2) > 0 THEN outp(2) = outp(2) - 4: son
IF x = 70 AND y = 12 AND outp(2) < 60 THEN outp(2) = outp(2) + 4: son
'------------[ OUTPUT ]-------------------

'------------[ Le scaling ]-------------------
'augmenter l'attaque mod
IF x = 34 AND y = 13 AND scalling(1) > 0 THEN scalling(1) = scalling(1) - 1: son
IF x = 39 AND y = 13 AND scalling(1) < 3 THEN scalling(1) = scalling(1) + 1: son
  
'augmenter l'attaque mod
IF x = 59 AND y = 13 AND scalling(2) > 0 THEN scalling(2) = scalling(2) - 1: son
IF x = 64 AND y = 13 AND scalling(2) < 3 THEN scalling(2) = scalling(2) + 1:  son
'------------[ OUTPUT ]-------------------


'------------[ La frequency multipler ]-------------------
'augmenter l'attaque mod
IF x = 27 AND y = 17 AND frequencymultipler(1) > 0 THEN frequencymultipler(1) = frequencymultipler(1) - 1: son
IF x = 44 AND y = 17 AND frequencymultipler(1) < 15 THEN frequencymultipler(1) = frequencymultipler(1) + 1: son
  
'augmenter l'attaque mod
IF x = 53 AND y = 17 AND frequencymultipler(2) > 0 THEN frequencymultipler(2) = frequencymultipler(2) - 1: son
IF x = 70 AND y = 17 AND frequencymultipler(2) < 15 THEN frequencymultipler(2) = frequencymultipler(2) + 1: son
'------------[ OUTPUT ]-------------------


'DIM amplitudevibrato(2)
'DIM levelscalling(2)
'DIM pitchvibrato(2)
'DIM frequencymultipler(2)
'DIM enveloppescalling(2)
'DIM waveselect(2)
'DIM feedback(2)
'DIM connection(2)
'amplitude vibrato
IF x = 37 AND y = 15 THEN amplitudevibrato(1) = amplitudevibrato(1) XOR 1: son
IF x = 62 AND y = 15 THEN amplitudevibrato(2) = amplitudevibrato(2) XOR 1: son

IF x = 37 AND y = 16 THEN pitchvibrato(1) = pitchvibrato(1) XOR 1: son
IF x = 62 AND y = 16 THEN pitchvibrato(2) = pitchvibrato(2) XOR 1: son


IF x = 37 AND y = 18 THEN enveloppescalling(1) = enveloppescalling(1) XOR 1: son
IF x = 62 AND y = 18 THEN enveloppescalling(2) = enveloppescalling(2) XOR 1: son

IF x = 37 AND y = 19 THEN sustaininglevel(1) = sustaininglevel(1) XOR 1: son
IF x = 62 AND y = 19 THEN sustaininglevel(2) = sustaininglevel(2) XOR 1: son

'31 34 37
IF x = 32 AND y = 21 THEN waveselect(1) = 0: son
IF x = 35 AND y = 21 THEN waveselect(1) = 1: son
IF x = 38 AND y = 21 THEN waveselect(1) = 2: son
IF x = 41 AND y = 21 THEN waveselect(1) = 3: son

IF x = 58 AND y = 21 THEN waveselect(2) = 0: son
IF x = 61 AND y = 21 THEN waveselect(2) = 1: son
IF x = 64 AND y = 21 THEN waveselect(2) = 2: son
IF x = 67 AND y = 21 THEN waveselect(2) = 3: son

IF x = 19 AND y = 23 THEN connection = connection XOR 1: son



END SUB

SUB waitmouse
DO
bo = MBtn%
LOOP UNTIL bo = 0

END SUB

DEFSNG A-Z
SUB writereg (Reg%, info%)
 OUT &H388, Reg%
 FOR d% = 1 TO 6: x% = INP(&H388): NEXT d%
 OUT &H389, info%
 FOR d% = 1 TO 35: x% = INP(&H388): NEXT d%
END SUB

