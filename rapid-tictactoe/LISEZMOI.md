# Rapid Tic Tac Toe (version 1.5, sorti en 2001)

Auteur: Asher256
Site: https://qbworld.asher256.com/product.php?programme=rttc

## Introduction

Bienvenue dans le jeu Tic Tac Toe ! Qui ne connait pas ce jeu auquel on a tous
joue au lycee et au college, pour passer le temps ?

Tic Tac Toe, egalement connu sous le nom de Morpion, est un jeu de reflexion
pour deux joueurs. Il se joue sur une grille de 3x3 cases. Les joueurs jouent
tour a tour en mettant les symboles (X ou O) dans une case libre de la
grille. Le but du jeu est d'aligner trois symboles identiques horizontalement,
verticalement ou en diagonale. Le premier joueur a reussir a aligner trois de
ses symboles gagne la partie. Si la grille est remplie sans qu'aucun joueur ne
parvienne a aligner trois symboles, la partie est declaree nulle. Tic Tac Toe
est un jeu simple mais amusant qui peut etre joue par des joueurs de tous ages.

Rapid Tic Tac Toe est le premier jeu que j'ai developpe qui est assez
intelligent jouer contre un humain. Si vous n'etes pas assez bon dans ce jeu,
vous aurez une forte chance de perdre contre l'ordinateur ! Si vous etes
suffisamment bon, vous ferez probablement match nul.

Mais si vous reussissez a gagner, merci de me contacter afin de m'expliquer
comment vous avez gagne ! Cela m'aidera a ameliorer l'algorithme.

Ce jeu a ete cree avec Rapid-Q, le compilateur QBasic pour Windows.
(Rapid-Q peut etre telecharge depuis: 
https://rapidq.phatcode.net/download/index.html ).

## Foire aux Questions

### Comment commencer a jouer?

- Appuyez sur F12 pour commencer une nouvelle partie.
- Le reste du jeu se fait avec la souris. Cliquez sur les cases vides et
  essayez d'aligner trois symboles.

### Comment executer Rapid Tic Tac Toe sous Linux?

Rapid Tic Tac Toe est un programme Windows, mais il peut etre execute sous
Linux a l'aide de wine.

Installez wine 32-bit. Sous Debian ou Ubuntu, vous pouvez l'installer avec
les commandes:
```
sudo dpkg --add-architecture i386
sudo apt-get update
sudo apt-get install wine32
```

Enfin, executez `rapid-tictactoe.exe` avec wine:
```
WINEARCH=win32 WINEPREFIX=~/.wine32 wine rapid-tictactoe.exe
```

## License

### License: Francais

Ce programme est un logiciel libre ; vous pouvez le redistribuer ou le
modifier suivant les termes de la GNU General Public License telle que
publiée par la Free Software Foundation ; soit la version 3 de la
licence, soit (à votre gré) toute version ultérieure.

Ce programme est distribué dans l'espoir qu'il sera utile, mais SANS
AUCUNE GARANTIE ; sans même la garantie tacite de QUALITÉ MARCHANDE ou
d'ADÉQUATION à UN BUT PARTICULIER. Consultez la GNU General Public
License pour plus de détails. 

Vous devez avoir reçu une copie de la GNU General Public License en
même temps que ce programme ; si ce n'est pas le cas, consultez
<http://www.gnu.org/licenses>.

### License: English version

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or (at
your option) any later version.

This program is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program. If not, see
<https://www.gnu.org/licenses/>. 3

## Liens
- Page officielle de Rapid Tic Tac Toe: https://qbworld.asher256.com/product.php?programme=rttc
