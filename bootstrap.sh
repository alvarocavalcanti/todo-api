#!/usr/bin/env bash

apt-get update

# install python
apt-get install python-dev python-pip -q -y

# install project dependencies
pip install -r codigo/requirements.txt
