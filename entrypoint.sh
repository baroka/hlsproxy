#!/bin/sh
echo "------ INITIALIZE CRON -------"
# Add crontab file to the cron directory
cp /work/cron/crontab /etc/cron.d/cron

# Give execution rights on the cron job
chmod 0644 /etc/cron.d/cron

# Apply cron job
crontab /etc/cron.d/cron
crond

echo "------ ALLOW HLS PROXY ON EVERY INTERFACE -------"
/work/hls-proxy -address 0.0.0.0 -port 8085 -save -quit

# Logs
LOG_FILE=/var/log/hls-proxy.log
CONFIG_FILE=/work/local.json
TEMP_FILE=/work/temp.json
echo "------ Log file is $LOG_FILE -------"
echo "       Do not modify it"
> $LOG_FILE
jq '.LOG.file.isEnabled=true' $CONFIG_FILE > $TEMP_FILE
cat $TEMP_FILE > $CONFIG_FILE
jq '.LOG.file.filename="/var/log/hls-proxy.log"' $CONFIG_FILE > $TEMP_FILE
cat $TEMP_FILE > $CONFIG_FILE
jq '.LOG.file.backups=1' $CONFIG_FILE > $TEMP_FILE
cat $TEMP_FILE > $CONFIG_FILE
rm $TEMP_FILE

echo '------ HLS PROXY -------'
/work/hls-proxy