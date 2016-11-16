#!/bin/bash
set -ex

apt-get --yes update
apt-get --yes --ignore-missing --no-install-recommends install \
    nginx
