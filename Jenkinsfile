pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
               sh '''
                docker build -t satishgssk/task1-nginx .
                '''
            }
        }
        stage('Push') {
            steps {
               sh '''
                docker push satishgssk/task1-nginx
                '''
            }
        }
        stage('Deploy') {
            steps { 
                sh '''
                docker stop flask-app-sat && echo "stopped flask-app-sat" || echo "flask-app-sat is not running"
                docker rm flask-app-sat && echo "removed flask-app-sat" || echo "flask-app-sat is not running"
                docker run -d --name flask-app-sat --network nginx-net satishgssk/task1-nginx
                '''
            }
        }
    }
}