#!/bin/bash

set -eux

# Pilih package manager mengikut versi Amazon Linux
if command -v dnf >/dev/null 2>&1; then
  PKG_MANAGER="dnf"
else
  PKG_MANAGER="yum"
fi

# Install Docker dan Nginx
$PKG_MANAGER install -y docker nginx

# Hidupkan servis secara automatik
systemctl enable --now docker
systemctl enable --now nginx

# Cipta halaman ujian
cat > /usr/share/nginx/html/index.html <<'EOF'
<!DOCTYPE html>
<html>
<head>
  <title>Terraform Server</title>
</head>
<body>
  <h1>Terraform Amali 5 Berjaya</h1>
  <p>Nginx dipasang menggunakan EC2 user_data.</p>
</body>
</html>
EOF