#!/bin/bash
LOG_FILE=/var/log/hls-proxy.log
ERROR="ERROR Request failed, no retry left: Exception: connect ENETUNREACH"

if cat $LOG_FILE | grep -q "$ERROR"; then
    echo "Unhealthy container. exit 1"   
    > $LOG_FILE
    exit 1
else
	exit 0
fi