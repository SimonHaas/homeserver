#!/bin/bash

docker-compose -f ./docker-compose.yml up -d

arr+=("airsonic")
arr+=("bookstack")
arr+=("calibre-web")
arr+=("clarkson")
arr+=("cyberchef")
#arr+=("dolibarr")
#arr+=("drone")
arr+=("etiketten")
#arr+=("fireflyiii")
#arr+=("ftp")
#arr+=("gitlab")
arr+=("gogs")
arr+=("grocy")
#arr+=("guacamole")
#arr+=("hoppscotch")
#arr+=("hrconvert2")
arr+=("jellyfin")
arr+=("librespeed")
#arr+=("minecraft")
#arr+=("minetest")
arr+=("monica")
arr+=("nextcloud")
#arr+=("odoo")
#arr+=("openproject")
#arr+=("paperless")
#arr+=("portainer")
arr+=("rainloop")
arr+=("registry")
#arr+=("searx")
arr+=("syncthing")
#arr+=("traggo")
#arr+=("wertpapierkredit")
arr+=("wger")
arr+=("wireguard")
#arr+=("xbrowsersync")
arr+=("youtube-dl")

for item in ${arr[*]}
do
    docker-compose -f ./$item/docker-compose.yml up -d
done
