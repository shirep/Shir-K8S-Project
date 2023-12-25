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

        stage('Login to Docker Hub') {         
            steps{
		        script {
		            sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'                 
	                echo 'Login Completed'                
                }           
            } 
        }  

        stage('Push Image to Docker Hub') {         
            steps{
		        script {
		            sh 'docker tag shir-java-image:$BUILD_NUMBER shirep/shir-java-image:$BUILD_NUMBER'
                    sh 'docker push shirep/shir-java-image:$BUILD_NUMBER'               
                    echo 'Push Image Completed'        
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
