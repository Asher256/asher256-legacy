'########################################################################
'                       Code source de QbsMario
'                     Copyright (c) Asher256, 2000
'
' URL: https://qbworld.asher256.com
'########################################################################
DECLARE SUB func ()
DECLARE SUB func2 ()
DECLARE SUB func3 ()
DECLARE SUB func4 ()

image$ = "dir\"

PRINT "Loading..."

DEFINT A-Z
DIM SHARED thanks(220 * 10)
DEF SEG = VARSEG(thanks(0))
BLOAD image$ + "thanks.ext", VARPTR(thanks(0))
DEF SEG 

DIM SHARED thanks2(220 * 10)
DEF SEG = VARSEG(thanks2(0))
BLOAD image$ + "thanks2.ext", VARPTR(thanks2(0))
DEF SEG 

DIM SHARED bravo(120 * 30)
DEF SEG = VARSEG(bravo(0))
BLOAD image$ + "bravo.bsv", VARPTR(bravo(0))
DEF SEG               ' Restituer le segment BASIC par d‚faut.


DIM SHARED titre(244 * 88)
DEF SEG = VARSEG(titre(0))
BLOAD image$ + "titre.bsv", VARPTR(titre(0))
DEF SEG               ' Restituer le segment BASIC par d‚faut.


DIM SHARED menu(57 * 27)
DEF SEG = VARSEG(menu(0))
BLOAD image$ + "menu.bsv", VARPTR(menu(0))
DEF SEG               ' Restituer le segment BASIC par d‚faut.


DIM SHARED perdu(100 * 40)
DEF SEG = VARSEG(perdu(0))
BLOAD image$ + "perdux.bsv", VARPTR(perdu(0))
DEF SEG               ' Restituer le segment BASIC par d‚faut.
DIM SHARED fin(50 * 40)
DEF SEG = VARSEG(fin(0))
BLOAD image$ + "finx.bsv", VARPTR(fin(0))
DEF SEG               ' Restituer le segment BASIC par d‚faut.


DIM SHARED decore(20 * 20)
DEF SEG = VARSEG(decore(0))
BLOAD image$ + "decore.bsv", VARPTR(decore(0))
DEF SEG               ' Restituer le segment BASIC par d‚faut.

DIM SHARED decore2(20 * 20)
DEF SEG = VARSEG(decore2(0))
BLOAD image$ + "decore2.bsv", VARPTR(decore2(0))
DEF SEG               ' Restituer le segment BASIC par d‚faut.

DIM SHARED decore3(20 * 20)
DEF SEG = VARSEG(decore3(0))
BLOAD image$ + "decore3.bsv", VARPTR(decore3(0))

DEF SEG               ' Restituer le segment BASIC par d‚faut.
DIM SHARED decore4(20 * 20)
DEF SEG = VARSEG(decore4(0))
BLOAD image$ + "decore4.bsv", VARPTR(decore4(0))
DEF SEG               ' Restituer le segment BASIC par d‚faut.

DIM SHARED decore5(20 * 20)
DEF SEG = VARSEG(decore5(0))
BLOAD image$ + "decore5.bsv", VARPTR(decore5(0))
DEF SEG               ' Restituer le segment BASIC par d‚faut.
DIM SHARED decore6(20 * 20)
DEF SEG = VARSEG(decore6(0))
BLOAD image$ + "decore6.bsv", VARPTR(decore6(0))
DEF SEG              ' Restituer le segment BASIC par d‚faut.

DIM SHARED decore7(20 * 20)
DEF SEG = VARSEG(decore7(0))
BLOAD image$ + "decore7.bsv", VARPTR(decore7(0))
DEF SEG               ' Restituer le segment BASIC par d‚faut.

DIM SHARED decore8(20 * 20)
DEF SEG = VARSEG(decore8(0))
BLOAD image$ + "decore8.bsv", VARPTR(decore8(0))
DEF SEG               ' Restituer le segment BASIC par d‚faut.

DIM SHARED decore9(20 * 20)
DEF SEG = VARSEG(decore9(0))
BLOAD image$ + "decore9.bsv", VARPTR(decore9(0))
DEF SEG               ' Restituer le segment BASIC par d‚faut.


DIM SHARED rmario1(20 * 20)
DEF SEG = VARSEG(rmario1(0))
BLOAD image$ + "radam.bsv", VARPTR(rmario1(0))
DEF SEG               ' Restituer le segment BASIC par d‚faut.

DIM SHARED rmario2(20 * 20)
DEF SEG = VARSEG(rmario2(0))
BLOAD image$ + "radam2.bsv", VARPTR(rmario2(0))
DEF SEG               ' Restituer le segment BASIC par d‚faut.


DIM SHARED mario1(20 * 20)
DEF SEG = VARSEG(mario1(0))
BLOAD image$ + "adam.bsv", VARPTR(mario1(0))
DEF SEG               ' Restituer le segment BASIC par d‚faut.

DIM SHARED mario2(20 * 20)
DEF SEG = VARSEG(mario2(0))
BLOAD image$ + "adam2.bsv", VARPTR(mario2(0))
DEF SEG               ' Restituer le segment BASIC par d‚faut.


DIM SHARED tmario1(20 * 20)
DEF SEG = VARSEG(tmario1(0))
BLOAD image$ + "tadam.bsv", VARPTR(tmario1(0))
DEF SEG               ' Restituer le segment BASIC par d‚faut.

DIM SHARED tmario2(20 * 20)
DEF SEG = VARSEG(tmario2(0))
BLOAD image$ + "tadam2.bsv", VARPTR(tmario2(0))
DEF SEG               ' Restituer le segment BASIC par d‚faut.


DIM SHARED smario1(20 * 20)
DEF SEG = VARSEG(smario1(0))
BLOAD image$ + "sadam.bsv", VARPTR(smario1(0))
DEF SEG               ' Restituer le segment BASIC par d‚faut.


DIM SHARED smario2(20 * 20)
DEF SEG = VARSEG(smario2(0))
BLOAD image$ + "sadam2.bsv", VARPTR(smario2(0))
DEF SEG               ' Restituer le segment BASIC par d‚faut.

DIM SHARED mar(15 * 9)
DEF SEG = VARSEG(mar(0))
BLOAD image$ + "select.bsv", VARPTR(mar(0))
DEF SEG               ' Restituer le segment BASIC par d‚faut.


DEFINT P-Q

PRINT
PRINT

PRINT "      ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿    "
PRINT "      ³ QBasic Super Mario a ‚t‚ ‚crit en Quick Basic 4.5 par Asher256  ³     "
PRINT "      ³ (c) 2000.                                                       ³     "
PRINT "      ³                                                                 ³     "
PRINT "      ³ Mon site web:                                                   ³"
PRINT "      ³              +----------------------------------+               ³"
PRINT "      ³              -  https://qbworld.asher256.com    -               ³"
PRINT "      ³              +----------------------------------+               ³"
PRINT "      ³                                                                 ³"
PRINT "      ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ     "
COLOR 7, 0
DO
LOOP UNTIL INKEY$ = CHR$(13)

palette.fadeout

SCREEN 13
CLS
jascpal "palettes\mario.pal"

'<------------------FIN LOAD TO SPRITE--------------------->

DIM ox AS SINGLE
DIM oy AS SINGLE
DIM basi AS SINGLE
DIM bass AS SINGLE
DIM hauti AS SINGLE
DIM hauts AS SINGLE

'********************************************************
'                  L'INTRO de MARIO
'********************************************************


menu:

palette.fadeout

CLS
mariox = 0
marioy = 200 - 60

PUT (0, 200 - 40), mario1, PSET

FOR i = 0 TO 300 STEP 20
	PUT (i, 200 - 20), decore2, PSET
NEXT


PUT (30, 0), titre, PSET

'********************************************************
'                  FIN L'INTRO de MARIO
'********************************************************

'------------CHOIX
choix:
palette.fadein


choix = 1
PUT (120 - 16, 88 + 8 + 8), mar, PSET

DO

c$ = INKEY$
COLOR 155

PUT (120, 78 + 8 + 8 + 8), menu, PSET

'choisis un mode (start - credit - BYE...)
SELECT CASE c$

CASE CHR$(0) + CHR$(80)                   'bas
	IF choix < 3 THEN
		choix = choix + 1
		PUT (120 - 16, 88 + 8 + 8), mar, PSET
		PUT (120 - 16, 96 + 8 + 8), mar, PSET
		PUT (120 - 16, 104 + 8 + 8), mar, PSET
		PUT (120 - 16, 88 + 8 + 8), mar, XOR
		PUT (120 - 16, 96 + 8 + 8), mar, XOR
		PUT (120 - 16, 104 + 8 + 8), mar, XOR
		IF choix = 1 THEN PUT (120 - 16, 88 + 8 + 8), mar, PSET
		IF choix = 2 THEN PUT (120 - 16, 96 + 8 + 8), mar, PSET
		IF choix = 3 THEN PUT (120 - 16, 104 + 8 + 8), mar, PSET
	END IF

CASE CHR$(0) + CHR$(72)               'haut

	IF choix > 1 THEN
		choix = choix - 1

		PUT (120 - 16, 88 + 8 + 8), mar, PSET
		PUT (120 - 16, 96 + 8 + 8), mar, PSET
		PUT (120 - 16, 104 + 8 + 8), mar, PSET
		PUT (120 - 16, 88 + 8 + 8), mar, XOR
		PUT (120 - 16, 96 + 8 + 8), mar, XOR
		PUT (120 - 16, 104 + 8 + 8), mar, XOR
		IF choix = 1 THEN PUT (120 - 16, 88 + 8 + 8), mar, PSET
		IF choix = 2 THEN PUT (120 - 16, 96 + 8 + 8), mar, PSET
		IF choix = 3 THEN PUT (120 - 16, 104 + 8 + 8), mar, PSET
	END IF
END SELECT

LOOP UNTIL c$ = CHR$(13)

SELECT CASE choix
CASE 1
	palette.fadeout
	GOTO deb

CASE 2
	palette.fadeout
	CLS
	GOSUB credits
	GOTO menu

GOTO choix

CASE 3
	palette.fadeout
	CLS
	palette.fadein
	CLEAR : RESET: SCREEN 0: WIDTH 80, 25
	quitter
END SELECT

deb:
CLS
'###################ouverture et lecture de stage.ach
OPEN "ind\mario.stg" FOR INPUT AS #1

DO UNTIL LEFT$(ph$, 4) = "NSTG"
LINE INPUT #1, ph$
LOOP

nstg = VAL(RIGHT$(ph$, LEN(ph$) - 5))

DIM obstacle(160)

GOSUB lecture
GOSUB affiche



PUT (mariox, marioy), mario1, PSET




'********************************************************
'                      TEST CLAVIER
'********************************************************
palette.fadein


debut:
ox = 0
oy = 0

DO
c$ = INKEY$

IF ox = 16 THEN GOTO gagne
		
IF c$ = CHR$(0) + CHR$(77) AND mariox < 300 THEN         'droite
	bouge = 1
	IF testb = 0 THEN dx = 10
	IF testb = 1 THEN dx = 20: testb = 0
	GOSUB testd
	GOSUB mariobouged
END IF

IF c$ = CHR$(0) + CHR$(75) AND mariox > 0 THEN          'gauche
	bouge = 2
	IF testb = 0 THEN dx = -10
	IF testb = 1 THEN dx = -20: testb = 0
	GOSUB testg
	GOSUB mariobougeg
END IF

IF c$ = CHR$(0) + CHR$(72) AND mariox < 300 THEN      'haut
	IF ba = 0 THEN
		FOR e = 1 TO 3
			dy = -20
			GOSUB testh
			GOSUB mariobougeh
			IF c$ = CHR$(0) + CHR$(77) THEN bouge = 1: hb = 1: EXIT FOR
			IF c$ = CHR$(0) + CHR$(75) THEN bouge = 2: hb = 1: EXIT FOR
		NEXT e
	       
		CALL clearkeyboard
		c$ = ""
		IF hb = 1 THEN GOSUB hbouge
		hb = 0
	END IF
END IF


'aller en test bas pour "si bas=0 alors mario tombe"
GOSUB testb

LOOP UNTIL UCASE$(c$) = CHR$(27)

'--- configuration pour terminer
palette.fadeout
CLS
CLOSE #1
palette.fadein
'aller au menu principal
GOTO menu

'<-----------------SUB MARIO BOUGE DROITE---------------------->
mariobouged:
c$ = INKEY$

IF dx = 0 THEN RETURN

IF ba = 1 THEN          'si mario est en train de tomber alors il tombe sans marcher
 tpause 1

 PUT (mariox, marioy), tmario1, PSET
 PUT (mariox, marioy), tmario1, XOR


 FOR droit = 1 TO dx STEP 5
 PUT (mariox + droit, marioy), tmario1, PSET
 tpause 1
 PUT (mariox + droit, marioy), tmario1, XOR
 NEXT


 mariox = mariox + dx
 PUT (mariox, marioy), tmario1, PSET
 PUT (mariox, marioy), tmario1, PSET

 tpause 1
 CALL clearkeyboard
 dx = 0
 RETURN

END IF

tpause .01

PUT (mariox, marioy), mario1, PSET
PUT (mariox, marioy), mario1, XOR


FOR droit = 1 TO dx STEP 5
PUT (mariox + droit, marioy), mario2, PSET
tpause 1
PUT (mariox + droit, marioy), mario2, XOR
NEXT


mariox = mariox + dx
PUT (mariox, marioy), mario1, PSET
PUT (mariox, marioy), mario1, PSET

'tpause 1



dx = 0

CALL clearkeyboard

RETURN
'<-----------------FIN SUB MARIO BOUGE DROITE---------------------->


'<-----------------SUB MARIO BOUGE GAUCHE---------------------->
mariobougeg:
c$ = INKEY$

IF dx = 0 THEN RETURN

IF ba = 1 THEN          'si mario est en train de tomber alors il tombe sans marcher
 tpause 1

 PUT (mariox, marioy), tmario2, PSET
 PUT (mariox, marioy), tmario2, XOR


 FOR gauche = 1 TO (dx * -1) STEP 5
 s = gauche * -1
 PUT (mariox + s, marioy), tmario2, PSET
 tpause 1
 PUT (mariox + s, marioy), tmario2, XOR
 NEXT


 mariox = mariox + dx
 PUT (mariox, marioy), tmario2, PSET
 PUT (mariox, marioy), tmario2, PSET

' tpause 1

 dx = 0
 RETURN
END IF




PUT (mariox, marioy), rmario1, PSET
PUT (mariox, marioy), rmario1, XOR

FOR gauche = 1 TO (dx * -1) STEP 5
s = gauche * -1
PUT (mariox + s, marioy), rmario2, PSET
tpause .0001
PUT (mariox + s, marioy), rmario2, XOR
NEXT


mariox = mariox + dx
PUT (mariox, marioy), rmario1, PSET
PUT (mariox, marioy), rmario1, PSET
tpause 1


dx = 0


CALL clearkeyboard

RETURN
'<-----------------FIN SUB MARIO BOUGE---------------------->

'<-----------------SUB LECTURE---------------------->
'sub qui lit le stage dans le fichier !!
lecture:
d = 0

DO UNTIL LEFT$(ph$, 5) = "[ STG"
LINE INPUT #1, ph$
IF EOF(1) = -1 THEN GOTO fin
LOOP

'------lit la position de mariox
DO UNTIL LEFT$(ph$, 6) = "MARIOX"
LINE INPUT #1, ph$
IF EOF(1) = -1 THEN SYSTEM
LOOP

pmariox = VAL(MID$(ph$, 8, LEN(ph$) - 7))

DO UNTIL LEFT$(ph$, 6) = "MARIOY"
LINE INPUT #1, ph$
IF EOF(1) = -1 THEN SYSTEM
LOOP

pmarioy = VAL(MID$(ph$, 8, LEN(ph$) - 7))
'--------

mariox = pmariox
marioy = pmarioy

FOR i = 1 TO 10
LINE INPUT #1, ph$

FOR j = 1 TO 16
d = d + 1

obstacle(d) = VAL(MID$(ph$, j + 1, 1))
NEXT
NEXT




RETURN

'<-----------------FIN SUB LECTURE---------------------->



'<-----------------SUB TESTD---------------------->
testd:

'/10 parceque chaque bloque vaut 2
'+1 pour que 0 devient 1



ox = ((mariox / 20) + 1)


oy = (marioy / 20) + 1


'FOR i = 0 TO 16
'IF ox = i THEN GOTO gh
'RETURN
'NEXT


IF ox = INT(ox) THEN GOTO gh ELSE RETURN

gh:



obs = ((oy * 16) - (16 - INT(ox + 1)))



SELECT CASE obstacle(obs)




CASE 1
ox = 0
dx = 0


CASE 2
ox = 0
dx = 0


CASE 3
ox = 0
dx = 0


CASE 4
ox = 0
dx = 0


CASE 5
ox = 0
dx = 0


CASE 6
ox = 0
dx = 0

CASE 7
ox = 0
dx = 0

CASE 8
ox = 0
dx = 0

CASE 9
ox = 0
dx = 0



END SELECT



RETURN
'<-----------------FIN SUB TEST DROITE---------------------->

'<-----------------SUB TEST GAUCHE---------------------->
testg:

'/10 parceque chaque bloque vaut 2
'+1 pour que 0 devient 1


'ox est la position X en carraux
ox = (mariox / 20)


oy = (marioy / 20) + 1

IF ox = 0 THEN dx = 0: RETURN
IF ox = INT(ox) THEN GOTO gh2 ELSE RETURN

gh2:



obs = ((oy * 16) - (16 - INT(ox)))



SELECT CASE obstacle(obs)


CASE 1
ox = 0
dx = 0



CASE 2
ox = 0
dx = 0


CASE 3

ox = 0
dx = 0

CASE 4
ox = 0
dx = 0

CASE 5
ox = 0
dx = 0

CASE 6
ox = 0
dx = 0

CASE 7
ox = 0
dx = 0

CASE 8
ox = 0
dx = 0

CASE 9
ox = 0
dx = 0


END SELECT



RETURN
'<-----------------FIN SUB TEST---------------------->



'<-----------------SUB affiche---------------------->
affiche:
d = 0

FOR y = 0 TO 180 STEP 20
FOR x = 0 TO 300 STEP 20
d = d + 1


SELECT CASE obstacle(d)

CASE 1
PUT (x, y), decore, PSET


CASE 2
PUT (x, y), decore2, PSET

CASE 3
PUT (x, y), decore3, PSET


CASE 4
PUT (x, y), decore4, PSET

CASE 5
PUT (x, y), decore5, PSET

CASE 6
PUT (x, y), decore6, PSET



CASE 7
PUT (x, y), decore7, PSET

CASE 8
PUT (x, y), decore8, PSET

CASE 9
PUT (x, y), decore9, PSET


END SELECT

NEXT
NEXT


RETURN



'<-----------------FIN SUB affiche---------------------->



'<-----------------SUB test bas---------------------->
testb:

'ox oy sont les position de mario en CARRAUX



ox = (mariox / 20) + 1
oy = (marioy / 20) + 1

IF oy = 10 THEN GOTO perdu

	IF ox <> INT(ox) THEN
		basi = ((oy + 1) * 16) - (16 - (INT(ox)))
		bass = ((oy + 1) * 16) - (16 - (INT(ox) + 1))

		IF obstacle(basi) = 0 AND obstacle(bass) = 0 THEN dy = 20: GOSUB mariobougeb: RETURN

		RETURN
	END IF

bas = ((oy + 1) * 16) - (16 - ox)

SELECT CASE obstacle(bas)
	CASE 0
		ba = 1     'var pour deplacement droit et gauche
		testb = 1
		dy = 20
		GOSUB mariobougeb
	CASE IS <> 0
		ba = 0
		IF bouge = 1 OR bouge = 0 THEN PUT (mariox, marioy), mario1, PSET
		IF bouge = 2 THEN PUT (mariox, marioy), rmario1, PSET
END SELECT

RETURN
'<-----------------FIN test bas---------------------->

'<-----------------mario bouge bas---------------------->
mariobougeb:



IF bouge = 1 OR bouge = 0 THEN
PUT (mariox, marioy), tmario1, PSET
PUT (mariox, marioy), tmario1, XOR

FOR i = 1 TO dy STEP 5
	PUT (mariox, marioy + i), tmario1, PSET
	tpause .001
	PUT (mariox, marioy + i), tmario1, XOR
NEXT

marioy = marioy + dy
PUT (mariox, marioy), tmario1, PSET


dy = 0
END IF

'------->>
IF bouge = 2 THEN                                   'si c'est gauche

PUT (mariox, marioy), tmario2, PSET
'tpause .001
PUT (mariox, marioy), tmario2, XOR

FOR i = 1 TO dy STEP 5
	PUT (mariox, marioy + i), tmario2, PSET
	tpause .0001
	PUT (mariox, marioy + i), tmario2, XOR
NEXT


marioy = marioy + dy
PUT (mariox, marioy), tmario2, PSET

dy = 0
CALL clearkeyboard


END IF

RETURN
'<-----------------FIN mario bouge bas---------------------->


'<-----------------TEST HAUT---------------------->
testh:
'sub de test s'il ya un obstacle en haut

ox = (mariox / 20) + 1
oy = (marioy / 20) + 1

IF oy = 1 THEN dy = 0: RETURN

	IF ox <> INT(ox) THEN
		hauti = ((oy - 1) * 16) - (16 - INT(ox))    'Nø d'obstacle en haut dans le tableau
		hauts = ((oy - 1) * 16) - (16 - INT(ox + 1))  'Nø d'obstacle en haut dans le tableau

		IF obstacle(hauts) <> 0 OR obstacle(hauti) <> 0 THEN dy = 0: RETURN

		RETURN
	END IF

	haut = ((oy - 1) * 16) - (16 - INT(ox))    'Nø d'obstacle en haut dans le tableau

	IF obstacle(haut) <> 0 THEN dy = 0

RETURN
'<-----------------FIN TEST HAUT---------------------->


'<-----------------MARIO BOUGE HAUT---------------------->
mariobougeh:
c$ = INKEY$

IF dy = 0 THEN RETURN

	IF bouge = 1 OR bouge = 0 THEN
		PUT (mariox, marioy), smario1, PSET
		PUT (mariox, marioy), smario1, XOR

		FOR saut = 1 TO (dy * -1) STEP 5
			PUT (mariox, marioy - (saut)), smario1, PSET
			tpause 1
			PUT (mariox, marioy - (saut)), smario1, XOR
		NEXT saut

		PUT (mariox, marioy - 20), smario1, PSET
		PUT (mariox, marioy - 20), smario1, XOR
		marioy = marioy + dy
		PUT (mariox, marioy), smario1, PSET
	END IF

IF bouge = 2 THEN
	PUT (mariox, marioy), smario2, PSET
	PUT (mariox, marioy), smario2, XOR


	FOR saut = 1 TO (dy * -1) STEP 5
		PUT (mariox, marioy - (saut)), smario2, PSET
		tpause 1
		PUT (mariox, marioy - (saut)), smario2, XOR
	NEXT saut

	PUT (mariox, marioy - 20), smario2, PSET
	PUT (mariox, marioy - 20), smario2, XOR

	marioy = marioy + dy

	PUT (mariox, marioy), smario2, PSET
END IF

dy = 0

RETURN
'<-----------------MARIO BOUGE HAUT---------------------->


'<-----------------HBOUGE---------------------->
hbouge:
GOSUB bougeh

FOR i = 1 TO 2

c$ = INKEY$
IF c$ = CHR$(0) + CHR$(77) THEN c$ = "": bouge = 1: GOSUB bougeh
IF c$ = CHR$(0) + CHR$(75) THEN c$ = "": bouge = 2: GOSUB bougeh

'IF c$ = "" THEN c$ = "": e = 3: RETURN

c$ = ""
NEXT
CALL clearkeyboard

RETURN

bougeh:

IF bouge = 1 OR bouge = 0 THEN dx = 20
IF bouge = 2 THEN dx = -20



IF dx = 0 THEN RETURN

IF bouge = 1 OR 0 THEN IF mariox >= 300 THEN RETURN
IF bouge = 2 THEN IF mariox <= 0 THEN RETURN

IF bouge = 1 OR bouge = 0 THEN


PUT (mariox, marioy), smario1, PSET
PUT (mariox, marioy), smario1, XOR

FOR z = 1 TO 2
	GOSUB testd

	FOR hbouged = 1 TO dx / 2 STEP 5
		PUT (mariox + hbouged, marioy), smario1, PSET
		tpause 1
		PUT (mariox + hbouged, marioy), smario1, XOR
	NEXT

	mariox = mariox + (dx / 2)
	PUT (mariox, marioy), smario1, PSET
NEXT
END IF
IF bouge = 2 THEN

PUT (mariox, marioy), smario2, PSET
PUT (mariox, marioy), smario2, XOR


FOR z = 1 TO 2
	GOSUB testg

	FOR hbougeg = 1 TO (dx * -1) / 2 STEP 5
		s = hbougeg * -1
		PUT (mariox + s, marioy), smario2, PSET
		tpause 1
		PUT (mariox + s, marioy), smario2, XOR
	NEXT

	mariox = mariox + (dx / 2)
	PUT (mariox, marioy), smario2, PSET

NEXT
END IF

dx = 0
dy = 0
c$ = ""
RETURN
'<-----------------FIN HBOUGE---------------------->


perdu:


palette.fadeout
CLS
COLOR 14
LOCATE 12, 13
PUT (110, 80), perdu, PSET
palette.fadein
DO
LOOP UNTIL INKEY$ = CHR$(13)
palette.fadeout
CLS
marioy = pmarioy
mariox = pmariox
PUT (mariox, marioy), mario1, PSET
GOSUB affiche
palette.fadein


GOTO debut

gagne:
CLS
GOSUB lecture
GOSUB affiche
PUT (mariox, marioy), mario1, PSET
GOTO debut

credits:
loadbmp image$ + "marion.bmp", 50, 0

FOR i = 0 TO 300 STEP 20
PUT (i, 0), decore5, PSET
PUT (i, 180), decore5, PSET
NEXT

FOR i = 0 TO 180 STEP 20
PUT (0, i), decore5, PSET
PUT (300, i), decore5, PSET
NEXT

palette.fadein

a$ = INPUT$(1)
RETURN

'################### FIN DU JEU
fin:
CLOSE #1


palette.fadeout
PUT (100, 85), bravo, PSET

palette.fadein

CLS
FOR i = 1 TO 9

	PUT (100, 85), bravo, PSET

	LOCATE 12, 13
	tpause 7

	PUT (100, 85), bravo, XOR
	tpause 7
NEXT

palette.fadeout
CLS
loadbmp image$ + "marion.bmp", 50, 0
palette.fadein

tpause 50
'XPAUSE 16


palette.fadeout
CLS
COLOR 255
PUT (45, 90), merci, PSET
palette.fadein
tpause 120

palette.fadeout
CLS

PUT (135, 80), fin, PSET
palette.fadein



tpause 120

SLEEP





clearkeyboard

CLOSE #1

GOTO menu

DEFSNG A-Z
SUB clearkeyboard

'*******************************************************************************
'*  clears the keyboard buffer to help prevent accidental keystrokes           *
'*******************************************************************************

		FOR x% = 1 TO 14
				a$ = INKEY$
		NEXT x%
	
		END SUB

FUNCTION int2str$ (sword%)
'This function is translating SWORD Integers into a string. Its only use
'is when you still use asm$ for assembler functions( like i do). In that
'case you can make your integer values usable ..
'THis function simply translates the hexa bytes
'into stringbytes as is.
'----------------------------------------------------
DEF SEG = VARSEG(sword%)
ptr% = VARPTR(sword%)
int2str$ = CHR$(PEEK(ptr%)) + CHR$(PEEK(ptr% + 1))
DEF SEG

END FUNCTION

DEFINT A-Z
SUB jascpal (palname$)
IF INSTR(palname$, ".") = 0 THEN palname$ = palname$ + ".pal"
temp% = FREEFILE
OPEN palname$ FOR INPUT AS #temp%
INPUT #temp%, jpt$
IF UCASE$(jpt$) <> "JASC-PAL" THEN EXIT SUB
INPUT #temp%, jpt$
INPUT #temp%, totcols%
FOR ljp% = 0 TO totcols% - 1
INPUT #temp%, jpt$
jp1% = VAL(LEFT$(jpt$, INSTR(jpt$, CHR$(32))))
jpt$ = RIGHT$(jpt$, LEN(jpt$) - INSTR(jpt$, CHR$(32)))
jp2% = VAL(LEFT$(jpt$, INSTR(jpt$, " ")))
jpt$ = RIGHT$(jpt$, LEN(jpt$) - INSTR(jpt$, CHR$(32)))
jp3% = VAL(jpt$)
OUT &H3C8, ljp%
OUT &H3C9, (jp1% / 255) * 63
OUT &H3C9, (jp2% / 255) * 63
OUT &H3C9, (jp3% / 255) * 63
NEXT
CLOSE #temp%
END SUB

DEFSNG A-Z
SUB loadbmp (Pic$, x%, y%)

'Maximum size of buffer, change to 19000 for QBasic-
BufferMax% = 32767
OPEN Pic$ FOR BINARY AS #1
'Read width and height of image-
GET #1, 19, BMPWidth%
GET #1, 23, BMPHeight%
'Each raster must be a multiple of 4 bytes, this next line takes
'care of 'padded' bytes at the end of rasters of odd-width images-
IF BMPWidth% / 4 <> BMPWidth% \ 4 THEN PadBytes% = 4 - (BMPWidth% MOD 4)
'Read the entire palette into a buffer-
a$ = SPACE$(1024)
GET #1, 55, a$
'Decode the palette from the buffer-
FOR i% = 0 TO 255
	Blue% = ASC(MID$(a$, i% * 4 + 1, 1)) \ 4
	Green% = ASC(MID$(a$, i% * 4 + 2, 1)) \ 4
	Red% = ASC(MID$(a$, i% * 4 + 3, 1)) \ 4
	'Henshaw's routine for faster palette setting
	SetPalette i%, Red%, Green%, Blue%
NEXT i%
n& = 1079
a% = BufferMax%
a% = a% - (BufferMax% MOD (BMPWidth% + PadBytes%)) 'Find usable buffer size-
B% = a% \ (BMPWidth% + PadBytes%) - 1              'Find rasters per buffer-
a$ = SPACE$(a%)
k% = BMPHeight% - 1
'If current buffer is off screen, read another-
DO WHILE k% - B% > (199 - y%)
	'Read a buffer's worth-
	GET #1, n&, a$
	'Move file pointer forward by buffer size-
	n& = n& + a%
	'Decrease image line counter
	k% = k% - B%
LOOP
DO
	'Read a buffer's worth-
	GET #1, n&, a$
	'(B% + 1) worth of rasters in buffer-
	FOR i% = 0 TO B%
		'BMPWidth% = pixels per raster-
		FOR j% = 0 TO (BMPWidth% - 1)
			'Decode each pixel from buffer-
			c% = ASC(MID$(a$, i% * (BMPWidth% + PadBytes%) + j% + 1, 1))
			'If pixel falls in viewing area, plot it-
			IF j% < (320 - x%) AND k% < (200 - y%) THEN PSET (j% + x%, k% + y%), c%
		NEXT j%
		'Done with this raster line, on to the next-
		k% = k% - 1
		'K% < 0 condition must be checked, in case data at end of file
		'does not completely fill the final buffer read-
		IF k% < 0 THEN EXIT FOR
	NEXT i%
	'Move file pointer forward by buffer size-
	n& = n& + a%
'If K% is not < 0, there's more image-
LOOP UNTIL k% < 0
'Put a fork in it, it's done-
CLOSE #1

END SUB

DEFINT A-Z
SUB palette.fadein

tpause 7


DIM tT(1 TO 3)
FOR i = 1 TO 64
WAIT &H3DA, 8, 8
	FOR O = 0 TO 255
		Palette.Get O, PAL
		tT(1) = PAL.Red
		tT(2) = PAL.Green
		tT(3) = PAL.Blue
		IF tT(1) < pdata(O, 1) THEN tT(1) = tT(1) + 1
		IF tT(2) < pdata(O, 2) THEN tT(2) = tT(2) + 1
		IF tT(3) < pdata(O, 3) THEN tT(3) = tT(3) + 1
		PAL.Red = tT(1)
		PAL.Green = tT(2)
		PAL.Blue = tT(3)
		Palette.Set O, PAL
	NEXT O
NEXT i

END SUB

SUB palette.fadeout
DIM tT(1 TO 3)

tpause 7

FOR i = 0 TO 255
	Palette.Get i, PAL
	pdata(i, 1) = PAL.Red
	pdata(i, 2) = PAL.Green
	pdata(i, 3) = PAL.Blue
NEXT i
FOR i = 1 TO 64
WAIT &H3DA, 8, 8
	FOR O = 0 TO 255
		Palette.Get O, PAL
		tT(1) = PAL.Red
		tT(2) = PAL.Green
		tT(3) = PAL.Blue
		IF tT(1) > 0 THEN tT(1) = tT(1) - 1
		IF tT(2) > 0 THEN tT(2) = tT(2) - 1
		IF tT(3) > 0 THEN tT(3) = tT(3) - 1
		PAL.Red = tT(1)
		PAL.Green = tT(2)
		PAL.Blue = tT(3)
		Palette.Set O, PAL
	NEXT O
NEXT i

tpause 4

END SUB

SUB Palette.Get (nColor%, pInfo AS PaletteType)
OUT &H3C6, &HFF
OUT &H3C7, nColor%
pInfo.Red = INP(&H3C9)
pInfo.Green = INP(&H3C9)
pInfo.Blue = INP(&H3C9)
END SUB

SUB Palette.Set (nColor%, pInfo AS PaletteType)
OUT &H3C6, &HFF
OUT &H3C8, nColor%
OUT &H3C9, pInfo.Red
OUT &H3C9, pInfo.Green
OUT &H3C9, pInfo.Blue
END SUB

SUB quitter
'        SHELL "ind\sbmidi/u"
'        SHELL "ind\sbsim/u"
	SYSTEM
END SUB

SUB SetPalette (Attr%, Red%, Green%, Blue%)
OUT &H3C7, Attr%
OUT &H3C8, Attr%
OUT &H3C9, Red%
OUT &H3C9, Green%
OUT &H3C9, Blue%
END SUB

SUB tpause (sec!)

DEF SEG = &H40
Lo& = PEEK(&H6C) + 256& * PEEK(&H6D)
Hi& = PEEK(&H6E) + 256& * PEEK(&H6F)
time& = (65536 * Hi&) + Lo&

current& = time&
d! = sec!



WHILE time& < (current& + d!)
DEF SEG = &H40
Lo& = PEEK(&H6C) + 256& * PEEK(&H6D)
Hi& = PEEK(&H6E) + 256& * PEEK(&H6F)
time& = (65536 * Hi&) + Lo&

WEND

END SUB

