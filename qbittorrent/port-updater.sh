#!/bin/sh

# Configuration
QBIT_ADDR="http://localhost:8080"
GLUETUN_ADDR="http://localhost:8000"

echo "Starting QBitTorrent Port Updater..."
echo "Waiting for 10 seconds to ensure services are ready..."
sleep 10

current_port=0

while true; do
    # 1. Get the forwarded port from Gluetun API
    # Note: Gluetun returns it as an integer in JSON
    RESPONSE=$(curl --connect-timeout 5 -s "$GLUETUN_ADDR/v1/portforward")
    echo "Gluetun response: $RESPONSE"
    
    if [ -z "$RESPONSE" ]; then
        echo "Empty response from Gluetun. Retrying in 10s..."
        sleep 10
        continue
    fi
    
    NEW_PORT=$(echo "$RESPONSE" | jq -r '.port')

    if [ -z "$NEW_PORT" ] || [ "$NEW_PORT" = "null" ] || [ "$NEW_PORT" = "0" ]; then
        echo "Port not yet available from Gluetun. Retrying in 10s..."
        sleep 10
        continue
    fi

    if [ "$NEW_PORT" != "$current_port" ]; then
        echo "New port detected: $NEW_PORT (Old: $current_port). Updating qBittorrent..."

        # 2. Login to qBittorrent
        rm -f /tmp/cookies.txt
        if [ -n "$QBITTORRENT_USERNAME" ] && [ -n "$QBITTORRENT_PASSWORD" ]; then
             curl -s -i -c /tmp/cookies.txt -d "username=$QBITTORRENT_USERNAME&password=$QBITTORRENT_PASSWORD" "$QBIT_ADDR/api/v2/auth/login" > /dev/null
        fi

        # 3. Update Port
        curl -s -b /tmp/cookies.txt -X POST -d "json={\"listen_port\": $NEW_PORT}" "$QBIT_ADDR/api/v2/app/setPreferences"
        
        echo "qBittorrent port updated to $NEW_PORT"
        current_port=$NEW_PORT
    fi

    # Check every minute
    sleep 60
done
