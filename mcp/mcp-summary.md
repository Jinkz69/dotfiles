# MCP Configuration Summary

**Last Updated**: 2025-09-07 06:30:00  
**Computer**: DESKTOP-K7O9M3P  
**User**: reros  

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
- **Last Backup**: 2025-09-07 06:30:00

## Quick Commands

Test MCP connection:
```
Ask Warp: "What's the status of my Proxmox cluster?"
```

List VMs on a node:
```
Ask Warp: "List all VMs on prox01"
```

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
