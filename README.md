```shell
Docker image for HLS Proxy. 

PREREQUISITES
 - Docker installed

INSTALLATION
 - Docker compose example: 

# Hlsproxy
  hlsproxy:
    container_name: hlsproxy
    image: baroka/hlsproxy:latest
    restart: unless-stopped    
    network_mode: "service:openvpn" # Encrypt thru vpn
    security_opt:
      - no-new-privileges:true      
    #ports:       
    #  - 8085:8085 # open port in vpn container
    volumes:
      - $DOCKERDIR/hlsproxy/config/local.json:/work/local.json # Configuration file
      - $DOCKERDIR/hlsproxy/config/groups.json:/work/groups.json # Groups file
      - $DOCKERDIR/hlsproxy/config/cron:/work/cron # crontab file and scripts
      - $DOCKERDIR/hlsproxy/media:/media # iptv lists folder
    environment:
      - TZ=$TZ
      - PGID=$PGID
      - PUID=$PUID

 - $DOCKERDIR points to your local path for hlsproxy config files
```
