Set WshNetwork = CreateObject("WScript.Network")
userName = WshNetwork.UserName
startupFolder = "C:\Users\" & userName & "\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"
Set objShell = CreateObject("Shell.Application")
objShell.Open startupFolder