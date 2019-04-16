@echo off

SET servidor=IP o Nombreservidor
SET Impresora=NombreImpresora

rundll32.exe printui.dll PrintUIEntry /dn /n /q "\\%servidor%\%Impresora%"


echo "Fin del Script"

pause