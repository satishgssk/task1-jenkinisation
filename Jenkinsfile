pipeline {
    agent any
    environment {
        YOUR_NAME=credentials("YOUR_NAME")
    }
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
                export YOUR_NAME=${YOUR_NAME}
                docker network rm task1-net && echo "removed task1-net" || echo "already removed task1-net"
                docker network create task1-net
                docker stop task1-nginx && echo "stopped task1-nginx" || echo "task1-nginx is not running"
                docker rm task1-nginx && echo "removed task1-nginx" || echo "task1-nginx is not running"
                docker stop flask-app && echo "stopped flask-app" || echo "flask-app is not running"
                docker rm flask-app && echo "removed flask-app" || echo "flask-app is not running"
                docker run -d --name flask-app --network task1-net satishgssk/task1-app
                docker run -d --name task1-nginx --network task1-net -e YOUR_NAME=${YOUR_NAME} -p 80:80 satishgssk/task1-nginx
                '''
            }
        }
    }
}