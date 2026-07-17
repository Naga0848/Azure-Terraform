#!/bin/bash
set -e

export DEBIAN_FRONTEND=noninteractive

# Install nginx and tools
apt-get update -y
apt-get install -y nginx curl jq

# Web root
WWW="/usr/share/nginx/html"
mkdir -p "$WWW"
chown -R www-data:www-data "$WWW"
chmod 755 "$WWW"

# Fetch the raw Markdown (roboshop frontend doc) and escape it for safe display
RAW_URL="https://raw.githubusercontent.com/daws-84s/roboshop-documentation/main/03-frontend.MD"
CONTENT="$(curl -sS "$RAW_URL" | sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g')"

# Create an index page that shows the README content inside a <pre> block
cat > "$WWW/index.html" <<HTML
<!doctype html>
<html>
<head>
  <meta charset="utf-8"/>
  <title>Roboshop Frontend README</title>
  <style>body{font-family:Arial,Helvetica,sans-serif;padding:20px} pre{white-space:pre-wrap;word-wrap:break-word;background:#f6f8fa;padding:16px;border-radius:6px;}</style>
</head>
<body>
  <h1>Roboshop Frontend — README (rendered)</h1>
  <p>Source: <a href="$RAW_URL" target="_blank">03-frontend.MD (GitHub)</a></p>
  <pre>$CONTENT</pre>
</body>
</html>
HTML

# Ensure nginx is enabled and running
systemctl enable nginx
systemctl restart nginx