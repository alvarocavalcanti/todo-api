#!/usr/bin/env bash

apt-get update

# install python
apt-get install libpq-dev python-dev python-pip -q -y

# install extra packages
apt-get install postgresql python-psycopg2

# install project dependencies
pip install -r /vagrant/codigo/requirements.txt
