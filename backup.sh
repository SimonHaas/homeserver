# !/bin/bash

if [ -f .env ]
then
  export $(cat .env | sed 's/#.*//g' | xargs)
fi

destination=${BACKUP_DESTINATION}
destinationMount=${BACKUP_DESTINATION_MOUNT}
repository="homeserver"
source=$( pwd; )
sourceMount=${BACKUP_SOURCE_MOUNT}
encryption="none"
compression="lz4"
rootuser="yes"
pruning="--keep-within=1d --keep-daily=7 --keep-weekly=4 --keep-monthly=12"

repopath="$destination"/"$repository"

if grep -qs $destinationMount /proc/mounts && grep -qs $sourceMount /proc/mounts
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

    borg create --compression $compression --exclude-caches --one-file-system -v --stats --progress $repopath::'{hostname}-{now:%Y-%m-%d-%H%M%S}' $source

    echo "End of backup $(date). Duration: $SECONDS seconds"
    $source/script.sh SAVE_BACKUP start

    borg prune -v --list $repopath --glob-archives '{hostname}-*' $pruning

else
    echo "!!! DIRECTORIES NOT MOUNTED !!!"
fi
