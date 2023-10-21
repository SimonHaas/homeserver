# superset

https://superset.apache.org/
https://github.com/apache/superset
https://hub.docker.com/r/apache/superset

## setup

``` bash
docker compose exec superset superset db upgrade
docker compose exec superset superset fab create-admin --username root --firstname Firstname --lastname Lastname --password root --email superset@example.com
docker compose exec superset superset init
```
