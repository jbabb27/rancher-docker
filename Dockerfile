FROM docker.io/rancher/server:v1.6.10

# Set timezone to America/Chicago
RUN set -x; \
    echo 'America/Chicago' > /etc/timezone \
    && dpkg-reconfigure tzdata \

# Update package list
    && apt-get update \

# Upgrade all installed packages
    && apt-get -y upgrade \

# Install nginx
    && apt-get install -y --no-install-recommends \
    nginx \

# Remove package list data
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \    

# Delete default nginx config
    && rm /etc/nginx/sites-enabled/default

    
COPY nginx /etc/nginx/
COPY service /service/
COPY container-backup.sh container-restore.sh /usr/local/bin/

RUN set -x; \ 

# Execute on backup and startup scripts.
    chmod +x /usr/local/bin/* /service/nginx/* \

# Generate dhparam.pem file
# Note that you may want to just generate this ahead of time and mount
# it in instead of regenerating on each build
    && openssl dhparam -out /etc/nginx/certs/dhparam.pem 2048



EXPOSE 80 443

VOLUME ["/var/lib/mysql-backups"]
