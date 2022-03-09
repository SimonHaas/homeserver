# Homeserver
A robust and extensible homeserver setup without any magic.

It is designed to be hosted and used only on your local network. Even though being only used on your local network it uses ```https``` via a wildcard certificate for everything to avoid browser security warnings and because some services do not work properly without TLS. You can still access from all around the world via a VPN.

## Structure
Each service is fully contained in a directory. Usually there are at least a ```docker-compose.yml``` and an ```.env.example``` file. All data is persistet in the service's ```data/``` direcrtory.
Traefik is the reverse proxy for all the services. To start a service simply ```cp .env.example .env``` edit it to your likes, add the service name to the ```SERVICES``` variable in the root ```.env``` file and run ```./script.sh up -d```.

## Initial Setup

### Prerequisites
- server running docker and docker-compose
- domain (get a free one at https://www.freenom.com/)
- DNS A-record wildcard pointing to your servers IP (e.g. 192.168.1.2)

Not all DNS providers support wildcard A-records, https://www.digitalocean.com/ does. Sign up and point your domain's NS-records to digitalocean's nameservers. It is free.

### Setup Traefik
```
cp .env.example .env
cd services/traefik2
cp .env.example .env
```
Change the ```DOMAIN``` in ```.env``` and edit ```SERVER_DOMAIN```, ```ACME_EMAIL``` and ```DO_AUTH_TOKEN``` in ```services/traefik2/.env```. You can get a ```DO_AUTH_TOKEN``` here https://cloud.digitalocean.com/account/api/tokens

To test if you can get a certificate from letsencrypt uncomment the line about the staging server in ```services/traefik2/docker-compose.yml```.

Run 
```
docker network create traefik_private
./script.sh up -d
``` 
wait till all images are pulled, build and a certificate retrieved. Then you can access nextcloud and gogs via your browser. If your browser warns you about an unknown certificate authority accept the risk because you know it is a staging certificate or maybe a self signed certificate from traefik. In the latter case you still need to wait a minute till your letsencrypt certificate is issued or you have an error somewhere. Check ```docker-compose logs -f traefik``` to view the logs. If everything worked alright, just comment out the one line in traefik's docker-compose.yml and run the script again to get a valid certificate.

## docker-compose.yml template

```
version: "3.6"
services:
  app123:
    container_name: app123
    restart: always
    networks: 
        - traefik
    security_opt:
        - no-new-privileges:true
    labels:
        - custom.network=private
        - "traefik.enable=true"
        - "traefik.http.services.app123.loadbalancer.server.port=80"
        - "traefik.http.routers.app123.rule=Host(`${SUB_DOMAIN}.${SERVER_DOMAIN}`)"
        - "traefik.http.routers.app123.entrypoints=websecure"
        - "traefik.http.routers.app123.tls.certresolver=myresolver"

networks:
    traefik:
        name: traefik_private
```
