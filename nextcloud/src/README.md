``` shell
cd fpm
docker build .
docker tag 3a02d840e0f7 registry.simon-haas.eu/nextcloud:21.0.0-fpm-alpine
docker image push registry.simon-haas.eu/nextcloud:21.0.0-fpm-alpine
```