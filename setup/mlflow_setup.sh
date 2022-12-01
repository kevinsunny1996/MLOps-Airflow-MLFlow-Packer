#!/bin/bash

# Wait till AMI instance is up to do the remaining
sleep 30

sudo dnf install gcc openssl-devel bzip2-devel libffi-devel  

sudo yum update -y

echo "Python Version:"
python3 -v

echo "Pip version:"
pip -v
pip3 -v

# Required packages
# sudo pip3 install mlflow psycopg2-binary boto3

# sudo nohup mlflow server --host 0.0.0.0 &