# 📁 Cross-Platform Project Structure Standards

## 🎯 Universal Project Layout

```
project-name/
├── .github/                # GitHub specific files
│   ├── workflows/         # GitHub Actions
│   ├── ISSUE_TEMPLATE/    # Issue templates
│   └── pull_request_template.md
├── .vscode/               # VS Code settings (optional)
│   ├── settings.json     # Project-specific settings
│   ├── launch.json       # Debug configurations
│   └── extensions.json   # Recommended extensions
├── docs/                  # Documentation
│   ├── README.md         # Main documentation
│   ├── API.md            # API documentation
│   ├── CONTRIBUTING.md   # Contribution guidelines
│   └── CHANGELOG.md      # Version history
├── src/                   # Source code
│   ├── main/             # Main application code
│   ├── test/             # Test files
│   └── resources/        # Resources/assets
├── scripts/               # Utility scripts
│   ├── build.ps1         # Windows build script
│   ├── build.sh          # Linux build script
│   ├── dev-setup.ps1     # Development environment setup
│   └── deploy.sh         # Deployment script
├── config/                # Configuration files
│   ├── development/      # Dev environment configs
│   ├── production/       # Prod environment configs
│   └── local.example     # Example local config
├── .gitignore            # Git ignore patterns
├── .gitattributes        # Git attributes
├── .editorconfig         # Editor configuration
├── README.md             # Project overview
├── LICENSE               # License file
├── package.json          # Node.js projects
├── requirements.txt      # Python projects
├── Dockerfile            # Container configuration
└── docker-compose.yml    # Multi-container setup
```

## 🔧 Technology-Specific Structures

### Node.js/TypeScript Projects
```
nodejs-project/
├── src/
│   ├── components/
│   ├── utils/
│   ├── types/
│   └── index.ts
├── tests/
├── dist/                 # Build output
├── package.json
├── tsconfig.json
├── .eslintrc.js
├── .prettierrc
└── jest.config.js
```

### PowerShell Module Projects
```
powershell-module/
├── src/
│   ├── Public/          # Public functions
│   ├── Private/         # Private functions
│   ├── Classes/         # PowerShell classes
│   └── ModuleName.psd1  # Module manifest
├── tests/
│   └── Pester/          # Pester tests
├── docs/
├── build/
│   ├── build.ps1
│   └── deploy.ps1
└── .github/
    └── workflows/
        └── ci.yml
```

### Infrastructure Projects (Ansible/Terraform)
```
infrastructure-project/
├── ansible/
│   ├── playbooks/
│   ├── roles/
│   ├── inventory/
│   └── group_vars/
├── terraform/
│   ├── environments/
│   ├── modules/
│   └── providers.tf
├── docs/
│   ├── architecture.md
│   └── deployment.md
├── scripts/
│   ├── deploy.sh
│   └── validate.ps1
└── .env.example
```

## 📋 File Templates

### Standard README.md Structure
```markdown
# Project Name

Brief description of what this project does.

## 🚀 Getting Started

### Prerequisites
- List of requirements

### Installation
```bash
# Installation commands
```

### Usage
```bash
# Usage examples
```

## 🔧 Development

### Setup
```bash
# Development setup
```

### Testing
```bash
# How to run tests
```

## 📚 Documentation
- [API Documentation](docs/API.md)
- [Contributing Guidelines](docs/CONTRIBUTING.md)

## 📄 License
This project is licensed under the MIT License - see [LICENSE](LICENSE) file.
```

## 🔒 Security Standards

### .gitignore Essentials
```gitignore
# Environment files
.env
.env.local
.env.*.local

# Credentials
*.key
*.pem
secrets.json
config/local.*

# OS generated files
.DS_Store
Thumbs.db
desktop.ini

# IDE files
.vscode/settings.json
.idea/
*.swp
*.swo

# Build outputs
dist/
build/
*.log
node_modules/
```

### Environment Configuration
- Use `.env.example` files with placeholder values
- Never commit actual credentials
- Use consistent naming: `DATABASE_URL`, `API_KEY`, etc.
- Document all required environment variables

## 📊 Cross-Platform Considerations

### Script Naming
- Windows: `script-name.ps1`
- Linux: `script-name.sh`
- Cross-platform: `script-name.py` or Node.js

### Path Handling
- Use relative paths where possible
- Environment variables for system paths
- Forward slashes in documentation (works on both)

### Line Endings
Configure `.gitattributes`:
```
* text=auto
*.ps1 text eol=crlf
*.sh text eol=lf
*.md text eol=lf
```

This ensures consistent behavior across Windows and Linux systems.
