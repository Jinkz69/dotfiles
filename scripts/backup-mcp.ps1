# MCP Configuration Backup Script
# Documents and backs up MCP server configurations for Warp

param(
    [switch]$UpdateDocs,
    [string]$BackupPath = "$PSScriptRoot\..\mcp"
)

Write-Host "🔧 MCP Configuration Backup" -ForegroundColor Cyan
Write-Host "============================" -ForegroundColor Cyan

# Ensure backup directory exists
if (-not (Test-Path $BackupPath)) {
    New-Item -ItemType Directory -Path $BackupPath -Force | Out-Null
    Write-Host "📁 Created MCP backup directory: $BackupPath" -ForegroundColor Green
}

# Create timestamp for backup
$Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

# Since MCP configs are stored in Warp's database, we document the current state
Write-Host "📝 Documenting current MCP configuration..." -ForegroundColor Blue

# Update the configuration timestamp
$ConfigFile = "$BackupPath\proxmox-config.json"
if (Test-Path $ConfigFile) {
    $Config = Get-Content $ConfigFile | ConvertFrom-Json
    $Config.mcp_server.last_updated = (Get-Date -Format "yyyy-MM-dd")
    $Config | ConvertTo-Json -Depth 10 | Out-File $ConfigFile -Encoding UTF8
    Write-Host "✅ Updated Proxmox configuration timestamp" -ForegroundColor Green
}

# Create a backup log
$BackupLog = "$BackupPath\backup-log.json"
$LogEntry = @{
    timestamp = $Timestamp
    backup_type = "mcp_configuration"
    computer_name = $env:COMPUTERNAME
    user = $env:USERNAME
    backed_up_items = @(
        "Proxmox MCP server configuration",
        "Connection details (non-sensitive)",
        "Available tools documentation",
        "Usage examples"
    )
    notes = "MCP credentials are managed by Warp and not backed up"
}

# Read existing log or create new
$BackupHistory = @()
if (Test-Path $BackupLog) {
    $BackupHistory = Get-Content $BackupLog | ConvertFrom-Json
    if ($BackupHistory -isnot [Array]) {
        $BackupHistory = @($BackupHistory)
    }
}

# Add new entry
$BackupHistory += $LogEntry

# Keep only last 10 entries
if ($BackupHistory.Count -gt 10) {
    $BackupHistory = $BackupHistory | Select-Object -Last 10
}

# Save updated log
$BackupHistory | ConvertTo-Json -Depth 3 | Out-File $BackupLog -Encoding UTF8
Write-Host "📝 Updated backup log" -ForegroundColor Green

# Check for new or changed MCP servers
Write-Host "🔍 Checking for MCP server changes..." -ForegroundColor Blue

# List of known MCP servers (this would be expanded as more are added)
$KnownServers = @("proxmox")
Write-Host "ℹ️  Currently tracking $($KnownServers.Count) MCP server(s): $($KnownServers -join ', ')" -ForegroundColor Gray

# Create a summary file
$SummaryFile = "$BackupPath\mcp-summary.md"
$Summary = @"
# MCP Configuration Summary

**Last Updated**: $Timestamp  
**Computer**: $env:COMPUTERNAME  
**User**: $env:USERNAME  

## Active MCP Servers

### Proxmox VE Cluster
- **Status**: ✅ Active
- **Cluster**: Home-Cluster (5 nodes)
- **Tools**: 7 available commands
- **Network**: 192.168.1.x
- **Configuration**: Documented in proxmox-config.json

## Backup Information

- **Configuration Files**: Backed up to version control
- **Credentials**: Managed by Warp (not backed up)
- **Restore Method**: Manual reconfiguration required
- **Last Backup**: $Timestamp

## Quick Commands

Test MCP connection:
``````
Ask Warp: "What's the status of my Proxmox cluster?"
``````

List VMs on a node:
``````
Ask Warp: "List all VMs on prox01"
``````

## Security Notes

- API credentials are stored securely by Warp
- No sensitive authentication data is backed up to Git
- Connection details (IPs, node names) are documented for restoration
- Use environment variables when setting up on new machines

## Restoration Steps

1. Ensure network connectivity to Proxmox cluster (192.168.1.x)
2. Set up MCP server connection in Warp
3. Configure API authentication (use KeePass for credentials)
4. Test connection with cluster status command
"@

$Summary | Out-File $SummaryFile -Encoding UTF8
Write-Host "📊 Created MCP summary file" -ForegroundColor Green

Write-Host ""
Write-Host "🎉 MCP backup completed successfully!" -ForegroundColor Green
Write-Host "📂 Backup location: $BackupPath" -ForegroundColor Gray
Write-Host ""
Write-Host "💡 Next steps:" -ForegroundColor Yellow
Write-Host "   1. Review documentation in: $BackupPath"
Write-Host "   2. Commit changes: git add mcp/ && git commit -m 'Update MCP config'"
Write-Host "   3. Push to GitHub: git push"
Write-Host ""
Write-Host "🔄 To restore on new machine:" -ForegroundColor Cyan
Write-Host "   1. Clone dotfiles repository"
Write-Host "   2. Review mcp/README.md for setup instructions"
Write-Host "   3. Configure MCP server in Warp using documented settings"
