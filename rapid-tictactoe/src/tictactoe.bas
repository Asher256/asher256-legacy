'----------------------------------------------------------------
' RAPID TicTacToe 1.0
' Par Asher256
'
' Compile avec RapidQ, en mars 2001.
' 
' Url: https://qbworld.asher256.com/product.php?programme=rttc
'----------------------------------------------------------------

$include "rapidq.inc"
$include "carreau.inc"
$resource table_bmp as "table.bmp"
$resource croie_bmp as "croie.bmp"
$resource rond_bmp as "rond.bmp"
$resource perdu_bmp as "perdu.bmp"
$resource gagne_bmp as "gagne.bmp"
$resource icone as "tictactoe_icone.ico"


CONST soundfile$="fx1.tss"
CONST soundgagne$="fx2.tss"
CONST soundfin$="fx3.tss"


DIM ordinateur AS INTEGER
    ordinateur = true

DIM CarteSon AS INTEGER
carteson = true

'teste si la carte son existe
'IF WaveOutGetNumDevs<1 THEN
'    showmessage("Il n'y ya pas de carte son")
'    carteson = false
'END IF




DIM objets(9) AS INTEGER
DIM perdu AS INTEGER
perdu = false
youpi = false

'my test$ c'est le teste diagonale horizontale...
DIM mytest$(9) AS STRING

mytest$(1) = "123"
mytest$(2) = "456"
mytest$(3) = "789"
mytest$(4) = "147"
mytest$(5) = "258"
mytest$(6) = "369"
mytest$(7) = "159"
mytest$(8) = "357"



DIM table AS QBITMAP
    table.bmphandle = table_bmp
    
DIM croie AS QBITMAP
    croie.bmphandle = croie_bmp
    croie.transparent = true
            
DIM rond AS QBITMAP 
    rond.bmphandle = rond_bmp
    rond.transparent = true

DIM buffer AS QBITMAP
    buffer.width = 222
    buffer.height = 222
    buffer.draw(0,0,table.bmp)

DIM buffer2 AS QBITMAP
    buffer2.width = 359
    buffer2.height = 169
    
        
DIM fenetre as qform
fenetre.caption = "RAPID TIC TAC TOE"
    fenetre.clientwidth = 222
    fenetre.clientheight = 239
    fenetre.center
    fenetre.borderstyle = bssingle
    fenetre.icohandle = icone
    
DIM canvas as QCANVAS
    canvas.left = 0
    canvas.top = 0
    canvas.width = 222
    canvas.height = 222
    canvas.parent = fenetre

DIM gagne_im AS qbitmap
    gagne_im.bmphandle = gagne_bmp
    
DIM perdu_im AS qbitmap
    perdu_im.bmphandle = perdu_bmp
    
    DIM formfin AS QFORM
    formfin.width = 359+5
    formfin.height = 169+21
    formfin.borderstyle = bstoolwindow
    formfin.center
    
    
    
DIM canvas2 AS QCANVAS
    canvas2.left = 0
    canvas2.top = 0
    canvas2.width = 359
    canvas2.height = 169
    canvas2.parent = formfin
    
DIM boutton AS qbutton
    boutton.parent = formfin
    boutton.kind = bkok
    boutton.left= 137
    boutton.top = 130
    boutton.width = 80       
'----------------Le menu boite de dialogue------------------------
DIM MyMenu AS QMainMenu

DIM mnu_fichiers AS QMenuItem
DIM mnu_quitter AS QMenuitem
DIM mnu_nouveau AS QMenuItem
DIM Mnu_credits AS Qmenuitem
DIM Mnu_2Joueurs AS Qmenuitem
DIM Mnu_1VsOrdinateur AS Qmenuitem
DIM mnu_separateur AS QMenuItem
DIM mnu_separateur2 AS QMenuItem

DIM mnu_1pcommence AS QMenuItem
DIM mnu_ordicommence AS QMenuItem
DIM mnu_separateur3 AS QMenuItem


MyMenu.Parent = fenetre
MyMenu.AddItems mnu_fichiers,Mnu_Credits

mnu_separateur.caption = "-"
mnu_separateur2.caption = "-"

mnu_2joueurs.caption = "2 Joueurs"
mnu_1VsOrdinateur.caption = "1 Joueur VS ordinateur"
mnu_1VsOrdinateur.checked = true
Mnu_Credits.caption = "&Credits"
mnu_fichiers.Caption = "&Fichiers"
Mnu_Nouveau.caption = "&Nouveau jeu     F2"
Mnu_quitter.caption = "&Quitter..." 
mnu_ordicommence.caption = "L'ordinateur commence..."
mnu_1pcommence.caption = "Joueur commence..."
mnu_separateur3.caption = "-"
mnu_ordicommence.checked = true
mnu_fichiers.AddItems Mnu_Nouveau,mnu_separateur,mnu_1VsOrdinateur,mnu_2joueurs,mnu_separateur2,mnu_1pcommence,mnu_ordicommence,mnu_separateur3,Mnu_Quitter

'------------Le fin du menu boite de dialogue

DIM info as qlabel
    info.left = 0
    info.width = 0
     info.top=0
    info.caption = info
    info.parent =fenetre

DIM joueur AS INTEGER
    joueur = 1
    

'une sub pour charger le son et le diffuser
SUB myplaysound(file AS STRING,opt AS LONG)
    if carteson = true then
        playwav(file,opt)
    end if
END SUB


SUB canvas2_repaint
    IF perdu = true THEN
        buffer2.draw(0,0,perdu_im.bmp)
    END IF
    IF youpi = true THEN
        buffer2.draw(0,0,gagne_im.bmp)
    END IF


    canvas2.draw(0,0,buffer2.bmp)
END SUB


SUB gameover
    formfin.caption = "Perdu..."
    formfin.show
    canvas2_repaint    
    
    For i=1 to 8
        If objets(i)=0 THEN objets(i)=2
    NEXT

    myplaysound(soundfin$,snd_async)

END SUB





SUB gagne
    formfin.caption = "Vous avez gagné..."
    formfin.show
    canvas2_repaint
   
    
    For i=1 to 8
        
        If objets(i)=0 THEN objets(i)=2
    NEXT
    
    myplaysound(soundgagne$,snd_async)
   
END SUB

SUB formfin_key
            formfin.close
END SUB


FUNCTION sendstrtest(c1%,c2%,c3%) AS STRING
'cette fonction envoie les trois var c1 et c2 et c3 dans une seule
'chaine de caractère.

letexte$ = str$(objets(c1%)) 
letexte$ = letexte$ + str$(objets(c2%)) 
letexte$ = letexte$ + str$(objets(c3%))

sendstrtest = letexte$
END FUNCTION
    


SUB affiche

buffer.draw(0,0,table.bmp)
i=0
FOR pcy%= 1 TO 3
FOR pcx%= 1 TO 3
i = i + 1
x% = carreauput(0,pcx%,79)
y% = carreauput(0,pcy%,79)


IF objets(i)=1 THEN buffer.draw(x%,y%,croie.bmp)
IF objets(i)= -1 THEN  buffer.draw(x%,y%,rond.bmp)

NEXT
NEXT

END SUB


'ici c'est quand l'ordinateur joue (l'intelligence artificielle)
SUB jeu_ordinateur

DIM C_ME AS STRING
DIM C AS STRING
DIM st AS STRING

c = str$(joueur*-1)
c_me = str$(joueur)

   

'c'est la ou on va stocker les 3 positions du test
DIM myc(3) AS INTEGER

'l'attaque s'il trouve deux O alors il remplis le 3eme
FOR I=1 TO 8
    myc(1) = val(mid$(mytest$(i),1,1))
    myc(2) = val(mid$(mytest$(i),2,1))
    myc(3) = val(mid$(mytest$(i),3,1))
    
    st = sendstrtest(myc(1),myc(2),myc(3))
 
    IF st = c_me+c_me+"0" OR st=c_me+"0"+c_me OR st="0"+c_me+c_me THEN 
        
        FOR I=1 TO 3 
            IF objets(myc(i)) = 0 THEN 
                        pos% = i
                        perdu = true
                        EXIT FOR
            END IF
        NEXT
        
        objets(myc(pos%)) = val(c_me)
        
        GOTO fin_ordinateur
    END IF
NEXT



'la defense s'il trouve deux X alors il remplis le 3eme avec un rond
FOR I=1 TO 8
    myc(1) = val(mid$(mytest$(i),1,1))
    myc(2) = val(mid$(mytest$(i),2,1))
    myc(3) = val(mid$(mytest$(i),3,1))
    
    st = sendstrtest(myc(1),myc(2),myc(3))
   
  IF st = C+C+"0" OR st = C+"0"+C OR st = "0"+C+C THEN 
   
        FOR I=1 TO 3 
            IF objets(myc(i)) = 0 THEN 
                        pos% = i
                        EXIT FOR
            END IF
        NEXT             
        
        objets(myc(pos%)) = val(c_me)
        
        GOTO fin_ordinateur
    END IF
NEXT

'ici s'il ya le coup de troie
IF objets(1)=val(c) AND objets(8)=val(c) AND objets(4)=0 AND objets(7)=0 AND objets(9)=0 THEN
    objets(7)=val(c_me)
    goto fin_ordinateur
END IF

IF objets(1)=val(c) AND objets(9)=val(c) AND objets(4)=0 AND objets(7)=0 AND objets(8)=0 THEN
    objets(6)=val(c_me)
    goto fin_ordinateur
END IF


IF objets(3)=val(c) AND objets(7)=val(c) AND objets(6)=0 AND objets(8)=0 AND objets(9)=0 THEN
    objets(4)=val(c_me)
    goto fin_ordinateur
END IF    

 




'et maintenant le jeu libre s'il n'y a rien

'ici si le centre est vide alors il le prend
IF objets(5)=0 THEN objets(5)=val(c_me):goto fin_ordinateur

'ici il remplis les quatre coins
IF objets(1)=0 THEN objets(1)=val(c_me) : goto fin_ordinateur
IF objets(3)=0 THEN objets(3)=val(c_me):goto fin_ordinateur
IF objets(7)=0 THEN objets(7)=val(c_me):goto fin_ordinateur
IF objets(9)=0 THEN objets(9)=val(c_me):goto fin_ordinateur

'ici il remplis les quatre coins +
IF objets(2)=0 THEN objets(1)=val(c_me):goto fin_ordinateur
IF objets(4)=0 THEN objets(1)=val(c_me):goto fin_ordinateur
IF objets(6)=0 THEN objets(1)=val(c_me):goto fin_ordinateur
IF objets(8)=0 THEN objets(1)=val(c_me):goto fin_ordinateur





fin_ordinateur:
affiche

IF perdu=true THEN gameover

 
END SUB



SUB clique(boutton%,x%,y%,shift%)
    IF perdu=true OR youpi = true THEN 
        SOUND 1000,0.25
        EXIT SUB
    END IF
    
    pcx% = carreau(x%,0,79)
    pcy% = carreau(y%,0,79)
    
    IF objets(ptable(pcx%,pcy%,3)) <>0 THEN
            SOUND 1000,0.25
                        EXIT SUB
    END IF
    
    
    
    objets(ptable(pcx%,pcy%,3)) = joueur
    
DIM myc(3) AS INTEGER    
DIM c AS STRING
C = str$(joueur)
DIM st AS STRING

'Si le joueur gagne
FOR I=1 TO 8
    myc(1) = val(mid$(mytest$(i),1,1))
    myc(2) = val(mid$(mytest$(i),2,1))
    myc(3) = val(mid$(mytest$(i),3,1))
    1vsOrdinateur_click
    st = sendstrtest(myc(1),myc(2),myc(3))
     
    IF st = c+c+c THEN 
     
     youpi = true
     canvas2.repaint
     gagne  
     affiche
      
      canvas.draw(0,0,buffer.bmp)
      exit sub
    END IF
NEXT

    'et enfin il affiche
    canvas.draw(0,0,buffer.bmp)
    myplaysound(soundfile$,snd_async)
    

    affiche
    'l'ordinateur joue maintenant...
    '--------------------------------------------------
    IF Mnu_1VsOrdinateur.checked = true THEN
        joueur = joueur * -1
         jeu_ordinateur
    END IF
    '---------------------------------------------------
    joueur = joueur * -1


canvas.draw(0,0,buffer.bmp)
       
END SUB



SUB quitter
IF messagedlg("Voulez vous quitter ce programme genial :) ?",mtinformation,mbyes+mbno,0)=mryes THEN
End
END IF
END SUB
SUB credits
messagedlg("Rapid - TIC TAC TOE -" +chr$(13)+"Par Asher256, 2001"+chr$(13)+chr$(13)+chr$(13)+"URL: http://qbworld.asher256.com/",mtinformation,mbok,0)
END SUB


SUB nouveau
    FOR I=1 TO 9
        objets(i)=0
    NEXT
    
    if mnu_ordicommence.checked = true then joueur = -1
    if mnu_1pcommence.checked = true then joueur = 1
        
    if Mnu_1VsOrdinateur.checked = true and joueur = -1 then
            objets(fix(rnd*9)+1)=joueur
            'jeu_ordinateur
            joueur = 1
    end if
    
    affiche
    canvas.draw(0,0,buffer.bmp)
    perdu = false
    youpi = false
END SUB

SUB formfin_onshow
    canvas2.draw(0,0,perdu_im.bmp)
END SUB

SUB canvas_repaint
    canvas.draw(0,0,buffer.bmp)
END SUB

SUB 1vsOrdinateur_click
    mnu_1vsOrdinateur.checked = true
    mnu_2joueurs.checked = false
    joueur=1
    nouveau
    affiche
    canvas.draw(0,0,buffer.bmp)
    mnu_1pcommence.caption = "Joueur 1 commence..."
    mnu_ordicommence.caption = "L'ordinateur commence..."
  
        
END SUB

SUB 2joueurs_click
    mnu_1vsOrdinateur.checked = false
    mnu_2joueurs.checked = true    
    joueur=1    
    nouveau
    affiche
    canvas.draw(0,0,buffer.bmp)
    mnu_1pcommence.caption = "Joueur 1 commence..."
    mnu_ordicommence.caption = "Joueur 2 Commence..."
    
    
END SUB

SUB fenetre_keydown(ascii as byte,shift as byte)
    'sil appuie sur F2 c'est comme si il clique sur nouveau
    IF ascii = 113 THEN nouveau
    
END SUB

SUB mnu_ordicommence_click
    mnu_ordicommence.checked = true
    mnu_1pcommence.checked = false
    nouveau
END SUB

SUB mnu_1pcommence_click
    mnu_ordicommence.checked = false
    mnu_1pcommence.checked = true
    nouveau
END SUB


fenetre.onkeydown = fenetre_keydown

mnu_1vsOrdinateur.onclick = 1vsOrdinateur_click
mnu_2joueurs.onclick = 2joueurs_click

formfin.onshow = formfin_onshow
Canvas.OnMouseUp = clique

Mnu_credits.onclick = credits
Mnu_nouveau.onclick = Nouveau
mnu_quitter.onclick = quitter
'formfin.onkeypress = formfin_key

canvas.onpaint = canvas_repaint
boutton.onclick = formfin_key
canvas2.onpaint = canvas2_repaint

mnu_ordicommence.onclick = mnu_ordicommence_click
mnu_1pcommence.onclick = mnu_1pcommence_click


fenetre.show
nouveau

DO
    doevents
LOOP UNTIL fenetre.visible = 0
