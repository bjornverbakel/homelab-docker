# Homelab Docker Config

This repository contains the declarative configuration for my home server infrastructure, orchestrated via **Docker Compose**.

### Host Information
- **Internal IP:** `192.168.2.20`
- **Architecture:** x86_64 (Mini PC)
- **OS:** Ubuntu Server 22.04 LTS
- **Storage Path:** `/mnt/storage`

### Quick Start
1. **Clone the repository:**
   ```bash
   git clone --recursive https://github.com/bjornverbakel/homelab-docker.git
   cd homelab-docker
   ```

2. **Create the environment file:**
   Copy the example and fill in your secrets.
   ```bash
   cp .env.example .env
   nano .env
   ```

3. **Launch the stack:**
   ```bash
   docker compose up -d
   ```

### Stacks

| Stack | Path | Description |
|-------|------|-------------|
| **Dashboard** | | |
| `homepage` | `homepage/` | GetHomepage dashboard (Config via submodule). |
| **Media** | | |
| `servarr` | `servarr/` | Jellyseerr, Radarr, Sonarr, Prowlarr, & Flaresolverr. |
| `qbittorrent` | `qbittorrent/` | Torrent client routed through Gluetun (ProtonVPN). |
| `jellyfin` | `jellyfin/` | Media streaming server. |
| **Storage** | | |
| `seafile` | `seafile/` | Personal Cloud (Seafile, MariaDB, Memcached). |
| **Home & Network** | | |
| `tailscale` | `tailscale/` | Remote access VPN. |
| `home-assistant` | `home-assistant/` | Home Automation. |
| `pihole` | `pihole/` | Network-wide Ad Blocking & DNS. |
| **Utilities** | | |
| `socket-proxy` | `socket-proxy/` | Secure Docker socket gateway. |
| `portainer` | `portainer/` | GUI for Docker management. |
| `whatsupdocker` | `whatsupdocker/` | Container update notifications & auto-updates. |

### Repository Structure

```text
.
├── compose.yaml          # Master Compose file (includes all child stacks)
├── .env                  # Environment Variables & Secrets
├── CHEATSHEET.md         # Ops manual, troubleshooting, and commands
├── README.md             # This file
│
├── homepage/
│   ├── compose.yaml      # Service definition
│   └── homepage-config/  # GIT SUBMODULE (Private Configuration)
│
├── [stack]/              # Standard structure for all other services
│   └── compose.yaml      # e.g., seafile, servarr, pihole, etc.
```

### Host Storage Structure
The `STORAGE_PATH` (set in `.env`) maps to `/mnt/storage` on the host. This keeps persistent data separate from the OS and configuration.

```text
/mnt/storage/
├── appdata/              # Persistent volumes for containers
│   ├── seafile/
│   ├── home-assistant/
│   ├── jellyfin/
│   ├── sonarr/
│   └── ...
│
├── media/                # Jellyfin media library
│   ├── movies/
│   ├── shows/
│   ├── torrents/         # Active download cache
│   └── downloads/
│
├── configs/              # General usage configs
```
