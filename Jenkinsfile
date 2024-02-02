pipeline {
    agent any
    
    stages {
        stage('Packages upgrade') {
            steps {
                sh 'sudo apt update && sudo apt install python3-pip nginx curl'
            }
        }

        stage('Virtual environment') {
            steps {
                sh './virtual_env.sh'
            }
        }

        stage('Install requirements') {
            steps {
                sh 'pip3 install -r ./requirements.txt'
            }
        }

        stage('Django migrate') {
            steps {
                sh './manage.py makemigrations'
                sh './manage.py migrate'
            }
        }

        stage('Gunicorn setup') {
            steps {
                sh './gunicorn.sh'
            }
        }

        stage('Nginx setup') {
            steps {
                sh './nginx.sh'
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
