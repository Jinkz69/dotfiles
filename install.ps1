# Dotfiles Installation Script for Windows
# Sets up cross-platform development environment

param(
    [switch]$Force,
    [switch]$BackupExisting,
    [string[]]$Components = @("all")
)

$ErrorActionPreference = "Stop"

Write-Host "🏠 Dotfiles Installation for Windows" -ForegroundColor Cyan
Write-Host "====================================" -ForegroundColor Cyan
Write-Host ""

# Get the directory where this script is located
$DotfilesPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

# Helper function to create symlinks
function New-SymbolicLink {
    param(
        [string]$Source,
        [string]$Target
    )
    
    if (Test-Path $Target) {
        if ($BackupExisting) {
            $BackupPath = "$Target.backup.$(Get-Date -Format 'yyyyMMdd-HHmmss')"
            Move-Item $Target $BackupPath
            Write-Host "📦 Backed up existing file to: $BackupPath" -ForegroundColor Yellow
        } elseif (-not $Force) {
            Write-Host "⚠️  File exists: $Target (use -Force to overwrite)" -ForegroundColor Yellow
            return
        } else {
            Remove-Item $Target -Force -Recurse
        }
    }
    
    # Create parent directory if it doesn't exist
    $ParentDir = Split-Path -Parent $Target
    if (-not (Test-Path $ParentDir)) {
        New-Item -ItemType Directory -Path $ParentDir -Force | Out-Null
    }
    
    # Create the symlink
    if (Test-Path $Source) {
        New-Item -ItemType SymbolicLink -Path $Target -Value $Source -Force | Out-Null
        Write-Host "🔗 Linked: $Target -> $Source" -ForegroundColor Green
    } else {
        Write-Host "❌ Source not found: $Source" -ForegroundColor Red
    }
}

# Component installation functions
function Install-GitConfig {
    Write-Host "📦 Installing Git configuration..." -ForegroundColor Blue
    
    $GitConfigPath = "$DotfilesPath\git\.gitconfig"
    if (Test-Path $GitConfigPath) {
        New-SymbolicLink -Source $GitConfigPath -Target "$env:USERPROFILE\.gitconfig"
    }
    
    $GitIgnorePath = "$DotfilesPath\git\.gitignore_global"
    if (Test-Path $GitIgnorePath) {
        New-SymbolicLink -Source $GitIgnorePath -Target "$env:USERPROFILE\.gitignore_global"
        
        # Set global gitignore
        git config --global core.excludesfile "~/.gitignore_global"
        Write-Host "✅ Configured global gitignore" -ForegroundColor Green
    }
}

function Install-PowerShellProfile {
    Write-Host "📦 Installing PowerShell profile..." -ForegroundColor Blue
    
    $ProfilePath = "$DotfilesPath\powershell\profile.ps1"
    if (Test-Path $ProfilePath) {
        # Create profile directory if it doesn't exist
        $ProfileDir = Split-Path -Parent $PROFILE
        if (-not (Test-Path $ProfileDir)) {
            New-Item -ItemType Directory -Path $ProfileDir -Force | Out-Null
        }
        
        New-SymbolicLink -Source $ProfilePath -Target $PROFILE
    }
}

function Install-WarpConfig {
    Write-Host "📦 Setting up Warp configuration sync..." -ForegroundColor Blue
    
    # Create a scheduled task to backup Warp settings regularly
    $BackupScript = "$DotfilesPath\scripts\backup-warp.ps1"
    if (Test-Path $BackupScript) {
        Write-Host "✅ Warp backup script available at: $BackupScript" -ForegroundColor Green
        Write-Host "💡 Run manually: .\scripts\backup-warp.ps1" -ForegroundColor Yellow
    }
}

function Install-ProjectTemplates {
    Write-Host "📦 Setting up project templates..." -ForegroundColor Blue
    
    $ProjectsPath = "$DotfilesPath\projects"
    Write-Host "✅ Project templates available at: $ProjectsPath" -ForegroundColor Green
    Write-Host "📚 Standards documented in: $ProjectsPath\standards\" -ForegroundColor Gray
}

function Install-VSCodeSettings {
    Write-Host "📦 Installing VS Code settings..." -ForegroundColor Blue
    
    $VSCodeConfigPath = "$DotfilesPath\vscode\settings.json"
    $VSCodeUserSettings = "$env:APPDATA\Code\User\settings.json"
    
    if (Test-Path $VSCodeConfigPath) {
        New-SymbolicLink -Source $VSCodeConfigPath -Target $VSCodeUserSettings
    } else {
        Write-Host "ℹ️  VS Code settings not found, skipping..." -ForegroundColor Gray
    }
}

# Main installation logic
Write-Host "🔍 Components to install: $($Components -join ', ')" -ForegroundColor Gray
Write-Host ""

if ($Components -contains "all" -or $Components -contains "git") {
    Install-GitConfig
}

if ($Components -contains "all" -or $Components -contains "powershell") {
    Install-PowerShellProfile
}

if ($Components -contains "all" -or $Components -contains "warp") {
    Install-WarpConfig
}

if ($Components -contains "all" -or $Components -contains "projects") {
    Install-ProjectTemplates
}

if ($Components -contains "all" -or $Components -contains "vscode") {
    Install-VSCodeSettings
}

# Initialize git repository if not already done
if (-not (Test-Path "$DotfilesPath\.git")) {
    Write-Host ""
    Write-Host "🚀 Initializing dotfiles repository..." -ForegroundColor Blue
    
    Set-Location $DotfilesPath
    git init
    git add .
    git commit -m "Initial dotfiles setup"
    
    Write-Host "💡 To push to GitHub:" -ForegroundColor Yellow
    Write-Host "   git remote add origin https://github.com/Jinkz69/dotfiles.git"
    Write-Host "   git branch -M main"
    Write-Host "   git push -u origin main"
}

Write-Host ""
Write-Host "🎉 Dotfiles installation completed!" -ForegroundColor Green
Write-Host ""
Write-Host "📚 Next steps:" -ForegroundColor Yellow
Write-Host "   1. Restart your terminal to load new configurations"
Write-Host "   2. Run: .\scripts\backup-warp.ps1 to backup current Warp settings"
Write-Host "   3. Check out project templates in: .\projects\templates\"
Write-Host "   4. Customize configurations in this directory"
Write-Host ""
Write-Host "🔄 To sync on other machines:" -ForegroundColor Cyan
Write-Host "   git clone https://github.com/Jinkz69/dotfiles.git && cd dotfiles && .\install.ps1"
