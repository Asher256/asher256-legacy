'***************************************************************************
'* CRAZY BALL v1.0
'* Une petite demo de balle qui rebondit Par Asher256 de
'* - Thunder Software 2001 -.
'*
'* Ce programme est ‚crit avec le quick basic 4.5 pour tout le peuple de
'* the qbasic world - http://www.qbworld.fr.st -
'*
'* Si vous ˆtes programmeur en qbasic alors n'hesitez pas … m'envoyer
'* votre cr‚ation elle figurera dans the qbworld.
'*
'* Voil… et merci d'avoir essay‚ cette demo !
'*
'*                                              
'*                                                   Asher256
'*                                                  ~~~~~~~~~~
'*                       [[[    E N J O Y ! ! !   ]]]
'*
'*
'***************************************************************************


DECLARE SUB myprint (texte$, l%, c%, coul%)
DECLARE SUB printgris (texte$, l%, c%, d%)
DECLARE SUB couleur ()
DECLARE SUB putx (x1 AS INTEGER, y1 AS INTEGER, x2 AS INTEGER, y2 AS INTEGER, coul AS INTEGER, coulr AS INTEGER)
DECLARE SUB mouse.hide ()
DECLARE SUB mouse.locate (x%, y%)
DECLARE SUB mouse.show ()
DECLARE SUB MOUSESTAT (b1%, B2%, l%, c%)
DECLARE SUB mouse (ax%, bx%, cx%, dx%)




DEFINT A-Z
SCREEN 13
CLS
f = 4
myprint "Asher256, 2001", f, 10, 23
myprint "- Crazy ball v1.5 (7 Mai 2001) -", f + 4, 4, 23
myprint "Demonstration: Balle qui rebondit.", f + 6, 1, 23
myprint "Page Web:", f + 8, 1, 23
myprint "https://qbworld.asher256.com", f + 10, 8, 24


a$ = INPUT$(1)

DEFINT A-Z
x = 1
x = 1

DIM balle(20 * 20)
coul = 21

'-----------------creation du sprite
FOR i = 9 TO 1 STEP -1
        coul = coul + 1
        CIRCLE (10, 10), i, coul
        PAINT (10, 10), coul
NEXT

GET (1, 1)-(20, 20), balle
'-------------------------------------
CLS





CLS

x = x%
y = y%






'1 Diag Droite Bas
'2 Diag Droite Haut
'3 Diag Gauche Bas
'4 Diag Gauche Haut
f = 20
v2 = 5
'DIM barre(10 * 50)
'CLS
'FOR i = 0 TO 9
'f = f + 1
'LINE (i, yb)-(i, yb + 49), f, BF
'NEXT

'GET (0, 0)-(9, 50), barre





'x = 1
'Y = 1

balle:

CLS






myprint "By Asher256, 2001", 1, 10, 21

v = 2

PUT (x, y), balle
diag = 1

'LINE (0, yb)-(5, yb + 50), 1, BF


DO
'WAIT &H3DA, 8 'WAIT for vertical retrace (the electron beam in your computer
c$ = INKEY$

WAIT &H3DA, 8

IF diag = 1 THEN
PUT (x, y), balle
x = x + v
y = y + v
PUT (x, y), balle, XOR
'diag = 0
IF y >= 179 THEN diag = 2
IF x >= 299 THEN diag = 3


END IF

IF diag = 2 THEN
PUT (x, y), balle
x = x + v
y = y - v
PUT (x, y), balle, XOR
'diag = 0
IF y <= 1 THEN diag = 1
IF x >= 299 THEN diag = 4
END IF


IF diag = 3 THEN
'1 Diag Droite Bas
'2 Diag Droite Haut
'3 Diag Gauche Bas
'4 Diag Gauche Haut

PUT (x, y), balle
x = x - v
y = y + v

PUT (x, y), balle, XOR
'diag = 0

IF y >= 175 THEN diag = 4
IF x <= 1 THEN diag = 1

END IF

IF diag = 4 THEN
'1 Diag Droite Bas
'2 Diag Droite Haut
'3 Diag Gauche Bas
'4 Diag Gauche Haut

PUT (x, y), balle
x = x - v
y = y - v
PUT (x, y), balle, XOR
IF y <= 1 THEN diag = 3
IF x <= 1 THEN diag = 2

END IF


LOOP UNTIL c$ = CHR$(27)
SCREEN 0
WIDTH 80
CLS
PRINT "Good bye !!!"

SUB couleur
SCREEN 13

COLOR 15

FOR i = 0 TO 255
LINE (i, 1)-(i + 1, 30), i, BF
NEXT



DO
c$ = INKEY$

IF c$ = CHR$(0) + CHR$(75) THEN

IF x <> 0 THEN t = POINT(x - 1, 29): x = x - 1
LINE (0, 31)-(320, 31), 0

END IF


IF c$ = CHR$(0) + CHR$(77) THEN
IF x <> 256 THEN t = POINT(x + 1, 29): x = x + 1
LINE (0, 31)-(320, 31), 0

END IF


PSET (x, 31), 15

LINE (60, 120)-(120, 180), t, BF
LOCATE 23, 1:  PRINT x

LOOP UNTIL c$ = CHR$(27)




END SUB

SUB myprint (texte$, l, c, coul)
COLOR 18
LOCATE l, c
PRINT texte$
'd = 104
c = c - 1
l = l - 1
putx c * 8, l * 8, (c * 8) + (LEN(texte$) * 8), (l * 8), 18, coul
putx c * 8, l * 8, (c * 8) + (LEN(texte$) * 8), (l * 8) + 1, 18, coul + 1
putx c * 8, l * 8, (c * 8) + (LEN(texte$) * 8), (l * 8) + 2, 18, coul + 2
putx c * 8, l * 8, (c * 8) + (LEN(texte$) * 8), (l * 8) + 3, 18, coul + 3
putx c * 8, l * 8, (c * 8) + (LEN(texte$) * 8), (l * 8) + 4, 18, coul + 4
putx c * 8, l * 8, (c * 8) + (LEN(texte$) * 8), (l * 8) + 5, 18, coul + 5
putx c * 8, l * 8, (c * 8) + (LEN(texte$) * 8), (l * 8) + 6, 18, coul + 6
putx c * 8, l * 8, (c * 8) + (LEN(texte$) * 8), (l * 8) + 7, 18, coul + 7
putx c * 8, l * 8, (c * 8) + (LEN(texte$) * 8), (l * 8) + 8, 18, coul + 8



END SUB

SUB mypset (x, t, c)
DEF SEG = &HA000
POKE x + (y * 320), c
DEF SEG

END SUB

DEFSNG A-Z
SUB putx (x1 AS INTEGER, y1 AS INTEGER, x2 AS INTEGER, y2 AS INTEGER, coul AS INTEGER, coulr AS INTEGER)

'coul c'est la couleur qu'ib  doit remplacer
'coulr c'est- la couleur qui va remplacer coul


FOR y = y1 TO y2
FOR x = x1 TO x2
t = POINT(x, y)
IF t = coul THEN PSET (x, y), coulr
NEXT
NEXT


END SUB

