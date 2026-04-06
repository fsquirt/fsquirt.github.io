Write-Host "    ______             _       ______  ___________ __         ____"
Write-Host "   / ____/_______  ___| |     / / __ \/ ____/ ___// /_  ___  / / /"
Write-Host "  / /_  / ___/ _ \/ _ \ | /| / / /_/ / /_   \__ \/ __ \/ _ \/ / / "
Write-Host " / __/ / /  /  __/  __/ |/ |/ / ____/ __/  ___/ / / / /  __/ / /  "
Write-Host "/_/   /_/   \___/\___/|__/|__/_/   /_/    /____/_/ /_/\___/_/_/   "
Write-Host "                                                                  "
Write-Host "                                 Under MIT license, github:fsquirt"

# 1. 设置变量
$urls = @(
    "https://www.cloudyou.top/files/FreeWPFShell_EXE.zip",
    "https://www.cloudyou.top/files/FreeWPFShell_Depend.zip"
)
$tempFolder = "D:\FreeWPFShellTemp"
$destFolder = "D:\FreeWPFShellBin"
$exePath = Join-Path $destFolder "FreeWPFShell.exe"
$desktopPath = [Environment]::GetFolderPath("Desktop")
$shortcutPath = Join-Path $desktopPath "FreeWPFShell.lnk"

# 2. 创建临时文件夹和目标文件夹
foreach ($folder in @($tempFolder, $destFolder)) {
    if (-not (Test-Path $folder)) {
        New-Item -Path $folder -ItemType Directory | Out-Null
    }
}

# 3. 下载并解压
foreach ($url in $urls) {
    $fileName = Split-Path $url -Leaf
    $zipFile = Join-Path $tempFolder $fileName
    Write-Host "Downloading $fileName ..." -ForegroundColor Cyan
    Invoke-WebRequest -Uri $url -OutFile $zipFile
    Write-Host "Extracting $fileName ..." -ForegroundColor Cyan
    Expand-Archive -Path $zipFile -DestinationPath $destFolder -Force
}

# 4. 创建桌面快捷方式
Write-Host "Creating Desktop Shortcut..." -ForegroundColor Cyan
$wshell = New-Object -ComObject WScript.Shell
$shortcut = $wshell.CreateShortcut($shortcutPath)
$shortcut.TargetPath = $exePath
$shortcut.WorkingDirectory = $destFolder
$shortcut.Description = "FreeWPFShell"
$shortcut.Save()

# 5. 清理临时文件
Write-Host "Cleaning Temp Files..." -ForegroundColor Cyan
Remove-Item -Path $tempFolder -Recurse -Force -ErrorAction SilentlyContinue

# 6. 启动程序
Write-Host "Installed, Starting FreeWPFShell..." -ForegroundColor Green
Start-Process -FilePath $exePath -WorkingDirectory $destFolder
Write-Host "All Done!" -ForegroundColor Yellow