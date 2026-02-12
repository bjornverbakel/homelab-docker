# Homelab Cheatsheet

## Docker Management
*Run these commands from `/home/bjorn/docker`*

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

### Updating Infrastructure (Docker/Env)
1. Go to the main folder:
   ```bash
   cd ~/docker
   ```
3. **Important:** If you updated the Homepage submodule, update the reference here too:
   ```bash
   git add homepage/homepage-config
   ```
4. Push to `homelab-docker` repo:
   ```bash
   git add .
   git commit -m "Updated infrastructure"
   git push
   ```

### Updating Homepage Config (Dashboard)
1. Go to the submodule folder:
   ```bash
   cd ~/docker/management/homepage
   ```
2. Push to `homepage-config` repo:
   ```bash
   git add .
   git commit -m "Added new widgets"
   git push
   ```