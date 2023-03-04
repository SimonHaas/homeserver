# !/bin/bash

# sudo crontab -e
# 0 0 * * * (time /bin/bash /mnt/ssd2/homeserver/backup.sh) >> /mnt/ssd2/homeserver/backup-logs.txt 2>&1

if [ -f .env ]
then
  export $(cat .env | sed 's/#.*//g' | xargs)
fi

destination=${BACKUP_DESTINATION}
repository="homeserver"
source=$( pwd; )
encryption="none"
compression="lz4"
rootuser="yes"
pruning="--keep-within=1d --keep-daily=7 --keep-weekly=4 --keep-monthly=12"

repopath="$destination"/"$repository"

if grep -qs $destination /proc/mounts && grep -qs $source /proc/mounts
then

    if [ $(id -u) -ne 0 ] && [ "$rootuser" == "yes" ]; then
        echo "Backup has to be run as root user."
        exit 1
    fi

    if [ ! -d $repopath ]; then
        borg init --encryption=$encryption $repopath
        echo "Borg-repository created at $repopath"
    fi

    SECONDS=0
    $source/script.sh SAVE_BACKUP stop
    echo "Start of backup $(date)."

    borg create --compression $compression --exclude-caches --one-file-system -v --stats --progress \
                $repopfad::'{hostname}-{now:%Y-%m-%d-%H%M%S}' $source

    echo "End of backup $(date). Duration: $SECONDS seconds"
    $source/script.sh SAVE_BACKUP start

    borg prune -v --list $repopfad --prefix '{hostname}-' $pruning

else
    echo "!!! DIRECTORIES NOT MOUNTED !!!"
fi
