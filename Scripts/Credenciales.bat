@echo off


SET servidor=IP o NombreServidot
SET usuario="Dominio\Usuario"
SET contrasena="Contraseña"

CMDKEY /delete:%servidor%  rem elimina credencial para el servidor indicado

CMDKEY /add:%servidor% /user:%usuario% /pass:%contrasena%  rem agrega credencial para el servidor indicado

echo "Fin del Script"

pause