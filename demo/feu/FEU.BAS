DECLARE SUB jascpal (palname$)
DECLARE SUB feu ()
DEFINT A-Z: SCREEN 13: RANDOMIZE TIMER

DIM SHARED fire%(8001)          '\ Prend dans le tableau fire% l'entˆte
GET (0, 0)-(319, 48), fire%     '/ pour stocker le feu comme dans un buffer
CLS
jascpal "feu.pal"       'charge la palette paint shop pro feu

DEF SEG = &HA000        'affiche le logo
DEF SEG

DEF SEG = VARSEG(fire%(0))      'pointe le segment vers FIRE%(0)

DO
        c$ = INKEY$                    'prend un caractaire du clavier
        feu                            'met le feu dans le buffer
        PUT (0, 150), fire%, PSET      'Affiche le buffer
LOOP UNTIL c$ = CHR$(27)

SCREEN 0
WIDTH 80
DEF SEG         'revient au segment normal
SCREEN 0: WIDTH 80, 25
CLS
PRINT "D‚mo de feu par Asher256, 2001"
PRINT
PRINT "URL: https://qbworld.asher256.com"
END

SUB feu
        'routine pricipale pour l'effet de feu

        debut = VARPTR(fire%(0)) + (320 * 49) + 4
        fin = debut + 319
        FOR x = debut TO fin
                couleur = RND * 80 - 40
                couleur = couleur + PEEK(x)
                IF couleur > 255 THEN couleur = 255
                IF couleur < 0 THEN couleur = 0
                POKE x, couleur
        NEXT
       
        FOR y = 0 TO 48
                debut = VARPTR(fire%(0)) + (y * 320) + 4
                fin = debut + 318
                FOR x = debut TO fin
                        couleur = PEEK(x + 319)
                        couleur = couleur + PEEK(x + 320) * 3
                        couleur = couleur + PEEK(x + 321)
                        couleur = couleur / 5
                        IF y < 30 THEN couleur = couleur - 10: IF couleur < 0 THEN couleur = 0
                        POKE x, couleur
                NEXT
        NEXT
END SUB

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
SUB setpal (c%, r, g, B)
  
   'OUT &H3C7, c%
   OUT &H3C8, c%
   OUT &H3C9, r
   OUT &H3C9, g
   OUT &H3C9, B
END SUB

DEFINT A-Z
SUB sjascpal (palname$)
DIM jp1 AS LONG
DIM jp2 AS LONG
DIM jp3 AS LONG
IF INSTR(palname$, ".") = 0 THEN palname$ = palname$ + ".pal"
temp% = FREEFILE
OPEN palname$ FOR OUTPUT AS #temp%
PRINT #temp%, "JASC-PAL"
PRINT #temp%, "0100"
PRINT #temp%, "256"
FOR ljp% = 1 TO 256
OUT &H3C8, ljp%
jp1 = INP(&H3C9): jp2 = INP(&H3C9): jp3 = INP(&H3C9)
PRINT #temp%, LTRIM$(STR$(INT((jp1 / 63) * 255))) + " " + LTRIM$(STR$(INT((jp2 / 63) * 255))) + " " + LTRIM$(STR$(INT((jp3 / 63) * 255)))
NEXT
CLOSE #temp%

END SUB

