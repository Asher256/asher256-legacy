'####################################################################
'                   DOSAMP version 1.3 Aout 2001
'
' Copyright (c) Asher256, Thunder software 2001
'
' Ce programme est un FREEWARE et libre de droit si vous voulez le
' modifier veuillez me contacter en premier...
'
' Vous avez eu ce fichier depuis le site officiel de FmSong:
' https://qbworld.asher256.com/fmsong.php
'
'####################################################################

DECLARE SUB resetchan (chan%)
DECLARE FUNCTION opt$ (num%)
DECLARE FUNCTION acinput$ (chaine$, act AS STRING, maxchar AS INTEGER, x AS INTEGER, y AS INTEGER, Col1 AS INTEGER)
DECLARE SUB afficher (mx%, my%)
DECLARE SUB ouvrir ()
DECLARE SUB scroll (char AS STRING)
DECLARE SUB loopit ()
REM $INCLUDE: 'directqb.bi'
'$INCLUDE: 'fmlib.bi'           'toujours inclure ce sous programme
DIM SHARED Font AS STRING * 2305



'---------[ Declaration des variables ]-------------------
DIM SHARED path$
DIM SHARED Volume
DIM SHARED maxvolume
maxvolume = 64 - 14
Volume = maxvolume / 2
DIM SHARED pan, maxpan
maxpan = 38 - 14
pan = maxpan / 2

DIM SHARED Pal AS STRING * 768
DIM SHARED mouse(30 * 30)   AS INTEGER
DIM SHARED winamp(DQBsize(0, 0, 276, 115))  AS INTEGER
DIM SHARED dx  AS INTEGER
DIM SHARED dy  AS INTEGER
dx = 15
dy = 35
DIM SHARED boutton(DQBsize(0, 117, 28, 126))  AS INTEGER
DIM SHARED save1(DQBsize(0, 0, 7, 7))  AS INTEGER
DIM SHARED save2(DQBsize(0, 0, 7, 7))  AS INTEGER
DIM SHARED dialogbox(DQBsize(122, 117, 319, 199))  AS INTEGER
DIM SHARED boutton2(DQBsize(61, 117, 74, 127))  AS INTEGER
DIM SHARED positionb  AS INTEGER
DIM SHARED mystring AS STRING
DIM SHARED scx AS INTEGER
DIM SHARED bouttontime!
DIM SHARED mx, my, mb, d!
DIM SHARED maxno AS INTEGER
DIM SHARED mystring2 AS STRING

path$ = opt(1)
IF NOT path$ = "" THEN
       IF RIGHT$(path$, 1) <> "\" THEN path$ = path$ + "\"
END IF
'--------------------------------------------------------

IF DQBinit(3, 0, 0) THEN
	SOUND 100, .25
	DQBclose
	PRINT DQBerror$
	END
END IF

DIM SHARED mouse AS INTEGER
mouse = -1
IF NOT DQBmouseDetected% THEN
	mouse = 0
	'PRINT "Erreur ne trouve pas la souris..."
	'DQBclose
	'END
END IF
DQBinitVGA



IF DQBloadImage(2, 0, 0, path$ + "dosamp.qbm", Pal, w, h) THEN
	DQBclose
	PRINT "Erreur ne trouve pas le fichier " + path$ + "dosamp.qbm"
     
	END
END IF
DQBsetPal Pal
DQBget 2, 31, 118, 57, 144, VARSEG(mouse(0)), VARPTR(mouse(0))
DQBget 2, 0, 0, 273, 115, VARSEG(winamp(0)), VARPTR(winamp(0))
DQBget 2, 0, 117, 28, 126, VARSEG(boutton(0)), VARPTR(boutton(0))
DQBget 2, 122, 117, 319, 199, VARSEG(dialogbox(0)), VARPTR(dialogbox(0))
DQBget 2, 61, 117, 74, 127, VARSEG(boutton2(0)), VARPTR(boutton2(0))


'charge le fichier FMSong
IF fmsonginit THEN
	DQBclose
	PRINT "Pas de chip FM detecte..."
	END
END IF


replay = 1

file$ = opt(0)

IF file$ = "" THEN
	IF loadfms(path$ + "sample") THEN SOUND 100, 3
	mystring = "Dosamp v1.3 Çcrit en QBasic 4.5 par Asher256, Thunder Software 2001 avec la librairie FM-Lib "
	mystring = mystring + "vous pouvez la tÇlÇcharger depuis son site officiel "
	mystring = mystring + "https://qbworld.asher256.com/fmsong.php"
ELSE

	IF loadfms(file$) THEN
		SOUND 1000, 2
		DQBclose
		fmsongclose
		PRINT "Erreur le fichier " + COMMAND$ + " est introuvable..."
		PRINT
	END IF

END IF

'-----------------[ Le menu principal ]----------------------------
DIM SHARED pfps AS INTEGER
DO
c$ = INKEY$
DQBclearLayer 1
FPS = FPS + 1
IF TIMER - fpstime! >= 1 THEN pfps = FPS: FPS = 0: fpstime! = TIMER

loopit

IF c$ = "0" THEN ouvrir
IF c$ = CHR$(13) THEN playfms: resumefms
IF c$ = CHR$(27) THEN pausefms
IF c$ = "p" THEN trackactuel = 0: loopnote = 0


'pour dÇplacer winamp
IF mb AND mx >= dx AND my >= dy AND my <= dy + 12 AND mx <= dx + 255 THEN
       
	farkx = mx - dx
	farky = my - dy
	      
	DO
		DQBclearLayer 1
		loopit
		dx = mx - farkx
		dy = my - farky

		afficher mx, my
		DQBcopyLayer 1, 0
	       
	LOOP UNTIL NOT mb
       

END IF

'la touche du replay
IF mb AND mx >= dx + 210 AND my >= dy + 89 AND mx <= dx + 234 AND my <= dy + 100 THEN
       
	bouttontime! = TIMER
	replay = replay XOR 1
	SOUND 100, .25
END IF

'rew
IF mb AND mx >= dx + 15 AND my >= dy + 87 AND mx <= dx + 35 AND my <= dy + 103 THEN
	bouttontime! = TIMER
	loopnote = -1
	trackactuel = 0
	FOR i = 1 TO 8: resetchan i: NEXT
END IF

'play
IF mb AND mx >= dx + 38 AND my >= dy + 87 AND mx <= dx + 57 AND my <= dy + 103 THEN
	bouttontime! = TIMER
	playfms
	resumefms
END IF

IF mb AND mx >= dx + 264 AND my >= dy + 2 AND mx <= dx + 270 AND my <= dy + 9 THEN
GOTO fin
END IF

'Eject ou ouvrir si on veut :)))
IF mb AND mx >= dx + 135 AND my >= dy + 88 AND mx <= dx + 155 AND my <= dy + 102 THEN
	ouvrir
	bouttontime! = TIMER
END IF

'FF avancer j'usquÖ la fin
IF mb AND mx >= dx + 107 AND my >= dy + 87 AND mx <= dx + 127 AND my <= dy + 103 THEN
	pausefms
	trackactuel = maxtrack - 1
	loopnote = maxnotes(trackactuel + 1) - 1
       
	bouttontime! = TIMER
END IF

'pause
IF mb AND mx >= dx + 61 AND my >= dy + 87 AND mx <= dx + 81 AND my <= dy + 103 THEN
	pausefms
	bouttontime! = TIMER
END IF

'stop
IF mb AND mx >= dx + 84 AND my >= dy + 87 AND mx <= dx + 104 AND my <= dy + 103 THEN
      
	pausefms
	bouttontime! = TIMER
END IF

'volume
IF mb AND mx >= dx + 107 AND my >= dy + 60 AND mx <= dx + 170 AND my <= dy + 64 THEN
	DO
		DQBclearLayer 1
		loopit
		afficher mx, my
	     
	     
		Volume = mx - (107 + dx + 7)
		IF Volume > maxvolume THEN Volume = maxvolume
		IF Volume < 0 THEN Volume = 0
		DQBcopyLayer 1, 0
     
       LOOP UNTIL NOT mb
END IF

'le reglage de pan
IF mb AND mx >= dx + 176 AND my >= dy + 60 AND mx <= dx + 213 AND my <= dy + 64 THEN
	DO
		DQBclearLayer 1
		loopit
		afficher mx, my
	     
	     
		pan = mx - (176 + dx + 7)
		IF pan > maxpan THEN pan = maxpan
		IF pan < 0 THEN pan = 0
		pani = ((pan * 30) / 24) - 30
		'setpan pani
		DQBcopyLayer 1, 0
	LOOP UNTIL NOT mb
END IF

'15 87 35 103

afficher mx, my



DQBcopyLayer 1, 0
LOOP UNTIL c$ = CHR$(27)


fin:
DQBclose
fmsongclose
CLEAR

REM $DYNAMIC
'stat=1 MAJ
'COMMANDE INPUT AVEC UN PASSWORDCHAR:
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'AUTEUR: ASHER256
'
'STAT= 0 normal 1 MAJUSCULE
'name$= est la var ou il va stocker la chaine de caractaire tapÇe
'char$= est le password char "" est normal "*" avec des etoiles
'chaine$= est la question qui va poser comme "DONNEZ LE PASSWORD"
'
'
FUNCTION acinput$ (chaine$, act AS STRING, maxchar AS INTEGER, x AS INTEGER, y AS INTEGER, Col1 AS INTEGER)
t! = TIMER
name$ = act

DO
'-----------------------------------------------------------

 
  c$ = INKEY$

  'si c$ est <> "" est est <> de entrÇe alors Çcrire
  IF c$ > CHR$(27) AND c$ <= CHR$(255) AND LEN(name$) < maxchar THEN
	name$ = name$ + c$
  END IF

  IF c$ = CHR$(8) AND LEN(name$) > 0 THEN
	name$ = LEFT$(name$, LEN(name$) - 1)
  END IF

loopit
DQBclearLayer 1
afficher mx, my
DQBcopyTransLayer 2, 1
DQBprint 1, name$ + "_", x, y, Col1
DQBput 1, mx, my, VARSEG(mouse(0)), VARPTR(mouse(0))

DQBcopyLayer 1, 0

IF c$ = CHR$(27) THEN EXIT FUNCTION

LOOP UNTIL c$ = CHR$(13) AND LEN(name$) >= 1

'COLOR , col2
'LOCATE y, x
'PRINT name$ + " "

acinput$ = name$

END FUNCTION

SUB afficher (mx, my)


DQBput 1, dx, dy, VARSEG(winamp(0)), VARPTR(winamp(0))
DQBput 1, dx + 17 + positionb, dy + 71, VARSEG(boutton(0)), VARPTR(boutton(0))

'DQBprint 1, "Fps:" + STR$(pfps) + STR$(maxpan) + STR$(pan) + STR$(mx) + STR$(my) + STR$(mb), 0, 0, 200
DQBget 1, dx + 110 - 8, dy + 26, dx + 110 - 8 + 8, dy + 26 + 8, VARSEG(save1(0)), VARPTR(save1(0))
DQBget 1, dx + 265, dy + 26, dx + 265 + 8, dy + 26 + 8, VARSEG(save2(0)), VARPTR(save2(0))
DQBprint 1, MID$(mystring, 1, 20), dx + 110 - scx, dy + 26, 125
DQBput 1, dx + 110 - 8, dy + 26, VARSEG(save1(0)), VARPTR(save1(0))
DQBput 1, dx + 265, dy + 26, VARSEG(save2(0)), VARPTR(save2(0))


DQBput 1, dx + 107 + Volume, dy + 60 - 3, VARSEG(boutton2(0)), VARPTR(boutton2(0))
DQBput 1, dx + 176 + pan, dy + 60 - 3, VARSEG(boutton2(0)), VARPTR(boutton2(0))
'30 199 278 199

IF replay = 1 THEN
	DQBpset 1, dx + 216, dy + 93, 125  '230 135
	DQBpset 1, dx + 215, dy + 93, 122    '230 135

END IF

IF mouse THEN DQBput 1, mx, my, VARSEG(mouse(0)), VARPTR(mouse(0))


END SUB

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
SUB fmsongclose
	stopfms         'Stoppe le fms en cours
	resetallchannel 'enleve tout les channels
	FOR n% = 0 TO 224: writereg n%, 0: NEXT n%
END SUB

FUNCTION fmsonginit
	 writereg 4, &H60
	 writereg 4, &H80
	 data1% = INP(&H388)
	 writereg 2, &HFF
	 writereg 4, &H21
	 FOR d% = 1 TO 150: x% = INP(&H388): NEXT d%
	 data2% = INP(&H388)
	 writereg 4, &H60
	 writereg 4, &H80
	 IF (data1% AND &HE0) = 0 AND (data2% AND &HE0) = &HC0 THEN DetectFM% = -1
	IF NOT DetectFM% THEN fmsonginit = -1: EXIT FUNCTION
       

	'initialisation du FM
	 FOR n% = 0 TO &HF5
	  writereg n%, 0
	 NEXT n%
       
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
' Retourne le maximum de notes dans cette la musique actuelle
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

FOR i = 1 TO trackactuel + 1 - 1        'on enläve 1 parceque c'est loop note
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


OPEN f$ FOR BINARY AS #1
IF LOF(1) = 0 THEN loadfms = -1: CLOSE #1: KILL f$: EXIT FUNCTION

'l'entàte
SEEK #1, 1
var$ = "               "
GET #1, , var$
IF var$ <> "fm-song-project" THEN loadfms = -1: PCOPY 2, 1: CLOSE #1: EXIT FUNCTION


'l'auteur
GET #1, , pname$
GET #1, , auteur
GET #1, , commentaire
GET #1, , maxtrack

resizetrack maxtrack

'les instruments
FOR k = 1 TO 8        'les channels
	GET #1, , ins(k).iname
	i1$ = " "
	i2$ = " "
	GET #1, , i1$
	GET #1, , i2$
		   ins(k).attack1 = ASC(i1$)
		   ins(k).attack2 = ASC(i2$)
	    
		   i1$ = " "
		   i2$ = " "
		   GET #1, , i1$
		   GET #1, , i2$
		   ins(k).decay1 = ASC(i1$)
		   ins(k).decay2 = ASC(i2$)
	   
		   i1$ = " "
		   i2$ = " "
		   GET #1, , i1$
		   GET #1, , i2$
		   ins(k).sustain1 = ASC(i1$)
		   ins(k).sustain2 = ASC(i2$)
	    
		   i1$ = " "
		   i2$ = " "
		   GET #1, , i1$
		   GET #1, , i2$
		   ins(k).released1 = ASC(i1$)
		   ins(k).released2 = ASC(i2$)
	    
	    
		   i1$ = " "
		   i2$ = " "
		   GET #1, , i1$
		   GET #1, , i2$
		   ins(k).outp1 = ASC(i1$)
		   ins(k).outp2 = ASC(i2$)
	    
	    
		   i1$ = " "
		   i2$ = " "
		   GET #1, , i1$
		   GET #1, , i2$
		   ins(k).scalling1 = ASC(i1$)
		   ins(k).scalling2 = ASC(i2$)

	    
	    
		   i1$ = " "
		   i2$ = " "
		   GET #1, , i1$
		   GET #1, , i2$
		   ins(k).amplitudevibrato1 = ASC(i1$)
		   ins(k).amplitudevibrato2 = ASC(i2$)

		   i1$ = " "
		   i2$ = " "
		   GET #1, , i1$
		   GET #1, , i2$
		   ins(k).pitchvibrato1 = ASC(i1$)
		   ins(k).pitchvibrato2 = ASC(i2$)
	    
		   i1$ = " "
		   i2$ = " "
		   GET #1, , i1$
		   GET #1, , i2$
		   ins(k).frequencymultipler1 = ASC(i1$)
		   ins(k).frequencymultipler2 = ASC(i2$)
	    
		   i1$ = " "
		   i2$ = " "
		   GET #1, , i1$
		   GET #1, , i2$
		   ins(k).enveloppescalling1 = ASC(i1$)
		   ins(k).enveloppescalling2 = ASC(i2$)
	    
		   i1$ = " "
		   i2$ = " "
		   GET #1, , i1$
		   GET #1, , i2$
		   ins(k).waveselect1 = ASC(i1$)
		   ins(k).waveselect2 = ASC(i2$)
	    
	    
		   i1$ = " "
		   i2$ = " "
		   GET #1, , i1$
		   GET #1, , i2$
		   ins(k).feedback = ASC(i1$)
		   ins(k).connection = ASC(i2$)
		  
		   i1$ = " "
		   i2$ = " "
		   GET #1, , i1$
		   GET #1, , i2$
		   ins(k).sustaininglevel1 = ASC(i1$)
		   ins(k).sustaininglevel2 = ASC(i2$)


'------- fin du chargement de l'instrument
NEXT



'la track
FOR i = 1 TO maxtrack
	GET #1, , maxnotes(i)       'les max notes
	    'il put l'instrument
	GET #1, , trackdelay(i)
	    'find de put instrument
    
	'put les channels dans le fichier
      
	FOR cn = 1 TO 8
		sc$ = " ": GET #1, , sc$
		num = ASC(sc$)
		IF num = 1 THEN ch.enabled(i, cn) = -1
       
	NEXT
	
		FOR k = 1 TO 8
		   FOR j = 0 TO maxnotes(i) - 1     'les notes
			n1$ = " "
			GET #1, , n1$
			notes(i, k, j) = ASC(n1$)
		   
		    NEXT
		NEXT
NEXT

CLOSE #1
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

playfms
mystring = CHR$(34) + LTRIM$(RTRIM$(pname$)) + CHR$(34) + " Par " + RTRIM$(LTRIM$(auteur)) + " - " + RTRIM$(LTRIM$(commentaire)) + " - "
'GET #1, , pname$
'GET #1, , auteur
'GET #1, , commentaire
'GET #1, , maxtrack


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

SUB loopit
'dqbcopylayer 2, 1
'vol = ((Volume * 14) / maxvolume) + 1
'setvolume vol, vol

mx = DQBmouseX
my = DQBmouseY
mb = mymouseb

	posi = getpositionnote - 1
	IF posi < 0 THEN posi = 0
	fp = (posi * 218&) / maxno     'calcul de pourcentage
	positionb = fp


IF TIMER - d! >= .001 THEN
    
      scx = scx + 1
     IF scx >= 8 THEN
	scroll mystring
	scx = 0
     END IF
    
     
	d! = TIMER

END IF

IF replay = 0 THEN
	IF loopnote + 1 > maxnotes(trackactuel + 1) THEN
		IF trackactuel + 1 >= maxtrack THEN
		      pausefms
		      trackactuel = 0
		      loopnote = 0
		END IF
	END IF
END IF

loopfms



END SUB

FUNCTION mymouseb

IF TIMER - bouttontime! > .4 THEN mymouseb = DQBmouseLB%

END FUNCTION

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

FUNCTION opt$ (num)
'------------------------------------------------------------------------
'fonction par Asher256
'------------------------------------------------------------------------
'                            - Explications -
'
'Cette fonction lit les options donnees avec une commande msdos par exemple
'si vous avez fait un programme loadtxt.exe qui charge des fichier *.txt
'alors vous pouvez Çcrire:
'
'                     C:\>Loadtxt.exe fichier.txt
'
'c'est comme dans un fichier batch ou on a l'option %0 ou %1 ou %2...
'OK voila un exemple pour connaitre l'option %1 :
'
'                              DIM cmd AS STRING
'                              cmd = opt$(1)
'                              PRINT cmd
'
'compilez ce programme en *.Exe en fichier test.exe et ecrivez dans votre
'commande MSDOS:
'                     C:\>test option1
'
'alors vous recevez dans votre Çcran la chaine de caractaire Option1.
'vous pouvez faire la màme chose avec l'option 2 ou 3 ou 4...
'------------------------------------------------------------------------
'Pour tÇlÇcharger des tonnes de programmes utilitaires,jeux,graphisme qbasic
'alors rendez vous dans ma page web The QuickBasic world:
'                   ------------------------------
'                    https://qbworld.asher256.com
'                   ------------------------------
'------------------------------------------------------------------------


env$ = COMMAND$
IF MID$(env$, 1, 1) = "/" THEN env$ = MID$(env$, 2, LEN(env$))




FOR i = 1 TO LEN(env$)
IF MID$(env$, i, 1) = "/" THEN env$ = LEFT$(env$, i - 1) + " " + MID$(env$, i + 1, LEN(env$))

NEXT



DO
r = INSTR(r + 1, env$, " ")
nbropt = nbropt + 1
LOOP UNTIL r = 0

nbropt = nbropt - 1
IF num > nbropt THEN opt$ = "": EXIT FUNCTION
r = 0

IF num >= 0 THEN
   FOR i = 1 TO num
   r = INSTR(r + 1, env$, " ")
 
   NEXT

   debut = r
   fin = INSTR(debut + 1, env$, " ")

   IF fin = 0 THEN fin = LEN(env$) + 1

 

   opt$ = MID$(env$, debut + 1, fin - debut - 1)

   EXIT FUNCTION



END IF







END FUNCTION

SUB ouvrir
pausefms
x1 = 50
y1 = 65
x2 = x1 + 200
y2 = y1 + 75

DQBclearLayer 1

DQBput 1, x1, y1, VARSEG(dialogbox(0)), VARPTR(dialogbox(0))
DQBcopyLayer 1, 2


a$ = acinput$(chaine$, "", 8, x1 + (8 * 3) + 5, y1 + (8 * 7) + 2, 100)

erreur = 0
IF a$ = "" THEN
	resumefms
	EXIT SUB
END IF
IF INSTR(a$, ".") THEN erreur = -1



IF NOT erreur THEN
	IF loadfms(a$) THEN SOUND 1000, 3: EXIT SUB
ELSE
	SOUND 1000, 1
	h! = TIMER: DO: LOOP UNTIL TIMER - h! > .1
	SOUND 500, 4
END IF

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

SUB resetchan (chan)
	writereg &HA0 + chan - 1, 0
	writereg &HB0 + chan - 1, 0

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

SUB scroll (char AS STRING)


char = MID$(char, 2) + MID$(char, 1, 1)

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
 OUT &H388, Reg%
 FOR d% = 1 TO 6: x% = INP(&H388): NEXT d%
 OUT &H389, info%
 FOR d% = 1 TO 35: x% = INP(&H388): NEXT d%
 EXIT SUB
END SUB

