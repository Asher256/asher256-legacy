'##########################################################################
'#                         FM-LIB HEADER
'#            Par Asher256, Thunder software 2001
'#
'#
'# Header pour la librairie FM lib il faut toujours l'inclure dans votre
'# prog pour l'inclure: REM $include:'fmsong.bi'
'#
'# Url:    https://qbworld.asher256.com/fmsong.php
'##########################################################################

DEFINT A-Z      'toujours INTEGER pour la rapidit‚e
REM $DYNAMIC    'pour la gestion des tracks dynamiquement
'le type instrument
TYPE instrument
        attack1 AS INTEGER
        attack2 AS INTEGER

        decay1 AS INTEGER
        decay2 AS INTEGER

        sustain1 AS INTEGER
        sustain2 AS INTEGER

        released1 AS INTEGER
        released2 AS INTEGER

        outp1 AS INTEGER
        outp2 AS INTEGER


        amplitudevibrato1 AS INTEGER
        amplitudevibrato2 AS INTEGER

        scalling1 AS INTEGER
        scalling2 AS INTEGER

        waveselect1 AS INTEGER
        waveselect2 AS INTEGER

        pitchvibrato1 AS INTEGER
        pitchvibrato2 AS INTEGER

        frequencymultipler1 AS INTEGER
        frequencymultipler2 AS INTEGER

        enveloppescalling1 AS INTEGER
        enveloppescalling2 AS INTEGER


        sustaininglevel1 AS INTEGER
        sustaininglevel2 AS INTEGER

        feedback AS INTEGER
        connection AS INTEGER
        iname AS STRING * 8
     
END TYPE
DECLARE SUB writereg (Reg%, info%)
DECLARE FUNCTION fmsonginit% ()
DECLARE FUNCTION getmaxnotes% ()
DECLARE FUNCTION getnote% (track%, chan%, num AS INTEGER)
DECLARE SUB getnoteinfo (track%, chan%, num%, diese%, octave%, note%)
DECLARE FUNCTION getpositionnote% ()
DECLARE FUNCTION getvoll% ()
DECLARE FUNCTION getvolr% ()
DECLARE SUB writereg (Reg%, info%)
DECLARE FUNCTION fmsonginit% ()
DECLARE SUB resumefms ()
DECLARE SUB pausefms ()
DECLARE FUNCTION getbaseport% ()
DECLARE SUB resizetrack (max%)
DECLARE FUNCTION getmaxnotes% ()
DECLARE FUNCTION getnote% (track%, chan%, num AS INTEGER)
DECLARE SUB getnoteinfo (track%, chan%, num%, diese%, octave%, note%)
DECLARE FUNCTION getpositionnote% ()
DECLARE FUNCTION loadfms% (a$)
DECLARE SUB sendinstrument (buffer AS instrument)
DECLARE SUB setinstrument ()
DECLARE SUB playit ()
DECLARE FUNCTION mymouseb% ()
DECLARE SUB setvaleur (track%, chan%, num%, diese%, octave%, note%)
DECLARE SUB myplay (chan%, Freq%, oct%, di%)
DECLARE SUB playnote (chan%, note$, octave%)
DECLARE SUB resetchannel (chan%)
DECLARE SUB setnote (track AS INTEGER, chan AS INTEGER, num AS INTEGER, valeur AS INTEGER)
DECLARE SUB playfms ()
DECLARE SUB loopfms ()
DECLARE SUB stopfms ()
DECLARE SUB fmsongclose ()
DECLARE SUB clearins (buffer AS instrument)
DECLARE SUB resetallchannel ()








'La table FM

DIM SHARED notef(11) AS INTEGER
notef(0) = &H16B: notef(1) = &H181: notef(2) = &H198
notef(3) = &H1B0: notef(4) = &H1CA: notef(5) = &H1E5
notef(6) = &H202: notef(7) = &H220: notef(8) = &H241
notef(9) = &H263: notef(10) = &H287: notef(11) = &H2AE

'les buffers
DIM SHARED attack(2) AS INTEGER
DIM SHARED decay(2) AS INTEGER
DIM SHARED sustain(2) AS INTEGER
DIM SHARED released(2) AS INTEGER
DIM SHARED outp(2) AS INTEGER
DIM SHARED scalling(2) AS INTEGER


DIM SHARED pitchvibrato(2) AS INTEGER
DIM SHARED amplitudevibrato(2) AS INTEGER
DIM SHARED frequencymultipler(2) AS INTEGER
DIM SHARED enveloppescalling(2) AS INTEGER
DIM SHARED waveselect(2) AS INTEGER
DIM SHARED sustaininglevel(2) AS INTEGER
DIM SHARED feedback AS INTEGER
DIM SHARED connection AS INTEGER

'----- instruments des 8 chanels
DIM SHARED voll AS INTEGER
DIM SHARED volr AS INTEGER

DIM SHARED iname AS STRING * 8
DIM SHARED channel AS INTEGER   'le channel pour l'echange entre les sub
DIM SHARED thechannel AS INTEGER   'le channel de FM lib
DIM SHARED maxtrack AS INTEGER
maxtrack = 1           'Au debut on a 1 track
DIM SHARED dimmaxtrack AS INTEGER
dimmaxtrack = 10           'au maximum 10 tracks
DIM SHARED trackactuel AS INTEGER
DIM SHARED lesnotes AS INTEGER
lesnotes = 256  '256 notes
DIM SHARED ins(8) AS instrument
FOR i = 1 TO 8: ins(i).iname = "": NEXT
DIM SHARED replay  AS INTEGER
DIM SHARED position AS INTEGER      'la position dans le scroll box
DIM SHARED positioncurseur AS INTEGER      'la position du curseur dans le scrollbox1

'DIM SHARED ch.enabled(1 TO dimmaxtrack, 8) AS INTEGER
'DIM SHARED maxnotes(1 TO dimmaxtrack) AS INTEGER          'le max de notes dans chaque track
'DIM SHARED notes(1 TO dimmaxtrack, 1 TO 8, 0 TO lesnotes) AS INTEGER   ' les notes des channels
'DIM SHARED trackdelay(1 TO dimmaxtrack) AS INTEGER


'-------- var des tracks
DIM SHARED maxnotes(1 TO 1) AS INTEGER          'le max de notes dans chaque track
DIM SHARED trackdelay(1 TO 1) AS INTEGER
DIM SHARED ch.enabled(1 TO 1, 1 TO 8) AS INTEGER
DIM SHARED notes(1 TO 1, 1 TO 8, 0 TO lesnotes - 1) AS INTEGER ' les notes des channels


DIM SHARED oct AS INTEGER  'l'octave
DIM SHARED pname AS STRING * 20   'le nom de la musique
DIM SHARED auteur AS STRING * 20   'l'auteur de la musique
DIM SHARED commentaire AS STRING * 50   'le commentaire de la musique
DIM SHARED fichier AS STRING     'le nom de la musique
DIM SHARED basep AS INTEGER    'le port de base
'---------- les vars de LOOP PLAY
DIM SHARED volactuel AS INTEGER
DIM SHARED panactuel AS INTEGER
DIM SHARED loopnote AS INTEGER
DIM SHARED looptime!
DIM SHARED timefm!
DIM SHARED savetimefm!
DIM SHARED fmssec!
'--------------------------------
'ici pour le loop pour ‚viter les conflits
DIM SHARED isplay AS INTEGER   's'il est en play
DIM SHARED ispause AS INTEGER   's'il est en pause

