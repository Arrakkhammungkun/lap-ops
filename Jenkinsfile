pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "66023085/my-next-app"
        DOCKER_SERVER = "43.208.241.236"
        CONTAINER_NAME = "next-container"
        PORT = "4445" 
    }

    stages {
        stage('Checkout Code') {
            steps {
                git 'git@github.com:your-repo/your-next-app.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t $DOCKER_IMAGE ."
            }
        }

        stage('Push Docker Image') {
            steps {
                withDockerRegistry([credentialsId: 'docker-hub-credentials', url: '']) {
                    sh "docker push $DOCKER_IMAGE"
                }
            }
        }

        stage('Deploy to Docker Server') {
            steps {
                sshagent(['docker-server-ssh']) {
                    sh """
                    ssh -o StrictHostKeyChecking=no ubuntu@$DOCKER_SERVER '
                    docker stop $CONTAINER_NAME || true &&
                    docker rm $CONTAINER_NAME || true &&
                    docker pull $DOCKER_IMAGE &&
                    docker run -d -p $PORT:3000 --name $CONTAINER_NAME $DOCKER_IMAGE
                    '
                    """
                }
            }
        }
    }
}
