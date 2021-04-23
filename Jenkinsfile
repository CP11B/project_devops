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
                    ssh jenkins@35.176.101.104 -oStrictHostKeyChecking=no << EOF
                    sudo apt-get update
                    rm -rf ./project_devops
                    git clone --single-branch --branch dev https://github.com/CP11B/project_devops.git
                    cd ./project_devops
                    docker-compose build --parallel
                    docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD} docker.io
                    docker-compose push
                    docker-compose up -d
                    pytest --cov application
                '''

               
            }   
        }

        
    }
}