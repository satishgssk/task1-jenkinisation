pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
               sh '''
                docker build -t satishgssk/task1-nginx nginx
                docker build -t satishgssk/task1-app .
                '''
            }
        }
        stage('Push') {
            steps {
               sh '''
                docker push satishgssk/task1-nginx
                docker push satishgssk/task1-app
                '''
            }
        }
        stage('Deploy') {
            steps { 
                sh '''
                ssh jenkins@satish-deploy <<EOF
                docker network rm task1-net && echo "removed task1-net" || echo "already removed task1-net"
                docker network create task1-net
                docker stop task1-nginx && echo "stopped task1-nginx" || echo "task1-nginx is not running"
                docker rm task1-nginx && echo "removed task1-nginx" || echo "task1-nginx is not running"
                docker stop flask-app && echo "stopped flask-app" || echo "flask-app is not running"
                docker rm flask-app && echo "removed flask-app" || echo "flask-app is not running"
                docker run -d --name flask-app --network task1-net satishgssk/task1-app
                docker run -d --name task1-nginx --network task1-net -p 80:5500 satishgssk/task1-nginx
                '''
            }
        }
    }
}