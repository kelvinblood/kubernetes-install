#!/usr/bin/env bash

sudo chmod +x ./check.sh \
  && sudo modprobe ip_vs \
  && sudo modprobe ip_vs_wrr \
  && sudo docker run --restart=always --net=host \
  --name keepalived --privileged --cap-add=NET_ADMIN \
  -v /app/kelu/keepalived/keepalived.conf:/usr/local/keepalived/etc/keepalived.conf \
  -d kelvinblood/keepalived:v1.3.5
