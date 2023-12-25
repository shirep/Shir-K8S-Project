pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS= credentials('dockerhub')
        }

    stages {
        stage('Checkout') {
            steps {
                script {
                	checkout scm
                }
            }
        }

        stage('Docker Build Shir Java Image') {
            steps {
                script {
                    sh 'docker build -t shir-java-image:$BUILD_NUMBER .'
                    echo 'Build Completed' 
                }
            }
        }

        stage('Docker Run') {  
            steps{
		        script {
                    sh 'docker run -itd --name shir-container-$BUILD_NUMBER shir-java-image:$BUILD_NUMBER'
                }
            }
        }

        stage('Login + Push Image to Docker Hub') {         
            steps{
		        script {
                    withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: DOCKERHUB_CREDENTIALS, usernameVariable: 'DOCKERHUB_USERNAME', passwordVariable: 'DOCKERHUB_PASSWORD']]) {
                        sh "docker login -u ${DOCKER_HUB_USERNAME} -p ${DOCKER_HUB_PASSWORD}"
		                sh 'docker tag shir-java-image:$BUILD_NUMBER shirep/shir-java-image:$BUILD_NUMBER'
                        sh 'docker push shirep/shir-java-image:$BUILD_NUMBER'               
                        echo 'Push Image Completed'
                    }
                }           
            } 
        }

    }
    

    post {
        always {  
            sh 'docker logout'           
        } 
        success {
            echo 'Success'
        }
        failure {
            echo 'Failed'
        }
    }
}
