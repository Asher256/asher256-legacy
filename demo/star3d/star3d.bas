'########################################################################
'#                            DEMO STAR FIELD
'#                           Dans le Qbasic 4.5
'#
'#
'#                Par Asher256, Thunder software 2001
'#
'#
'# La d‚mo du cŠlŠbre jeu starfield 3D cette demo utilise l'algo de la
'# perspective pour les effets en 3D.
'#
'# Email: Asher256
'# Url:   http://qbworld.asher256.com
'#
'########################################################################

SCREEN 13: DEFINT A-Z
maxetoile = 400
DIM x(1 TO maxetoile) AS INTEGER    '\   declaration des variables
DIM y(1 TO maxetoile) AS INTEGER    ' |  ou sera stock‚ tout les points
DIM z(1 TO maxetoile) AS INTEGER    ' |  dans l'espace 3D.
DIM v(1 TO maxetoile) AS INTEGER    '/

FOR i = 1 TO maxetoile               '\
        r = i                        ' |  Met les valeurs al‚atoires une table
        GOSUB reformat               ' | 
NEXT                                 '/

DO
d$ = INKEY$
WAIT &H3DA, &H8   'attend le retracement vertical

FOR i = 1 TO maxetoile
        x2d = 256 * (x(i) / (z(i) + 40)) + 160
        y2d = 256 * (y(i) / (z(i) + 40)) + 100
        IF x2d >= 0 AND x2d < 319 AND y2d < 200 AND y2d >= 0 THEN
                PSET (x2d, y2d), 0
        END IF
        IF z(i) < -30 THEN
                r = i
                GOSUB reformat
        ELSE
                z(i) = z(i) - v(i)
        END IF
       
        IF z(i) > 400 THEN lez = 400 ELSE lez = z(i)
        c = 30 - INT(lez / 30)
       
        x2d = 256 * (x(i) / (z(i) + 40)) + 160
        y2d = 256 * (y(i) / (z(i) + 40)) + 100

        IF x2d >= 0 AND x2d < 319 AND y2d < 200 AND y2d >= 0 THEN
                PSET (x2d, y2d), c
        END IF
NEXT

LOOP UNTIL d$ = CHR$(27)
SCREEN 0
WIDTH 80, 25
COLOR 7, 0
PRINT "DEMO StarField 3D"
PRINT "Par Asher256, Thunder software 2001"
PRINT
PRINT "Url:   http://qbworld.asher256.com"

END
reformat:
        x(r) = (RND * 200) - 100
        y(r) = (RND * 200) - 100
        z(r) = (RND * 600) + 1
        v(i) = RND * 5 + 4
RETURN

