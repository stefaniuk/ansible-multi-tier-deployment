#!/bin/bash
set -ex

apt-add-repository ppa:ansible/ansible --yes
apt-get --yes update
apt-get --yes --ignore-missing --no-install-recommends install \
    ansible
