DECLARE SUB addz (obj AS ANY, num%)
DECLARE SUB afficheallfaces ()
DECLARE SUB addx (obj AS ANY, num%)
DECLARE FUNCTION loadasc% (obj AS ANY, fichier$)
DECLARE SUB afficheobjet (obj AS ANY)
DECLARE FUNCTION calculintensite% (i%)
DECLARE SUB addvertex (x%, y%, z%)
DECLARE SUB trierfacettes ()
DECLARE SUB addface (v1%, v2%, v3%, Col%)
DECLARE SUB myDQBtri (Layer%, x1%, y1%, x2%, y2%, x3%, y3%, Col%)
DECLARE SUB rotationvertex (rotx%, roty%, rotz%)
DECLARE SUB afficheface (laface AS ANY)
DECLARE SUB rotate (c1 AS ANY, c2 AS ANY, rotx%, roty%, rotz%)
DECLARE SUB conv2d (c1 AS ANY, c2 AS ANY)
DECLARE SUB xrpset (x3d%, y3d%, z3d%, rotx%, roty%, rotz%, out3dx%, out3dy%, out3dz%)
DECLARE SUB xpset (x3d%, y3d%, z3d%, outx%, outy%)
'$INCLUDE: 'directqb.bi'

DIM SHARED Zoom AS INTEGER
DIM SHARED depth AS INTEGER




Zoom = 256
depth = 100
'-----------------trucs de demarrage pour angle------------
'met les 360 valeur de chaque radien dans une table
'pour la rapidit‚
CONST pi = 3.141592
DIM rad!
DIM SHARED s!(360)  'le sinus de chaque radian
DIM SHARED c!(360)  'le cosinus de cchaque radian
FOR i = 0 TO 360
rad! = (i / 360) * (2 * pi)
s!(i) = SIN(rad!)
c!(i) = COS(rad!)
NEXT
'----------------------------------------------------------


'-------------- options de 3D -------------------
CONST ca = 1
CONST cb = 2
CONST cc = 3

CONST cx = 1
CONST cy = 2
CONST cz = 3

DIM rotx, roty, rotz AS INTEGER
'----------------------------------------------------

'-------- Les types --------------------------------
TYPE pixel3d
	x AS INTEGER
	y AS INTEGER
	z AS INTEGER
END TYPE
TYPE PIXEL
	x AS INTEGER
	y AS INTEGER
END TYPE
TYPE face
	v1 AS INTEGER
	v2 AS INTEGER
	v3 AS INTEGER
	couleur AS INTEGER
	nx AS INTEGER
	ny AS INTEGER
	nz AS INTEGER
	nx2 AS INTEGER
	ny2 AS INTEGER
	nz2 AS INTEGER
	norme AS INTEGER
END TYPE
TYPE objet
	debut AS INTEGER
	fin AS INTEGER
END TYPE
'---------------------------------------------------
DIM SHARED maxvertex

DIM SHARED vertex(2000) AS pixel3d
DIM SHARED outvertex(2000) AS pixel3d
DIM SHARED outvertex2d(2000) AS PIXEL


DIM SHARED objets(10) AS objet


'--------- >> les faces <<--------------------
DIM SHARED faces(2000) AS face
DIM SHARED visible(2000) AS INTEGER
DIM SHARED maxfaces AS INTEGER
DIM SHARED letri(2000) AS INTEGER

DIM SHARED add(2000) AS pixel3d

'addface 1, 2, 3, 15

'load3d "3dedit\object.3d"
'PRINT "m"; maxfaces
a% = loadasc(objets(1), "object.asc")
''PRINT "m"; maxfaces
a% = loadasc(objets(2), "object.asc")
'PRINT "m"; maxfaces


PRINT objets(1).debut
PRINT objets(1).fin
PRINT objets(2).debut
PRINT objets(2).fin
a$ = INPUT$(1)

'dqbclose
'END


'---------------------------------------------------

IF DQBinit(1, 0, 0) THEN
	PRINT DQBerror$
	END
END IF
DQBinitVGA
DIM Pal AS STRING * 768
DIM SHARED texture(DQBsize(0, 0, 63, 63)) AS INTEGER
DIM SHARED texture2(DQBsize(0, 0, 63, 63)) AS INTEGER
IF DQBloadImage(1, 0, 0, "texture1.bmp", Pal, 0, 0) THEN
	dqbclose
	PRINT DQBerror$
	END
END IF
DQBsetPal Pal
DQBsetTextureSize 32
DQBget 1, 0, 0, 31, 31, VARSEG(texture(0)), VARPTR(texture(0))
DQBget 1, 0, 32, 31, 32 + 31, VARSEG(texture2(0)), VARPTR(texture2(0))

pl = 1

DO
c$ = INKEY$
	DQBclearLayer 1
	'dqbwait 1
	IF c$ = "p" THEN pl = pl + 1
	IF c$ = "o" AND pl > 0 THEN pl = pl - 1
      
	IF c$ = "+" THEN Zoom = Zoom + 5
	IF c$ = "-" THEN Zoom = Zoom - 5

	roty = (roty + 2 + pl) MOD 360
	rotz = (rotz + 5 + pl) MOD 360
     
	rotx = (rotx + 1 + pl) MOD 360
	
	rotationvertex rotx, roty, rotz
	trierfacettes
       
	afficheallfaces

	
	IF c$ = " " THEN addz objets(1), 10
	'addz objets(2), 1
       
	
       dqbwait 1
       DQBcopyLayer 1, 0
LOOP UNTIL c$ = CHR$(27)


dqbclose
CLS
PRINT "Demo de la 3D textur‚e dans le QBasic Par Asher256, 2001"
PRINT "Je remercie Tom rathbone pour son tutorial 3D ce tutorial est"
PRINT "telechargable depuis QBworld."
PRINT
PRINT "https://qbworld.asher256.com"
END

REM $DYNAMIC
SUB addface (v1, v2, v3, Col)
       
	max = maxfaces + 1
	faces(max).v1 = v1
	faces(max).v2 = v2
	faces(max).v3 = v3
	faces(max).couleur = Col
	maxfaces = max

END SUB

SUB addvertex (x, y, z)
maxvertex = maxvertex + 1

vertex(maxvertex).x = x: vertex(maxvertex).y = y: vertex(maxvertex).z = z

END SUB

SUB addz (obj AS objet, num)

	FOR i = obj.debut + 1 TO obj.fin - 1
		add(faces(i).v1).z = add(faces(i).v1).z + num
		add(faces(i).v2).z = add(faces(i).v2).z + num
		add(faces(i).v3).z = add(faces(i).v3).z + num
	NEXT

END SUB

SUB afficheallfaces
DIM maface AS face

	FOR i = 1 TO maxfaces
				afficheface faces(letri(i))
	NEXT

END SUB

SUB afficheface (laface AS face)
       
	x1 = outvertex2d(laface.v1).x
	x2 = outvertex2d(laface.v2).x
	x3 = outvertex2d(laface.v3).x

	y1 = outvertex2d(laface.v1).y
	y2 = outvertex2d(laface.v2).y
	y3 = outvertex2d(laface.v3).y
       
	myDQBtri 1, x1, y1, x2, y2, x3, y3, laface.couleur
END SUB

SUB calculernormales

	
	FOR i = 1 TO maxfaces
	   aa0 = outvertex(faces(i).v1).x - outvertex(faces(i).v2).x
	   aa1 = outvertex(faces(i).v1).y - outvertex(faces(i).v2).y
	   aa2 = outvertex(faces(i).v1).z - outvertex(faces(i).v2).z

	   bb0 = outvertex(faces(i).v1).x - outvertex(faces(i).v3).x
	   bb1 = outvertex(faces(i).v1).y - outvertex(faces(i).v3).y
	   bb2 = outvertex(faces(i).v1).z - outvertex(faces(i).v3).z

	   faces(i).nx = (a1 * B2) - (a2 * B1)
	   faces(i).ny = (a2 * B0) - (a0 * B2)
	   faces(i).nz = (a0 * B1) - (a1 * B0)
	   faces(i).norme = (faces(i).nx * faces(i).nx) + (faces(i).ny * faces(i).ny) + (faces(i).nz * faces(i).nz)
	   'faces(i).norme = 20
	NEXT




END SUB

REM $STATIC
FUNCTION calculintensite (i)
lum0 = 1
lum1 = 1
lum2 = 1

DIM res AS DOUBLE
res = ((faces(i).nx2 * lum0) + (faces(i).ny2 * lum2) + (faces(i).nz2 * lum3) * 31)
res = INT(res / faces(i).norme)

IF res > 0 THEN
     calculintensite = 32 - res
ELSE
     calculintensite = 31
END IF


END FUNCTION

REM $DYNAMIC
SUB conv2d (c1 AS pixel3d, c2 AS PIXEL)
		xpset c1.x, c1.y, c1.z, c2.x, c2.y
END SUB

SUB initsort STATIC

FOR j = 1 TO maxpoly
	resultat(j) = 0  'met tout les resultats … 0
	resultat2(j) = 0  'met tout les resultats … 0
     
	resultat3(j) = 0  'met tout les resultats … 0
     
	liste(j) = j     'met dans la liste les nombres de 1 … maxpoly
NEXT

	
FOR j = 1 TO maxpoly      'tout les polygognes
	FOR k = 1 TO 3  'abc
		resultat(j) = resultat(j) + out3d(j, k, cz)
      
		resultat2(j) = resultat2(j) + out3d(j, k, cy)
		resultat3(j) = resultat3(j) + out3d(j, k, cx)
      
	NEXT
NEXT



END SUB

REM $STATIC
SUB load3d (fichier$)

	OPEN fichier$ FOR INPUT AS #1
	LINE INPUT #1, ph$
	maxfaces = 0
	maxvertex = 0

	repeat = VAL(ph$)
	d = 1
	
	FOR i = 1 TO repeat
	 FOR j = 1 TO 3
	    LINE INPUT #1, ph1$
	    LINE INPUT #1, ph2$
	    LINE INPUT #1, ph3$
	    addvertex VAL(ph1$) - 50, VAL(ph2$) - 50, VAL(ph3$) - 50
	 NEXT
	    LINE INPUT #1, color$
	   
	    addface d, d + 1, d + 2, (RND * 10) + 22
	    '
	    d = d + 3
	   
	NEXT
	CLOSE #1
END SUB

FUNCTION loadasc (obj AS objet, fichier$)

DIM wx AS DOUBLE
DIM wy AS DOUBLE
DIM wz AS DOUBLE

DIM Red AS INTEGER, Green AS INTEGER, Blue AS INTEGER
DIM ph$ 'une ligne

'maxfaces = 0
'maxvertex = 0

OPEN fichier$ FOR INPUT AS #1

DO
LINE INPUT #1, ph$
LOOP UNTIL INSTR(LCASE$(ph$), "named") OR EOF(1)

'---->>> charge le max de vertexes
LINE INPUT #1, ph$

ph$ = ph$ + " "

'PRINT "Ligne :"; ph$
ph$ = LCASE$(ph$)
debut = INSTR(1, ph$, "vertices: ")
debut = debut + 9
fin = INSTR(debut + 1, ph$, " ")
maxv = VAL(MID$(ph$, debut, fin - debut))



ph$ = ph$ + " "
debut = INSTR(1, ph$, "faces: ")
debut = debut + 6
fin = INSTR(debut + 1, ph$, " ")
maxf = VAL(MID$(ph$, debut, fin - debut))


' "Le max de vertex est :"; maxv
'PRINT "Le max de faces est :"; maxf

obj.debut = maxfaces
obj.fin = maxf + maxfaces



DIM u(maxv)
DIM v(maxv)


'-----------------------



'---------si elle est map‚e alors mapped=1
'LINE INPUT #1, ph$
'ph$ = RTRIM$(LTRIM$(LCASE$(ph$)))
'IF ph$ = "mapped" THEN mapped = 1 ELSE mapped = 0
'-----------------------------------------

'----->>trouve la liste des vertexes
DO
LINE INPUT #1, ph$
ph$ = RTRIM$(LTRIM$(LCASE$(ph$)))
'PRINT ph$
LOOP UNTIL ph$ = "vertex list:" OR EOF(1)

IF EOF(1) THEN BEEP: END
'----->>trouve la liste des vertexes



'------>>> chargement des vertexes <<<------------------------------
DO

LINE INPUT #1, ph$ 'lit une ligne
ph$ = RTRIM$(LTRIM$(LCASE$(ph$)))

IF MID$(ph$, 1, 6) = "vertex" THEN
	ph$ = ph$ + " "
	ph$ = LCASE$(ph$)
	numdebut = INSTR(1, ph$, " ")
	numfin = INSTR(1, ph$, ":")

	numero = VAL(MID$(ph$, numdebut + 1, numfin - numdebut)) + 1

	xdebut = INSTR(1, ph$, "x:") + 2
	xfin = INSTR(xdebut + 1, ph$, " ")
	wx = VAL(MID$(ph$, xdebut, xfin - xdebut))
       
	ydebut = INSTR(1, ph$, "y:") + 2
	yfin = INSTR(ydebut + 1, ph$, " ")
	wy = VAL(MID$(ph$, ydebut, yfin - ydebut))
       
	zdebut = INSTR(1, ph$, "z:") + 2
	zfin = INSTR(zdebut + 1, ph$, " ")
	wz = VAL(MID$(ph$, zdebut, zfin - zdebut))
       
	addvertex FIX(wx * 20), FIX(wy * 20), FIX(wz * 20)
      
	d = d + 1
       ' PRINT d, wx, wy, wz
	

END IF


LOOP UNTIL ph$ = "face list:"
'END
'-------------------->>>

a$ = ""




DO
LINE INPUT #1, ph$
ph$ = RTRIM$(LTRIM$(LCASE$(ph$)))


IF MID$(ph$, 1, 5) = "face " THEN
	ph$ = ph$ + " "
	debut = INSTR(1, ph$, " ") + 1
	fin = INSTR(1, ph$, ":")
	nface = VAL(MID$(ph$, debut, fin - debut)) + 1

	adebut = INSTR(1, ph$, "a:") + 2
	afin = INSTR(adebut + 1, ph$, " ")
	wa = VAL(MID$(ph$, adebut, afin - adebut)) + 1
		    
	bdebut = INSTR(1, ph$, "b:") + 2
	bfin = INSTR(bdebut + 1, ph$, " ")
	wb = VAL(MID$(ph$, bdebut, bfin - bdebut)) + 1

	cdebut = INSTR(1, ph$, "c:") + 2
	cfin = INSTR(cdebut + 1, ph$, " ")
	wc = VAL(MID$(ph$, cdebut, cfin - cdebut)) + 1
	       
	LINE INPUT #1, ph$
	ph$ = RTRIM$(LTRIM$(LCASE$(ph$)))
	IF LEFT$(ph$, 8) = "material" THEN
		debut = INSTR(ph$, CHR$(34))
		IF debut <> 0 THEN
		      fin = INSTR(debut + 1, ph$, CHR$(34))
		      IF fin <> 0 THEN
			 p$ = MID$(ph$, debut + 1, fin - debut - 1)
			 c = VAL(RIGHT$(p$, 2))
		      END IF
		END IF
	END IF

	 IF c = 0 THEN c = (RND * 10) + 18
	 addface wa, wb, wc, c
	 c = 0
	DO
		LINE INPUT #1, ph$
		ph$ = RTRIM$(LTRIM$(LCASE$(ph$)))
	LOOP UNTIL MID$(ph$, 1, 10) = "smoothing:"
       
	'smooth(nface) = VAL(MID$(ph$, 11, LEN(ph$)))
	'PRINT wa, wb, wc
     
END IF




		  
LOOP UNTIL EOF(1) OR RIGHT$(ph$, 5) = "name"
'END

CLOSE #1

loadasc = 1
maxfaces = maxfaces + 1



END FUNCTION

SUB myDQBtri (Layer, x1, y1, x2, y2, x3, y3, Col)
'        DQBline layer, x1, y1, x2, y2, col
'        DQBline layer, x2, y2, x3, y3, col
'        DQBline layer, x3, y3, x1, y1, col


'dqbtri layer, x1, y1, x2, y2, x3, y3, col

IF Col >= 13 THEN DQBttri Layer, x1, y1, x2, y2, x3, y3, 0, 0, 31, 0, 31, 31, VARSEG(texture(0)), VARPTR(texture(0))
END SUB

SUB rotate (c1 AS pixel3d, c2 AS pixel3d, rotx, roty, rotz)
	xrpset c1.x, c1.y, c1.z, rotx, roty, rotz, c2.x, c2.y, c2.z
END SUB

SUB rotationvertex (rotx, roty, rotz)
       
	FOR i = 1 TO maxvertex
		rotate vertex(i), outvertex(i), rotx, roty, rotz
		outvertex(i).z = outvertex(i).z + add(i).z
		conv2d outvertex(i), outvertex2d(i)
	NEXT


END SUB

SUB trierfacettes
	FOR i = 1 TO maxfaces
		letri(i) = i
	NEXT
	FOR i = 1 TO maxfaces
		FOR j = 1 TO maxfaces
		    z1 = outvertex(faces(letri(i)).v1).z + outvertex(faces(letri(i)).v2).z + outvertex(faces(letri(i)).v3).z
		    z2 = outvertex(faces(letri(j)).v1).z + outvertex(faces(letri(j)).v2).z + outvertex(faces(letri(j)).v3).z
		
		    IF z1 > z2 THEN
			SWAP letri(i), letri(j)
		    END IF
		NEXT
	NEXT

END SUB

SUB xpset (x3d, y3d, z3d, outx%, outy%)

      x2d% = (Zoom * (-x3d / (z3d + depth))) + 160
      y2d% = (Zoom * (-y3d / (z3d + depth))) + 100
      outx% = x2d%
      outy% = y2d%
  
		       
END SUB

SUB xrpset (x3d, y3d, z3d, rotx, roty, rotz, out3dx%, out3dy%, out3dz%)
       
	x2! = (x3d * c!(rotz)) - (y3d * s!(rotz))
	y2! = (x3d * s!(rotz)) + (y3d * c!(rotz))
	x3! = (x2! * c!(roty)) - (z3d * s!(roty))
	z2! = (x2! * s!(roty)) + (z3d * c!(roty))
	y3! = (y2! * c!(rotx)) - (z2! * s!(rotx))
	z3! = (y2! * s!(rotx)) + (z2! * c!(rotx))
       
	out3dx% = FIX(x3!)
	out3dy% = FIX(y3!)
	out3dz% = FIX(z3!)



END SUB

