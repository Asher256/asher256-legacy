# FmLib (version 1.5)

Auteur: Asher256

## Introduction

FmLib est une librairie qui vous permettra de charger les musiques crees par
FM-Song dans votre programme QBASIC. FmLib est compatible avec les cartes son
Adlib et Sound Blaster.

## Comment ajouter FmLib a un programme QBasic?

FmLib se trouve dans le fichier "fmlib.bas".

A la difference des librairies *.qlb, vous devez fusionner la source avec votre
programme:
- Ouvrez le menu Fichier --> Fusionner,
- Choisissez le fichier "fmlib.bas" afin d'ajouter la librairie a votre code source.

Vous pouvez utiliser a present toutes les commandes pour jouer de la musique
dans votre programme Qbasic.

ATTENTION: Il ne faut pas oublier d'ajouter le code suivant apres vos declarations (non pas apres les fonctions appelees):
```
REM $include : 'fmlib.bi'
```

## Les commandes:
Voici la liste de tout les commandes pour charger et jouer des musiques *.fms:

```
FUNCTION FmSongInit()          # Initialisation de la librairie et de la carte
                               # son s'il ya une erreur alors il retourne TRUE

SUB FmSongClose()              # Ferme la librairie

FUNCTION loadfms(filename$)    # Charge un fichier *.fms dans la memoire
                               # si Erreur alors il retourne TRUE

SUB playfms()                  # Il joue le son
SUB stopfms()                  # Il stoppe le son

FUNCTION eofms()               # Attention a mettre avant loopfms...
                               # non zero si le FMS touche a sa fin
                               # Utilisation: "IF eofms THEN stopfms"
                               # facile non?? ;)

SUB pausefms()                 # Il met le son en pause
SUB resumefms()                # Si le son est en pause alors il
                               # enleve la pause

SUB loopfms()                  # C'est la plus importante SUB c'est elle qui
                               # continue de jouer le son en arriere plan
                               # vous devez la mettre dans toutes les boucles.
```

## Un exemple

```
REM $INCLUDE: 'fmlib.bi'           'inclue le header ou il ya les
                                   'variables de la lib et les declarations

IF fmsonginit THEN   'initialisation de la librairie FM-LIB
            PRINT "Erreur de chargement de la librairie FM-LIB, ChipFm non detecte..."
            END
END IF


IF Loadfms("fichier.fms") THEN      'charge le fichier dans la memoire
           PRINT "Erreur de chargement de fichier.fms"     'gestion d'erreur s'il
                                                           'ya erreur dans le chargement du fichier
           END
END IF

playfms   'Joue le son

DO    'Votre programme dans cette boucle
        c$=inkey$
        IF eofms THEN stopfms : c$ = chr$(27)        'Quitter si la fin du FMS
        loopfms     'il joue le son en arriere plan (toujours dans une boucle)

         '--- ici mettre votre programme

         'deux stupides lignes pour voir que le son joue en
         'BackGround
         LOCATE 1,1:PRINT "Ceci est un nombre aleatoire:";
         PRINT RND*1000

LOOP UNTIL c$=chr$(27)
stopfms         'stoppe le son
fmsongclose     'fermeture de la librairie
```

## Links
- Official web page: https://qbworld.asher256.com/fmsong.php
