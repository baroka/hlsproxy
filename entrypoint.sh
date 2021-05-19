#!/bin/sh
echo '------ INITIALIZE CRON -------'
# Add crontab file to the cron directory
cp /work/cron/crontab /etc/cron.d/cron

# Give execution rights on the cron job
chmod 0644 /etc/cron.d/cron

# Apply cron job
crontab /etc/cron.d/cron

cron

echo '------ ALLOW HLS PROXY ON EVERY INTERFACE -------'
/work/hls-proxy -address 0.0.0.0 -port 8085 -save -quit

echo '------ HLS PROXY -------'
/work/hls-proxy
