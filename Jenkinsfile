  pipeline {
    agent any
    environment {
        MYSQL_ROOT_PASSWORD = credentials("MYSQL_ROOT_PASSWORD")
        DOCKER_PASSWORD = credentials("DOCKER_PASSWORD")
        DOCKER_USERNAME = credentials("DOCKER_USERNAME")
    }
    stages {

        stage("SSH to machine"){
            ssh 18.132.14.20 -oStrictHostKeyChecking=no  << EOF
            git clone https://github.com/CP11B/project_devops.git
            cd ./project_devops
            docker compose up
            EOF
        }

        stage("Build"){
            steps{
                sh "docker-compose build --parallel"
            }
        }

        stage("Push"){

            steps{
                script{
                    sh "docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD} docker.io"
                    sh "docker-compose push"
                }
            }
        }
        
        stage("Deploy"){
            steps{
                sh "docker-compose up -d"
            }
        }      
    }
}