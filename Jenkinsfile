  pipeline {
    agent any
    environment {
        MYSQL_ROOT_PASSWORD = credentials("MYSQL_ROOT_PASSWORD")
        DOCKER_PASSWORD = credentials("DOCKER_PASSWORD")
        DOCKER_USERNAME = credentials("DOCKER_USERNAME")
    }
    stages {

        stage("SSH to machine"){
            steps{                 
                sh '''
                    ssh jenkins@18.130.245.47 -oStrictHostKeyChecking=no << EOF
                    sudo apt-get update
                    rm -rf ./project_devops
                    git clone https://github.com/CP11B/project_devops.git
                    cd ./project_devops
                '''

               
            }   
        }

        stage("Build"){
            steps{
                sh '''
                    ssh jenkins@18.130.245.47 -oStrictHostKeyChecking=no << EOF
                    cd ./project_devops
                    docker-compose build --parallel
                '''
            }
        }

        stage("Push"){
            steps{
                sh '''
                    ssh jenkins@18.130.245.47 -oStrictHostKeyChecking=no << EOF
                    cd ./project_devops
                    docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD} docker.io
                    docker-compose push
                '''
                }
            }
        
        
        stage("Deploy"){
            steps{
                sh '''
                    ssh jenkins@18.130.245.47 -oStrictHostKeyChecking=no << EOF
                    cd ./project_devops
                    docker-compose up -d
                '''
            }
        }      
    }
}