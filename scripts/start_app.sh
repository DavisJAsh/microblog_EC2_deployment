#!/bin/bash

#Script will run on the application server that will set up the server so that has all of the dependencies that the application needs, clone the GH repository, 
#install the application dependencies from the requirements.txt file as well as [gunicorn, pymysql, cryptography], set ENVIRONMENTAL Variables, 
#flask commands, and finally the gunicorn command that will serve the application IN THE BACKGROUND

#Clone the git repo and cd into the directory
sudo apt-get install git

#Create the directory and clone the repository if it doesn't exist, navigate to that directory
if [[ ! -d /home/ubuntu/microblog_EC2_deployment ]] then; 
    git clone https://github.com/DavisJAsh/microblog_EC2_deployment
    cd /home/ubuntu/microblog_EC2_deployment
else 
    cd /home/ubuntu/microblog_EC2_deployment
    git pull origin main  #pulling  down the latest version of the repo if dir exists
fi

#Update and install the necessary packages
sudo apt-get update -y
sudo apt install fontconfig openjdk-17-jre software-properties-common -y
sudo add-apt-repository ppa:deadsnakes/ppa -y
sudo apt install python3.9 python3.9-venv python3.9-dev -y

#Set git global attributes
git config --global user.name "DavisJAsh"
git config --global user.email "davisjash@gmail.com"

#Install the requirements
sudo apt install python3-pip -y

#Create the virtual environment
python3.9 -m venv venv
source venv/bin/activate

#Upgrading virtual environments pip
pip install pip --upgrade  
pip install -r requirements.txt 
pip install gunicorn pymysql cryptography 

#Set Environment variables stays through out the environment because of "export" command
export FLASK_APP="microblog.py"
FLASK_ENV="development"
source /etc/environment
echo $FLASK_APP

sudo apt install python3-flask -y

gunicorn -b :5000 -w 4 microblog:app --daemon

echo "App is running successfully!"
