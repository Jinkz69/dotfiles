# 🏠 Dotfiles - Cross-Platform Configuration Management

Modern, cross-platform configuration management for Windows and Linux environments.

## 🚀 Quick Start

### Windows (PowerShell)
```powershell
git clone https://github.com/Jinkz69/dotfiles.git
cd dotfiles
.\install.ps1
```

### Linux (Bash)
```bash
git clone https://github.com/Jinkz69/dotfiles.git
cd dotfiles
./install.sh
```

## 📁 Structure

```
dotfiles/
├── warp/                   # Warp terminal configurations
│   ├── settings/          # Warp settings and preferences
│   └── workflows/         # Custom workflows and commands
├── git/                   # Git configurations
│   ├── .gitconfig        # Global git configuration
│   └── .gitignore_global # Global gitignore patterns
├── powershell/           # PowerShell configurations
│   ├── profile.ps1       # PowerShell profile
│   └── modules/          # Custom PowerShell modules
├── bash/                 # Bash configurations
│   ├── .bashrc          # Bash configuration
│   ├── .bash_aliases    # Custom aliases
│   └── .bash_functions  # Custom functions
├── projects/            # Project templates and structure
│   ├── templates/       # Project scaffolding templates
│   └── standards/       # Coding and project standards
├── scripts/             # Utility scripts
│   ├── backup-warp.ps1  # Warp configuration backup
│   ├── sync-configs.sh  # Cross-platform config sync
│   └── setup-env.ps1    # Environment setup
├── install.ps1          # Windows installation script
├── install.sh           # Linux installation script
└── README.md            # This file
```

## 🔧 Features

- **Cross-Platform**: Works on Windows and Linux
- **Automated Backup**: Regular configuration backups
- **Version Control**: All configs tracked in Git
- **Modular**: Easy to add/remove components
- **Templated Projects**: Standardized project structures

## 🌟 Configurations Included

### Terminal & Shell
- Warp terminal settings and themes
- PowerShell profile and modules
- Bash configuration and aliases

### Development Tools
- Git global configuration
- GitHub CLI settings
- VS Code settings (if used)

### Project Management
- Standard project templates
- Documentation templates
- Coding standards and linting configs

## 🔄 Syncing Across Machines

The dotfiles automatically handle syncing configurations across different machines:

1. **Initial Setup**: Run install script on new machine
2. **Regular Sync**: Use `sync-configs` script to pull latest changes
3. **Backup**: Use backup scripts to save current configurations

## 🛡️ Security

- Sensitive data stored in environment variables
- SSH keys and tokens managed separately
- KeePass integration for credential management

## 📚 Usage

### Backup Current Warp Settings
```powershell
.\scripts\backup-warp.ps1
```

### Sync All Configurations
```bash
./scripts/sync-configs.sh
```

### Create New Project from Template
```powershell
.\scripts\new-project.ps1 -Template "node-typescript" -Name "my-project"
```
