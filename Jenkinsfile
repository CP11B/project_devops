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
                script{
                    sh "18.130.245.47 -oStrictHostKeyChecking=no << EOF"
                    sh "rm -rf ./project_devops"
                    sh "git clone https://github.com/CP11B/project_devops.git"
                    sh "cd ./project_devops"
                } 
            }   
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