' Le fichier carreau.inc est un fichier inc de RAPIDQ 
' et l'utilitaire de carreau par
' Asher256 (c) 2001

FUNCTION carreau(x%, dx%, dimcx%) AS INTEGER
	pcx% = ((x% - dx%) / dimcx%) + 1
	carreau = pcx%
END FUNCTION

FUNCTION carreauput(dx%,pcx%,dimcx%) AS INTEGER
	cputx% = (dimcx% * PCX%) + dx% - dimcx%
	carreauput = cputx%
END FUNCTION

FUNCTION ptable (pcx%, pcy%, xcm%) AS integer
	'ptable donne le numéro de table d'une table cliquée
	ptable = ((pcy% * xcm%) - (xcm% - PCX%))

END FUNCTION


FUNCTION pctableX (postable%, xcmax%) AS INTEGER
	mypcy% = ((postable% - 1) / xcmax%)+1
	myPCX% = postable% / mypcy%	
	pctableX = mypcx%
END FUNCTION 

FUNCTION pctableY (postable%, xcmax%) AS INTEGER
	mypcy% = (((postable% - 1) / xcmax%) + 1)
	myPCX% = postable% / mypcy%
	pctabley = mypcy%
END FUNCTION


