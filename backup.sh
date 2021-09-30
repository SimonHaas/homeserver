#!/bin/bash

# sudo crontab -e
# 0 0 * * *  /mnt/external4TB/docker/backup.sh >> /mnt/external4TB/docker/backup-logs.txt 2>&1

# Beim erstmaligen Backup von einem großen Ordner erstmal alles mit rsync kopieren und dann erst rdiff-backup drauf anwenden.
# rdiff-backup kann ein abgebrochenes Backup nicht weitermachen und löscht erst mal wieder alles.

echo "########### START ###########"
echo `date`

#TODO wenn Ziel noch kein rdiff-backup dir, dann erstmal rsync bis alles einmal kopiert wurde

if grep -qs '/mnt/backup' /proc/mounts && grep -qs '/mnt/external4TB' /proc/mounts
then
    echo "########### lets backup docker"

    #rdiff-backup -l /mnt/backup/rdiff-backup/docker
    rdiff-backup --remove-older-than 4W /mnt/backup/rdiff-backup/docker
    
    ./script.sh stop
    rdiff-backup -v5 --print-statistics /mnt/external4TB/docker /mnt/backup/rdiff-backup/docker
    ./script.sh start
fi

echo "########### END ###########"
