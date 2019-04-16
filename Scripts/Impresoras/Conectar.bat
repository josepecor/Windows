@echo off

SET servidor=IP o Nombreservidor
SET Impresora=NombreImpresora

rundll32 printui.dll,PrintUIEntry /in /q /n  "\\%servidor%\%Impresora%"


echo "Fin del Script"

pause
