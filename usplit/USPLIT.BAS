'####################################################################
'# Ultra Split v2.1 programme de division de fichiers
'# Par Asher256, Thunder software 2001
'#
'# Url: https://qbworld.asher256.com
'#
'####################################################################
DECLARE FUNCTION lastof% (ph$, carac$)
DECLARE SUB afficher ()
DECLARE FUNCTION getouinon$ (d$)
DECLARE FUNCTION opt$ (num!)
DECLARE SUB lafin ()
'$DYNAMIC
'ON ERROR GOTO erreur
DEFINT A-Z      'toujours integer pour la rapidit‚e

PRINT "Ultra Splitter V2.1"
PRINT "Copyright (c) Asher256, Thunder software 2001"
PRINT "URL: https://qbworld.asher256.com"
PRINT

DIM buffer AS STRING
DIM litmax AS LONG
litmax = 20000
DIM nummax AS LONG
DIM SHARED p1, p2, p3, p4, p5, c1
DIM SHARED t!
DIM SHARED pourcent
DIM SHARED myfile$
DIM fichier AS STRING
DIM fichier2 AS STRING
DIM SHARED j AS LONG
DIM SHARED intnum AS INTEGER
DIM lenght AS LONG
DIM div AS INTEGER
DIM octet AS LONG
intnum = FREEFILE

IF opt(0) = "" THEN
        INPUT "Donnez le fichier … diviser: ", fichier
        IF fichier = "" THEN END
        PRINT
ELSE
        fichier = opt(0)
END IF

fichier2 = fichier
repertoire$ = ""
IF INSTR(fichier2, "\") <> 0 THEN
     d = lastof(fichier2, "\")
     repertoire$ = MID$(fichier2, 1, d)
     fichier2 = MID$(fichier2, d + 1, LEN(fichier2) - d + 1)
END IF

OPEN fichier FOR BINARY ACCESS READ LOCK WRITE AS intnum
lenght = LOF(intnum)
IF lenght = 0 THEN
        PRINT "Le fichier " + fichier + " n'existe pas..."
        CLOSE (intnum)
        KILL fichier
        END
END IF

PRINT "Fichier:          "; fichier
PRINT "Nombre d'octets: "; LOF(intnum)
division:
PRINT

IF opt(1) = "" THEN
        INPUT "Combient de divisions voulez vous diviser ce fichier: ", div
ELSE
        div = VAL(opt(1))
END IF

IF div < 2 THEN
        PRINT "Erreur le division doit ˆtre plus grande que 1..."
        IF opt(1) = "" GOTO division ELSE lafin
END IF
IF div > 999 THEN
        PRINT "Vous n'exagerez pas un petit peut?"
        IF opt(1) = "" GOTO division ELSE lafin
END IF
IF div > lenght THEN
        PRINT "Erreur le nombre de divisions est plus grand que le fichier..."
        GOTO division
END IF

IF opt(1) = "" THEN PRINT
PRINT "Vous avez choisis"; div; "Divisions Cela fera environ";

'--------- convertit en string using ##
numero$ = STR$(FIX((lenght / div) / 1024))
o = 0
IF VAL(numero$) = 0 THEN
        numero$ = STR$(FIX(lenght / div))
        o = -1
END IF
'-------- FIN

PRINT numero$;
IF NOT o THEN PRINT " Ko ";  ELSE PRINT " Octet "
PRINT "pour chacune des division..."
PRINT
reprendrekey:
c$ = getouinon("voulez vous continuer [O/N]? ")

IF c$ = "n" THEN
        d$ = getouinon("Rechoisir autres divisions [O/N]? ")
        IF d$ = "n" THEN lafin ELSE GOTO division
END IF

'----------[ Met les infos dans l'‚cran ]------------
t! = TIMER
PRINT
PRINT "Temps de division: ";
p1 = POS(0): PRINT
PRINT "Fichier actuel: ";
p2 = POS(0): PRINT
PRINT "Pourcentage:";
p3 = POS(0): PRINT
PRINT "Octet nø:";
p5 = POS(0): PRINT
'-----------------------------------------------------
PRINT "";

c1 = CSRLIN
p4 = POS(0)

f$ = fichier
p = INSTR(f$, ".")
octet = FIX(lenght / div)
IF p <> 0 THEN
        f$ = MID$(f$, 1, p - 1)
END IF
n$ = " "
intnum3 = FREEFILE

OPEN repertoire$ + "unsplit.bat" FOR OUTPUT AS intnum3

PRINT #intnum3, "@echo off"
PRINT #intnum3, "echo Fichier *.bat UNSPLIT Cr‚‚ par Ultra Split 1.0"
PRINT #intnum3, "echo Par Asher256, Thunder software 2001"
PRINT #intnum3, "echo."
PRINT #intnum3, "if exist " + fichier + " del " + fichier

PRINT #intnum3, "choice voulez vous DESPLITTER le fichier " + fichier2 + "? "
PRINT #intnum3, "if errorlevel 2 goto fin"

PRINT #intnum3, "echo."
PRINT #intnum3, "echo Operation unsplit dans le fichier " + fichier2 + " en cours..."

PRINT #intnum3, "copy /b ";


IF litmax > octet THEN litmax = octet

FOR I = 1 TO div

        num$ = RIGHT$(STR$(I), LEN(STR$(I)) - 1)
        IF LEN(num$) < 3 THEN num$ = STRING$(3 - LEN(num$), "0") + num$
        myfile$ = f$ + "." + num$
        intnum2 = FREEFILE

        PRINT #intnum3, myfile$;
      
        OPEN myfile$ FOR OUTPUT AS intnum2: CLOSE intnum2
        intnum2 = FREEFILE
        OPEN myfile$ FOR BINARY ACCESS WRITE AS intnum2
   
        
    FOR j = 1 TO octet
        IF EOF(intnum) THEN EXIT FOR
          
        IF LOC(intnum) + litmax >= LOF(intnum) THEN
                nummax = LOF(intnum) - LOC(intnum) + 1
        ELSE
                nummax = litmax
        END IF
        
        buffer = INPUT$(nummax, #intnum)
        PUT #intnum2, , buffer
        j = j + nummax
        afficher
    NEXT

    'l'exeption s'il reste un petit peut de place
    IF I = div AND NOT EOF(intnum) THEN
        FOR j = LOC(intnum) TO LOF(intnum)
                GET #intnum, , n$
                PUT #intnum2, , n$
                
                afficher
        NEXT
        
    END IF

    CLOSE intnum2
    IF EOF(intnum) THEN EXIT FOR
    IF I < div THEN PRINT #intnum3, "+";
NEXT
PRINT #intnum3, " " + fichier2 + " >nul"
PRINT #intnum3, ":fin"
PRINT #intnum3, "echo."

CLOSE intnum3
LOCATE c1, p4
PRINT

PRINT "Le fichier UNSPLIT est " + repertoire$ + "unsplit.bat..."

lafin

'--------- SI UNE ERREUR EST DETECTEE
erreur:
IF ERR = 64 THEN PRINT "Nom de fichier incorrect...": END

PRINT "Une erreur c'est produite lors de l'execution du programme..."
PRINT "Code d'erreur: "; ERR
END

REM $STATIC
SUB afficher
        pourcent = (LOC(intnum) * 100) / LOF(intnum)
       
        LOCATE c1 - 4, p1: PRINT USING "##"; TIMER - t!; : PRINT " Seconde";
        LOCATE c1 - 3, p2: PRINT myfile$;
        LOCATE c1 - 2, p3: PRINT pourcent; "%";
        LOCATE c1 - 1, p5: PRINT LOC(intnum); "/"; LOF(intnum);
END SUB

FUNCTION getouinon$ (d$)
        PRINT d$;
        DO: c$ = LCASE$(INKEY$): LOOP UNTIL c$ = "o" OR c$ = "n"
        PRINT c$
        getouinon = c$
END FUNCTION

DEFSNG A-Z
SUB lafin
CLOSE intnum
PRINT
END
END SUB

DEFINT A-Z
'###########################################################
'                  Comme instr mais … l'envers
'                 Asher256, Thunder software 2001
'###########################################################
FUNCTION lastof (ph$, carac$)
        FOR j = LEN(ph$) TO 1 STEP -1
                IF MID$(ph$, j, LEN(carac$)) = carac$ THEN
                        lastof = j
                        EXIT FUNCTION
                END IF
        NEXT
END FUNCTION

DEFSNG A-Z
FUNCTION opt$ (num)
'------------------------------------------------------------------------
'fonction par Asher256 (c) 2000       
'------------------------------------------------------------------------
'                            - Explications -
'
'Cette fonction lit les options donnees avec une commande msdos par exemple
'si vous avez fait un programme loadtxt.exe qui charge des fichier *.txt
'alors vous pouvez ‚crire:
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
'alors vous recevez dans votre ‚cran la chaine de caractaire Option1.
'vous pouvez faire la mˆme chose avec l'option 2 ou 3 ou 4...
'------------------------------------------------------------------------


env$ = COMMAND$
IF MID$(env$, 1, 1) = "/" THEN env$ = MID$(env$, 2, LEN(env$))




FOR I = 1 TO LEN(env$)
IF MID$(env$, I, 1) = "/" THEN env$ = LEFT$(env$, I - 1) + " " + MID$(env$, I + 1, LEN(env$))

NEXT



DO
r = INSTR(r + 1, env$, " ")
nbropt = nbropt + 1
LOOP UNTIL r = 0

nbropt = nbropt - 1
IF num > nbropt THEN opt$ = "": EXIT FUNCTION
r = 0

IF num >= 0 THEN
   FOR I = 1 TO num
   r = INSTR(r + 1, env$, " ")
 
   NEXT

   debut = r
   fin = INSTR(debut + 1, env$, " ")

   IF fin = 0 THEN fin = LEN(env$) + 1

 

   opt$ = MID$(env$, debut + 1, fin - debut - 1)

   EXIT FUNCTION



END IF







END FUNCTION

