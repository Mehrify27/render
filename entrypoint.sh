#!/bin/bash

# مقادیر پیش‌فرض در صورت عدم تنظیم متغیرهای محیطی
export PORT=${PORT:-10000}
export UUID=${UUID:-"c2d385ef-1337-4d7a-a38f-98c563e41421"}
export WS_PATH=${WS_PATH:-"/api/v1/telemetry"}

mkdir -p /etc/xray

# جایگذاری متغیرهای محیطی در کانفیگ‌ها
envsubst '${PORT} ${WS_PATH}' < /app/nginx.conf.template > /etc/nginx/nginx.conf
envsubst '${UUID} ${WS_PATH}' < /app/config.json.template > /etc/xray/config.json

# اجرای سرویس‌ها با supervisord
exec /usr/bin/supervisord -c /etc/supervisord.conf
