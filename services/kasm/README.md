# kasm

## installation


curl -O https://kasm-static-content.s3.amazonaws.com/kasm_release_1.11.0.18142e.tar.gz
tar -xf kasm_release*.tar.gz
sudo bash kasm_release/install.sh -L 8443

## to make kasm work behind traefik
go to ADMIN -> ZONES -> edit the default zone
set "Upstream Auth Address" to kasm.example.com
set "Proxy Port" to 443