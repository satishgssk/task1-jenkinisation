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
                 kubectl apply -f .
                '''
            }
        }
    }
}