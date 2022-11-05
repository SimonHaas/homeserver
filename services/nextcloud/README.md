# Nextcloud

https://nextcloud.com/

## cron jobs - using host

crontab -e
*/5 * * * * docker exec -t -u www-data nextcloud php -f /var/www/html/cron.php