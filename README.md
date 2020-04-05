# Notes

This is all located on an encrypted external hard drive.

## Let's Encrypt

To renew the wildcard-certificate simply run:

``` shell
sudo certbot certonly --manual --manual-public-ip-logging-ok --preferred-challenges dns-01 --server https://acme-v02.api.letsencrypt.org/directory -d "*.simon-haas.eu"
```

## OpenVPN

The VPN Server is on the not encrypted SD Card. So that it starts after a power outage. Then I can even connect remotely to unlock the hard drive and start the other services corretly.

It will be located a /home/pi/docker

## firefly

The storage folder has to be owned by www-data.

``` shell
sudo chown -R www-data:www-data ./firefly_iii
```
