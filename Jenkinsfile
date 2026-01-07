pipeline {
    agent any

    environment {
        COMPOSE_PROJECT = 'shvirtd-example-python'
        MYSQL_ROOT_PASSWORD = credentials('MYSQL_ROOT_PASSWORD')
        MYSQL_PASSWORD = credentials('MYSQL_PASSWORD')
        MYSQL_HOST = 'mysql-db'
        MYSQL_DATABASE = 'virtd'
        MYSQL_USER = 'app'
    }

    stages {
        stage("Set environment variables") {
            steps {
//                 writeFile file: '.env', text: '''
//                     MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD\n
//                     MYSQL_PASSWORD=''\n
//                     MYSQL_HOST=''\n
//
//                     '''
                script {
                   def date = new Date()
                   def data = "MYSQL_HOST='mysql-db'\nMYSQL_PASSWORD='$MYSQL_PASSWORD'\nMYSQL_DATABASE = 'virtd'\nMYSQL_USER = 'app'"
                   writeFile(file: '.env', text: data)
                   sh "ls -l"
               }
            }
        }

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
                sh 'curl -f http://localhost:8090/health'
            }
        }

    }

//     post {
//         always {
//             sh 'docker compose down -v || true'
//         }
//     }
}
