CLS
LOCATE 11, 23, 0
COLOR 8
PRINT STRING$(26, "€")
LOCATE 12, 23
PRINT "€€";
COLOR 15
PRINT "  ASHER256 PRESENTE   ";
COLOR 8
PRINT "€€"
LOCATE 13, 23
PRINT STRING$(26, "€")

PLAY "l15 o4 a o6 c p8"
WHILE INKEY$ <> CHR$(13)
WEND

toutdebut:
CLS
COLOR , 0


LOCATE 1, 1
COLOR 8
PRINT SPACE$(30) + "€€€€€€€€€€€€€€€€€€€€"
PRINT SPACE$(30) + "€€";
COLOR 15
PRINT "  FLYING WAR    ";
COLOR 8
PRINT "€€"
PRINT SPACE$(30) + "€€€€€€€€€€€€€€€€€€€€"

COLOR 15, 9
LOCATE 6, 10
PRINT "⁄" + STRING$(60, "ƒ") + "ø"

LOCATE 7, 10                   'un espace
PRINT "≥" + SPACE$(60) + "≥"
LOCATE 8, 10                   'un espace
PRINT "≥" + SPACE$(60) + "≥"
LOCATE 9, 10                   'un espace
PRINT "≥" + SPACE$(60) + "≥"

LOCATE 7, 12   'un texte (ligne1)
PRINT "Vous àtes Ö bord d'une fusÇe qui se trouve dans"
LOCATE 8, 12   'un texte (ligne2)
PRINT "l'espace. Vous ne devez absolument pas toucher les"
LOCATE 9, 12 'un texte (ligne2)
PRINT "Çtoiles, sinon la fusÇe va exploser !"
LOCATE 10, 10
PRINT "¿" + STRING$(60, "ƒ") + "Ÿ"

LOCATE 12, 13
COLOR 3, 0
PRINT "FLYING WAR Çcrit en QuickBasic4.5 par Asher256, 2000  "

LOCATE 13, 34
COLOR 15
PRINT "     ⁄ø     "
LOCATE 14, 34
PRINT "   ⁄ƒŸ¿ƒø       "
LOCATE 15, 34
PRINT "  ⁄Ÿ    ¿ø      "
LOCATE 16, 34
PRINT " ⁄¥ ⁄ƒƒø √ø     "
LOCATE 17, 34
PRINT "⁄Ÿ≥ ¿ƒƒŸ ≥¿ø    "
LOCATE 18, 34
PRINT "≥ ≥      ≥ ≥    "
LOCATE 19, 34
PRINT "¿ƒ¥      √ƒŸ    "
LOCATE 20, 34
PRINT " ⁄¡ƒƒ¬¬ƒƒ¡ø     "
LOCATE 21, 34
PRINT " ¿ø ⁄Ÿ¿ø ⁄Ÿ     "
LOCATE 22, 34
PRINT "  ¿ƒŸ  ¿ƒŸ      "
                                                                               

LOCATE 24, 16
COLOR 2
PRINT "1 Facile   ";
COLOR 14
PRINT "2 moyen   ";
COLOR 4
PRINT "3 Difficile   ";
COLOR 13
PRINT "4 impossible";
COLOR 7


DO
d$ = INKEY$
SELECT CASE d$
 CASE "1"
   f = 120
   niveau$ = "FACILE"
   GOTO cont

 CASE "2"
   f = 150
   niveau$ = "MOYEN"
   
   GOTO cont
 CASE "3"
   f = 220
   
   niveau$ = "DIFFICILE"
   GOTO cont
  CASE "4"
   f = 600
   niveau$ = "IMPOSSIBLE"

   GOTO cont
END SELECT
LOOP UNTIL d$ = "q"
END

         


CLS
cont:
w = TIMER
WHILE TIMER - w < 1
        n = n + 1
WEND


CLS

DIM etoilel(50)
DIM etoilec(50)
'les etoiles
debutjeu:
FOR i = 1 TO 50
        IF etoilec(i) <> 0 AND etoilel(i) <> 0 THEN LOCATE etoilel(i), etoilec(i)
        PRINT " "
        NEXT i


        LOCATE 25, 2
        COLOR 15
        PRINT "NIVEAU: ";
        PRINT niveau$

        LOCATE 25, 60
        COLOR 15
        PRINT "SCORE: "; score
        FOR i = 1 TO 50

        COLOR 15
lo:
         
          c = INT(RND * 80)
          l = INT(RND * 21)

          etoilel(i) = l
          etoilec(i) = c


         

          IF l = 0 OR c = 0 THEN GOTO lo
          LOCATE l, c

          PRINT "*"
NEXT i

LOCATE 23, 40

time:

DO
c$ = INKEY$
l = CSRLIN
c = POS(0)
d = d + 1

FOR x = 1 TO 50
        IF l = etoilel(x) AND c = etoilec(x) THEN       'PERDU

                PRINT "X"
                FOR i = 1 TO 12                'fait un son BOUM pour perdre
                        PLAY "l64n1l64n13"
                        t = TIMER
                        WHILE t + .01 > TIMER
                        WEND
                NEXT

                PLAY "l30n1l30n13"

                LOCATE l, c
                PRINT " "

                IF l > 1 AND c > 1 THEN             '<-- -
                        LOCATE l, c - 1
                        PRINT "-"
                END IF

                IF l < 25 AND c < 80 THEN             '--> -
                        LOCATE l, c + 1
                        PRINT "-"
                END IF


                IF l > 1 AND c > 1 THEN             '<-- \
                        LOCATE l - 1, c - 1
                        PRINT "\"
                END IF

                IF l > 1 AND c < 80 THEN          '--> /       x
                        LOCATE l - 1, c + 1
                        PRINT "/"
                END IF

                IF l < 25 AND c > 1 THEN           '<-- /
                        LOCATE l + 1, c - 1
                        PRINT "/"
                END IF

                IF l < 25 AND c < 80 THEN          '--> \     x
                        LOCATE l + 1, c + 1
                        PRINT "\";
                END IF

                COLOR 15, 1
                LOCATE 11, 29
                PRINT "⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø"
                LOCATE 12, 29
                PRINT "≥ appuyez sur entrÇe ≥"
                LOCATE 13, 29
                PRINT "¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ"


                DO: LOOP UNTIL INKEY$ = CHR$(13)
                COLOR 7, 0
                GOTO perdu
        END IF
NEXT x

IF d = INT(n / f) + 1 THEN d = 1

IF l < 1 THEN
        GOTO perdu
END IF


IF c$ = CHR$(0) + CHR$(77) THEN    'droite
        COLOR 12
        LOCATE l, c
        PRINT " "
        LOCATE l, c + 1
        PRINT "A"
        LOCATE l, c + 1

        l = CSRLIN
        c = POS(0)
END IF

IF c$ = CHR$(13) THEN             'PAUSE
        PLAY "l14 o3 a l14 o3 c"
        DO
        LOOP UNTIL INKEY$ = CHR$(13)
        PLAY "l14 o3 a l14 o3 c"
END IF

IF c$ = CHR$(0) + CHR$(75) THEN    'droite
        COLOR 12
        LOCATE l, c
        PRINT " "
        LOCATE l, c - 1
        PRINT "A"
        LOCATE l, c - 1
        l = CSRLIN
        c = POS(0)
END IF

IF d = 1 AND l <> 1 THEN
        COLOR 12
        LOCATE l, c
        PRINT " "
        LOCATE l - 1, c
        PRINT "A"
        LOCATE l - 1, c
END IF


IF l = 1 THEN
        score = score + 50
        GOTO debutjeu
END IF

LOOP UNTIL c$ = "q"

COLOR 7, 0
END

perdu:
        CLS
        LOCATE 1, 36
        COLOR 15, 9


        LOCATE 1, 16
        PRINT "⁄" + STRING$(45, "ƒ") + "ø"
        LOCATE 2, 16                   'un espace
        PRINT "≥" + SPACE$(45) + "≥"
        LOCATE 3, 16                   'un espace
        PRINT "≥" + SPACE$(45) + "≥"

        LOCATE 2, 18   'un texte (ligne1)
        PRINT SPACE$(10); "     VOUS AVEZ PERDU     "
        LOCATE 3, 18   'un texte (ligne2)
        PRINT " VOTRE VAISSEAU SPATIAL A HEURTE UNE ETOILE "
        LOCATE 4, 16
        PRINT "¿" + STRING$(45, "ƒ") + "Ÿ"


        LOCATE 15, 34

        COLOR 15, 0
        LOCATE 12, 34
        PRINT SPACE$(5) + "⁄ƒƒƒƒƒø"

        LOCATE 13, 34
        PRINT "SCORE" + "≥" + SPACE$(5) + "≥"
         
        LOCATE 14, 34
        PRINT SPACE$(5) + "¿ƒƒƒƒƒŸ"



        FOR i = 0 TO score STEP 10
                PLAY "l64 ceg"
                LOCATE 13, 40
                PRINT i
                NEXT i
        LOCATE 22, 1

        PRINT "1 Pour REJOUER"
        PRINT "0 Pour QUITTER"

        DO
                c$ = INKEY$

                IF c$ = "1" THEN CLEAR : GOTO toutdebut
        LOOP UNTIL c$ = "0"
       
        COLOR 7, 0
        CLS
END









