#!/bin/bash

sudo apt-get update

sudo apt install python3-virtualenv -y
virtualenv --python="/usr/bin/python3.10" sandbox  
source sandbox/bin/activate

pip3 install -r requirements.txt --target my-lambda-layer/aws-layer/python/lib/python3.10/site-packages/

zip -r lambda-layer.zip python