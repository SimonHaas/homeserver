# tailscale
https://tailscale.com/
https://docs.ibracorp.io/tailscale/tailscale/docker-compose

## setup

echo 'net.ipv4.ip_forward = 1' | sudo tee -a /etc/sysctl.conf
echo 'net.ipv6.conf.all.forwarding = 1' | sudo tee -a /etc/sysctl.conf
sudo sysctl -p /etc/sysctl.conf
docker compose up -d
docker exec tailscale tailscale login
docker exec tailscale tailscale up --advertise-routes=192.168.31.0/24