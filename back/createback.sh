#!/bin/bash

sudo apt update

echo "=====================================> PYTHON VERSION"

python3 --version
pip3 --version

echo "=====================================> INSTALL"

sudo apt-get install -y python3
sudo apt-get install -y python3-pip
sudo apt-get install -y python3-venv
sudo apt-get install -y libjpeg-dev zlib1g-dev
sudo apt install rustc

echo "=====================================> PIP INSTALL"

python3 -m pip install Pillow
python3 -m pip install -U setuptools

echo "=====================================> CREATE VENV"

python3 -m venv venv
source venv/bin/activate

echo "=====================================> WAGTAIL"

python3 -m pip install wagtail==2.15
wagtail start backend

echo "=====================================> INSTALL REQUIREMENTS"

cp material/conf/requirements.txt backend/requirements.txt
python3 -m pip install -r backend/requirements.txt

cp material/base.py backend/backend/settings/base.py
python3 backend/manage.py migrate

echo "=====================================> ADD USER"

echo "from django.contrib.auth import get_user_model; \
    User = get_user_model(); User.objects.create_superuser('admin', 'admin@myproject.com', 'admin')" | python3 backend/manage.py shell

echo "=====================================> RUN SERVER"

python3 backend/manage.py runserver 7000