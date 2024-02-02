pipeline {
    agent any
    
    stages {
        stage('Packages upgrade') {
            steps {
                sh """
                sudo chmod +x ./conf/gunicorn.sh
                sudo chmod +x ./conf/nginx.sh
                sudo chmod +x ./conf/virtual_env.sh
                """
                sh 'sudo apt update && sudo apt install python3-pip nginx curl -y'
            }
        }

        stage('Virtual environment') {
            steps {
                sh './conf/virtual_env.sh'
            }
        }

        stage('Install requirements') {
            steps {
                sh 'pip3 install -r ./requirements.txt'
            }
        }

        stage('Django migrate') {
            steps {
                sh 'python3.8 ./manage.py makemigrations'
                sh 'python3.8 ./manage.py migrate'
            }
        }

        stage('Gunicorn setup') {
            steps {
                sh './conf/gunicorn.sh'
            }
        }

        stage('Nginx setup') {
            steps {
                sh './conf/nginx.sh'
            }
        }

        stage('Nginx test') {
            steps {
                sh 'echo $(sudo nginx -t)'
                sh 'sudo systemctl enable --now nginx'
                sh 'sudo systemctl status nginx'
            }
        }
    }
}
