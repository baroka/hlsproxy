# build:
#  docker build -t baroka/hlsproxy .

FROM ubuntu:latest

EXPOSE 8085

WORKDIR /work

# Copy entrypoint script
COPY entrypoint.sh .
RUN chmod a+x entrypoint.sh

# Install packages
RUN apt-get update && apt-get -y install unzip curl

# Install HLS Proxy
RUN curl -O https://www.hls-proxy.com/downloads/7.6.2/hls-proxy-7.6.2.linux-x64.zip && \
    unzip hls-proxy-7.6.2.linux-x64.zip

RUN rm hls-proxy-7.6.2.linux-x64.zip

# Give execution rights
RUN chmod a+x hls-proxy

# Run the command on container startup
ENTRYPOINT ["/work/entrypoint.sh"]