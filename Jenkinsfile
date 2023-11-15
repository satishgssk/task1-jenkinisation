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
                docker push satishgssk/task1jenk
                '''
            }
        }
        stage('Deploy') {
            steps { 
                sh '''
                docker stop task1
                docker rm task1
                docker run -d -p 80:5500 --name task1 satishgssk/task1jenk
                '''
            }
        }
    }
}