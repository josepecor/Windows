
'* Accede directamente al registro para obtener una lista de impresoras conectadas mediante \\nombreservidor\nombreimpresora
'* Primero almacena la impresora predeterminada en una variable, luego elimina la conexión del servidor antiguo y la recrea en el servidor nuevo.
'* Finalmente restaura la impresora predeterminada en su nueva ubicación

Dim from_sv, to_sv, PrinterPath, PrinterName, DefaultPrinterName, DefaultPrinter
Dim DefaultPrinterServer, SetDefault, key
Dim spoint, Loop_Counter
Dim WshNet, WshShell
Dim WS_Printers
DefaultPrinterName = ""
spoint = 0
SetDefault = 0
set WshShell = CreateObject("WScript.shell")

from_sv = "\\..." 'IP o Nombre del servidor original
to_sv = "\\..." 'IP Nombre del nuevo servidor

'* Comprobación de que hay impresoras instaladas
On Error Resume Next
key = "HKCU\Software\Microsoft\Windows NT\CurrentVersion\Windows\Device"
DefaultPrinter = LCase(WshShell.RegRead (key))
If Err.Number <> 0 Then
    DefaultPrinterName = ""
else
    '* Si ha logrado leer correctamente el registro, almacena el nombre de la impresora predeterminada
    spoint = instr(3,DefaultPrinter,"\")+1
    DefaultPrinterServer = left(DefaultPrinter,spoint-2)
    if DefaultPrinterServer = from_sv then
    DefaultPrinterName = mid(DefaultPrinter,spoint,len(DefaultPrinter)-spoint+1)
    end if
end if


'* En esta rutina elimina la conexión del servidor original y la recrea contra el nuevo servidor
Set WshNet = CreateObject("WScript.Network")
Set WS_Printers = WshNet.EnumPrinterConnections

For Loop_Counter = 0 To WS_Printers.Count - 1 Step 2
    PrinterPath = lcase(WS_Printers(Loop_Counter + 1))

    if LEFT(PrinterPath,len(from_sv)) = from_sv then

        spoint = instr(3,PrinterPath,"\")+1
        PrinterName = mid(PrinterPath,spoint,len(PrinterPath)-spoint+1)

        WshNet.RemovePrinterConnection from_sv+"\"+PrinterName

        WshNet.AddWindowsPrinterConnection to_sv+"\"+PrinterName
        '* Comprueba si la impresora que acaba de crear era la predeterminada y, si es el caso, la predetermina de nuevo en su nueva ubicación
        if DefaultPrinterName = PrinterName then
            WshNet.SetDefaultPrinter to_sv+"\"+PrinterName
        end if
    end if
Next

'* Limpia variables y sale
Set WS_Printers = Nothing
Set WshNet = Nothing
Set WshShell = Nothing

