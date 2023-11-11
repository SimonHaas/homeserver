# openvpn

https://hub.docker.com/r/kylemanna/openvpn/

## setup

https://github.com/kylemanna/docker-openvpn/blob/master/docs/docker-compose.md

docker compose run --rm openvpn ovpn_genconfig -u udp://vpn.example.com
docker compose run --rm openvpn ovpn_initpki
docker compose up -d

export CLIENTNAME="your_client_name"
# with a passphrase (recommended)
docker compose run --rm openvpn easyrsa build-client-full $CLIENTNAME
# without a passphrase (not recommended)
docker compose run --rm openvpn easyrsa build-client-full $CLIENTNAME nopass

docker compose run --rm openvpn ovpn_getclient $CLIENTNAME > $CLIENTNAME.ovpn
