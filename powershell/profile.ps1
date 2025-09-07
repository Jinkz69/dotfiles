# PowerShell Profile - Cross-Platform Development

# Set encoding to UTF-8
$OutputEncoding = [console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding

# Import modules if available
try {
    Import-Module posh-git -ErrorAction SilentlyContinue
} catch {
    # posh-git not available
}

# Common aliases
Set-Alias -Name ll -Value Get-ChildItem
Set-Alias -Name la -Value Get-ChildItem
Set-Alias -Name l -Value Get-ChildItem
Set-Alias -Name grep -Value Select-String
Set-Alias -Name which -Value Get-Command
Set-Alias -Name touch -Value New-Item

# Git aliases
function gs { git status $args }
function ga { git add $args }
function gc { git commit $args }
function gp { git push $args }
function gl { git log --oneline --graph --all $args }
function gd { git diff $args }
function gb { git branch $args }
function gco { git checkout $args }

# Directory navigation
function .. { Set-Location .. }
function ... { Set-Location ..\.. }
function .... { Set-Location ..\..\.. }

# Quick navigation to common directories
function cdp { Set-Location C:\Users\$env:USERNAME\Documents\Projects }
function cdd { Set-Location C:\Users\$env:USERNAME\Documents }
function cdt { Set-Location C:\Users\$env:USERNAME\Desktop }

# Dotfiles management
function dotfiles { Set-Location C:\Users\$env:USERNAME\dotfiles }
function backup-warp { 
    Push-Location C:\Users\$env:USERNAME\dotfiles
    .\scripts\backup-warp-fixed.ps1 @args
    Pop-Location
}

# System information
function sysinfo {
    Get-ComputerInfo | Select-Object WindowsProductName, WindowsVersion, TotalPhysicalMemory, CsProcessors
}

# Network utilities
function ping-test { param($host) Test-NetConnection $host -Port 80 }
function ports { Get-NetTCPConnection | Where-Object State -eq Listen }

# File operations
function mkcd { 
    param($path)
    New-Item -ItemType Directory -Path $path -Force | Out-Null
    Set-Location $path
}

function unzip {
    param($file, $destination = ".")
    Expand-Archive -Path $file -DestinationPath $destination
}

# Development helpers
function serve { 
    param($port = 8000)
    python -m http.server $port 2>$null
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Python not available, trying Node.js..." -ForegroundColor Yellow
        npx http-server -p $port
    }
}

function json-pretty {
    param($inputObject)
    $inputObject | ConvertTo-Json -Depth 10 | Write-Host
}

# Package management helpers (respecting user rules)
function pnpm-init { pnpm init }
function pnpm-add { pnpm add @args }
function pnpm-dev { pnpm add -D @args }
function pnpm-run { pnpm run @args }

# Environment setup
$env:EDITOR = "code"

# Custom prompt (simple and clean)
function prompt {
    $location = Get-Location
    $gitBranch = ""
    
    # Try to get git branch if in a git repository
    try {
        $gitBranch = git branch --show-current 2>$null
        if ($gitBranch) {
            $gitBranch = " ($gitBranch)"
        }
    } catch {
        # Not in a git repository or git not available
    }
    
    Write-Host "$env:USERNAME@$env:COMPUTERNAME" -ForegroundColor Green -NoNewline
    Write-Host ":" -NoNewline
    Write-Host "$($location.Path)" -ForegroundColor Blue -NoNewline
    Write-Host "$gitBranch" -ForegroundColor Yellow -NoNewline
    Write-Host ""
    Write-Host "❯ " -ForegroundColor Magenta -NoNewline
    
    return " "
}

# Welcome message
Write-Host ""
Write-Host "🚀 PowerShell Profile Loaded" -ForegroundColor Cyan
Write-Host "💡 Available commands: dotfiles, backup-warp, serve, json-pretty" -ForegroundColor Gray
Write-Host ""
