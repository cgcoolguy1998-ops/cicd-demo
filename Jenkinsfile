pipeline {
    agent any

    environment {
        IMAGE_NAME = 'shreyascoolguy/cicd-demo'
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Test') {
            steps {
                sh 'bash test.sh'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t ${IMAGE_NAME}:${BUILD_NUMBER} .'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: 'dockerhub-creds',
                        usernameVariable: 'DOCKER_USER',
                        passwordVariable: 'DOCKER_TOKEN'
                    )
                ]) {
                    sh '''
                        set +x
                        export DOCKER_CONFIG=$(mktemp -d)
                        trap 'rm -rf "$DOCKER_CONFIG"' EXIT

                        echo "$DOCKER_TOKEN" | docker login \
                            -u "$DOCKER_USER" \
                            --password-stdin

                        docker push ${IMAGE_NAME}:${BUILD_NUMBER}

                        docker tag ${IMAGE_NAME}:${BUILD_NUMBER} \
                            ${IMAGE_NAME}:latest

                        docker push ${IMAGE_NAME}:latest
                    '''
                }
            }
        }
    }
}