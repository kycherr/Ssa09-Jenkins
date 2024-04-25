pipeline {
        agent {
        label 'jen-job.kwds.net.ua'
    }
    
    environment {
        CONTAINER_NAME = 'nginx_ssa_demo'
        IMAGE_NAME = 'nginx:latest'
    }
    
    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    def buildResult = sh(script: 'docker build -t nginx_hello_world .', returnStatus: true)
                    if (buildResult != 0) {
                        error "Failed to build Docker image"
                    }
                }
            }
        }
        
        stage('Run Docker Container') {
            steps {
                script {
                    def runResult = sh(script: "docker run -d --name ${CONTAINER_NAME} -p 8080:80 nginx_hello_world", returnStatus: true)
                    if (runResult != 0) {
                        error "Failed to run Docker container"
                    }
                }
            }
        }
        
        stage('Check Content') {
            steps {
                script {
                    def response = sh(script: 'curl -s http://localhost:8080/', returnStdout: true, returnStatus: true)
                    
                    if (response != 0) {
                        error "Failed to check content"
                    } else if (!response.trim().contains('Hello, World!')) {
                        error "Content 'Hello, World!' is not present on the running container"
                    }
                }
            }
        }
        
        stage('Check Logs for Errors') {
            steps {
                script {
                    def logErrors = sh(script: 'docker exec ${CONTAINER_NAME} cat /var/log/nginx/error.log | grep -E " 4[0-9]{2}| 5[0-9]{2}"', returnStatus: true, returnStdout: true)
                    
                    if (logErrors != 0) {
                        echo "No errors found in Nginx logs."
                    } else {
                        error "Errors found in Nginx logs:\n${logErrors}"
                    }
                }
            }
        }
        
        stage('Cleanup') {
            steps {
                script {
                    def stopResult = sh(script: "docker stop ${CONTAINER_NAME}", returnStatus: true)
                    if (stopResult != 0) {
                        error "Failed to stop Docker container"
                    }
                    def removeResult = sh(script: "docker rm ${CONTAINER_NAME}", returnStatus: true)
                    if (removeResult != 0) {
                        error "Failed to remove Docker container"
                    }
                    def removeImageResult = sh(script: "docker rmi ${IMAGE_NAME}", returnStatus: true)
                    if (removeImageResult != 0) {
                        error "Failed to remove Docker image"
                    }
                }
            }
        }
    }
}
