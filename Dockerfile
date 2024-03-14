# build:
#  docker build -t baroka/hlsproxy .

FROM alpine:latest

EXPOSE 8085

WORKDIR /work

# Copy entrypoint script
COPY entrypoint.sh .
RUN chmod a+x entrypoint.sh

# Install packages
RUN apk update && apk add --no-cache unzip curl iproute2 jq ffmpeg && \
    rm -rf /tmp/*

# Timezone
RUN apk update && apk add tzdata
ARG TZ "Europe/Madrid"
ENV TZ=$TZ
RUN cp /usr/share/zoneinfo/Europe/Madrid /etc/localtime

# Add crontab file to the cron directory
ADD crontab /etc/cron.d/cron

# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/cron

# Install HLS Proxy
ARG version=8.4.8

RUN curl -O https://www.hls-proxy.com/downloads/$version/hls-proxy-$version.linux-x64.zip && \
    unzip hls-proxy-$version.linux-x64.zip

RUN rm hls-proxy-$version.linux-x64.zip

# Give execution rights
RUN chmod a+x hls-proxy

# Set log file
RUN touch /var/log/hls-proxy.log

# Health check
COPY health.sh .
RUN chmod a+x health.sh
HEALTHCHECK --interval=60s --timeout=5s --retries=3 --start-period=90s \  
    CMD sh health.sh

# Run the command on container startup
ENTRYPOINT ["/work/entrypoint.sh"]