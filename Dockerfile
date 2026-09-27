FROM alpine:latest

# نصب پیش‌نیازها
RUN apk add --no-cache nginx gettext curl unzip bash supervisor

# دانلود و نصب آخرین نسخه هسته Xray
RUN set -ex && \
    curl -L -o /tmp/xray.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip && \
    unzip /tmp/xray.zip -d /usr/local/bin/ xray && \
    chmod +x /usr/local/bin/xray && \
    rm -rf /tmp/xray.zip

WORKDIR /app

# کپی کردن فایل‌های پیکربندی
COPY nginx.conf.template /app/nginx.conf.template
COPY config.json.template /app/config.json.template
COPY index.html /var/www/html/index.html
COPY entrypoint.sh /app/entrypoint.sh
COPY supervisord.conf /etc/supervisord.conf

RUN chmod +x /app/entrypoint.sh

EXPOSE 10000

ENTRYPOINT ["/app/entrypoint.sh"]
