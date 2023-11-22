pipeline {
    agent any
    environment {
        YOUR_NAME=credentials("YOUR_NAME")
    }
    stages {
        stage('Build') {
            steps {
               sh '''
                docker build -t satishgssk/task1-app .
                '''
            }
        }
        stage('Push') {
            steps {
               sh '''
                docker push satishgssk/task1-app
                '''
            }
        }
        stage('Deploy') {
            steps { 
                sh '''
                sed -e 's, {{userName}}, '${YOUR_NAME}', g;' user-secret.yaml | kubectl apply -f -
                kubectl apply -f task1-app-manifest.yaml
                kubectl apply -f task1-nginx-manifest.yaml
                sleep 60
                kubectl get services
                '''
            }
        }
    }
}