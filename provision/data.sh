#!/bin/bash
set -ex

# install Docker Compose
ver=$(curl -sSL https://github.com/docker/compose | grep '/docker/compose/tree/' | egrep '/[0-9]+\.[0-9]+\.[0-9]+"' | egrep -o '[0-9]+\.[0-9]+\.[0-9]+' | sort -r | head -n 1)
curl -sSL https://github.com/docker/compose/releases/download/$ver/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
