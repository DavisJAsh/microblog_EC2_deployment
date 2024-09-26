#!/bin/bash

#SSH into the "Application_Server" instance
ssh -i /home/ubuntu/.ssh/microblog.pem ubuntu@10.0.133.37 << EOF

echo "Download start_app.sh from GitHub"
curl -O https://raw.githubusercontent.com/DavisJAsh/microblog_EC2_deployment/refs/heads/main/scripts/start_app.sh

echo "Running the "start_app.sh" in th Application Server"
source start_app.sh  
EOF

#source gives the script evironmental variables (operates in the current shell - bash would create a new one and cannot effect its parent) and permissions

#If need to install this script to multiple application servers in a fast manner. Save the scripts to github repo in a scripts folder. 
#Learn to work and scale up or down - scripting moment.
#curl - raw file link from github script repo - save files there; write a script that will curl for you
