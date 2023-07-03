# kasm

## installation

``` shell
curl -O https://kasm-static-content.s3.amazonaws.com/kasm_release_1.13.1.421524.tar.gz
tar -xf kasm_release*.tar.gz
sudo bash kasm_release/install.sh -L 8443

docker exec -it kasm_db psql -U kasmapp -d kasm
update users set
    pw_hash = 'fe519184b60a4ef9b93664a831502578499554338fd4500926996ca78fc7f522',
    salt = '83d0947a-bf55-4bec-893b-63aed487a05e',
    secret=NULL, set_two_factor=False, locked=False,
    disabled=False, failed_pw_attempts = 0 where username ='admin@kasm.local';
\q
```

Login:
admin@kasm.local
password

## to make kasm work behind traefik
1. go to ADMIN -> ZONES -> edit the default zone
2. set "Upstream Auth Address" to kasm.example.com
3. set "Proxy Port" to 443

## usage with ./script.sh

``` shell
./script.sh KASM start
./script.sh KASM stop
```
