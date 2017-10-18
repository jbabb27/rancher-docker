# Rancher Server

Takes the docker.io/rancher/server:v1.6.10 image from Docker Hub and makes the following changes:

- Sets timezone to America/Chicago
- Upgrades all currently installed packages
- Installs nginx and adds it to /service so s6-supervise will start it

# Volume Mounts
- /etc/nginx/certs/server.key (currently baked in--not best practice)
- /var/lib/cattle
- /var/lib/mysql
- /var/lib/mysql-backups
- /var/log/mysql (optional)
 
# Mysql backups

container-backup.sh is executed externally by cron on the host in our environments to allow for a nice clean dumped version of the underlying mysql database
