# 🔧 MCP (Model Context Protocol) Configuration

This directory contains backup and setup information for MCP servers configured in Warp.

## 📋 Current MCP Setup

### **Proxmox MCP Server**
- **Description**: Provides access to Proxmox Virtual Environment cluster management
- **Tools**: 7 available commands for VM, container, and cluster management
- **Cluster**: Home-Cluster (5 nodes)

#### **Available Commands:**
| Command | Description | Parameters |
|---------|-------------|------------|
| `proxmox-cluster-resources` | Get detailed cluster resources | None |
| `proxmox-cluster-status` | Get cluster status and resources | None |
| `proxmox-container-status` | Get container status | `node`, `vmid` |
| `proxmox-list-containers` | List all LXC containers | `node` |
| `proxmox-list-vms` | List all virtual machines | `node` |
| `proxmox-node-status` | Get node status | `node` |
| `proxmox-vm-status` | Get VM status | `node`, `vmid` |

#### **Cluster Nodes:**
- **prox00** (192.168.1.25) - Local node
- **prox01** (192.168.1.26)
- **prox02** (192.168.1.29)
- **prox03** (192.168.1.27)
- **prox04** (192.168.1.28)

## 🔄 Backup Strategy

Since MCP configurations are integrated into Warp's internal database, we maintain:

1. **Configuration Documentation** - This file documents current setup
2. **Setup Scripts** - Scripts to recreate MCP server connections
3. **Connection Details** - Non-sensitive connection information
4. **Usage Examples** - Common commands and workflows

## 🚀 Restore Instructions

### **Setting up Proxmox MCP Server:**

1. **Prerequisites:**
   - Proxmox VE cluster accessible
   - Valid API credentials for Proxmox
   - Network connectivity to cluster nodes

2. **Installation:**
   ```bash
   # Install MCP server for Proxmox (command may vary)
   # This would typically be done through Warp's MCP interface
   ```

3. **Configuration:**
   - Cluster endpoint: Your Proxmox cluster
   - Authentication: API token or credentials
   - Network: Ensure access to 192.168.1.x network

## 💡 Usage Examples

### **Check Cluster Status:**
```
Ask: "What's the status of my Proxmox cluster?"
```

### **List VMs on a Node:**
```
Ask: "List all VMs on prox01"
```

### **Check Specific VM:**
```
Ask: "What's the status of VM 100 on prox00?"
```

## 🔧 Configuration Files

**Note**: MCP configurations in Warp are stored in the internal database. 
For backup purposes, we document the setup here and provide restoration scripts.

### **Connection Details** (Non-sensitive):
- **Cluster Name**: Home-Cluster
- **Network Range**: 192.168.1.x
- **Node Count**: 5
- **API Version**: Proxmox VE API v2

### **Security Notes**:
- API credentials are stored securely by Warp
- No sensitive data is backed up to version control
- Use environment variables for credentials during setup

## 📚 Additional MCP Servers to Consider

### **Development**:
- **GitHub MCP** - Repository management
- **Docker MCP** - Container operations
- **Git MCP** - Advanced git operations

### **System Administration**:
- **SSH MCP** - Remote server management
- **Network MCP** - Network diagnostics
- **File System MCP** - Advanced file operations

### **Cloud & Infrastructure**:
- **AWS MCP** - Cloud resource management
- **Kubernetes MCP** - Container orchestration
- **Terraform MCP** - Infrastructure as code

## 🔄 Sync Instructions

1. **Backup**: Document any new MCP servers in this directory
2. **Version Control**: Commit changes to this configuration
3. **Restore**: Use documentation and scripts to recreate setup
4. **Update**: Keep this documentation current with actual setup
