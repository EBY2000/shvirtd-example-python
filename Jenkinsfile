pipeline {
    agent any

    environment {
        COMPOSE_PROJECT = 'shvirtd-example-python'
    }

    stages {

        stage('Prepare Platform') {
            steps {
                sh 'docker --version'
                sh 'docker compose version || true'
                sh 'docker compose down -v || true'
            }
        }

        stage('Build Platform Images') {
            steps {
                sh 'docker build -t platform-fastapi:${BUILD_ID} .'
                sh 'docker build -t platform-haproxy:${BUILD_ID} ./haproxy'
            }
        }

        stage('Runtime Platform Up') {
            steps {
                sh 'docker compose up -d --build'
                sh 'echo "Checking containers..."'
                sh 'docker compose ps'
            }
        }

        stage('Smoke Platform Test') {
            steps {
                sh 'echo "Testing ingress path..."'
                sh 'curl -f http://127.0.0.1:8090/health'
            }
        }

    }

    post {
        always {
            sh 'docker compose down -v || true'
        }
    }
}
