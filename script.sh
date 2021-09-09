#!/bin/bash

arr+=("airsonic")
arr+=("bookstack")
arr+=("calibre-web")
#arr+=("clarkson")
#arr+=("cyberchef")
#arr+=("dolibarr")
#arr+=("drone")
arr+=("dyndns")
arr+=("etiketten")
#arr+=("filebrowser")
#arr+=("fireflyiii")
arr+=("gitlab")
arr+=("gogs")
#arr+=("grocy")
#arr+=("guacamole")
#arr+=("hoppscotch")
#arr+=("hrconvert2")
#arr+=("jellyfin")
#arr+=("joplin")
arr+=("librespeed")
#arr+=("minecraft")
#arr+=("minetest")
#arr+=("monica")
arr+=("nextcloud")
#arr+=("notea")
#arr+=("odoo")
#arr+=("openproject")
#arr+=("paperless")
#arr+=("portainer")
arr+=("rainloop")
arr+=("registry")
#arr+=("searx")
arr+=("syncthing")
arr+=("traefik")
#arr+=("traggo")
arr+=("transmission")
#arr+=("trilium")
#arr+=("webtop")
#arr+=("wertpapierkredit")
#arr+=("wger")
arr+=("wireguard")
#arr+=("xbrowsersync")
arr+=("youtube-dl")

for item in ${arr[*]}
do
    docker-compose -f ./$item/docker-compose.yml $1 $2 $3
done
