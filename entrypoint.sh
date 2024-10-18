#!/bin/sh

echo "0 * * * * cd /usr/src/app && ruby bin/scrape >> /var/log/cron.log 2>&1" > /etc/crontabs/root

rake create
rake migrate

echo "Starting scraper..."
./bin/scrape

echo "Starting cron..."
crond -l 2 -f
