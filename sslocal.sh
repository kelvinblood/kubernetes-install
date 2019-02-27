#!/bin/bash

docker run -d --name=sslocal --entrypoint=/usr/local/bin/sslocal -v $(pwd)/local.json:/tmp/ssmlt.json:rw oddrationale/docker-shadowsocks -c /tmp/ssmlt.json

git config --global http.proxy 'http://127.0.0.1:1080' 
git config --global https.proxy 'https://127.0.0.1:1080'

git config --global http.proxy 'socks5://127.0.0.1:1080' 
git config --global https.proxy 'socks5://127.0.0.1:1080'

#git config --global --unset http.https://github.com.proxy)

git config --global core.gitproxy "git-proxy"
git config --global socks.proxy "localhost:1080"

#git config --global --unset core.gitproxy

git config --global user.email "admin@kelu.org"
git config --global user.name "血衫非弧"

git config --global push.default simple

git config --global credential.helper store
