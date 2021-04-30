# build:
#  docker build -t baroka/hlsproxy .

FROM ubuntu:latest

EXPOSE 8085

# Copy entrypoint script
COPY entrypoint.sh .
RUN chmod a+x entrypoint.sh

# Install packages
RUN apt-get update && apt-get -y install wget unzip

RUN mkdir -p /opt/hlsp
VOLUME [ "/opt/hlsp" ]

# Install HLS Proxy
RUN wget https://www.hls-proxy.com/downloads/7.6.0/hls-proxy-7.6.0.linux-x64.zip -O /var/tmp/hlsproxy.zip

# Unzip HLS Proxy
RUN unzip -o /var/tmp/hlsproxy.zip -d /opt/hlsp/

# Clean temp
RUN rm -rf /var/tmp/hlsproxy.zip

# Chmod HLS Proxy
#RUN chmod +x /opt/hlsp/hls-proxy

COPY entrypoint.sh .
ENTRYPOINT [ "./entrypoint.sh" ]
