#!/bin/sh
echo '------ ALLOW HLS PROXY ON EVERY INTERFACE -------'
/opt/hlsp/hls-proxy -address 0.0.0.0 -port 8085 -save -quit

echo '------ SERVE HLS PROXY 7.5.8 -------'
/opt/hlsp/hls-proxy
