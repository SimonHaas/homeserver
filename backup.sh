#!/bin/bash

echo "Hello World"

#TODO wenn Ziel noch kein rdiff-backup dir, dann erstmal rsync bis alles einmal kopiert wurde

if grep -qs '/mnt/backup' /proc/mounts && grep -qs '/mnt/omv' /proc/mounts
then
    echo "lets backup omv"

    rdiff-backup --remove-older-than 4W /mnt/backup/rdiff-backup/omv
    rdiff-backup -v5 --print-statistics /mnt/omv /mnt/backup/rdiff-backup/omv
fi

if grep -qs '/mnt/backup' /proc/mounts && grep -qs '/mnt/external4TB' /proc/mounts
then
    echo "lets backup docker"

    rdiff-backup --remove-older-than 4W /mnt/backup/rdiff-backup/docker
    
    docker-compose stop
    rdiff-backup -v5 --print-statistics /mnt/external4TB/docker /mnt/backup/rdiff-backup/docker
    docker-compose up -d
fi