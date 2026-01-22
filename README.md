# Homelab Docker Config

This repository contains the declarative configuration for my home server infrastructure, orchestrated via **Docker Compose**.

### Stacks

| Stack | Path | Description |
|-------|------|-------------|
| **Dashboard** | | |
| `homepage` | `homepage/` | GetHomepage dashboard (Config via submodule). |
| **Media** | | |
| `servarr` | `servarr/` | Radarr, Prowlarr, & Flaresolverr. |
| `qbittorrent` | `qbittorrent/` | Torrent client routed through Gluetun (Mullvad). |
| `jellyfin` | `jellyfin/` | Media streaming server. |
| **Storage** | | |
| `seafile` | `seafile/` | Personal Cloud (Seafile, MariaDB, Memcached). |
| **Home & Network** | | |
| `home-assistant` | `home-assistant/` | Home Automation. |
| `pihole` | `pihole/` | Network-wide Ad Blocking & DNS. |
| **Utilities** | | |
| `socket-proxy` | `socket-proxy/` | Secure Docker socket gateway. |
| `portainer` | `portainer/` | GUI for Docker management. |
| `whatsupdocker` | `whatsupdocker/` | Container update notifications & auto-updates. |
