REM Esta tarea es la encargada entre otras cosas de limpiar el escritorio los accesos directos rotos

@echo off

schtasks /change /tn "\Microsoft\Windows\Diagnosis\Scheduled" /disable


echo "Fin del Script"

pause
