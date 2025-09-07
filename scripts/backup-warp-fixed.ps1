# Warp Configuration Backup Script
# Backs up Warp terminal configurations to the dotfiles repository

param(
    [switch]$Force,
    [string]$BackupPath = "$PSScriptRoot\..\warp\settings"
)

Write-Host "🚀 Warp Configuration Backup" -ForegroundColor Cyan
Write-Host "================================" -ForegroundColor Cyan

# Warp configuration paths
$WarpDataPath = "$env:LOCALAPPDATA\warp\Warp"
$WarpConfigFile = "$WarpDataPath\data\dev.warp.Warp-User"

# Check if Warp is installed
if (-not (Test-Path $WarpDataPath)) {
    Write-Host "❌ Warp not found. Please install Warp terminal first." -ForegroundColor Red
    exit 1
}

# Create backup directory if it doesn't exist
if (-not (Test-Path $BackupPath)) {
    New-Item -ItemType Directory -Path $BackupPath -Force | Out-Null
    Write-Host "📁 Created backup directory: $BackupPath" -ForegroundColor Green
}

# Backup main configuration file
if (Test-Path $WarpConfigFile) {
    $BackupFile = "$BackupPath\warp-user-config.json"
    Copy-Item $WarpConfigFile $BackupFile -Force
    Write-Host "✅ Backed up user configuration" -ForegroundColor Green
} else {
    Write-Host "⚠️  User configuration file not found" -ForegroundColor Yellow
}

# Backup database (contains settings, history, etc.)
$WarpDB = "$WarpDataPath\data\warp.sqlite"
if (Test-Path $WarpDB) {
    $BackupDB = "$BackupPath\warp-settings.db"
    
    # Only backup if file has changed or force is specified
    $ShouldBackup = $Force.IsPresent
    if (Test-Path $BackupDB) {
        $OriginalHash = (Get-FileHash $WarpDB).Hash
        $BackupHash = (Get-FileHash $BackupDB).Hash
        $ShouldBackup = $ShouldBackup -or ($OriginalHash -ne $BackupHash)
    } else {
        $ShouldBackup = $true
    }
    
    if ($ShouldBackup) {
        Copy-Item $WarpDB $BackupDB -Force
        Write-Host "✅ Backed up Warp database" -ForegroundColor Green
    } else {
        Write-Host "ℹ️  Database unchanged, skipping backup" -ForegroundColor Blue
    }
}

# Create a backup metadata file
$MetadataFile = "$BackupPath\backup-info.json"
$FileList = @()

Get-ChildItem $BackupPath -File | ForEach-Object {
    if ($_.Name -ne "backup-info.json") {
        $FileList += @{
            Name = $_.Name
            Size = $_.Length
            LastModified = $_.LastWriteTime.ToString("yyyy-MM-dd HH:mm:ss")
        }
    }
}

$Metadata = @{
    BackupDate = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
    ComputerName = $env:COMPUTERNAME
    UserName = $env:USERNAME
    WarpVersion = "Unknown"
    Files = $FileList
}

$Metadata | ConvertTo-Json -Depth 3 | Out-File $MetadataFile -Encoding UTF8
Write-Host "📝 Created backup metadata" -ForegroundColor Green

Write-Host ""
Write-Host "🎉 Backup completed successfully!" -ForegroundColor Green
Write-Host "📂 Backup location: $BackupPath" -ForegroundColor Gray

# Suggest next steps
Write-Host ""
Write-Host "💡 Next steps:" -ForegroundColor Yellow
Write-Host "   1. Review backed up files in: $BackupPath"
Write-Host "   2. Commit changes: git add . && git commit -m 'Update Warp config'"
Write-Host "   3. Push to remote: git push"
