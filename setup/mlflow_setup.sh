#!/bin/bash

# Wait till AMI instance is up to do the remaining
sleep 30

sudo dnf install gcc openssl-devel bzip2-devel libffi-devel  

sudo yum update -y

yum -y install wget  

echo "Pulling up Python 3.11.0"
cd /opt  wget https://www.python.org/ftp/python/3.11.0/Python-3.11.0.tgz

echo "Python3.11.0 downloaded...Inflating the tarball file"
tar xzf Python-3.11.0.tgz  

cd Python-3.11.0  sudo ./configure --enable-optimizations  sudo make altinstall  

# Required packages
sudo pip3 install mlflow psycopg2-binary boto3

nohup mlflow server --host 0.0.0.0 &