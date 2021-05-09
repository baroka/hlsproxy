#!/bin/sh
echo '------ ALLOW HLS PROXY ON EVERY INTERFACE -------'
/work/hls-proxy -address 0.0.0.0 -port 8085 -save -quit

echo '------ HLS PROXY -------'
/work/hls-proxy
