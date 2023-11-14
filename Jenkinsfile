pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
               sh '''
                docker build -t satishgssk/task1jenk .
                '''
            }
        }
        stage('Push') {
            steps {
               sh '''
                docker push
                '''
            }
        }
        stage('Deploy') {
            steps { 
                sh '''
                docker run -d -p 80:5500 --name task1 
                '''
            }
        }
    }
}