@echo off

SET puerto=NumeroPuerto
SET ReglaTCP=NombreReglaTCP
SET ReglaUDP=NombreReglaUDP

netsh advfirewall firewall delete rule name="%ReglaTCP%"

netsh advfirewall firewall delete rule name="%ReglaUDP%"

netsh advfirewall firewall add rule name="%ReglaTCP%" dir=in action=allow profile=any protocol=TCP localport=%puerto%

netsh advfirewall firewall add rule name="%ReglaUDP%" dir=in action=allow profile=any protocol=UDP localport=%puerto%

netsh advfirewall firewall add rule name="%ReglaTCP%" dir=out action=allow profile=any protocol=TCP remoteport=%puerto%

netsh advfirewall firewall add rule name="%ReglaUDP%" dir=out action=allow profile=any protocol=UDP remoteport=%puerto%

echo "Fin del Script"

pause