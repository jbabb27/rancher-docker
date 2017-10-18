#!/bin/sh

BACKUPDIR='/var/lib/mysql-backups'

TIMESTAMP=$1

if [ ! -f $BACKUPDIR/$TIMESTAMP.gz ]; then
    echo "Can't find backup of timestamp '$TIMESTAMP', here are the available backup timestamps:"
    find /var/lib/mysql-backup/ -type f -printf '%P\n' | sed -e 's/\.gz$//g' | sort
    exit 1;
fi

/bin/zcat $BACKUPDIR/$TIMESTAMP.gz | mysql -u cattle -pcattle

/usr/bin/mysqlimport -h localhost -u cattle -pcattle | /bin/zcat $BACKUPDIR/$TIMESTAMP.gz