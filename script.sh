#!/bin/bash

#arr+=("airsonic")
#arr+=("bookstack")
#arr+=("calibre-web")
#arr+=("clarkson")
#arr+=("cyberchef")
#arr+=("dolibarr")
#arr+=("drone")
arr+=("etiketten")
#arr+=("filebrowser")
#arr+=("fireflyiii")
arr+=("fittrackee")
#arr+=("gauth")
#arr+=("gitlab")
arr+=("gogs")
#arr+=("grocy")
arr+=("guacamole")
arr+=("heimdall")
#arr+=("hoppscotch")
#arr+=("hrconvert2")
arr+=("jackett")
#arr+=("jellyfin")
#arr+=("joplin")
#arr+=("keeweb")
arr+=("librespeed")
#arr+=("minecraft")
#arr+=("minetest")
#arr+=("monica")
#arr+=("motioneye")
arr+=("nextcloud")
#arr+=("notea")
#arr+=("odoo")
#arr+=("openproject")
#arr+=("paperless")
arr+=("photoprism")
#arr+=("pihole")
#arr+=("portainer")
arr+=("radarr")
arr+=("rainloop")
arr+=("registry")
arr+=("samba")
#arr+=("searx")
#arr+=("syncserver") does not work
arr+=("syncthing")
arr+=("traefik")
#arr+=("traggo")
arr+=("transmission")
#arr+=("trilium")
#arr+=("uptimekuma")
#arr+=("webtop")
#arr+=("wertpapierkredit")
#arr+=("wger")
arr+=("wol")
#arr+=("xbrowsersync")
arr+=("youtube-dl")

for item in ${arr[*]}
do
    docker-compose -f ./$item/docker-compose.yml $1 $2 $3
done
