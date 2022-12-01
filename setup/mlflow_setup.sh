#!/bin/bash

# Wait till AMI instance is up to do the remaining
sleep 30

sudo apt update -y

# Install all the required tools for mlflow UI
sudo apt install python 3.8

# Required packages
sudo pip3 install mlflow psycopg2-binary boto3

nohup mlflow server --host 0.0.0.0 &