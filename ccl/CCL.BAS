'###############################################################
'# Code source de CCL Version 4.0
'# Copyright (c) Asher256, Thunder software 2001
'#
'# Url:   https://qbworld.asher256.com
'##############################################################
DECLARE FUNCTION opt$ (num%)
DECLARE FUNCTION acinput$ (chaine$, char$, STAT%, maxchar%)
DECLARE FUNCTION copy% (fichier1$, fichier2$)
DECLARE SUB printlogo ()
DECLARE FUNCTION exist% (fich$)

DEFINT A-Z

DIM lenght AS LONG
DIM minipourcent AS LONG
DIM nenre AS LONG
DIM buffer AS STRING
DIM nummax AS LONG
DIM litmax AS LONG
DIM lestep AS INTEGER
DIM t AS SINGLE
litmax = 20000


'<------declaration des variables------>
v = 5
'<--------fin des variables------------>

IF INSTR(1, LCASE$(opt(0)), "?") <> 0 THEN GOSUB aide: END



IF opt(0) = "" THEN
        
1
        CLS
        printlogo
        PRINT
        INPUT "Entrez le fichier … crypter: > ", fich$
       
        IF fich$ = "" THEN END
        IF exist(fich$) = 0 THEN
               
                PRINT "Mauvais Fichier..."
                BEEP
                GOTO 1
        END IF

ELSE
        
        IF exist(LCASE$(opt$(0))) <> 1 THEN
               PRINT
               PRINT "Erreur: Le fichier n'existe pas"
               END
        END IF
       'si ya la clef et le fichier existe alors enfin commencer
        fich$ = opt(0)
END IF


       'si pas de clef
       IF opt$(1) = "" THEN GOSUB pasclef: GOTO continue
       clef$ = LCASE$(opt$(1))
      
'       'si le fichier n'existe pas
continue:

GOTO debut

END
aide:

PRINT "CCL 4.0 Programme de cryptage/decryptage"
PRINT "Copyright (c) Asher256, Thunder software 2001"
PRINT
PRINT "‚crivez dans votre ligne de commande:"
PRINT "                      CCL.EXE Fichier.ext clef"
PRINT
PRINT "Fichier   le fichier … crypter"
PRINT "clef      le clef de cryptage"
RETURN



'--------------------saisie des infos et ouverture du fichiers---------------------
debut:
'ON ERROR GOTO erreur

OPEN fich$ FOR BINARY AS #1
OPEN "~temp.tmp" FOR OUTPUT AS #2: CLOSE #2
OPEN "~temp.tmp" FOR BINARY AS #2

nenre = LOF(1)
'------------------fin de saisie des infos et ouverture du fichiers-------



GOSUB clef: t = TIMER
PRINT : PRINT : PRINT : PRINT : LOCATE CSRLIN - 4
lin = CSRLIN: GOSUB crypt
GOTO fin



'------------sub CLEF ----------------------
clef:
DIM caraclef$(LEN(clef$))
FOR i = 1 TO LEN(clef$)
caraclef$(i) = MID$(clef$, i, 1)
NEXT i
RETURN
'-------------------------------------------
'-------si pas de clef alors la demander--------
pasclef:
clef$ = acinput$("Entrez la clef: ", "*", 1, 255)
IF clef$ = "" THEN
        PRINT "Erreur vous n'avez entr‚ aucune clef..."
        PRINT
        PRINT "Entrer une nouvelle clef [O/N]? ";

100
        a$ = INPUT$(1)
        IF NOT (a$ = "o" OR a$ = "n") THEN GOTO 100
        
        PRINT a$
        IF a$ = "o" THEN GOTO pasclef
        IF a$ = "n" THEN
                END
        END IF
END IF

RETURN
'-----------------------------------------------



'------------SUB CRYPT----------------------

crypt:
'PRINT
lenght = LOF(1)
minipourcent = FIX((7 * lenght) / 100)

'    ------->  ?
'LOF -------> 100

DO UNTIL EOF(1)
       
        IF LOC(1) + litmax >= lenght THEN
                nummax = lenght - LOC(1) + 1
        ELSE
                nummax = litmax
        END IF
       
        fdigit$ = INPUT$(nummax, #1)
        
       
        FOR i = 1 TO LEN(fdigit$)
                
                clair$ = MID$(fdigit$, i, 1)
                clefc$ = UCASE$(caraclef$(numclef + 1))
                crypt$ = CHR$(ASC(clair$) XOR ASC(clefc$) XOR 42)
                MID$(fdigit$, i, 1) = crypt$
                     
                st = st + 1
                IF st >= minipourcent THEN st = 0
                IF st = 0 THEN
                        pourcent = INT(((LOC(1) - LEN(fdigit$) + i) / lenght) * 100)'definit le pourcentage
                        GOSUB affiche    'il va au SUB affiche pour affichier le pourcent
                END IF
                numclef = (numclef + 1) MOD LEN(clef$)
              

        NEXT
        PUT #2, , fdigit$
LOOP

pourcent = INT((LOC(1) / lenght) * 100)  'definit le pourcentage
GOSUB affiche    'il va au SUb affiche pour affichier le pourcent

RETURN
'------------------Fin du cryptage --------------------------


'------------------label  FIN-----------------------------------
fin:
temps = INT(TIMER - t)    'definit le temps de cryptage

PRINT
PRINT
PRINT "Nombre d'octets Crypt‚s:"; LOF(1)
IF temps = 1 THEN PRINT "Temps de cryptage:"; temps; " Seconde"
IF temps < 60 AND temps > 1 THEN PRINT "Temps de cryptage:"; temps; " Secondes"
IF temps > 60 THEN PRINT "Temps de cryptage:"; temps / 60; " Minutes"
'PRINT

RESET
SHELL "copy ~temp.tmp " + fich$ + ">nul"
KILL "~temp.tmp"

END

'-----------------------Fin label fin --------------------------------


'----------SUB affiche msgbox avec pourcentage + temps ------------------
affiche:
IF merde = 0 THEN
        LOCATE , , 0
        merde = 1
        PRINT "Cryptage en cours: ";
        cologne = POS(0)
        ligne = CSRLIN
        LOCATE ligne, cologne + 1
        PRINT STRING$(20, "°");
END IF

LOCATE , 20
'100 ------> 20
' p  ------>

PRINT STRING$(FIX(pourcent / 5), "Û");
LOCATE , 20 + 20: PRINT pourcent; "%";

RETURN
'------------------fin de SUB affiche ----------------------------------

'-----------------SUB ERREUR--------------------------------------
erreur:
IF ERR = 53 THEN PRINT : COLOR 7: PRINT "LE FICHIER "; : COLOR 2: PRINT UCASE$(fich$); : COLOR 7: PRINT " EST INTROUVABLE"
IF ERR = 76 THEN PRINT : COLOR 7: PRINT "LE CHEMIN "; : COLOR 2: PRINT UCASE$(fich$); : COLOR 7: PRINT " EST INTROUVABLE"
IF ERR = 70 THEN PRINT : COLOR 7: PRINT "soi Le disque ou le fichier "; : COLOR 2: PRINT UCASE$(fich$); : COLOR 7: PRINT " son prot‚g‚ en ‚criture"
IF ERR = 64 THEN PRINT : COLOR 7: PRINT "le Nom de fichier "; : COLOR 2: PRINT UCASE$(fich$); : COLOR 7: PRINT " est incorect "

IF ERR = 14 THEN
        PRINT "Pas assez de m‚moire pour executer cette tƒche..."
        RESET
        KILL "~temp.tmp"
        END
END IF

PRINT "Erreur Nø "; ERR

END

'stat=1 MAJ
'COMMANDE INPUT AVEC UN PASSWORDCHAR:
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'Auteur: Asher256
'
'STAT:0=normal,1=MAJUSCULE
'char$: est le password char "" est normal "*" avec des etoiles
'chaine$: est la chaine affich‚e comme "Donnez le PASSWORD:"
'Maxchar: c'est le nombre maximum de caractaires qu'on peut entrer
'------------------------------------------------------------------------
'Pour t‚l‚charger des tonnes de programmes utilitaires,jeux,graphisme qbasic
'alors rendez vous dans ma page web The QuickBasic world:
'                   -----------------------------
'                   https://qbworld.asher256.com
'                   -----------------------------
'
'                                                 (c) Asher256, 2000
'                                                 ~~~~~~~~~~~~~~~~~~
'------------------------------------------------------------------------
'
FUNCTION acinput$ (chaine$, char$, STAT, maxchar)

name$ = ""


PRINT chaine$;
DO

  c$ = INKEY$
  LOCATE , , 1, 5, 5

  IF STAT <> 0 THEN c$ = UCASE$(c$)

  'si c$ est <> "" est est <> de entr‚e alors ‚crire
  IF LEN(name$) < maxchar AND c$ > CHR$(13) AND c$ <= CHR$(255) AND c$ <> CHR$(13) THEN
   name$ = name$ + c$
    IF char$ <> "" THEN PRINT LEFT$(char$, 1);  ELSE PRINT c$;
  END IF



  IF c$ = CHR$(8) AND LEN(name$) > 0 THEN

  name$ = LEFT$(name$, LEN(name$) - 1)

  IF POS(0) = 1 THEN
      LOCATE CSRLIN - 1, 80
      PRINT " ";
      LOCATE CSRLIN - 1, 80
  ELSE
      LOCATE CSRLIN, POS(0) - 1
      PRINT " ";
      LOCATE CSRLIN, POS(0) - 1
  END IF


  END IF
'-----------------------------------------------------------
LOOP UNTIL c$ = CHR$(13)
PRINT
acinput$ = name$


END FUNCTION

SUB barrep (pourcent, l, c)

'2 ---------> 100
'  ---------> 1

'1*2 /100

END SUB

FUNCTION copy (fichier1$, fichier2$)
        'IF exist(fichier2$) THEN KILL fichier2$
        IF NOT exist(fichier1$) THEN copy = -1: EXIT FUNCTION

        intnum = FREEFILE
        OPEN fichier1$ FOR BINARY AS intnum
        intnum2 = FREEFILE
        OPEN fichier2$ FOR OUTPUT AS intnum2: CLOSE intnum2
        intnum2 = FREEFILE: OPEN fichier2$ FOR BINARY AS intnum2

        DO UNTIL EOF(intnum)
                n$ = INPUT$(10000, intnum)
                PUT intnum2, , n$
        LOOP

        CLOSE intnum, intnum2

END FUNCTION

FUNCTION exist (fich$)


OPEN fich$ FOR BINARY AS #4

IF LOF(4) = 0 THEN
        exist = 0
        CLOSE #4
        KILL fich$
        EXIT FUNCTION
END IF

's'il existe alors 1
exist = 1



CLOSE #10


END FUNCTION

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
'Pour t‚l‚charger des tonnes de programmes utilitaires,jeux,graphisme qbasic
'alors rendez vous dans ma page web The QuickBasic world:
'                   -----------------------------
'                     www.multimania.com/qbw
'                   -----------------------------
'
'
'                                                 (c) Asher256 2000
'                                                 ~~~~~~~~~~~~~~~~~~
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

SUB printlogo
        PRINT SPACE$(20) + "ÉÍÍÍÍÍÍÍÍÍ» ÉÍÍÍÍÍÍÍÍÍ» ÉÍÍÍÍ»"
        PRINT SPACE$(20) + "º         º º         º º    º"
        PRINT SPACE$(20) + "º    ÉÍÍÍÍ¼ º    ÉÍÍÍÍ¼ º    º"
        PRINT SPACE$(20) + "º    º      º    º      º    º  "
        PRINT SPACE$(20) + "º    ÈÍÍÍÍ» º    ÈÍÍÍÍ» º    ÈÍÍÍ»"
        PRINT SPACE$(20) + "º         º º         º º        º"
        PRINT SPACE$(20) + "ÈÍÍÍÍÍÍÍÍÍ¼ ÈÍÍÍÍÍÍÍÍÍ¼ ÈÍÍÍÍÍÍÍÍ¼"
        PRINT SPACE$(20) + "         ...CCL V4.0..."
        PRINT
        PRINT "CCL 4.0 Programme de cryptage/decryptage (Aout 2001)."
        PRINT "Auteur: Asher256:"
        PRINT "URL: https://qbworld.asher256.com"
END SUB

