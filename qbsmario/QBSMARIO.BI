'#################################################################
' Fichier BI de QBSMario
'
' Copyright (c) Asher256, 2001
'
' Url:   https://qbworld.asher256.com
'#################################################################

DECLARE FUNCTION MultiKey (T!)

TYPE Registers
         AX    AS INTEGER
         BX    AS INTEGER
         CX    AS INTEGER
         DX    AS INTEGER
         BP    AS INTEGER
         SI    AS INTEGER
         DI    AS INTEGER
         FLAGS AS INTEGER
         DS    AS INTEGER
         ES    AS INTEGER
END TYPE

CONST False = 0, True = NOT False

