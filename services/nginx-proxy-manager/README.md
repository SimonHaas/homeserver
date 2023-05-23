# nginx proxy manager

https://nginxproxymanager.com/
https://github.com/NginxProxyManager/nginx-proxy-manager

Nginx Proxy Manager is a popular reverse proxy. 
It is often compared to and regardes as an alternative to traefik.
Here they both work hand in hand.
Traefik forwards all requests it does not know what to do with to nginx proxy manager.
By creating 'Proxy Hosts' via the UI of nginx proxy manager you can easily integrate webservices into this homeserver setup which can not be proxied via traefik.
This can be docker services requiring host-networking or services running on totally different servers.