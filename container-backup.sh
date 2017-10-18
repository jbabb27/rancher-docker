#!/bin/sh

BACKUPDIR='/var/lib/mysql-backups'
TIMESTAMP=`date '+%Y-%m-%d_%H.%M.%S'`

/usr/bin/mysqldump --all-databases -h localhost -u cattle -pcattle | /bin/gzip > $BACKUPDIR/$TIMESTAMP.gz

find $BACKUPDIR -type f -mtime +7 -exec rm '{}' ';'