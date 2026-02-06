# Homelab Cheatsheet

## Docker Management
*Run these commands from `/home/USER/docker`*

### List Running Containers
```bash
docker ps
```

### Start / Update Everything
```bash
# Pull latest images and restart only changed containers
docker compose up -d
```

### Manage Specific Stacks/Services
Since there is a master `compose.yaml` with includes, you can address services by name directly.
```bash
# Restart a specific container
docker compose restart homepage
docker compose restart qbittorrent

# View logs for a specific container (follow with -f)
docker compose logs -f homepage
docker compose logs -f qbittorrent
docker compose logs -f gluetun
```

### Maintenance
```bash
# Update all images
docker compose pull

# Remove unused images/volumes (cleanup)
docker system prune -a
```

---

## Git & Submodules
*There is a split setup: `homelab-docker` and `homepage-config`.*

### First-Time Setup
```bash
# Clone everything including the homepage configuration submodule
git clone --recursive https://github.com/bjornverbakel/homelab-docker.git
```

---

## Troubleshooting & Specifics

### qBittorrent & VPN (ProtonVPN)
**Leak Test**
Verify that qBittorrent is using the VPN IP, not the Host IP.
```bash
# Check Host IP
curl -s https://am.i.mullvad.net/ip

# Check Container IP (Should be different)
docker exec qbittorrent curl -s https://am.i.mullvad.net/ip
```