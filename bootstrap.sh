#!/usr/bin/env bash

apt-get update

# install python
apt-get install libpq-dev python-dev python-pip -q -y

# install extra packages
apt-get install postgresql python-psycopg2

# install project dependencies
pip install virtualenv
pip install -r /vagrant/codigo/requirements.txt

virtualenv --python=python3 todo-api-venv

if grep "todo-api-venv/bin/activate" "/home/vagrant/.bashrc"; then
  echo 'Venv Activate already in BASHRC'
else
  echo 'source /home/vagrant/todo-api-venv/bin/activate; cd /vagrant/' >> /home/vagrant/.bashrc
fi
