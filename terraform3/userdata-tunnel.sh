#!/bin/bash
set -euo pipefail

export DEBIAN_FRONTEND=noninteractive

apt-get update -y
apt-get install -y docker.io

systemctl enable --now docker

docker run -d \
  --name nginx \
  --restart unless-stopped \
  -p 80:80 \
  nginx:latest

docker run -d \
  --name cloudflared \
  --restart unless-stopped \
  --network host \
  cloudflare/cloudflared:latest \
  tunnel --no-autoupdate run --token "${tunnel_token}"