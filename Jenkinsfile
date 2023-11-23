pipeline {
    agent any
    environment {
        YOUR_NAME=credentials("YOUR_NAME")
    }
    stages {
        stage('Build') {
            steps {
               sh '''
                docker build -t satishgssk/task1-app:v${BUILD_NUMBER} .
                '''
            }
        }
        stage('Push') {
            steps {
               sh '''
                docker push satishgssk/task1-app:v${BUILD_NUMBER}
                '''
            }
        }
        stage('Staging Deploy') {
            steps {
               sh '''
                sed -e 's,{{userName}},'${YOUR_NAME}', g;' -e 's,{{version}},'${BUILD_NUMBER}',g;' task1-app-manifest.yaml | kubectl apply -f - --namespace staging
                kubectl apply -f task1-nginx-manifest.yaml --namespace staging
                '''
            }
        }
        stage('Quality Check') {
            steps {
               sh '''
                sleep 50
                export STAGING_IP=\$(kubectl get svc -o json --namespace staging | jq '.items[] | select(.metadata.name == "task1-nginx") | .status.loadBalancer.ingress[0].ip' | tr -d '"')
                pip3 install requests
                python3 test-app.py
                '''
            }
        }
        stage('Prod Deploy') {
            steps { 
                sh '''
                sed -e 's,{{userName}},'${YOUR_NAME}', g;' -e 's,{{version}},'${BUILD_NUMBER}',g;' task1-app-manifest.yaml | kubectl apply -f - --namespace prod
                kubectl apply -f task1-nginx-manifest.yaml --namespace prod
                sleep 50
                kubectl get services --namespace prod
                '''
            }
        }
    }
}