pipeline {
  agent any
    stages {
        stage('Build') {
	    steps {
	        sh python3.9 -m venv 
	        sh source /bin/activate    
	        sh pip install -r requirements.txt 
		sh microblog.py
	    }
        }
        stage ('Test') {
            steps {
                sh '''#!/bin/bash
                source /home/ubuntu/microblog_EC2_deployment/venv/bin/activate
                py.test ./tests/unit/ --verbose --junit-xml test-reports/results.xml
                '''
            }
            post {
                always {
                    junit 'test-reports/results.xml'
                }
            }
        }
      stage ('OWASP FS SCAN') {
            steps {
                dependencyCheck additionalArguments: '--scan ./ --disableYarnAudit --disableNodeAudit', odcInstallation: 'DP-Check'
                dependencyCheckPublisher pattern: '**/dependency-check-report.xml'
            }
        }
      stage ('Clean') {
            steps {
                sh '''#!/bin/bash
                if [[ $(ps aux | grep -i "gunicorn" | tr -s " " | head -n 1 | cut -d " " -f 2) != 0 ]]
                then
                ps aux | grep -i "gunicorn" | tr -s " " | head -n 1 | cut -d " " -f 2 > pid.txt
                kill $(cat pid.txt)
                exit 0
                fi
                '''
            }
        }
      stage ('Deploy') {
          steps {
              sh '''#!/bin/bash
              source venv/bin/activate
              '''
          }
      }

    }
}
