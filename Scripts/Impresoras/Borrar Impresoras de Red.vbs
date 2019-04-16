Wscript.Echo "Se procederá a borrar todas las impresoras de Red"
strComputer = "."
Set WshNetwork = WScript.CreateObject("WScript.Network")
Set objShell = CreateObject("Wscript.Shell")
Set objWMIService = GetObject("winmgmts:" _
& "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")
Set colInstalledPrinters = objWMIService.ExecQuery _
("Select * from Win32_Printer")

'Wscript.Echo "Enumero las impresoras del sistema:"
'Wscript.Echo "______________________________"
For Each objPrinter in colInstalledPrinters
'Wscript.Echo "Nombre: " & objPrinter.Name
'Wscript.Echo "Localización: " & objPrinter.Location
if InStr(objPrinter.Name, "\\") > 0 then
'wscript.echo Now & " Borraré: " & objPrinter.Name
WshNetwork.RemovePrinterConnection objPrinter.Name
end if
Next
'Wscript.Echo Now & " Terminado. "
Wscript.Echo "Impresoras de Red Borradas."