#!/bin/sh
echo '------ ALLOW HLS PROXY ON EVERY INTERFACE -------'
/opt/hlsp/hls-proxy -address 0.0.0.0 -port 8085 -save -quit

echo '------ HLS PROXY 7.6.0 -------'
/opt/hlsp/hls-proxy
