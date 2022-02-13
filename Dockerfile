# build:
#  docker build -t baroka/hlsproxy .

FROM ubuntu:latest

EXPOSE 8085

WORKDIR /work

# Copy entrypoint script
COPY entrypoint.sh .
RUN chmod a+x entrypoint.sh

# Install packages
RUN apt-get update && apt-get -y install unzip curl cron iproute2

# Timezone
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata
RUN echo "Europe/Madrid" > /etc/timezone
RUN rm -f /etc/localtime
RUN dpkg-reconfigure -f noninteractive tzdata

# Add crontab file to the cron directory
ADD crontab /etc/cron.d/cron

# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/cron

# Install HLS Proxy
RUN curl -O https://www.hls-proxy.com/downloads/8.1.2/hls-proxy-8.1.2.linux-x64.zip && \
    unzip hls-proxy-8.1.2.linux-x64.zip

RUN rm hls-proxy-8.1.2.linux-x64.zip

# Give execution rights
RUN chmod a+x hls-proxy

# Run the command on container startup
ENTRYPOINT ["/work/entrypoint.sh"]