# Nextcloud

https://nextcloud.com/

## cron jobs - using host

crontab -e
*/5 * * * * cd /mnt/data/homeserver/services/nextcloud/ && docker compose exec -it -u www-data nextcloud php /var/www/html/cron.php