# 1. 设置变量
$url = "https://www.cloudyou.top/files/freewpfshell.zip"
$zipFile = "D:\freewpfshell.zip"
$destFolder = "D:\FreeWPFShellBin"
$exePath = Join-Path $destFolder "FreeWPFShell.exe"
$desktopPath = [Environment]::GetFolderPath("Desktop")
$shortcutPath = Join-Path $desktopPath "FreeWPFShell.lnk"

# 2. 创建目标文件夹（如果不存在）
if (-not (Test-Path $destFolder)) {
    Write-Host "Creating File Folder: $destFolder..." -ForegroundColor Cyan
    New-Item -Path $destFolder -ItemType Directory | Out-Null
}

# 3. 下载文件
Write-Host "Downloading files from $url ..." -ForegroundColor Cyan
Invoke-WebRequest -Uri $url -OutFile $zipFile

# 4. 解压文件
Write-Host "Unzip $destFolder..." -ForegroundColor Cyan
# 使用 -Force 确保覆盖旧文件
Expand-Archive -Path $zipFile -DestinationPath $destFolder -Force

# 5. 创建桌面快捷方式
Write-Host "Creating Desktop Shutcut..." -ForegroundColor Cyan
$wshell = New-Object -ComObject WScript.Shell
$shortcut = $wshell.CreateShortcut($shortcutPath)
$shortcut.TargetPath = $exePath
$shortcut.WorkingDirectory = $destFolder
$shortcut.Description = "FreeWPFShell 快捷方式"
$shortcut.Save()

# 6. 删除下载的 ZIP 文件
Write-Host "Cleaning Temp Files..." -ForegroundColor Cyan
Remove-Item -Path $zipFile -ErrorAction SilentlyContinue

# 7. 启动程序
Write-Host "Installed, Starting FreeWPFShell..." -ForegroundColor Green
Start-Process -FilePath $exePath -WorkingDirectory $destFolder

Write-Host "All Done!" -ForegroundColor Yellow